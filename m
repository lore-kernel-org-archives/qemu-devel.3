Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34635C88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50LF-0004i4-9B; Fri, 11 Sep 2026 08:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Kn-00045x-NT; Fri, 11 Sep 2026 08:26:26 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Ki-0006CX-W6; Fri, 11 Sep 2026 08:26:25 -0400
Received: from [172.21.96.1] (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowABHtD5k86NqyHDqBw--.17498S3;
 Fri, 11 Sep 2026 20:26:13 +0800 (CST)
Message-ID: <a03b699a4e8aa75bc6febf6373c3227119e34465.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
References: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
Date: Fri, 4 Sep 2026 21:49:06 +0800
Subject: [PATCH v4 1/5] target/riscv: enforce XTheadCmo U-mode privilege checks
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org
X-CM-TRANSID: zQCowABHtD5k86NqyHDqBw--.17498S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47XFyUurWftFyfGrW3Jrb_yoW8ZF1rpF
 WDKayYkrZ5JF15A3Zxur47Za97JFZ8Gw47X3W3Z398Aa15CrW7W3Z7K3y2gw48Cr40gr1q
 kF1qyr15Zr1jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vE77IFxV
 WkZVCq3wA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4U
 M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr
 0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8
 JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4w
 AS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IY
 x2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
 x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5JwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
 k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jsAwxUUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tested: RV32/RV64 Linux-user test cases with xtheadcmo enabled and
disabled.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4412
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


