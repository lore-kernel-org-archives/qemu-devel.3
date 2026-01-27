Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B555D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSK-00078S-4v; Tue, 27 Jan 2026 00:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSD-00072r-6Q
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSB-0008Qm-Mj
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OnOtqZFQnQ7z67Y/wwL5FaGuBGKBCde67NUJiikFzaU=;
 b=chTyUbKBQFBYjapSH5z9KfQOu8vDe+T5y2MMUG4eLgncvYr+pU3wqSl3mHkzDNDDhDPzPj
 ggrLhHWbuVkH1KisVaroSl04zdKFqx8IJ8vqlMmt5VZOCt/ikw6P1VuhGQKPn2ilIwXry3
 MDt8sUYOnr8hfq1ow8rqvLUeT/hmyb4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-0CbqIU1KMo6NvkHHkxJ5Wg-1; Tue, 27 Jan 2026 00:17:25 -0500
X-MC-Unique: 0CbqIU1KMo6NvkHHkxJ5Wg-1
X-Mimecast-MFC-AGG-ID: 0CbqIU1KMo6NvkHHkxJ5Wg_1769491044
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-353049e6047so3890683a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491044; x=1770095844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnOtqZFQnQ7z67Y/wwL5FaGuBGKBCde67NUJiikFzaU=;
 b=Ecj2RZCIm5zJHv6wvPeHD/IiKFzh1S1XKZ1krXIIXCYr4QrlWpTxHw2Ey3kke3ykF1
 r8bExHA8w54VCjPwcwWhsq84wA02qsGDkWd/AUKnBmNBkYc94iljTSamaoAfQqJX3Zwc
 CSfRxxjxUHpZtebQMuvCFU+9SQwDboQ8tLwg2ExY0gOSruArjpHiA6cH5HdrFaaNBZWm
 Lm3ZaY1D4DwqpHctYRLBMamLE/xM2OcxFE2fJvs21jPK8A/PueQ11shI3y+r9zQdOWaQ
 hkL6Dp+kLAs26aOiPVwa5KI/xvqBShUI7gfzKwlN9X4u6vkAKMWQR9uG1MPKjG+WH7PX
 CYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491044; x=1770095844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OnOtqZFQnQ7z67Y/wwL5FaGuBGKBCde67NUJiikFzaU=;
 b=ryy/hSwhDMhTjGB5+WGtMZogWHjbspthnkTJIO0TrYpjF5LugenyYwv976M3w9gtV1
 2PKHLIzbY0Ei6qjuZK9swgz10F+R+n8PPh9QoQSUPLUhiw7j1yglSyfTdHEM7wNZbiYQ
 uXmpG+hULAaiEGiMYzDPbL7oYVMeDfGqolz8Y2ZlVhKnlbgvXvWnGtGlyg8qDhjEB6s8
 7IvcATjYgH18FLWQmmYOrbhMG8Fgglf84IGZ3avpfs0qHzQCDl27BEm9GRvf88PeVA3a
 hH2Btpty6u1VMwUZNqLSWIPOlclU5/zvtDT2LiWuyWKc5OjhQvI/O7KVqD0xxdsJZGAD
 7VXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyVtwnkP01eEKPiSBARnzNbsQjUWZrjhi2gEdVADKX6z6954nOQqMJDlZawpadyrrfEfqbci5zrjqH@nongnu.org
X-Gm-Message-State: AOJu0YwMoyZNN+I9+dilqwDxXCoZH5D9k17W0mSoPY/ekBtgR6wkSfQl
 qxkW0m0CO4W9XN0kWQUbYSmUTCbdXN43tIoJfTQy68EPPag3BHitLpW6GZsVWhLC93XT8mXpg8X
 quKbjTGrkmLnGuZoG720wHqI6hl16y9L4EFfAvQqNplUtLwZc343+7LzS
X-Gm-Gg: AZuq6aLqC+46cfN9Ni7PSf1QswfaEFgQ2brqeUA3aE9j+wb4tkzJeHLsDJsX9O66+zz
 KIeDFq/oZrac5/Jhq3QHHIGp205Uf/Xpeato5Yb36oPoOjvGElIQEeRRbEn2EoSOoahII31hnIQ
 nhYZd0X3Q7rp+GscrhskVvr3sIAcjoy4PvX0UhhMtC1NxUK2TzfZNLpCPUVpVIGkBlNfSX7T6aw
 yEPSLiH4zRYEQjPry46H/s2OCICZipECzAmenvAlYi/8HwKwGESSVRiiMK/C4jDiJ6SquhCgi81
 sVFTy43Y++/B9JHMPMomSGoEVjwnF/+Xge/FMfGNAhuwo/qRMCZQU9/CL8S/1VtG5xSkRu5ySiE
 eLd1RjqQSjteA/68r3+VOYJZuF/9fdVIbG1zQJ1zrZw==
X-Received: by 2002:a17:90a:ee88:b0:353:3f04:1b78 with SMTP id
 98e67ed59e1d1-353fecd096emr470467a91.4.1769491043806; 
 Mon, 26 Jan 2026 21:17:23 -0800 (PST)
X-Received: by 2002:a17:90a:ee88:b0:353:3f04:1b78 with SMTP id
 98e67ed59e1d1-353fecd096emr470454a91.4.1769491043445; 
 Mon, 26 Jan 2026 21:17:23 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:23 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 16/33] i386/tdx: finalize TDX guest state upon reset
Date: Tue, 27 Jan 2026 10:45:44 +0530
Message-ID: <20260127051612.219475-17-anisinha@redhat.com>
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

When the confidential virtual machine KVM file descriptor changes due to the
guest reset, some TDX specific setup steps needs to be done again. This
includes finalizing the inital guest launch state again. This change
re-executes some parts of the TDX setup during the device reset phaze using a
resettable interface. This finalizes the guest launch state again and locks
it in. Machine done notifier which was previously used is no longer needed as
the same code is now executed as a part of VM reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c        | 38 +++++++++++++++++++++++++++++++-----
 target/i386/kvm/tdx.h        |  1 +
 target/i386/kvm/trace-events |  3 +++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index fd8e3de969..37e91d95e1 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,7 @@
 #include "crypto/hash.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
+#include "system/reset.h"
 #include "system/system.h"
 #include "system/ramblock.h"
 #include "system/address-spaces.h"
@@ -38,6 +39,7 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 #include "tdx-quote-generator.h"
+#include "trace.h"
 
 #include "standard-headers/asm-x86/kvm_para.h"
 
@@ -389,9 +391,19 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
     CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
 }
 
-static Notifier tdx_machine_done_notify = {
-    .notify = tdx_finalize_vm,
-};
+static void tdx_handle_reset(Object *obj, ResetType type)
+{
+    if (!runstate_is_running() && !phase_check(PHASE_MACHINE_READY)) {
+        return;
+    }
+
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+        error_setg(&error_fatal, "KVM_HC_MAP_GPA_RANGE not enabled for guest");
+    }
+
+    tdx_finalize_vm(NULL, NULL);
+    trace_tdx_handle_reset();
+}
 
 /*
  * Some CPUID bits change from fixed1 to configurable bits when TDX module
@@ -738,8 +750,6 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      */
     kvm_readonly_mem_allowed = false;
 
-    qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
-
     tdx_guest = tdx;
     return 0;
 }
@@ -1505,6 +1515,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    TDX_GUEST,
                                    X86_CONFIDENTIAL_GUEST,
                                    { TYPE_USER_CREATABLE },
+                                   { TYPE_RESETTABLE_INTERFACE },
                                    { NULL })
 
 static void tdx_guest_init(Object *obj)
@@ -1538,16 +1549,24 @@ static void tdx_guest_init(Object *obj)
 
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
+    qemu_register_resettable(obj);
 }
 
 static void tdx_guest_finalize(Object *obj)
 {
 }
 
+static ResettableState *tdx_reset_state(Object *obj)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+    return &tdx->reset_state;
+}
+
 static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     klass->kvm_init = tdx_kvm_init;
     klass->can_rebuild_guest_state = true;
@@ -1555,4 +1574,13 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
     x86_klass->check_features = tdx_check_features;
+
+    /*
+     * the exit phase makes sure sev handles reset after all legacy resets
+     * have taken place (in the hold phase) and IGVM has also properly
+     * set up the boot state.
+     */
+    rc->phases.exit = tdx_handle_reset;
+    rc->get_state = tdx_reset_state;
+
 }
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 1c38faf983..264fbe530c 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -70,6 +70,7 @@ typedef struct TdxGuest {
 
     uint32_t event_notify_vector;
     uint32_t event_notify_apicid;
+    ResettableState reset_state;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index 2d213c9f9b..a386234571 100644
--- a/target/i386/kvm/trace-events
+++ b/target/i386/kvm/trace-events
@@ -14,3 +14,6 @@ kvm_xen_soft_reset(void) ""
 kvm_xen_set_shared_info(uint64_t gfn) "shared info at gfn 0x%" PRIx64
 kvm_xen_set_vcpu_attr(int cpu, int type, uint64_t gpa) "vcpu attr cpu %d type %d gpa 0x%" PRIx64
 kvm_xen_set_vcpu_callback(int cpu, int vector) "callback vcpu %d vector %d"
+
+# tdx.c
+tdx_handle_reset(void) ""
-- 
2.42.0


