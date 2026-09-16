Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jrU-0005n6-7L; Wed, 16 Sep 2026 03:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqv-0005ak-6W; Wed, 16 Sep 2026 03:14:45 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqs-0000zS-04; Wed, 16 Sep 2026 03:14:44 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S20;
 Wed, 16 Sep 2026 15:08:05 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 18/19] target/riscv: Remove Zbkb dependency from P
 extension to align with the spec
Date: Wed, 16 Sep 2026 07:07:20 +0000
Message-Id: <20260916070721.3279229-19-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S20
X-Coremail-Antispam: 1UD129KBjvJXoW7tw48Wr4xCryDXrWUWF1rZwb_yoW8tr1xpr
 48C3yYkrWDXFyrA3yftF4UAF1UWa1Sga1Iga92qwn5uF45ArW3Xr4q9w43KF1UJF1kWw42
 9F1vy3s8uFW8Xa7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
 67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULSdkUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.74,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---
 target/riscv/tcg/insn_trans/trans_rvb.c.inc | 4 +++-
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 2 +-
 target/riscv/tcg/tcg-cpu.c                  | 6 ++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index 3e74be223b0..48bc5df0378 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -527,7 +527,9 @@ static bool trans_brev8(DisasContext *ctx, arg_brev8 *a)
 
 static bool trans_pack(DisasContext *ctx, arg_pack *a)
 {
-    REQUIRE_ZBKB(ctx);
+    if (!has_ext(ctx, RVP) && !ctx->cfg_ptr->ext_zbkb) {
+        return false;
+    }
     return gen_arith(ctx, a, EXT_NONE, gen_pack, NULL);
 }
 
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index bec44e98f7c..8c8c6ba3a6f 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -1436,4 +1436,4 @@ GEN_DWS_REG_OP(psll_dws, EXT_NONE, true, tcg_gen_shl_tl)
 GEN_DWS_REG_OP(psrl_dws, EXT_ZERO, true, tcg_gen_shr_tl)
 GEN_DWS_REG_OP(psra_dws, EXT_SIGN, true, tcg_gen_sar_tl)
 
-GEN_DW_PAIR_ARITH(ppaire_dh, REQUIRE_ZBKB(ctx); , EXT_NONE, gen_pack)
+GEN_DW_PAIR_ARITH(ppaire_dh, , EXT_NONE, gen_pack)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e72e2ffd7f..4d57192d1e1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -562,10 +562,8 @@ static void riscv_cpu_validate_p(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb &&
-          cpu->cfg.ext_zbkb)) {
-        error_setg(errp, "P extension requires zmmul, zba, zbb and zbkb "
-                         "extensions");
+    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb)) {
+        error_setg(errp, "P extension requires zmmul, zba and zbb extensions");
         return;
     }
 }
-- 
2.34.1


