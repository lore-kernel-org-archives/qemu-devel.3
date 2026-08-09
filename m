Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2B8C5AE49
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBO-00061I-56; Sun, 09 Aug 2026 18:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBM-0005zs-Vt
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:53 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBL-00087B-0v
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so1305362a91.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315190; x=1786919990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0FrZuXoDds3/Gdqu4dPVdbsHkEzGZXJO7vs0hM7/2UU=;
 b=D3VxlATDI1wih6Hpc5dafgxYowAbtxzPcL5CMGgRoDvFFmWbH5HboizaOrrhBXawb/
 A9wSa1PdOs2cpL/VRQW4v5y2lXRrsxIfmKGYq0TgFOdtYp1stY7X3Pi74jLhvq22L8sZ
 YJZOYxuWPYgdBON9cuVhqQrDkrnoKwRi1kIeTglzZNCUqrfi6b9I/zC5hARKONgmH3ov
 ays7361ApBpwg3AysbAHn5LYPZjpiUCff24VK8Kb5VvhfHp7KnJhRz6huMLAar6CQ4pM
 DJyVrJHUFCNb56p3eRsZ3mXwEabjRYovAroE4J8zN3gzBWDI+7GdPFoodRMZtz4c/zyv
 0IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315190; x=1786919990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0FrZuXoDds3/Gdqu4dPVdbsHkEzGZXJO7vs0hM7/2UU=;
 b=RHlFWZtYSmWBn/mkXx+Ygyf5cKh/MQuDc2nDVB+QNPsaxj4hjaxwitLfCcPX8uN58A
 URLfEVvJ5mR+S7Bdo8PA1LIcSixhs/DsNvWLV95B2n8f/wVNHJF6YpUnUWi2Z29UWdpk
 TTMD6R6zY9/GbUfcHE4u7/zPjo+hiyykkn7hiQ0Fnf6aIztfyNGKE+vAhqO0jSVmmd6h
 2HCOMNMjvP7weH96ANgXzdbEdqcvTVzt1pwi1CVOeLp1bHrQ77kFR3eooqw4NncIR4o/
 5Jb1MOYL9FXXdRjR9RyNYDS/Q0Vf+BrTKOYdwXPLrLEqzxg+s13H9zfnHVod/pkOOw4R
 ulSw==
X-Gm-Message-State: AOJu0YyZGgO0qRZ24GqA3bprxUm/bTLvm90pVzZVUYbo+bscS+nuwHEd
 /zjoqjTu59w2FTjh2qq7XhmCKLlAH5q1qkORXLwLQaHabB4cU3XpBhziH+blJubWiaLwFPZ9FOR
 Q1eTW
X-Gm-Gg: AR+sD12AfpABpJN4oDwjjoJgt09yC/nXoG2BZI+VIDDKLxDj46s1VGIiF35MgnjCiMX
 sG/e9NWZ4JNDCuz+B6NVcvXbOIiFMoHeELp1EZR4ro5mDt8GIFFQ8YiicBdTIsJMRUDfF42pMPn
 LVTr9FMbr+tdgxwj/EjZ1RpvTUp4cFxwQge0dsiv9rR89eIwI6+rbsE002LIJA/yxQT1JIZ4wEm
 Gmxnef78rLLt0+t2FqIOTHVzjpJwTP8bEwqpB9kRIFTeWm0YNX7GOG3SjLjccooy9rkNLrpxOCu
 BY9KAreN+pNhW9B5iY8CgtObfHjDGYLISTTwoIHu+2eaUESCdRFCQQhPEjq4E7WE/ZjCx5aM6yL
 X9Ut8qQIZ2N/o0U/zmgjiaQD2c4wjq3YffBjmsOfqYS0xqm2dj1o9dBMwjxHclCbZXkr4iKHLiC
 iBhwwZBaWu19dCSXdBMrbA/YCyNyo/Eshnw9FrvM9HIzABmqyR3hBUCHu7XxbX39AxZm9OHWdQj
 vJkcLys8bLeMSynLRFX
X-Received: by 2002:a17:90b:2f03:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-3903c53404amr40091300a91.7.1786315189577; 
 Sun, 09 Aug 2026 15:39:49 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 54/56] disas/riscv: Tidy decode of mop.r.n and mop.rr.n
Date: Sun,  9 Aug 2026 15:35:43 -0700
Message-ID: <20260809223545.730664-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Merge nested if's.
Reuse operand_mop_{r,rr}_imm for zicfiss decode.
Return pointers directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 59 +++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9682e6f5a5..94d1ed1e20 100644
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
2.43.0


