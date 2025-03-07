Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B1C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWaA-0005Fe-1B; Fri, 07 Mar 2025 07:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWZu-0005CF-2n
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:13:22 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWZq-00067m-UV
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:13:20 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso3792636a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741349597; x=1741954397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9ImYCtVdr1Ch20c7B9nCWAJDI5ZjZ4w4LmYM3Sl+n4=;
 b=RL6Zv4+ZoxAHBFf6LpGjAihxod6G2RXZIEOCGbhABS6m9bRC3Bh5yx9nODFSq132gd
 ibmnb4WXTioRbIxCjNcHvMcLXYbeX63k9JsqfvFPAtWlvwdwCgRrpmC4xFVHwt1e82v/
 rbjpavqT4jYeWqr9uKcDvX4yKMw8eNnSLJ2GsAZVeZrGxLmGITYl9iaJXu3f6LqBm9I7
 +jxTDlfAT3JdD+2ZLThvb3Thh3HdMMvsPh+uF3uOZsNjWuwB8k3qH/d9CFHp1fqfk2dH
 ehGP+5uCjUa8BxntFPArYaDZvqPr2N6ZEHqnpJoy8fkrr4N/V4F7jFcOEkuvaeO3i6U8
 U1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741349597; x=1741954397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9ImYCtVdr1Ch20c7B9nCWAJDI5ZjZ4w4LmYM3Sl+n4=;
 b=vS8JEW3KqtE2D6L3eKzrEzlyoy4nX/IQqn6QripWZna6rjFmnxO6J7kej1Gh9ZybH3
 CwhqZk+3sUZLRtH0ShllOJoL1KkJ7vmtG0Y7pS4amgRPnW3O2APUaZrik2Q7QZk9mzEx
 Ov3IBy0vrR8c9wb4t4BhpQ4zi68tb9eAgwFoHXXK6uJOM+Dh4mRR/udHXJ4QDc7+ASwy
 Uz235F0DVncfXQVsfmFlKO3aaRgcCD4p31lxnDz4Rq+b21LR6nogUpphBo3bWBOfM6Tm
 YQ6V22x09YmEui6yoOO45gV1ZFryxUHurwwksy+dMbO5Osx0Sh/WOXvwE+ilC7yBBWJk
 /D0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJRHvsK4bbl88KDz2bZBiHMLjqlJhki4e35e/ZneSibEpqDqCTKsvBwY+/stgWkDywNCYCksRHHSnm@nongnu.org
X-Gm-Message-State: AOJu0YwndY6N12XN37pwNHLr/Q2Pr7eQSO85IKsOv1/7ZK8zvF1QU+Nd
 j50CoeyV4ADxziw9qU+cL9fLHIIfLAyQ53YC+oyr61/jxkqyFYv9kQ+9yOJkhAU=
X-Gm-Gg: ASbGnctYSStEk9IXkkihgsgRfpz66iCgKiSn5F+jd7ulCVp3Flesvlb7eEDR+H6XYMm
 DHv0Ew62R14LdDLV1J7Kz/VVSPfwD8aPwFf/F319hlhAKMikEN+cxZpzx2Ilm7S+Gzjro4Ks5Be
 1CGttStnxIZGK0lJ36U1zshpx/wHaRElGy7b+PWto2XD8nF09FS1fF1PvB04XQ2W11hQH851WS9
 Cgm4zy2kPdVB7i9uwul1U28DR+bJO1Q1ZqNdFtwNkO1o5rRjuwMCHJk29Oq0OWuKty6dYge0HrC
 48FYyEXI/GjPZd3kCquj9j38LcB00lB5GPxK5x6Yf92XblQtwAP1gIYZMYA=
X-Google-Smtp-Source: AGHT+IHhKEzmGN+3eZOz9OhWdgPIs+j1OmNHeM+BWpTdNQoVp5AaDCzzhA2M3GOc1sgFteWcbS+XxA==
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2ff7cef76acmr4976975a91.28.1741349597396; 
 Fri, 07 Mar 2025 04:13:17 -0800 (PST)
Received: from [192.168.68.110] ([177.170.118.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4d457cd0sm4800529a91.0.2025.03.07.04.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:13:16 -0800 (PST)
Message-ID: <f826318c-c65f-436f-b825-a5d952753258@ventanamicro.com>
Date: Fri, 7 Mar 2025 09:13:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/riscv: fix handling of nop for vstart >= vl
 in some vector instruction
To: Chao Liu <lc00631@tecorigin.com>, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com
References: <cover.1736130472.git.lc00631@tecorigin.com>
 <a7fbcda155d62a613cc40219fb1aa8d5bfe65417.1736130472.git.lc00631@tecorigin.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a7fbcda155d62a613cc40219fb1aa8d5bfe65417.1736130472.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/5/25 11:43 PM, Chao Liu wrote:
> Recently, when I was writing a RISCV test, I found that when VL is set to 0, the
> instruction should be nop, but when I tested it, I found that QEMU will treat
> all elements as tail elements, and in the case of VTA=1, write all elements
> to 1.
> 
> After troubleshooting, it was found that the vext_vx_rm_1 function was called in
> the vext_vx_rm_2, and then the vext_set_elems_1s function was called to process
> the tail element, but only VSTART >= vl was checked in the vext_vx_rm_1
> function, which caused the tail element to still be processed even if it was
> returned in advance.
> 
> So I've made the following change:
> 
> Put VSTART_CHECK_EARLY_EXIT(env) at the beginning of the vext_vx_rm_2 function,
> so that the VSTART register is checked correctly.
> 
> Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when
> vstart >= vl")
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 4f14395808..5f1fc24d99 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2151,8 +2151,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
>                uint32_t vl, uint32_t vm, int vxrm,
>                opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
>   {
> -    VSTART_CHECK_EARLY_EXIT(env, vl);
> -
>       for (uint32_t i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -2176,6 +2174,8 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
>       uint32_t vta = vext_vta(desc);
>       uint32_t vma = vext_vma(desc);
>   
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
>       switch (env->vxrm) {
>       case 0: /* rnu */
>           vext_vv_rm_1(vd, v0, vs1, vs2,
> @@ -2278,8 +2278,6 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
>                uint32_t vl, uint32_t vm, int vxrm,
>                opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
>   {
> -    VSTART_CHECK_EARLY_EXIT(env, vl);
> -
>       for (uint32_t i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -2303,6 +2301,8 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
>       uint32_t vta = vext_vta(desc);
>       uint32_t vma = vext_vma(desc);
>   
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
>       switch (env->vxrm) {
>       case 0: /* rnu */
>           vext_vx_rm_1(vd, v0, s1, vs2,
> @@ -4638,6 +4638,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>       uint32_t i;                                           \
>       TD s1 =  *((TD *)vs1 + HD(0));                        \
>                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
> +                                                          \
>       for (i = env->vstart; i < vl; i++) {                  \
>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
>           if (!vm && !vext_elem_mask(v0, i)) {              \
> @@ -4724,6 +4726,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
>       uint32_t i;                                            \
>       TD s1 =  *((TD *)vs1 + HD(0));                         \
>                                                              \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                      \
> +                                                           \
>       for (i = env->vstart; i < vl; i++) {                   \
>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
>           if (!vm && !vext_elem_mask(v0, i)) {               \
> @@ -4886,6 +4890,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
>       int i;
>       bool first_mask_bit = false;
>   
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -4958,6 +4964,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
>       uint32_t sum = 0;                                                     \
>       int i;                                                                \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \
> @@ -5316,6 +5324,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>       uint32_t vta = vext_vta(desc);                                        \
>       uint32_t num = 0, i;                                                  \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vext_elem_mask(vs1, i)) {                                    \
>               continue;                                                     \


