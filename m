Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7F9C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFO-00033T-RC; Sun, 13 Sep 2026 20:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFI-00031U-FJ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFG-0006sg-7S
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2dcff8f44f2so40738755ad.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344504; x=1789949304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXBRafcE8TuclebNUywibHP0dHCt3C5G32QauiWhFAI=;
 b=xD1T0VKosLq/BDEBB6AwZPAvkEfX19F3nf0eLJmotj4qqNfcjhU/eshCWAuRlMDkzr
 O7YuM6pk72xk0fZydHUwfZqHwcZcmOPxqnAvTZaJMMFCMF7osByICzlIafHWEvVuy1lT
 wO2/+ZaKKgNoeROBdv31/c0OWpADhalzID3vUabILPkmwEiWpFN01WgMSbZlPFjKX7PG
 v3N9CX7YK5256FHYq2RmU2XP9hs4XjVYVL19qaXBv5q4JhZtxhqDW0Pg9M6yZm62efVI
 YtGPZqvrb/yxS+XayC4tEHRBKB8AHJRHwmo4UgWvSjK0mIs8TM129HlqlrGMxW2R1oSS
 bzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344504; x=1789949304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXBRafcE8TuclebNUywibHP0dHCt3C5G32QauiWhFAI=;
 b=GWSJNc+tSDxf0rMz2D6Hl+/7pYS6WP4nLVQc4GgdqX2u3i22HqOq9v8oZgtYRTNtiP
 xg7pMyS7xEHoa6VfWj1XQ62cKP6pev01dWyY2vU5ta0aoRMKOAYU9nUhkZkOQGpaBq41
 j+n3rsnceMzxXgW7bVRMVw4VxDGGORK44yXPHLCrPeteqvNR037YBXCYyu3XcBBwMhw+
 oTEM260e636+8lAbELxSn/Z724ORpdCvOTWw30O+F2lvG6egTIP9IER5CqwdBQRp5NI0
 YVnHhvj/8AryG2XprNnpy6Q8t/JBxCpG/A0XvGLkg2ix832CSuC2Z+kCZga+hNdwm+4/
 XvIw==
X-Gm-Message-State: AFuF++nCzpNxlasLiH/2+Bd/32GCgItosPNJfPDQS6WWoSNs6WKK6BuS
 OdWZIS2WHPtMRp0GS0D58AqTNedAfCVn0AVKDxHHtqkPEfefMqJavBNhFf/GpJdrHM971kS284/
 cnRRnEsw=
X-Gm-Gg: AYBFou02lqphU+7IGtq2JJ94/pggq5qF9lee8hIkwSPDXX40f2Bn/JEkFuI/uyzNLtr
 zvemhSHkP62u8SYbcfUfau64EQJONMv9Pw5xi7+Klm7GNIpFGNRVgJ8Uz2bCjTlFypSiW48rnia
 xl4ounE3TXRSdm1wfg+XngJTAAk750z2BEiDEwRvfHDdhQWNLMLC52BF5Tf962+fL1+ClKW8aZh
 uYy5G7Oe1xJh6df1l/aW/NZm3rRxZuwd1vi3S2lUZFrJtCDAW55JKA2+EKi3Q44cEuWL5Cui3Ti
 +MeNfvo1XIwJ4PtSdCunHcs1D3GH7Ury0+NK/yyy6vATjcG7WgSGIVqoo3sCT+1Apuupe2hOkBx
 0ZtfLhGWNAWj78RAqk8cJHInX9ILJOH/SZeL2/5m1/7MffthYuZjE1hsZq0rmC1FW3oH2OebhOR
 XbxMo/5cajQMjrk8ZjgqaHdbglY29zWp5QE9ND5p7I2HX6y6wMDwxiQxkAoU6F+5Ki12lqEGfPt
 d8Cul0=
X-Received: by 2002:a17:90b:2541:b0:396:61f1:da5c with SMTP id
 98e67ed59e1d1-39debf6bb19mr545681a91.4.1789344504366; 
 Sun, 13 Sep 2026 17:08:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 05/11] tcg/riscv64: Adjust sign of lui immediate in
 tcg_out_movi
Date: Sun, 13 Sep 2026 14:08:08 -1000
Message-ID: <20260914000814.785155-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

No real bug fix here, as we've already shown the full value
fits in int32_t, but simple subtraction in tcg_target_long
may produce a positive out-of-range intermediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 99bc658c264..d0c9d8e9cd2 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -792,21 +792,22 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long val)
 {
-    tcg_target_long lo, hi, tmp;
+    tcg_target_long tmp;
+    int32_t lo, hi;
     int shift, ret;
 
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
     }
 
-    lo = sextreg(val, 0, 12);
+    lo = sextract32(val, 0, 12);
     if (val == lo) {
         tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, lo);
         return;
     }
 
-    hi = val - lo;
     if (val == (int32_t)val) {
+        hi = val - lo;
         tcg_out_opc_upper(s, OPC_LUI, rd, hi);
         if (lo != 0) {
             tcg_out_opc_imm(s, OPC_ADDIW, rd, rd, lo);
-- 
2.53.0


