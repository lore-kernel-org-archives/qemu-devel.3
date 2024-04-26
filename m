Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387CC10F15
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 01:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0AZV-0006T1-73; Thu, 25 Apr 2024 21:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s0AZS-0006RX-Tx; Thu, 25 Apr 2024 21:40:15 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s0AZQ-0000hG-9P; Thu, 25 Apr 2024 21:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1714095597; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=m6INjHsZ/84mv6B/Je5F8hzLj8JixF7ldalsSuwtQS4=;
 b=d0ImVzOFsxvpUhgRnwDDqj69aS5AKDKXgiEHQqWrjmfvDP8nl/30NZRDv1w0gj+EeIE46DithyxZMYXTmLPHxPP/Ue5WE+BOSlJx04wzRyiyWndLnDE309ElwQa4KW9qC03GyKmqmpM8DGjPBUGe3Lv6SAA1fN9crQJ+RWFvdBs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W5Gx1wQ_1714095595; 
Received: from 30.198.0.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W5Gx1wQ_1714095595) by smtp.aliyun-inc.com;
 Fri, 26 Apr 2024 09:39:56 +0800
Message-ID: <270b35d6-9671-4495-bdb6-4d4e1db28aac@linux.alibaba.com>
Date: Fri, 26 Apr 2024 09:39:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 1/2] target/riscv/debug: set tval=pc in
 breakpoint exceptions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, richard.henderson@linaro.org
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
 <20240416230437.1869024-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240416230437.1869024-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
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
> We're not setting (s/m)tval when triggering breakpoints of type 2
> (mcontrol) and 6 (mcontrol6). According to the debug spec section
> 5.7.12, "Match Control Type 6":
>
> "The Privileged Spec says that breakpoint exceptions that occur on
> instruction fetches, loads, or stores update the tval CSR with either
> zero or the faulting virtual address. The faulting virtual address for
> an mcontrol6 trigger with action = 0 is the address being accessed and
> which caused that trigger to fire."
>
> A similar text is also found in the Debug spec section 5.7.11 w.r.t.
> mcontrol.
>
> Note that what we're doing ATM is not violating the spec, but it's
> simple enough to set mtval/stval and it makes life easier for any
> software that relies on this info.
>
> Given that we always use action = 0, save the faulting address for the
> mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
> used as as scratch area for traps with address information. 'tval' is
> then set during riscv_cpu_do_interrupt().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c | 1 +
>   target/riscv/debug.c      | 3 +++
>   2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index fc090d729a..f9c6d7053b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>               tval = env->bins;
>               break;
>           case RISCV_EXCP_BREAKPOINT:
> +            tval = env->badaddr;
>               if (cs->watchpoint_hit) {
>                   tval = cs->watchpoint_hit->hitaddr;
>                   cs->watchpoint_hit = NULL;
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..b110370ea6 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                   if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
>                       /* check U/S/M bit against current privilege level */
>                       if ((ctrl >> 3) & BIT(env->priv)) {
> +                        env->badaddr = pc;
>                           return true;
>                       }
>                   }
> @@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                       if (env->virt_enabled) {
>                           /* check VU/VS bit against current privilege level */
>                           if ((ctrl >> 23) & BIT(env->priv)) {
> +                            env->badaddr = pc;
>                               return true;
>                           }
>                       } else {
>                           /* check U/S/M bit against current privilege level */
>                           if ((ctrl >> 3) & BIT(env->priv)) {
> +                            env->badaddr = pc;
>                               return true;
>                           }
>                       }

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei


