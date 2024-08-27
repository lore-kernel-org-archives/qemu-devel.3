Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2683CC54743
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TU-0004EN-8r; Tue, 27 Aug 2024 19:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TD-00034c-BG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T9-0000sB-BL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2023dd9b86aso48558235ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800762; x=1725405562;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJJt5Z8SJGSqiOcjU4U+2C4uQqhkjvrrqsHIDsZi2XU=;
 b=oPVsE2HJKOcRgUz4I85zCIconsnrGoxGcqRrefC4jMuuyXbjWKONL//H7JvVOUoeiM
 PmHLR/+E+5/A7/vgqHxJcRZa1iPiclw06txQdv4AhiA8tkaeSFoZk8rKPYjZrByvU9ro
 9Ph84PJ+xwHZWl/RxbmuSNMILaYv1jgzBEjpetIdIY+xJqG18lTctqs8pPB99x9stA4Q
 JYVufWkKEPtYfTchNT1nWTWt+oIsG8f4HXYXSjfIcdsmVYaDslrhrNQdFwjKs/Swl+gV
 lmvmOUKfMyr+ze0IKA2dVXFGYizBknnW41aUvfx7Cl9XD52AwgDBuO9YWJV12Vl1kgFj
 xjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800762; x=1725405562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJJt5Z8SJGSqiOcjU4U+2C4uQqhkjvrrqsHIDsZi2XU=;
 b=f5A6hgHs8gp25VJY9F3Q0hKdX5TM81U9/77wHOB5wzMdE8SkqPF+QVhyL+od8yagOZ
 FGdMb+28rLCSFd8Zf2F+E16yYCxC5faffbeIjMFS7fWjplim1NyahiI85R0eac7Udugj
 Ugs0wH2/oTR/2GKB/oAI6RUFg2sarr/ymobQOgcRzBvFJCranjAJta2MZvCoKUODqqp7
 hX+Y/87VN/1WRhtIObWNHOuQuG2Qu+cn/5dgLOwl/lbAS3S071sV46F40iliJP2/b7sl
 PwwMc4JtOiX1C0TZIFcN4f7SWveGY/c2v6yZ3UMeFWpbxo2nFXhUdfnpBdSQZ3KL6/s/
 wxAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpoPJNOI3W2M07TKXiQG/S/bkdLFb/8ejzWn6FX1zPNG0B6755j+QVn/DC4JBd8I95i3uott26Rd2z@nongnu.org
X-Gm-Message-State: AOJu0Yyi8bqSWIO0zv2oI7PpnbtZfNwb8aX99xBfpU+AQB9/WGpyJlRs
 waMeYlsJRtg0EFdef2x7t2cJyspA1T1XhldbPgCs565essKxwep52Xoqm4HO8D0=
X-Google-Smtp-Source: AGHT+IFutze4KoqjpsYfit810Yp6k1dQlQaQlCZ2mx7VcqEhGJm6rSLtzRgjGMHQrPQt+ZaP3TFv+w==
X-Received: by 2002:a17:902:db0a:b0:202:1176:5e2e with SMTP id
 d9443c01a7336-2039e47b895mr159119345ad.21.1724800761816; 
 Tue, 27 Aug 2024 16:19:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:21 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v10 09/21] disas/riscv: enable `lpad` disassembly
Date: Tue, 27 Aug 2024 16:18:53 -0700
Message-ID: <20240827231906.553327-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x631.google.com
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
index c8364c2b07..c7c92acef7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -974,6 +974,7 @@ typedef enum {
     rv_op_amomaxu_h = 943,
     rv_op_amocas_b  = 944,
     rv_op_amocas_h  = 945,
+    rv_op_lpad = 946,
 } rv_op;
 
 /* register names */
@@ -2232,6 +2233,7 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "lpad", rv_codec_lp, rv_fmt_imm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2925,7 +2927,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -4482,6 +4490,11 @@ static uint32_t operand_tbl_index(rv_inst inst)
     return ((inst << 54) >> 56);
 }
 
+static uint32_t operand_lpl(rv_inst inst)
+{
+    return inst >> 12;
+}
+
 /* decode operands */
 
 static void decode_inst_operands(rv_decode *dec, rv_isa isa)
@@ -4869,6 +4882,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
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
2.44.0


