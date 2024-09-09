Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C0ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngaK-000586-Rp; Mon, 09 Sep 2024 11:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sngaD-00055P-NM
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:45:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sngaB-0004KG-SG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:45:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c3d8d3ebbdso696265a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725896738; x=1726501538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eIWAPB2sTmMU/5NUok7FsVRXFtzPM00GzV1Anwo45Us=;
 b=ZCMBj9kctk6a2DxV6FHmCtBkALukseqwnPs5KYeSGHgWiu/38zrDpCNIgvTKa6J33+
 9+ucjPcdwH8ykvi2xF9sxEFyegVQmybzdRjzWohyx+l/0XoujxmYMkJplY13wHL6uBYk
 wu+7+pkE77Uby3oDDTbbDPRX9kL5VehvhVqf/HqW4RFUldTkCH2ySC7oAfqUp8aMcIID
 rEXRRBzo3d0BM3oBH3iQlNBVLKUS/Bpc2GN3vwHIo6zPns3RNqmvHij2VniE3odMzuxF
 vfQZc2RYrGcb5U3bJ9JscPHi3MfeTmEqLdQTIGLLSiRR/Mq6EridSeCmTU6QYzDaocGu
 yyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725896738; x=1726501538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eIWAPB2sTmMU/5NUok7FsVRXFtzPM00GzV1Anwo45Us=;
 b=Np8bowH3ZKbD/2FeV48rq5GheHSUMUBE2/F40LZv2DyC3ZEurJuEHfWXfnwcYEl/Xr
 l58sS52zIJl3ouS6nGKaVgg7wI62V0kRlUWD9Gddztm4uJUOZCmxDbgKSlTyakUbalBH
 YDBsFUTBcIpht4SsCejjQ5A6WUA86k15YPbpdsAi3yJUfYjjY7+1qqk7O8KlT/ogGB7D
 a8zNx/FHCbCnrC2C4DWqhs7dT6l0WrKRSebSrya6l5OvVue1wSPzLs1380NTS4jOS3ii
 dwe1n0i/h4FOGsMO0dlet5r/gN9nw595S1W2A6GQ2Hq93bBSQd8KcOWdfbxDnJlEMuYQ
 H+iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtUVBYFuAI+02nCi3LAVG8jfu3tF9lvtUstfNhXNSkewMXsyZcvX6RSQrypmsWLnfZYfIdacoE96Nq@nongnu.org
X-Gm-Message-State: AOJu0Yybv1E/8DdThzDlexHbKsZf1GjGUIDqrqFz+iNWv/RuBrNyM8Ml
 VC4InRUqdNVo6RQY7lnjwfX0x2NPkxMAEtsgvuhEiPW5aUsAPISBrA5okTIrquk=
X-Google-Smtp-Source: AGHT+IFYNDLz3V2sp3kRC0D1vxmD0xzPxzv41PjbOxIMej3+McRmQXrVFIf4jrMljA84gZTZ4xmFmQ==
X-Received: by 2002:a05:6402:2317:b0:5c2:7601:a0c8 with SMTP id
 4fb4d7f45d1cf-5c401602356mr64621a12.13.1725896737861; 
 Mon, 09 Sep 2024 08:45:37 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd4693fsm3163168a12.37.2024.09.09.08.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 08:45:37 -0700 (PDT)
Message-ID: <6e238c93-631a-4686-9e5a-e169ce082b17@linaro.org>
Date: Mon, 9 Sep 2024 17:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
 <3f4ce380-0c0b-48ad-9752-c72f5aeac754@roeck-us.net>
 <CAFEAcA_ETkWY=AaPWti8KwO0awdxWqkO4CLAwxaGVr+i4yFz-Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_ETkWY=AaPWti8KwO0awdxWqkO4CLAwxaGVr+i4yFz-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/9/24 17:02, Peter Maydell wrote:
> On Mon, 9 Sept 2024 at 15:55, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 9/9/24 06:40, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 3/9/24 18:06, Peter Maydell wrote:
>>>> This patchset removes the various Arm machines which we deprecated
>>>> for the 9.0 release and are therefore allowed to remove for the 9.2
>>>> release:
>>>>    akita, borzoi, cheetah, connex, mainstone, n800, n810,
>>>>    spitz, terrier, tosa, verdex, z2
>>>
>>>> The series includes removal of some code which while not strictly
>>>> specific to these machines was in practice used only by them:
>>>>    * the OneNAND flash memory device
>>>>    * the PCMCIA subsystem
>>>>    * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
>>>
>>>> thanks
>>>> -- PMM
>>>>
>>>> Peter Maydell (53):
>>>>     hw/input: Drop ADS7846 device
>>>>     hw/adc: Remove MAX111X device
>>>>     hw/gpio: Remove MAX7310 device
>>
>> max7310 is a gpio controller which is at least somewhat compatible
>> to pca953x. It is used on imx6qdl-sabreauto, and also instantiated
>> by Linux with the INT3491 ACPI ID.

Can you use the PCF8574 port expander instead? It uses more recent
QEMU design model.

>> Is there real pressure to remove support for such devices ?
> 
> "git grep" says the only place we use our max7310 device is
> on the "spitz" board. The point of removing all those
> elderly Arm boards is that all this code is ancient and
> unmaintained. If we were using this device on the imx6
> boards I would have kept it, but we aren't. I don't want
> to keep old, unmaintained, untested, dead code in the tree.
> If anybody does want to use it on some board in future
> they can always pull it out of the git history (and
> check whether it needs work to bring it up to modern
> standards, and write some tests for it...)
> 
> thanks
> -- PMM


