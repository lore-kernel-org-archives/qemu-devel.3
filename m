Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C41C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxIwF-0001Xt-VZ; Fri, 21 Aug 2026 02:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIwC-0001Vj-S3; Fri, 21 Aug 2026 02:41:12 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIwA-00065v-1Q; Fri, 21 Aug 2026 02:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787294440; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=cCJ4CtoSRuqrNI3u0ddPHzeGyfMyt3WdpH6gBNVyB5s=;
 b=tkyHXxY5M/ShMR/ZRau/S2kTBunpY7fJilAeUcQhbahxA9pft88IyJ3sP7sABkACri3kfI9qyIZ5OaL0H+XvHFUe+7RN53OpOz9wS7b+y8xIk+Z+wzpslRF9xwdximTNe4rFGQdAMkEO0xYUKomfxionSioJbBP5Nm69QBOB3xI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X9LMiRZ_1787294438; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X9LMiRZ_1787294438 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 21 Aug 2026 14:40:39 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com,
 zhiwei_liu@linux.alibaba.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PATCH 0/3] Fix RCsc store->load ordering of release stores
Date: Fri, 21 Aug 2026 14:40:29 +0800
Message-Id: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Several guest architectures give their store-release instructions RCsc
semantics, which requires the store to be ordered not only after the
memory operations that precede it, but also before any subsequent
load-acquire with RCsc semantics.  The TCG translators, however, only
emit the leading barrier before the store, so under MTTCG nothing
prevents the host CPU from executing the load-acquire that follows a
store-release before the store has left its store buffer.  On an x86
host (TSO), store-load is the only reordering the hardware may
perform, and it is exactly the ordering that is missing, so the
architecturally forbidden [0,0] outcome of the Store Buffering litmus
test is easy to observe:

    CPU 0                      CPU 1
    store-release X = 1        store-release Y = 1
    load-acquire  r0 = Y       load-acquire  r1 = X

The affected instructions are the RISC-V Zalasr store-release
instructions and the Arm STLR, STLPUR and A32/T32 STL store-release
instructions.  Neither architecture defines an RCpc store, so every
store-release is RCsc (RVWMO preserved program order Rule 7; Arm
Architecture Reference Manual DDI 0487, section B2.3.8 "Acquire and
release semantics").

Patch 1 fixes the RISC-V side and patch 2 the Arm side by emitting a
full barrier after the store as well.  Patch 3 fixes an inverted
barrier polarity found in the A32 LDA load-acquire translator while
auditing the load-acquire side.

Both fixes are verified with bare-metal Store Buffering litmus tests
under MTTCG on an x86 host:

  * RISC-V (rv64, Zalasr, 4 vCPUs): 89881 out of 100000 iterations
    produce the forbidden [0,0] result before the fix and 0 after;

  * Arm (cortex-a53, 2 vCPUs): 6 to 7 out of 100000 iterations
    produce the forbidden [0,0] result before the fix and 0 after;
    a control variant of the test that inserts a DMB ISH between the
    store and the load produces 0 out of 100000 before the fix, which
    validates the harness.

The other architectures were audited and need no change:

  * Xtensa keeps only the leading barrier for S32RI and the trailing
    one for L32AI, which exactly matches the simplified Release
    Consistency model the ISA specifies (Xtensa Instruction Set
    Architecture Reference Manual, sections 3.8.3 "Memory Access
    Ordering" and 4.3.12.3 "Inter-Processor Communication with the
    L32AI and S32RI Instructions"): the ISA orders the release store
    only after previous memory operations and the acquire load only
    before subsequent memory operations, so the Store Buffering
    litmus test is allowed there and a trailing barrier would be
    stronger than required;

  * exclusive stores and guest atomic operations are lowered to host
    atomic instructions, which are fully ordered on x86 hosts;

  * the RISC-V Ztso extension is TSO by design and explicitly allows
    store buffering.

LIU Zhiwei (3):
  target/riscv: Fix RCsc ordering of Zalasr store-release
  target/arm: Fix RCsc ordering of store-release instructions
  target/arm: Fix barrier polarity of A32 LDA load-acquire

 target/arm/tcg/translate-a64.c                   | 13 +++++++++++++
 target/arm/tcg/translate.c                       |  8 +++++++-
 target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc |  8 ++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.43.0


