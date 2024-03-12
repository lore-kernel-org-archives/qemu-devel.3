Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1B1C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 02:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjs0J-0000W6-Rz; Mon, 11 Mar 2024 22:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rjs0F-0000Vk-Q4; Mon, 11 Mar 2024 22:36:32 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rjs09-0002SP-Kd; Mon, 11 Mar 2024 22:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710210973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=bj8e0iChBUvFH/+hfLkQPtJuF7Ib3Y/H7e85fmCJnBk=;
 b=dHu8uburIRmzMLOWQ6N4uiHytE9BiyvdCEaEjzwGJ/6YHyI1BAdE24B9k1eKyV7F/lR6VL5y8DIvSLoMfSEzGSO6+eLdBDP1U/9546gEzNSjM7BN4+tkXgRPbIgvBKDX6OanILzl5foymRH5ASciuS6+UkxSM2JFNeKHB2uz/9A=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W2KElfp_1710210970; 
Received: from 30.198.0.173(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2KElfp_1710210970) by smtp.aliyun-inc.com;
 Tue, 12 Mar 2024 10:36:11 +0800
Message-ID: <c68ea7b8-5c6c-4045-a759-667ce9873efe@linux.alibaba.com>
Date: Tue, 12 Mar 2024 10:36:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
Content-Language: en-US
To: Yu-Ming Chang <yumin686@andestech.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20240311030852.53831-1-yumin686@andestech.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240311030852.53831-1-yumin686@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/3/11 11:08, Yu-Ming Chang wrote:
> Both CSRRS and CSRRC always read the addressed CSR and cause any read side
> effects regardless of rs1 and rd fields. Note that if rs1 specifies a register
> holding a zero value other than x0, the instruction will still attempt to write
> the unmodified value back to the CSR and will cause any attendant side effects.
>
> So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specifies
> a register holding a zero value, an illegal instruction exception should be
> raised.
>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
> This incorporated the comments from Richard. Thank you.
>
>   target/riscv/cpu.h       |  2 ++
>   target/riscv/csr.c       | 17 ++++++++++++++---
>   target/riscv/op_helper.c |  2 +-
>   3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5d291a7092..452841ae2f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -710,6 +710,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>   void riscv_cpu_update_mask(CPURISCVState *env);
>   bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                          target_ulong *ret_value);
>   RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                              target_ulong *ret_value,
>                              target_ulong new_value, target_ulong write_mask);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d4e8ac13b9..0d14ba2ba5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4306,7 +4306,7 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
>   
>   static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>                                                  int csrno,
> -                                               bool write_mask)
> +                                               bool write)
>   {
>       /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
>       bool read_only = get_field(csrno, 0xC00) == 3;
> @@ -4328,7 +4328,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>       }
>   
>       /* read / write check */
> -    if (write_mask && read_only) {
> +    if (write && read_only) {
>           return RISCV_EXCP_ILLEGAL_INST;
>       }
>   
> @@ -4415,11 +4415,22 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                           target_ulong *ret_value)
> +{
> +    RISCVException ret = riscv_csrrw_check(env, csrno, false);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
> +}
> +
>   RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                              target_ulong *ret_value,
>                              target_ulong new_value, target_ulong write_mask)
>   {
> -    RISCVException ret = riscv_csrrw_check(env, csrno, write_mask);
> +    RISCVException ret = riscv_csrrw_check(env, csrno, true);
>       if (ret != RISCV_EXCP_NONE) {
>           return ret;
>       }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdb..f3aa705be8 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -51,7 +51,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
>       }
>   
>       target_ulong val = 0;
> -    RISCVException ret = riscv_csrrw(env, csr, &val, 0, 0);
> +    RISCVException ret = riscv_csrr(env, csr, &val);
>   
>       if (ret != RISCV_EXCP_NONE) {
>           riscv_raise_exception(env, ret, GETPC());

Hi Yu-Ming,

The 128-bit CSR operations have the similar errors. Could you solve the 
similar bug in this patch set?

Otherwise,

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Thanks,
Zhiwei


