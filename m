Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966BAC54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpCkc-0007f0-C7; Wed, 29 Jul 2026 18:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpCkb-0007eX-7T
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:27:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpCkR-0008Mg-Mj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:27:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ceb096e675so19478195ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785364054; x=1785968854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j95vJfjdZ/LfANZcybXJ0RTFQkgqTX8pW2dKKED9Anw=;
 b=b4CnMSCMkwNLjMO+2xUjrLvpCZeBv8guAKWcXS8P0JNHdKPXl1MELdp9fCo1YKSEYv
 5O7Py452EYzwTdW5DApXkAOq+XodqhP4zcCWubsYc//R20tpkDvHEJjiWyFykdn9v85g
 gdm2y6jaUGIDVStLw1Ns3I/FALXUTe55b3HrhJLv7x/xNiJdLasO1Eit86YLIeBzZZuC
 TaJqPTaQSvrLpmY/BRGFj/4+LSQdkjx5j3J5ak38eNbbBUK/RL5d9Zn8ewGbDD8BrE/s
 qWPaMujt7YtGxRElPrZ8ZBy1JjqLcxegfN/IUH4m8gU8D9IdTaHPxliuYWHDacQkWoR+
 bbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785364054; x=1785968854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j95vJfjdZ/LfANZcybXJ0RTFQkgqTX8pW2dKKED9Anw=;
 b=KsCSNR7dOjOqPBt/occTa7DP3H1DY5iKkKFm2cIJPXP7O65qK4M86nNAfPzAkkz/M1
 KoV13/4ILW4UwI4sDoYAiEX9g1OAYFRvJgUGD52BLWX1dsrL8EaicGbFagjutdhTJ8Se
 01GOuWFg+57k1QDgDKhFT6u3i5+tEhWIZu0CV1K7ecoAr2F+5P3B46b2M49Ij2SzhnOi
 UefMmK4FHYTbf957zPADN59A3HnFj4ciy5TfmfRtirogARITY8CsfCkcffCwoGWFnILl
 ZtMFDlScb3Cl1AoIB5XGotAQGjV7EwlGhG2RcYTSnNtgNPEyoBTBrGi8z+UhF7da8Bm5
 MiWQ==
X-Gm-Message-State: AOJu0Yz2SWrAf5mItiR4yw0Kl4wNqLSnpT8LiNho2czqNLe42FSrcHP7
 HiWnBf1jzHmdbu/kwZz+ve2WYas0I7nnM3kqs46FCO1D2C3uJ4CwQneZ//ToW+n1owPAtEnI8MV
 J8O13
X-Gm-Gg: AR+sD11cdkihvibJUgKqstn+7x0q6jBdpHIbvQ5oeQS3qxKevolmYmrIbN0wt+3ixXS
 cRxRYEZGp5L5tHEU9tH06xZDhlaYKh+0ctFCC71hscUmCUg0YF7pH0iZILGe0uSik1s+KjSzWyf
 7ahmnP4mfc1JHTs5eX14KZ5OWi1euqafb9rJypXP5/Af54mt4Q3uzcAkAKqmOFm+x9wO8vNzE2U
 KnXfbSYBE7shwV6pyJCQlEe2evHkKyRU7A77C0C54JbSw7JB1FwVJB0U8UFY31Qz+UYrY7ijt+S
 yIMF5Ilxi+Tln2lL+0rjsg9QaarzMCnuHuqiuDpCg5QCJOvQ4GkQ0s8P2Bd+t1C5OrKMOSi+Uzh
 0YYExGyusqT0uGbIu7yq8ynH+fIoGxqme5889fRuzUpnxoyDRyxUFPyUCSDpZpPmqfRNheU4N+p
 uXCaIHTYSsBEKkjkjxi9+T/WqhDg3/Kv2yOgJT+CcUtcvDkCUxftXfQ9F+dXN/dd/y2sKm41Yye
 /yK1j4ma6R/s+TVUUkt
X-Received: by 2002:a17:902:e883:b0:2cc:7c36:2c23 with SMTP id
 d9443c01a7336-2d035cff1e5mr1728565ad.43.1785364054128; 
 Wed, 29 Jul 2026 15:27:34 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bca9d7sm17159035ad.52.2026.07.29.15.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 15:27:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, 2358543632@qq.com, quintin.kong@qq.com,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] tcg/mips64: Fix variable shift operand order
Date: Wed, 29 Jul 2026 15:27:31 -0700
Message-ID: <20260729222732.12927-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729222732.12927-1-richard.henderson@linaro.org>
References: <20260729222732.12927-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Quintin Kong <quintin.kong@qq.com>

TCGOutOpBinary passes (output, value, count), but MIPS variable shift
instructions encode (rd, rt, rs), where rt is the value and rs is the
count. tcg_out_opc_reg() takes its register fields in (rd, rs, rt)
order, so passing (a0, a1, a2) encodes the value as the count and the
count as the value.

Swap a1 and a2 at the four variable shift emitters. This covers the I32
and I64 forms of SHL, SHR, SAR, and ROTR.

Cc: qemu-stable@nongnu.org
Fixes: 03568c0d5395 ("tcg: Convert rotl, rotr to TCGOutOpBinary")
Fixes: b5aafbaa8346 ("tcg: Convert sar to TCGOutOpBinary")
Fixes: 27d21ee7c791 ("tcg: Convert shl to TCGOutOpBinary")
Fixes: edd6ba8a6bc8 ("tcg: Convert shr to TCGOutOpBinary")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4103
Signed-off-by: Quintin Kong <quintin.kong@qq.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <tencent_59B16645478B73A6A0E779128D406FE96A06@qq.com>
---
 tcg/mips/tcg-target.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 400eafbab4..29cf7fa0ab 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2049,7 +2049,7 @@ static void tgen_rotr(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_ROTRV : OPC_DROTRV;
-    tcg_out_opc_reg(s, insn, a0, a1, a2);
+    tcg_out_opc_reg(s, insn, a0, a2, a1);
 }
 
 static void tgen_rotri(TCGContext *s, TCGType type,
@@ -2073,7 +2073,7 @@ static void tgen_sar(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SRAV : OPC_DSRAV;
-    tcg_out_opc_reg(s, insn, a0, a1, a2);
+    tcg_out_opc_reg(s, insn, a0, a2, a1);
 }
 
 static void tgen_sari(TCGContext *s, TCGType type,
@@ -2096,7 +2096,7 @@ static void tgen_shl(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SLLV : OPC_DSLLV;
-    tcg_out_opc_reg(s, insn, a0, a1, a2);
+    tcg_out_opc_reg(s, insn, a0, a2, a1);
 }
 
 static void tgen_shli(TCGContext *s, TCGType type,
@@ -2119,7 +2119,7 @@ static void tgen_shr(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SRLV : OPC_DSRLV;
-    tcg_out_opc_reg(s, insn, a0, a1, a2);
+    tcg_out_opc_reg(s, insn, a0, a2, a1);
 }
 
 static void tgen_shri(TCGContext *s, TCGType type,
-- 
2.43.0


