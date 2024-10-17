Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875BFD3C52A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Uh9-000721-LO; Thu, 17 Oct 2024 13:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t1Uh8-00071H-AD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:53:54 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t1Uh6-0003cR-Nw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:53:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cbb1cf324so10391155ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729187631; x=1729792431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02oeOFeK7jtYuCzX8W9dU5PdVKq3pbuOMiR05+cTM30=;
 b=D69r7sY0WKEuNIk0siDPcbPcuGOx8OVG+KyK1ZwHUBsw5ZFR2ew5YAx4Pde7Tb7Ue8
 SNvKjNtDfLJA+DqOI6mQpXqutcOzKOww1szRmm10T5BKXdmoyYuurOH136ZHc5NDCbcp
 bYwWxG3V3Gsl2MxapUvDDHJHBwdulPnuZo124aF3ElczjPYfK1aHqbYmrtK0fv/aJsYM
 vDzpCDen1Z190/iH4NrEJAcLXqS42VfX/lHx7wb9wNX7xTdmqC/trqNeMNNod4uUWJmS
 1kdXxcW9iVBAbS6iQo7pUM5WpYjeY+cmQADsQ0X4TmDzUup7EbzXvHzJCTfs3fSvXj8t
 i5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187631; x=1729792431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02oeOFeK7jtYuCzX8W9dU5PdVKq3pbuOMiR05+cTM30=;
 b=j7yQM+wELniUT/PrDXMNBYne5y/lRXL24/XG7Ia7zSd7WTdja2GN8KDeZYVi3OPxYh
 uZ4hDYzT8MBrCdidWsJ6M5ckcb8PapyrDOlPUJVj7LKAZBy8CfYAoLRTNgVsrvWYSikJ
 oTHdkL9HuL/8AQLQUymDPHqX0adpUxQkdClLvsOn0mK+7MWdA9hCpEm9KOVeruUgxbDv
 xotSOr/jhBD40K2B7efMBVMkMQeXbIWtJxhnPo4+Bb2U+YnrOg/b+Xfq3UY+gEV/IUta
 D78RTlmLVju1BG9in5ocoZx3lF789FZdQBCtsTjlgySltEXR1AbsJwZgOH5sK6h9hV9V
 Yb9g==
X-Gm-Message-State: AOJu0YzeNFhnhmxR8tv66Z2TMPyLSYiEumQNBqM7nemLQdAG3iYyq9/g
 tZ09/ENS5JD7ZV0r+0thEt53Jxpkq9YjnysHvy6nU6ZTSdve1dbEH0Pd6chMWz0=
X-Google-Smtp-Source: AGHT+IGyA7u1b10iGVQrb28N/d5XTMtA2jAsrnF1YFrxdnEHtsgbGORXNhMnwGLviCOX5FjE3mCQ7A==
X-Received: by 2002:a17:903:22cb:b0:20c:9821:699d with SMTP id
 d9443c01a7336-20d27f41966mr130474815ad.51.1729187630791; 
 Thu, 17 Oct 2024 10:53:50 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f9d321sm47037755ad.68.2024.10.17.10.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 10:53:50 -0700 (PDT)
Message-ID: <5b6e9f3f-36e7-4b0f-8698-15a419095558@linaro.org>
Date: Thu, 17 Oct 2024 14:53:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
 <CAFEAcA95QmpcsrgCj5uE-Ng8ahNir3MuVEHWBCvjb3UwBbOFRA@mail.gmail.com>
 <ec0e8a75-c59f-41b3-b559-43c057fca8fd@roeck-us.net>
 <CAFEAcA9AZS1dGaLG85zZE8U0d7AcrLgKXNbhxkCoP+PLmbFn2g@mail.gmail.com>
 <cf7c8f57-22d5-4a40-bd87-0f15f5457d48@roeck-us.net>
 <CAFEAcA98=2OdT9ykg5ibDuVLtSXuq4g0PLmSbxkYmt1SyKe9iQ@mail.gmail.com>
 <c354e331-39c4-4520-9a69-b62a8ecdddbc@roeck-us.net>
 <CAFEAcA-NreDmpCoFgrTJ5dEto5jQbjRg1eCfqg9Ns8VwQ9-Qzw@mail.gmail.com>
 <2e8046a2-c229-4ed5-add1-d31f437325b9@roeck-us.net>
 <CAFEAcA9AfH7cTO8TYSh9E+FnYN8SbTLDkXW8W5Jwi9Kfcddr6g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9AfH7cTO8TYSh9E+FnYN8SbTLDkXW8W5Jwi9Kfcddr6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 17/10/24 13:07, Peter Maydell wrote:
> On Thu, 17 Oct 2024 at 16:29, Guenter Roeck <linux@roeck-us.net> wrote:


>>> By the way, it looks to me like QEMU has a regression
>>> somewhere where we can't boot that sx1 test for the SD
>>> card version -- it hangs during kernel boot waiting for
>>> the MMC card. (An elderly QEMU binary I have boots OK.)
>>> I'm looking into what's happened there.
>>>
>>
>> Yes, you are correct. I did a quick check; the problem started with v9.1.
>> v9.0 boots fine.
> 
> It's an issue with commit 1ab08790bb75e4 -- when we did a refactor
> of the SD card emulation we didn't notice that the omap mmc
> controller was also using the sd_cmd_type_t enum and relied
> on the values of that enum matching the meanings of the
> different values of the controller's MMC_CMD register Type field.
> I'm just testing a patch.

Doh indeed I missed that use in omap_mmc_command()...

Thanks for the quick analysis!

Phil.


