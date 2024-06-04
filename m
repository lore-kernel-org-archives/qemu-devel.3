Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E6C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENx0-0007ze-A3; Tue, 04 Jun 2024 02:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvY-0004OL-14
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvU-0007b6-LE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3kk6qDClWUbQZl0B321Mu8iHJPjC3lDTl307Q8JEmA=;
 b=jNXy4mAIAD6XUVFotp0ZuiiUo6qGyDEnntyLSiypdqV7K6jHgPvOF5yum1hbqkzITaAyQN
 odaY7a6yJx/lloPY4XIPEIzfKDllCGw12aFeMdGE3ah5xdAX7lshizuvGh2avRjpmY829T
 uilGRo0jqAIKEvvrBQWkgAL6vbzV6RY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-WYORbEgDNE2w6i2669bw4w-1; Tue, 04 Jun 2024 02:45:35 -0400
X-MC-Unique: WYORbEgDNE2w6i2669bw4w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52b9267d9d6so1824659e87.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483533; x=1718088333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3kk6qDClWUbQZl0B321Mu8iHJPjC3lDTl307Q8JEmA=;
 b=ApZciwpeR+mbrO6I01DDNZk2WaSjZfkiGhPHpLFR6JkFw39ro4zRYEKSb1eHcerOTS
 l6ZIFgP1+ivFYy6fkv5u/yCM+2Ih2l8nyg+XDjdcKiH7NXx7gDi0dlrU8uEl1PzW9Yie
 2Xpb9FtB0l63jYKoEAaTDvu3U/OehgtUKFM6VzNX9H4EWidk8ukUvi2jpJOZ8FheTJ6C
 YnjIaMofQgUfJalzI12pPyC7nUlFnoq2qdu5bdLmzeUCPrH7u9lrFqILtM+VBXSszMQk
 UPUfAgtIalzq9BRv0pYkO7ToZnJCe7tRej0SGTaitbf8srcKMuQYyor0XXenNpeU54Nm
 3MDw==
X-Gm-Message-State: AOJu0YyBkvrtU/jt3JkGlIqGJw1O60z695q2qNvAouPKKU/qzh6zS0KG
 im3FK/cEUxKSUNTfGO2TBMRqdAo3QV3bF/84Q1fp25H0tplNrNKwyLZsYqZ3+Qe6ugPHMtG1ImX
 TM9SEmxjFpWBcmMKIbGSuEgI66PJb/xv5UKk4ppw/4cIQOhg10J0d9S68dndkk8W7m4QLGYQQtr
 FsnxTyMs9Z3J61BSqQ2eTOdkGlkOJm/s1QRX6J
X-Received: by 2002:ac2:5dc1:0:b0:51c:778f:b569 with SMTP id
 2adb3069b0e04-52b8956362bmr8294294e87.29.1717483533115; 
 Mon, 03 Jun 2024 23:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6w+yFphJKXxZ7Hv1uk/Se2vv1lMWFUixy72s1hKJDznmempiWcF2D8FFKTHJI4rK1wpspwg==
X-Received: by 2002:ac2:5dc1:0:b0:51c:778f:b569 with SMTP id
 2adb3069b0e04-52b8956362bmr8294284e87.29.1717483532673; 
 Mon, 03 Jun 2024 23:45:32 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6959f932b4sm67763466b.171.2024.06.03.23.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 28/45] i386/sev: Update query-sev QAPI format to handle SEV-SNP
Date: Tue,  4 Jun 2024 08:43:52 +0200
Message-ID: <20240604064409.957105-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

Most of the current 'query-sev' command is relevant to both legacy
SEV/SEV-ES guests and SEV-SNP guests, with 2 exceptions:

  - 'policy' is a 64-bit field for SEV-SNP, not 32-bit, and
    the meaning of the bit positions has changed
  - 'handle' is not relevant to SEV-SNP

To address this, this patch adds a new 'sev-type' field that can be
used as a discriminator to select between SEV and SEV-SNP-specific
fields/formats without breaking compatibility for existing management
tools (so long as management tools that add support for launching
SEV-SNP guest update their handling of query-sev appropriately).

The corresponding HMP command has also been fixed up similarly.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by:Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-15-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc-target.json | 72 ++++++++++++++++++++++++++++++++++---------
 target/i386/sev.h     |  3 ++
 target/i386/sev.c     | 57 +++++++++++++++++++++-------------
 3 files changed, 97 insertions(+), 35 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 4e0a6492a9a..2d7d4d89bd5 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -47,6 +47,50 @@
            'send-update', 'receive-update' ],
   'if': 'TARGET_I386' }
 
+##
+# @SevGuestType:
+#
+# An enumeration indicating the type of SEV guest being run.
+#
+# @sev: The guest is a legacy SEV or SEV-ES guest.
+#
+# @sev-snp: The guest is an SEV-SNP guest.
+#
+# Since: 6.2
+##
+{ 'enum': 'SevGuestType',
+  'data': [ 'sev', 'sev-snp' ],
+  'if': 'TARGET_I386' }
+
+##
+# @SevGuestInfo:
+#
+# Information specific to legacy SEV/SEV-ES guests.
+#
+# @policy: SEV policy value
+#
+# @handle: SEV firmware handle
+#
+# Since: 2.12
+##
+{ 'struct': 'SevGuestInfo',
+  'data': { 'policy': 'uint32',
+            'handle': 'uint32' },
+  'if': 'TARGET_I386' }
+
+##
+# @SevSnpGuestInfo:
+#
+# Information specific to SEV-SNP guests.
+#
+# @snp-policy: SEV-SNP policy value
+#
+# Since: 9.1
+##
+{ 'struct': 'SevSnpGuestInfo',
+  'data': { 'snp-policy': 'uint64' },
+  'if': 'TARGET_I386' }
+
 ##
 # @SevInfo:
 #
@@ -60,25 +104,25 @@
 #
 # @build-id: SEV FW build id
 #
-# @policy: SEV policy value
-#
 # @state: SEV guest state
 #
-# @handle: SEV firmware handle
+# @sev-type: Type of SEV guest being run
 #
 # Since: 2.12
 ##
-{ 'struct': 'SevInfo',
-    'data': { 'enabled': 'bool',
-              'api-major': 'uint8',
-              'api-minor' : 'uint8',
-              'build-id' : 'uint8',
-              'policy' : 'uint32',
-              'state' : 'SevState',
-              'handle' : 'uint32'
-            },
-  'if': 'TARGET_I386'
-}
+{ 'union': 'SevInfo',
+  'base': { 'enabled': 'bool',
+            'api-major': 'uint8',
+            'api-minor' : 'uint8',
+            'build-id' : 'uint8',
+            'state' : 'SevState',
+            'sev-type' : 'SevGuestType' },
+  'discriminator': 'sev-type',
+  'data': {
+      'sev': 'SevGuestInfo',
+      'sev-snp': 'SevSnpGuestInfo' },
+  'if': 'TARGET_I386' }
+
 
 ##
 # @query-sev:
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 94295ee74f7..5dc4767b1e9 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -31,6 +31,9 @@
 #define SEV_POLICY_DOMAIN       0x10
 #define SEV_POLICY_SEV          0x20
 
+#define SEV_SNP_POLICY_SMT      0x10000
+#define SEV_SNP_POLICY_DBG      0x80000
+
 typedef struct SevKernelLoaderContext {
     char *setup_data;
     size_t setup_size;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 072cc4f8530..43d1c48bd9e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -363,25 +363,27 @@ static SevInfo *sev_get_info(void)
 {
     SevInfo *info;
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    SevGuestState *sev_guest =
-        (SevGuestState *)object_dynamic_cast(OBJECT(sev_common),
-                                             TYPE_SEV_GUEST);
 
     info = g_new0(SevInfo, 1);
     info->enabled = sev_enabled();
 
     if (info->enabled) {
-        if (sev_guest) {
-            info->handle = sev_guest->handle;
-        }
         info->api_major = sev_common->api_major;
         info->api_minor = sev_common->api_minor;
         info->build_id = sev_common->build_id;
         info->state = sev_common->state;
-        /* we only report the lower 32-bits of policy for SNP, ok for now... */
-        info->policy =
-            (uint32_t)object_property_get_uint(OBJECT(sev_common),
-                                               "policy", NULL);
+
+        if (sev_snp_enabled()) {
+            info->sev_type = SEV_GUEST_TYPE_SEV_SNP;
+            info->u.sev_snp.snp_policy =
+                object_property_get_uint(OBJECT(sev_common), "policy", NULL);
+        } else {
+            info->sev_type = SEV_GUEST_TYPE_SEV;
+            info->u.sev.handle = SEV_GUEST(sev_common)->handle;
+            info->u.sev.policy =
+                (uint32_t)object_property_get_uint(OBJECT(sev_common),
+                                                   "policy", NULL);
+        }
     }
 
     return info;
@@ -404,20 +406,33 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
 {
     SevInfo *info = sev_get_info();
 
-    if (info && info->enabled) {
-        monitor_printf(mon, "handle: %d\n", info->handle);
-        monitor_printf(mon, "state: %s\n", SevState_str(info->state));
-        monitor_printf(mon, "build: %d\n", info->build_id);
-        monitor_printf(mon, "api version: %d.%d\n",
-                       info->api_major, info->api_minor);
-        monitor_printf(mon, "debug: %s\n",
-                       info->policy & SEV_POLICY_NODBG ? "off" : "on");
-        monitor_printf(mon, "key-sharing: %s\n",
-                       info->policy & SEV_POLICY_NOKS ? "off" : "on");
-    } else {
+    if (!info || !info->enabled) {
         monitor_printf(mon, "SEV is not enabled\n");
+        goto out;
     }
 
+    monitor_printf(mon, "SEV type: %s\n", SevGuestType_str(info->sev_type));
+    monitor_printf(mon, "state: %s\n", SevState_str(info->state));
+    monitor_printf(mon, "build: %d\n", info->build_id);
+    monitor_printf(mon, "api version: %d.%d\n", info->api_major,
+                   info->api_minor);
+
+    if (sev_snp_enabled()) {
+        monitor_printf(mon, "debug: %s\n",
+                       info->u.sev_snp.snp_policy & SEV_SNP_POLICY_DBG ? "on"
+                                                                       : "off");
+        monitor_printf(mon, "SMT allowed: %s\n",
+                       info->u.sev_snp.snp_policy & SEV_SNP_POLICY_SMT ? "on"
+                                                                       : "off");
+    } else {
+        monitor_printf(mon, "handle: %d\n", info->u.sev.handle);
+        monitor_printf(mon, "debug: %s\n",
+                       info->u.sev.policy & SEV_POLICY_NODBG ? "off" : "on");
+        monitor_printf(mon, "key-sharing: %s\n",
+                       info->u.sev.policy & SEV_POLICY_NOKS ? "off" : "on");
+    }
+
+out:
     qapi_free_SevInfo(info);
 }
 
-- 
2.45.1


