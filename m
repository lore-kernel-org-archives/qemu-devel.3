Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8069AC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 08:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyRwn-00059E-2d; Sat, 29 Mar 2025 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyRwm-00058y-4P; Sat, 29 Mar 2025 04:53:44 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyRwi-0002y8-QQ; Sat, 29 Mar 2025 04:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1743238411; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=jUsuQT1ffFVWLfaoV37Ui4vdfR/xGs/sIZV5NKfs+oE=;
 b=dVaf8paG3qE7HUx0LEaThIqMFjsxELU3H0rSxkHv3EZMgiXjX8/I9JuHlHyk/mlVs6EfK0SIZLM5lHQVV69p2E3G86GGsGUMWvEaacWZjI/MWA7qUt0q5bI+kSBZqyaniag9A0nG0mMERcS8kJoI3ESeb4b5p+WdE1bY95PziFg=
Received: from 30.166.64.61(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WTIWhLR_1743238410 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 29 Mar 2025 16:53:30 +0800
Message-ID: <c3130367-d821-4b5c-a5e3-12fa98658ae8@linux.alibaba.com>
Date: Sat, 29 Mar 2025 16:53:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] target/riscv: pmp: move Smepmp operation
 conversion into a function
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-3-loic@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250313193011.720075-3-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
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
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/pmp.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index e1e5ca589e..7d65dc24a5 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -31,6 +31,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
>                             uint8_t val);
>   static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
>   
> +/*
> + * Convert the PMP permissions to match the truth table in the Smepmp spec.
> + */
> +static inline uint8_t pmp_get_smepmp_operation(uint8_t cfg)
> +{
> +    return ((cfg & PMP_LOCK) >> 4) | ((cfg & PMP_READ) << 2) |
> +           (cfg & PMP_WRITE) | ((cfg & PMP_EXEC) >> 2);
> +}
> +
>   /*
>    * Accessor method to extract address matching type 'a field' from cfg reg
>    */
> @@ -355,16 +364,6 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>           const uint8_t a_field =
>               pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>   
> -        /*
> -         * Convert the PMP permissions to match the truth table in the
> -         * Smepmp spec.
> -         */
> -        const uint8_t smepmp_operation =
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
> -            (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_EXEC) >> 2);
> -
>           if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
>               /*
>                * If the PMP entry is not off and the address is in range,
> @@ -383,6 +382,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
>                   /*
>                    * If mseccfg.MML Bit set, do the enhanced pmp priv check
>                    */
> +                const uint8_t smepmp_operation =
> +                    pmp_get_smepmp_operation(env->pmp_state.pmp[i].cfg_reg);
> +
>                   if (mode == PRV_M) {
>                       switch (smepmp_operation) {
>                       case 0:

