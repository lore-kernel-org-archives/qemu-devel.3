Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DA4D6ACFA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGM1v-0005Ie-IZ; Wed, 27 Nov 2024 12:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGM1t-0005IA-Nf
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:40:45 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGM1s-0006OX-6F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:40:45 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ffdbc0c103so9901631fa.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732729241; x=1733334041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dE3z+qlntb/vTs4uv9/GBWmO6wDvA/yViyaIVnowAMQ=;
 b=dYSUDVBJ1zjkURcmgtBBc9MJy0G22Lp+P7R2V7HUB5EVKFRtOhfzs2mAWeqrmhmNbZ
 vXSNG/pEy3ENdce06aiYuB6j25d17jKcxCVjl2Jr1eTZxdaeDG39Qn+bXFgzs1S7xjFY
 O0W+puK2JqrX+cbOnkEt1pgA0AxTni2mKTSeLNbKtCfNjvrufxgJxeRzUi88MKr8MeY7
 MYu6U0sDt3OhZsIl2ny137n1xh1Nh5qRhoeARZNY+WbvZLkOl8AS+hxJ4HfdBbN+GIz9
 DDcvKwkc6ix+qBFu7B32mrLFg1mbvRzEY78JQhVXalqzwRygVXrU4/T6vaBdeVV8Ij3d
 VGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732729241; x=1733334041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dE3z+qlntb/vTs4uv9/GBWmO6wDvA/yViyaIVnowAMQ=;
 b=EH2RBb0Ta7+2FIg83HUcwpnsLMCHgGhVtMv88Ufb8WmvxQtJiAd1syDZe9IWA+lbky
 xvH1iYjnb4LNfirmzCtgId+Dl1RBFYuImqF8MTBhcObapBy37V5ippe+3h6JCmr9uH7u
 6G3zwc+Z0XQOc9HvIyKrQWKOIK+gYKSb+yS2Hsa/udeIvNKIpHCMwRtdfwnq04Ct1I8y
 70QxdgTw2qaL0SDjPT8XPMdOs1LyYvJujFYdwEXMBZoO1yCQc1D9Cf3g5lz50/B2+BRL
 bx5iAwHT/PlrCS1aseRWkNDzmeLeqkHrhsni48Fm8FdS1M/UNUQ35zJU+56ivDVJQEjC
 /Wqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwzXLNE/FHh/12RKOQnNDF7LGrirj8UJ9RvtCJ812Y47ogn7Xbd4u/q1LIP4yKo3/o0MdH0mWWYGcg@nongnu.org
X-Gm-Message-State: AOJu0YzG2ydSMXnpVUsNR4YdvWAHPVUI8h2G5T2JU1BAbKb2mYHXoca3
 /hl8Zzhszlu1QFg9E8CrbR0XUTsaopNANQdfoYZRfmJmfu81iQ/tSAUO6m3pugwVqAJJeunhcvh
 I+rg=
X-Gm-Gg: ASbGncvijt3SBQ6BZxq+n6+9LZTMFUouufpp2BctGixwmOPcZ0B4K8AW0USFbnaQ7Lp
 b3AWOKRTKBaqnhPd9jPjlxy97NWxTzqFhTx4/Tu5yDjfSNvuPNAcgz6/2xF++qt4gv0lQpHhUaR
 5+/X7byWN3H5m3SbjLi6mXSpJX19O02Ny9mfKVgb4cDSEVwBhrfIb7MnOjGJw7KRghwMh3DiU66
 rp1cMi1c05ND4Y9EXFQi9HUJbUR+hzR0hfN1BdoM/7TjsdafEEk/UU7bCEN6ITpiYJZ
X-Google-Smtp-Source: AGHT+IEPhxRCyTCvneyuBe+Q/f3Igj1KTVRBBoG0v0ojtvJdgC+S/Jw6P4yrTsS6OID2NgLmr+Nmrw==
X-Received: by 2002:a2e:ab0a:0:b0:2fb:5c84:929b with SMTP id
 38308e7fff4ca-2ffd60d2b4dmr34381611fa.36.1732729241504; 
 Wed, 27 Nov 2024 09:40:41 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.66])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffc092ed3dsm11004601fa.41.2024.11.27.09.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:40:40 -0800 (PST)
Message-ID: <f434cb54-b4b2-4b29-88a3-cd5ed6bf274a@linaro.org>
Date: Wed, 27 Nov 2024 11:40:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 2/6] accel/tcg: Declare local tcg_ops variable in
 tcg_exec_realizefn()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127121658.88966-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22b.google.com
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

On 11/27/24 06:16, Philippe Mathieu-Daudé wrote:
>   bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>   {
> -    static bool tcg_target_initialized;

Error removing this variable before patch 6.

r~

> +    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>   
>       if (!tcg_target_initialized) {
>           /* Check mandatory TCGCPUOps handlers */
>   #ifndef CONFIG_USER_ONLY
> -        assert(cpu->cc->tcg_ops->cpu_exec_halt);
> -        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
> +        assert(tcg_ops->cpu_exec_halt);
> +        assert(tcg_ops->cpu_exec_interrupt);
>   #endif /* !CONFIG_USER_ONLY */
> -        cpu->cc->tcg_ops->initialize();
> +        tcg_ops->initialize();
>           tcg_target_initialized = true;


