Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93726F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vc-0008P1-Ps; Tue, 24 Feb 2026 22:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5va-0008E3-LO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vY-00089h-T6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=TPX+2qm2O89sX3Z7gGiAhyrtflCFMIbpYLJF8/ogoi7V9nbHU3pQUlfbz5WftK5QrO1caD
 CBMes1M+/zWfks9jtdFFr8ujitDD/OuHiAfnir4AVNScdAIkRvI8jCdfGIX+BUMNRnKS69
 E1NCcKe5bbStqbXdnXJ5chaGS+Pa9jM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-H3FgKY6jPH6Z_3IKtlJnlw-1; Tue, 24 Feb 2026 22:51:06 -0500
X-MC-Unique: H3FgKY6jPH6Z_3IKtlJnlw-1
X-Mimecast-MFC-AGG-ID: H3FgKY6jPH6Z_3IKtlJnlw_1771991465
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c72d23dfso37499421a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991465; x=1772596265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=HN7aQDOoBUaESGkIJseKEuYnLy6o8q/uzhcV0DTpsU+YNlZ2RH5dYDQccrGzGHq/CW
 gRdZ2tU2sfot+6VEE1amvAhI1JVhYS+0A2cgDGnneELE39cXPlv+u0DasFb+dX9UX49T
 rBG7nos13wyNQdE+IBz4e0PXiIL7/3TLba4X65LxPoUEZdnG8z9to5yi7qCtGL1wq1HY
 BvoFkhV2Fi2Ivpzlrj6Y9ExQwgk2PI4vY4O0c02a672top2zSnskhttnnMk4xPftY34Z
 xCj8JIDAZpqUpy/bnPMSVnu/sjM0HlaPMCTp7GmwjPs2c49aeCWqWHn+7sMwmn2Bde35
 9cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991465; x=1772596265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdx//uhe0dGZAW7ELRMRtjQOSKo80AjzaA5Q7pgL+h8=;
 b=EL+8T6XNZdSM80GCB7XcKmsEBDAUbXc7WQC5VCQFY1kMyCQiRAbGMcRKX0T+neuqd2
 wAjk1AyAt02nQsChbFT21Vui3dt+2XXfIHOEG1ZvKJjA5pn/Gh/XGmYlbD6JQ/+Gc1m1
 sD8BxRHI4gtfsuB2gv4mCtPsut4r2RSbAuV0IKH5A210J9HyTZPgi2Ul0ORBY9EkmMdz
 YHO2cJEzqZaVc4mILk9VpZi5CdkOKwPSTWo9e5yhrDHT19w7asSEvFL8NOQeawYmuPcp
 yb60LyxrJZTyVlFwL6jO9qHUk2z9wfmLVzq1GHdYHule+srjaEn3g6H8G7tpN7nuk7Rp
 SXVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZzEPTyxOB2ZqJ+V5AOK5uR7tTQlO9K9cjyyIoTiHKBLTZ1X2kTe5q4B7BgecMV+SWmZkhcv6jVyoT@nongnu.org
X-Gm-Message-State: AOJu0YxBnlPKONBM8CCxjTi+kih/Z2H3Luxj437TkP4uXMRbMSz5gLuz
 EP3a0kKlRGod/p3teoq8Bd9wCvmRF4OahhBKQV14FF6xOff46MbjQABLFjucj3Kk7+KIxn528Hz
 d8Hc2sHhlWB9gmpBZjh22/wYbbCUXkXlr/vNNmPiMCffX3KMXOPZLhKBL
X-Gm-Gg: ATEYQzy2rRqBKa02T8ktYuHdu1o5PBNPu1MKhfvS10tTUUijM+sO1Mrj/xUkohNT0bA
 g4+YSJ4/AMJWYldaZPmUmIro+2az6vNzxy61hBYwJulq6kh8mld3cCR4RiUhvEJ9cJSdls2QG8R
 1zm0ZaN9ZsDMH2oh/19EyWJR0eHwxQSP3CcxEjLB5Z8a4BBYADNlv+BZ1KvE4sh4p3uiKez15K+
 ASnYtNP1G01m7QKJqR/rM4NwPpiXgGH0i8ncHvIEZbQcSjuOKYJCR4c/qfuowDlANQ02kvIZu8G
 O+C/Q026PQRvK+hTjm5vPmhG14BaTJZ03mDHNVp6/kDDsxOOZZC+CmgASBgVyYZy5mmKeqI5o3t
 UZGJWvvUbx7XKUmaYRe0pkP+N7Gilrd1bzSKjEEu/MpIr+/nwyCXaZyg=
X-Received: by 2002:a17:90b:1b05:b0:34c:2db6:57d5 with SMTP id
 98e67ed59e1d1-358ae6be0e4mr10612271a91.0.1771991465448; 
 Tue, 24 Feb 2026 19:51:05 -0800 (PST)
X-Received: by 2002:a17:90b:1b05:b0:34c:2db6:57d5 with SMTP id
 98e67ed59e1d1-358ae6be0e4mr10612249a91.0.1771991465011; 
 Tue, 24 Feb 2026 19:51:05 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:04 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 17/35] i386/tdx: finalize TDX guest state upon reset
Date: Wed, 25 Feb 2026 09:19:22 +0530
Message-ID: <20260225035000.385950-18-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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


