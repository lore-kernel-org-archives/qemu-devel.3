Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92AAE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 13:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQoDl-0003U4-La; Thu, 26 Dec 2024 08:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQoDj-0003TO-Qz
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 08:48:12 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQoDh-0001u5-Jn
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 08:48:11 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso74044925ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 05:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1735220888; x=1735825688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8/gE6EfjH7j1AnAq0kkdPfNUg1HjuKI6fkTRMWMUFZM=;
 b=dMxJ6BIbEutdAclcQB58kg8LnnKHSW4hqhemXoNj2uFbtoUMYaJ0UY4aq79pIoDBpE
 apkl0lIa7iMnO8ouxtm2i38V6oTD+ziit+T+msLFrHn7LThAqND7dricn7CbKOcTk9AR
 EjVYmylKhY42mfSq6rYB7sPn/FnPs34lsBpM50TxpG14vur/zghsub6FF/B3ACqcFT4F
 zopkEupkeeMiRMu5XuoEsEFs1FJukYKnKmaTEoZ8/I7WpgN0zDz5E3xSkLrPAKSv/F35
 w4kVr+TyKHBnV4GE6LPcNc5R5+PrK4YwbwOJWCAMghiru7psprGIWlGQnsPH3Y1Auyv6
 c1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735220888; x=1735825688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/gE6EfjH7j1AnAq0kkdPfNUg1HjuKI6fkTRMWMUFZM=;
 b=MtfhrOYTH9AFqMAwan40i1sBkSN6JO4EYJ1CZlzjZgFOBWeAzLqWi2/xIIhMCNu46d
 p6/QJNEbPn/KFapr6ow9N+U/oLEG6teQGKFTrmG7ibaxl4ptjpVHtdk2+QbwSuz6FbXl
 o98dc7O7vdfYI23ENnYC1cBFgG3+PaPR+zZ03AUPgEv+waHKYvYgtZkGDsoMQjmYMS1g
 CquoUFQNM2GnAPgXgRmKKKXkSjqYjFd4JPOMOoITp0OjPlkWjftjRyu3FWTzobZN8nI0
 a9RUuSHIyNQ1rxDI8mW20M4BlIOlyenVJJK6vBF+kjXjd24OZhqzZPWdhURVMdgbetDJ
 lRqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7hfbaTJLgzArLnrAMB9y8kIqEwfQt3+JG9rnjqR4GwS+LSppWNE9QSUe7CWm169HHhCKr1C8j31tx@nongnu.org
X-Gm-Message-State: AOJu0YzbD599sIb4oyUI546wNdoMIrBVZOJZEe9DcXQKx5gYGfEDX57l
 o/jQ6ATDX8K2vvize78j9Gd04S8++uNJ/cIkW06aoESV31wBTL6AuUN1ZJZLswY=
X-Gm-Gg: ASbGncty8YRq6GgDdHK1ydYBXMMINZ9ESl92Ppt+L0lriyuuwj6uyePeqVbfVBLex/j
 oUZe0c6nBTvIXSKTJZnIGcAq//ZFbLO3XOZvlqH+6GAgFQZi29T09ROcp+Smtv5sqC+diHkVtJx
 ekcTPTFjKKMziOHfTUBKrMK3kAHdNeoQTQb1+VSbgOnvXVedECTZ+g17gGNELbdl2qlDZWH8nnU
 /+DMCRX2PvsyjrT9eKiGeagRSl3kiMd0vT1XC+p1T6SG55b+slQYYs9Munrs9Zmm8mg8A==
X-Google-Smtp-Source: AGHT+IHhpcJwxsTIZHzLW+2e52fowq3sRU+OW7A9CbBdqh9KaadZO23dV+24WsVdpG6I9AQI5S4RyQ==
X-Received: by 2002:a17:903:244b:b0:216:34e5:6e49 with SMTP id
 d9443c01a7336-219e70dd211mr308558385ad.57.1735220888158; 
 Thu, 26 Dec 2024 05:48:08 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b2b3e80fsm10035182a12.31.2024.12.26.05.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 05:48:07 -0800 (PST)
Message-ID: <61e8f7d8-607a-4d63-b9dd-cfbfc840716e@ventanamicro.com>
Date: Thu, 26 Dec 2024 10:48:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: fix handling of nop for vstart >= vl
 in some vector instruction
To: Chao Liu <lc00631@tecorigin.com>, bmeng.cn@gmail.com,
 liwei1518@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, max.chou@sifive.com, alistair23@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com
References: <cover.1734504907.git.lc00631@tecorigin.com>
 <044d68f67066073484257f22b82fa946d025e27d.1734504907.git.lc00631@tecorigin.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <044d68f67066073484257f22b82fa946d025e27d.1734504907.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x641.google.com
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

On 12/18/24 4:15 AM, Chao Liu wrote:

We want a commit message here because the change is not trivial.

You gave an explanation in the v1 cover letter:

---
Recently, when I was writing a RISCV test, I found that when VL is set to 0, the
instruction should be nop, but when I tested it, I found that QEMU will treat
all elements as tail elements, and in the case of VTA=1, write all elements
to 1.

After troubleshooting, it was found that the vext_vx_rm_1 function was called in
the vext_vx_rm_2, and then the vext_set_elems_1s function was called to process
the tail element, but only VSTART >= vl was checked in the vext_vx_rm_1
function, which caused the tail element to still be processed even if it was
returned in advance.

So I've made the following change:

put VSTART_CHECK_EARLY_EXIT(env) at the beginning of the vext_vx_rm_2 function,
so that the VSTART register is checked correctly.
----

You can add this text as a commit msg for this patch, also mentioning that you're
changing vext_vv_rm_1 / vext_vv_rm_2 for the same reason.


> fix: https://lore.kernel.org/all/20240322085319.1758843-8-alistair.francis@wdc.com/

The tag format we use in QEMU refers to the commit in the tree, not the link for the
pull request email.

In this case the tag would be:

Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when vstart >= vl")

> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> ---


The code itself looks good to me. Thanks,

Daniel

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


