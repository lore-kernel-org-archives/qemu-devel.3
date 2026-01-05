Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A14C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcaQy-0008C2-O3; Sun, 04 Jan 2026 21:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaQx-0008BT-Ju
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:35:03 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaQv-0005zu-OP
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:35:03 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so11169272b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767580500; x=1768185300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c5HmxIXl+W0mpLvyQ0eMgjPgPkuTltFCztweNX+adRw=;
 b=ldU5jFB/Pb6qNtQzB96o21NaDPn+Hi3ni8ILlE2uNq6t84qE3/paljyanLb3AZr0+p
 mIqR60HmVOdDZo/XCsrOx5j3vOe7HdXhaYm2KJa50VewkqXTCJ9Q8n2Nr9GkYI5mxR46
 ei9XAIC4svb6UeSXuPkrWCwH0lXdJZnwF57pijF2Wrnl/K4t3s0CKM1fApw1DPgDpbGQ
 MmurpWCwRuaiU4YYrwS2du+qJ16deAZPlQblOayAdwrNyl/fx+k9ZhNVoTl5TJ1A8Fro
 E7lPtZftoXynEjv6YIFJ60x5GCIAz8dwK+r/QehVdgjZyL6i0DEDBU6Tuag9U2OeP7bg
 rJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767580500; x=1768185300;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c5HmxIXl+W0mpLvyQ0eMgjPgPkuTltFCztweNX+adRw=;
 b=asqLcQ3uvpK4Cv5OZXTpVFSBso3dFlCU9B0onn/mBM4XdnP8/NNoIEq7w1OagfRDrh
 XT/SWhExNmpRziZvNvbSk7ixJ6aazNfm/EvXM59VkK5o5kVQZET5g4V+5FRCfCYI8kGd
 URlfZsLwwI+UoXRMAb1kBpJT6hbY8oC+WLl8vWP8zGghGYMtg6LeNTmc5U62oYDp3hjF
 +UQgdymYlcLhoXpFAKRj5duHcWPcwIrP2pOBaq6/2uCD8t1DOygRm/lWs68n3SZtbIXh
 0m+7Louhsgl4Z0rEA+4zWviJ22AMAWw44QGxSZdQNnCJNKqL1MiR29nwo7cj8qMFLQKR
 3VNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ZngC6BysDr9jp+LLWMwwHrUUgRimyZA6FfJZagjkrKRIe3LVYC+J+Zq14kLX3ADOayJisvqxe93z@nongnu.org
X-Gm-Message-State: AOJu0YzsW6XCbkugbR2JpKKmtBuEyj4BOk+p8t7bkLaAZG8KkSuNTEZK
 7X+YBJ+foD+ynABxISgufdEGAnkNeWoId6wxigtDgpibY+T/sXh71VCl4d/QQy7OhfY=
X-Gm-Gg: AY/fxX7dKgjQ4OzkfIF1Cf/IaiB5K5YCytUFLlkPy/fafn+Qf4zwXokfzAisfEUGUmc
 3Z6mzThK6CJIzDMooqteYSp9J26TcL0kwt30MBfi/S30z3Gp0hSwsm26/2KMCTt9E09KghILm/7
 xclnZApLcyibWSTZmhrnfeeh6FfENbWKoNbrd0y/3Nrr76QUy1KhuGl4eGXpT89YwGanI/4ZAz1
 0G5ADqjBy58jq5fuJqapis8zxNkV8l/oSCo+uPP/sgeLmon5MR6vsvthT8H7tdtc8Sw52a4fdyK
 g1fstvRG0dXxfuWQBpZR7GIRY7y9JCYxykUczt9XFWLSInLKILrJ1OlPfb1dMa1Skl5ymtrZCc2
 VZSHE9BAipUECpI6WEIU/8sMkipRdiSQ3xh7NOPuH4G9HTW63IkC3buv8GMpMq+PYsN6nelN09o
 4cnjvo2FqTuKGuP/cswqHPP6ow/T+/SA==
X-Google-Smtp-Source: AGHT+IGD7M618T/pUZ2VBML9slauWvGWjnyCoIarFP1CNdAwPxyOf5EjGMp0+WcvEnbVpJUEV15bQQ==
X-Received: by 2002:a05:6a00:f9b:b0:7f6:3f21:7d22 with SMTP id
 d2e1a72fcca58-7ff65f768d7mr40582007b3a.45.1767580500088; 
 Sun, 04 Jan 2026 18:35:00 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7eb85f15sm46353736b3a.68.2026.01.04.18.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 18:34:59 -0800 (PST)
Message-ID: <b79b623f-4d4d-4c36-af63-3c6c1216118f@linaro.org>
Date: Mon, 5 Jan 2026 13:34:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/hppa: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller
 <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20251229225517.45078-1-philmd@linaro.org>
 <20251229225517.45078-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251229225517.45078-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/30/25 09:55, Philippe Mathieu-Daudé wrote:
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
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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

Using mo_endian(),
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

