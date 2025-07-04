Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A728C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDz-0008HP-4y; Fri, 04 Jul 2025 12:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDx-0008Fi-O4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDv-00065v-M4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453608ed113so12303435e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646314; x=1752251114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WVsL7KrYHwCP57mTFTbShINVbfgH7p4y5zsRi/3m5gg=;
 b=eEpObgA/iRYkfzjG45qEmbcpJCQ0M8OiIQNRyf+aKykSxef11+Xmdg3aVAgh6ZEGTd
 kGyfkJYkBx4qYlphH08GzinWDrsIjZBIvYPIg7SyShgb9Dkv80ZUbzrgC5UU2p2SDkxY
 OEHDoHwPEFevHllCvxfhTs0YnffrgSpp92z0nJEViuv+zuiPNiJcg/xT+dc0d05QXomi
 ig8MhQA1gh+s/SeD5WqCBG/iLf7aep7FzgZrOtDd6WXWiS946MFG9+uXiXepKyMl8b7z
 z+S4/VtQqGoT276gsp2s1/QsaevLf/VOaqKRBdjJwC7ugmJX/cgzNbtRIbHx5UJr8ncv
 BrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646314; x=1752251114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVsL7KrYHwCP57mTFTbShINVbfgH7p4y5zsRi/3m5gg=;
 b=tsFQFmzw8KKAJFdreV6A+k2nqH8fwuZGTU1ML2mfiBybSDcmoeCDNVPrPW5D3ecpgQ
 Q1Y0RlWQxgFYJXPnunzSIu9c/NGvEyfAFbTYChDo9pD3ylyG8nzztqjXqEEf0qhGoQMa
 694DdmJLLcC8X/7SepXQLXEPSgXpYkY6elW6NRi+v3gMU/uOuKYqGVnNbL4/i0BCI6Gd
 R8nkM6woo236I3W5kyPQNofyJ9Hfql4U3d4TqqPzRy8TcUknE3hwFIdF7cnqQ7xa3sDc
 kplmwnP9z7xp+LuLTGSrp5KMf8lKqKFXWNPddrP1v/IRZppr6gZ7hUeTSZHgeSKckDoq
 mmgw==
X-Gm-Message-State: AOJu0YwnqRpmTAQM7n1nQ0MeiIPHpnW9+hs6Nx+KIqa7LN0+AiT5hByf
 wfxdbNqB+2sORgfRptZGZZkQcPEJS0B989u4ud2HlIS0kykaAY1DlluSpSv9aQq8aXLt1DsADwu
 9qOGw
X-Gm-Gg: ASbGnctRUE6SyGz5+v2TsosFCyfADg0uKIh5yvGJJLeFi2iVGeGrqUpW4aRLuCG1AWa
 LKo7jFeZ8Gww1Swz5Z/utIiC6IrAntp7kbBa/6d7wQZUshFNCq7KtV1rHvNBdcydWVsFyuxbEen
 DzCIHgOF/u/lLoHErRRN+oY5b3hgCv2DnFdGS3tyT8Bm/vf4jNon417BjkLuMYAflbvduxpdxBR
 3fNOPVSky+lyLCzfTaqAgrqVVJy+bXk/SCMO+rZ+RhHyTo+oQJk+ICkiw0QJcqaFxmrR++F2lxC
 v3gUabOSj6Uz8RDekFaO16nNVnMYZKgUH0H6WOGPGQk2SXEAM3nVKOq1UfF/mFaJkcJ3
X-Google-Smtp-Source: AGHT+IG2ENzqJfUAbCz9Skb7pmUtgbQr/en65a/m7fDhfW9qqoVQarU0jnfj4egULHZ5XSHIqy2REQ==
X-Received: by 2002:a05:600c:6488:b0:441:d437:e3b8 with SMTP id
 5b1f17b1804b1-454b30fd93dmr31843705e9.23.1751646313884; 
 Fri, 04 Jul 2025 09:25:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 011/119] target/arm: Fix VST4 helper store alignment checks
Date: Fri,  4 Jul 2025 17:23:11 +0100
Message-ID: <20250704162501.249138-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

This patch adds alignment checks in the store operations in the VST4
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-11-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 7473dfad2d2..5273411389d 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -577,6 +577,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint16_t mask = mve_eci_mask(env);                              \
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -588,7 +590,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
                 uint8_t *qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + e); \
                 data = (data << 8) | qd[H1(off[beat])];                 \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -602,6 +604,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -612,7 +616,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             data = qd[H2(off[beat])];                                   \
             qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + y + 1);         \
             data |= qd[H2(off[beat])] << 16;                            \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -626,6 +630,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int y;                                                          \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -635,7 +641,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
             y = (beat + (O1 & 2)) & 3;                                  \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + y);             \
             data = qd[H4(off[beat] >> 2)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
-- 
2.43.0


