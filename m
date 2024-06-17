Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22EFC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Yh-0001UI-TX; Mon, 17 Jun 2024 03:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6YS-0000ph-PZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:29 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6YQ-0002Sn-WA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:28 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6f85f82ffeso86058566b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608405; x=1719213205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhKelacngo3+27BBQ2bi8+2Xt3BwJYNr5sZIoXjck/k=;
 b=ihVUpJ0qtUgU2h9Sw/FJZRsqSGQOP/IShwbad5SKcoV7Jt0clyjm7cs6uBezPrhsFU
 wMOgbf3pnbn+QzOtANVsVzW6YPBQzrYmKhh/JbY3h8ulBbSdSzOx2++6XEOde2ZMhoYX
 ALmkGVCdem1DMFvD3GNxVm1vE9xQKe4lNeONcstKYsDrUK2zEKFO+Rxqgum4GMhNBkyh
 jLYcArY59ps3dMzocJ+GomDhVUhc/q9EQA87S1A9Z6iFKFDA/W43aTx0E0ngFjHipwCJ
 eHKMR57E1E9BfP3/uvBGSOP0NDasioEg4J4tUnYWNh6G5+quv72H2hMoHXv9O8PcUWne
 vn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608405; x=1719213205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhKelacngo3+27BBQ2bi8+2Xt3BwJYNr5sZIoXjck/k=;
 b=sbm6D4XFtj8q7yrgKB032rBY5TOfRRcuMB3ErmPjY+g9eBww5HuASNKpft1DJ9tA9S
 Gf0PckXVgyK8nwXd4/mNQDCKNNsPWB5On8mkgZUtg+owRARLMgBcuq+6GDw4emYfuEsz
 WQOQ190y4/YSo8RAqVec1BPHcI3EAqMok3uxVOAvh5b0w3hFfgWOz6uBUdo3U4L7s2C8
 m2X6qUrKY3jwOmwWXAnmz5fHi/xoqXDpFkswik66Qwv1eKQlaG3XGtPChuqkQxQDCQuz
 PNo7JfXwiYgVIC2FDLxY48ba2B+DuIh9cyCrE7rc8o6njp6fpa/3pv5CeuH35X+aIMqc
 PfMQ==
X-Gm-Message-State: AOJu0YwUFHteGrad50/AcUq3fcicRjv7yeqCeLKVIfg4a3yXl0x7ys1z
 HQIs7rO5XwKNDvvmBXxt/ywsdZ40xNyb2jMmiLTDDVTr6DTpfAeRX3WTFXYdo87sQz0P82SQCjz
 lyxI=
X-Google-Smtp-Source: AGHT+IGaZ1Pk8pRJ8GE/gGV9ybFjkJVV58fGfsQ9msteol9Tz4OdHRVqAzYNoGoFy3fHDqg1epDDcA==
X-Received: by 2002:a17:906:2c0f:b0:a6f:4a1e:8ae0 with SMTP id
 a640c23a62f3a-a6f60dc1eeamr559030866b.57.1718608404872; 
 Mon, 17 Jun 2024 00:13:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41adesm482236966b.165.2024.06.17.00.13.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:13:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v6 22/23] target/i386: Remove X86CPU::kvm_no_smi_migration
 field
Date: Mon, 17 Jun 2024 09:11:17 +0200
Message-ID: <20240617071118.60464-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

X86CPU::kvm_no_smi_migration was only used by the
pc-i440fx-2.3 machine, which got removed. Remove it
and simplify kvm_put_vcpu_events().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.h     | 3 ---
 target/i386/cpu.c     | 2 --
 target/i386/kvm/kvm.c | 7 +------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8fe28b67e0..bba1d73aed 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2107,9 +2107,6 @@ struct ArchCPU {
     /* if set, limit maximum value for phys_bits when host_phys_bits is true */
     uint8_t host_phys_bits_limit;
 
-    /* Stop SMI delivery for migration compatibility with old machines */
-    bool kvm_no_smi_migration;
-
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7466217d5e..a5af56405b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8283,8 +8283,6 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-                     false),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 912f5d5a6b..7ad8072748 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4474,6 +4474,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.sipi_vector = env->sipi_vector;
 
     if (has_msr_smbase) {
+        events.flags |= KVM_VCPUEVENT_VALID_SMM;
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
@@ -4488,12 +4489,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             events.smi.pending = 0;
             events.smi.latched_init = 0;
         }
-        /* Stop SMI delivery on old machine types to avoid a reboot
-         * on an inward migration of an old VM.
-         */
-        if (!cpu->kvm_no_smi_migration) {
-            events.flags |= KVM_VCPUEVENT_VALID_SMM;
-        }
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-- 
2.41.0


