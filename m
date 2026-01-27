Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0412D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSa-0007SI-QA; Tue, 27 Jan 2026 00:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSS-0007If-Lr
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSQ-000083-JP
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4BnmYW2pBzdLKLKUKm7VVppCSo8wKNLqPmySN8D7FQ=;
 b=PDtSzCA9/jxsTv4aNd41U5FFJ0EGZcdf+FGjm5vZ97q4z3eji/cbDj3k+CN+JtPclgrlUJ
 SAmKt/6wJ592Xblt+8o5SQV4aBbstSymnciQOh3nKyma8l52foE8xE0Ygmp0rrEOayWrW1
 GqdKes7WBCH5+u/nb6cJdG2bKD6Vm48=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-KxVwpz70OSqhKMdBKPAYzQ-1; Tue, 27 Jan 2026 00:17:40 -0500
X-MC-Unique: KxVwpz70OSqhKMdBKPAYzQ-1
X-Mimecast-MFC-AGG-ID: KxVwpz70OSqhKMdBKPAYzQ_1769491059
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f2b45ecffso83297725ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491059; x=1770095859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4BnmYW2pBzdLKLKUKm7VVppCSo8wKNLqPmySN8D7FQ=;
 b=SgTrEfriMy2zT+XOnya3AjUCDY1arZ6K4omIsa9ACPr9TPyh0BhpeiMXoOSMbtREpU
 G4JuULsvCgWcsYUd8htbNSi6nNCzEQJvvPC22TJGWEJyT3iA1w6MTLot8aJQznmZ0UhO
 fJMcN7DyGCCoD0Ljlg3JBmkYRxz5KusRGyDN5r73woQXAsd3sqvqlUsgzXET5IHtc5kl
 BfGSQ1AsCaDONLCHogT9TxiEhYaNl9GeE2zATPkHN/kKcgsqtQGszE1p/dFlKr8Bg8tz
 ul5n1IHfUJcpIpr79fxGKCNmzaMgl0TaM0TxiQr2IA58FLUs/NnOxZD9sNv70/I92gzE
 ij3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491059; x=1770095859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M4BnmYW2pBzdLKLKUKm7VVppCSo8wKNLqPmySN8D7FQ=;
 b=XO720myT7LR2xiI7tD4Kafl6om5kKMnDhaCaDPZQCT/LrBs1fwJvbMYBjVUBXYUQlC
 RL+V7bf3mwW7/mTS+yMEuF/uzVP9CpLUv0mfjaqzLz2zWDu4ArMYzSw9aEo4tjkJBZWq
 xU5M3vwrl+KNUM+ezpnKPw3y2D0nx6I8ikLqkOK/RMv2YHuKUKzNJ3ajz16xEV29I8eS
 mVV7En2UDSTO/ICvSdh/Bzkeg1D1z0v1wcLIwOoEJN2A5rb31pXKFPZib4JNA9MinrIh
 LrTHJgHo4fTgGSHtDcrONdX9pGrAa8EIqqqsMdPcrKpgU1F7dO7dkzx5y/RiLBLW2l5W
 fsQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq22qsCsguH+MzSD1I7Ijbw9ZVX1Uhu0PXmgVUh+6ftsGVvkbkft+mDkumsZBFCA387Htqe+Owqe4u@nongnu.org
X-Gm-Message-State: AOJu0YwaH8+NaSl6pm57x9XqVdOQfoOe5rYZZ58vdtcuioB3hZnCStDV
 yVv6QvjS5+Cl0c52W5bBbd/Zt41Mz8AYfkl4MfdQ0FzAXGqh3hdDZgxyumzr+mMBC6nQM59BXsH
 DiGF2qMkVGWYiJ7rDekGXaIe7cO3BHxzp+mKsDODk5fOQYCydTS1T8j2/hdg4OnmR
X-Gm-Gg: AZuq6aIoL91+FbIwRh23dka0YLi1J7AqDpk///LLkRpvhaHh/HB6HEntNIo+h47wNMM
 ZRY3WpWYtl2TiX35P1mDgL5kDxTwGBgXZgk5a5M5cmchOXzmZI9Yjde4a2HE9jTUPXFqXdTPPkO
 97KZN7sBziv0e0RpiO6PzM7ODQy4tEJbYc1nvVW3S4qr2bKGcgUZFixguTHNKz+Jy16ZT0Jl/6m
 CYTQDYAZagnGHVjzshlRVDpEH5kTs1MVrfzzQAPj4pfYRMLdCxbOMrAwtSRkXvYkW2UGidy3k+K
 MTFnAs9Bwwqj1ezJZ+vz2CHUwGkvMmXY3XQSQimsVykctHzI9300R79lIBPQ9fIooPdGZBmOylv
 st5wHPzELHIv4N4qYAlCeltQnab0STMygNaxKqen3hA==
X-Received: by 2002:a17:902:ea0d:b0:2a7:63dd:3496 with SMTP id
 d9443c01a7336-2a870dd5288mr8218945ad.46.1769491058625; 
 Mon, 26 Jan 2026 21:17:38 -0800 (PST)
X-Received: by 2002:a17:902:ea0d:b0:2a7:63dd:3496 with SMTP id
 d9443c01a7336-2a870dd5288mr8218645ad.46.1769491058214; 
 Mon, 26 Jan 2026 21:17:38 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 21/33] i386/sev: add support for confidential guest reset
Date: Tue, 27 Jan 2026 10:45:49 +0530
Message-ID: <20260127051612.219475-22-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When the KVM VM file descriptor changes as a part of the confidential guest
reset mechanism, it necessary to create a new confidential guest context and
re-encrypt the VM memeory. This happens for SEV-ES and SEV-SNP virtual machines
as a part of SEV_LAUNCH_FINISH, SEV_SNP_LAUNCH_FINISH operations.

A new resettable interface for SEV module has been added. A new reset callback
for the reset 'exit' state has been implemented to perform the above operations
when the VM file descriptor has changed during VM reset.

Tracepoints has been added also for tracing purpose.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c        | 58 ++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 59 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d1dc0f3c1d..a53b4696e2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -30,8 +30,10 @@
 #include "system/kvm.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
+#include "system/cpus.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "system/reset.h"
 #include "trace.h"
 #include "migration/blocker.h"
 #include "qom/object.h"
@@ -85,6 +87,10 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
     uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashTable)];
 } PaddedSevHashTable;
 
+static void sev_handle_reset(Object *obj, ResetType type);
+
+SevKernelLoaderContext sev_load_ctx = {};
+
 QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
 
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
@@ -128,6 +134,7 @@ struct SevCommonState {
     uint8_t build_id;
     int sev_fd;
     SevState state;
+    ResettableState reset_state;
 
     QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
 };
@@ -1665,6 +1672,11 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
             error_setg(&sev_mig_blocker,
                        "SEV: Migration is not implemented");
             migrate_add_blocker(&sev_mig_blocker, &error_fatal);
+            /*
+             * mark SEV guest as resettable so that we can reinitialize
+             * SEV upon reset.
+             */
+            qemu_register_resettable(OBJECT(sev_common));
         }
     }
 }
@@ -1991,6 +2003,41 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+/*
+ * handle sev vm reset
+ */
+static void sev_handle_reset(Object *obj, ResetType type)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+
+    if (!sev_common) {
+        return;
+    }
+
+    if (!runstate_is_running()) {
+        return;
+    }
+
+    sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
+    if (sev_es_enabled() && !sev_snp_enabled()) {
+        sev_launch_get_measure(NULL, NULL);
+    }
+    if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
+        /* this calls sev_snp_launch_finish() etc */
+        klass->launch_finish(sev_common);
+    }
+
+    trace_sev_handle_reset();
+    return;
+}
+
+static ResettableState *sev_reset_state(Object *obj)
+{
+    SevCommonState *sev_common = SEV_COMMON(obj);
+    return &sev_common->reset_state;
+}
+
 int
 sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
@@ -2469,6 +2516,8 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
         return false;
     }
 
+    /* save the context here so that it can be re-used when vm is reset */
+    memcpy(&sev_load_ctx, ctx, sizeof(*ctx));
     return klass->build_kernel_loader_hashes(sev_common, area, ctx, errp);
 }
 
@@ -2729,8 +2778,16 @@ static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     klass->kvm_init = sev_common_kvm_init;
+    /*
+     * the exit phase makes sure sev handles reset after all legacy resets
+     * have taken place (in the hold phase) and IGVM has also properly
+     * set up the boot state.
+     */
+    rc->phases.exit = sev_handle_reset;
+    rc->get_state = sev_reset_state;
 
     object_class_property_add_str(oc, "sev-device",
                                   sev_common_get_sev_device,
@@ -2780,6 +2837,7 @@ static const TypeInfo sev_common_info = {
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_RESETTABLE_INTERFACE },
         { }
     }
 };
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 51301673f0..b320f655ee 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -14,3 +14,4 @@ kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data
 kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
 kvm_sev_snp_launch_update(uint64_t src, uint64_t gpa, uint64_t len, const char *type) "src 0x%" PRIx64 " gpa 0x%" PRIx64 " len 0x%" PRIx64 " (%s page)"
 kvm_sev_snp_launch_finish(char *id_block, char *id_auth, char *host_data) "id_block %s id_auth %s host_data %s"
+sev_handle_reset(void) ""
-- 
2.42.0


