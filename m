Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08289D2CE17
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 03:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vS5Vv-0002TQ-PZ; Sat, 06 Dec 2025 22:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vS5Vu-0002Ss-4W; Sat, 06 Dec 2025 22:32:46 -0500
Received: from out28-69.mail.aliyun.com ([115.124.28.69])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vS5Vr-0001xc-RM; Sat, 06 Dec 2025 22:32:45 -0500
Received: from 192.168.71.26(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.feaYEaU_1765078344 cluster:ay29) by smtp.aliyun-inc.com;
 Sun, 07 Dec 2025 11:32:25 +0800
Message-ID: <63697707-289f-4eec-a377-ea84f91f3869@zevorn.cn>
Date: Sun, 7 Dec 2025 11:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: chao.liu@zevorn.cn
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, ebiggers@kernel.org, 
 liwei1518@gmail.com, npiggin@gmail.com, palmer@dabbelt.com,
 paolo.savini@embecosm.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <cover.1758006834.git.chao.liu@zevorn.cn>
Subject: Re: [PATCH v9 0/2] Generate strided vector loads/stores with tcg nodes
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <cover.1758006834.git.chao.liu@zevorn.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.69; envelope-from=chao.liu@zevorn.cn;
 helo=out28-69.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 16 Sep 2025 17:21:36 +0800, Chao Liu wrote:
>Hi all,
>
>Thanks Richard for the review. In patch v9:
>
>- Simplify the implementation of gen_check_vext_elem_mask():
>  remove the `mask` argument, compute the mask directly inside the function,
>  and eliminate redundant code.
>
>- Limit the bit width to 8 bits when loading the mask from memory.
>
>- Remove the `vreg` argument in gen_ldst_vreg().
>
>History of changes:
>
>patch v8:
>- Use the right TCGv type for each variable — for example, make mask_elem
>  type TCGv_i64.
>- Use tcg_gen_trunc_i64_ptr() to change TCGv types — don't use C-style
>  casting.
>- Use TCG_COND_TSTNE, not TCG_COND_NE in tcg_gen_brcond_i64() to represent:
>  if (vext_elem_mask(v0, i) != 0)
>  https://lore.kernel.org/qemu-devel/cover.1757690407.git.chao.liu@zevorn.cn/
>
>patch v7:
>- Standardize the subject line of patch 1 and remove the trailing period.
>- Split into sub-functions to improve the patch's code readability and
>  facilitate review.
>- Use more faster TCG ops, use tcg_gen_andi_tl() instead of tcg_gen_rem_tl().
>- Add a tested-by signature for patch 2, as Eric has already tested it.
>  https://lore.kernel.org/qemu-devel/cover.1756975571.git.chao.liu@zevorn.cn/
>
>patch v6:
>- If a strided vector memory access instruction has non-zero vstart, 
>  check it through vlse/vsse helpers function.
>- Adjust the tcg test Makefile.
>  https://lore.kernel.org/qemu-devel/cover.1756906528.git.chao.liu@zevorn.cn/
>
>Patch v5:
>- Removed the redundant call to mark_vs_dirty(s) within the
>  gen_ldst_stride_main_loop() function.
>  https://lore.kernel.org/qemu-riscv/cover.1755609029.git.chao.liu@zevorn.cn/
>
>Patch v4:
>- Use ctz32() replace to for-loop
>  https://lore.kernel.org/qemu-devel/cover.1755333616.git.chao.liu@yeah.net/
>
>Patch v3:
>- Fix the get_log2() function:
>  https://lore.kernel.org/qemu-riscv/cover.1755287531.git.chao.liu@yeah.net/T/#t
>- Add test for vlsseg8e32 instruction.
>- Rebase on top of the latest master.
>
>Patch v2:
>- Split the TCG node emulation of the complex strided load/store operation into
>  two separate functions to simplify the implementation:
>  https://lore.kernel.org/qemu-riscv/20250312155547.289642-1-paolo.savini@embecosm.com/
>
>Patch v1:
>- Paolo submitted the initial version of the patch.
>  https://lore.kernel.org/qemu-devel/20250211182056.412867-1-paolo.savini@embecosm.com/
>

Ping.

Does anyone have any further comments or revisions on this set of patches?
I have been using them in the production environment for a long time, and so far,
they have been working reliably.

Thanks,
Chao

