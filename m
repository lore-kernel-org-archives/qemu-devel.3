Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19F4CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98VA-0004tA-3O; Wed, 15 Oct 2025 16:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98V8-0004pT-OO
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:53:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98V6-0006NC-WD
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:53:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so378035e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561614; x=1761166414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ykJTzdmI6e5P1n6kKtC3rjlG0Lmai7TPSuyNzNJIxs0=;
 b=V4n5fzmyBIB75PwxQgVxAMInRLd/luR3L00S29s+JDuOciuTjWtTD4AoaiE/3F220e
 aHCYjTQSZAwl/y3IJApiJK4nPVt4/9fSyeSBHvWo3JnM2TzaANgo9bYRQuvQko8n4Nkz
 rhX0gKRJ5Lbe5RvWbHbdv0uZfLAea/IiwwgYf7kKZp/VvetX6hAPmsB2evaJHDaCjB/R
 ndH0BwiAxC416IgsDMYwspKkPnWxeccMWdIKv8p9JVMggdE/XtTQk5nT5FrSQC7+dltM
 /uH6ACgNcCLGDYbZSKG9MMhleyC6XfjujoN1A9HtAjZVC7v7rzgpLS075di2XUYho9ZG
 Rusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561614; x=1761166414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ykJTzdmI6e5P1n6kKtC3rjlG0Lmai7TPSuyNzNJIxs0=;
 b=TzgUNdmJd+/mFC9iG5bHMKMy4oGCYBf3mYRJnIlKRBmCscixzwOTPrS03GthdfmvOs
 40/G1eu+Y8nPWW5W2KXd/2DEJ6HJg/dUVfH0hhoH8cOc897dv/HpFtjNCt4yIG/+4LIk
 rMgxyt27JNmBC5vKxyzXEVGhtn4H/SVy4y2sBy6SYO01Eyl5iEoZ2PPxSapAIEmjaoHW
 Jp7BYXXFwEJ2h37MTnR/zw4kbSOlYHHJ/StIygFmVts+T7doYg5tclkFeU9ooyVkkbE2
 RZZQXAAe9kZu/aVY+DyEqz+E90q7aCOkiYeRF4qIMjEa2TATEfSOVIxNrTgOm8rlt8v4
 Epfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTZy7LTfGhp4IIBTCDFMuZvPWLw6SXpVcsy/E8qAgKUNQc/44Rfb72rrF1zEi8tMUA73KqsVs39dpN@nongnu.org
X-Gm-Message-State: AOJu0YyCw3r92dG1Qq7198FjskB94t8/79GouIg1EFx4mzZiHLFNLITH
 aGfQC56AdJYe5svOMzxQth3jN+YTW6F/pl76jBeeLUSq3DHhWLj6/JiW/iaY89qribdcPFO1vT4
 4fYz+2ESVxg==
X-Gm-Gg: ASbGncsNdMZQWi+G4YKGKTtNd22SkzE3QEgfBqAenbUfeMACzXYnZIxphvRxmfl7XOf
 lTmmInXJ2wKadttyBHAEFUl5KrxtmrK/7Qo7bfPqo2pPKGq7LcfB3FfqxCXRRSfbW+ia6Zf4I4S
 WTRLWykcfEUVlZYvINapbK0y9hlcCEa9e6Ol7FU/KOb08tITfQkP1Fl3GjR7LvsI3cRiEzruMiS
 VL4EAxXKc4yhA1DHtrAMDOrtUWKwqfUfL5EXpjeFna2yCeUGHWUGENuy90m1db9UUkPawPZvnm2
 WWjFxr/mmPhjyd1AvYmdZYw6SPXjK7tjRwSj9I5CDjgMkyZBYm7XTVrTN3+/Qgr8m78jUYOPGKw
 ye5X6R4KxlXth04VhP/MZtZiPOkI3nh/JhJadi5Nv6U5r4YDhjXQorrnie5XiFrnQqgWQs3rDFb
 RYBPGdnhnSGiJmYSqwDBRxqeWDcWwtrZuaCo8YHzucUqTpJjR2bU7ppbd/sA==
X-Google-Smtp-Source: AGHT+IH7xtRpvSjyx1qy8qOtobgzh5HM3N9xhUuQpwswTgeQwSHeFlfWFxNV6OcDMxac1slNmY57Tw==
X-Received: by 2002:a05:600c:37cd:b0:46e:59dd:1b55 with SMTP id
 5b1f17b1804b1-46fa9a8b3e3mr229958505e9.2.1760561614515; 
 Wed, 15 Oct 2025 13:53:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca2a48asm1859175e9.2.2025.10.15.13.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:53:34 -0700 (PDT)
Message-ID: <9c7cd94d-7daf-4c37-ad02-334c35586b68@linaro.org>
Date: Wed, 15 Oct 2025 22:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/34] target/riscv: Fix size of excp_uw2
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-20-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-20-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/10/25 22:34, Anton Johansson wrote:
> Fix to 64 bits to match size of instruction start words.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


