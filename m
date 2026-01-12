Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BED4C9EC8E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHui-0004aZ-TO; Mon, 12 Jan 2026 08:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtz-00039p-6k
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtt-0003mo-NI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=re0muZmMrtqo8EWO5a5L2LHVK2cH9w5XVHhtUQzVCdc=;
 b=VvYyC24BdqmIrXz7Drcs7jT5i4u2nk0zQFCMvAx0ycanW0lzfaOfiI6j8dQ/agxNHjlRzo
 5nF+nlsmKL3UNQBwLFWVMq4ZQ/LrjwlDwxG36CYVYbDZawqCR7ES9ft+xjD8TbsxBOzxlV
 SZRfRgLMSqj6ErtGeHka1NiM33am/S4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-01dExezYNliTDv5FfB0VdQ-1; Mon, 12 Jan 2026 08:24:04 -0500
X-MC-Unique: 01dExezYNliTDv5FfB0VdQ-1
X-Mimecast-MFC-AGG-ID: 01dExezYNliTDv5FfB0VdQ_1768224243
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c5539b9adc3so1865634a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224243; x=1768829043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=re0muZmMrtqo8EWO5a5L2LHVK2cH9w5XVHhtUQzVCdc=;
 b=j/oDPFOX+wBnykqgnCNgZ8jbQzwxFeLIGXussIT7sxT3SyYH02ZdP5Rpf562ge3dZl
 3ArIPh/ISAYN7CXaCMsUph7f5OFtlSLWIatbhE+x9r62jy8FwqwCeQEAK99WHKFQtb96
 ymP8CeN4BDlalqbcYn2WYOjctz0QndLpwYRSy8i9nlfZuFdn7iffKOqzf7VP3zh3vvi2
 aEZVDYoLegEOp/gvjctLzwSDQ7jhg4w5ME+YRBKvtH86ziDlYr3fWJrcK1tY9CLbOSvu
 3JdmXma2PIobWqKNH2mQLAiOTeHCwGX3qgzXbVbAH+71HlR1Cc2n1Ke3fdXK02tAAyAL
 nZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224243; x=1768829043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=re0muZmMrtqo8EWO5a5L2LHVK2cH9w5XVHhtUQzVCdc=;
 b=WS1FbCcnDi+74uKHZhLFzq6+FPJe0AyWQv2QCbY8khZTP/FzOOn1itJplyuT1pkZS4
 pCZ94BtJ+VT8QcPFqSf7sO/baHAjfF89v4Np/b/F/vbRiQN/1GaRgQA6Se6MqCQxWaF7
 QIhKkVqqQ0+FzpFZlajlr3mXrtClBCisqG6mu6tpKJ4vsdvJMgnVZgdVivEcsA9eoMHf
 tXIUGS6f3D5hBVCfx0+90iti/8++041pZz9SPyBbHaY2Ol+0o5nBDCPfNinnzztV8lZq
 pBrJXX9fUh7VLi8aeZ3UV0E4Rj8UT+qjGbgOU2IL+xFmTw3y2LZ3AOrzbjyQIwLd55p9
 WZaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0YgQq6Rhd80KNBufkow0B0xptiWB1No0cmMacZGzAf7PhJCfIsuC3DpQ6JeQAzeNC9yeBaIIZmtPG@nongnu.org
X-Gm-Message-State: AOJu0Yz1jmLoH9xTXtFrZ+Wx5C1YB5eIP/kq93cWm91ZQhUhcoiW4fWR
 XggYMUYNb1f/g94NY6VgSjHUnEUHIdq3RpsmFBPjwh16s0G6Bd1SOkzE/QtzKlfSdGZbKL5IdnE
 SRlWs1lbtPHTULgx3Zeyq8Njufk7FZ2gnTGe6AOGOhTowaISvNzBy9QLZ
X-Gm-Gg: AY/fxX7ANjntdNv6Ur+GztSgGIQtjBCKRH4flb87nBMwbKUnbA4kcAHa1reE2yY8slD
 7qsi1IFcDHPwlR1TTDD/w9q4QT6ZqOMJQj0aZ8soOdwDqBnHtEHgS/1M4ySI+oxE0NDSeiYIbxB
 NNRY6fMdIiwqiGaG0R+1q8MfD+ALt+O87cTiLcLYxgDDtGodAgiPDnavlm+9Xw0njdZroVY+OmG
 4sHgzPQEEJosziiBy6lFEv9b6/OgAMpaDcI4m7eWyFivqTIJySRAfiMRZEzJNNoDf43WcbVSwW/
 cgbjRJ9dvccKSzhi7uuw/o/iLr+lyZgQ7wdNEncZ9+dR4Xvu2B7Xz6a9jbHLXY9vQffapvUuyK8
 bczLu/WXfgWpJnIKjCp2vLfYk1qo0NXlJmyVjlZIusKE=
X-Received: by 2002:a05:6a20:5493:b0:366:14ac:8c6d with SMTP id
 adf61e73a8af0-3898f9cf622mr16237020637.67.1768224242888; 
 Mon, 12 Jan 2026 05:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjz1PJMGZym0PSu5C9k8ojaJS95nPXlOCAztYTfHj1g2CJ3fKTkb5Z0vZjd85rOHWGK+xRjg==
X-Received: by 2002:a05:6a20:5493:b0:366:14ac:8c6d with SMTP id
 adf61e73a8af0-3898f9cf622mr16237004637.67.1768224242460; 
 Mon, 12 Jan 2026 05:24:02 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:02 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 14/32] i386/tdx: finalize TDX guest state upon reset
Date: Mon, 12 Jan 2026 18:52:27 +0530
Message-ID: <20260112132259.76855-15-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
index b595eabb6a..cba07785f7 100644
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
@@ -1538,20 +1549,37 @@ static void tdx_guest_init(Object *obj)
 
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
     x86_klass->kvm_type = tdx_kvm_type;
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
index 1f4786f687..47473001d8 100644
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


