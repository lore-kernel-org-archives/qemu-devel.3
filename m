Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FFAC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlCc-0002OS-Lg; Mon, 21 Jul 2025 03:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1udlCI-000226-T7
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:44:30 -0400
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1udlCG-0002vy-7i
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753083859;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=CtgglYqh5238uTjSB6WpNb4n7xuodSALqbQckBIEsWw=;
 b=iEF01ykR6zc1eVk5kyAyrzKUr19od1wf2qggE9Pnj/+Eit56hyhHyeva6HpMcnNdhhJm6n
 Op/5T6aoUT9Wq8Ke1mmQtI4PWgxRZ4UX1emvC6z3mik4HGBTHTDAQ4HsmZznqgJyK/Vi/1
 b6haacKOhIhsDkTRhR68IGzBChLQQSWNAyD53jOJlzCSsnVp8LcKUi9Ny/qvOrdwPw9Qod
 sH/QdQXlDVp7Xm6xuq1eNRhX6E44baAauNVReILCFAyEd9mjuvvATyQO+QQDPW8iEE2uJn
 i9iTsxJTSvVrGtAwdAms+y/zDMNNx1H3g3styW7riXAY/H65Pf8LRSgBIO8JqA==
User-Agent: Mozilla Thunderbird
References: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
X-Lms-Return-Path: <lba+2687defd1+56f16b+nongnu.org+liujingqi@lanxincomputing.com>
To: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 <qemu-devel@nongnu.org>
Cc: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>, 
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>, 
 <palmer@dabbelt.com>, "Richard Henderson" <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/riscv: do not call GETPC() in
 check_ret_from_m_mode()
Date: Mon, 21 Jul 2025 15:44:14 +0800
Message-Id: <9cda05fa-1083-464f-a37f-25f8369c61bd@lanxincomputing.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Mon, 21 Jul 2025 15:44:16 +0800
Content-Language: en-US
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/14/2025 9:37 PM, Daniel Henrique Barboza wrote:
> GETPC() should always be called from the top level helper, e.g. the
> first helper that is called by the translation code. We stopped doing
> that in commit 3157a553ec, and then we introduced problems when
> unwinding the exceptions being thrown by helper_mret(), as reported by
> [1].
>
> Call GETPC() at the top level helper and pass the value along.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/3020
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/op_helper.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 15460bf84b..110292e84d 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -355,21 +355,22 @@ target_ulong helper_sret(CPURISCVState *env)
>   }
>   
>   static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
> -                                  target_ulong prev_priv)
> +                                  target_ulong prev_priv,
> +                                  uintptr_t ra)
>   {
>       if (!(env->priv >= PRV_M)) {
> -        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
>       }
>   
>       if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
>                                       env->priv_ver,
>                                       env->misa_ext) && (retpc & 0x3)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
>       }
>   
>       if (riscv_cpu_cfg(env)->pmp &&
>           !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
>       }
>   }
>   static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
> @@ -394,8 +395,9 @@ target_ulong helper_mret(CPURISCVState *env)
>       target_ulong retpc = env->mepc & get_xepc_mask(env);
>       uint64_t mstatus = env->mstatus;
>       target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> +    uintptr_t ra = GETPC();
>   
> -    check_ret_from_m_mode(env, retpc, prev_priv);
> +    check_ret_from_m_mode(env, retpc, prev_priv, ra);
>   
>       target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
>                                (prev_priv != PRV_M);
> @@ -443,8 +445,9 @@ target_ulong helper_mnret(CPURISCVState *env)
>       target_ulong retpc = env->mnepc;
>       target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
>       target_ulong prev_virt;
> +    uintptr_t ra = GETPC();
>   
> -    check_ret_from_m_mode(env, retpc, prev_priv);
> +    check_ret_from_m_mode(env, retpc, prev_priv, ra);
>   
>       prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
>                   (prev_priv != PRV_M);

