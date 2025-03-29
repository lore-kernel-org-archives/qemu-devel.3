Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED4CC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 08:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyRiz-0002vY-36; Sat, 29 Mar 2025 04:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyRis-0002uc-HR; Sat, 29 Mar 2025 04:39:24 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyRiq-0001Jq-1H; Sat, 29 Mar 2025 04:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1743237550; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=bRxVVxf+4htzbJXWTvgpKNYSyXChRz14wKVu/BFHdR0=;
 b=uq3SWTF0lV/UmHYqEOvtX9YxqsifSUpuPJ3u0vhQ1zl1IFLwPipWd30Z0J9bDjhk9qa03d++xn1dXVO08lZCUmk38kClZ9Y85tmTEkYKN23EE+O0wACycfcjB0C9oupuF6RYUDr7MCIT3/zeCQyZM27Cw6Nvwqv4QM8F0Nv23lE=
Received: from 30.166.64.61(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WTIWZP4_1743237238 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 29 Mar 2025 16:33:58 +0800
Message-ID: <d0a8d305-04c6-49b4-9827-36cfad80c108@linux.alibaba.com>
Date: Sat, 29 Mar 2025 16:33:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-2-loic@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250313193011.720075-2-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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
> When Smepmp is supported, mseccfg.RLB allows bypassing locks when writing CSRs
> but should not affect interpretation of actual PMP rules.
>
> This is not the case with the current implementation where pmp_hart_has_privs
> calls pmp_is_locked which implements mseccfg.RLB bypass.
>
> This commit implements the correct behavior by removing mseccfg.RLB bypass from
> pmp_is_locked.
>
> RLB bypass when writing CSRs is implemented by adding a new pmp_is_readonly
> function that calls pmp_is_locked and check mseccfg.RLB. pmp_write_cfg and
> pmpaddr_csr_write are changed to use this new function.
>
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>

Reviewed-by: LIU Zhiwei  <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/pmp.c | 43 +++++++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index b0841d44f4..e1e5ca589e 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
>    */
>   static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>   {
> -    /* mseccfg.RLB is set */
> -    if (MSECCFG_RLB_ISSET(env)) {
> -        return 0;
> -    }
> -
>       if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
>           return 1;
>       }
> @@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>       return 0;
>   }
>   
> +/*
> + * Check whether a PMP is locked for writing or not.
> + * (i.e. has LOCK flag and mseccfg.RLB is unset)
> + */
> +static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
> +{
> +    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
> +}
> +
>   /*
>    * Count the number of active rules.
>    */
> @@ -90,39 +94,38 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> -        bool locked = true;
> +        bool readonly = true;
>   
>           if (riscv_cpu_cfg(env)->ext_smepmp) {
>               /* mseccfg.RLB is set */
>               if (MSECCFG_RLB_ISSET(env)) {
> -                locked = false;
> +                readonly = false;
>               }
>   
>               /* mseccfg.MML is not set */
> -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index)) {
> -                locked = false;
> +            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
> +                readonly = false;
>               }
>   
>               /* mseccfg.MML is set */
>               if (MSECCFG_MML_ISSET(env)) {
>                   /* not adding execute bit */
>                   if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
> -                    locked = false;
> +                    readonly = false;
>                   }
>                   /* shared region and not adding X bit */
>                   if ((val & PMP_LOCK) != PMP_LOCK &&
>                       (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
> -                    locked = false;
> +                    readonly = false;
>                   }
>               }
>           } else {
> -            if (!pmp_is_locked(env, pmp_index)) {
> -                locked = false;
> -            }
> +            readonly = pmp_is_readonly(env, pmp_index);
>           }
>   
> -        if (locked) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
> +        if (readonly) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "ignoring pmpcfg write - read only\n");
>           } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
>               /* If !mseccfg.MML then ignore writes with encoding RW=01 */
>               if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> @@ -524,14 +527,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
>               is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
>   
> -            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
> +            if (pmp_is_readonly(env, addr_index + 1) && is_next_cfg_tor) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
> -                              "ignoring pmpaddr write - pmpcfg + 1 locked\n");
> +                              "ignoring pmpaddr write - pmpcfg+1 read only\n");
>                   return;
>               }
>           }
>   
> -        if (!pmp_is_locked(env, addr_index)) {
> +        if (!pmp_is_readonly(env, addr_index)) {
>               if (env->pmp_state.pmp[addr_index].addr_reg != val) {
>                   env->pmp_state.pmp[addr_index].addr_reg = val;
>                   pmp_update_rule_addr(env, addr_index);
> @@ -542,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               }
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR,
> -                          "ignoring pmpaddr write - locked\n");
> +                          "ignoring pmpaddr write - read only\n");
>           }
>       } else {
>           qemu_log_mask(LOG_GUEST_ERROR,

