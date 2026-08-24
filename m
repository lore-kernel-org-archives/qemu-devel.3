Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC21C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNc4-0007dU-ES; Mon, 24 Aug 2026 01:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbm-0006Tc-2j
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:34 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbk-00039F-AK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:33 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so2463255a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550751; x=1788155551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kp+RARhuhB9eCydGM0toopCbuCJCJESGSSluyzS3iH8=;
 b=T8t7odJW/gMP5IKJboBOYb9UPZCNEcZEnt8MV35BkMA1sk7UkKHkGtyvgxIalvR89E
 94Z7ETLF8NBcXQMilMvtJdq0mozYYsve+yQ99v6dEGMtIXphT/euENcsAYtMztgdeJEE
 my1xH+SNB5/+odHuT/FSsYJU/om54fHSgpnl9CRm90/fPk9iaQeV4y70Q3m1FUlFcUM0
 grJGQLyx4d8dvIpaUxzbfG8tnYIk7hEY6Qo8qAy47mvCy9tJ5W4bQBae9sX6PElhWpP+
 g4EGO72DGYH2VMl3+NqJnhGkWr14Qitvtfvi5oQk15Awp7of3iKDNeMnTKptBcEOUc69
 dWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550751; x=1788155551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kp+RARhuhB9eCydGM0toopCbuCJCJESGSSluyzS3iH8=;
 b=ETmlNueS+pi9kwLg6VQWnJjlpCqsKqsB1H3rxtfMjH17gViQNkz18/PMsuXaI/w05m
 8CzD2MMIQUxqisDGRr+LupJr5/pghSCAPXx3qLqx4B+4nFJZjDidPfZzOWQqm79dnS0p
 2iMn4kiE9aJrB96jJRRt/vhX2RiYz/u4UhZcBMrkE92hSHZzFZGLtmprZfC1jQ5/jvfB
 bZAcfOczy2XdJ7HBSq2KGYC7yVEiQidufo+Ifmn3flsRpbQbU9jQNiwlq8yYZORYhwMx
 eVYo+y5dYq4/iRcQ7RJaUkexc/+R5UvyLFM+SF1yXqwRn5iEBpT1z88Y7a20u1NHfOKn
 kmdQ==
X-Gm-Message-State: AFuF++nHX/pEhE83icQ6DuX8feUznyYtrphgczEb9tEE595+rEpja9Ej
 KL/rBJJpQ+Pt5PRZN6Eitk/MLieO+u16ts0YvVZ8+DQx54fR5qfjU2clcygtkg==
X-Gm-Gg: AR+sD112rJZOaytkJw+gqfIUlFfVekKX2oLMDiC7vb+AsugjV7b+I4xQjBkQpC5JS5t
 sbXDdLpedvZ3vGnQly9u+aX8PGQhT3bSSXQK580iRiys/fm8enze7mARxDTuFaIvt3NXNkjHzl7
 LA4BzJdR5IFrMGds4JSOqW5LJ8wgDgJ8mku2OsQqALmYNDIRWogNbiSzVr2zFf1/oQer+E2jJpc
 W0fg2TUaKUVqtO3fUMj32WUXb9joT1Xuox+R5HrTino70/TPAG6u8/RRTdKeWRUACF2RTVFTLjM
 QTY44uUbV9PDXZuXISFNxhx6IRgBRBWdrfMpROz+t4YbGY60ykrsGN5Eqwb8BaC1KbKaJhZqLzb
 R35akAtsGL3xEIe2nNjnO5+SZcfPqxq8+rXfIBqmZLCS5zN8PGZjrWluqetCGNZfZuU6yKRzm9D
 RFg2b2cU84lp8eqf/HqNtGzJ25Mb/Utu0b/noRpRS3YHgy5PsPowvWw4oSE4K4tzmTj/rBJeEHK
 YTerw==
X-Received: by 2002:a17:90b:53d0:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-395c359a74bmr42151189a91.12.1787550750929; 
 Sun, 23 Aug 2026 22:52:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 83/96] disas/riscv: Tidy decode of mop.r.n and mop.rr.n
Date: Mon, 24 Aug 2026 15:47:53 +1000
Message-ID: <20260824054806.2790041-84-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

Merge nested if's.
Reuse operand_mop_{r,rr}_imm for zicfiss decode.
Return pointers directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-51-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 59 +++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 197eaa43b1..7ea65ba2e7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2555,44 +2555,33 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 3: op = rv_op_csrrc; break;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
-                    int imm_mop5, imm_mop3, reg_num;
-                    if ((extract32(inst, 22, 10) & 0b1011001111)
-                        == 0b1000000111) {
-                        imm_mop5 = deposit32(deposit32(extract32(inst, 20, 2),
-                                                       2, 2,
-                                                       extract32(inst, 26, 2)),
-                                             4, 1, extract32(inst, 30, 1));
-                        op = rv_op_mop_r;
-                        /* if zicfiss enabled and mop5 is shadow stack */
-                        if (dec->cfg->ext_zicfiss &&
-                            ((imm_mop5 & 0b11100) == 0b11100)) {
-                                /* rs1=0 means ssrdp */
-                                if ((inst & (0b011111 << 15)) == 0) {
-                                    op = rv_op_ssrdp;
-                                }
-                                /* rd=0 means sspopchk */
-                                reg_num = (inst >> 15) & 0b011111;
-                                if (((inst & (0b011111 << 7)) == 0) &&
-                                    ((reg_num == 1) || (reg_num == 5))) {
-                                    op = rv_op_sspopchk;
+                    if (((inst >> 22) & 0b1011001111) == 0b1000000111) {
+                        if (dec->cfg->ext_zicfiss
+                            && operand_mop_r_imm(inst) == 28) {
+                            switch (operand_rs1(inst)) {
+                            case 0:
+                                return &rvi_opcode_data[rv_op_ssrdp];
+                            case 1:
+                            case 5:
+                                if (operand_rd(inst) == 0) {
+                                    return &rvi_opcode_data[rv_op_sspopchk];
                                 }
+                            }
                         }
-                    } else if ((extract32(inst, 25, 7) & 0b1011001)
-                               == 0b1000001) {
-                        imm_mop3 = deposit32(extract32(inst, 26, 2),
-                                             2, 1, extract32(inst, 30, 1));
-                        op = rv_op_mop_rr;
-                        /* if zicfiss enabled and mop3 is shadow stack */
-                        if (dec->cfg->ext_zicfiss &&
-                            ((imm_mop3 & 0b111) == 0b111)) {
-                                /* rs1=0 and rd=0 means sspush */
-                                reg_num = (inst >> 20) & 0b011111;
-                                if (((inst & (0b011111 << 15)) == 0) &&
-                                    ((inst & (0b011111 << 7)) == 0) &&
-                                    ((reg_num == 1) || (reg_num == 5))) {
-                                    op = rv_op_sspush;
-                                }
+                        return &rvi_opcode_data[rv_op_mop_r];
+                    }
+                    if (((inst >> 25) & 0b1011001) == 0b1000001) {
+                        if (dec->cfg->ext_zicfiss
+                            && operand_mop_rr_imm(inst) == 7
+                            && operand_rd(inst) == 0
+                            && operand_rs1(inst) == 0) {
+                            switch (operand_rs2(inst)) {
+                            case 1:
+                            case 5:
+                                return &rvi_opcode_data[rv_op_sspush];
+                            }
                         }
+                        return &rvi_opcode_data[rv_op_mop_rr];
                     }
                 }
                 break;
-- 
2.54.0


