Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49F5CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nc-0001rk-Ju; Fri, 30 Aug 2024 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4na-0001lY-VU
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:35 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nW-000723-FZ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:34 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d88bff0b8fso206868a91.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036509; x=1725641309;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMVA2s6MpWOnwDBiOmB7waUQnW/LE7dtvxpEMEnCYXU=;
 b=Q31u6sYpQE4+YFB0/q1TwJw7Ak3mR2CGysPzpmDX0/vHbQOcX2dkAhA6uVm6hKQk1X
 DT7ttb6RSPJVd9CVflLNKuXH1AlZeg6NSgrpyO0cLeKuFYVSCLqek+Q7dtlyRj+uKevy
 pNPaq4J1dQ47s1H7xOvwOrb91nxGFSK/bu92h4ka4ZYbjNbJgYYQzgWg5FNtepRth4MN
 g9Hbj/HWfQ6llnUnHL/kFJF+eLCycc+gTmybZunhTRkUj3vLonlxPbonccx2xus/F/5g
 H5ba/pX+FXCkVzTMbQg8d8alpd7OAnkoK9NulT1oayW8VtR9Up2iUdTUMIiwDrKWAGcO
 yDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036509; x=1725641309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMVA2s6MpWOnwDBiOmB7waUQnW/LE7dtvxpEMEnCYXU=;
 b=S6Xso9J0xqu2bdr+3mOYWtJUmWj6Yb5lhA2txmdfIZQ342ie8oqLk3iVjEu/MHtbuT
 Yc4jCTfAf6MPJWdZabEEO2EywppiKaU+3iqSrEKJ+gjFCewXAyiRDBttETasjUjXGccs
 aY5UH35JeQo1MWdFyrMJgGMxGmXZ2Xu2y4fNcatulq19l4DQhPxdNmlfq0vAgILRVenk
 w046r6RzAxhitLPNiSv5U/Zbxo73DaDS0i6yatetA2aBnuzhZ3b1UckKPv5ZmJjx5kJw
 ssd8FI4nGb53Dqv1dXGvH4RyauliliqgE0OMfc8iMH78/7QqJeSMFfAEZPnFyn8S8Yop
 02Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5bZ3jw4fR5hFp3PrplVBlBoOAeHpcTASgBnolgBA7TTG8o9tDhuC7341C+bojesZFvFtqXodIecwW@nongnu.org
X-Gm-Message-State: AOJu0YzrFata2elvZiLW/376KhaLIoTQYqvpfrIcq+R2HZ98kgXrPEnH
 Yhu1M6azwQfOL9RxqW3fn+at8Y42ZZHkdtZGVfz4WQ5O3fIgk7oTMRwJtXYqN6o=
X-Google-Smtp-Source: AGHT+IH0E0fwfNTHgtaT7TyKEZDu18bO+Lo2J145mCvGnJvED++/d1Xt3YMPRcXJ4dmhjbxWnntM2A==
X-Received: by 2002:a17:90a:e612:b0:2d8:840b:9654 with SMTP id
 98e67ed59e1d1-2d8840b980bmr1540446a91.34.1725036509060; 
 Fri, 30 Aug 2024 09:48:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 19/20] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Fri, 30 Aug 2024 09:47:55 -0700
Message-ID: <20240830164756.1154517-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1030.google.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 19 ++++++++++++++++++-
 disas/riscv.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 5eafb7f7f3..6e9ba42edd 100644
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


