Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005FFC43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkEx1-00034b-Pw; Thu, 16 Jul 2026 01:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wkEws-00033m-Ux; Thu, 16 Jul 2026 01:47:54 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wkEwf-0005sn-JU; Thu, 16 Jul 2026 01:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784180834; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=uDX7x13DA6IZpGu69TxU6W58VJFYBz17Hd+QDSaOHKM=;
 b=eFj8Wk34HRoqBKqK0+kdxiX38Pe6fjdmOpRNplj/uqN3f/mSwbugVkQPdG+T8TSmdVt9lOzz2uf4759x6ls1l0qdodLdack+HZ2op+rrgdFSY+mthN68Jy32auWr+O2HeLrIUccQ51ZuKZO5jJyA9r+LmRzvKeLG04ZU5JXLNFE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X7CFkfQ_1784180830; 
Received: from 30.166.64.228(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X7CFkfQ_1784180830 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 16 Jul 2026 13:47:11 +0800
Message-ID: <fc6cb1dc-e531-4073-93aa-7a42ab864c50@linux.alibaba.com>
Date: Thu, 16 Jul 2026 13:47:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] disas/riscv: Fix immediate decoding and extraction
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7@linux.alibaba.com>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001,
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

Hi,

Gentle ping for this series.

v4 still applies cleanly on current Alistair's riscv-to-apply.next
(8fb3075916), and test-riscv-disas still passes with the external unit
test coverage:
https://patchew.org/QEMU/20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7%40linux.alibaba.com/

Thanks,
TianCheng

在 2026/7/3 13:03, TANG Tiancheng 写道:
> Fix two XThead immediate decoding issues in the RISC-V disassembler, fix
> vector immediate signedness handling, and make operand extraction more
> explicit.
>
> The first patch aligns th.srri decoding with target/riscv/xthead.decode:
> th_srri uses bits 31:26 as 000100 and bit 25 as shamt[5], while the
> disassembler switches on bits 31:25.
>
> The second patch extracts the full 6-bit immediate field for
> rv_codec_r2_imm6, which fixes the immediate printed for th.srri and
> th.tst.
>
> The third patch makes operand_vimm() return int32_t, matching the signed
> 5-bit vector immediate value it extracts.
>
> The fourth patch decodes unsigned 5-bit vector immediates with a separate
> codec, matching the target translator paths that zero-extend or truncate
> those fields.
>
> The fifth patch follows Richard's review suggestion by converting operand
> helper bit extraction to extract32() or sextract32(). Signed immediates use
> sextract32() on the sign-bearing field and combine it with the remaining
> extract32() fields.
>
> This series is based on Alistair's riscv-to-apply.next branch:
> 64ce9ac18757 ("hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0")
>
> Testing:
> - Applied and tested on top of Alistair's riscv-to-apply.next branch.
> - Verified with an external test branch that adds unit coverage:
>    https://github.com/LLyndra/qemu.git b4-disas-riscv-v2-tests
>
>    The added tests cover XThead th.srri/th.tst immediate decoding,
>    signed vector immediates, unsigned vector immediate operands, and
>    signed base ISA I-immediate extraction.
> - Commands run:
>      ./configure --target-list=riscv64-softmmu --disable-docs \
>          --prefix=/tmp/qemu-riscv-disas-test --cross-prefix=
>      ninja -C build tests/unit/test-riscv-disas
>      build/tests/unit/test-riscv-disas --tap -k
> - Result:
>      test-riscv-disas passed: 37/37 TAP tests ok.
>
> ---
> Changes in v4:
> - Rebased on current Alistair's riscv-to-apply.next branch.
> - Folded Alex's extract32() suggestion into the 6-bit immediate
>    fix patch, so it directly uses extract32(inst, 20, 6).
> - Link to v3: https://lore.kernel.org/qemu-devel/20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com
>
> Changes in v3:
> - Updated the extract-helper cleanup patch to use sextract32() on the
>    sign-bearing field directly, as suggested by Richard.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260701-b4-disas-xthead-fix-riscv-next-v2-0-e6e4ff5a7847@linux.alibaba.com
>
> Changes in v2:
> - Collected Reviewed-by tags from Daniel.
> - Kept the 6-bit immediate fix as a minimal correctness change.
> - Added a patch making the signed vector immediate helper return a signed
>    type.
> - Added a patch decoding unsigned vector immediates separately from signed
>    vector immediates.
> - Added a cleanup patch using extract32()/sextract32() for replaceable
>    operand helper field extraction, including split immediates, as
>    suggested by Richard.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com
>
> ---
> TANG Tiancheng (5):
>        disas/riscv: Fix th.srri decoding
>        disas/riscv: Fix 6-bit immediate extraction
>        disas/riscv: Use signed type for vector immediates
>        disas/riscv: Decode unsigned vector immediates as unsigned
>        disas/riscv: Use extract helpers for operand fields
>
>   disas/riscv-xthead.c |   6 +-
>   disas/riscv.c        | 263 +++++++++++++++++++++++++++------------------------
>   disas/riscv.h        |   1 +
>   3 files changed, 142 insertions(+), 128 deletions(-)
> ---
> base-commit: 64ce9ac18757d79f3b5b337f7bcbdd0dabef3ce1
> change-id: 20260623-b4-disas-xthead-fix-riscv-next-c6af6a09d2dc
>
> Best regards,

