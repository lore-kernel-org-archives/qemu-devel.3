Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E130E10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CK-00077m-2q; Fri, 27 Mar 2026 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CG-000748-BJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CD-0008Lh-L0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso2030565f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610264; x=1775215064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvlMSNGdKIlUIEkOr6Lv47MQTuNcGu0po65x29YyYWY=;
 b=xvA08muiTPDIAglBq2VgMo9I+53CQBL9ClNG+yD0wi0AQw8U/ERkNTETYr/yZ/JSXP
 V2YetGN2p91aoOasnpvSUKa4hIUM0dQx//yrMDScvzfd+qRiX5c37WX67COfjZFXwg2C
 y1AILrI9auvrrEBv3P6V3TVJ7NvFRQIEm7fYhPT1X+e1k8MHEGPa0HzhEizcESCy/768
 u50bHlqiWFNdABfHP8rJ6FblFn8QrgNj26ov8JxHPURk+z8dzYAEqYmrisXo74d0bIUF
 PC64sbz5h/JoMfqMAw2tjkdtNmgoaEEu9hAVUWZi3vcHmJ8GQEtk8y8/rbGTcmWAJ2hB
 n++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610264; x=1775215064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zvlMSNGdKIlUIEkOr6Lv47MQTuNcGu0po65x29YyYWY=;
 b=r+KkJWRruufYQQRrqZl/RPK0AMiVHirxjmGmP5s4AQsdu9yt7w+AkwV7nsxFlEt4va
 vn05JwPSjjDRX64NCGalDTgV3D5DSr/6lDNVPmyrUX0B2KFr3rQM4Pe22GSdlDhVpptk
 FpCQX0Kkk1vDitVLLtmE81M9dlgC7wvo9Bs5rZE26EP1gus/rnc+2hOzFf8LRx4dVLrH
 uJzejWNG3XPzH6XOk/QW50bTaMyKY9J2KlokgbaK++kGkUi2/V5CkOVjk4Ll5wvhv56u
 dP/ASWVLcVdeClxVl76+YE6WjVh89jiQHDGLFda++AlaAbJSgC3cr4ja/sKIQN/n9etu
 RKAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkl2A0qRxsrG3UWDmAGoETK99lslkvesJiwMEBxo9m8tzFMyyP09uNpqSb1oTWY0ZIyhW7qpYlrkGm@nongnu.org
X-Gm-Message-State: AOJu0YwhQxPBVEA2Ryhm1BHEdUHsgs/dn+/9fbH0X4pcz1UiYw1vuM0s
 wfN9HgJOyV2ZE0h/1aOnN/6FTCC3CzWaoIZQg4BTR16yNe4tR3frOqvivLfUw/h6zh6QlAYL1fC
 qfaA0P/s=
X-Gm-Gg: ATEYQzw8jZR0BLtHAsaKWF+nr+izQEPGpJ7Oe/rIiGBabfHDdLEdoQTh29xIBtaYAvK
 SDPNgssZMfJyUvRH6iu5xrnqxmKDTVAVPrGFalGUwtf0xuxnHYjx90gQVtR4RH75OvNQeAljzSp
 94BAxTPpWrkMkTKUTHuvnoWnJPpZl2Rx8HGTw71xlj5itOA/UXlA95lxkbLjp/RWgnCTxNYAf8z
 EiqSfNn6NVACm8uEv0Q/DQDZToDuKEEY+DzSRRsQhrhAQlt0vGG1KdB5dYxwAc7c0O2B9e2c0PU
 PmmAnEgtxIaU/4lmwi3a/YbC5utJH/iuyYYN72Zmq/nltcE+rCFXC5jYqotZ5538/DfDDnoDQ5p
 9c4y5H8nzAFAXGHkCpy8gbFNS/USUNQki65RgPdFlUGbNyWFNvgvXFiTBYqKcmLl667ozoc2M/u
 /eCQhlwAccBjlilITThShaXIzAKLabkFrpKnCwV2ESKg40nVGDHAX6qTFJqdy9kL8ySE9g4CdLU
 rREhapmX792q8fxYbqZ97JH80kAUDs=
X-Received: by 2002:a05:6000:1787:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-43b9e9e8c64mr3413778f8f.12.1774610264039; 
 Fri, 27 Mar 2026 04:17:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 44/65] target/arm: GICv5 cpuif: Implement ICC_CR0_EL1
Date: Fri, 27 Mar 2026 11:16:39 +0000
Message-ID: <20260327111700.795099-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement ICC_CR0_EL1, which is the main control register.  This is
banked between interrupt domains in the same way as ICC_APR_*.

The GICv5 spec assumes that typically there will need to be a
hardware handshake between the CPU and the IRS, which is kicked off
by guest software setting a LINK bit in this register to bring the
link between the two online.  However it is permitted to have an
implementation where the link is permanently up.  We take advantage
of this, so our LINK and LINK_IDLE bits are read-only and always 1.

This means the only interesting bit in this register for us is the
main enable bit: when disabled for a domain, the cpuif considers that
there is never an available highest priority interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e0a7d02386..1263841a1d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,7 @@ typedef struct CPUArchState {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
         uint64_t icc_apr[NUM_GICV5_DOMAINS];
+        uint64_t icc_cr0[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index ed7c30c07c..50aa81d74f 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -43,6 +43,12 @@ FIELD(ICC_IDR0_EL1, ID_BITS, 0, 4)
 FIELD(ICC_IDR0_EL1, PRI_BITS, 4, 4)
 FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
 
+FIELD(ICC_CR0, EN, 0, 1)
+FIELD(ICC_CR0, LINK, 1, 1)
+FIELD(ICC_CR0, LINK_IDLE, 2, 1)
+FIELD(ICC_CR0, IPPT, 32, 6)
+FIELD(ICC_CR0, PID, 38, 1)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -346,6 +352,37 @@ static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gic_running_prio(env, gicv5_current_phys_domain(env));
 }
 
+/* ICC_CR0_EL1 is also banked */
+static uint64_t gic_icc_cr0_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_cr0[domain];
+}
+
+static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * For our implementation the link to the IRI is always connected,
+     * so LINK and LINK_IDLE are always 1. Without EL3, PID and IPPT
+     * are RAZ/WI, so the only writeable bit is the main enable bit EN.
+     */
+    GICv5Domain domain = gicv5_logical_domain(env);
+    value &= R_ICC_CR0_EN_MASK;
+    value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+
+    env->gicv5_cpuif.icc_cr0[domain] = value;
+}
+
+static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* The link is always connected so we reset with LINK and LINK_IDLE set */
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_cr0); i++) {
+        env->gicv5_cpuif.icc_cr0[i] =
+            R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+    }
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -504,6 +541,13 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_apr_el1_write,
         .resetfn = gic_icc_apr_el1_reset,
     },
+    {   .name = "ICC_CR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 1,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_cr0_el1_read,
+        .writefn = gic_icc_cr0_el1_write,
+        .resetfn = gic_icc_cr0_el1_reset,
+    },
     {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
         .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


