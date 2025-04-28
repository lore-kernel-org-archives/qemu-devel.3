Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8991C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 23:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9XVZ-0004Uh-5q; Mon, 28 Apr 2025 19:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9XVW-0004Tz-3y
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 19:03:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9XVM-0004ka-Q4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 19:03:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30820167b47so5344892a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745881392; x=1746486192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Afj+lu9lGhLDc3PkAGzfp/bNbDjeLSLISbLDH0TaFuY=;
 b=FteHy9Rf9ADZqzh619+m4KCbIjhHYDGpvxCFXmWR8T3AVChnHoGeQ80kkwZ8a8GluO
 cU62kRlXS1G8mxnKlkeWhOUZgbylwkSQYPLKOWjp9KYo01kh2uGuLD1Q2Alyb0W5Tci/
 0KbXU/2asbeSzvOGfNY8alyu6cPp8CgYIFPtzc3Kl8vrEyPT3Dxtz6gufuTCLt19zWge
 cqKjvpSu/DSp/G5nhUNx/vAqvIJvxXCsF/VJ95RhEOjU0bBG8A1SgyXd19zvkWvI796Z
 qM1xvDEzTrHWyeSG0RGk+PhzkN2HZl+4R/z2Gzh5kpBAuKCYxkjj6O8/wVi+ZpG3SuCp
 4S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745881392; x=1746486192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Afj+lu9lGhLDc3PkAGzfp/bNbDjeLSLISbLDH0TaFuY=;
 b=hGG4AlGwXc5FaHOpEeWJQ9El9VObBEbpxwFkQpKsX2NecPaqZ+mkOEXLiDPdGzvGJx
 hHbEO0KDx8+yHmIgfnotdYO8FTlGGhmIx6MhBF1uD0Xk9IgH7DaoUGELda4beeZRfKUA
 pvVO/mgry6h6bJEQ5aJsf96/x6kUETWGBzGgsXl9wHNA2or+mgRbquyh8vxcWW4yWrI+
 mRpXlH/TMrqWr5C0Y1CKFx+TcE/GCHOIxHh3kzQzenQ8ahB3H3DlPGv5E+aTnnjmfIDh
 IlbSb1Se14gZNe+lPTRxGgZ09tFQ3WixpsyKOC1GOMvSBADAvP3++Zgv4AAcjkM++LNV
 lckQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNhy8/uK7OK+ONcEwRggWjuWb5tnh5WdKAdN1J809y+CbBs9eG82kd3ZuFBiTH74aOKE1WzL6tXPI0@nongnu.org
X-Gm-Message-State: AOJu0YyDGJz1BTsdIzyrY4ckeHFTFyDSAD2GRGbycRjt+AkJUY4O5O8a
 +zV/27IeeA8kL2rpB6oqMtKVkWUu/jv3T1fzoJXhKt3mWQeMIgau0C4j3fr/Mbg=
X-Gm-Gg: ASbGncs10AgcdF1o2zHmFE/iyFq2fdTJxAJG17gs0K6n276FEkahDbD++RUTrS5Lg/H
 1AM1MI2L3HBuUAMonYBkM/D0OR0mB7lI9QKa597dKLf/eAfWaK8vSzWqNe1zunpXoRKwXoTt9ft
 6aXvLEUZhNCs83ykEIYSU3YrSjonJ+gEy+lAzpZhVBiImq0ggKPW0BkBYxbY/XqDbToEqt3xuet
 cceloBpPrP3b5cUPiQ2MYijpr3t0zzpIVte9+I5yOgd0z2HFMXmLNJOe6uHCsODPRsk3KhQ4d33
 gfPRNeShVDp/xO3DK0G8EHcKMkmH2dcGXgfbnQ6UuwZbqgVqPa7K2A==
X-Google-Smtp-Source: AGHT+IHgXKtFB8jEFHMdmsDEBLq2/CuZWER6ghjfwWctY77bwVoBcUVRLJpR1ABe9rPzhLlSV7uwQw==
X-Received: by 2002:a17:90b:5403:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-30a224af03cmr1418874a91.11.1745881392406; 
 Mon, 28 Apr 2025 16:03:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f784a56asm7865036a91.41.2025.04.28.16.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 16:03:12 -0700 (PDT)
Message-ID: <b13089fa-75bf-4eab-a0a4-1061c24943cd@linaro.org>
Date: Mon, 28 Apr 2025 16:03:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
Content-Language: en-US
To: Kyle Evans <kevans@FreeBSD.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
 <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/28/25 3:57 PM, Kyle Evans wrote:
>> Gentle ping on this series.
>> As we didn't have any feedback from BSD side, could we consider to
>> enable this upstream?
>>
> 
> Sorry- I have no strong opinion on plugins, but the diff looks
> incredibly reasonable and non-invasive.  I'm not really seeing any
> reason we'd object, but I don't personally feel qualified to review this
> (except as a basic human C linter- I can't imagine the added calls
> breaking anything we rely on).
> 

Thanks for your answer Kyle.
The current issue is that check-tcg is not tested on BSD hosts for now, 
so enabling plugins support is not tested.

That said, it works on the few cases I tried, and there is nothing 
specific to BSD in tcg or plugins code, so it would be reasonable to 
enable this I think.

> Thanks,
> 
> Kyle Evans


