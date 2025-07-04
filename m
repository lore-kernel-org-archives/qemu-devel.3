Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDx-0008FR-MG; Fri, 04 Jul 2025 12:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDv-0008Cm-OJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDt-000652-SY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso8786315e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646312; x=1752251112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=75h5JYanAAyAMbTMMG7XYWKCz19Fz2IxJzhKVW1CbPM=;
 b=QUbW0Q28QUR6eRW5/qrTXzGI4k+0AqF9kTgLnBSKdjKqMBsiZv2XSS4tmDQ2VJ6nRY
 BN1CMzgyQ0uW+WRe+U9ryqf03PV6TQfbcKU9BnNg03dLj6rFLYXOwmC/4bh7H1L7Czog
 TAZZz18lo4Q/dB+KlJA76vUB1xYtQxfeDbo7EBh/QEEA1fKAs6SBDWWac1ABV6wLGTR9
 30M1P3+2SNUpPXqbJs1ADxrWsIcDGrBQ90UpUcqL1kCbnOirdSToM6J6JJdqTBfr5rCz
 DpA+mliB5v+k89rzMHW7rTyuVmeOoS3rsJ92yMStWoVJdPirgdFhAdumNoJrYTRXrYWH
 Xi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646312; x=1752251112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75h5JYanAAyAMbTMMG7XYWKCz19Fz2IxJzhKVW1CbPM=;
 b=RuXJVvVG74h2V4mUjOPLLzqhUQrUQbXTx6bm0c/0xOdC50IBvHEnvj6cy4atP+/zx/
 CEShv+/K6gH8TAd1SlM/yGGqu8BhRuM9Z1LMhZm6VNZVAeM7q1Ah+hf3JT19tdftnZ/g
 9qbsQzVGbo4mmbq8uucHnowYAMeWoNGCu3K9I2HZU5mpnsS1VNqunE+wcSFRzy3JhO6o
 wB2QSmERXwsn8fy0EUmkPCclm9Vk4Q8hGZbmwF85h1NhK9qK3D5eM8R5nLO7i3Hu45qO
 R/n9HEUdsAW0pE0zjNEPxiG263SIJjJ6DpHR3fdFxTMkesxVRFZ3SC7qPyWAlwko9h1v
 BKPA==
X-Gm-Message-State: AOJu0Yzvth85PU/cTqvwEXabf4RG1CXIig3pGoSCfv0Buh90Du1+ecH8
 Ke7ZKStpfjIx0lnx6pTvLY6xWXSPu6TJQO033Gbww1uIMzrE3cJdqsDD15PmGhw3YB2dCPUziaD
 CpV8q
X-Gm-Gg: ASbGncsBoNTDc0C3FfMIdsBVBbp2tZWi7u5A0iY5ysCp4o7sjerjx7D7u0/AfD4Td6T
 Wriin6CqIohu+Gnbxlhrcxje6HNkmIY73aVXib7i5C6y7G7c0sh1fLBKWyDaQM6S422clVxXXKs
 YrhZrR9Ir10VV85L4Or/E6VaeDL1ram+F2gTnBFyauSCf0EvQPGz+tAxIalFT7LFPzF10HCARPq
 6HzfiF6kDAE5Mbn2nrErXo5GPG0hppHd6XKFeakzf1IdG5YmWZALN8aDpBfOpXGSKlCZGxNQK4g
 5YlC22SIDP/QrrXp/jB9gjda+er+YqJT1oEaUddissQRdWW5n15jw/4rlqd8/ceUEM1g
X-Google-Smtp-Source: AGHT+IGr1n5G7pnUww+cWAvxTdweCh0oyFoILozvRYVHP/pEQkOUlFTJ4rGg95WaNdrdE5hlxfke0w==
X-Received: by 2002:a05:600c:6383:b0:453:8ab5:17f3 with SMTP id
 5b1f17b1804b1-454b4ead145mr22420775e9.22.1751646311864; 
 Fri, 04 Jul 2025 09:25:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 009/119] target/arm: Fix VLD4 helper load alignment checks
Date: Fri,  4 Jul 2025 17:23:09 +0100
Message-ID: <20250704162501.249138-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the load operations in the VLD4
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-9-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 2d21625f244..7069910db4a 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -403,13 +403,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 4; e++, data >>= 8) {                       \
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 qd[H1(off[beat])] = data;                               \
@@ -427,13 +429,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 8 + (beat & 1) * 4;               \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y);             \
             qd[H2(off[beat])] = data;                                   \
             data >>= 16;                                                \
@@ -452,13 +456,15 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             qd[H4(off[beat] >> 2)] = data;                              \
-- 
2.43.0


