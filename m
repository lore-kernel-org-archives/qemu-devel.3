Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E1EC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wew0E-0001yv-8C; Wed, 01 Jul 2026 10:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew09-0001ww-6v; Wed, 01 Jul 2026 10:33:21 -0400
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew05-0000RY-10; Wed, 01 Jul 2026 10:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782916376; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=D40jrpLIMGSXT5fZKZ7ZRYYGUdZky9dhD+ajiJo+RL8=;
 b=TvnD5Ns2Vo95XGI2T9CH2Vugfhze97sO+eHGHcmJfoMiOAUBv7roYAYnQPVZFUzxmFQARGe4usOKqaAHzJb67Uh3dBZ9BzrX2qNQXB77rMwZYbrhwfTpAJpxu3FWFsoijsTd76anUALMG4g0630TXuWrVDziIXQYwWA2C4wFuEA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R301e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X6A2Tqk_1782916372; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X6A2Tqk_1782916372 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Jul 2026 22:32:55 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v3 0/5] disas/riscv: Fix immediate decoding and extraction
Date: Wed, 01 Jul 2026 22:32:08 +0800
Message-Id: <20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkkRWoC/4XNwQrCMAzG8VeRns1os9mpJ99DPGRt5gK6STvLR
 Pbu1oF4ETx+Ifz+TxU5CEe1Xz1V4CRRhj6Pcr1SrqP+zCA+b4UarbZYQlOBl0gRprFj8tDKBEG
 iS9DzNIKz1FrSO4/eqYzcAuePJXA85d1JHIfwWHrJvK8f2v6jkwENdYW4pdKZBs3hIv19KugiD
 TVUuOGq3omEX7bW5i+LmWXLVdtuqN5W9S92nucX8E3L1ysBAAA=
X-Change-ID: 20260623-b4-disas-xthead-fix-riscv-next-c6af6a09d2dc
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782916375; l=3410;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=404ZXdbQmgndXKGsY1KiOS41sbXVN5tWIX3Bxs8+obA=;
 b=PNLMeLgcTY4wjMpoKzhsff7iu/5MumibKiDXLXKcWYRv/VZtF//P2YQEf1FX/bJByqUbJfiLz
 xXpgxGAZ1BwCy4QkGDf7Ivx/1pKS29D3zPjarYaajngTvCaJ9QlQOw3
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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

Fix two XThead immediate decoding issues in the RISC-V disassembler, fix
vector immediate signedness handling, and make operand extraction more
explicit.

The first patch aligns th.srri decoding with target/riscv/xthead.decode:
th_srri uses bits 31:26 as 000100 and bit 25 as shamt[5], while the
disassembler switches on bits 31:25.

The second patch extracts the full 6-bit immediate field for
rv_codec_r2_imm6, which fixes the immediate printed for th.srri and
th.tst.

The third patch makes operand_vimm() return int32_t, matching the signed
5-bit vector immediate value it extracts.

The fourth patch decodes unsigned 5-bit vector immediates with a separate
codec, matching the target translator paths that zero-extend or truncate
those fields.

The fifth patch follows Richard's review suggestion by converting operand
helper bit extraction to extract32() or sextract32(). Signed immediates use
sextract32() on the sign-bearing field and combine it with the remaining
extract32() fields.

This series is based on Alistair's riscv-to-apply.next branch:
9afc75682112 ("hw/riscv/riscv-iommu.c: make FCTL.BE read only 0")

Testing:
- Applied and tested on top of Alistair's riscv-to-apply.next branch.
- Verified with an external test branch that adds unit coverage:
  https://github.com/LLyndra/qemu.git b4-disas-riscv-v2-tests

  The added tests cover XThead th.srri/th.tst immediate decoding,
  signed vector immediates, unsigned vector immediate operands, and
  signed base ISA I-immediate extraction.
- Commands run:
    ./configure --target-list=riscv64-softmmu --disable-docs \
        --prefix=/tmp/qemu-riscv-disas-test --cross-prefix=
    ninja -C build tests/unit/test-riscv-disas
    build/tests/unit/test-riscv-disas --tap -k
- Result:
    test-riscv-disas passed: 37/37 TAP tests ok.

---
Changes in v3:
- Updated the extract-helper cleanup patch to use sextract32() on the
  sign-bearing field directly, as suggested by Richard.
- Link to v2: https://lore.kernel.org/qemu-devel/20260701-b4-disas-xthead-fix-riscv-next-v2-0-e6e4ff5a7847@linux.alibaba.com

Changes in v2:
- Collected Reviewed-by tags from Daniel.
- Kept the 6-bit immediate fix as a minimal correctness change.
- Added a patch making the signed vector immediate helper return a signed
  type.
- Added a patch decoding unsigned vector immediates separately from signed
  vector immediates.
- Added a cleanup patch using extract32()/sextract32() for replaceable
  operand helper field extraction, including split immediates, as
  suggested by Richard.
- Link to v1: https://lore.kernel.org/qemu-devel/20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com

---
TANG Tiancheng (5):
      disas/riscv: Fix th.srri decoding
      disas/riscv: Fix 6-bit immediate extraction
      disas/riscv: Use signed type for vector immediates
      disas/riscv: Decode unsigned vector immediates as unsigned
      disas/riscv: Use extract helpers for operand fields

 disas/riscv-xthead.c |   6 +-
 disas/riscv.c        | 263 +++++++++++++++++++++++++++------------------------
 disas/riscv.h        |   1 +
 3 files changed, 142 insertions(+), 128 deletions(-)
---
base-commit: 9afc756821123d0b9dfbf3c5673d82b048a6248a
change-id: 20260623-b4-disas-xthead-fix-riscv-next-c6af6a09d2dc

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


