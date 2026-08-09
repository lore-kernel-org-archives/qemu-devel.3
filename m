Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A2BC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7z-0000y4-0d; Sun, 09 Aug 2026 18:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7x-0000xI-B8
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7v-0007QS-Rt
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-848761b5897so560494b3a.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314978; x=1786919778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bhg5X7KgkKtu//M3cNDtYHW3Mp2ktbzWoJF2WF06SXQ=;
 b=rVZv7KlEw2ee2hneNEpO3P7UkwSO3nNEqfM0LrebhAY3+Zrt15hWISJwXpVXHLbKFR
 VpaMsEYFBgndRcfAKoPt+pIO10MPHVqDpT4G11kqES8wjxFCicAwWhfSCXdn1D9ZXGL3
 A6Q4B+16Fwep/qO8Y4BVHek669hbYVd2CChqOidgnX7c4pNkhtrnoExQYPUYcF6ejlem
 RZqWUvlMK4WTI3IefukJkAO1kyoRtQjWP3O5bbfjUG3JFh60KmVeQtyOKgWN6x/dHNh6
 aOQr8lAnmf0BRyng51e2hBkh5DxH3H7aOtnKDoB2M3m2184VGADZFqrmrNf9UQRbokqN
 B5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314978; x=1786919778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bhg5X7KgkKtu//M3cNDtYHW3Mp2ktbzWoJF2WF06SXQ=;
 b=HtJiUNffMHZCe6giGU6jmsfpFfGHPFMJuiDToZE1j0FEWRJy8VoyFv+GCJjFCmoJrC
 NZ6BQWFY8lwmK/KhFV3TtJIq0hVcHrjf/iiEtJ6PbjeSrRhLqnRm8wtf8pNubBKXS9Dt
 p2go7Gb2gkw8YzhDBNz9/8mcKwdmkGHc2jfoM2iCNws7gtac2t8srftRd5P8CtX/8xZU
 zce3oiN2rEBa51qgkA3FI+/wsVD/2EkChzOLP/HCaN2mc5O5p7v+mNESReNGViZnEJhn
 +mDRS5zhpvf0amYdyFG8L6wgNCWxMCLxfawdhnRrmYkPMsiysSvpzTraL+SiNzBtl2kd
 dNbw==
X-Gm-Message-State: AOJu0YygeDrC8sUS26A1W+UwvDAO/tx6/lFtAKOucUliJdY/stAHZwmu
 oTLoif9nbyzuMrZuRwn0ffSeqLZ3XcLLDZrE8Bl+KQHq6KPEWtnGHXOoadbk90mvhYtbBy3SNl8
 Y1w+B
X-Gm-Gg: AR+sD13kmmhTosuAMgG17EV7uOolKZEtHzWY95XyEUABOIVV+RSbB3L2F+vscloq5kR
 X3AP1FjpovfZ6RuMNFb5YU/a1SLZlXdJOn/KWoJ1dMw7a5aF6OpbSAt3j9XbdX65DRM6qouR+m2
 HzzaiuiH6Zu/Xj7LgPrTxWYBipNkoaxt8G1n+UwtCa+ZaF8CkXKgj1CXHm+hzD3RtKUgnW6pMdJ
 MDV4lSQycDvzLwNKoX8r0Qt6NpeXVaP70Hk9u/Ht7GcrpvyWPwCBhb0KyGNSsacIkxATMc3ZbLe
 BKrOPpqXeXee4ONG/QjPGHb7YYwjOimbNpuZnMnlRAX1kCFmPm/FAUCaUTiwnJ8M2jObHRiN8MV
 DRzcmpqjqgJG8FgsaMOAHrE1rSEp0c7Qlo7O8QhFVoHTy1Il4x7wBG62VOoAc0U3mklP60GPUbk
 BwQTcEceO616H+RqkzKMdOJQPbVZX3cRlUhicHBw2jF/4x6TteEqN8BsaAkVizH1xclDy2zf2Ss
 pMtfzAHfFz5f+035hJR
X-Received: by 2002:a05:6a00:194f:b0:847:8971:87bb with SMTP id
 d2e1a72fcca58-84f2e00ea47mr37958043b3a.21.1786314978447; 
 Sun, 09 Aug 2026 15:36:18 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 24/56] disas/riscv: Remove rvcd_imm_nz
Date: Sun,  9 Aug 2026 15:35:13 -0700
Message-ID: <20260809223545.730664-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Remove rvcd_imm_nz and rv_opcode_data.decomp_data as unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 5 -----
 disas/riscv.c | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 31bb0db86c..3909d73dd0 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -186,7 +186,6 @@ typedef struct {
     short decomp_rv32;
     short decomp_rv64;
     short decomp_rv128;
-    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
@@ -217,10 +216,6 @@ enum {
     rv_op_illegal = 0
 };
 
-enum {
-    rvcd_imm_nz = 0x1
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index ddc2f73eae..95957506bd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5417,12 +5417,7 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
     }
 
     if (decomp_op != rv_op_illegal) {
-        if ((op->decomp_data & rvcd_imm_nz) && dec->imm == 0) {
-            dec->opcode_data = rvi_opcode_data;
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-        }
+        dec->op = decomp_op;
         op = &dec->opcode_data[decomp_op];
     }
     return op;
-- 
2.43.0


