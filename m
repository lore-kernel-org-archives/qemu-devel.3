Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E01C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhL-0006lf-HQ; Tue, 01 Apr 2025 04:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhH-0006ks-64
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWh9-0005jP-AF
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso35401325e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495000; x=1744099800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOUfwVEN3xQycXHlRqTY2E9mL68SSaiI0fdupHWA/TQ=;
 b=ZXKy9IIRDy44Un1AITLOHZoOxDAzWgbWhTkC/MgL0fAvMi2T6FaryfiRNpTWhtkep/
 LTx2Z/gh5JUljs+emBqJl0XhWdhlHDBtpkP6x/ZOufYIic4Jld4ZH3Akxrtmjl0qgoB8
 DvI77zRyseWhTc9oUxEoawj2cyl5Ul1BrZMS5Fvh1ja/kbvKjDeW2pkzba3r6OzdXDyJ
 0CZFi64LT5k4DbdavWgs1556RXv6YMNTwDQI72pjT9b5CGnwC4dqsGn0jSl9fZR2/2WQ
 XHRAh6UrMfZqVtONuK4P5btyv0yx7ucvvt6x9aV6HSZoyVx10WGqR+wdrn25kaxufIQT
 eSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495000; x=1744099800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOUfwVEN3xQycXHlRqTY2E9mL68SSaiI0fdupHWA/TQ=;
 b=ft1ckjdYuxnnMVD3Uovic5Vm6nSy3nVdZ3CqpXVV+VoW1ULxV0vnQc/KwRaTGN3ZpF
 b370YEMhg7oDVrL7acpbzxY0bKogZzJyFDw3in2NyZ2ytuBuC8uJiGE3syal7HHbTfKj
 biP94s4F6f7zYc6U2eZ1mbegFdjEQ2+qrs9Y7oANo+FnAEXz63gM8oNV+mgUPdR99QuU
 kMwclQAdwl4FPzcPx/gej9dvk6AjpAm7esIE+ho46XtI+qsX+sBhWhi66JIa+j7VtNcY
 iAx13ZEcyHGDHeQ1j1xz6//6SnXpWJ9vWaCvVlwlb+MHip7kZtx9j4fzwi9LAjkzZooI
 wkGA==
X-Gm-Message-State: AOJu0YykqmpS6Uyou6DQsBu8x2SzDe5oPO6vjqDD6JVkqNt89+TekHoK
 5+VxfhyOstwCQDPyx9unWgzGPG5lsX1IqdLJ+4tqgwHh3VQzdHXowLHis5NO+QK0WncQB1+5PHi
 5
X-Gm-Gg: ASbGncvT66e7faT8JCGoOSEt5rhoqIHSMKCFhLWkCBVpHPw0C+DGlHh0R2uqR/LqDzD
 q92uD/uVjOsN0rQn/FAQfDhpEVIpWy6Gk0V7FtJdabonBIUW6+VSB7nauzLUihzrSzVAxkm9o8F
 PFPd1EGWCaL17wnC1KlvQjLcvL3XKeRCctw4edoLJ6QSIcvxdaoHf3LDlAeoByIxh03eC3Req7s
 gTLDqTexXw0s8K43YH1mW5ucN2kX31L1fsULGtV3wpH1UYlbePBreE+m5elG8nWQh737GUbJOvM
 bbBKeMfhQTNlZb/N7S1ZjpwVIO6WbEfxG9jlKJbc4xDQBn3A0SJ2C/JCHOwvtmzkiiq2LWv6R6A
 t/mQT4uXW+ZezOzAeoyU=
X-Google-Smtp-Source: AGHT+IEU6A/6PSmeDQpwdXNsZdDsUPO6oB0Sg0d/oWSbD/GRHxgzqaM1gx4mGstmwG/SRloWfkupSQ==
X-Received: by 2002:a05:600c:4fd4:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-43db6248e50mr110255725e9.18.1743495000349; 
 Tue, 01 Apr 2025 01:10:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66ab6dsm13157538f8f.48.2025.04.01.01.09.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:09:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 04/24] target/arm: Restrict SoftMMU mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:17 +0200
Message-ID: <20250401080938.32278-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Move arm_cpu_mmu_index() within CONFIG_TCG #ifdef'ry,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f29661938c4..92909276f0f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -122,6 +122,12 @@ void arm_restore_state_to_opc(CPUState *cs,
         env->exception.syndrome = data[2] << ARM_INSN_START_WORD2_SHIFT;
     }
 }
+
+static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return arm_env_mmu_index(cpu_env(cs));
+}
+
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
@@ -145,11 +151,6 @@ static bool arm_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return arm_env_mmu_index(cpu_env(cs));
-}
-
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -2676,6 +2677,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    .mmu_index = arm_cpu_mmu_index,
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
@@ -2709,7 +2711,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
-- 
2.47.1


