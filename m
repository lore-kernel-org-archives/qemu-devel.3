Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAC2C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBh5-0004cD-55; Wed, 29 May 2024 01:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBh3-0004YK-5m
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBh1-0005Wz-2H
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-354be94c874so1331612f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959861; x=1717564661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz6s05/IrF+4uE8X51O0iRSZz1ji8UGQu3fhLSYvF+k=;
 b=t7JArrjzogm33zgqr769FSyva4zPzEmrMkm/sgu7FQ127JXHTQtRjzNerYHQRlhca7
 GQVpvK/1AiYfm8HedKBIe73z7UhEw/3X3Eok332ajgHlYAf0Y26nS94bNnpq+vS889PY
 oURxG+gdn6nB3b6J7m7lOTd5jick3AAFBk5JcXEj9f6q4Eqc813xVIFmnLsKeK2T2RNZ
 fr+NB0kXt2X99AJnNTNuhchuXCAEyZ0uWI62P95wgSzl1S4d392BTkR5ntAxSSYrvWSh
 IhGzPyBCuGMVk+xZs/piJygPDC3c7SSZvOTRpbnNoOsrlZjOYC3J4+uH/EWMSX7yEzMX
 CA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959861; x=1717564661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz6s05/IrF+4uE8X51O0iRSZz1ji8UGQu3fhLSYvF+k=;
 b=RNyT2a7l0ksdol9hhsYX70tMdQozaE4QnB1jlAls7Y3nbD041MDtt29O6G7tVt5YOI
 Q7mqHmZQlQbD3S2r0nbEGPZQs5yZHAdcmlZgUnPIFATVkvaG+BHAJV/TU0M/RaqPQsK3
 bU0gZ9znnFHAqYpTp1QSjy4GTnLHmbq/ay5WE2NlSxWNrykWwY0y3rAyBEcTGe2hfav9
 PNXTCFSywL6Y7SrtNjMTqpNLOuHpFx6X0UfEz6uuGb4h/OiHl4GXBl72cNZH6WkVferp
 4RyFyDC62ayUKDr8ogMHIUEFW7tpcm6xAttNOdozBRm0sqqwSgRjcE4MM5uPgR+vTNyx
 VJGA==
X-Gm-Message-State: AOJu0YyatrOFv9lWswhKosM7i1u6LGJj0AsE1nevSqmhxjo5dFQICXqp
 CLRI/7OfTdr+E2BpqqRaH+weGG9lmvLcR9xde63DJI369cHqzOD80UMXM5iPDiKtgmMS07Gg5ed
 j
X-Google-Smtp-Source: AGHT+IG0ySZC/pv/nLs3SNQ87eN+be+Rr7ZWh1qgBiEZ5EiNqxPms9B033n0H8AwsKFJesiQRDnrQg==
X-Received: by 2002:a5d:500b:0:b0:354:f308:7cf2 with SMTP id
 ffacd0b85a97d-3552fdc430dmr15155584f8f.50.1716959861014; 
 Tue, 28 May 2024 22:17:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a09031esm13608645f8f.49.2024.05.28.22.17.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 22/23] target/i386: Remove X86CPU::kvm_no_smi_migration
 field
Date: Wed, 29 May 2024 07:15:38 +0200
Message-ID: <20240529051539.71210-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
---
 target/i386/cpu.h     | 3 ---
 target/i386/cpu.c     | 2 --
 target/i386/kvm/kvm.c | 7 +------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c64ef0c1a2..6951f48f86 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2059,9 +2059,6 @@ struct ArchCPU {
     /* if set, limit maximum value for phys_bits when host_phys_bits is true */
     uint8_t host_phys_bits_limit;
 
-    /* Stop SMI delivery for migration compatibility with old machines */
-    bool kvm_no_smi_migration;
-
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc2dceb647..2d972def64 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8253,8 +8253,6 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-                     false),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c864e4611..51bd9556f6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4391,6 +4391,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.sipi_vector = env->sipi_vector;
 
     if (has_msr_smbase) {
+        events.flags |= KVM_VCPUEVENT_VALID_SMM;
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
@@ -4405,12 +4406,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
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


