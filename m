Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9513AEEE271
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotdK-0005s1-R9; Thu, 12 Sep 2024 19:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdJ-0005nZ-P6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:53 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdI-0008Da-7Y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so1409326b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185231; x=1726790031;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/P67wf325xKMcU48G4zBDiTLVG8mpptFQ7OMFFPf2ww=;
 b=ymQRmh0537hibBJHyq1XQQyKJcPpsHKBS3H2Nd6322uW3q+U/7YbV0S5c/J6fkbvAy
 VEqERTSaTYp99KS59glUijvQ552C562OnO/kHwEZsW8yjcu9wjhFxUZQ4yuCQWIvR5OD
 YbJosY9NoaFjVzMhteB+TkCY1Qu3SWRA3c07qiPVVjr9g7qxliqjqJMOd1nUN1ZnzpRd
 Ulk39D0aBvwYiPcjLx3xk87STwU0lZ5BYtlHu1CkV87UpPEx4ZctxsXPrbyZ0p9a7S2U
 1g22wkQOV+auYpiY2gdDLDdWTuyVWS2agTw34ZoHvNx49o2cXmpP32DGcmB/ak5H0njU
 q63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185231; x=1726790031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/P67wf325xKMcU48G4zBDiTLVG8mpptFQ7OMFFPf2ww=;
 b=YOaYM+T1pvNu/k+3FiJ4k8sUzPy66p3G7a1jrRzEG8DKHvQ1eFO8QSxDa7ZvXbsH+v
 lGHbq3tl2ldwDDH9Ep3Qg1z36RVlbhgfQh5BysXwWJSOVla3DGYjJeg2VMKulGMEKI/+
 TCiWiyIhemwp7vY0MAlue1mYGq02V3Qpk8Zcw8AEljwCrms9gfRhPFFKoRV0V3NlYKhm
 QcQswywi0MxCAFAPGpeUwrSTWdsOJkKdDwvtYCZKo0+eCsquFKOO1TON53jFatBOfRKM
 fc8RCMh6Xnnr+AA2GuBfZczEhWuFF8L1PB4+XiAEUc+3etHOUy+U2WR7sQkWRO73jRpU
 fHJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0n5oeQyZX8bn2Pv+dvzfdsgRBeMJl9oS6JSaZrhQaqD90R2zxEmc0pErSq+rNFFkLWrz1pyzvjkgS@nongnu.org
X-Gm-Message-State: AOJu0YzHEF4M0LdUK96Nxp6latUw/yICDSEXCYhXMmRcGX5Vo+UGvXyg
 kyB6+6P1J2e1jaATqbidXyRQ5c75XTQo7aAiki3+8AJLwFhv8rASBRPMORQSFxk=
X-Google-Smtp-Source: AGHT+IGsHZRakxi+bmgmrkFBUBklKoyreF5dQIDQVKdit3k9wYLwnY37WZIyy/gyzMiKwhw99Ldd7A==
X-Received: by 2002:a05:6a00:2393:b0:718:dc55:728a with SMTP id
 d2e1a72fcca58-7192607f65amr6710518b3a.8.1726185230943; 
 Thu, 12 Sep 2024 16:53:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 19/20] disas/riscv: enable disassembly for compressed
 sspush/sspopchk
Date: Thu, 12 Sep 2024 16:53:19 -0700
Message-ID: <20240912235320.3768582-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x436.google.com
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
index 0f9ecd8a14..d557c0cda8 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -982,6 +982,8 @@ typedef enum {
     rv_op_ssrdp = 951,
     rv_op_ssamoswap_w = 952,
     rv_op_ssamoswap_d = 953,
+    rv_op_c_sspush = 954,
+    rv_op_c_sspopchk = 955,
 } rv_op;
 
 /* register names */
@@ -2248,6 +2250,10 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd, NULL, 0, 0, 0 },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush,
+      rv_op_sspush, 0 },
+    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
+      rv_op_sspopchk, 0 },
 };
 
 /* CSR names */
@@ -2608,7 +2614,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -4929,6 +4941,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
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
2.45.0


