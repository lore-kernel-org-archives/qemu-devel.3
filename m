Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA0E77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuiJ-00021g-3f; Wed, 04 Dec 2024 14:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIui4-00020H-OB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:06:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIui0-00057X-MX
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:06:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a83c6b01so1067195e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733339206; x=1733944006; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ibIy2drWP56YRJu1nbNoc3IL9Q6+0UkelpHO9ibKjU=;
 b=u6CsgNI2XqYe8Km6wmuEf9jlFTDcSYqgnZvL2bFfqxBKI5Xv1xcoa8bAVMX7RqJUbr
 Jy6t8qor1ve91+ZAxCXyxpbqe2gCtCc6vyNO7yMcr2ySiRTZHyhc0HWRVx/f977vRcYU
 BgK7UHcBVkBlmD1eqPWu6BW5BP0uC7Xw2oV8XJnrrPWpCXWIgw3WLh5PP8VQ8BrmYqSa
 iA0eOcapcfCyTyGrOTOV7cHBJevUna5yeOD8IN+2dHARFVnk+qSABvUBSr3oxSdpQpDw
 pHm10b5eYWD2BGupkQzyyUBNZZZVZBwfBp7KxwCwxd+j+7mWdG0vzkbQKiGuiuhxAij2
 p6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733339206; x=1733944006;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ibIy2drWP56YRJu1nbNoc3IL9Q6+0UkelpHO9ibKjU=;
 b=D1wVpwejRIC6MJSMgHdyVfOTC064JHSM7uPh2sEMwZF1r122vm4tcGjnIzOES1nJwo
 ZLad2BAlTTsKdrQBlHSgdl7Hffh6/yfnbryVuloTnQLgzk8/hFiC8er2v3ZgC3eHVX3G
 TyX0zV0Gj1v5aVHqxCDg2mtN0n+ZCCVbqmIQ6BuJFZBu7Z7Ov0if6kBJq9t9F1pHYvuf
 +NInQ9xHQ4u/XzUQ7AziqCcy/cHEDAKbHpCcr4XzvcA5SlFF2JXK1gKZG+MpJrHTpg+g
 BMWzN0BpgXvp8KVtV6g69TcUcGB9Qix2PXnyiesn/UhhtIZdabGA7mG+XPV7sOSOvBHy
 bRmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX7dk/Pb/z6CEcNuXElPrft+HI+DozIpWh8thQqliG68yOT3GahUcmp6FNrNtgn85aF4Vml3HYO3qQ@nongnu.org
X-Gm-Message-State: AOJu0YzRHLeQXti9Dbtyd56PnKhzffZe5H7kuf+A5S+40ipajo9Vnhgw
 KFI96nO9B+fR5uucE4k5bxmgqZLKgkt6rvjMUyR2kmhrDHJDlJTKrMtLMoaopgU=
X-Gm-Gg: ASbGncsyjtRddGOTL9/3e2KjY4EqO8KC/qseVqjkYCzovrl8WQFOMrxosnxE8xI6NIJ
 GL8CJJxFjIxltg9Z6UxerO2nT6fFPw/tVjb/mlimAA8r/MGcaHmO1g8uNPFdFFkOquICyaquec2
 DJba3pLx9UGspBNlFUv+EbwNKoQ2vNGCpa9TX1DjCeHvGItyRQ0LY0Oyu33hO01Phbw8x98Egub
 3Og7+y5am8/DxsPf114UQ/2kK6M2pcByOZ9cJlLRXx82qrR
X-Google-Smtp-Source: AGHT+IFQTxPt1P+huYZnrYZ9Ew3tM5Ox2QrI9oPJToAe/ipqyTN+KqSlax2aZU/GU5HwiM9aJJmhIw==
X-Received: by 2002:a05:600c:524d:b0:431:5aea:95f with SMTP id
 5b1f17b1804b1-434d09ce368mr70376045e9.16.1733339205742; 
 Wed, 04 Dec 2024 11:06:45 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0bc7sm33384065e9.35.2024.12.04.11.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:06:45 -0800 (PST)
Date: Wed, 4 Dec 2024 19:07:08 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 01/26] kvm: Merge kvm_check_extension() and
 kvm_vm_check_extension()
Message-ID: <20241204190708.GA2349278@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-3-jean-philippe@linaro.org>
 <Z0W_LzcGOfoBveKA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0W_LzcGOfoBveKA@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 26, 2024 at 12:29:35PM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 25, 2024 at 07:56:00PM +0000, Jean-Philippe Brucker wrote:
> > The KVM_CHECK_EXTENSION ioctl can be issued either on the global fd
> > (/dev/kvm), or on the VM fd obtained with KVM_CREATE_VM. For most
> > extensions, KVM returns the same value with either method, but for some
> > of them it can refine the returned value depending on the VM type. The
> > KVM documentation [1] advises to use the VM fd:
> > 
> >   Based on their initialization different VMs may have different
> >   capabilities. It is thus encouraged to use the vm ioctl to query for
> >   capabilities (available with KVM_CAP_CHECK_EXTENSION_VM on the vm fd)
> > 
> > Ongoing work on Arm confidential VMs confirms this, as some capabilities
> > become unavailable to confidential VMs, requiring changes in QEMU to use
> > kvm_vm_check_extension() instead of kvm_check_extension() [2]. Rather
> > than changing each check one by one, change kvm_check_extension() to
> > always issue the ioctl on the VM fd when available, and remove
> > kvm_vm_check_extension().
> 
> The downside I see of this approach is that it can potentially
> mask mistakes / unexpected behaviour.
> 
> eg, consider you are in a code path where you /think/ the VM fd
> is available, but for some unexpected reason it is NOT in fact
> available. The code silently falls back to the global FD, thus
> giving a potentially incorrect extension check answer.
> 
> Having separate check methods with no fallback ensures that we
> are checking exactly what we /intend/ to be checking, or will
> see an error

Yes I see your point, and I'm happy dropping this patch since I'm less
familiar with the other archs.

The alternative is replacing kvm_check_extension() with
kvm_vm_check_extension() wherever the Arm ioctl handler behaves
differently depending on the VM type. Simple enough though it does affect
kvm-all.c too:

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..a56b943f31 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2410,13 +2410,13 @@ static int kvm_recommended_vcpus(KVMState *s)
 
 static int kvm_max_vcpus(KVMState *s)
 {
-    int ret = kvm_check_extension(s, KVM_CAP_MAX_VCPUS);
+    int ret = kvm_vm_check_extension(s, KVM_CAP_MAX_VCPUS);
     return (ret) ? ret : kvm_recommended_vcpus(s);
 }
 
 static int kvm_max_vcpu_id(KVMState *s)
 {
-    int ret = kvm_check_extension(s, KVM_CAP_MAX_VCPU_ID);
+    int ret = kvm_vm_check_extension(s, KVM_CAP_MAX_VCPU_ID);
     return (ret) ? ret : kvm_max_vcpus(s);
 }
 
@@ -2693,7 +2693,7 @@ static int kvm_init(MachineState *ms)
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
-        (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
+        (kvm_vm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 #endif
 
     kvm_sstep_flags = 0;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7b6812c0de..609c6d4e7a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -618,11 +618,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
 
-    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
@@ -1764,7 +1764,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
@@ -1799,7 +1799,7 @@ bool kvm_arm_aarch32_supported(void)
 
 bool kvm_arm_sve_supported(void)
 {
-    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
+    return kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
 bool kvm_arm_mte_supported(void)

