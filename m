Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5609C5B560
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBO-00061M-E3; Sun, 09 Aug 2026 18:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBM-0005zf-CL
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBK-00086r-6i
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1642259a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315189; x=1786919989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s37vUBaH0AOjJlqnT0JaqEyfZQb3/rLSBrzaNqBT7rk=;
 b=CBPYZIbSRC3mmR5+qvKBB6mqmx+e0sudAULwBV2nh3/xZecRlVJIEXIPDELjmdxOxp
 l04o8u8REdr3neDGUfudYs28uv0fpMrwYaU3XPj7zVcMSiU2hfEFBueE0taUur1gN+6G
 FFBCieFkYUmIn32zJA/LWzXdTZoZJ7ytvVDOvTJUzJLF7N3FaM0GAJ6l6EWgB6gV7SFP
 5kQ/iWuD54x1qGlYtEtcV3djJj2LQWYqNn6TnXzn92j2XsphovYwbDD/k3Zr+U0Dnpz7
 /hd1stZsFrVq6wj1ICO/0F7Nd/k8EEVvqIgWWut3PGORwPeG/p0Ke5FEN95kt/HfUk66
 Ry5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315189; x=1786919989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s37vUBaH0AOjJlqnT0JaqEyfZQb3/rLSBrzaNqBT7rk=;
 b=HCW2nd2TlRAmI6PL9lGLct6BnFa+UccGXF4uALD4+QL86Jzlr7Xoc5tZUHD286RCv5
 ciZSkYLUvkdBh0znTnJsr6bv1QAuzyxKMey2a/nrk/uLdZ8rLjBSMRDhTlxoXbGVOe2Z
 XPIItbeZAjs1NqtKX3CC8rFBsbhntxKWXcsABFG/cTgIc+3rqrBsSF+3rORCfvqQ2fiQ
 9UZNry6uu1nTSVHCJSl+aW8i2WXj+vfXLLgNmiVNdfHQ+N3Af+gaIO6GLXQu6KUfGpxs
 R8OBU8s/LlTU4Su0FgVJgNaKTS5wEAg9I9YtoLr/ecrubDX1PmBmhh2BROCUrzxzZPUc
 Hvaw==
X-Gm-Message-State: AOJu0Yyd83V+PaqyPChZRAq49oglAf9wKyfSdtZSMcL2hXq96HfRaTmW
 sh0I50B6THbjVOQinqNviMfqytajufbe4M1F2R0YQvK/fx16Rk2aQBCpulPfGrYd6dovBeB8ggX
 4rA/s
X-Gm-Gg: AR+sD12ZxLr/4EdIJ720HITvSlSewUddsLUPnNyelGnr9D8DQo1Vs6jGEjKpZAoTv4n
 7RmZZPfA7xRFXQtrtO7gzyJeFDSPZGkj/+ho12PYxCJ3KLEBtkZI9qZ8BsiD1UED1JL4njvbquH
 KgFPWJYmYikO5uHks1I/j7gd7RXnoN4AvtnEMbjXZ94iwC3sL39Xl1eyjhr80IPlKXAIvtOsIf/
 //PkIlauLF+lkwNtuGUK5FXRK35vEAAmrAo1FZ+StSPNArS2PogSA/TrBIsccH8QrZtOFTuIXwa
 siNBLJB0dHEe75+5KDOraNGXqUh+z3yEpqidT2a8lbI2rXCCNFv9aIj0mBMDWesOYunTgSC/kPl
 AucEXbJPO+8KqKjygOQEETiEinDDHM72+3r9A5l8aFDXCWQFj4Brfw5/V+2GoYYtg92iHy9KT3G
 CR/cqlrJ7xyMs8XY3yeCfFYJLSAzqstB1tb5dhbkg+4PnazZ0QverHqoESv3myse0R2kp8/gSQ3
 ENJfMkzPGvd3Dv6l225
X-Received: by 2002:a17:90b:2545:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-39261feb6a2mr21105031a91.8.1786315188727; 
 Sun, 09 Aug 2026 15:39:48 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 53/56] disas/riscv: Tidy decode of c.mop.n
Date: Sun,  9 Aug 2026 15:35:42 -0700
Message-ID: <20260809223545.730664-54-richard.henderson@linaro.org>
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
Reuse operand_cmop_imm for zicfiss decode.
Return pointers directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 89c2e63941..9682e6f5a5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1027,18 +1027,17 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
-            if (dec->cfg && dec->cfg->ext_zcmop) {
-                if ((((inst >> 2) & 0b111111) == 0b100000) &&
-                    (((inst >> 11) & 0b11) == 0b0)) {
-                    unsigned int cmop_code = 0;
-                    cmop_code = ((inst >> 8) & 0b111);
-                    op = rv_op_c_mop;
-                    if (dec->cfg->ext_zicfiss) {
-                        op = (cmop_code == 0) ? rv_op_c_sspush : op;
-                        op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
+            if (dec->cfg
+                && dec->cfg->ext_zcmop
+                && ((inst >> 2) & 0b111111) == 0b100000
+                && ((inst >> 11) & 0b11) == 0) {
+                if (dec->cfg->ext_zicfiss) {
+                    switch (operand_cmop_imm(inst)) {
+                    case 1: return &rvi_opcode_data[rv_op_c_sspush];
+                    case 5: return &rvi_opcode_data[rv_op_c_sspopchk];
                     }
-                    break;
                 }
+                return &rvi_opcode_data[rv_op_c_mop];
             }
             if (inst & ((1 << 12) | (0x1f << 2))) {
                 switch ((inst >> 7) & 0b11111) {
-- 
2.43.0


