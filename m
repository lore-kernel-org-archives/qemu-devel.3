Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC4DC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 09:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyS60-0007yB-Pc; Sat, 29 Mar 2025 05:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyS5x-0007xj-VV; Sat, 29 Mar 2025 05:03:14 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tyS5v-0003sB-EX; Sat, 29 Mar 2025 05:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1743238986; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=DuGRDczNJXIQFiHwuHU1/i5SrNQ8mPRHZBhgYYjkI1o=;
 b=navPMq677mSEZJ7zmhqJkkCKChbBFRs8qGqzInmM06UTWI8ARSZpsEZVUJxh/0Y8u+rO5E5H0ayTM4FpxkFrO6+mF+yqPHD7quxChDI2+jasNkDinisqqQIwL76jJc4D/PvaZ2zJsNjWL8So5JRGehMsSDHalTpHhTlFcXHeXgA=
Received: from 30.166.64.61(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WTIe8cT_1743238983 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 29 Mar 2025 17:03:03 +0800
Message-ID: <3d3cf6a5-7ec2-427f-8f02-dc1e5a370996@linux.alibaba.com>
Date: Sat, 29 Mar 2025 17:03:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/riscv: pmp: exit csr writes early if value
 was not changed
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-5-loic@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250313193011.720075-5-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
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
> ---
>   target/riscv/pmp.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index c5f6cdaccb..845915e0c8 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -141,6 +141,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
>   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>   {
>       if (pmp_index < MAX_RISCV_PMPS) {
> +        if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
> +            /* no change */
> +            return false;
> +        }
> +
>           if (pmp_is_readonly(env, pmp_index)) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "ignoring pmpcfg write - read only\n");
> @@ -528,6 +533,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>       bool is_next_cfg_tor = false;
>   
>       if (addr_index < MAX_RISCV_PMPS) {
> +        if (env->pmp_state.pmp[addr_index].addr_reg == val) {
> +            /* no change */
> +            return;
> +        }
> +
>           /*
>            * In TOR mode, need to check the lock bit of the next pmp
>            * (if there is a next).
> @@ -544,14 +554,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>           }
>   
>           if (!pmp_is_readonly(env, addr_index)) {
> -            if (env->pmp_state.pmp[addr_index].addr_reg != val) {

Is there some benefit removing this if sentence?

Zhiwei

> -                env->pmp_state.pmp[addr_index].addr_reg = val;
> -                pmp_update_rule_addr(env, addr_index);
> -                if (is_next_cfg_tor) {
> -                    pmp_update_rule_addr(env, addr_index + 1);
> -                }
> -                tlb_flush(env_cpu(env));
> +            env->pmp_state.pmp[addr_index].addr_reg = val;
> +            pmp_update_rule_addr(env, addr_index);
> +            if (is_next_cfg_tor) {
> +                pmp_update_rule_addr(env, addr_index + 1);
>               }
> +            tlb_flush(env_cpu(env));
>           } else {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "ignoring pmpaddr write - read only\n");

