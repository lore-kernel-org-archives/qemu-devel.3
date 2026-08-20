Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B797C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlw-0007TH-2U; Wed, 19 Aug 2026 23:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlt-0007LG-92
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:53 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlr-0004S5-Ju
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:53 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so1520201a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197730; x=1787802530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kp+RARhuhB9eCydGM0toopCbuCJCJESGSSluyzS3iH8=;
 b=g8AQQa4QV9WbVpPZrqkE3BTZ5NZGSPhdjmT+zF6PHivl64M8VuNC9n+01rD9bdCAlU
 vjQ76kJ1OPQieV7+L3Xg47hQnV5mSC7ttqq3dpeqtgDS+e0qEIf952xZ9hWrjTFI0EW2
 2zhY2PhJMITocyIFHTtKHGXgXYyA60zv2e1/58Rhz88SEsGJt/UJTHPQvWf3Y2hDTZv2
 TxREhc53mkALHDIXD91jMb56xdIqMC3PutpKg+vmtDe2Erx05lKnSwn8OwyzWy0mvEp4
 Y2mQ6gKo7NoiOiql95kgjmZLCCo7jerlanyplgPm/hdQ4pJZHdQBaX6FP4pjCxJm48sa
 hU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197730; x=1787802530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kp+RARhuhB9eCydGM0toopCbuCJCJESGSSluyzS3iH8=;
 b=R1+2HkxbqSJr8gIcbskDXupAP87BdPt3glj/AFTCmiThAUigtxLbTjhnWeKiRhnaTP
 9OcbUjCbN0YdMHrp+kSCpVqLqHFOAkabAWjqIC+kZazmSYyKwTWPJUOajjz505/YZjd4
 ry9B8XbJ1gG3CMqPRDLfBM9oFjeHtzifsDeOMRyRTWgdu9YKasQtNVZCC9FaJqrycBZh
 +HdD7F59JBzJz+49hxAUt64p21OgYSXWsTNiS5gjNDWOPpgI/NE9BtYfGECvI0vUr6jm
 4GIwca6/e1oKV3L22hpGrbPWlq5whO554+kPWTi3eo/DM3ZqZ1rSeNIm1Dt2itV4WjgW
 Nzyg==
X-Gm-Message-State: AFuF++nQDcZ3IJbk4aDM6flh1hOZcJFaN9+qsbZzbMeH5XBpcoFOTTCN
 V2NKM7tQB4elyrT8lNLB5h6TYJDLRwEPVJcy3ROO3RTSWtXUPlc9a1fuIFxKwA==
X-Gm-Gg: AR+sD10VyU1HMGjlt/X2dqIYc/ddqos2GkzCHmFq/zZQQ6jPoydjIaeWDv6rpkkXgdO
 39yVaZ0B3ZeqGJBKlMLK8mkKQFP9MIf4WfdHYYWcavq8+WST3fzwDB+gVsmtCL3QrcvfIHAALha
 MJQOOxakIaEYX1SOWF1E6mnAkVdgmhAyQKdUwp1Hw7LX1hn8Oe6wN/E487N+UwfUqlTmLkZAvnJ
 gQU0QQCuLSkL3HO8o6u6vQUp6F6BBLefR6VX4ImEhkXEIya4TIIJu639/tgbSNCBncL2Olqpjjf
 l9wFFBYDN6gjY+5+kL+U0CZx1/mfN3FHdFhdRQgIIVzPhpYCPRKPBWkUpv3+8B2HRo7PC15fecZ
 ta9aCDPDYdomKBuarpyjy7FvVV0vwtOTzSODMGGYHgQY8Vz7XhLaXV9sVVTF5Oe8YAkORYyxYQn
 W1oYmHa2xheAyehjw5+IXXjmQjPAsKda2rukItK2pHB1SEU30CtO49Z1D+Cu1EuPAjjKKGZ8DvO
 u4+drvfBmrXuZhf
X-Received: by 2002:a17:90b:1cc3:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39580ace560mr18261872a91.6.1787197730312; 
 Wed, 19 Aug 2026 20:48:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 86/93] disas/riscv: Tidy decode of mop.r.n and mop.rr.n
Date: Thu, 20 Aug 2026 13:44:23 +1000
Message-ID: <20260820034430.1186695-87-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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


