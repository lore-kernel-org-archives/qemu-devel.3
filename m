Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C867EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9l-0007px-0h; Thu, 12 Feb 2026 01:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9j-0007pj-Dt
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9h-0005GW-QP
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=Wy78EA60hTkWSyYoslH8x+mV0+WazeYatzk6feFygGTf4RvCzB2rc22DsMeAWKakSC7swM
 bD6PJi41EVKvp0gPwxTMUidj9RkXKGs0kzW8+AK93cIUA9wjmt3L77SquH0ihCKFBL0FlY
 ARSkNEJZ9PydeW9OmgNCgM1kGnoKLFE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-yRju11d6O6iIUIt3XRyu-Q-1; Thu, 12 Feb 2026 01:26:23 -0500
X-MC-Unique: yRju11d6O6iIUIt3XRyu-Q-1
X-Mimecast-MFC-AGG-ID: yRju11d6O6iIUIt3XRyu-Q_1770877582
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c6e18f1cb86so2858451a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877582; x=1771482382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=MyVhMt45e1UmGbS6JkPJtVmyi+4IzQnm9K6/2okfG4LKdfw1U60G+30oZFo6ti77rn
 xh/HPG+9fIF31svg01Cr7mI5aY8WR+ecCiFH9jVy3fu/O1wF5bEI25gtnfwvGQVty4Tj
 oJJeE+eiNq+tzyajwfrZSCw7eyFYRIlB4EnMmpsrd9oPqwStGQS9Fwmf2OAl6zUIEN0D
 I/IIVQqojpQP6LDIugGQpKkGgeBkKp8ySYZlqMMfU4ii7OwWtQki2QDrQUuwMiLvptxe
 Dzl50TCBOzsiFdrJ4KIKDFD+umTkSn0web2BUPAcXGhatBgVlsbeTZbTF2T+Tr8Zumul
 GJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877582; x=1771482382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=ReJ0jzvU+0JsQz39+dwOZj+75Tg9fMlE83Q1avusMEdPJtx8fkrjHU9R090OzfHaz/
 YjvEClvNd62rSvWS/I1CU318PS04McDWlaK23XZRfj+X42rzh6iNIpRLeKSgBjy4aQtJ
 IfydSTUl6LCMfoD7p3+FhMNo6gqlL60CBtrtlVlxPHrFpxzn7Y9rfk3oKg3v/i/KrgYS
 w/2OZbfuV6C6iMdoNcTPKUMruTpFTdp/R1t5OaN4jC5s2RPAsAtILDiGW+zlrYYHzJU4
 IQLk3O4cVjCsFdVBRLDQHPbaV22cn0EVsGlrFZM2o45z7homvd9uvMoOmQhv7BeuFlMA
 HuVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqeY4pYIngRxkR9KqMF/FrkttEKZkLo0Bqqy3gSbo8xY9DfEtnYPdyiDgDzh/iirWaxpJcCC1ZfUsb@nongnu.org
X-Gm-Message-State: AOJu0Yw9O6n8O1e//HUsLDV9xdIeDyiQrd+RGoy/iMC9hKypC4YKYzT0
 lhZDLd/PPq2+zrchmRh+LXkG2ONuTwJRTPg1rwIz2B7w8Genu2yxKbonVyq6aVgWh14Kbbl/C4O
 sBTwikl6bDDmg2uYKgmj/yhFXype0x/iG8AjwzEtztz8u7MWiT4Q0hb8T
X-Gm-Gg: AZuq6aJ4jxk5b3/mjyA/9NYG/rgz6vr1pBHzQGSqWy7c5BfnNMIme9b6rj0yyRot5Yz
 16C3Xj3n7V1UQvgJoYHIMLyK4KjFyJb7ZoxwFerDTGeAaODEhpIXW0lAl6ucMnHifefE0DS7R+7
 7pHpBMf1FI5UNjdNcYsv07ybiWJRUaeHMEU7YzaIRv0Zn+oGeCDpqbbGZoydpNilvLiBb003Hmd
 UjCbxceIG/Pc/+ljOSBQQx4yveimp+kPyphKmPE7gmz8HzTR8PCfUuwVVeGf7XDsixkiT/EwiMd
 hdP5D59IjxuKWwg19wR+i7qQMNPypH/Q+WUNGS0d8oisrUqMAw0t9vG2x1b/IvwGNYJC6WuHbql
 S7aHRYsurRyMJWjy/jPOnEXglOom+pXzEmKaBztyze1SXISL+oNEtvgA=
X-Received: by 2002:a05:6a20:2454:b0:366:14ac:e1fc with SMTP id
 adf61e73a8af0-3944897ea14mr1768766637.78.1770877582401; 
 Wed, 11 Feb 2026 22:26:22 -0800 (PST)
X-Received: by 2002:a05:6a20:2454:b0:366:14ac:e1fc with SMTP id
 adf61e73a8af0-3944897ea14mr1768746637.78.1770877582040; 
 Wed, 11 Feb 2026 22:26:22 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:21 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 15/31] i386/tdx: finalize TDX guest state upon reset
Date: Thu, 12 Feb 2026 11:54:59 +0530
Message-ID: <20260212062522.99565-16-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
includes finalizing the initial guest launch state again. This change
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


