Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A0D49238
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4iE-0003XX-L0; Fri, 12 Dec 2025 10:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iD-0003Ma-AS
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4iB-00068H-62
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMdRfFGcpxCcqNkq2TVSVJsE/ZLQul0p4ArTaq9CGns=;
 b=TJ3XxgZD0jYoZXiIdmVa7PGNVMgsRVJbbEe05fg2oXU6X9asW6M2fcTfy4XXYXFpuPhZ5w
 kd6rUuB7JOn9pjPJT8+Dv3HW7rTeqQxJzlUyyAD2d+N/2DR5rgbPTYaZvbIcWzeUNX34mT
 DRh3t3XFnPFXSlX1oaTWqP3ED2NcFKY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-ezsbKj2tO0mg7Yx03RSqow-1; Fri, 12 Dec 2025 10:05:37 -0500
X-MC-Unique: ezsbKj2tO0mg7Yx03RSqow-1
X-Mimecast-MFC-AGG-ID: ezsbKj2tO0mg7Yx03RSqow_1765551935
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29557f43d56so16175215ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551935; x=1766156735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMdRfFGcpxCcqNkq2TVSVJsE/ZLQul0p4ArTaq9CGns=;
 b=fe2RkfSRymVPJOCkvyz/X0VPf+Ym9Kg2def7ZZ3QlDWkvnxExoV9daLQ/uPbHOLiSZ
 rp6r6rsoVH5+aQKARJLkMNzLpigwQeomWjI/WdkNM4DwG+PYOorX8o1i9a2/OkDx4Hyr
 6YE0Hqw8EvidgbegxTfzUy24sC/VyoYKn3IapDRiFDtIQNlqM2c215sYOORrX2QM+Jx1
 iwar/9usN/QsWW5gCKMeglrgvJWxumOJr7VsrS/KdRy0cJ95yLP01gzopuqEa+MDT3AG
 77drXkZU4shuanuNyEFD58eTYmR3F52ygFCL5Z3JeFMX53wtlVnA4PGmGJ/4askpAzqy
 5zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551935; x=1766156735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMdRfFGcpxCcqNkq2TVSVJsE/ZLQul0p4ArTaq9CGns=;
 b=cGmb2TOq8szBniLYMwkkM2XQvtyjLG0TAztq3wgsVxBNFvAFSQmgkKUG2HhYqmu+BT
 cSjVqF5wc3LpAKPQK8Zfw0mrD8nf7PvNFyE3JdHDiBKLMnHu/uS9W4HEJTRaBPUQckzI
 qkJtbb6zXPf6L+1PiNVCgdjYcUAtm2KDon9ucnwSkohKBcV9d/9ow7a2x4dmk3K7ohcG
 krJE9ssY/PGqbnLKOLRT71O/R2c7U7EPWtbLIYfAEVIU+i5+g+LqNRi/RCUmpZfjg3EB
 MIVZejgpAuRzSmZ5d5AMOppKikuTpG3ANZf8KNQXzeHcmRpRxUtfABLsML5wRKLEfk5A
 NsIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYKsJcs2sBplirwEmfdNIBv0T7osear5B6UrBOPo0YGbPEgRanX1/32hBTJivNCyXZSVEAmPmXk7TE@nongnu.org
X-Gm-Message-State: AOJu0YzaN+DC5X9Zp4iv+thJaFU5zK5rYvakuNzhKDkndSAwzaJunVWC
 S+NgRTh6op2gJ+HXsvf3LKijUvc6SQTwwYmVWxyysDN5x7RxOG5LQmb+OtJNSdj6lTYQ5uxa0jh
 9IGJhkN9jiLPT4lFY2SzVL4ElxjJ39DhvYFTcuNI1wy6NSJQ7gFVHeirm
X-Gm-Gg: AY/fxX7LvtZP9hPq1QE4BAdLHuA2Bnw0q/CyjDLS2svMeu16zlenQa3UzEvY8Mc61bY
 /fWF542qJGVF3KK/SmkeDTthouclZqSxB+TRwSt/19s+gX8TpvEn8idJhfcFwKS36zpyLjG5pip
 Olv5F4Sq1zaYYjTMmZW2sHIjrzM0jfq1P1goyqI5rzNUqFS3hdE/FS0kGNPdJBLtISnCK0diX8m
 Mrukexqs3hrvwADCy87rUacj6chMJUobF/eou4Nb+pkS4yGpCIaVlyI3zjnCYkqwFI+mIj1chLm
 rVR+D6bPd8fHNbMFbCyJRfp4hr1+MNfaiTl1ALD4cyWyqbSyKWLPofycOZLmexYPpHh2dcbUxAd
 kNttv/4hy9Emj562Gy54wMRZYYULso12ZzT1nbp0w7os=
X-Received: by 2002:a17:903:acf:b0:294:fcae:826 with SMTP id
 d9443c01a7336-29f244d24c1mr23437805ad.59.1765551934974; 
 Fri, 12 Dec 2025 07:05:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGedReOhIbFJBin/uwXKIliBnvQTpJto3XxixePrYDFlN9AlFUFlcGPxEcKxB7IBSK0yyzltA==
X-Received: by 2002:a17:903:acf:b0:294:fcae:826 with SMTP id
 d9443c01a7336-29f244d24c1mr23437305ad.59.1765551934309; 
 Fri, 12 Dec 2025 07:05:34 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 22/28] accel/kvm: add a per-confidential class callback to
 unlock guest state
Date: Fri, 12 Dec 2025 20:33:50 +0530
Message-ID: <20251212150359.548787-23-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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

As a part of the confidential guest reset process, the existing encrypted guest
state must be made mutable since it would be discarded after reset. A new
encrypted and locked guest state must be established after the reset. To this
end, a new callback per confidential guest support class (eg, tdx or sev-snp)
is added that will indicate whether its possible to rebuild guest state:

bool (*can_rebuild_guest_state)(ConfidentialGuestSupport *cgs)

This api returns true if rebuilding guest state is possible,
false otherwise. A KVM based confidential guest reset is only possible when
the existing state is locked but its possible to rebuild guest state.
Otherwise, the guest is not resettable.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/system/confidential-guest-support.h | 27 +++++++++++++++++++++
 system/runstate.c                           | 11 +++++++--
 target/i386/kvm/tdx.c                       |  6 +++++
 target/i386/sev.c                           |  9 +++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 0cc8b26e64..3c37227263 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -152,6 +152,11 @@ typedef struct ConfidentialGuestSupportClass {
      */
     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp);
+
+    /*
+     * is it possible to rebuild the guest state?
+     */
+    bool (*can_rebuild_guest_state)(ConfidentialGuestSupport *cgs);
 } ConfidentialGuestSupportClass;
 
 static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
@@ -167,6 +172,28 @@ static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
     return 0;
 }
 
+static inline bool
+confidential_guest_can_rebuild_state(ConfidentialGuestSupport *cgs)
+{
+    ConfidentialGuestSupportClass *klass;
+
+    if (!cgs) {
+        /* non-confidential guests */
+        return true;
+    }
+
+    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
+    if (klass->can_rebuild_guest_state) {
+        return klass->can_rebuild_guest_state(cgs);
+    }
+
+    /*
+     * by default, we should not be able to unprotect the
+     * confidential guest state
+     */
+    return false;
+}
+
 static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
                                                Error **errp)
 {
diff --git a/system/runstate.c b/system/runstate.c
index f5e57fd1f7..fb878c2992 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -58,6 +58,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
+#include "system/confidential-guest-support.h"
 #include "system/system.h"
 #include "system/tpm.h"
 #include "trace.h"
@@ -564,7 +565,12 @@ void qemu_system_reset(ShutdownCause reason)
     if (cpus_are_resettable()) {
         cpu_synchronize_all_post_reset();
     } else {
-        assert(runstate_check(RUN_STATE_PRELAUNCH));
+        /*
+         * for confidential guests, cpus are not resettable but their
+         * state can be rebuilt under some conditions.
+         */
+        assert(runstate_check(RUN_STATE_PRELAUNCH) ||
+               (current_machine->cgs && runstate_is_running()));
     }
 
     vm_set_suspended(false);
@@ -713,7 +719,8 @@ void qemu_system_reset_request(ShutdownCause reason)
     if (reboot_action == REBOOT_ACTION_SHUTDOWN &&
         reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         shutdown_requested = reason;
-    } else if (!cpus_are_resettable()) {
+    } else if (!cpus_are_resettable() &&
+               !confidential_guest_can_rebuild_state(current_machine->cgs)) {
         error_report("cpus are not resettable, terminating");
         shutdown_requested = reason;
     } else {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index b6fac162bd..20f9d63eff 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1594,6 +1594,11 @@ static ResettableState *tdx_reset_state(Object *obj)
     return &tdx->reset_state;
 }
 
+static bool tdx_can_rebuild_guest_state(ConfidentialGuestSupport *cgs)
+{
+    return true;
+}
+
 static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
@@ -1601,6 +1606,7 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     klass->kvm_init = tdx_kvm_init;
+    klass->can_rebuild_guest_state = tdx_can_rebuild_guest_state;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 246a58c752..4eea58d160 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2659,6 +2659,14 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static bool sev_can_rebuild_guest_state(ConfidentialGuestSupport *cgs)
+{
+    if (!sev_snp_enabled() && !sev_es_enabled()) {
+        return false;
+    }
+    return true;
+}
+
 static int cgs_get_mem_map_entry(int index,
                                  ConfidentialGuestMemoryMapEntry *entry,
                                  Error **errp)
@@ -2833,6 +2841,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->can_rebuild_guest_state = sev_can_rebuild_guest_state;
 
     qemu_register_resettable(OBJECT(sev_common));
 
-- 
2.42.0


