Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8E1C9EC91
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuk-0004hx-Rq; Mon, 12 Jan 2026 08:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuN-000477-Gz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuL-0003s1-72
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mNZOVGpLRkq1Bf/PS8HZ5/0yQ0n0eM+fBjQiQ5vegE=;
 b=ZtkLkmiUK/B5qtN+N2KQywZkTTm+/yOKRylOORWzxSPedIXFBV/G+GPMLv4h/mOcsHIwkW
 ZnMhOvviflSvTljNf52F5b5oLt7taXySdtyc8kojeLxeQc2ObkrHbbdf6fW7Ua8jP0yvQe
 wtAgOX8O4KciukMqbgC+KZhshTidf2Y=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-FAq77rNNNs-cuer31wN--A-1; Mon, 12 Jan 2026 08:24:29 -0500
X-MC-Unique: FAq77rNNNs-cuer31wN--A-1
X-Mimecast-MFC-AGG-ID: FAq77rNNNs-cuer31wN--A_1768224268
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-81e6ec1da28so1868054b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224268; x=1768829068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mNZOVGpLRkq1Bf/PS8HZ5/0yQ0n0eM+fBjQiQ5vegE=;
 b=hm+V3aife0tGOQlO5s2W24po7HFF6i4/NzHNJN7HqeSFjsRWDmC4Hn5OWPojDRqI8D
 KRhv5iJ3zbXNxjsp/XwSLaePnalQjrdACJqqx/JmeDTwyDqW0axZvoAkHafKO+1XzivQ
 +N6BVcn9GUIqFn/ggNIYqr2tRFNCMT3ScPiBqHOVMyEHkoclMEoYG1AQ/mB2emYhAn1J
 Cp1fXSp+6FBunsA0okw8a66fjJggfJXJD9sp6SxZNIFAr24oHtsZk73ILw+RByn5BaSS
 1AsItljMpVqRCfmaWWD32Yn6VX9lkfwP6/yLWh6QrwCcrKzPrF2dJGMj3Rb/LieHoZZ7
 uMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224268; x=1768829068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5mNZOVGpLRkq1Bf/PS8HZ5/0yQ0n0eM+fBjQiQ5vegE=;
 b=KHQWjxdOtNC+zmWDxl1hktmZJo0m7+vY4QURhNqSvYTna18Ze5BRT43brZn6yhoNnK
 SWFdyJaXRCjE/6EjxGixiVLh6/gyQSD/bxbxDNRHKbSdVXttY7Ie2okCg506B1t98i8Y
 pq1v7FW1eBRNMtsm84CfuyAfoNv4d1bprn8bxWfYGZXMEQomE7PZOKOKxVc67uZFP/Uu
 XDrCmC4qTBNUgwF/EaJif4vB0q1EPU5/9TyzJ6wtvyQJnYKBqEdJ5xq9uoWB+o+MnmaW
 IL9FAffQrlhX4vb8MKQC/avMSff+s87X4Z/3AivsAZo27BQgv9kJCp80DwgnVKlBCoHn
 VHPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Fmpgwz25wZBf8CvMUXHqBqnYVppehHhcAjHdmpi2HpYP31LHEKPQ0mWSSWHyNewzX3gW5uUpEbNN@nongnu.org
X-Gm-Message-State: AOJu0YzZtiyKFaghSDd8PnHQdE77g9bXIQEBZREm6i45Zchax799cN2k
 zdUzpxUIVM2hGR5I3c+kEvalnF/PqPqFCKM1/D3tcIblq16KoZmg3cnXW6lainRh5AV7wnx3P0E
 T4ARB9OqQPaj1aMW0/N/sLNx2KP6DPOOTykjmehPKt8VUp99MMuJ8ufYK
X-Gm-Gg: AY/fxX4ZHMVP0CwFdJaSMSSVsMqlvt0NK6aalmwV7TUvzyGIFpa9jHJpE/IQxvrNMLt
 eIKFrhZUuYL0iBGpkNbZYxWOmZSqY0C6gByiLwk6f3UKXPl3R+9Ct+lD/IxWYyENV+XzOlXV7M0
 z6Zg+zVFilF3KHNEqIpZK+oXum8SxkjoNx7AgrPkfritbxzVR2IkqV5eVYGXz4Mh6zVsBJyx6sJ
 6m7bUsT5hgEHqMjKkWn6bzP5SptCCI86J4kDT0IzBz8IX6MSZbr3LnndZE2oxfHc63Lvd+c6+in
 DnY+wGd/LouN0jJ2vP9zweeXCtq7ktfnecD4i4K/sFPkdPid9K7EViEsOEFOYwl9+6vQFdaeeTX
 boXXOnsZJ8B962vjI/WCYiV6IuWM+rEpK4tjXjIy5d6w=
X-Received: by 2002:a05:6a20:6a08:b0:37e:8eea:3e3f with SMTP id
 adf61e73a8af0-3898f9c28a9mr16110805637.80.1768224268306; 
 Mon, 12 Jan 2026 05:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD9RUhQ3GTJxL2ONxoegYo4Rf5YfwQeYOo30AP0UNkHIJItgroqtE20TpG/pfeVSe07ySt6g==
X-Received: by 2002:a05:6a20:6a08:b0:37e:8eea:3e3f with SMTP id
 adf61e73a8af0-3898f9c28a9mr16110784637.80.1768224267933; 
 Mon, 12 Jan 2026 05:24:27 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:27 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v2 24/32] accel/kvm: add a per-confidential class callback to
 unlock guest state
Date: Mon, 12 Jan 2026 18:52:37 +0530
Message-ID: <20260112132259.76855-25-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index b0ce0410fa..710f5882d9 100644
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
index 314d316b7c..a89b14d401 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1589,6 +1589,11 @@ static ResettableState *tdx_reset_state(Object *obj)
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
@@ -1596,6 +1601,7 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     klass->kvm_init = tdx_kvm_init;
+    klass->can_rebuild_guest_state = tdx_can_rebuild_guest_state;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index d45356843c..c52027c935 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2632,6 +2632,14 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
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
@@ -2806,6 +2814,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->can_rebuild_guest_state = sev_can_rebuild_guest_state;
 
     qemu_register_resettable(OBJECT(sev_common));
 
-- 
2.42.0


