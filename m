Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65856CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEDui-00059s-GL; Wed, 29 Oct 2025 17:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDub-00058j-2g
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:40:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDuM-0005kN-E6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:40:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso4178915e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774032; x=1762378832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ncKmPlVytzymp+1TPUudiFEf8xHLOE7bUhfZrx7l5p4=;
 b=c6HBNVgAqyTvOr0AYKIbbySaRFIJg24QCLNqVzy92EedZh+Ge8LgLxKVC1M6Pt8x7H
 MJJlN0PYs4r8gACkaZSlRX4nRiR29ois5yBzz616Bhn/uGTRXzXv8210RJ0X0xxYkYkL
 YbEcNPJBYV8zFBZhC7okXg8Gw84qLUqs+rmBFabRBM9i+Y3XjynnueR41hypJYOnKqN8
 9OFKQEgfNJqtXaTAX+p6aArEkCS5+i2cNoL0RUuNiuAxXdxiAH4Ay9pDrazVnQ09gHYQ
 qhV2BZZu3ohWoDOJXxJP90ZCSK0AgJDdcMcSRzzqUiYOD62V3X4lBR4e+yTFdAco1ayb
 e9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774032; x=1762378832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ncKmPlVytzymp+1TPUudiFEf8xHLOE7bUhfZrx7l5p4=;
 b=po31GEknaRibeU4lctwO5VoQt+GFIhEtCiFx28pHqiyF4EOCYpZEuwZZ/h6kE9hNDX
 Nq1vXPxplKMC8IhY5kG5/KxUCs3pu3zfbIz6Z9bhJ24x8dCEj2oJFfx/zUnDWpNxxtg2
 IX7Mt6684csqUFyG6lXm+Lg9jYWRofNRPh+ZwFjQrz/q9+dUxInVVEeXuWCWSWTbCsUS
 YJNyEg7R6Ap3+2MaN2mPWl77FFEB7m8fHn/8gvCrxjHVXrSTs3Wy7A2v7/jg2/OVUywD
 K0Q9mmkfyaXWFID9aRCh4NR7wo2KfSYunglA+KNplduHrBvQekHWBpZZKl07pYh/h05F
 E39Q==
X-Gm-Message-State: AOJu0YyS0v4LNaHZtew2ewnKAYL7nvZ+GRewyS9ttv2t99pauq6bWzM3
 BL6jbYSW+xjVgwhVo83d9BzkfG2PXHg/9w67+2nshOQhVs5AKtEmGeOr5yEygQKLThg=
X-Gm-Gg: ASbGncv+Y35oxJfw6tghixGOndzLVyXv68M9DMsLJuOzaulJt+0BwpDPVGSjUxlzcXn
 q3E+b7Rha225lGHs1OkARhlxcOYe9cWMkAi6CwJ5xGsYqpxyEau4c1elU3tXX0076FdgJ87OJc3
 eAUUM119FD9uhzokIVvvIvDg09UL8jGOUkprUaRdzxaWmaX8MpI8jEz+iy4q7N5vnrAE0KccO0L
 skaWAbGUPYklzuYasa2GE3RMO1Lf2zrqFAbv3IistF2IotycHCZYR4URLlZFm7eKc54QfXTOQf9
 v7f4TCkn9ugkd1vxYWA1vCIZ2JoHY0Ko6DrAmdisugkp8gtO9zjZRbduW+WD7FaWQHP7fmAcJm4
 ROTrqdg3qKuHphFtOg/MmB/ye3/TJ5rpgig87kxwH6rupZlhcT0tftp8bPBp3g1axTqxy27PH5o
 bJoOfrI8Ymm3ZtPImB7uBacZtekyBuyVsXUl2iFGErr3Y=
X-Google-Smtp-Source: AGHT+IFXUJifVRQ7Vbl9dG5zJpYgqfo0P08xQwkOPkawg2q8imAVIcD2QygFY2RYHcgIQpUn834ULQ==
X-Received: by 2002:a05:600c:64cf:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-4771e1db42fmr39515955e9.24.1761774032250; 
 Wed, 29 Oct 2025 14:40:32 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b2dsm28106136f8f.2.2025.10.29.14.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:40:31 -0700 (PDT)
Message-ID: <9931a47f-6d04-4763-9d48-7377b1a29531@linaro.org>
Date: Wed, 29 Oct 2025 22:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/19] single-binary: Make hw/arm/ common
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20251021205741.57109-1-philmd@linaro.org>
 <CAFEAcA8A5xa0nJUczM_BDCvVu+sP-tdbt_CxDGos6hKW27qEZA@mail.gmail.com>
 <a244a654-7bd8-46cf-bc55-87ab5287bda5@linaro.org>
 <CAFEAcA9y29qsC4UQLjO+sJ5TLiA7FqtBTKwUAaQhq8Bz+WX+2g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9y29qsC4UQLjO+sJ5TLiA7FqtBTKwUAaQhq8Bz+WX+2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 23/10/25 14:16, Peter Maydell wrote:
> On Wed, 22 Oct 2025 at 15:03, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 22/10/25 13:50, Peter Maydell wrote:
>>> On Tue, 21 Oct 2025 at 21:57, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> Series fully reviewed.
>>>>
>>>> Since v6:
>>>> - Addressed Jan comment
>>>> - Removed aspeed/raspi meson patches
>>>
>>> I'm assuming you'll take this via your own tree like the
>>> other single-binary stuff -- let me know if you want me
>>> to take it into target-arm instead.
>>
>> Since most files are hw/arm/ related, I tried to get it fully reviewed
>> before the last Tuesday before soft freeze so you could queue it;
>> however it is based on my hw-misc-20251021 pull request, which isn't
>> yet merged. I'm happy to merge myself, but would you mind to provide
>> your Acked-by tag?
> 
> Sure:
> 
> Acked-by: Peter Maydell <peter.maydell@linaro.org>

Thanks! Series queued.


