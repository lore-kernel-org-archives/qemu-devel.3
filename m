Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C5DCA0ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 00:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un4oH-0000Qd-U5; Fri, 15 Aug 2025 20:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un4oC-0000PB-W1; Fri, 15 Aug 2025 20:30:09 -0400
Received: from mail-m16.yeah.net ([1.95.21.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un4o6-0002vu-W3; Fri, 15 Aug 2025 20:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=nQQRb0xfUm6KtGsSxHueW8B+CQ7jum1wa5hjlBmLYhE=;
 b=c6MIiT9N7gQAwDAIsr8Q6z9DecGjBbCDYMBW25lIbbrnaLj3LJBlLBnD42p8Nc
 DK/2vUW483v9wzWak309mFWAGZfIEsNXc3BISltbrBGTDgIW8J9GWrotTsdx5xoH
 4vICqWX8qzjQQ9FKqA79PGrHY/L00j45N6GVehg3G2L3Y=
Received: from ZEVORN-PC (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXHbHr0J9oFNywAg--.22102S2;
 Sat, 16 Aug 2025 08:29:31 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: paolo.savini@embecosm.com, dbarboza@ventanamicro.com, ebiggers@kernel.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v2 0/2] target/riscv: fix vector LD/ST instruction
Date: Sat, 16 Aug 2025 08:29:19 +0800
Message-ID: <cover.1755287531.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgAXHbHr0J9oFNywAg--.22102S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6JKIUUUUU
X-Originating-IP: [240e:b8f:29d6:3800:7c84:49f3:ff4c:3c80]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiIgtwmGif0OvDSAAA3G
Received-SPF: pass client-ip=1.95.21.17; envelope-from=chao.liu@yeah.net;
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
Message-ID: <20250816002919.JSQ8K4fsq4Y33C0XfZBFjyvDeIJwnj0CM4_clzze-Hs@z>

Hi Paolo, Eric, Daniel,

patch v3 changes:
- Fix the get_log2 cunftion:
  https://lore.kernel.org/qemu-riscv/cover.1755287531.git.chao.liu@yeah.net/T/#t

#### Problem Description

The `get_log2` function in `trans_rvv.c.inc` returned a value 1 higher than the
actual log2 value. For example, get_log2(4) incorrectly returned 3 instead of 2.

This led to erroneous vector register offset calculations, resulting in data
overlap where bytes 32-47 were incorrectly copied to positions 16-31 in ChaCha20
encryption code.

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

#### Root Cause Analysis

The original implementation counted the number of right shifts until zero,
including the final shift that reduced the value to zero:

static inline uint32_t get_log2(uint32_t a)
{
    uint32_t i = 0;
    for (; a > 0;) {
        a >>= 1;
        i++;
    }
    return i; // Returns 3 for a=4 (0b100 → 0b10 → 0b1 → 0b0)
}

#### Fix Implementation

The corrected function stops shifting when only the highest bit remains and
handles the special case of a=0:

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

#### Testing

This fix has been verified with:
    1. The provided ChaCha20 vector optimization test case
    2. RVV strided load instruction tests in `test-vlsseg8e32.S`

All tests now pass with correct data handling and no memory overlap.


Test using the following command:

    ./configure --target-list=riscv64-softmmu \
                --cross-prefix-riscv64=riscv64-unknown-elf-

    ninja -j$(nproc) -C build && make check-tcg

Expected result:

    BUILD   riscv64-softmmu guest-tests
    RUN     riscv64-softmmu guest-tests
    TEST    issue1060 on riscv64
    TEST    test-vlsseg8e32 on riscv64


Best regards,

Chao

Chao Liu (2):
  target/riscv: fix vector register address calculation in strided LD/ST
  tests/tcg/riscv64: Add test for vlsseg8e32 instruction

 target/riscv/insn_trans/trans_rvv.c.inc   |   5 +-
 tests/tcg/riscv64/Makefile.softmmu-target |   8 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 108 ++++++++++++++++++++++
 3 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

-- 
2.50.1


