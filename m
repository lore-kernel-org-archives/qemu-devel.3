Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EFAE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTk0M-0001f0-7k; Fri, 03 Jan 2025 10:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTk0H-0001eT-Q4
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTk0F-0002Ob-U1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735919662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8MK3UcVLcOkZD/EmeCE8e77wopXF8zXhW3+DVQ2Dxmk=;
 b=Jh28nOv/Cdpjty0WeULnw4zt3nA1IFy8VtbEz+zVzbN+HlW9f2FjJAkawFYExIBbvWscYA
 Zu1g6/a3tp4ADIbAVZ6sNCrz6PRYg/EttLALfjwOlYDg93fyDJmWg4WtM0oeQJO+7J8kof
 sAauLTZsBKhHGWTRvtNYYVBBTIIwDu8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-D0cptFSUNbWyxj0r9RrKpw-1; Fri,
 03 Jan 2025 10:54:18 -0500
X-MC-Unique: D0cptFSUNbWyxj0r9RrKpw-1
X-Mimecast-MFC-AGG-ID: D0cptFSUNbWyxj0r9RrKpw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECFA619560B4; Fri,  3 Jan 2025 15:54:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0A9319560AA; Fri,  3 Jan 2025 15:54:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH] Remove the deprecated "-runas" command line option
Date: Fri,  3 Jan 2025 16:54:11 +0100
Message-ID: <20250103155411.721759-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It has been marked as deprecated two releases ago, so it should
be fine now to remove this command line option.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  6 ++++++
 system/vl.c                     |  9 ---------
 qemu-options.hx                 | 15 +--------------
 4 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d6809f94ea..63b46fd520 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -74,12 +74,6 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
-``-runas`` (since 9.1)
-''''''''''''''''''''''
-
-Use ``-run-with user=..`` instead.
-
-
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index cb1388049a..c6616ce05e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -555,6 +555,12 @@ to produce an odd effect (rotating input but not display output). But
 this was never intended or documented behaviour, so we have dropped
 the options along with the machine models they were intended for.
 
+``-runas`` (removed in 10.0)
+''''''''''''''''''''''''''''
+
+Use ``-run-with user=..`` instead.
+
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/system/vl.c b/system/vl.c
index 0843b7ab49..3c5bd36d7d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3611,15 +3611,6 @@ void qemu_init(int argc, char **argv)
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
 #if defined(CONFIG_POSIX)
-            case QEMU_OPTION_runas:
-                warn_report("-runas is deprecated, use '-run-with user=...' instead");
-                if (!os_set_runas(optarg)) {
-                    error_report("User \"%s\" doesn't exist"
-                                 " (and is not <uid>:<gid>)",
-                                 optarg);
-                    exit(1);
-                }
-                break;
             case QEMU_OPTION_daemonize:
                 os_set_daemonize(true);
                 break;
diff --git a/qemu-options.hx b/qemu-options.hx
index cc694d3b89..7090d59f6f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4976,19 +4976,6 @@ SRST
     ``-nodefaults`` option will disable all those default devices.
 ERST
 
-#ifndef _WIN32
-DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
-    "-runas user     change to user id user just before starting the VM\n" \
-    "                user can be numeric uid:gid instead\n",
-    QEMU_ARCH_ALL)
-#endif
-SRST
-``-runas user``
-    Immediately before starting guest execution, drop root privileges,
-    switching to the specified user. This option is deprecated, use
-    ``-run-with user=...`` instead.
-ERST
-
 DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
     "-prom-env variable=value\n"
     "                set OpenBIOS nvram variables\n",
@@ -5176,7 +5163,7 @@ SRST
 
     ``chroot=dir`` can be used for doing a chroot to the specified directory
     immediately before starting the guest execution. This is especially useful
-    in combination with -runas.
+    in combination with ``user=...``.
 
     ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
     before starting guest execution. QEMU will use the ``setuid`` and ``setgid``
-- 
2.47.1


