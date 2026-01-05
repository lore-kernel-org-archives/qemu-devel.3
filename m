Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409BCC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcY8c-0007dE-8N; Sun, 04 Jan 2026 19:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY8a-0007d0-OH
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:07:56 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY8Z-0006OF-2Z
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:07:56 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso21734783b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571673; x=1768176473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FlHvyro0eUpD/kX/x0LHKTD3X0Lu4A8iL2EIvkdmNB8=;
 b=TmPj+C04uAjR2Yf4DDsEVi29w6GAQeVwtEReing7SOnNa6fry9Wyt/4r1m2Ks5HvXq
 orkYPH6T/a8ZHTsUv290MxQ0bKnyLdiJjKo0d42wdjgc0VEcm/N5JKLODJJ9wlvz9Xp3
 lsGBd5x2s47rLDqSNcA8Cg057ORQmaKDvHntm9VoL+kBf5Syulrv7OhoR1LXcjBgFEXY
 pjSTErqaV9xRXfJSVTzLfvd1igVA1jFA8YvNT3iX/1r7PhBj5FUFblKJlsPXD21W42qU
 1LWc5a4Z8ZZUMZ8DCRB+r4AYZeFDDY+a5tU+rDECLocJOOyQLg86vevnVGlCjVcYCigS
 U37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571673; x=1768176473;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FlHvyro0eUpD/kX/x0LHKTD3X0Lu4A8iL2EIvkdmNB8=;
 b=ayJBuK9hUYt2ci42znSS4FZvcTVo6b7hx34gGrMA3hTZcFcxRRv13WRXVBhduS/0XH
 3qmxYLWVgLbq/Y5epzpwQKhWwdlEOAxZbvK90etaeMC/mA4OzMY9LWkp8w5edA21ZMgz
 TXWkpS5DIlFJaz4B0PQfltxYh2sxL7uaTlwxdQfuXPQkO57YarmBEsn7OBCNBE6j0ssh
 nAruDoiH9hcYVBUprCS9T0tHFWha1/9YJ//YJT4qJgZ47RCWfrc9G6kHzu2tr2pr9YMJ
 Imnj/kk4yeSUS3BSPc/pW+EBQZhouajr/CUE8KMcYzTLwSxYSkY4pcMh+qEj3ncaAQ+c
 nZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXup20ygJHOJstZXzYFO4SxZHLqjIzH8bpsMRNHHB8z3M1t3f2HIa0hYRxGqKd6GQzsbjQWo1sY9Gx+@nongnu.org
X-Gm-Message-State: AOJu0Yyl5YLh3eqzlAZBikk09lmDx0piBBeUeV6BIRIXOkNsUF7ZwXrd
 Bjr2nYGv+TMsS3u27K74gUzflzjGe0yi4Gko8sFjGA4MpU3WhO9FguMKVcxhJnvMoXI=
X-Gm-Gg: AY/fxX52w1fph0PeoDwjeu/uTlAZ80kfb3ElBtbo98G4LpYZrFiPnlM1wAsQj0ggiv6
 z9NzL3NsS0R3uczk95EuA/GQ9FBUl6kFVN3vocPQoO3wS9lKooXR3Phuj6r+L1R5hdPQrKMf2h6
 AO95HU85p56szsWhUzjYHqqEvrHfKaJx6KnylBq+zk5TyilD2gzJ1E/m5RcBwRfCdYFCAd2KLS6
 4M/6xMHv6YotIEd/exT2jbCawzdOw7qx+buL7nrQs/s9rNkJTDs4pEIHs3L9Q67+2tiPs8ttg4O
 yGoYhiSZBAhg3N4RUVYtDmUWeKusVAoP6eOwMaq40GHhwppCYsMmWcZDea09DXBZEwoVCzle1ay
 AY78+HUsnfFqYxT9B0neQ2LjqYzrV9aZvgrA5XcSie5GDtWyMbdIinQx40Xu3jF7OCcql304KPn
 ig8f82aLetPsY7G3smBPAbY+pDwuQ0gA==
X-Google-Smtp-Source: AGHT+IGonorWvoHOZ+Y9Kqf7+m1XtL0JefWaLbbWmYmtYIGhbtLaRw+C3cUSKLwZhf06+K96fl/0QQ==
X-Received: by 2002:aa7:9311:0:b0:7a2:7a93:f8c9 with SMTP id
 d2e1a72fcca58-7ff64fc8fd5mr43855918b3a.27.1767571673191; 
 Sun, 04 Jan 2026 16:07:53 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a1a2asm45678691b3a.41.2026.01.04.16.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:07:51 -0800 (PST)
Message-ID: <3e172a30-31b2-4227-9eca-fee7f653061e@linaro.org>
Date: Mon, 5 Jan 2026 11:07:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/hppa: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20251224160942.89386-1-philmd@linaro.org>
 <20251224160942.89386-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160942.89386-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/25/25 03:09, Philippe Mathieu-Daudé wrote:
> translator_ldl() is defined in "exec/translator.h" as:
> 
>    198 static inline uint32_t
>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    200 {
>    201     return translator_ldl_end(env, db, pc, MO_TE);
>    202 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_BE
> since PA-RISC use big-endian order.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 853cba2ba4f..73c2cbdf5fc 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -4737,7 +4737,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>       {
>           /* Always fetch the insn, even if nullified, so that we check
>              the page permissions for execute.  */
> -        uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
> +        uint32_t insn = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
> +                                           MO_BE);
>   
>           /*
>            * Set up the IA queue for the next insn.

Use mo_endian(ctx), since you have it.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

