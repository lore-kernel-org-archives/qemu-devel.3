Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52993CF042B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2D-0000GW-LH; Tue, 08 Oct 2024 18:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2B-0000FJ-J3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ29-0003wa-QV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c693b68f5so78515ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427824; x=1729032624;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpvZYJph47UbMl7k6pfcf7IX44LlneT6ofd0Ip0BFwA=;
 b=PSi3qFPxkcJ7qWTJKlNXxkPcGzruE/fpbh6SRvXr3yAM050QleXVc8QXMbgiZIOwIh
 ok9qxwXVBOZkktIf2mZEGWCaWp0aMGoLwzJbptyfc+eUDeoeo/d0ewDPjGlhuxOzs0/2
 sHFO0eXEAYWlzRv1gW2eC4+kq2okqX91vZr+1fc7Lh5TxEbnItGJuHlnqPgGirHjMY9m
 7XZ2SRvLT7u5nRz0J3Jgvp1WG+2OTJLNosQgeBduOUr5DaNswKBClX+JTywqPzrC3V4Q
 HVMNJpwLV+PJvZ/a3mCxY/QQHjWp1sPotn8WFqtj4QN27JsJh9cowz28SfCAaiC9V2XH
 nx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427824; x=1729032624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpvZYJph47UbMl7k6pfcf7IX44LlneT6ofd0Ip0BFwA=;
 b=YPH5B+csquHxYDm/tVqwTB4z7bjenGPWyEFOc4YRkIX0CE2EHVu4harBuAODDqMv37
 Jh5KFn3eiJN6ZUxnVpV4lAjNgR7uMJ4BHyv1Cv9yy2fKWH8Xsn7/rbA6b/KU+wEEojQn
 MDJxQIM+mxTsBKk+pqrdEsrou0KnUnM/En7P+m0kzTqdMxSPsw7xDFTDskbE0pP495/T
 j9zhQjh7brbHtWZyUrSRJ1KDYNGvx/k1DmKuA8e3Jge/vC0KExRCPCbji3rem1zf9caO
 tS1TR71J8VjphgNzNWNnyXMWwvKOreBSZRf0tiSyzaF90gdCgGp7EW+KawHdp76I3Fd+
 rvQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAwT5XD64yeyECZyJUxYEei8zAJ9pkDZUN7sj7fqvzGrC/1w8I08JOc8EsvHGznaGXjSlM+rwbZB8e@nongnu.org
X-Gm-Message-State: AOJu0YyMBRR2LtTzwFQ6vCXvv7nYRs/J+kHaBGMXjSmnXSb05vCizuyy
 8798KaLG9EP7Y4w+SvgULr4YKAjydOm8z5LFGQqtIXKvO0zcWTFFwLRqL5euXOI=
X-Google-Smtp-Source: AGHT+IG12vn39VWr/udr+Bq7G85Hvn+0B37oGRBC/8SfSGeoGHdVkhJMiQMS8XSZClViZ3IpucX5lg==
X-Received: by 2002:a17:902:ce8e:b0:20b:59ae:fe08 with SMTP id
 d9443c01a7336-20c6377d18amr7277135ad.42.1728427824493; 
 Tue, 08 Oct 2024 15:50:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 08/20] disas/riscv: enable `lpad` disassembly
Date: Tue,  8 Oct 2024 15:49:58 -0700
Message-ID: <20241008225010.1861630-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 18 +++++++++++++++++-
 disas/riscv.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 5965574d87..2942a5800f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -976,6 +976,7 @@ typedef enum {
     rv_op_amocas_h  = 945,
     rv_op_wrs_sto = 946,
     rv_op_wrs_nto = 947,
+    rv_op_lpad = 948,
 } rv_op;
 
 /* register names */
@@ -2236,6 +2237,7 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2929,7 +2931,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 7: op = rv_op_andi; break;
             }
             break;
-        case 5: op = rv_op_auipc; break;
+        case 5:
+            op = rv_op_auipc;
+            if (dec->cfg->ext_zicfilp &&
+                (((inst >> 7) & 0b11111) == 0b00000)) {
+                op = rv_op_lpad;
+            }
+            break;
         case 6:
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addiw; break;
@@ -4488,6 +4496,11 @@ static uint32_t operand_tbl_index(rv_inst inst)
     return ((inst << 54) >> 56);
 }
 
+static uint32_t operand_lpl(rv_inst inst)
+{
+    return inst >> 12;
+}
+
 /* decode operands */
 
 static void decode_inst_operands(rv_decode *dec, rv_isa isa)
@@ -4875,6 +4888,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = sextract32(operand_rs2(inst), 0, 5);
         dec->imm1 = operand_imm2(inst);
         break;
+    case rv_codec_lp:
+        dec->imm = operand_lpl(inst);
+        break;
     };
 }
 
diff --git a/disas/riscv.h b/disas/riscv.h
index 16a08e4895..1182457aff 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -166,6 +166,7 @@ typedef enum {
     rv_codec_r2_immhl,
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
+    rv_codec_lp,
 } rv_codec;
 
 /* structures */
@@ -228,6 +229,7 @@ enum {
 #define rv_fmt_rs1_rs2                "O\t1,2"
 #define rv_fmt_rd_imm                 "O\t0,i"
 #define rv_fmt_rd_uimm                "O\t0,Ui"
+#define rv_fmt_imm                    "O\ti"
 #define rv_fmt_rd_offset              "O\t0,o"
 #define rv_fmt_rd_uoffset             "O\t0,Uo"
 #define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
-- 
2.45.0


