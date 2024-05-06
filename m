Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8042AC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wQ7-0001it-M4; Mon, 06 May 2024 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3wPL-0001ZV-2P
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3wPH-00007C-Rg
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714994466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vAyX+18i7W5hxpcwWY3wQVWZeUt+CcwHVxmQ6+nOCI4=;
 b=ZamIMqHd/WMYjfJXksKd8YLSMsp1QzqPjse6oaO9/ZTyAX2Z5t8V4vGgwoNcjhqcEzSdvm
 N/xvz1TXbZzNxQ+69nRuSLZEHISLtCwkhIhUwe/PWVeVplu7HyeZ3jnuuhyvYcVM1mQUa0
 uPoc2cCW8WHlNKxu0gGcTJ5yhr3+4Mo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-nC-01PcsPWCClcaTbe54pA-1; Mon,
 06 May 2024 07:21:01 -0400
X-MC-Unique: nC-01PcsPWCClcaTbe54pA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9D8729AA3AF;
 Mon,  6 May 2024 11:21:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 420501C060D1;
 Mon,  6 May 2024 11:20:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2] qemu-options: Deprecate "-runas" and introduce "-run-with
 user=..." instead
Date: Mon,  6 May 2024 13:20:58 +0200
Message-ID: <20240506112058.51446-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The old "-runas" option has the disadvantage that it is not visible
in the QAPI schema, so it is not available via the normal introspection
mechanisms. We've recently introduced the "-run-with" option for exactly
this purpose, which is meant to handle the options that affect the
runtime behavior. Thus let's introduce a "user=..." parameter here now
and deprecate the old "-runas" option.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Add missing part in qemu-options.hx as suggested by Philippe

 docs/about/deprecated.rst |  6 ++++++
 system/vl.c               | 15 +++++++++++++++
 qemu-options.hx           | 15 +++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 3310df3274..fe69e2d44c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -61,6 +61,12 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
+``-runas`` (since 9.1)
+----------------------
+
+Use ``-run-with user=..`` instead.
+
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/system/vl.c b/system/vl.c
index 7756eac81e..b031427440 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -773,6 +773,10 @@ static QemuOptsList qemu_run_with_opts = {
             .name = "chroot",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "user",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -3586,6 +3590,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #if defined(CONFIG_POSIX)
             case QEMU_OPTION_runas:
+                warn_report("-runas is deprecated, use '-run-with user=...' instead");
                 if (!os_set_runas(optarg)) {
                     error_report("User \"%s\" doesn't exist"
                                  " (and is not <uid>:<gid>)",
@@ -3612,6 +3617,16 @@ void qemu_init(int argc, char **argv)
                 if (str) {
                     os_set_chroot(str);
                 }
+                str = qemu_opt_get(opts, "user");
+                if (str) {
+                    if (!os_set_runas(str)) {
+                        error_report("User \"%s\" doesn't exist"
+                                     " (and is not <uid>:<gid>)",
+                                     optarg);
+                        exit(1);
+                    }
+                }
+
                 break;
             }
 #endif /* CONFIG_POSIX */
diff --git a/qemu-options.hx b/qemu-options.hx
index cf61f6b863..3031479a15 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4824,7 +4824,8 @@ DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
 SRST
 ``-runas user``
     Immediately before starting guest execution, drop root privileges,
-    switching to the specified user.
+    switching to the specified user. This option is deprecated, use
+    ``-run-with user=...`` instead.
 ERST
 
 DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
@@ -4990,13 +4991,15 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
 
 #ifdef CONFIG_POSIX
 DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
-    "-run-with [async-teardown=on|off][,chroot=dir]\n"
+    "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
     "                Set miscellaneous QEMU process lifecycle options:\n"
     "                async-teardown=on enables asynchronous teardown (Linux only)\n"
-    "                chroot=dir chroot to dir just before starting the VM\n",
+    "                chroot=dir chroot to dir just before starting the VM\n"
+    "                user=username switch to the specified user before starting the VM\n"
+    "                user=uid:gid dito, but use specified user-ID and group-ID instead\n",
     QEMU_ARCH_ALL)
 SRST
-``-run-with [async-teardown=on|off][,chroot=dir]``
+``-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]``
     Set QEMU process lifecycle options.
 
     ``async-teardown=on`` enables asynchronous teardown. A new process called
@@ -5013,6 +5016,10 @@ SRST
     ``chroot=dir`` can be used for doing a chroot to the specified directory
     immediately before starting the guest execution. This is especially useful
     in combination with -runas.
+
+    ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
+    by switching to the specified user (via username) or user and group
+    (via uid:gid) immediately before starting guest execution.
 ERST
 #endif
 
-- 
2.45.0


