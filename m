Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FFDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBUd-0006ik-Gb; Fri, 12 Apr 2024 03:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBUb-0006iO-6Q; Fri, 12 Apr 2024 03:38:37 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBUX-0007xs-2H; Fri, 12 Apr 2024 03:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712907502; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=4+2qdm/apoMiVfH3kMPqOvk4CSUGbdlyWLmKvixE+wk=;
 b=ZNopkPM8LhYf1R0gTfgjJM3yzGKGEwdu3+spgplicSD5RHyX4gUAegRIgWN96Aqv2bXW2Mz7pk6PFZnNEdavnYEAKANQgdIBijol8dZpvrEmmyIIEAcPAtDyoJKZvOex2sTGWN7JYWxI0EyW12tqjeZWsAHkT6DEwwOJGX3rgQ4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NVPPR_1712907499; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NVPPR_1712907499) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:38:21 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 00/65]target/riscv: Support XTheadVector extension
Date: Fri, 12 Apr 2024 15:36:30 +0800
Message-ID: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This patchset implements the XTheadVector extension for RISC-V on QEMU.

You can find the full description of the XTheadVector extension at:
https://github.com/RISCV-SPEC/thead-extension-spec/blob/master/xtheadvector.adoc

The XTheadvector extension is a non-standard extension for RISC-V. The
encoding space of the XTheadVector instructions overlaps with those of
the V extension.

The XTheadVector is similar to the V extension v0.7.1, so it has several
differences with the current V extension v1.0 which is supported by
QEMU.

Here is a simple list of the differences:
  * Different instructions
  * Different CSR behaviors
  * Different mask register layout
  * Different overlap policy
  * Different masked/tail element processing policy
  * Same instructions have different behaviors in detail

This patchset is based on https://github.com/alistair23/qemu/tree/riscv-to-apply.next,
relay on some former patches which are not merged into upstream yet:
  * target/riscv: Implement dynamic establishment of custom decoder
  (https://patchew.org/QEMU/20240314092158.65866-1-eric.huang@linux.alibaba.com/)
  * riscv: set vstart_eq_zero on vector insns
  (https://patchew.org/QEMU/20240313220141.427730-1-dbarboza@ventanamicro.com/)
  * riscv: thead: Add th.sxstatus CSR emulation
  (https://patchew.org/QEMU/20240329120427.684677-1-christoph.muellner@vrull.eu/)


The patch 'riscv: thead: Add th.sxstatus CSR emulation' is included in the patchset
for we need to change it to support XTheadVector csrs.

Christoph Müllner (1):
  riscv: thead: Add th.sxstatus CSR emulation

Huang Tao (64):
  target/riscv: Reuse th_csr.c to add user-mode csrs
  target/riscv: Add properties for XTheadVector extension
  target/riscv: Override some csr ops for XTheadVector
  target/riscv: Add mlen in DisasContext
  target/riscv: Implement insns decode rules for XTheadVector
  target/riscv: implement th.vsetvl{i} for XTheadVector
  target/riscv: Add strided load instructions for XTheadVector
  target/riscv: Add strided store instructions for XTheadVector
  target/riscv: Add unit-stride load instructions for XTheadVector
  target/riscv: Add unit-stride store instructions for XTheadVector
  target/riscv: Add indexed load instructions for XTheadVector
  target/riscv: Add indexed store instructions for XTheadVector
  target/riscv: Add unit-stride fault-only-first instructions for
    XTheadVector
  target/riscv: Add vector amo operations for XTheadVector
  target/riscv: Add single-width integer add and subtract instructions
    for XTheadVector
  target/riscv: Add widening integer add/subtract instructions for
    XTheadVector
  target/riscv: Add integer add-with-carry/sub-with-borrow instructions
    for XTheadVector
  target/riscv: Add bitwise logical instructions for XTheadVector
  target/riscv: Add single-width bit shift instructions for XTheadVector
  target/riscv: Add narrowing integer right shift instructions for
    XTheadVector
  target/riscv: Add integer compare instructions for XTheadVector
  target/riscv: Add integer min/max instructions for XTheadVector
  target/riscv: Add single-width integer multiply instructions for
    XTheadVector
  target/riscv: Add integer divide instructions for XTheadVector
  target/riscv: Add widening integer multiply instructions for
    XTheadVector
  target/riscv: Add single-width integer multiply-add instructions for
    XTheadVector
  target/riscv: Add widening integer multiply-add instructions for
    XTheadVector
  target/riscv: Add integer merge and move instructions for XTheadVector
  target/riscv: Add single-width saturating add and sub instructions for
    XTheadVector
  target/riscv: Add single-width average add and sub instructions for
    XTheadVector
  target/riscv: Add single-width fractional mul with rounding and
    saturation for XTheadVector
  target/riscv: Add widening saturating scaled multiply-add instructions
    for XTheadVector
  target/riscv: Add single-width scaling shift instructions for
    XTheadVector
  target/riscv: Add narrowing fixed-point clip instructions for
    XTheadVector
  target/riscv: Add single-width floating-point add/sub instructions for
    XTheadVector
  target/riscv: Add widening floating-point add/sub instructions for
    XTheadVector
  target/riscv: Add single-width floating-point multiply/divide
    instructions for XTheadVector
  target/riscv: Add widening floating-point multiply instructions for
    XTheadVector
  target/riscv: Add single-width floating-point fused multiply-add
    instructions for XTheadVector
  target/riscv: Add widening floating-point fused mul-add instructions
    for XTheadVector
  target/riscv: Add floating-pointing square-root instructions for
    XTheadVector
  target/riscv: Add floating-point MIN/MAX instructions for XTheadVector
  target/riscv: Add floating-point sign-injection instructions for
    XTheadVector
  target/riscv: Add floating-point compare instructions for XTheadVector
  target/riscv: Add floating-point classify and merge instructions for
    XTheadVector
  target/riscv: Add single-width floating-point/integer type-convert
    instructions for XTheadVector
  target/riscv: Add widening floating-point/integer type-convert
    instructions for XTheadVector
  target/riscv: Add narrowing floating-point/integer type-convert
    instructions for XTheadVector
  target/riscv: Add single-width integer reduction instructions for
    XTheadVector
  target/riscv: Add widening integer reduction instructions for
    XTheadVector
  target/riscv: Add single-width floating-point reduction instructions
    for XTheadVector
  target/riscv: Add widening floating-point reduction instructions for
    XTheadVector
  target/riscv: Add mask-register logical instructions for XTheadVector
  target/riscv: Add vector mask population count vmpopc for XTheadVector
  target/riscv: Add th.vmfirst.m for XTheadVector
  target/riscv: Add set-X-first mask bit instructrions for XTheadVector
  target/riscv: Add vector iota instruction for XTheadVector
  target/riscv: Add vector element index instruction for XTheadVector
  target/riscv: Add integer extract and scalar move instructions for
    XTheadVector
  target/riscv: Add floating-point scalar move instructions for
    XTheadVector
  target/riscv: Add vector slide instructions for XTheadVector
  target/riscv: Add vector register gather instructions for XTheadVector
  target/riscv: Add vector compress instruction for XTheadVector
  target/riscv: Enable XTheadVector extension for c906

 target/riscv/cpu.c                            |    4 +
 target/riscv/cpu.h                            |   39 +
 target/riscv/cpu_bits.h                       |   18 +
 target/riscv/cpu_cfg.h                        |    2 +
 target/riscv/cpu_helper.c                     |    2 +-
 target/riscv/csr.c                            |   42 +-
 target/riscv/helper.h                         | 1067 +++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 2933 +++++++++++++
 target/riscv/internals.h                      |   12 +
 target/riscv/meson.build                      |    3 +
 target/riscv/tcg/tcg-cpu.c                    |   33 +
 target/riscv/th_csr.c                         |  250 ++
 target/riscv/translate.c                      |    7 +
 target/riscv/vector_helper.c                  |  306 +-
 target/riscv/vector_internals.h               |  187 +
 target/riscv/xtheadvector.decode              |  390 ++
 target/riscv/xtheadvector_helper.c            | 3894 +++++++++++++++++
 17 files changed, 8983 insertions(+), 206 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_xtheadvector.c.inc
 create mode 100644 target/riscv/th_csr.c
 create mode 100644 target/riscv/xtheadvector.decode
 create mode 100644 target/riscv/xtheadvector_helper.c

-- 
2.44.0


