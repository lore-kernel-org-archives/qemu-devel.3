Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929EFC5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbD-0004xf-8O; Mon, 24 Aug 2026 01:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa4-0003kh-KC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:50 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa2-0002W8-Te
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:48 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca80d708489so1947767a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550646; x=1788155446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qht+Lyy6ya77fhoK8407K/BbvZSE066z6kEHDiB1ixw=;
 b=IuLNFWP461TRhz3AtQsSBFCOB+RniDoZ0vnIGp6aMdo6+49+/C0pH+h9J//1lyU+ls
 Tpw1O+J53NFbO9ppyETbblGvdLmnNSPUm+fsTq5nMQANX7pR9fEySDZQGN1UkRhHk8k1
 6ehvGzqWm5AqhX5rzrWx33LJdGF8vuAQUb1hJ6pjMhQ0xE/mTEAt3SKvk7eaqEIuG73d
 gkt2upET9Rm26ev+HNKrAoDln3Zc9BAXIzyEbJ/ohvU69NIbK6yLkMhrtjaT9d/rIdNL
 2m1JSbB/amPVq21rAQeKsLb2E75+JCxIzhF8ez4Ny31QDCGXl5/WoXM/iiAVU9rQBs/S
 2geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550646; x=1788155446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qht+Lyy6ya77fhoK8407K/BbvZSE066z6kEHDiB1ixw=;
 b=cX8+z+aPSFqa/qyvY7qPvhtS6Yq+oNqy6AlzF/of7ZXZU4zlSn6pAbr+N2AStCv6FM
 qsnCD+FwkHljqOlmjpshND+j25rB15uF2wKakiiC+sQQ9eqLX+P6eEBnNbuz83J+okt3
 BT6NlnEx/IJbHfns6Er7Q3kP49x3lZZ5ZaxyZzElSWmhSs5+juUFr9u75H/KlQwzInHy
 RTTers7Xcm+7Dop7qfhl1MFrmECO0h2tZMsQeMITjRPComHMnlpEixfTIos013NHE2iW
 UtFaH2JPOcWQUJap8Ks13PPQGryz3NFp7lBslQAsFUfyRv5HMwdorLkh0TAoT6XkiZX1
 2RrQ==
X-Gm-Message-State: AFuF++m8mmepB+qMbjS82n2qHbgbfuQhPTSSbbozonM6OWc4WDhkijka
 5okhHthheG0yzkfdNaPjdIstm6f1Sr6oWS+2o6YuFBC8ZXgoxnfboj7y89QsEw==
X-Gm-Gg: AR+sD103CVYs5828Vi68MjCilpo2eaREJJPDjGKu2Wjsar/rc6h8VBkx7HlGbIF1oCT
 zfIFpYarQMuGZM0ormId2zzbHGYDUNcC3eTEVpghUyougFq+weMKnZ1xrxYw5N8wVGiNdLoVEWs
 v6BM/lyhTBsudEjfK8VMnSP0t0X8cLPH8B4ktxklZ8YLz9JIjMYNxTSzOoaAmY+hkPp+j+nWRQb
 ohVLwMcv0SsxgfY1xIv1PdJz//eK+aJtzvg4DfjiQbdh/1i4OHoI/uIjytmLGXNiBuYbKxQ14G3
 ObGZTcNg0x/hkxbJvP+dR6+UXFvOSpOiVbt0T/O7dZUVkM+kVl47dXW/3jAgEriwggV1qQWP5cO
 ioIDGyTM0I5xgRO9OAas5k84XUfOMiFrxF3BzhdSw2do6JFi7kZzGKWdK43bmFIMDUMYtAxA9p/
 x9xYtfEkdLf2B3coAk2ecEUqCXyhc3mYr20fuz3zwIK+s9sd5PkSvYKi/8v9c+Dt8r3wA0vuVR1
 OjSLQ==
X-Received: by 2002:a17:90b:2dc2:b0:38e:4f31:8412 with SMTP id
 98e67ed59e1d1-395a062e5a0mr39035123a91.11.1787550645534; 
 Sun, 23 Aug 2026 22:50:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 47/96] disas/riscv: Simplify c.addi
Date: Mon, 24 Aug 2026 15:47:17 +1000
Message-ID: <20260824054806.2790041-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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


