Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C4EC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONN-00018d-7Z; Tue, 01 Sep 2026 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONL-00017o-GS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:07 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONJ-0007Du-QY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2533d83e3bso771787866b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268684; x=1788873484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uTzrpqBFjGoCZI34dKuHfrpzrE876KSrwm8Lwfz5BVY=;
 b=mMBiKt1tZdO90AJZ0eU1KHDa+M1a59gKbF/GCwdjlKhgsqGq7W0h+aQJJYxk92xc0M
 m/lvVVCzd3rhiUGuIUZZl6qpew6z+3AN50Y1zrzupGzjxER+5Fuf3JK1zUYvlf3gvuoM
 xAYjWftjN2sK5Mhtqo8GMKusBoI+/bzJgbVxcy0iYY0tTm5B2HXCITyUbj1ze5103v4X
 iXDwZUZmrH0J+P9Ecv+sdiIOsEoR/Z6mhy9WimEvFvZbTdZAHB4Zn0xFX148f3V+LMyV
 dlwLHsa4Lch8X+5IFBSCjO2W58dPjNxjBfM7521ROl7MpH5cnu51gdfeu1JVe5wZKnQT
 ipAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268684; x=1788873484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uTzrpqBFjGoCZI34dKuHfrpzrE876KSrwm8Lwfz5BVY=;
 b=lP3NaU4WJo6Lsf40+A6uGQvM+dD9gzRo0LFMs7xvnItn4w1GdrrYJ1Oev6MiOGlTMa
 L/p9sWKBrFwuDtbmK8KEyvv+3leKSw4zfNr7yu4Ra2gt5VYbdeTUPMjVCVO8cR0yKVZu
 T9rBtFy88toy7Eqwxn+IlQLsVqrEGvHAKiJBtSG8sVtjYh50UQvFuI1fFBfspLBmQhRs
 ycbdm7Gd1kMIlpU2zM1fsvKjBH/C6jsQZZleOm8J5zEJFsiGXH9/EUnsgpqDcgLND8MY
 G50+qgRl7zWgqgqhf1rBO3X9t2QQ9gZA60LfBE4TarYQkKjhYMfrw13LHsh1mPCU2lNp
 ynWQ==
X-Gm-Message-State: AFuF++n0YFNckqHrZXUhrkeOjlB2KpuLIopnCDYy2s4C1Br+28QOeIGx
 QVPZeNExpULJUYcy/saKsQFXayAfLrQuuUTerABofabGYHXjXSg4yRRITkOYMbVVIOBit2Xv9ue
 AdJlNvQI=
X-Gm-Gg: AR+sD122FQGL+BPVre8uF2EAlA4uT9gMXNTqqmhXJP9KMbJ6zCGNA1fjm3EFFyNRqDm
 R1Z0TIMQ3ScWIr7k2/yPm9YG0eUuE255an+bDxijgT+xoDltCudM9aoauEpfN8y3vOCp+BUZMGi
 bi1F6TwHcT9UaJJuJUhvkZtvJbrkQVIZWq4T4mN8Ftvb5LSg9CMUYtgu6NXlnp+kM5fJDFFPvpg
 pGMKM7FFpSRqyPTDD3Zql37FxVpb8icec7ZavoocIZq4idGR2amuAwjvhiWwy0d4rzmogqSiTE0
 7HyUZvK8szawsy7F3xG1RfUD2rN7k47r8IIY/HPO8mE51Q1ehwjlW9TO+RXxqyM2yVPP/lPRehI
 ygsNrwnwJQ/ojoIPpO4NHM5dFQOxHdQ59IVbD7+eTGzZvgJ20l0JIf5KLSATHxsgL7RV4JVgJKl
 r184UHNr9ak/4NLag1CfWatMrYcYTHnU+LEVatTuOSyHUwfxbS0t0PT2hgVzW+wgTmHTUcb7UXu
 qkt8iBq2pYIyKbyuMZozY06g3wb3xPS6UxU6kC8fzjVPbpMTS9gXFJefbOin1guf54fhuNjvj/p
 +UhV
X-Received: by 2002:a17:906:7154:b0:c21:752f:c44e with SMTP id
 a640c23a62f3a-c25b3cf059amr440714066b.16.1788268684335; 
 Tue, 01 Sep 2026 06:18:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/58] target/arm: Add FGWTE3 FGT bit definitions
Date: Tue,  1 Sep 2026 14:17:04 +0100
Message-ID: <20260901131732.2263947-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260806172709.333300-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2c9927b1d95..9f2532fe667 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -728,6 +728,9 @@ FIELD(FGT, BITPOS, 0, 6) /* Bit position within the uint64_t */
 #define DO_BIT(REG, BITNAME)                                    \
     FGT_##BITNAME = FGT_##REG | R_##REG##_EL2_##BITNAME##_SHIFT
 
+#define DO_EL3_BIT(REG, BITNAME)                                \
+    FGT_##BITNAME = FGT_##REG | R_##REG##_EL3_##BITNAME##_SHIFT
+
 /* Some bits have reversed sense, so 0 means trap and 1 means not */
 #define DO_REV_BIT(REG, BITNAME)                                        \
     FGT_##BITNAME = FGT_##REG | FGT_REV | R_##REG##_EL2_##BITNAME##_SHIFT
@@ -787,6 +790,7 @@ typedef enum FGTBit {
     FGT_HDFGRTR = FGT_RW | (FGTREG_HDFGRTR << R_FGT_IDX_SHIFT),
     FGT_HDFGWTR = FGT_W | (FGTREG_HDFGWTR << R_FGT_IDX_SHIFT),
     FGT_HFGITR = FGT_EXEC | (FGTREG_HFGITR << R_FGT_IDX_SHIFT),
+    FGT_FGWTE3 = FGT_W | (FGTREG_FGWTE3 << R_FGT_IDX_SHIFT),
 
     /* Trap bits in HFGRTR_EL2 / HFGWTR_EL2, starting from bit 0. */
     DO_BIT(HFGRTR, AFSR0_EL1),
@@ -919,10 +923,37 @@ typedef enum FGTBit {
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
+
+    /* Trap bits in FGWTE3_EL3, starting from bit 0 */
+    DO_EL3_BIT(FGWTE3, ACTLR_EL3),
+    DO_EL3_BIT(FGWTE3, AFSR0_EL3),
+    DO_EL3_BIT(FGWTE3, AFSR1_EL3),
+    DO_EL3_BIT(FGWTE3, AMAIR_EL3),
+    DO_EL3_BIT(FGWTE3, AMAIR2_EL3),
+    DO_EL3_BIT(FGWTE3, GCSCR_EL3),
+    DO_EL3_BIT(FGWTE3, GCSPR_EL3),
+    DO_EL3_BIT(FGWTE3, GPCCR_EL3),
+    DO_EL3_BIT(FGWTE3, GPTBR_EL3),
+    DO_EL3_BIT(FGWTE3, MAIR_EL3),
+    DO_EL3_BIT(FGWTE3, MAIR2_EL3),
+    DO_EL3_BIT(FGWTE3, MDCR_EL3),
+    DO_EL3_BIT(FGWTE3, MECID_RL_A_EL3),
+    DO_EL3_BIT(FGWTE3, MPAM3_EL3),
+    DO_EL3_BIT(FGWTE3, PIR_EL3),
+    DO_EL3_BIT(FGWTE3, SCTLR_EL3),
+    DO_EL3_BIT(FGWTE3, SCTLR2_EL3),
+    DO_EL3_BIT(FGWTE3, SPMROOTCR_EL3),
+    DO_EL3_BIT(FGWTE3, TCR_EL3),
+    DO_EL3_BIT(FGWTE3, TPIDR_EL3),
+    DO_EL3_BIT(FGWTE3, TTBR0_EL3),
+    DO_EL3_BIT(FGWTE3, VBAR_EL3),
+    DO_EL3_BIT(FGWTE3, GPCBW_EL3),
 } FGTBit;
 
 #undef DO_BIT
+#undef DO_EL3_BIT
 #undef DO_REV_BIT
+#undef DO_TLBINXS_BIT
 
 typedef struct ARMCPRegInfo ARMCPRegInfo;
 
-- 
2.43.0


