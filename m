Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D8FCF31B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 12:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhIx-0004uF-AY; Wed, 19 Nov 2025 07:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhIs-0004tV-02
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:28:54 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vLhIp-0004bX-B5
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:28:53 -0500
Received: from cslab-raptor.s.cslab.moe (unknown [166.111.238.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 9E8E849A7E9;
 Wed, 19 Nov 2025 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1763555322; bh=FyMr2OJGmqvQsrW7g6Xf9aexPY0tteLQ5bIpfD7/shA=;
 h=From:To:Cc:Subject:Date;
 b=utTYkcqzrFXpI1yoSxQagkp2Bx1HshhZHa+2UcA/9Yv4N8S/J98buqethmDrFLEI1
 buaxo5cYjZQPNR50nLisG8B8oQ2BpuVojU0A0rDHoJATT4ndGQj7LttRHi38rwxVI1
 iPS0LrWG7VxSEOwEXwKSDeS/GcmqkuJ/U0qmLXqI=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 0/7] Add LoongArch v1.1 instructions
Date: Wed, 19 Nov 2025 20:24:45 +0800
Message-ID: <20251119122822.1513788-1-c@jia.je>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Latest revision of LoongArch ISA is out at
https://www.loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf
(Chinese only). The revision includes the following updates:

- estimated fp reciporcal instructions: frecip -> frecipe, frsqrt ->
  frsqrte
- 128-bit width store-conditional instruction: sc.q
- ll.w/d with acquire semantic: llacq.w/d, sc.w/d with release semantic:
  screl.w/d
- compare and swap instructions: amcas[_db].b/w/h/d
- byte and word-wide amswap/add instructions: am{swap/add}[_db].{b/h}
- new definition for dbar hints
- clarify 32-bit division instruction hebavior
- clarify load ordering when accessing the same address
- introduce message signaled interrupt
- introduce hardware page table walker

The new revision is implemented in the Loongson 3A6000 processor.

This patch series implements all the new instructions. The v1 version
can be found at
https://patchew.org/QEMU/20231023153029.269211-2-c@jia.je/.

A simple testcase to test the new fp and sc.q instructions:

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

void test_fp() {
  float a = 3.0;
  float b;

  asm volatile("frecip.s %0, %1" : "=f"(b) : "f"(a));
  printf("frecip: %f\n", b);
  asm volatile("frecipe.s %0, %1" : "=f"(b) : "f"(a));
  printf("frecipe: %f\n", b);

  asm volatile("frsqrt.s %0, %1" : "=f"(b) : "f"(a));
  printf("frsqrt: %f\n", b);
  asm volatile("frsqrte.s %0, %1" : "=f"(b) : "f"(a));
  printf("frsqrte: %f\n", b);
}

uint64_t rand64() { return ((uint64_t)rand() << 32) | rand(); }

void test_sc_q() {
  __int128 val = rand64();
  val = (val << 64) | rand64();
  __int128 *ptr = &val;
  uint64_t add_lo = rand64();
  uint64_t add_hi = rand64();
  __int128 add = add_hi;
  add = (add << 64) | add_lo;
  __int128 expect = val + add;
  int res = 0;

  asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\nadd.d $t1, $t1, %2\nadd.d "
               "$t2, $t2, %3\nsc.q $t1, $t2, %1\nmove %0, $t1"
               : "=r"(res), "+r"(ptr)
               : "r"(add_lo), "r"(add_hi)
               : "$t1", "$t2", "memory");
  assert(res == 1);
  assert(val == expect);

  // change memory content to make sc fail
  res = 1;
  asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\naddi.d $t1, $t1, 1\nst.d "
               "$t1, %1, 0\nsc.q $t1, $t2, %1\nmove %0, $t1"
               : "=r"(res), "+r"(ptr)
               :
               : "$t1", "$t2", "memory");
  assert(res == 0);

  res = 1;
  asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\naddi.d $t2, $t2, 1\nst.d "
               "$t2, %1, 8\nsc.q $t1, $t2, %1\nmove %0, $t1"
               : "=r"(res), "+r"(ptr)
               :
               : "$t1", "$t2", "memory");
  assert(res == 0);

  printf("SC.Q passed\n");
}

int main(int argc, char *argv[]) {
  test_fp();
  test_sc_q();
  return 0;
}

Compile and test by:

loongarch64-linux-gnu-gcc test.c -o test -static && ./qemu-loongarch64 -cpu max test

Jiajie Chen (7):
  target/loongarch: Require atomics to be aligned
  target/loongarch: Add am{swap/add}[_db].{b/h}
  target/loongarch: Add amcas[_db].{b/h/w/d}
  target/loongarch: Add estimated reciprocal instructions
  target/loongarch: Add llacq/screl instructions
  target/loongarch: Add sc.q instructions
  target/loongarch: Add LA v1.1 instructions to max cpu

 target/loongarch/cpu.c                        |  11 +-
 target/loongarch/cpu.h                        |   7 +
 target/loongarch/disas.c                      |  33 ++++
 target/loongarch/insns.decode                 |  34 ++++
 .../tcg/insn_trans/trans_atomic.c.inc         | 145 ++++++++++++++++--
 .../tcg/insn_trans/trans_farith.c.inc         |   4 +
 .../tcg/insn_trans/trans_memory.c.inc         |  22 +++
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  |   8 +
 target/loongarch/tcg/translate.c              |   6 +-
 target/loongarch/translate.h                  |  30 ++--
 10 files changed, 280 insertions(+), 20 deletions(-)

-- 
2.51.0


