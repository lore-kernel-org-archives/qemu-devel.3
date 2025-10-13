Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A91CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ghs-0007rt-A9; Mon, 13 Oct 2025 07:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ghp-0007rI-MK
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ghk-0006Ee-Hq
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760354821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXbW3N8gX99+5lwtTmZ4123UvfpZvpKKoarN9yvkUuc=;
 b=hGuOVRjoW0DMWWjoa2L/vFPQBVXSGgOfN8yO8Yah0bV5EWCj7BSCMopfXDHS65mJ+x7LuB
 8hOGpUsWz7wVITC60X4HTaCmVTunx4vbm1bIzJTvjtVsFy++l5fOJudNzCD7lsVhM0MlrQ
 aN0WkllutH1QyLLgisehdChMiAKpgWM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-R89GVmBsMD2Iu3cV3uRBMg-1; Mon, 13 Oct 2025 07:26:59 -0400
X-MC-Unique: R89GVmBsMD2Iu3cV3uRBMg-1
X-Mimecast-MFC-AGG-ID: R89GVmBsMD2Iu3cV3uRBMg_1760354818
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6365fb32d66so4754425a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 04:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760354817; x=1760959617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXbW3N8gX99+5lwtTmZ4123UvfpZvpKKoarN9yvkUuc=;
 b=i4WPoVLbdUXcU7+sHikfRB6fq/rIOxGySJNfm4s1EgA11vUb37rmnvjifDrYrfZatP
 szz85u8aY2godt4KDB4pz3/pF/QRRq53Lji17vgh8c3I0D1abKnqlnrH4D6LiX3vWGDQ
 vATfcWWfI1bU4s3PyhDb+KKtVEEIos5sAC1nEwIId92SGlZkj1D6pEQafBcd2/+UHjBk
 kZyDiikfgwpG9erV+ubIG+TI+t4sdpQf2zR6iCDyqlBZQl2RZBT97lBiO67XFyXeBWwr
 x9sMgRfyNJFaHMtop0qhUpw82n0mOmcmZeTeqKg8vM/luZt2Dfio7uVFyfKSB4rlxPa7
 RedQ==
X-Gm-Message-State: AOJu0YwsxLdMYWoXvyq4OTFH0qOPXl4ocyIU29u7iGNI++Rf5jP+2o6t
 7SSHbl2rvZVl6Ctlc76Bhg58JQkoHyKS65sbx4Z773lmuzUiKAqo8mfdeaAXtwLZnTV691E8+i0
 dKL/yq9nsBp2go3xAxbjYuR+y5XxTWPV1xhr8O9whykfzihnjRrYNSPOpJb6Cxqya5mmH2Qa15Y
 j5NTeWMfXYzxE9vn9xO/FMiDvGt7X3MSYF1HZiHiHS
X-Gm-Gg: ASbGncsRnB+0QWLmXfZNQkbuTtdiKRY0WaSVWSmaiOUCucsWgEsLO08bQ/LbKLOkYSp
 lNPyXT9e++8TpNHSO1c5AmO7auQ7MBY6WL4fncR3LCP3mYkLJ3DLe/A9Lt6gnQOUAzo7OtqWJz0
 q1TS63pZYu9W7SJ3nF4A07ldQNpSCwPx+7GQpok54PfHByxQhDIvFy//57GPZX2O/0NpGLXnpxs
 ygqxY5c6XeHpMaz6DlYrznbqrdE/8SxWZ1ighOILetoDAMg4J1G573PWYX7+04iFMwjlWhKHuHE
 4CUGtrbIdsx4bu0JIztK1hZxI4xLOWC5L2z/pQQnmqNOfasv3ghK+QL6QNwtftZFv7tzY5NMBZD
 LPXiUArSIqqRSJoeb9PwlU8eZfHRZaPkzpPfm7Qc4FyU=
X-Received: by 2002:a05:6402:278f:b0:637:dfb1:339e with SMTP id
 4fb4d7f45d1cf-639d5b57a36mr17958878a12.5.1760354817479; 
 Mon, 13 Oct 2025 04:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEis6t2y7JR5br06DhN6aFKBpDTSbvvxJZ6BapbwXDWvBCNFi9BEIIKbOvIkFs0b7nQqrKQwQ==
X-Received: by 2002:a05:6402:278f:b0:637:dfb1:339e with SMTP id
 4fb4d7f45d1cf-639d5b57a36mr17958848a12.5.1760354816910; 
 Mon, 13 Oct 2025 04:26:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5235e7fasm8593722a12.7.2025.10.13.04.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 04:26:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Praveen K Paladugu <prapal@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] monitor: generalize query-mshv/"info mshv" to
 query-accelerators/"info accelerators"
Date: Mon, 13 Oct 2025 13:26:50 +0200
Message-ID: <20251013112650.935921-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013112650.935921-1-pbonzini@redhat.com>
References: <20251013112650.935921-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The recently-introduced query-mshv command is a duplicate of query-kvm,
and neither provides a full view of which accelerators are supported
by a particular binary of QEMU and which is in use.

KVM was the first accelerator added to QEMU, predating QOM and TYPE_ACCEL,
so it got a pass.  But now, instead of adding a badly designed copy, solve
the problem completely for all accelerators with a command that provides
the whole picture:

    >> {"execute": "query-accelerators"}
    << {"return": {"enabled": "tcg", "present": ["kvm", "mshv", "qtest", "tcg", "xen"]}}

Cc: Praveen K Paladugu <prapal@microsoft.com>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

 fixup a0df118f73f # fff
---
 qapi/accelerator.json      | 47 +++++++++++++++++++++++++++++---------
 include/monitor/hmp.h      |  2 +-
 hw/core/machine-hmp-cmds.c | 21 +++++++++--------
 hw/core/machine-qmp-cmds.c | 20 ++++++++++++----
 hmp-commands-info.hx       | 15 ++++++++----
 5 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 664e0272465..2b920608847 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -56,30 +56,55 @@
   'features': [ 'unstable' ] }
 
 ##
-# @MshvInfo:
+# @Accelerator:
 #
 # Information about support for MSHV acceleration
 #
-# @enabled: true if MSHV acceleration is active
+# @hvf: Apple Hypervisor.framework
 #
-# @present: true if MSHV acceleration is built into this executable
+# @kvm: KVM
+#
+# @mshv: Hyper-V
+#
+# @nvmm: NetBSD NVMM
+#
+# @qtest: QTest (dummy accelerator)
+#
+# @tcg: TCG (dynamic translation)
+#
+# @whpx: Windows Hypervisor Platform
+#
+# @xen: Xen
 #
 # Since: 10.2.0
 ##
-{ 'struct': 'MshvInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm', 'qtest', 'tcg', 'whpx', 'xen'] }
 
 ##
-# @query-mshv:
+# @AcceleratorInfo:
 #
-# Return information about MSHV acceleration
+# Information about support for various accelerators
 #
-# Returns: @MshvInfo
+# @enabled: the accelerator that is in use
 #
-# Since: 10.0.92
+# @present: the list of accelerators that are built into this executable
+#
+# Since: 10.2.0
+##
+{ 'struct': 'AcceleratorInfo', 'data': {'enabled': 'Accelerator', 'present': ['Accelerator']} }
+
+##
+# @query-accelerators:
+#
+# Return information about accelerators
+#
+# Returns: @AcceleratorInfo
+#
+# Since: 10.2.0
 #
 # .. qmp-example::
 #
-#     -> { "execute": "query-mshv" }
-#     <- { "return": { "enabled": true, "present": true } }
+#     -> { "execute": "query-accelerators" }
+#     <- { "return": { "enabled": "mshv", "present": ["kvm", "mshv", "qtest", "tcg"] } }
 ##
-{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
+{ 'command': 'query-accelerators', 'returns': 'AcceleratorInfo' }
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 31bd812e5f4..897dfaa2b6d 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,7 +24,7 @@ strList *hmp_split_at_comma(const char *str);
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
 void hmp_info_kvm(Monitor *mon, const QDict *qdict);
-void hmp_info_mshv(Monitor *mon, const QDict *qdict);
+void hmp_info_accelerators(Monitor *mon, const QDict *qdict);
 void hmp_info_status(Monitor *mon, const QDict *qdict);
 void hmp_info_uuid(Monitor *mon, const QDict *qdict);
 void hmp_info_chardev(Monitor *mon, const QDict *qdict);
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 682ed9f49b8..74a56600be8 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -163,19 +163,22 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     qapi_free_KvmInfo(info);
 }
 
-void hmp_info_mshv(Monitor *mon, const QDict *qdict)
+void hmp_info_accelerators(Monitor *mon, const QDict *qdict)
 {
-    MshvInfo *info;
+    AcceleratorInfo *info;
+    AcceleratorList *accel;
 
-    info = qmp_query_mshv(NULL);
-    monitor_printf(mon, "mshv support: ");
-    if (info->present) {
-        monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
-    } else {
-        monitor_printf(mon, "not compiled\n");
+    info = qmp_query_accelerators(NULL);
+    for (accel = info->present; accel; accel = accel->next) {
+        char trail = accel->next ? ' ' : '\n';
+        if (info->enabled == accel->value) {
+            monitor_printf(mon, "[%s]%c", Accelerator_str(accel->value), trail);
+        } else {
+            monitor_printf(mon, "%s%c", Accelerator_str(accel->value), trail);
+        }
     }
 
-    qapi_free_MshvInfo(info);
+    qapi_free_AcceleratorInfo(info);
 }
 
 void hmp_info_uuid(Monitor *mon, const QDict *qdict)
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e24bf0d97bf..51d5c230f7e 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -31,15 +31,25 @@
 #include <sys/stat.h>
 
 /*
- * QMP query for MSHV
+ * QMP query for enabled and present accelerators
  */
-MshvInfo *qmp_query_mshv(Error **errp)
+AcceleratorInfo *qmp_query_accelerators(Error **errp)
 {
-    MshvInfo *info = g_malloc0(sizeof(*info));
+    AcceleratorInfo *info = g_malloc0(sizeof(*info));
+    AccelClass *current_class = ACCEL_GET_CLASS(current_accel());
+    int i;
 
-    info->enabled = mshv_enabled();
-    info->present = accel_find("mshv");
+    for (i = ACCELERATOR__MAX; i-- > 0; ) {
+        const char *s = Accelerator_str(i);
+        AccelClass *this_class = accel_find(s);
 
+        if (this_class) {
+            QAPI_LIST_PREPEND(info->present, i);
+            if (this_class == current_class) {
+                info->enabled = i;
+            }
+        }
+    }
     return info;
 }
 
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c2aa40056bb..25b4aed51f5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -308,16 +308,21 @@ SRST
 ERST
 
     {
-        .name       = "mshv",
+        .name       = "accelerators",
         .args_type  = "",
         .params     = "",
-        .help       = "show MSHV information",
-        .cmd        = hmp_info_mshv,
+        .help       = "show present and enabled information",
+        .cmd        = hmp_info_accelerators,
     },
 
 SRST
-  ``info mshv``
-    Show MSHV information.
+  ``info accelerators``
+    Show which accelerators are compiled into a QEMU binary, and what accelerator
+    is in use. For example::
+
+        kvm qtest [tcg]
+
+    indicates that TCG in use, and that KVM and qtest are also available.
 ERST
 
     {
-- 
2.51.0


