Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBBDC54791
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 02:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjVau-0007tK-9J; Sun, 10 Mar 2024 22:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rjVat-0007t4-6w; Sun, 10 Mar 2024 22:40:51 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rjVao-0007Vp-Tr; Sun, 10 Mar 2024 22:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710124832; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=RFcKP8BDPqv+e1Ejlqlj6w67WOHbXMqNKJQR6W/Qv4g=;
 b=tpkA7lWdhXVitF4yyszbzHSsrt7Ww9RYRcZYHFoOsHwlfVVYYOA0v0ZCLLn84Q+Z6+9MdYlszkZZt+TSeZctjSnMun7FI8OC+sXrsmdkYfMWxz0daxuiYfy5X20R0WXZdcYMVTE/ksPIhdPieUyuf1nlpIMZAlKX/GuQ5ZYcORQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W29Xe1n_1710124828; 
Received: from 30.198.0.173(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W29Xe1n_1710124828) by smtp.aliyun-inc.com;
 Mon, 11 Mar 2024 10:40:29 +0800
Message-ID: <1590234b-0291-432a-a0fa-c5a6876097bc@linux.alibaba.com>
Date: Mon, 11 Mar 2024 10:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] target/riscv/vector_helper.c: update tail with
 vext_set_tail_elems_1s()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, richard.henderson@linaro.org,
 philmd@linaro.org
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-5-dbarboza@ventanamicro.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240309204347.174251-5-dbarboza@ventanamicro.com>
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


On 2024/3/10 4:43, Daniel Henrique Barboza wrote:
> Change all code that updates tail elems to use vext_set_tail_elems_1s()
> instead of vext_set_elems_1s().

Hi Daniel,

Notice vext_set_tail_elems_1s will use NF field, which is zero for most 
vector instructions. Thus it will do nothing.
I think you need encode the  right NF value(1) into desc for them if you 
want to do this replacement.

Thanks,
Zhiwei

>
> Setting 'env->vstart=0' needs to be the very last thing a helper does
> because env->vstart is being checked by vext_set_tail_elems_1s().
>
> A side effect of this change is that a lot of 'vta' local variables got
> unused. The reason is that 'vta' was being fetched to be used with
> vext_set_elems_1s() but vext_set_tail_elems_1s() doesn't use it - 'vta' is
> retrieve inside the helper using 'desc'.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 130 ++++++++++++++---------------------
>   1 file changed, 52 insertions(+), 78 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 86b990ce03..b174ddeae8 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -913,7 +913,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>       uint32_t esz = sizeof(ETYPE);                             \
>       uint32_t total_elems =                                    \
>           vext_get_total_elems(env, desc, esz);                 \
> -    uint32_t vta = vext_vta(desc);                            \
>       uint32_t i;                                               \
>                                                                 \
>       for (i = env->vstart; i < vl; i++) {                      \
> @@ -923,9 +922,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>                                                                 \
>           *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
>       }                                                         \
> -    env->vstart = 0;                                          \
>       /* set tail elements to 1s */                             \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);  \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);  \
> +    env->vstart = 0;                                          \
>   }
>   
>   GEN_VEXT_VADC_VVM(vadc_vvm_b, uint8_t,  H1, DO_VADC)
> @@ -945,7 +944,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
>       uint32_t vl = env->vl;                                               \
>       uint32_t esz = sizeof(ETYPE);                                        \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);         \
> -    uint32_t vta = vext_vta(desc);                                       \
>       uint32_t i;                                                          \
>                                                                            \
>       for (i = env->vstart; i < vl; i++) {                                 \
> @@ -954,9 +952,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
>                                                                            \
>           *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
>       }                                                                    \
> -    env->vstart = 0;                                                     \
>       /* set tail elements to 1s */                                        \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);             \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);             \
> +    env->vstart = 0;                                                     \
>   }
>   
>   GEN_VEXT_VADC_VXM(vadc_vxm_b, uint8_t,  H1, DO_VADC)
> @@ -1113,7 +1111,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(TS1);                                           \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       uint32_t i;                                                           \
>                                                                             \
> @@ -1127,9 +1124,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
>           *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7)
> @@ -1160,7 +1157,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
>       uint32_t esz = sizeof(TD);                              \
>       uint32_t total_elems =                                  \
>           vext_get_total_elems(env, desc, esz);               \
> -    uint32_t vta = vext_vta(desc);                          \
>       uint32_t vma = vext_vma(desc);                          \
>       uint32_t i;                                             \
>                                                               \
> @@ -1174,9 +1170,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                    \
>           *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);            \
>       }                                                       \
> -    env->vstart = 0;                                        \
>       /* set tail elements to 1s */                           \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);\
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);\
> +    env->vstart = 0;                                        \
>   }
>   
>   GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7)
> @@ -1835,16 +1831,15 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
>       uint32_t vl = env->vl;                                           \
>       uint32_t esz = sizeof(ETYPE);                                    \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
> -    uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
>       for (i = env->vstart; i < vl; i++) {                             \
>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
>           *((ETYPE *)vd + H(i)) = s1;                                  \
>       }                                                                \
> -    env->vstart = 0;                                                 \
>       /* set tail elements to 1s */                                    \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
> +    env->vstart = 0;                                                 \
>   }
>   
>   GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1)
> @@ -1859,15 +1854,14 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
>       uint32_t vl = env->vl;                                           \
>       uint32_t esz = sizeof(ETYPE);                                    \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
> -    uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
>       for (i = env->vstart; i < vl; i++) {                             \
>           *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
>       }                                                                \
> -    env->vstart = 0;                                                 \
>       /* set tail elements to 1s */                                    \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
> +    env->vstart = 0;                                                 \
>   }
>   
>   GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1)
> @@ -1882,16 +1876,15 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
>       uint32_t vl = env->vl;                                           \
>       uint32_t esz = sizeof(ETYPE);                                    \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
> -    uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
>       for (i = env->vstart; i < vl; i++) {                             \
>           ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
>           *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
>       }                                                                \
> -    env->vstart = 0;                                                 \
>       /* set tail elements to 1s */                                    \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
> +    env->vstart = 0;                                                 \
>   }
>   
>   GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1)
> @@ -1906,7 +1899,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
>       uint32_t vl = env->vl;                                           \
>       uint32_t esz = sizeof(ETYPE);                                    \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);     \
> -    uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
>       for (i = env->vstart; i < vl; i++) {                             \
> @@ -1915,9 +1907,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
>                      (ETYPE)(target_long)s1);                          \
>           *((ETYPE *)vd + H(i)) = d;                                   \
>       }                                                                \
> -    env->vstart = 0;                                                 \
>       /* set tail elements to 1s */                                    \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);         \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);         \
> +    env->vstart = 0;                                                 \
>   }
>   
>   GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1)
> @@ -1973,7 +1965,6 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
>       uint32_t vm = vext_vm(desc);
>       uint32_t vl = env->vl;
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);
> -    uint32_t vta = vext_vta(desc);
>       uint32_t vma = vext_vma(desc);
>   
>       switch (env->vxrm) {
> @@ -1995,7 +1986,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
>           break;
>       }
>       /* set tail elements to 1s */
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
>       env->vstart = 0;
>   }
>   
> @@ -2098,7 +2089,6 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
>       uint32_t vm = vext_vm(desc);
>       uint32_t vl = env->vl;
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);
> -    uint32_t vta = vext_vta(desc);
>       uint32_t vma = vext_vma(desc);
>   
>       switch (env->vxrm) {
> @@ -2120,7 +2110,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
>           break;
>       }
>       /* set tail elements to 1s */
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);
>       env->vstart = 0;
>   }
>   
> @@ -2872,7 +2862,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>       uint32_t vl = env->vl;                                \
>       uint32_t total_elems =                                \
>           vext_get_total_elems(env, desc, ESZ);             \
> -    uint32_t vta = vext_vta(desc);                        \
>       uint32_t vma = vext_vma(desc);                        \
>       uint32_t i;                                           \
>                                                             \
> @@ -2885,10 +2874,10 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>           }                                                 \
>           do_##NAME(vd, vs1, vs2, i, env);                  \
>       }                                                     \
> -    env->vstart = 0;                                      \
>       /* set tail elements to 1s */                         \
> -    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
> -                      total_elems * ESZ);                 \
> +    vext_set_tail_elems_1s(env, vd, desc, ESZ,            \
> +                           total_elems);                  \
> +    env->vstart = 0;                                      \
>   }
>   
>   RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
> @@ -2915,7 +2904,6 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
>       uint32_t vl = env->vl;                                \
>       uint32_t total_elems =                                \
>           vext_get_total_elems(env, desc, ESZ);             \
> -    uint32_t vta = vext_vta(desc);                        \
>       uint32_t vma = vext_vma(desc);                        \
>       uint32_t i;                                           \
>                                                             \
> @@ -2928,10 +2916,10 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
>           }                                                 \
>           do_##NAME(vd, s1, vs2, i, env);                   \
>       }                                                     \
> -    env->vstart = 0;                                      \
>       /* set tail elements to 1s */                         \
> -    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
> -                      total_elems * ESZ);                 \
> +    vext_set_tail_elems_1s(env, vd, desc, ESZ,            \
> +                           total_elems);                  \
> +    env->vstart = 0;                                      \
>   }
>   
>   RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
> @@ -3501,7 +3489,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>       uint32_t vl = env->vl;                             \
>       uint32_t total_elems =                             \
>           vext_get_total_elems(env, desc, ESZ);          \
> -    uint32_t vta = vext_vta(desc);                     \
>       uint32_t vma = vext_vma(desc);                     \
>       uint32_t i;                                        \
>                                                          \
> @@ -3517,9 +3504,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>           }                                              \
>           do_##NAME(vd, vs2, i, env);                    \
>       }                                                  \
> +    vext_set_tail_elems_1s(env, vd, desc, ESZ,         \
> +                           total_elems);               \
>       env->vstart = 0;                                   \
> -    vext_set_elems_1s(vd, vta, vl * ESZ,               \
> -                      total_elems * ESZ);              \
>   }
>   
>   RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
> @@ -4256,7 +4243,6 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
>       uint32_t esz = sizeof(ETYPE);                             \
>       uint32_t total_elems =                                    \
>           vext_get_total_elems(env, desc, esz);                 \
> -    uint32_t vta = vext_vta(desc);                            \
>       uint32_t i;                                               \
>                                                                 \
>       for (i = env->vstart; i < vl; i++) {                      \
> @@ -4264,9 +4250,9 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
>           *((ETYPE *)vd + H(i)) =                               \
>               (!vm && !vext_elem_mask(v0, i) ? s2 : s1);        \
>       }                                                         \
> -    env->vstart = 0;                                          \
>       /* set tail elements to 1s */                             \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);  \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);  \
> +    env->vstart = 0;                                          \
>   }
>   
>   GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2)
> @@ -4421,7 +4407,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>       uint32_t vl = env->vl;                                \
>       uint32_t esz = sizeof(TD);                            \
>       uint32_t vlenb = simd_maxsz(desc);                    \
> -    uint32_t vta = vext_vta(desc);                        \
>       uint32_t i;                                           \
>       TD s1 =  *((TD *)vs1 + HD(0));                        \
>                                                             \
> @@ -4433,9 +4418,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>           s1 = OP(s1, (TD)s2);                              \
>       }                                                     \
>       *((TD *)vd + HD(0)) = s1;                             \
> -    env->vstart = 0;                                      \
>       /* set tail elements to 1s */                         \
> -    vext_set_elems_1s(vd, vta, esz, vlenb);               \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, vlenb);    \
> +    env->vstart = 0;                                      \
>   }
>   
>   /* vd[0] = sum(vs1[0], vs2[*]) */
> @@ -4507,7 +4492,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
>       uint32_t vl = env->vl;                                 \
>       uint32_t esz = sizeof(TD);                             \
>       uint32_t vlenb = simd_maxsz(desc);                     \
> -    uint32_t vta = vext_vta(desc);                         \
>       uint32_t i;                                            \
>       TD s1 =  *((TD *)vs1 + HD(0));                         \
>                                                              \
> @@ -4519,9 +4503,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
>           s1 = OP(s1, (TD)s2, &env->fp_status);              \
>       }                                                      \
>       *((TD *)vd + HD(0)) = s1;                              \
> -    env->vstart = 0;                                       \
>       /* set tail elements to 1s */                          \
> -    vext_set_elems_1s(vd, vta, esz, vlenb);                \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, vlenb);     \
> +    env->vstart = 0;                                       \
>   }
>   
>   /* Unordered sum */
> @@ -4738,7 +4722,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(ETYPE);                                         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       uint32_t sum = 0;                                                     \
>       int i;                                                                \
> @@ -4754,9 +4737,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
>               sum++;                                                        \
>           }                                                                 \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   GEN_VEXT_VIOTA_M(viota_m_b, uint8_t,  H1)
> @@ -4772,7 +4755,6 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(ETYPE);                                         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       int i;                                                                \
>                                                                             \
> @@ -4784,9 +4766,9 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
>           }                                                                 \
>           *((ETYPE *)vd + H(i)) = i;                                        \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   GEN_VEXT_VID_V(vid_v_b, uint8_t,  H1)
> @@ -4807,7 +4789,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(ETYPE);                                         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       target_ulong offset = s1, i_min, i;                                   \
>                                                                             \
> @@ -4820,9 +4801,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>           }                                                                 \
>           *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
> @@ -4840,7 +4821,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(ETYPE);                                         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       target_ulong i_max, i_min, i;                                         \
>                                                                             \
> @@ -4861,9 +4841,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>           }                                                                 \
>       }                                                                     \
>                                                                             \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
> @@ -4882,7 +4862,6 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>       uint32_t vl = env->vl;                                                  \
>       uint32_t esz = sizeof(ETYPE);                                           \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);            \
> -    uint32_t vta = vext_vta(desc);                                          \
>       uint32_t vma = vext_vma(desc);                                          \
>       uint32_t i;                                                             \
>                                                                               \
> @@ -4898,9 +4877,9 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>               *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));             \
>           }                                                                   \
>       }                                                                       \
> -    env->vstart = 0;                                                        \
>       /* set tail elements to 1s */                                           \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);                \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);                \
> +    env->vstart = 0;                                                        \
>   }
>   
>   GEN_VEXT_VSLIE1UP(8,  H1)
> @@ -4931,7 +4910,6 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>       uint32_t vl = env->vl;                                                    \
>       uint32_t esz = sizeof(ETYPE);                                             \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);              \
> -    uint32_t vta = vext_vta(desc);                                            \
>       uint32_t vma = vext_vma(desc);                                            \
>       uint32_t i;                                                               \
>                                                                                 \
> @@ -4947,9 +4925,9 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>               *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));               \
>           }                                                                     \
>       }                                                                         \
> -    env->vstart = 0;                                                          \
>       /* set tail elements to 1s */                                             \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);                  \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);                  \
> +    env->vstart = 0;                                                          \
>   }
>   
>   GEN_VEXT_VSLIDE1DOWN(8,  H1)
> @@ -5005,7 +4983,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(TS2);                                           \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       uint64_t index;                                                       \
>       uint32_t i;                                                           \
> @@ -5023,9 +5000,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>               *((TS2 *)vd + HS2(i)) = *((TS2 *)vs2 + HS2(index));           \
>           }                                                                 \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
> @@ -5048,7 +5025,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(ETYPE);                                         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t vma = vext_vma(desc);                                        \
>       uint64_t index = s1;                                                  \
>       uint32_t i;                                                           \
> @@ -5065,9 +5041,9 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>               *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
>           }                                                                 \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   /* vd[i] = (x[rs1] >= VLMAX) ? 0 : vs2[rs1] */
> @@ -5084,7 +5060,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>       uint32_t vl = env->vl;                                                \
>       uint32_t esz = sizeof(ETYPE);                                         \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz);          \
> -    uint32_t vta = vext_vta(desc);                                        \
>       uint32_t num = 0, i;                                                  \
>                                                                             \
>       for (i = env->vstart; i < vl; i++) {                                  \
> @@ -5094,9 +5069,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>           *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
>           num++;                                                            \
>       }                                                                     \
> -    env->vstart = 0;                                                      \
>       /* set tail elements to 1s */                                         \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);              \
> +    env->vstart = 0;                                                      \
>   }
>   
>   /* Compress into vd elements of vs2 where vs1 is enabled */
> @@ -5130,7 +5105,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
>       uint32_t vm = vext_vm(desc);                                 \
>       uint32_t esz = sizeof(ETYPE);                                \
>       uint32_t total_elems = vext_get_total_elems(env, desc, esz); \
> -    uint32_t vta = vext_vta(desc);                               \
>       uint32_t vma = vext_vma(desc);                               \
>       uint32_t i;                                                  \
>                                                                    \
> @@ -5142,9 +5116,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
>           }                                                        \
>           *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));       \
>       }                                                            \
> -    env->vstart = 0;                                             \
>       /* set tail elements to 1s */                                \
> -    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);     \
> +    vext_set_tail_elems_1s(env, vd, desc, esz, total_elems);     \
> +    env->vstart = 0;                                             \
>   }
>   
>   GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1)

