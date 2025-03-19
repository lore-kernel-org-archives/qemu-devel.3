Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED965C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutoz-0001BV-Bl; Wed, 19 Mar 2025 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutnj-0000fx-Qj
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:49:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutnd-0005Jx-SR
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:49:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso48401405e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742392173; x=1742996973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ZHqWVoZXtsPUKynhm/kD6lDlmtQ/4W/3xVBEqB7IqI=;
 b=cFvZDI++k9NGRRwswJmqCXsLJ7vW1iwNyLSlnjjU7+3qKF4w1RBnt2vms/LbHvF518
 yl/wJ0DjHk4sR5U3mYdSVl4k7qrIonVqbWnBiQ+rJJ7xTVxOJbb+WzgWAfYs5yLqAbPZ
 dEyqLELe0oNYhsFCfP36R1qRlrN2GSGR5bIZifBjUWUggvQotJfBiTmB1fp72RiywsT8
 4WNkofS5z+96/lZI2MwM/K/HNXuMSwvh31yDPaWQxfak72AnHTy2qo4UoIsOX3TFipdJ
 E2gaG/fFAQXYc2Oqr4ozBA1T7zI0C6kLB78mz+Yi8AIqkFUUrr/tyRZpSYtskU5/tegg
 WG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742392173; x=1742996973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZHqWVoZXtsPUKynhm/kD6lDlmtQ/4W/3xVBEqB7IqI=;
 b=kpMDDerk4v+1WXMgJJqKZWxV7Dt76faSXYkk/E4BtkjUKjo6Wdej8rPT+7QSDtunk3
 haimx2MkANcXlv6XMT+i+SQ7LoUvpQBMCLDEqGjm2kkOzvd/nK2/UqyCVFefWlxS8oEL
 QxWnrySNt5KiIemqQJwt67mtm2EjNn8pxLT8ThsSgEdK+G0lmekTqM22OzkEU2fYrprs
 5u4QTdnnWboMAgG5IACg8U5fCqRzZ4g5IlcMegcKCzNRc+/EL/WTvffCDFiPO409Nod2
 TSgQvQyldzt2c80KTT6O8aa3WlFnYHv0COndEEbDXpmGejxjiBSJfYlWepxMBP821KiJ
 dZbA==
X-Gm-Message-State: AOJu0YxlbCds7XWliuIX7arOQe4zi0C3CQwBMwyHCdJuhmR2PZCUalIe
 hKapi7HZG0WCTrhp85PEAjy1YsAg5tOMzsYsyM7dRyf++SYUN3XYCeWiyJER0UM=
X-Gm-Gg: ASbGncvzWaV663hBcFX55AvxguLPa8Yt7Z7TcZ+TZRntmNTWel5hg4vt+CDeIhTu77q
 bmtvGTmnM7fbPDwWYerAiOixEgs9CWruazod6ycIzPQMvKV/3NZyW0O86tlPGM2OGv5SMAMdCfF
 dLeZNBRQ711Jt0xEm7m3N6NEvQDOtaX0/v79AUj/O8apnKT/LDTqFTcaRLT3G2BQpI6I+THyCWi
 0kXEvd8jlLpMalg0S23LaJ8ESZxemNlhKi7gHOvhbM0VPTo3r+/3AWD/AADuYCySQgp3qpP4i5g
 fDel6Y13igpel9w1T4aJMklNi3/34WPGXX+v3lA2qKLonJG3WZ8lVqkZTf4Pk5yFmjZPchUYSWf
 qofOS39ITYBJ7
X-Google-Smtp-Source: AGHT+IGe3UMSdAD0WJPcxTo5iV0SE0JZI0vyruSbsjmR67BrA0nbgbNzrCf4RkDdqAPCyriqggUUlA==
X-Received: by 2002:a05:600c:1d04:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43d43875471mr16853505e9.26.1742392173395; 
 Wed, 19 Mar 2025 06:49:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43d803f6sm20041565e9.0.2025.03.19.06.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 06:49:32 -0700 (PDT)
Message-ID: <954c3f61-f338-45e3-9f23-b45cef5c81e2@linaro.org>
Date: Wed, 19 Mar 2025 14:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
To: Peter Maydell <peter.maydell@linaro.org>,
 Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
 <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/3/25 14:44, Peter Maydell wrote:
> On Wed, 19 Mar 2025 at 12:53, Tanish Desai <tanishdesai37@gmail.com> wrote:
>>
>> The issue started after commit https://github.com/qemu/qemu/commit/59f4d65584bd3372070e2484876436c8d02505e4
>>
>> Reproduction:
>>    1. In the build directory on MacOS (haven't tried on other OS), run:
>>         ../configure --enable-rust --target-list=aarch64-softmmu
>>    2. Then run either:
>>         ninja -C .
>>         OR
>>         make
>>    3. At the end, you will encounter the error:
>>         duplicate symbol '_pl011_create' in:
>>             /Users/tanishdesai37/Downloads/qemu-master/build/libcommon.a.p/hw_char_pl011.c.o
>>             librust_aarch64_softmmu.a[5](pl011.pl011.390d424367e209af-cgu.1.rcgu.o)
>>         ld: 1 duplicate symbols
>>
>> Root cause:
>>    Both CONFIG_PL011 and X_PL011_RUST are selected, causing C++ and Rust to produce the same object.
>>    This is due to the commit above where 'select PL011' forces a true condition instead of checking if HAVE_RUST is true.
>>    If HAVE_RUST is true, X_PL011_RUST should be selected instead of CONFIG_PL011.
>>
>> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
>> ---
>>   hw/vmapple/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
>> index 2382b297672..01bcbf40e00 100644
>> --- a/hw/vmapple/Kconfig
>> +++ b/hw/vmapple/Kconfig
>> @@ -22,7 +22,8 @@ config VMAPPLE
>>       select PLATFORM_BUS
>>       select PCI_EXPRESS
>>       select PCI_EXPRESS_GENERIC_BRIDGE
>> -    select PL011 # UART
>> +    select PL011 if !HAVE_RUST # UART
>> +    select X_PL011_RUST if HAVE_RUST # UART
>>       select PL031 # RTC
>>       select PL061 # GPIO
>>       select GPIO_PWR
> 
> Paolo: we seem to have quite a lot of this
> 
>      select PL011 if !HAVE_RUST # UART
>      select X_PL011_RUST if HAVE_RUST # UART
> 
> duplicated for every PL011-using machine. Can we factor this out
> in Kconfig? e.g.
> 
> config PL011
>      select X_PL011_RUST if HAVE_RUST
>      select PL011_C if !HAVE_RUST
> 
> (and update hw/char/meson.build to use CONFIG_PL011_C for pl011.c).
> Then all the machines can go back to plain "select PL011" and
> don't need to care whether it's the Rust or C version.
> 
> Or does that not work?

This should work.


