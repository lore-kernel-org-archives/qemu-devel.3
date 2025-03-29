Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDFC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 09:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyS4P-0007AG-2S; Sat, 29 Mar 2025 05:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyS4L-00079l-RJ; Sat, 29 Mar 2025 05:01:34 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyS4E-0003nY-8H; Sat, 29 Mar 2025 05:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1743238875; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Xyu1FZsAebbK6AA0inw3oo8sn/P5+w9I+pUDs250GCI=;
 b=ccSaLoXTJsDJiQik0w9w9W8aOf+gnHr2TMo+LphWntNV3uL39ya5+epSJ0/d/tSHE4+dX90YlBg5wQEKtYYV5L8d3JXl2vQUTcERgGZk1Qo4O9s9nfi4Fxu2XQDHwh9KdOm/Jhpe2cx2SqMsfBGaqz30C9EmzVGdbKPqut+XSqQ=
Received: from 30.166.64.61(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WTIe7pa_1743238872 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 29 Mar 2025 17:01:12 +0800
Message-ID: <ea016721-8fc2-4394-9189-5c359c22fc73@linux.alibaba.com>
Date: Sat, 29 Mar 2025 17:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/riscv: pmp: fix checks on writes to pmpcfg
 in Smepmp MML mode
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-4-loic@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250313193011.720075-4-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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


On 2025/3/14 03:30, Loïc Lefort wrote:
> With Machine Mode Lockdown (mseccfg.MML) set and RLB not set, checks on pmpcfg
> writes would match the wrong cases of Smepmp truth table.
>
> The existing code allows writes for the following cases:
> - L=1, X=0: cases 8, 10, 12, 14
> - L=0, RWX!=WX: cases 0-2, 4-6
> This leaves cases 3, 7, 9, 11, 13, 15 for which writes are ignored.
Good catch.
>
>  From the Smepmp specification: "Adding a rule with executable privileges that
> either is M-mode-only or a locked Shared-Region is not possible (...)" This
> description matches cases 9-11, 13 of the truth table.
>
> This commit implements an explicit check for these cases by using
> pmp_get_epmp_operation to convert between PMP configuration and Smepmp truth
> table cases.
>
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/pmp.c | 79 +++++++++++++++++++++++++---------------------
>   1 file changed, 43 insertions(+), 36 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 7d65dc24a5..c5f6cdaccb 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -75,6 +75,44 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
>       return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
>   }
>   
> +/*
> + * Check whether `val` is an invalid Smepmp config value
> + */
> +static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
> +{
> +    /* No check if mseccfg.MML is not set or if mseccfg.RLB is set */
> +    if (!MSECCFG_MML_ISSET(env) || MSECCFG_RLB_ISSET(env)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Adding a rule with executable privileges that either is M-mode-only
> +     * or a locked Shared-Region is not possible
> +     */
> +    switch (pmp_get_smepmp_operation(val)) {
> +    case 0:
> +    case 1:
> +    case 2:
> +    case 3:
> +    case 4:
> +    case 5:
> +    case 6:
> +    case 7:
> +    case 8:
> +    case 12:
> +    case 14:
> +    case 15:
> +        return 0;
> +    case 9:
> +    case 10:
> +    case 11:
> +    case 13:
> +        return 1;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

I think we should define a truth table for smepmp when mml is 1.

One reason is we can avoid the magic numbers here in the switch case. 
Another reason is we have already used this truth table twice in 
pmp_hart_has_privs.


Otherwise,
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> +
>   /*
>    * Count the number of active rules.
>    */
> @@ -103,44 +141,13 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> -        bool readonly = true;
> -
> -        if (riscv_cpu_cfg(env)->ext_smepmp) {
> -            /* mseccfg.RLB is set */
> -            if (MSECCFG_RLB_ISSET(env)) {
> -                readonly = false;
> -            }
> -
> -            /* mseccfg.MML is not set */
> -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
> -                readonly = false;
> -            }
> -
> -            /* mseccfg.MML is set */
> -            if (MSECCFG_MML_ISSET(env)) {
> -                /* not adding execute bit */
> -                if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
> -                    readonly = false;
> -                }
> -                /* shared region and not adding X bit */
> -                if ((val & PMP_LOCK) != PMP_LOCK &&
> -                    (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
> -                    readonly = false;
> -                }
> -            }
> -        } else {
> -            readonly = pmp_is_readonly(env, pmp_index);
> -        }
> -
> -        if (readonly) {
> +        if (pmp_is_readonly(env, pmp_index)) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "ignoring pmpcfg write - read only\n");
> -        } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
> -            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
> -            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> -                !MSECCFG_MML_ISSET(env)) {
> -                return false;
> -            }
> +        } else if (pmp_is_invalid_smepmp_cfg(env, val)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ignoring pmpcfg write - invalid\n");
> +        } else {
>               env->pmp_state.pmp[pmp_index].cfg_reg = val;
>               pmp_update_rule_addr(env, pmp_index);
>               return true;

