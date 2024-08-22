Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3887C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh38U-00067C-4X; Thu, 22 Aug 2024 04:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38N-0005fr-Vj
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38J-00061r-Ln
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20231aa8908so4819595ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724315126; x=1724919926;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak9PVtm0xOUDnaFvLdvWza9j+CseOeqPaayHYoeyFwg=;
 b=WkpfESniFv8uOsoB7KgLx8Dupcc3YG+7nb7yDHAjbG9MoGDWk9p5tve3EwT7S3eps1
 RMplVEfLCKo61HWJOh1bDciiUYqEoZF8s3OxZ+wY/ctyT9p7+qmT5LgfCsbl2397ULKH
 8AzQSXLWLiZk8vfEyeLNXn+GVwiy1LPpfpzhFLiZnzxmtGYZ4GZTGo4by5FecaFhTQpH
 yT34naNDX01gBrA9NfFTboAcFOVX1QeuF2DGkhMg9RIMCYN4d48yz+fg6j5l7fuzBFGU
 qFzfYSmSTJTeTsGvxtYdHqjGv2A0oVWAfYNwEfv6q6ThBaGvXizsTTAu8BhfsbPL9Jdx
 Az2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724315126; x=1724919926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak9PVtm0xOUDnaFvLdvWza9j+CseOeqPaayHYoeyFwg=;
 b=JOZW/9JYSrbtURsYRKgm4ulhKkoxB9pPCsbvrRfvSMkVlQA8ONHl4jqx4ACSiivTv4
 uGVGSq5Rj9OJ3+bzuH9j44/inJKkg+EOlEv/0RE3kwRO9YcYBLPdQdVghDw99QtipxrO
 sSm7CJc59yMfzhZKcGs7wPmq10Ev7MBzqKOYWkYjCgf8eKa83/62dI1OKGl46eIRNE6z
 IuuHgUfoF7mibhB3ALeiGkr6gUz79P80RZoHo1lnWltsHb1eB5jLtiexlCKGmqa/eRPl
 92RzRTNbFmAiA8ju2hz/OL4zHiThlizb8KrbZH/g1uguTE1HeLx2LPqXMX4v7k4WuQ+O
 GDJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHr888ItYmt9lBrBTKJxCQrZLVe6KCfThqg7isSXlNvMgOeAV/qKLv1RMfs23Bel6or5lEVUoBvN/X@nongnu.org
X-Gm-Message-State: AOJu0Yy93ySavOdW5hyqRddLAp7SP35adSLCgpLeCVm4W8AYdsi5YPDd
 6d+CGnYqL4aOlgG+Pk0NoYwpIGiEWoUyqnFnTDP5osAyiiP0KoV3aGf1iF1/XUzzaZK6LNZZGQH
 l
X-Google-Smtp-Source: AGHT+IEzPRWxcj1XUV1wkS5lu8tkh3S4g0jYkYjA4YXDJRiNp8ws81uKE1wnj/ZBFjMiaikqKpBWZA==
X-Received: by 2002:a17:902:d2c3:b0:202:2e81:27c7 with SMTP id
 d9443c01a7336-20367d56b79mr59191085ad.35.1724315126149; 
 Thu, 22 Aug 2024 01:25:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385589225sm7641295ad.115.2024.08.22.01.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 01:25:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v7 17/17] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Thu, 22 Aug 2024 01:25:03 -0700
Message-ID: <20240822082504.3979610-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240822082504.3979610-1-debug@rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
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


