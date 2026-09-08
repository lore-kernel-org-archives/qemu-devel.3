Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B4C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x44JD-0006xe-Vs; Tue, 08 Sep 2026 18:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1x44JC-0006xK-7H
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 18:28:54 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1x44J9-0004CU-1b
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 18:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1788906523; x=1789165723;
 bh=nLpx2lqQ0DWsi+a/I0joa4s81akdIU9FBes1DibMwZ8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Mlq9ee/QiY+5PmkkBGphbUQBQavyOU/fDRmxyjjXzFJrQBlzyrg+p2ofUmjvL7LyT
 9O6EQ0t1ZhzM8WukOonXKMdARSpbBQe0V/YQRAMq/4YM+epTFELZvonf1BO/xPR6Jx
 3slV5gtZtZpRagd85GkhPPJwmeETgeXO2/Fwjs2SiZlE73ygsq6Awnw9RA3o22OTKJ
 rbzSYUjI2yMe0rDYWYqR65ONd+qYEhowutgU6572FRv/Nsh8R36sTL6RFOKbzelrGs
 6hms8at7MVD7veX0rWhbbKY5K7wWVPWmUl0TsfKg4stIs5MMPfos3xNAtSVjYKRA1B
 UTk8PkFtwYXBg==
Date: Tue, 08 Sep 2026 22:28:33 +0000
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH] target/riscv/tcg: svinval instructions raise virtual
 instruction
Message-ID: <20260908222825.84642-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: c073632b9e255ea6bb115b66eb91bc9884ce03d6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45;
 envelope-from=christianslima@proton.me; helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The risc v privileged specification requires hinval.vvma, hinval.gvma,
sfence.w.inval and sfence.inval.ir should raise a virtual instruction
exception when executed in the vu-mode. This patch add the check to
raise the virtual instruction exception when is in the vu-mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 target/riscv/tcg/insn_trans/trans_svinval.c.inc |  4 ++++
 target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 13 ++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/riscv=
/tcg/insn_trans/trans_svinval.c.inc
index 4614c1489c..251d9c5815 100644
--- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
@@ -25,8 +25,12 @@
 /* Test if priv level is M or S. */
 #define REQUIRE_PRIV_MS(ctx) do {          \
     if (ctx->priv =3D=3D PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp =3D true;    \
+        }                                  \
         return false;                      \
     }                                      \
+    return true;                           \
 } while (0)
=20
 static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/=
tcg/insn_trans/trans_xthead.c.inc
index f4e3051000..c00b007895 100644
--- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
@@ -267,11 +267,14 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_ts=
t *a)
 #define REQUIRE_PRIV_MSU(ctx)
=20
 /* Test if priv level is M or S. */
-#define REQUIRE_PRIV_MS(ctx)                                    \
-do {                                                            \
-    if (ctx->priv =3D=3D PRV_U) {                                   \
-        return false;                                           \
-    }                                                           \
+#define REQUIRE_PRIV_MS(ctx) do {          \
+    if (ctx->priv =3D=3D PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp =3D true;    \
+        }                                  \
+        return false;                      \
+    }                                      \
+    return true;                           \
 } while (0)
=20
 #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \
--=20
2.55.0



