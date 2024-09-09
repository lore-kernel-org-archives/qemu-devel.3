Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDDAECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfnO-00086W-U2; Mon, 09 Sep 2024 10:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1snfnM-0007uq-MJ; Mon, 09 Sep 2024 10:55:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1snfnE-00076C-Bj; Mon, 09 Sep 2024 10:55:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-717914d6c95so2859903b3a.0; 
 Mon, 09 Sep 2024 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725893702; x=1726498502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=iWh3R93qEouOzH298uC0Jsze3u2mPLpwJHIHPFoWEmg=;
 b=O6AZquXc4CkRB2+FKyknt0jp1e2yuA4tXbIq3VICB0kRLJtmh9hxC4qa2QBYi5tMaH
 ze0eLZZsI6FtuNB16uaJ19Tu62MMPgdkCTIJC4Ay8HkefGByrgiX/HeFKZmr52t4W1s+
 bVjJswV1iMumC+9FGBcXAUBsH8aptCzjjcYJ6hnxKPBNsYqslAfqq57fDoDPrQElKo4g
 LP5xP9zprPENhE5aKkbOVGEjDKF/gO+1J/4wUCeqssSldvBlPntZomyMGLMZYz/o76/j
 X008pJ1zDJQ8hxm2VetjPik/tJX50e+FwK/X7kszEc4cOACktCcbc3AxLhcVQF8o3ajr
 VcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893702; x=1726498502;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWh3R93qEouOzH298uC0Jsze3u2mPLpwJHIHPFoWEmg=;
 b=hBqGi/1+JGobdBydkQ7HsAFTOoPD9T0B2T8xV8oOz2J1is/cDf+agxHMXH1/AGfpQF
 w09vCFLhA68WR9StnVwP3o6hkkWLDnbfKcOeXq/TYiHuz+BwrC4HvWy0fqVIWp74tHwC
 a5uNVXzl6VsFTF7+Twy4SKBWnmf+ygsRB8O38N7SUquUbLjvr8Z7J0IGexBOItJlUX9K
 J5h8ZiuGwpS9gPSaGpP3rMZ1vflkVe6VZapn60m764L8VTzdWwCkj+5jSWxzfD+Alen/
 Lk04ORvNtpQYuwQPDK7Rhx0+ZjweR8issTeBLDzof5OoGPus8rVCXSntnrKSTNlkHxfr
 SkEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWAjbHR38jx+eB5qtqsZuDb4fX57+KjzcQdvBvbxTAij5fVzsUqesAetb52QF4v8Vq46qJtBSOnVcR1A==@nongnu.org,
 AJvYcCW0jSI90BT78YAUO9b7uuZzaEcWvjDQy5wl4mhNvPKe0FI9Hl1yu0RDRRz71mYMjHS2PjwiLyR8zg==@nongnu.org
X-Gm-Message-State: AOJu0YyHBEZa6y7pULD0MsPJq0y3EcSsDDFEVRoEHXAoPZGqB8f5bfxy
 1NPTY1hU8mNwtxth2urN3nWFtp3LfRoXMta/F3pFhV1bh2Qso4bD
X-Google-Smtp-Source: AGHT+IEWoKzc8YC/ORy5l2WDXLlz1Vb022Q0YfLO5ymM6Zekr7JOPwbbGdRH2NB1a88rW0Wmt2VD4w==
X-Received: by 2002:a05:6a21:39b:b0:1cf:4ba0:c0b9 with SMTP id
 adf61e73a8af0-1cf4ba0c2f3mr1200329637.44.1725893702416; 
 Mon, 09 Sep 2024 07:55:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e598ff05sm3616946b3a.189.2024.09.09.07.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 07:55:01 -0700 (PDT)
Message-ID: <3f4ce380-0c0b-48ad-9752-c72f5aeac754@roeck-us.net>
Date: Mon, 9 Sep 2024 07:55:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/9/24 06:40, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 3/9/24 18:06, Peter Maydell wrote:
>> This patchset removes the various Arm machines which we deprecated
>> for the 9.0 release and are therefore allowed to remove for the 9.2
>> release:
>>   akita, borzoi, cheetah, connex, mainstone, n800, n810,
>>   spitz, terrier, tosa, verdex, z2
> 
>> The series includes removal of some code which while not strictly
>> specific to these machines was in practice used only by them:
>>   * the OneNAND flash memory device
>>   * the PCMCIA subsystem
>>   * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
> 
>> thanks
>> -- PMM
>>
>> Peter Maydell (53):
>>    hw/input: Drop ADS7846 device
>>    hw/adc: Remove MAX111X device
>>    hw/gpio: Remove MAX7310 device

max7310 is a gpio controller which is at least somewhat compatible
to pca953x. It is used on imx6qdl-sabreauto, and also instantiated
by Linux with the INT3491 ACPI ID.

Is there real pressure to remove support for such devices ?

Thanks,
Guenter

>>    hw/input: Remove tsc2005 touchscreen controller
>>    hw/input: Remove tsc210x device
>>    hw/rtc: Remove twl92230 device
>>    hw/input: Remove lm832x device
>>    hw/usb: Remove tusb6010 USB controller
>>    hw/usb: Remove MUSB USB host controller
> 
> Some of these devices are user-creatable and only rely on a bus
> (not a particular removed machine), so could potentially be used
> on other maintained machines which expose a similar bus.
> We don't have in-tree (tests/) examples, but I wonder if it is OK
> to remove them without first explicitly deprecating them in
> docs/about/deprecated.rst. I wouldn't surprise users when 9.2 is
> release. Maybe this isn't an issue, but I prefer to mention it
> now to be sure.
> 
> Regards,
> 
> Phil.


