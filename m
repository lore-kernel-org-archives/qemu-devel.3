Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45423C5AD7B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBH-0005vk-C2; Sun, 09 Aug 2026 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBD-0005s1-IR
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCB7-00081n-L8
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1426821a91.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315176; x=1786919976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wrVOzQEoLp3rMXSEpQrDmR8U9V+/O+1y66nnFrsT6yo=;
 b=ZrZffgM7rpxt/KBC/Ktfv8Hm6q0hcTUpCd1zaqb5hb7Ceo6k5863PCogMa7eg1uvAG
 Gs8aL9lJPEl64QwvZpPlBTxuWp1twp97WaDtaC4U4SX2H2TZIxP3oB6lpF44CvwgA+Rk
 U7GAj0iRQ0JejN/g83dcw+Lw+fOZPrwXzUdFpDcc04d+I3irzWJ5764wbjecNROfhiGP
 gx3CWEsjymjkNKTYkkeJNzVXj6BgpgOdCCFVoKDuqm1/HDsHvto/BcAzDCmDgKqNnGpj
 qoIS8GmF0uUtyCRWKXDgoWXbvzUCJ/x2cR7VUc2eQaG0yIyZidFA+LeFs9Jz7qkQ3xoW
 y1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315176; x=1786919976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wrVOzQEoLp3rMXSEpQrDmR8U9V+/O+1y66nnFrsT6yo=;
 b=Wa3fYRh4X52vid0jgXwMA9eyTPFjiDBT+KMt8vG1/H1nlcz2tnFRtS7JU0UOUgQnwx
 h4re7XwoQT+ty2SanGjBnKqUGGJY/9rE27fOBBPdaF/xUW6L9UPFZSYUQk1Q0UnAv0p3
 Ukhvk/wDgZALkJeQrNylsi7Iza5n7isa6htTJYNvAlHZ79b8l7nlJzmtgcrE1ZSgBHze
 p2BjMfPokHNxfMbWxL31R1cmgvD8iOwN3swgw4XYqwsLJEARQRJoqADd/UH7xfA7b+Ul
 fyDqbUBW3WU8f9wm5dKfjdQZSfUDjCiW5xFsbYp/zrSjNyJKXcJHjTw3q0MvUFh3UcWG
 9PQg==
X-Gm-Message-State: AOJu0Yy9aDwx0VhlfbeFEIMcL4MYtDxOVJmj6qs1FmLEY4C4FSCIcWNK
 phbZLL8Jh9zjlq9sGzcp+s0XIWqNS88ueT40qrkbIkCmDEoV2FXLOOPAwM+UM4RnPwO2nIgJn0P
 hgPAQ
X-Gm-Gg: AR+sD10GLy9y3HAloR0gezL374FdsPHyK7s4N524JzaTrLENEcQ33Mh1Bb+g1v8CPMH
 N5Pf7M92s3SU+R3IR4iyaorwp4+5ayAJQ40gdHY79ovPQuOekiLHdIcRKMq83zgvHUf1DWY1x13
 x+aJGiJgM6Iuo/1GHIgLAB3wvdKX/2PatAOFDrGQ6V6gjDWZ5xHHX7DkM6NJI1B+N69iWIe/XOu
 b5A9KLPag4cQp7O62P5NWU52rgIqe2L8q1zWMsJRu9o6ooJgfTBZc7wB0C6pgp8WEtyK4T3VEkP
 Tay3AzmRha4rQc98/n6eGmJPoLaG4PpvU+109W65Hoxam4RAIeoZf7LyphWk6/HAk9CpSl4SJS3
 dEoq7DCh0HRuuoQcXRMYRtdOArq+j/so56wOs5gt0mmPRlrJUNTbdb3llU9W1CfmvTba9N8GMhF
 AMya02RsiuwjIr4YsBucbwJ5FYBvlUuiViQNN1eJELGWOVA9NrvcffNgsv+Aw0BLMhkbPKFrM86
 1K81+3/PgJnMIos9x5a
X-Received: by 2002:a17:90b:2249:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-3928242ffc4mr14190384a91.10.1786315175840; 
 Sun, 09 Aug 2026 15:39:35 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 40/56] disas/riscv: Return rv_opcode_data pointer from decoders
Date: Sun,  9 Aug 2026 15:35:29 -0700
Message-ID: <20260809223545.730664-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Rather than putting array + index into rv_decode,
return the pointer to the object directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv-xlrbr.h    |  2 +-
 disas/riscv-xthead.h   | 22 ++++++++---------
 disas/riscv-xventana.h |  2 +-
 disas/riscv.h          |  2 --
 disas/riscv-xlrbr.c    |  5 ++--
 disas/riscv-xthead.c   | 55 +++++++++++++++++-------------------------
 disas/riscv-xventana.c |  5 ++--
 disas/riscv.c          | 23 +++++++-----------
 8 files changed, 48 insertions(+), 68 deletions(-)

diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
index ebf3d4c133..da14f1b340 100644
--- a/disas/riscv-xlrbr.h
+++ b/disas/riscv-xlrbr.h
@@ -12,6 +12,6 @@
 
 #include "disas/riscv.h"
 
-void decode_xlrbr(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xlrbr(rv_decode *, rv_isa);
 
 #endif /* DISAS_RISCV_XLRBR_H */
diff --git a/disas/riscv-xthead.h b/disas/riscv-xthead.h
index 0c65c8e0af..f2160be8a4 100644
--- a/disas/riscv-xthead.h
+++ b/disas/riscv-xthead.h
@@ -11,16 +11,16 @@
 
 #include "disas/riscv.h"
 
-void decode_xtheadba(rv_decode *, rv_isa);
-void decode_xtheadbb(rv_decode *, rv_isa);
-void decode_xtheadbs(rv_decode *, rv_isa);
-void decode_xtheadcmo(rv_decode *, rv_isa);
-void decode_xtheadcondmov(rv_decode *, rv_isa);
-void decode_xtheadfmemidx(rv_decode *, rv_isa);
-void decode_xtheadfmv(rv_decode *, rv_isa);
-void decode_xtheadmac(rv_decode *, rv_isa);
-void decode_xtheadmemidx(rv_decode *, rv_isa);
-void decode_xtheadmempair(rv_decode *, rv_isa);
-void decode_xtheadsync(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadba(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadbb(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadbs(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadcmo(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadcondmov(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadfmemidx(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadfmv(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadmac(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadmemidx(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadmempair(rv_decode *, rv_isa);
+const rv_opcode_data *decode_xtheadsync(rv_decode *, rv_isa);
 
 #endif /* DISAS_RISCV_XTHEAD_H */
diff --git a/disas/riscv-xventana.h b/disas/riscv-xventana.h
index 1006c3be00..d28e84c7e4 100644
--- a/disas/riscv-xventana.h
+++ b/disas/riscv-xventana.h
@@ -11,6 +11,6 @@
 
 #include "disas/riscv.h"
 
-void decode_xventanacondops(rv_decode*, rv_isa);
+const rv_opcode_data *decode_xventanacondops(rv_decode*, rv_isa);
 
 #endif /* DISAS_RISCV_XVENTANA_H */
diff --git a/disas/riscv.h b/disas/riscv.h
index ab62c0db94..241dd47d7f 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -182,10 +182,8 @@ typedef struct {
     const RISCVCPUConfig *cfg;
     uint64_t  pc;
     uint64_t  inst;
-    const rv_opcode_data *opcode_data;
     int32_t   imm;
     int32_t   imm1;
-    uint16_t  op;
     uint8_t   rd;
     uint8_t   rs1;
     uint8_t   rs2;
diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
index d0092e9edd..b12916c9da 100644
--- a/disas/riscv-xlrbr.c
+++ b/disas/riscv-xlrbr.c
@@ -36,7 +36,7 @@ static const rv_opcode_data xlrbr_opcode_data[] = {
     { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1 },
 };
 
-void decode_xlrbr(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -76,6 +76,5 @@ void decode_xlrbr(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xlrbr_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xlrbr_opcode_data[op];
 }
diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 757d6ff39f..428a6380e9 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -246,7 +246,7 @@ static const rv_opcode_data xthead_opcode_data[] = {
     { "th.sync.s", rv_codec_none, rv_fmt_none },
 };
 
-void decode_xtheadba(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadba(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -272,11 +272,10 @@ void decode_xtheadba(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadbb(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadbb(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -331,11 +330,10 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadbs(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadbs(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -358,11 +356,10 @@ void decode_xtheadbs(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadcmo(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -437,11 +434,10 @@ void decode_xtheadcmo(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -465,11 +461,10 @@ void decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -503,11 +498,10 @@ void decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadfmv(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -539,11 +533,10 @@ void decode_xtheadfmv(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadmac(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadmac(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -571,11 +564,10 @@ void decode_xtheadmac(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -646,11 +638,10 @@ void decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadmempair(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -681,11 +672,10 @@ void decode_xtheadmempair(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
 
-void decode_xtheadsync(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xtheadsync(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -716,6 +706,5 @@ void decode_xtheadsync(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = xthead_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
 }
diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
index 4fb9a29d0b..a4e59312d0 100644
--- a/disas/riscv-xventana.c
+++ b/disas/riscv-xventana.c
@@ -20,7 +20,7 @@ static const rv_opcode_data ventana_opcode_data[] = {
     { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
 };
 
-void decode_xventanacondops(rv_decode *dec, rv_isa isa)
+const rv_opcode_data *decode_xventanacondops(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -38,6 +38,5 @@ void decode_xventanacondops(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = ventana_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &ventana_opcode_data[op];
 }
diff --git a/disas/riscv.c b/disas/riscv.c
index 171c60238f..c4b8ee7d07 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2846,7 +2846,7 @@ static const char *csr_name(int csrno)
 
 /* decode opcode */
 
-static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
+static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
@@ -4541,8 +4541,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    dec->opcode_data = rvi_opcode_data;
-    dec->op = op;
+    return op == rv_op_illegal ? NULL : &rvi_opcode_data[op];
 }
 
 /* decode operands */
@@ -5291,14 +5290,12 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         .inst = inst,
         .cfg = cfg,
     };
-    const rv_opcode_data *op;
+    const rv_opcode_data *op = decode_inst_opcode(&dec, isa);
 
-    decode_inst_opcode(&dec, isa);
-
-    if (dec.op == rv_op_illegal && cfg) {
+    if (!op && cfg) {
         static const struct {
             bool (*guard_func)(const RISCVCPUConfig *);
-            void (*decode_func)(rv_decode *, rv_isa);
+            const rv_opcode_data *(*decode_func)(rv_decode *, rv_isa);
         } decoders[] = {
             { has_xtheadba_p, decode_xtheadba },
             { has_xtheadbb_p, decode_xtheadbb },
@@ -5317,19 +5314,17 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
             if (decoders[i].guard_func(cfg)) {
-                decoders[i].decode_func(&dec, isa);
-                if (dec.op != rv_op_illegal) {
+                op = decoders[i].decode_func(&dec, isa);
+                if (op) {
                     break;
                 }
             }
         }
     }
-
-    if (dec.op == rv_op_illegal) {
-        dec.opcode_data = rvi_opcode_data;
+    if (!op) {
+        op = &rvi_opcode_data[rv_op_illegal];
     }
 
-    op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec, op);
-- 
2.43.0


