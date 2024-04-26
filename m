Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF59C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 01:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0AZs-0006WU-Ku; Thu, 25 Apr 2024 21:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s0AZq-0006Vs-F9; Thu, 25 Apr 2024 21:40:38 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s0AZo-0000x3-E9; Thu, 25 Apr 2024 21:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1714095630; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=xyLdbbtKso8hxC35XrCJqU4Rihqac2TfwcUJ5+2GB+U=;
 b=SNNJK2Es+rvyA1w+x+SWxJvhkqbN4t3/ZFTP/L/YBSXvZex98Sk4OmmYKk2FCP3ytopTYBtjpTcZtm8qufAuOFPIcObvDClX9UpFg2g+rbJjH/6kLN8lrVwemjClhSJj/p3GCbrn4p8vTROmsjixNiIoJK1od1J+scucGCbkDbc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W5Gx27t_1714095627; 
Received: from 30.198.0.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W5Gx27t_1714095627) by smtp.aliyun-inc.com;
 Fri, 26 Apr 2024 09:40:28 +0800
Message-ID: <027bad4d-e1f5-470a-b7ef-809fc49b15dd@linux.alibaba.com>
Date: Fri, 26 Apr 2024 09:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 2/2] trans_privileged.c.inc: set (m|s)tval on
 ebreak breakpoint
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, richard.henderson@linaro.org
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
 <20240416230437.1869024-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240416230437.1869024-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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


On 2024/4/17 7:04, Daniel Henrique Barboza wrote:
> Privileged spec section 4.1.9 mentions:
>
> "When a trap is taken into S-mode, stval is written with
> exception-specific information to assist software in handling the trap.
> (...)
>
> If stval is written with a nonzero value when a breakpoint,
> address-misaligned, access-fault, or page-fault exception occurs on an
> instruction fetch, load, or store, then stval will contain the faulting
> virtual address."
>
> A similar text is found for mtval in section 3.1.16.
>
> Setting mtval/stval in this scenario is optional, but some softwares read
> these regs when handling ebreaks.
>
> Write 'badaddr' in all ebreak breakpoints to write the appropriate
> 'tval' during riscv_do_cpu_interrrupt().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 620ab54eb0..bc5263a4e0 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -62,6 +62,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>       if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
>           generate_exception(ctx, RISCV_EXCP_SEMIHOST);
>       } else {
> +        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
> +                      offsetof(CPURISCVState, badaddr));

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>           generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
>       }
>       return true;

