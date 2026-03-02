Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25448D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvs-0001GX-Le; Mon, 02 Mar 2026 03:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv4-0005n0-Rp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuy-00020B-9B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NY3ePzWlUb0GebemqhYkrEXwQ+wMFMJn6LRZG4Qy/0I=;
 b=J2xOVBEpQPTLKj+YKTLmBlhravAeMm/QoBqmo2q8ugP1bYVhZcGitqdpRloorHkggWewwP
 0cX/GZCBvDzvEAA8YmD1dBtcEeuwLUNTy43Uuim7FZTFfk7c20iSQ2ysZ38soBMEzeQsVU
 uzOXeO6aihor3iCLVASJ5MdSMuzUaI8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-k5pkeFl6ND6hNKn_kKEHhA-1; Mon, 02 Mar 2026 03:46:16 -0500
X-MC-Unique: k5pkeFl6ND6hNKn_kKEHhA-1
X-Mimecast-MFC-AGG-ID: k5pkeFl6ND6hNKn_kKEHhA_1772441175
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-483101623e9so39420655e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441173; x=1773045973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NY3ePzWlUb0GebemqhYkrEXwQ+wMFMJn6LRZG4Qy/0I=;
 b=Zpq4/yUt8jsdAlc602REQCC5iYJFjLFQ1bI/5mTGlJc5+FjxrisqCj+a4++p7lu1T0
 aH7pWzyOOH+bUZmGIOsrBALhzGRMz+t92WJxqmkfPug0x38heqObumDsd/+y9kot03T5
 uop+w3/d9N65g9eZK8EjLNem6zUemm4VvYeTAGazHFQeQ9UerkEQo8Yv5MI2vcXREpvo
 cXNd14nwts2tubvNeAai3DHf3pQWrnHVT+EFHH5XwNKdJiigwEK7P8wtbfxyJWMhCZAn
 d6lhIsY9CqC6FlidoOrCr5rG1GTJJLQEHdwAn4QM+A7JWiuMbrVgwgxM69iGlljawOz1
 05rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441173; x=1773045973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NY3ePzWlUb0GebemqhYkrEXwQ+wMFMJn6LRZG4Qy/0I=;
 b=muT67JqDOGZ1bpQPJ12l05zErS/yWkdeumxeAFstCkuWBCCHgIQJOjUaudh7i0bCm4
 JB4ZqPRJ0rACSJrnysG5wrb9gc8UoKlLqGYCmeiwIqOrCIy3Ldstyy1OqFdZDDVJbIt2
 6GW2eTAwlv1+nZ2Onjj0A/QHy1TckHXHQZ9zs49wKiU1esRDxNDfPFBIgKLHZdoSAVYA
 rHeQgzDz0m2Nk0ME3s/0jsZSnrf2q5h6gsRlwA3QkEUPvzHVQkPw5IqvgmUIcUJlLwYZ
 Osy7B8ISJWOxxfzXFL2B6Bxc0PXX2h2dFdHrSfEZ9tQyVaNnFic5ahjkiHls5IVkRn3e
 vRPg==
X-Gm-Message-State: AOJu0YzCvCJnT+VK6yXt+Iuc2KbFMSZTPvBxEvBx/4A2o9LseaW+nZnn
 /dVEZQwdvqYVuMHs7R68kUHyBE5Veh3wo2K/0M0ZSfr/XVxQwz5SHK1F2phD2NMSQvrRrMbTcRL
 7OYg6G7PbgNNoJJMVTNcqgWetyQOXjTrWi5nWJdnUCo0H1hSD/n2A/u5dANZ7CQmasvxCmm5nwA
 wJeHc7cuDjzH0vtng2OdOudM7xZ3gOC3TjqOUuNjvO
X-Gm-Gg: ATEYQzzCwZqAk8iyjpf1j+4YcgPGS/xf/IbrFQX1kX9EOE+gtTABIsRCVFap3YNqLeH
 2W6LQdYudCP3iPrCZTBVkviiEsv/zvS46SoSCUGrTyRTq7/hh3znbfyh7hH59Jq8qkG0GbRRA5f
 +A1Sov9Tsx1yg+XwrlVbJ2MgIDV1aRIXQtrr6UQyk3iM4EsHqQ2T1ZzIyqVeJoB/d3X7x3+fLDc
 nc8M9J3PJFOHHIfp54/ccn5EbTmjk2/2aWygwjVYNkP9QP8xHQGKB+wUl51iLHNzdZO6lbAVy/C
 mIYZ2ccCijHQp32taJk0PyInUg2hxIXDBnj3Lm7+vFvBdxA0eeKK/4br/4lMvOn6Pm3Ny0nHn1e
 IWhRjHVKZSU71Bas9GrKLl7jOPhyJAbEZ4QBcbzDtL45EaynxXLF7TSVq9M/e2zvbymsDJ4zozN
 ExSzMV9nY3BiF6ASAnn84b87Alq/8=
X-Received: by 2002:a05:600c:3f16:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-483c9c22e11mr198910375e9.30.1772441173538; 
 Mon, 02 Mar 2026 00:46:13 -0800 (PST)
X-Received: by 2002:a05:600c:3f16:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-483c9c22e11mr198909965e9.30.1772441173051; 
 Mon, 02 Mar 2026 00:46:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ba2a5970sm3360623f8f.33.2026.03.02.00.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 058/102] i386/tdx: finalize TDX guest state upon reset
Date: Mon,  2 Mar 2026 09:42:53 +0100
Message-ID: <20260302084338.473368-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

When the confidential virtual machine KVM file descriptor changes due to the
guest reset, some TDX specific setup steps needs to be done again. This
includes finalizing the initial guest launch state again. This change
re-executes some parts of the TDX setup during the device reset phaze using a
resettable interface. This finalizes the guest launch state again and locks
it in. Machine done notifier which was previously used is no longer needed as
the same code is now executed as a part of VM reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-18-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h        |  1 +
 target/i386/kvm/tdx.c        | 38 +++++++++++++++++++++++++++++++-----
 target/i386/kvm/trace-events |  3 +++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 1c38faf9834..264fbe530cc 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -70,6 +70,7 @@ typedef struct TdxGuest {
 
     uint32_t event_notify_vector;
     uint32_t event_notify_apicid;
+    ResettableState reset_state;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index fd8e3de9693..37e91d95e1e 100644
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
diff --git a/target/i386/kvm/trace-events b/target/i386/kvm/trace-events
index 2d213c9f9b6..a3862345714 100644
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
2.53.0


