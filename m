Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29506D1715C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 03:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t35Jy-0002hb-0Z; Mon, 21 Oct 2024 23:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t35Jt-0002hH-2a; Mon, 21 Oct 2024 23:12:29 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t35Jp-0006jV-Py; Mon, 21 Oct 2024 23:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1729566734; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=O1YF3MhKvfa4h2+MKp0zvG1Kc+33Z+47MJ8GL8rySwk=;
 b=xgxG40e5T5Bmmp6hDA8SpprLJ4YxO2HttdywhFIWDjLqeEKH6nqhHMaV2HnJuNJmrQuAx4CSB2k08WAzlUQPGpRVqZMRW4+MUr+8sZzxc0u9SidhX45ktkvyP5FPGgDjyGudbtAGYe/kyEHcSj9kLUwM4Jh+T5sv8c/XOP6VNgk=
Received: from 30.166.64.99(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WHgKM.S_1729566732 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 22 Oct 2024 11:12:12 +0800
Message-ID: <b82a2350-9115-4bb3-9aa4-46f7c5087927@linux.alibaba.com>
Date: Tue, 22 Oct 2024 11:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/14] disas/riscv: Fix vsetivli disassembly
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-3-richard.henderson@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241016193140.2206352-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/10/17 03:31, Richard Henderson wrote:
> The first immediate field is unsigned, whereas operand_vimm
> extracts a signed value.  There is no need to mask the result
> with 'u'; just print the immediate with 'i'.
>
> Fixes: 07f4964d178 ("disas/riscv.c: rvv: Add disas support for vector instructions")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/riscv.h | 2 +-
>   disas/riscv.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 16a08e4895..0d1f89ce8a 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -290,7 +290,7 @@ enum {
>   #define rv_fmt_fd_vs2                 "O\t3,F"
>   #define rv_fmt_vd_vm                  "O\tDm"
>   #define rv_fmt_vsetvli                "O\t0,1,v"
> -#define rv_fmt_vsetivli               "O\t0,u,v"
> +#define rv_fmt_vsetivli               "O\t0,i,v"
>   #define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
>   #define rv_fmt_push_rlist             "O\tx,-i"
>   #define rv_fmt_pop_rlist              "O\tx,i"
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 5965574d87..fc0331b90b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4808,7 +4808,7 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
>           break;
>       case rv_codec_vsetivli:
>           dec->rd = operand_rd(inst);
> -        dec->imm = operand_vimm(inst);
> +        dec->imm = extract32(inst, 15, 5);

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>           dec->vzimm = operand_vzimm10(inst);
>           break;
>       case rv_codec_zcb_lb:

