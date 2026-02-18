Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15292E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfyD-0003VZ-Ay; Wed, 18 Feb 2026 06:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfy0-0003M8-Eb
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxy-0007tj-RD
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=fq/GYgortbxGSeyquXaV7/wQ+81UXESRs+J2LhCcTjMy7xNMEQWcT7u9x2iyAm/hHg2+0e
 Gl3UHo+ydRDWteeZxXCChMKA2Syr2fbUwCe1WAEpp5ouOe8nSaCq9z15tKGZNMUmhzirJa
 n9ROktK4wVCsWwZLlpH5o6TX+CLhjOs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-0Z29S5MgNumk-8LdIZ53Uw-1; Wed, 18 Feb 2026 06:43:36 -0500
X-MC-Unique: 0Z29S5MgNumk-8LdIZ53Uw-1
X-Mimecast-MFC-AGG-ID: 0Z29S5MgNumk-8LdIZ53Uw_1771415015
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf2ce5d81so62267745ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415015; x=1772019815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=oPR/OZFjnstXS3nqEnggTLM0YOUOiGvzChUG/MUgQu+FZQBdXdpUcCm8gLpiw50+7q
 wWzX7hZ7RNx55drKrmXmNgz/dp7TZmWVnDAZHScVgRirho8PMOMQVe3TfJx868FqONWY
 5SW9PumJbB6pLLhi2QYwEdGn4EW7oOr8iDdYxEg3cRxI9YEyBguRUSwAjuC3frpe41U7
 YZt+ZbXaSUqEdMEo/fBVkntZHWJeGA2zueeOWoLV6f/dYL3XIsPxi11qBH3s8eawKUp4
 /YH5qHtgNkEQWyunxLqqypJnMYetWpvy+DTQPJeMXd5OaDkLTPFJ7aO9TFsDA0g1PNkD
 fhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415015; x=1772019815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=Aeac+Q6dxO/GkPamFuCNglZOQfk92Y8pSAJttS9764HNXMtodB6mPAlglonzR2sTHB
 utALFtUjgBXi5o61zHp+CVjl/t/bpIv9H0X8ghrSuJfbeMsVoX9Z5FMX5AB1lr8HkkB7
 Cy/BwmQb+qjGwf9cL23sHMt5P7A6Rvn/yQm7NZos2Mle9Q8UKfHG/wl37s07iO7dSyD3
 dpl7GCH8s5ClMGMQ7VkxzeyRx9c+67M3BaR7jR3Yp7NlnMdHrEBh2z19Ivk3G25IOgBJ
 aCpvClNmMmR/rsfEQ3Z1718G3YHE2woclEsxkcZjDU02mn5CdYHzlQwBfzvOASriB9Lb
 PWUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZWRPmlxt88D8eJ/JM872iBj6F5TJcmfRfVv6FywYYXwQtNdn4qv/s9CYvTwDQWs4BRemvwKvLNQ0m@nongnu.org
X-Gm-Message-State: AOJu0YzP1TMv1WOWsn6PpOK/1zhMUz9FJltj390QVnJBYddID0RvPqqf
 Rk7GZ1mvhGiRNDdE2ARpXOtM99HeNk+cwYN1h0T2SvvsYpCsvHj6lwzvUdtehAU30nizbkMhZe1
 4hqpFqB4s4/k2tOG5k9fm8iz1L/4y0ZUO3Vr2opUkfOG2KeBfjLYbj9A+
X-Gm-Gg: AZuq6aIR1Yqbq+CvciCBYBZwvpWGHWC2hWdMXH0UqA+G28YI4Sutbkb7pO6QgDrlGv3
 BbK/227tW9BUg4kT7noVxrLTeMaU3kLsmW9sc3GQaCOIfK07BIz5V6U15x1ZEiRtPDsscS9bugB
 5Ds2APAAbg220pEMAXH5dmzoHbUu6Xm1gEeg70Ps2Cu8rJ3XyzYDkeyZFyI3M81X0MGkUZj/zz6
 sr19IOTmGhqlvePykG7TZfwOajzsgj7BM7ax4opyTPJnEqsmATDEbppty9AktCz9sJyy9gM6FZE
 hEzbr0zKNC4le5CBSaixtsQ/ZT5+ShDk4xyJN6CrrGalBcIg67iM9ZGJuM9vHIAPk/0I+mAfibl
 1M7pU8iipzm871eIZEzFF49ZOPMSLRU1fkW7UusUezQRkTgWtLNPS
X-Received: by 2002:a17:902:e5c8:b0:2aa:d647:c312 with SMTP id
 d9443c01a7336-2ad175c5952mr155523725ad.61.1771415015238; 
 Wed, 18 Feb 2026 03:43:35 -0800 (PST)
X-Received: by 2002:a17:902:e5c8:b0:2aa:d647:c312 with SMTP id
 d9443c01a7336-2ad175c5952mr155523515ad.61.1771415014774; 
 Wed, 18 Feb 2026 03:43:34 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 16/34] i386/tdx: finalize TDX guest state upon reset
Date: Wed, 18 Feb 2026 17:12:09 +0530
Message-ID: <20260218114233.266178-17-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


