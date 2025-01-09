Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136E7E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrns-0000AP-Qx; Thu, 09 Jan 2025 07:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrnm-00008a-TI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:38:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrnj-0004wJ-MO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:38:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so640817f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736426293; x=1737031093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sCtZHRaXQh/eN53aoCTddO6TXo2ZxSf1Akwc07lgQG8=;
 b=PfPCkslDNPhuogHkvyL59wn+kSDz8kxSTGUxpQNXadCRtgcJvadcgL8N5/anN66KAw
 wHt/4sYWN6tSdrKyzJ7rdFKQYmIzXj4bv26OPQFRXUXjZP2p5TceII/kgLW3aRwfjsnC
 wnZopIEiohodEq4RKqETsYlEzPoHpXEvPwrVoq6kciUUnYQUNN8povhgDCqVH35kRWFz
 qrvryWLODC50gWSa+t/i4hYxebuE2QgaUw92ADy+nZ1v+bFj/GhkdavysTQjeOXMx8B5
 R3vvLn6ZtF/hP3YNLsdHhmopD3llEO8jFqdgycXJwX/JNHAaB8ZmJc9/6BqxPL4oL8ml
 KPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426293; x=1737031093;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCtZHRaXQh/eN53aoCTddO6TXo2ZxSf1Akwc07lgQG8=;
 b=tz6VZS//H5a+/S9ktZknUa3wYNxiPSuqneRAeNGG4nbyU65HNU8R/Yw/RFApuH9JpO
 z01nNsiN7UUHDQ82q5exDHMPymiKK+0x87QV3CqLXp/APTsgoUH/aiH0tDnKtGJbTpHt
 nmHzoBLAshuppCv1B5/CknJ8JV8mRe5ZaynpzWBPoIXb7C2PgTUjhzClIzUWN+2X6SVu
 Gq31C+7Ozr1YhJ7n+473mK63BN2cbeygosCpjcMZBvIvK8lH//IqdzWHYrZ3J5R5CrbN
 /IIC9V4tZ9RlzSUo2Eez93wWnPY/RUuyOymx37lqhzEo81mUi28x2PAMWaQ6MHyUkImU
 gJLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkSHFYOkGHies5Cs/d0wIv8eRYPtQ3fcwpdB2V6K0zrI6j//lqtG6rGj81TvNN9pjDNZoTc0CVAVEU@nongnu.org
X-Gm-Message-State: AOJu0Yyi91ft7vi/c2XGtuwX3xry+8gdmlsBfx0Zeoi7Ax8kgxpGTvrL
 IcCv0ezlEZbbKHgJTEMAbR40v13oAHucCDo6es7I6z7v5MGxXS6jor8Pi6/lO0w=
X-Gm-Gg: ASbGncs8+dHuq9xrdU/bawPT1fJfpDsC9jLb3zYrmaKCJ+8kPwT08wvgW5pSFJbp6+M
 /AbPWj0b2e+r9ne9MS6crnPDro/J/lVZkTfynHaB1+N618H8rtzBmHpQb19/fhO9DpZrPxHopVZ
 y/BP0PDxMIPN9+efTwQUxysNhMAqcc+Ige/5ruZhBPOiui//DZKCmLwAIyTwGrX2lpahlIN2GIb
 G8pRV6e0LiDTKtG7MSLedE9EQ+5rLNl3G0aqtksN/RhA4Znm8/0CV+R/8+nEOLbtCtUlSc8hKbB
 8MBhYMPMUzza8k2tw05lqsy+
X-Google-Smtp-Source: AGHT+IG+WPPCnONLqsA17K1Iiv272YtWajiN30JgAyA4UrVlgkatdeas40sD3/VmTfZHRmL5+d6ZDQ==
X-Received: by 2002:a05:6000:1445:b0:385:df6d:6fc7 with SMTP id
 ffacd0b85a97d-38a8730ce5amr6011841f8f.25.1736426293352; 
 Thu, 09 Jan 2025 04:38:13 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d447sm1717278f8f.4.2025.01.09.04.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:38:12 -0800 (PST)
Message-ID: <d1ee0d2b-0266-4d26-9832-0f9fc05fb3b9@linaro.org>
Date: Thu, 9 Jan 2025 13:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-13-shentey@gmail.com>
 <696c9a80-7311-4a95-ab3c-f85bc0b38e6e@linaro.org>
 <258e62c4-9e7f-432c-ace2-a5c459d8e016@linaro.org>
Content-Language: en-US
In-Reply-To: <258e62c4-9e7f-432c-ace2-a5c459d8e016@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 9/1/25 12:56, Philippe Mathieu-Daudé wrote:
> On 9/1/25 12:43, Philippe Mathieu-Daudé wrote:
>> On 8/1/25 10:25, Bernhard Beschow wrote:
>>> Also print the MMIO address when tracing. This allows to 
>>> distinguishing the
>>> many instances a typical i.MX SoC has.
> 
> I'm not a fan of using peripheral address access, because it
> can change i.e. when a vCPU is accessing it from secure or
> non-secure mode.
> 
> I'd rather use an 'id', a 'name' or even the QOM (canonical?)
> path.
> 
> Maybe we should directly cache that as Device::qom_path, so
> all devices can use it for tracing, and we don't need to set
> an id/name property when creating the device...

We already have that, it is Device::canonical_path :)

> 
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>>   hw/i2c/imx_i2c.c    | 21 +++++----------------
>>>   hw/i2c/trace-events |  5 +++++
>>>   2 files changed, 10 insertions(+), 16 deletions(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


