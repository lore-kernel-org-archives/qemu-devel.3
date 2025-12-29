Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A0D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 08:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va8vW-0001UH-DH; Mon, 29 Dec 2025 03:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zengzhijin@linux.spacemit.com>)
 id 1va8vS-0001Th-Sk; Mon, 29 Dec 2025 03:48:26 -0500
Received: from smtpbg151.qq.com ([18.169.211.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zengzhijin@linux.spacemit.com>)
 id 1va8vL-0004Nj-FC; Mon, 29 Dec 2025 03:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1766998080;
 bh=CswC8Rb9pFZatFilDZ6pwMvbkX/TJXCpyiYKpp7Qhdc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=IBT9INXx4ZODVtUiZYH8p3cLSa04ArvSC7/5MJcU1L3K2a7reFpVOykga/mYcSzjX
 /FREB15NzqpwquEAGwBjbnefzvwHvYxyeHtuH2aFX3sKFPDCYEycL/vZ+6i/kLxw1W
 +anEHrpxafIMvKLejg57SJgtgIcgBnZtnL0cdAhQ=
X-QQ-mid: esmtpsz20t1766998075t12f1b6ae
X-QQ-Originating-IP: WHI0eEDNFORSg8B8pMMJLfACyrsxe56rVDDGTYHf+mQ=
Received: from ZhijinZeng.dc.com ( [183.48.244.56])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 29 Dec 2025 16:47:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5362272422245591132
EX-QQ-RecipientCnt: 5
From: zengzhijin@linux.spacemit.com
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, qemu-devel@nongnu.org,
 Zhijin Zeng <zengzhijin@linux.spacemit.com>
Subject: [PATCH v2] tcg/risc-v: Fix clobbering of TCG_REG_TMP0 (t6) in vector
 code generation
Date: Mon, 29 Dec 2025 16:47:47 +0800
Message-ID: <5D809A625CAA1DCC+20251229084747.1428-1-zengzhijin@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MQaNw+J8Qgodkb9Tcl1wG8qTBYbzmGsJCqYapTJHzn/76YczXY0Ybke5
 XlWpsXMLo8SgqWdx/tSBjWyP3uXhWFC1HOMysabJQL7xXfwTJaFJoRBw9/IYO9bbn2E3kx3
 WiuNtB+gMlgt8fG3iraFesO9T31fr1AnQRDfKzE58rD0rxTEolwp+zn7RpaFYXiq5mEYrXm
 sDtQ3rpTs1jEubzVuVzCdN9e7XrSEVtucBqX2x0Q5rNRFn40ADgTpZUQ53GS0Nr4KaSPF/Y
 zV9tgpXybOMIaXtWd8jd4gHbfg9GUjMwGlzWS+W67agyocmRdqv4Qf06zJR8VZ+xx+JK4cW
 gRAQ0en5HAq34A4k3ZqoafWGor450cGUO+ja/yFmucIrcEGzEv3mY+kp+1L1d+yyhdGzei+
 ELOPdIe0LTWN3cjOI3y1MTwQD+INsdDWXGog0VakGfmzB/8+j2wBZtm4awSzvmx2iVFGGk5
 OVhlaIQgbACvX/Fsgd7wAAKbry93+FXr/h91/kDk0yQbpSa/BRQLogiT3YPhEjxSJMvoWHQ
 Y43IHKCY1+UH/W2+3PIyB+HqYJRfR3KDCRzJNee27NbNZu9Z/gL0nJY4fvCVZ9L81up6YC+
 t+RVfDoiWKfGNnDBmbjfMS3eKSNTwngn1c5orRLHCtESuvUPmtIngVrecTna+ZK8kf3ZRn0
 RLza0AgWVVTOIB4E7VPHAmfjeOmU8iTDBumtNlaK1dqYLeY9PCJu70kBxla0mmws9hNDwcJ
 +TueXBPMEuIOZ7VjBo3oCyC9PJDHbfvuseMZJxhCO5SiSx45/CBwktTLuvyJj8rd2b28uAv
 0lLWbRdCypqDAX551+4rU7KTPnHP7EUpkJcvHk2TOtl8Afoe9yUFo22QeeVTrIxC8elh6EM
 /eAwTH7fCgo1cZMRnMGOevlNGUKnBj3Bz4t8Z3CjBgH12nBR8f5BZn4gE6vQLNoCSoSSpIb
 ldG9Bai/nChe9RUlVNnSwhuxU8rXSgprmmG+FbM49roKD81yWs2rAhr1QA5OzgYtrn9I97U
 8Jh4JTeOFnEzxx1O40TSF7HIl7Jkv8r8cUxr9Mydr0/zhoo6kDdUQMtjMQZBg2zY6eXZ08U
 vY9d69CI75VAiIKsVAiz1wl5Tpj5wjal5FX62x26XgYf/zNtOQUToA8k5YiFsUYIkuIQzR7
 uxl8
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
Received-SPF: none client-ip=18.169.211.239;
 envelope-from=zengzhijin@linux.spacemit.com; helo=smtpbg151.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhijin Zeng <zengzhijin@linux.spacemit.com>

The RISC-V target currently uses register t6 as the destination for vsetvli and
vsetvl instructions to capture the resulting vector length (vl).

However, in the tcg_out_dupm_vec function, t6 is also used as a temporary
register. Since tcg_out_dup_vec may emit a vsetvli or vsetvl instruction
internally, the value previously written to t6 (e.g., by an earlier ld in
the same translation block) can be unintentionally overwritten.

This patch reserves the t3 register to be used as the destination for vsetvli
and vsetvl instructions.

Signed-off-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>
---
 tcg/riscv/tcg-target.c.inc | 10 +++++++---
 tcg/riscv/tcg-target.h     |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 31b9f7d87a..359021aa76 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -3022,10 +3022,12 @@ static void probe_frac_lmul_1(TCGType type, MemOp vsew)
         p->vset_insn = encode_vseti(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
     } else if (lmul_eq_avl) {
         /* rd != 0 and rs1 == 0 uses vlmax */
-        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);
+        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP3, TCG_REG_ZERO,
+                                   vtype);
     } else {
-        p->movi_insn = encode_i(OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
-        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
+        p->movi_insn = encode_i(OPC_ADDI, TCG_REG_TMP3, TCG_REG_ZERO, avl);
+        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP3,
+                                   vtype);
     }
 }
 
@@ -3070,6 +3072,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
 
     if (cpuinfo & CPUINFO_ZVE64X) {
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP3);
+
         switch (riscv_lg2_vlenb) {
         case TCG_TYPE_V64:
             tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 6dc77d944b..0f2dced8e2 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -55,6 +55,7 @@ typedef enum {
     TCG_REG_TMP0       = TCG_REG_T6,
     TCG_REG_TMP1       = TCG_REG_T5,
     TCG_REG_TMP2       = TCG_REG_T4,
+    TCG_REG_TMP3       = TCG_REG_T3,
 } TCGReg;
 
 #define TCG_REG_ZERO  TCG_REG_ZERO
-- 
2.43.0


