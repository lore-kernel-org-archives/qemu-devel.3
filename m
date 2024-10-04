Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D24CFA775
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 13:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swilN-0001ZH-72; Fri, 04 Oct 2024 09:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swilK-0001Yt-E4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 09:54:30 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swilI-0007B1-Q0
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 09:54:30 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-710fe5c3b44so1187797a34.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728050067; x=1728654867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu/DFFYEw7/VG36tvxDS6RaxAlNo/zUlq3tKZeME2ss=;
 b=BAqjgEexfBKt/1Wm2MQuQbsgLXztGgzpIFA73ocjIyCrKqNKrCzvO+RoZsUpxaq70F
 QP/iZd/PJ0KNTzx96el8Cd1FJBWreigzafmG5ZM14Orh/xIg+ZWn1FOC1T1zlFXDYeMA
 dl9k+TCLz9I7sb4Yoqw8hSBAg6YdsMycUHVHWyVjQZGcVxxgCyyHP8kxpx3C5psvEAZH
 QtDGNrXqvwvpw3NyOyBT9Lq7twpr1hVWh+fRF01/Wc+2S/Jdmp1vldVYhnjTmae5wMk0
 helLweCuaS52OLCPixUlXTguVuUmeE5oGFhZk95QxB4nK3SEfVQn2IGDY17NwiyZEcRc
 08bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728050067; x=1728654867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gu/DFFYEw7/VG36tvxDS6RaxAlNo/zUlq3tKZeME2ss=;
 b=eaXmJ8IjIfZCEa0qL2LBt/+t+7B64csQYREzhj2+0/R0l+pJ56YOy6M37aoMDhIhv2
 wWfanvLbLf9LU1/BE2bqwwwMGMC3cY6MXpb7aykL7AzwYxWcUM977y+NndBjnGBj6tpP
 Qj7sHjVvXxiZDY5oB5YA/z6Jv+9wbosyoTLIetxeLo+Cqp7iXP4XD3AGlpnMJkZ43McB
 2/ckYtQKD1ZBy79ferbTAtRgqe92Y29C2UleSgccEeePhd/hboYxx6pNY/pUBWv7JxWS
 E5yOutPfmBkX1uVGv0HMuBDO/aRJdaxuu7/unl1gqvzUQMtoZPA8T7ihPPQiWb2xOnlf
 CxUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJRyMUU8ltDkzwaPvyjqIsSyejJoGUQ3vk/y5t7F00p1Y53doVqiUhiH52UDgljRlNlEpWLXDFxDq2@nongnu.org
X-Gm-Message-State: AOJu0Yzud5hI4k3ognMk7gOHu45O/4p/RQ7QVrv9JbPmRTBu8fGORNvV
 BVjkEWw6uPBt3aE7VT7wjWcFiwaUkjr+X8gidd28JUddi9Aq5PLq3uNwPY7pJ6c=
X-Google-Smtp-Source: AGHT+IFBFYpcjBC+2p87l1OEEIv07xFRcypv5H+N9gpIPTiHHufv0fLCuRQ6AwvwmEMHle8WG31SkQ==
X-Received: by 2002:a05:6830:6e99:b0:715:3a11:eced with SMTP id
 46e09a7af769-7154e81a955mr2202391a34.5.1728050067329; 
 Fri, 04 Oct 2024 06:54:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71de8b6c1c5sm1238273b3a.166.2024.10.04.06.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 06:54:26 -0700 (PDT)
Message-ID: <927dc38c-e5bf-4522-a857-d580cab924bc@linaro.org>
Date: Fri, 4 Oct 2024 06:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] arm: drop last bits from deprecated boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241003140010.1653808-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 10/3/24 07:00, Peter Maydell wrote:
> This series is the remaining patches not yet applied from my "arm:
> Drop deprecated boards" series; this is essentially the device
> removals which didn't get review in that series and/or which had some
> discussion about whether we should remove them.
> 
> To summarise the remaining removals:
> 
>   * max1110 and max1111 are SSI devices so in theory could be
>     created by users on the command line. However I found no
>     evidence of doing this when I did a web search for
>     "device max1110", and the utility of doing so is unclear
>     to me since it's not possible for the command line device
>     to have its ADC inputs or its interrupt line output
>     wired up to anything.
>   * max7310 is an I2C GPIO controller, so it has the same
>     "in theory a user could create this on the command line
>     but in practice it's pretty useless because there's no
>     way to wire up the GPIO lines to anything" status.
>   * the microdrive device can only be used with our PCMCIA
>     bus emulation, and we no longer have any boards using
>     that, so I think these are uncontroversially deleteable.
>     Some boards we still have should in theory have a
>     PCMCIA controller (strongarm, kzm, sh7750), but we don't
>     model those controllers and none of those boards are
>     sufficiently interesting or active that it's likely
>     anybody will ever add one.
>   * The ECC code is entirely unused now; this is an
>     uncontroversial removal of dead code, and I only didn't
>     put it in my pullreq because it wasn't reviewed yet.
>   * Consensus on the v1 series was that we could get rid of
>     -portrait/-rotate even though in theory you could use
>     them on a non-pxa2xx machine type to achieve the odd
>     effect of rotating mouse input. I've added a section
>     to removed-features.rst about this and beefed up the
>     patch commit message.
> 
> Of these, I think we should definitely be dropping microdrive,
> pcmcia, ecc, and the portrait/rotate options, and I didn't hear any
> dissenting opinions on v1.
> 
> For max111x and max7310: these are fairly small (a couple of hundred
> lines each) and not too badly behind the curve for code quality/API
> usage (in particular they're both QOM devices), so I could fairly
> easily be persuaded that they should stay.  However I would like in
> that case to see:
> 
>   (a) what's the use case/user ? (e.g. examples of "I'm
>       actually using this on the command line, like this"
>       or "I'm using this in the machine model I plan to submit
>       in the next six months")
>   (b) some kind of testing of them (which we can write
>       based on the answer to a.)

I have no trouble deleting them now and resurrecting if and when they ever get used, 
especially since I think that has low odds.

> Peter Maydell (6):
>    hw/adc: Remove MAX111X device
>    hw/gpio: Remove MAX7310 device
>    hw/ide: Remove DSCM-1XXXX microdrive device model
>    hw: Remove PCMCIA subsystem
>    hw/block: Remove ecc
>    vl.c: Remove pxa2xx-specific -portrait and -rotate options

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

