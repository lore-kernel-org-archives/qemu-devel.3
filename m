Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B0C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkm-0004VV-Uj; Wed, 19 Aug 2026 23:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkI-0003lo-HZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkG-00049V-To
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:14 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cf452def93so3677065ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197631; x=1787802431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qht+Lyy6ya77fhoK8407K/BbvZSE066z6kEHDiB1ixw=;
 b=AjbGck1iqubos7iBfXFdyBYsKVF4+Q5zyzng5aogr3D5AYJDaK+H/ZpACcjR5oEham
 5jXItmhqdZlf8PVeV0szgSs1BFMSmyxgtTn5mc7W9nDFd0VQP+MUPzY8oVXtXo5mTi+j
 Zcn9rYNe9RSWJaP0QtDZkg2hQG3NuM0RjWdMAErsnsdMLgXqes1jp7KYa9ij+ECy0saa
 7sDfxcTcOxjpay5FxjC6dt1xpvIF9CX2sw7d4Fd1C9uNdcqv4UY+gH2Ya8R7MpSscSrh
 rkZ/mXUVMbwy3IIb4p4/Zwn+8gyuF/Fea5UW8nvv7IaSFRvR82OSL9cU7BcCCI+dpCOT
 udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197631; x=1787802431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qht+Lyy6ya77fhoK8407K/BbvZSE066z6kEHDiB1ixw=;
 b=IW/gCS2pR2cXSP2q9AE5eJDmXcixlnk1awfTRjKC4xywvKPrEVCJglIVJttV9mKKf/
 6f2DI3GN29CK2/vxGcO+IhfGSIm2twhNwkHhwC3kP4lrs/ZcLZ53sKuLLL2WwGQhrz1Z
 dtu1Rh8zsVi7v9MbzrY+kN2knz0YeCrOGP+DpvgpnO1RIzPkwlDchoUExDbk/l/NyOjb
 x3rVSKXbA58kW0GcfNsyNO5+ZVBYN539/T56O5HEcV6Ho99UMtX/6yEZxCsCitCOyfqr
 9kIccuhQJ0ovdCqC3msQGGuUmav0e/vRClu1GIqbzy8lCmvNkzk381wpD2NZLC8W1hGo
 8fBQ==
X-Gm-Message-State: AFuF++nCfgsWiUHHH0/HSRC+2DV6Dd/p0c+NCF5Fvs3PSGEtvNbY0CcR
 UafoSmutu6sYTNq6S1ZUM4/SgcQKGtudGcdUBq4g2fH5Hp845Sagz9Ny4eiovg==
X-Gm-Gg: AR+sD12tXQTUq2jYJnJYYPqq9bw540pVACiQ0aGtO5YAXYFMjq1wl79uoI92vMOZh5t
 XdcFRZ7gmySOAxinmjPCI14aak/SonQunM+xDiD8l4wKIrWsZ0/SZNHgiIxpKa7dfxbYmbu5cLJ
 u+D1olAao5fDaAjOcdwFvKIcVTYNjSECQTilMnbL0RszFdDu3tRS2bXrjHkpvVIAA4z+ASql96s
 lQXDgFkxivbrPmazKGWkuNAOgjwYUK9boYwxSMxNsZ0Hb8jrlh8Fh+EVOykocJtS464zySLiYjz
 FjHOPJWUerglSc2lkA0g2rVpgj6PL0R1IzO4X/Fs7MpnACTtC6ezj2p/F8cS+31LlQ3iCsUnFPH
 CrYwIdgYQBW0gx9QIXTNf5Ki4hlrBDNoRg/T+uys2WmzorSIBntBQjknhUPzmOEAKqqAVF8mP+Z
 4qMz5hRedR2OdM02MzQCBSK7tnJYaZYL35Jk1lkTHUdJcHMQwlVkK0L16hEuAf7kJBKk98aNcer
 ueMXA==
X-Received: by 2002:a17:90b:3902:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-395a04ea8f7mr3957748a91.8.1787197631480; 
 Wed, 19 Aug 2026 20:47:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/93] disas/riscv: Simplify c.addi
Date: Thu, 20 Aug 2026 13:43:47 +1000
Message-ID: <20260820034430.1186695-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

While c.addi with imm == 0 and rd == 0 is c.nop,
other c.addi with imm == 0 and rd != 0 are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
c.addi rather than falling back to invalid.

Further, there's no reason to differentiate c.nop, since we have
  c.addi -> addi -> nop
vs
  c.nop -> addi -> nop
via decompress and pseudo translation steps.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-15-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8a957e6a1e..7978ffb378 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -263,7 +263,6 @@ typedef enum {
     rv_op_c_fsd = 231,
     rv_op_c_sw = 232,
     rv_op_c_fsw = 233,
-    rv_op_c_nop = 234,
     rv_op_c_addi = 235,
     rv_op_c_jal = 236,
     rv_op_c_li = 237,
@@ -1896,10 +1895,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw,
       rv_op_sw },
     { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
-    { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi },
+    { },
     { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi, rvcd_imm_nz },
+      rv_op_addi },
     { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi },
@@ -3010,10 +3008,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     case 1:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            switch ((inst >> 2) & 0b11111111111) {
-            case 0: op = rv_op_c_nop; break;
-            default: op = rv_op_c_addi; break;
-            }
+            op = rv_op_c_addi; /* or unspecified HINT */
             break;
         case 1:
             if (isa == rv32) {
-- 
2.54.0


