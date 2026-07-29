Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFCEC54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpCkb-0007ef-PS; Wed, 29 Jul 2026 18:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpCka-0007eP-KC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:27:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpCkS-0008Mr-Fk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:27:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d01663d816so13709995ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785364055; x=1785968855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x7llLYb5SiO/txOcB5U0TYVAXKt2eTpfMujF/WHT6VM=;
 b=Y05CmA4nIvoB2sbASjur3iAbmn2CE71ziwrPowYhRcxcHP2cgvPV5bVdoIq5iXeQ9p
 aPHVHsSlgDXR2fANNJZNw8aK8LuTNb9n/q3Uj5jThbLRsp/Mlmelr9n4ZnT9yEKz9/uZ
 vr7+QNrzWFeQWGg615F3vSNm13T5k4fXCsd8qnoHm4xkeS/znQyqMUcuiLgOohCIgLtb
 AY73vJaPBlrCU65K3wo33EMWGaBSd9IFy84mNp2VX8UkeKHz7JqicHjFh6+xrXXq+lyc
 kBJK9F/A0pNxrySa/jwcyF2ylGrk4QNVo6Z1lSCq6mWzOyJUyp/kmrjQ9rieUEQD3xGB
 U3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785364055; x=1785968855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x7llLYb5SiO/txOcB5U0TYVAXKt2eTpfMujF/WHT6VM=;
 b=YfGcJQBJ3iEh4P0Niwv/tDmLHMUMhq+5BEoeZOzBHtGIg0zMFCuviR3C/gqV9nRotu
 aeHG6QZdlpSFDn9IdcbEf2VM0BSsdmy0gYSqDX2ctU5eU7MmrSI6g7h0XerH2O2K9y0B
 o00aeb10k+ul4tyzjFFR6IwsAFdPZEW7QJtmBrVYIWa3u5Ua5TkC5FJUlrnyr/Tq4XB/
 qK+LbEDShKUpvG/i6EHni+lXtGDJdcPfp18oEWZuuYIm9dVfjZyv9ygOvEtdaFgAMFT7
 MoA5/hNlyCYQCcTIUJCKrKnwcz/6lr677G4m6NH8nsBaJTbcslc9WjlT5WACIfPUKJt6
 lgbQ==
X-Gm-Message-State: AOJu0YxmiobRlOQOVVXK1ZIKcmOjkdt7i+xoPtc3MDXXOSvgNOHsKPZj
 yOPing91PIJcF6CMLRwtfk81Ivxk8mbOzKKIzb07WiszrzT1eO1GuW72y86Hio+s3b4t6iDEOH0
 kqwmw
X-Gm-Gg: AR+sD1015p4e8rARbOYZDt4PcMclH3G5SkdE2cOlbd92yoqje9ttxDv3BQZP2/RM3Y+
 7hVhYwyb/mGdCi96uuqYO03bz37Rl+vwF6rEIGGEnkEoX9FAaxqBsCco9yT7P9ghRjv4z9lNV+A
 EzsliZpvE2azj33TPn2eJVkj5zlFnLWy5hmpDYefpQy1G2kEsoWiNIHggiHSfZVksQTT9kysra8
 Rq3oo7Jth0zBS3dc91w16pI5cc0lJbFa8H+r7VKbpmuvhwVDkC4kqLvlJVBABhdYdAHNgtMYNbJ
 jNxny2qwxI2l97lNgHcc2xZxwgt97FfKPIIcA3qisRS75yMI22U2ePHrbHr5iqXC5m4GmkgYIVY
 lQZuGDQM6fPiS4y8gRWBaYHmTL98gI5RTNVAOMPQl3xSjGp6fryUh36UBaniCh/RdoYbjjH0FKO
 R8zw0V/aXwGBn7c/ai19i5tgangbaaCIb+yoyLaMmPjcESpyn0WsoWoMB/0f2OVEU6Y/5KDQmDW
 jnXNic86R5A+Ji+LE49fwVm2f2HZL0=
X-Received: by 2002:a17:903:4590:b0:2cc:f4d4:29a7 with SMTP id
 d9443c01a7336-2d035ca4d31mr1469865ad.24.1785364054868; 
 Wed, 29 Jul 2026 15:27:34 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bca9d7sm17159035ad.52.2026.07.29.15.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 15:27:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	2358543632@qq.com,
	quintin.kong@qq.com
Subject: [PATCH 2/2] tcg/mips64: Preserve the base of unaligned loads
Date: Wed, 29 Jul 2026 15:27:32 -0700
Message-ID: <20260729222732.12927-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729222732.12927-1-richard.henderson@linaro.org>
References: <20260729222732.12927-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Quintin Kong <quintin.kong@qq.com>

The qemu_ld output constraint permits the output register to overlap a
dead address input. That is valid for a direct load, but a pre-R6 MIPS
host implements an unaligned 32-bit or 64-bit load with an LWR/LWL or
LDR/LDL pair. Both instructions require the original base address.

If lo and base overlap, the first instruction replaces the base with
part of the loaded value. The second instruction then accesses an
unrelated address.

Prior to eb664d0c527, the address register was always a temporary,
so this problem never occured.  Copy an overlapping base to TCG_TMP0.

Fixes: eb664d0c527 ("tcg/mips: Rationalize args to tcg_out_qemu_{ld,st}")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4102
Signed-off-by: Quintin Kong <quintin.kong@qq.com>
[rth: Move fixup into tcg_out_qemu_ld_unalign for qemu 10 series]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <tencent_8D773439C708369D6BD2ACF71EACE26B020A@qq.com>
---
 tcg/mips/tcg-target.c.inc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 29cf7fa0ab..a683bff625 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1338,9 +1338,9 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
     const MIPSInsn ld1 = HOST_BIG_ENDIAN ? OPC_LDL : OPC_LDR;
     const MIPSInsn ld2 = HOST_BIG_ENDIAN ? OPC_LDR : OPC_LDL;
     bool sgn = opc & MO_SIGN;
+    MemOp size = opc & MO_SIZE;
 
-    switch (opc & MO_SIZE) {
-    case MO_16:
+    if (size == MO_16) {
         if (HOST_BIG_ENDIAN) {
             tcg_out_opc_imm(s, sgn ? OPC_LB : OPC_LBU, TCG_TMP0, base, 0);
             tcg_out_opc_imm(s, OPC_LBU, lo, base, 1);
@@ -1360,8 +1360,16 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
             tcg_out_opc_sa(s, OPC_SLL, TCG_TMP1, TCG_TMP1, 8);
             tcg_out_opc_reg(s, OPC_OR, lo, TCG_TMP0, TCG_TMP1);
         }
-        break;
+        return;
+    }
 
+    /* Both loads in the unaligned pair require the original base. */
+    if (lo == base) {
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_TMP0, base);
+        base = TCG_TMP0;
+    }
+
+    switch (size) {
     case MO_32:
         tcg_out_opc_imm(s, lw1, lo, base, 0);
         tcg_out_opc_imm(s, lw2, lo, base, 3);
-- 
2.43.0


