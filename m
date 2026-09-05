Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C64EC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2mqd-0004mz-MQ; Sat, 05 Sep 2026 05:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqb-0004mY-Aa; Sat, 05 Sep 2026 05:38:05 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqY-0002d3-EO; Sat, 05 Sep 2026 05:38:04 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowABHUT_u4ptqIsvvBg--.16071S3;
 Sat, 05 Sep 2026 17:37:52 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 1/5] target/riscv: enforce XTheadCmo U-mode privilege checks
Date: Sat,  5 Sep 2026 17:37:45 +0800
Message-ID: <20260905093749.491-2-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUT_u4ptqIsvvBg--.16071S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47XFyUurWftFyfGrW3Jrb_yoW8Cw18pF
 WDKayYkrZ5JF15A3Zxur47Za97JFZ8Jw47X3W3Z398Aa15CrW7W3Z7K39Fgw48Cr40gr1q
 kF1qyr15Zr1jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vY
 z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mx
 kF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JU4mhwUUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The XTheadCmo specification restricts th.dcache.cva and th.dcache.iva
to privilege modes above U, while th.dcache.civa remains available in
U-mode. Both restricted instructions currently use the empty
REQUIRE_PRIV_MSU macro, so they retire in U-mode. Use REQUIRE_PRIV_MS
for the two restricted instructions.

Tested: RV32/RV64 Linux-user witness matrix with xtheadcmo enabled
and disabled.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4412

Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 target/riscv/tcg/insn_trans/trans_xthead.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
index f4e3051000..681f70e5bc 100644
--- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
@@ -289,9 +289,9 @@ NOP_PRIVCHECK(th_dcache_iall, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_cpa, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_cipa, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_ipa, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
-NOP_PRIVCHECK(th_dcache_cva, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MSU)
+NOP_PRIVCHECK(th_dcache_cva, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_civa, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MSU)
-NOP_PRIVCHECK(th_dcache_iva, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MSU)
+NOP_PRIVCHECK(th_dcache_iva, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_csw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_cisw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_isw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
-- 
2.55.0.windows.2


