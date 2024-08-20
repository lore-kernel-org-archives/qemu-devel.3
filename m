Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBD1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 23:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgXp4-0004jV-KZ; Tue, 20 Aug 2024 18:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXp3-0004ix-BB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:59:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXp0-0002St-KC
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:59:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-710e39961f4so4139311b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724194759; x=1724799559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IAt+tZ6hLhbQWE0u0Man+y1vmDyt7QjILbvStlIAgQo=;
 b=giW8P7a6b7XRFUPdz/ctsdgfajxtcDhcClIbMOVp24hSVzjyFskKk7xu2I4DGXmQYZ
 gaUH2D5gIbr2gw16Ef3nWsCxP2iE8OJJQ8zPfcDOpFlk1dQIfEzdSemlPM322OCs0WAf
 qLJmparjqo7o1ELnLyzlcUo58d7lBF1VhTkZ6r8qWzY3iJ8Wd4jDss9w8WO9zvDNXHcu
 cxL0OG2B0p9ZNRQ7ZPOLAbL73G8FKZ9p+1mw/LuXwIDFehjLCaQLzHRlJKIqbvudCjDw
 ayB0TMRC8nSM3cR2hLTDXxDPcNJ0NgNX/lSfrUkDHKgVfXNsIF4IVo7/YpTHZ2Yjzx7/
 w/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724194759; x=1724799559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAt+tZ6hLhbQWE0u0Man+y1vmDyt7QjILbvStlIAgQo=;
 b=hLMs/Gxvf27pwyik34K884ANjwgb6NdSaGLyZK7AG8uCD6KiW8Z/eOvuCDFaTEWC+V
 E+fLdsOK4HGktKESyhT9aUoUI3ZTEeIiERd5fSEQP7HBl8nH1W2nb2Pf5rPHSvTpd2kt
 5gghVAUnQ+KN9FEmdmRniY5ETcnLAK0gWshghP1m4iv3TXUdfgW9/3xNaplE4MXL0fxy
 zIJCaCThsQyuFzHGfG5y+GGv+Cb4ruOkW1TI6Tv3ovdRTK6eg1ab57e7wlORGGRwgJP9
 7hMvYJa3IgN4y+vhgVLbQdjnz3USLHj5nPIRML82bGQT7w5KZ9xo0yt3WBGkxloI86k9
 BBYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNDoKbHAYt0tuL3/iVZKlUz+ezQI2pUYeK7RtdRUXDievQvZBO/lw1TppsiWhzJ44UyNA5grwvNnM/@nongnu.org
X-Gm-Message-State: AOJu0YxeZuH03NCbx2YpWvx9K3iHC2WvCVDtCZQSKIVLf98JIfuzQnpG
 3+Z2Zbr6ndpFIDsfeK467A0LELFSNCPus4nvti1Vd9MdLG++RwGbleGi08xlSdU=
X-Google-Smtp-Source: AGHT+IG8p8uaPT7jxMOz7NnKylIPny0YtlHS743nS5iUnzG5HyAYVKeDItr78SFWqx/2k8glFxqA9w==
X-Received: by 2002:a05:6a20:ce47:b0:1c4:a49b:403 with SMTP id
 adf61e73a8af0-1cad81a4248mr1059646637.46.1724194758654; 
 Tue, 20 Aug 2024 15:59:18 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af3b0b2sm8709688b3a.185.2024.08.20.15.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 15:59:17 -0700 (PDT)
Message-ID: <245b32c8-ff8d-4c24-8ca1-fafa1e2fbb0b@linaro.org>
Date: Wed, 21 Aug 2024 08:59:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Fix enum value assertion
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
References: <oPimw5pKWjOolRVo_7-wrc75fq9RQccGIZFwWLTLupIprA9PaVm6IDzlE5M_MEZLCWtT31P55BAwc1VgCpEGyB21qyGLDRekNlK6ueu4MaA=@szczek.dev>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <oPimw5pKWjOolRVo_7-wrc75fq9RQccGIZFwWLTLupIprA9PaVm6IDzlE5M_MEZLCWtT31P55BAwc1VgCpEGyB21qyGLDRekNlK6ueu4MaA=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/21/24 08:52, Kamil Szczęk wrote:
> Coverity reported:
>   >>> CID 1559533:  Integer handling issues (CONSTANT_EXPRESSION_RESULT)
>   >>> "pcms->vmport >= 0" is always true regardless of the values of
>   >>> its operands. This occurs as the logical first operand of "&&".
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
> Reported-By: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7779c88a91..523dfe3f3f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1221,7 +1221,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>           isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
>       }
> 
> -    assert(pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX);
> +    assert(pcms->vmport < ON_OFF_AUTO__MAX);

Given the usage here

>       if (pcms->vmport == ON_OFF_AUTO_AUTO) {

and later, here

>     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>                     pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);

absolutely nothing goes off the rails no matter the value of vmport.

It is not used to index an array, which might be out of bounds.
It it not a security issue.
There's no need or benefit for the assert at all.


r~

