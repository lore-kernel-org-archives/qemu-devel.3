Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089B3C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNap-0004UW-Nb; Mon, 24 Aug 2026 01:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZy-0003Tt-Ou
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:43 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZx-0002Uu-8G
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2516640a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550640; x=1788155440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2ERpv2R5tDGDX/CspojpX8vl9OuHWWYGhdlr3yYFXI=;
 b=ii9ZKtTZNzKfFKsMGCgW1+ty7gPRsyoLv5W2E8sAp0KWmUqqBQ0WF4W6nJulpIr+hj
 EUtEn3l4Riv5zuoBcPRldKNySWKF07nrhoiYle4fxDNSBJLSy3zgETj8vsPPt4orGlJN
 1DPUlNjZyqJq60b+gR8AnZIvEwrg+78SRsXlexOdPOfsourdPTWJK8zEt4QgVtX3dUw6
 Y6hgOB1poZYYQzbFJpPe85lNc2Ysgm2axe380s4xZMrQHe6+dSt54najXJE+3O7qapRe
 7sYqYVCpRNjtcoWeLy17cdqZldMlZc5cQx9JpcvKn0pf1CmiSqmhiPshq7/II754+eSs
 6uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550640; x=1788155440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p2ERpv2R5tDGDX/CspojpX8vl9OuHWWYGhdlr3yYFXI=;
 b=PWpQH1ViGucUpJ2wQ6Z9i/AOC7Av+YXNGv7GMR6sejqLOyfLZV1/FPV6TvnffbCtr2
 ZED8HEXECaohpiqFdesnTMPNBho/8tRVJVAXv6eN5Isdy3RDPPBQ74Nuy5OEFnRRD1HJ
 Z+TBtD+U3Nw+4aX7lytsYYESET1U9pUJFsdm+oo6l5M67qVYJ17M1X9FE6ZF1Rws7Sro
 0yeS3e6UFjbwSRo89FManSlO8FwMYnug/nWlAvgaLBiEeL7nrOuQohz3GYLIkBztPlQf
 wR7Wg6K29XM/dotlu2d3ODJACfWaPcuFeRrmzrPelnicF7cIuL3zcrbcfeZyEh2Q1Chh
 57DA==
X-Gm-Message-State: AFuF++k0Cdl+rmV2h3f4kVFAR+u02zy5jkmt+JldAxhqe+l4Tzt7ouzP
 x9T9AilfsWPR5vU6wohoflxvwTLcfMHmQTWF0BbOQuF2ZpROv0THfCXKRGghoA==
X-Gm-Gg: AR+sD12v+SHXv5a/OS59JwF2PnfOtP49NecRxK/y2hpyHwIR55iTsZ0rOFo63uEgmdU
 rrYr+hFYKlqFbfpiSN8fRTgOkMhTlaq62bbMLUsC9K9gqimy15yoPQp5vuS4uqqfJ0GUaGfbxx5
 VDM4/wHBimmZ0RozrxEfAAqDgVLLKki2JtymF7qDnknQ8/JTaROL9EYEeU9E15AVW5/52UiofHx
 ZkyEqwTvhBRPUFxYDTPMHwL9H/AOsi7R+4l7eb4hi15DOlH3gS8e1vhqhKKwIJRPtHvkFenz5vO
 WbqEW1SM29mKT15Eyn35t481GWQWF7A94ceUC4P730q6ifOJOC/kmWuJeqrmLoPxuy1yyE9WBfi
 Zj1tVP+U/dwc/5+45Jbh9E4CcqXWjtX2G6Y7d5HEQCiHUeP91PB/PQDz4j9MmNGNQKx0ZBiYum2
 x5JHhTXFL+l8hqZyya2YBGqcWIa2qoQ7CrbRyL7Z5dwtf0R7LgOy1pOXJxW8q3X/SW4F+ewAYVi
 zc5yw==
X-Received: by 2002:a17:90b:4c11:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-395c3878304mr38373287a91.10.1787550639904; 
 Sun, 23 Aug 2026 22:50:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 45/96] disas/riscv: Drop codec from rv_decode
Date: Mon, 24 Aug 2026 15:47:15 +1000
Message-ID: <20260824054806.2790041-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

This is mostly write-only, only used in one place;
other updates are ignored.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-13-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 1 -
 disas/riscv.c | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 3325b7b4ef..31bb0db86c 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -197,7 +197,6 @@ typedef struct {
     int32_t   imm;
     int32_t   imm1;
     uint16_t  op;
-    uint8_t   codec;
     uint8_t   rd;
     uint8_t   rs1;
     uint8_t   rs2;
diff --git a/disas/riscv.c b/disas/riscv.c
index ec40abb618..9813d75feb 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4603,8 +4603,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
 {
     rv_inst inst = dec->inst;
 
-    dec->codec = op->codec;
-    switch (dec->codec) {
+    switch (op->codec) {
+    case rv_codec_illegal:
+        break;
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
         dec->imm = 0;
@@ -5369,7 +5370,6 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
             if (check_constraints(dec, comp_data->constraints)) {
                 dec->op = comp_data->op;
                 op = &dec->opcode_data[dec->op];
-                dec->codec = op->codec;
                 break;
             }
             comp_data++;
@@ -5407,7 +5407,6 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
             dec->op = decomp_op;
         }
         op = &dec->opcode_data[decomp_op];
-        dec->codec = op->codec;
     }
     return op;
 }
-- 
2.54.0


