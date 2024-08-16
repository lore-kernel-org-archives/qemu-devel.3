Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BE1C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRQ-0001Wk-HN; Thu, 15 Aug 2024 21:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRL-0001Fz-Ge
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:39 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRJ-0002Nb-K2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:39 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7106e2d0ec1so1238828b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770456; x=1724375256;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak9PVtm0xOUDnaFvLdvWza9j+CseOeqPaayHYoeyFwg=;
 b=DDWUpNENryJm8h7nHxRuzHEn9KAXsQux5G56NyUSiXP5c5O3SeknNy9VGMrKb22AGe
 ACHbKarcnEgWB6qxgYcnz6z/uPQsxLpyHsPgu/6Qwf2oll8TF3JGWerkRH3sgPbUYiRK
 /ee94h/eQJkuDa8ZTmqN7KDXYC+nznIi7uzZf6r25A3tJiS/CFj3CaFIR5fyhiD9gcS3
 jAoi5S9hPMxtd+NyzDRti8bSH2xwJ3dvbQ4bx8nV+bKp4k0LVpWWzH4b0+9jT8nC/euA
 zkmuIRhAaqeOVuA9Y7b2vaZgdNd+pwRGO81vIg02QqWAKUOdoQ/PXVO2RQXVo5ytmrve
 ymAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770456; x=1724375256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak9PVtm0xOUDnaFvLdvWza9j+CseOeqPaayHYoeyFwg=;
 b=e/RvmKFuqNPDSugPVnQjmCQzGPw2IAhy1FCXjNxtBs3RXh/lh9t9MuiZQuqzqq9tOa
 Pzwb31I3zGhNIfeXKvG2CFVMYMAoO1oHggkppmC35ImEPGS8hGYbvGaSn2zYGt9yH1Oe
 tymszgI9pLdifa4XI8J5Xx6oqKfEYSMn3JZvkZH9xH3IT8fLbCr5m3SU7qh9EvCBbtit
 A7fOEL5Qwz98+97CqFi3hRRFwymlDSGsLubE1wqujTG2Yj6xu/3x7gkGXoOtpIKQ9Jmb
 hpCC6kjBzkhHo0/eLmtLcwModZzn3qFBxF7+4V4y0u+zO0pfdysB3Sf55CaX76B0i2Sc
 DHAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnM264ojlWZSZMhf5I9uOyZ6vKlISYca/nQ5En7Vy3RpMYtH7NeavsGX5+2QDWt8mDsz7gVwgch78oriZTRzFRWMSYjuQ=
X-Gm-Message-State: AOJu0YxIIAxVVsVuzhKVsbRzh+tP3ypeCCoZBYhWuw2fw+/lDURhrxMu
 lf0sF45oOQN8GyIwbBjkdC7w6wOtOaL0fixvQuRhC7ttfdraBTYV7VmiH2WmolU=
X-Google-Smtp-Source: AGHT+IFl0XfcM3JJIFbqs3Q3L1d2LhRDxfYz/olhKvSUvsQeClUgiFLngROG2lnDeGTxPhM1sY7l/w==
X-Received: by 2002:a05:6a20:e68e:b0:1c4:afb6:a8b8 with SMTP id
 adf61e73a8af0-1c904f913e0mr1900152637.21.1723770456140; 
 Thu, 15 Aug 2024 18:07:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 15/16] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Thu, 15 Aug 2024 18:07:09 -0700
Message-ID: <20240816010711.3055425-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sspush and sspopchk have equivalent compressed encoding taken from zcmop.
cmop.1 is sspush x1 while cmop.5 is sspopchk x5. Due to unusual encoding
for both rs1 and rs2 from space bitfield, this required a new codec.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 disas/riscv.c | 19 ++++++++++++++++++-
 disas/riscv.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index f1f4ffc50a..8eeaa9f843 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -980,6 +980,8 @@ typedef enum {
     rv_op_ssrdp = 949,
     rv_op_ssamoswap_w = 950,
     rv_op_ssamoswap_d = 951,
+    rv_op_c_sspush = 952,
+    rv_op_c_sspopchk = 953,
 } rv_op;
 
 /* register names */
@@ -2244,6 +2246,10 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush,
+      rv_op_sspush, 0 },
+    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
+      rv_op_sspopchk, 0 },
 };
 
 /* CSR names */
@@ -2604,7 +2610,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             if (dec->cfg->ext_zcmop) {
                 if ((((inst >> 2) & 0b111111) == 0b100000) &&
                     (((inst >> 11) & 0b11) == 0b0)) {
-                    op = rv_c_mop_1 + ((inst >> 8) & 0b111);
+                    unsigned int cmop_code = 0;
+                    cmop_code = ((inst >> 8) & 0b111);
+                    op = rv_c_mop_1 + cmop_code;
+                    if (dec->cfg->ext_zicfiss) {
+                        op = (cmop_code == 0) ? rv_op_c_sspush : op;
+                        op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
+                    }
                     break;
                 }
             }
@@ -4923,6 +4935,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
     case rv_codec_lp:
         dec->imm = operand_lpl(inst);
         break;
+    case rv_codec_cmop_ss:
+        dec->rd = rv_ireg_zero;
+        dec->rs1 = dec->rs2 = operand_crs1(inst);
+        dec->imm = 0;
+        break;
     };
 }
 
diff --git a/disas/riscv.h b/disas/riscv.h
index 4895c5a301..6a3b371cd3 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -167,6 +167,7 @@ typedef enum {
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
     rv_codec_lp,
+    rv_codec_cmop_ss,
 } rv_codec;
 
 /* structures */
-- 
2.44.0


