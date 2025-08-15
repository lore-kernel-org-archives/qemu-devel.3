Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B045DCA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un0XK-0003yW-Fm; Fri, 15 Aug 2025 15:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un0XJ-0003yC-7H; Fri, 15 Aug 2025 15:56:25 -0400
Received: from mail-m16.yeah.net ([220.197.32.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un0XF-0004r9-7n; Fri, 15 Aug 2025 15:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=1fiKA4dy0xdL90wRaaFduyn2+bDZ4La+jQDUFpYQD/Q=;
 b=HXldxkWnkTwEQQmjteNJMWWTwuPpZnzK3zaG2HnaZU9l00jyP9Rwp+YghF4Dlf
 08D6/IFbQ5/o9IHYPvUnCCzKCqqj6G0s3YfG0v7G/yHCTZcgVEL6ZPf4Cme5Fnxw
 H1OnWsiANXe6dAF+vFjP7lI64cf4c5sIX2cgyOGL70ciM=
Received: from ZEVORN-PC (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHtrLGkJ9ocCKuAg--.20443S3;
 Sat, 16 Aug 2025 03:55:51 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: paolo.savini@embecosm.com, dbarboza@ventanamicro.com, ebiggers@kernel.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v2 1/2] target/riscv: fix vector register address calculation
 in strided LD/ST
Date: Sat, 16 Aug 2025 03:55:40 +0800
Message-ID: <ee461421503da741d4cf6d2486b8596862fc0b7f.1755287531.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755287531.git.chao.liu@yeah.net>
References: <cover.1755287531.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgCHtrLGkJ9ocCKuAg--.20443S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1UuF1xtr1DGFW5Xr13Jwb_yoW8ZFyrpr
 sYkry7Kr45WFWfZFZ2yr48JryYqayFgr4jkw4qgwn8XFW5Xr47tF4vga42kF18JrWxur12
 9ayUuay5uw13uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaD73UUUUU=
X-Originating-IP: [240e:b8f:29d6:3800:f820:962e:d888:73d]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiIghYgGifkMgwkgAA3-
Received-SPF: pass client-ip=220.197.32.16; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This patch fixes a critical bug in the RISC-V vector instruction
translation that caused incorrect data handling in strided load
operations (e.g., vlsseg8e32).

Problem Description:

The `get_log2` function in `trans_rvv.c.inc` returned a value 1 higher
than the actual log2 value. For example, get_log2(4) incorrectly
returned 3 instead of 2.

This led to erroneous vector register offset calculations, resulting in
data overlap where bytes 32-47 were incorrectly copied to positions
16-31 in ChaCha20 encryption code.

rvv_test_func:
    vsetivli    zero, 1, e32, m1, ta, ma
    li          t0, 64

    vlsseg8e32.v v0, (a0), t0
    addi        a0, a0, 32
    vlsseg8e32.v v8, (a0), t0

    vssseg8e32.v v0, (a1), t0
    addi        a1, a1, 32
    vssseg8e32.v v8, (a1), t0
    ret

Analysis:

The original implementation counted the number of right shifts until
zero, including the final shift that reduced the value to zero:

static inline uint32_t get_log2(uint32_t a)
{
    uint32_t i = 0;
    for (; a > 0;) {
        a >>= 1;
        i++;
    }
    return i; // Returns 3 for a=4 (0b100 → 0b10 → 0b1 → 0b0)
}

Fix:

The corrected function stops shifting when only the highest bit remains
and handles the special case of a=0:

static inline uint32_t get_log2(uint32_t a)
{
    uint32_t i = 0;
    if (a == 0) {
        return i; // Handle edge case
    }
    for (; a > 1; a >>= 1) {
        i++;
    }
    return i; // Now returns 2 for a=4
}

Fixes: 28c12c1f2f ("Generate strided vector loads/stores with tcg nodes.")

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2b6077ac06..f50b62b1d8 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -877,7 +877,10 @@ static inline uint32_t MAXSZ(DisasContext *s)
 static inline uint32_t get_log2(uint32_t a)
 {
     uint32_t i = 0;
-    for (; a > 0;) {
+    if (a == 0) {
+        return i;
+    }
+    for (; a > 1;) {
         a >>= 1;
         i++;
     }
-- 
2.50.1


