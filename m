Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19458C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 08:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmUbN-0003oA-7A; Tue, 19 Mar 2024 04:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmUbL-0003nc-2U; Tue, 19 Mar 2024 04:13:39 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmUbG-0007vb-Ib; Tue, 19 Mar 2024 04:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710836004; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=VMxGg/HglIseeNwydchbhH/8VOT54s9BYAGz/q0SMqo=;
 b=a8NuhIYaRlAdVLkwoWt+nXAeq97DsDgQkRGMEAgl5hrNs0cUL9klwRAq3X3elI27fqBHyMdIEG1r7NddAeIhEx1NPhjNPhN6SCqjWy9Z3Yt80bt7X8UcMEpRxuWzv+u8GqdfeWzeFWhlooVlb27jd0PuiLzp0tQh+xNr1G/WiC0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2sMZ1d_1710836001; 
Received: from 30.198.0.148(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2sMZ1d_1710836001) by smtp.aliyun-inc.com;
 Tue, 19 Mar 2024 16:13:22 +0800
Message-ID: <58752d39-25fb-467a-8e9b-15361539720d@linux.alibaba.com>
Date: Tue, 19 Mar 2024 16:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 04/10] target/riscv: always clear vstart in
 whole vec move insns
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, max.chou@sifive.com,
 richard.henderson@linaro.org
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-5-dbarboza@ventanamicro.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240314175704.478276-5-dbarboza@ventanamicro.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/3/15 1:56, Daniel Henrique Barboza wrote:
> These insns have 2 paths: we'll either have vstart already cleared if
> vstart_eq_zero or we'll do a brcond to check if vstart >= maxsz to call
> the 'vmvr_v' helper. The helper will clear vstart if it executes until
> the end, or if vstart >= vl.
>
> For starters, the check itself is wrong: we're checking vstart >= maxsz,
> when in fact we should use vstart in bytes, or 'startb' like 'vmvr_v' is
> calling, to do the comparison. But even after fixing the comparison we'll
> still need to clear vstart in the end, which isn't happening too.
>
> We want to make the helpers responsible to manage vstart, including
> these corner cases, precisely to avoid these situations:
>
> - remove the wrong vstart >= maxsz cond from the translation;
> - add a 'startb >= maxsz' cond in 'vmvr_v', and clear vstart if that
>    happens.
>
> This way we're now sure that vstart is being cleared in the end of the
> execution, regardless of the path taken.
>
> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 3 ---
>   target/riscv/vector_helper.c            | 5 +++++
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 8c16a9f5b3..52c26a7834 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3664,12 +3664,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
>                                vreg_ofs(s, a->rs2), maxsz, maxsz);        \
>               mark_vs_dirty(s);                                           \
>           } else {                                                        \
> -            TCGLabel *over = gen_new_label();                           \
> -            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
>               tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
>                                  tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
>               mark_vs_dirty(s);                                           \
> -            gen_set_label(over);                                        \
>           }                                                               \
>           return true;                                                    \
>       }                                                                   \
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 34ac4aa808..bcc553c0e2 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5075,6 +5075,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
>       uint32_t startb = env->vstart * sewb;
>       uint32_t i = startb;
>   
> +    if (startb >= maxsz) {
> +        env->vstart = 0;
> +        return;
> +    }
> +
>       if (HOST_BIG_ENDIAN && i % 8 != 0) {
>           uint32_t j = ROUND_UP(i, 8);
>           memcpy((uint8_t *)vd + H1(j - 1),

