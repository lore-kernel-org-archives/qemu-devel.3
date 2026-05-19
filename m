Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F4ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLja-00020I-3Y; Tue, 19 May 2026 10:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLjS-00016t-IU
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLjM-0007zj-F4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so21435185e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202051; x=1779806851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWZdLVhlhSLtHCNbbyN0ZgO/iZgjO8xlliAMjKdmLuw=;
 b=XOLmsddvCUDhwE5kVL+JVAhwcRQV9i4IPq3m+iaG5imYHbksYitEoLbLhClDb+0zW3
 Oj5YodUXfgxt8p+XcTqbChciH8614TV/xJ6poJR/Q6SMg3kP3WlD2LE7AkCarz8l3Q+2
 vZW0XAlFoiPnoOP5iYtojuIjRrR1cnCFiLnc7BfeZvhwA7oiMETkIrUyFvauh/tKqXyo
 1I7Che7Hf/prSp0QqdlgmLSzpYOba6pTR2AAaA8kwuCrGw7lzwcQppJKl5I7mntdeTWs
 0rY/clgB0jj91PNvE24HCpAzsc3gtNnZVXcYxQfNGh6naJIVZJQ4YHRtwGWd1waH0Knc
 Omxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202051; x=1779806851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PWZdLVhlhSLtHCNbbyN0ZgO/iZgjO8xlliAMjKdmLuw=;
 b=e4G1dCVGwCXBWapg+iTsrcR+3XTn5nlOckKPl1vd4j0nC4Xx/NtoWYNo4jeA9fTXFY
 OmjMMC3jAs7zt2YZf3D/4wMSN6RcJqM9E1YN5xdJ3O0dKGKcfYZeKBctLbLeSkahEa4r
 ib0a9NYQS+c0kieBx5IZb/rBScHLSsEUnxP7F4hXpiAPUDHJwiZ6BCjtGfepQmVgP3i0
 I0JImBOfWDtHvorMyKIEc4zNNglbL3lqu/U64eEDg/UJTVLJ1jSwDVG84UnGX1GwX9JA
 GAY4yZzKahAQGWz9jxwo+nKN4GWo0gsCGY8UIrHQZy6F+yg/eYTW7ge78gE4fHFk+QcI
 KsKA==
X-Gm-Message-State: AOJu0YyKWXxLRniaQi75b//gQytokkuVJAmm5ZRzF/C44OTnWhdQ+Lzw
 7REnIYz8uZisn3VBOro6mHIGupXjuivRL+L+9yetf0qW7O9yyBkPy9/yjM89YvOH31wQj8DpBYD
 JeNyEs1U=
X-Gm-Gg: Acq92OFRlJkow7ssXzligtuIdY3EfJAkY3mZZ4hbdr4m1I1iDhY1CgiQe8tjY5C3XU5
 oA6XYPrBr6vPDsFDTaRxo79tfqyGlGe/ksu353dPmvwXdUB52CKgjGMFO5OaCZJaOxglH+s4190
 oqufmLthnFlnLtxSVKGLb3Zx4eUAuzDjRApsWZ1ApVAxoOzdOF6qpMiz5fca1HIOifb/nqwtwhL
 6wwWQ7NvJTOIqfQVEFb20keYoJks1786fjqIgqQe6CFEeH7KFBPzaomGSMq0P1Zs8ipyKXem7+e
 eOovusYfrkOJ4uDBqNJWq2pA70rk8s+wc5EjHFOATzvfZdtwuWY6IubGWiUuB/HQph2pRYUUmeY
 CA1x7JnDDdH3W9Rnzuu/MLwtGZB7x9E8XozbLzT4X0Yt9kFDy+YKn3P/oaXSm/JifPIGE1h2Yk9
 a/HKydC8fJR7gBitVZAqba81Ap9RC8Vhg19paBc1mO6+EJ+jDg4ga+vuq8+VPsS09+K4Fs8JeN
X-Received: by 2002:a05:600c:364b:b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-48fd635962cmr257416045e9.11.1779202050941; 
 Tue, 19 May 2026 07:47:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1aeafsm48611239f8f.23.2026.05.19.07.47.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:47:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 14/18] target/arm: Factor aarch64_aa32_a57_init() out
Date: Tue, 19 May 2026 16:45:49 +0200
Message-ID: <20260519144553.91483-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In order to make the following commit easier to review,
factor aarch64_aa32_a57_init() out of aarch64_a57_initfn()
as a preliminary step. We only add a %aa32_only argument
to restrict AArch64 features.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/cpu64.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7b2f09cf8ec..7dce17fdb20 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -686,17 +686,20 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
     SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
 }
 
-static void aarch64_a57_initfn(Object *obj)
+static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
+    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    if (aarch64_enabled) {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -727,10 +730,12 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
-    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
-    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    if (aarch64_enabled) {
+        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
+        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
+        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    }
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -742,14 +747,21 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 2048KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    set_dczid_bs(cpu, 4); /* 64 bytes */
-    cpu->gic_num_lrs = 4;
-    cpu->gic_vpribits = 5;
-    cpu->gic_vprebits = 5;
-    cpu->gic_pribits = 5;
+    if (aarch64_enabled) {
+        set_dczid_bs(cpu, 4); /* 64 bytes */
+        cpu->gic_num_lrs = 4;
+        cpu->gic_vpribits = 5;
+        cpu->gic_vprebits = 5;
+        cpu->gic_pribits = 5;
+    }
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+static void aarch64_a57_initfn(Object *obj)
+{
+    aarch64_aa32_a57_init(obj, false);
+}
+
 static void aarch64_a53_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -886,7 +898,7 @@ static void aarch64_max_initfn(Object *obj)
     }
 
     if (tcg_enabled() || qtest_enabled()) {
-        aarch64_a57_initfn(obj);
+        aarch64_aa32_a57_init(obj, false);
     }
 
     /* '-cpu max' for TCG: we currently do this as "A57 with extra things" */
-- 
2.53.0


