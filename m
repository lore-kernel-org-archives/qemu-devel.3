Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEF9CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjZi-000259-2I; Wed, 03 Sep 2025 05:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utjZg-00024W-AO
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:14:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utjZd-0002HD-Vd
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:14:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61cd1046d42so7672963a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756890876; x=1757495676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAlPJUk8nhpCIUro1gfebOjKqDGc9j5uBxOcgD/tjq8=;
 b=VFWZ+A0BfP2C9CiXQanBOQ5uophLu/wGiviixClg2xhdXcwt2tTRAZrh4OhsnIPCcv
 EPUC63AbPaljWQtY4h+YTU+Pq90AjytCO+hHTa8gvFIc4xDdJpzocdBrq/+oPYMc4QsY
 gBkc6gIt77nFwvK1gSYr7ij0jzOb9SZC6gXxlwLjv+phK1URDsDKiBEAKtJ4C7tVBbfb
 L4kdXgbNDWCHWGbGOGrkU2BrzEi8GIOddi6yXPvuL+wlSuH9FS5AFeVdGmFUj9+b5HBY
 D8rWujJLBSdSSOAOH87n3VCJq29F+fSeVO8nH6aYcwNSnB6WW4POzkNyZtV4Va7FFpjF
 md4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756890876; x=1757495676;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QAlPJUk8nhpCIUro1gfebOjKqDGc9j5uBxOcgD/tjq8=;
 b=RsMQg/c2H2KntIaZqNKPTmTJ6+2HpC6IDvhnS0TmR79DC2PMBh0Q+Ypj6riLS+YU71
 r4nwcrs9a4OnRxG4peeyuH5HscZ9shwiOEJeXKdbE03LEluVyk0itpZ1HNqFZg5jivpR
 KMh2/geZI4kBM/iFgFMVGW1ob0+inLx8JENiT3/kWq54LXEj6o9ECFGYsIkx7KqmxPWi
 Xt1g0N57mj9CQBdxrwiKVOiWb3DDzgK7gxfy4QcoO/fTZgyUPLPpFTurpOjuxjfJLsfG
 xC0M6Y2o2xgmaSiMEJe22WyGN0o2rXrBzRp3j6cBtGNIHgS7cIJa2Ag36xYoyC8nI9Y5
 sSGA==
X-Gm-Message-State: AOJu0YyY2V9x70xLyoDp8ygQ4t1emDZql67VgedVTOFDLpJmkeWwYYna
 Hik4+K9OwbjmtNTv54z4HxTx+inuNL4QeKkcCSD6FCs4x4CijJMrFPCCvtBlUUCERjWlnxOXEty
 jYmRLOTU=
X-Gm-Gg: ASbGnctq63UT/9AhOnQbHLZqFYGnvCAeOadosrMMIredZWCuaDCcQJP+Zmy8jO2sPcn
 D+vgSGohtwR5Fmvx9wDONW6UApx5lPtaRw/3evjdb33RA3rB8jJqrDwRaWSPoeO3byFb3TKMzFC
 Kw9MEuHBEvMGiLAeuco0yVWe40byK+vcs89audOdlAw4DYdy/amh7E1IiWUk1HN2IjCBHr6ZiaF
 Jb3Puh97EoQ1BIckKW8B3aAUoXHmzezP5ZFAPu4nuTKQ1GUquvhUGUhtD1bDo6a+4Km2fopYDKU
 4wop1aOVDLjuzsyaWEfm82GfdXNkmdD48tVkmYRxURS4TPBOiH3nFtwwu+9WdE4PQkEdnUgmyXM
 sdF5KbKjI6hEgMikTUK4nklmBhVzOks+KBY20EufZ+sMqDmjw0EZSPm8WYF21Z0nNR0pEgCAipp
 SqA/DXGQ==
X-Google-Smtp-Source: AGHT+IEVRvo+8ho74VeCkNY3t8k2duKnTxASGme94NZLi6wgFd6bJXO5yvP9uWX2CG0tOlYlLf78BA==
X-Received: by 2002:a05:6402:13d5:b0:61c:768e:a86f with SMTP id
 4fb4d7f45d1cf-61d26892f1cmr12597571a12.11.1756890875695; 
 Wed, 03 Sep 2025 02:14:35 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4bbc6bsm11722524a12.29.2025.09.03.02.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 02:14:35 -0700 (PDT)
Message-ID: <06afcbdc-28e2-4d13-81d4-26fd257ed8a3@linaro.org>
Date: Wed, 3 Sep 2025 11:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] linux-user/riscv: Add vector state to signal context
To: qemu-devel@nongnu.org
References: <20250903042510.279954-1-npiggin@gmail.com>
 <20250903042510.279954-4-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903042510.279954-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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

On 9/3/25 06:25, Nicholas Piggin wrote:
> This enables vector state to be saved and restored across signals.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   linux-user/riscv/signal.c | 130 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 126 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 4ef55d0848..4acbabcbc9 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -41,7 +41,17 @@ struct target_fp_state {
>       uint32_t fcsr;
>   };
>   
> +struct target_v_ext_state {
> +    target_ulong vstart;
> +    target_ulong vl;
> +    target_ulong vtype;
> +    target_ulong vcsr;
> +    target_ulong vlenb;

All abi_ulong.


> +    target_ulong datap;

abi_ptr.

> +} __attribute__((aligned(16)));

Where does this come from?

As it happens, sizeof(struct target_v_ext_state) will be a multiple of 16 for riscv64. 
however...

> +
>   /* The Magic number for signal context frame header. */
> +#define RISCV_V_MAGIC   0x53465457
>   #define END_MAGIC       0x0
>   
>   /* The size of END signal context header. */
> @@ -106,6 +116,88 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
>       return sp;
>   }
>   
> +static unsigned int get_v_state_size(CPURISCVState *env)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    return sizeof(struct target_ctx_hdr) +
> +           sizeof(struct target_v_ext_state) +
> +           cpu->cfg.vlenb * 32;
> +}
> +
> +static struct target_ctx_hdr *save_v_state(CPURISCVState *env,
> +                                           struct target_ctx_hdr *hdr)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +    target_ulong vlenb = cpu->cfg.vlenb;
> +    uint32_t riscv_v_sc_size = get_v_state_size(env);
> +    struct target_v_ext_state *vs;
> +    uint64_t *vdatap;
> +    int i;
> +
> +    __put_user(RISCV_V_MAGIC, &hdr->magic);
> +    __put_user(riscv_v_sc_size, &hdr->size);
> +
> +    vs = (struct target_v_ext_state *)(hdr + 1);
> +    vdatap = (uint64_t *)(vs + 1);

... if you wanted to ensure 16-byte alignment of the data for riscv32, you'd do it here. 
I don't believe there's anything about RVV that would require 16-byte aligned data though.

> +
> +    __put_user(env->vstart, &vs->vstart);
> +    __put_user(env->vl, &vs->vl);
> +    __put_user(env->vtype, &vs->vtype);
> +    target_ulong vcsr = riscv_csr_read(env, CSR_VCSR);
> +    __put_user(vcsr, &vs->vcsr);
> +    __put_user(vlenb, &vs->vlenb);
> +    __put_user((target_ulong)vdatap, &vs->datap);

h2g(vdatap)

> +static void restore_v_state(CPURISCVState *env,
> +                            struct target_ctx_hdr *hdr)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +    target_ulong vlenb = cpu->cfg.vlenb;
> +    struct target_v_ext_state *vs;
> +    uint64_t *vdatap;
> +    int i;
> +
> +    uint32_t size;
> +    __get_user(size, &hdr->size);
> +    if (size != get_v_state_size(env)) {
> +        g_assert_not_reached();
> +        /* XXX: warn, bail */
> +    }

Do not assert.  The kernel simply fails the restore,

     if (!(has_vector() || has_xtheadvector()) ||
         !riscv_v_vstate_query(regs) ||
         size != riscv_v_sc_size)
         return -EINVAL;


leading to SIGSEGV.

> +
> +    vs = (struct target_v_ext_state *)(hdr + 1);
> +
> +    __get_user(env->vstart, &vs->vstart);
> +    __get_user(env->vl, &vs->vl);
> +    __get_user(env->vtype, &vs->vtype);

You're missing a step here.  The unsanitized values from vs should be processed as if 
"vsetvl x0, vtype, vl".  In particular, if either input is garbage, vill will be set.  You 
probably need a small wrapper around helper_vsetvl().

Similarly vstart should be written with riscv_csr_write because it gets masked.

> +    target_ulong vcsr;
> +    __get_user(vcsr, &vs->vcsr);

Do not intersperse declarations.  As much as I like them, qemu has denied them in 
docs/devel/style.rst.

> +    riscv_csr_write(env, CSR_VCSR, vcsr);
> +    __get_user(vlenb, &vs->vlenb);
> +    target_ulong __vdatap;

No __, ever.  It's a reserved namespace in user-land.

> +    __get_user(__vdatap, &vs->datap);
> +    vdatap = (uint64_t *)__vdatap;

Bad cast.  Since vdatap may be discontiguous, you need

   host_vdatap = lock_user(VERIFY_READ, guest_vdatap, env->vlenb * 32);
   if (!host_vdatap) {
     goto badaddr;
   }

> +
> +    for (i = 0; i < 32; i++) {
> +        int j;
> +        for (j = 0; j < vlenb; j += 8) {

Feel free to use

     for (int i = 0;
         for (int j = 0;

etc.

> @@ -207,9 +308,30 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
>   
>       uint32_t magic;
>       __get_user(magic, &hdr->magic);
> -    if (magic != END_MAGIC) {
> -        qemu_log_mask(LOG_UNIMP, "signal: unknown extended context header: "
> -                                 "0x%08x, ignoring", magic);
> +    while (magic != END_MAGIC) {
> +        if (magic == RISCV_V_MAGIC) {
> +            if (riscv_has_ext(env, RVV)) {
> +                restore_v_state(env, hdr);
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has V state "
> +                                               "but CPU does not.");
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "signal: unknown extended state in "
> +                                           "sigcontext magic=0x%08x", magic);
> +        }
> +
> +        if (hdr->size == 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state in sigcontext "
> +                                           "has size 0");
> +        }
> +        hdr = (void *)hdr + hdr->size;
> +        __get_user(magic, &hdr->magic);
> +    }
> +
> +    if (hdr->size != END_HDR_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state end header has "
> +                                       "size=%u (should be 0)", hdr->size);

All of these GUEST_ERROR should goto badaddr.  We haven't generally logged the reason for 
this, though I don't have any particular objection to doing so.


r~

