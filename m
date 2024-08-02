Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412EEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 17:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvey-0007ZH-LY; Fri, 02 Aug 2024 13:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvew-0007Y2-Ce
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:01:42 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZveu-0006fQ-IV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:01:42 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so10077508e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722618098; x=1723222898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FvXt2X7FWUB1rfnbVasvJsWyy5xFu7T9dVbglF5sb+s=;
 b=Vi3zcKLJTmq9XYkb+20UKnmb33n9l4vdK2jewVgehVjZTqlGQMLPJCbzTy/R13rWjr
 ecSCCzMW6+sCbiBoNzsRHnGsPjZksAaSgc5mYA2T7ngCe1cVRBb7n+YKvZiYupknPupd
 /npvMavbY6iZ2wuzwHRMq42Zx6Sr4MPCFZcBudbsTuLjYu1pA7rUH+t4YAztMa6AZWki
 RbQ7FPXB+25CsY+fywHYHJMHiKAHBIKP/Ps2f7pDBLdtXXBMye0+tM6qtRqTF+qd9EpJ
 QKrt75t4B9O0NQjWJknQ4GxCtQBR9hJDljxLjkdLFPSf1zbqG0TTbflllmqwx3fovu1G
 O9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722618098; x=1723222898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FvXt2X7FWUB1rfnbVasvJsWyy5xFu7T9dVbglF5sb+s=;
 b=byX/wTf1r2YVkzZJKIAlq1YrJTJ2J3eQwj0e3iUosd4HPxo5OuCv5ESnG/Kfwrwy42
 lkyLjfbwVOz462cfnKBwkvsPuIKtEEVlvu9mpye8JrWr9uyZwdpNUTYtI0UvSHrVMinW
 vWi1UB9XcIVjNMj3DC0GAPzePv/4wN9pv5ZWJQPbEhdripcyb0C8Q0T/wy2/IVaN4KsJ
 8hOImcm1BxZhavtDpUwfb2yD40++rAjHaqd5ISq6YKDYlKr+GxuVXzaz0AgnsCeYCIld
 TrvU4giceEc3xDKWbb2WCwCWNiK1blGJbsS4dZmWAgseRd19RWNN/Lk3e5iqBmQAGMKD
 trbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4pTXkrPO480bB93GGXgVsKJZqamdCW8ZBvkHd5dXRuoRksz6yVGBa6MkQGE4HkOLz6GE2eIdIyF98@nongnu.org
X-Gm-Message-State: AOJu0YyLqsAaitpIW+n62Wtpkb1Gbma30gxj1tUJgHYyw6LDDaAbNuQE
 9CFkKzZaQfy36X4uOycS3Trxs0VPB30SzolZLo1LafOpgbiKbeqFvAebqx7O8hQ=
X-Google-Smtp-Source: AGHT+IFtP6GDPpuuShQJrkHGdwUt1jXclMU/AdyQMD58bmM5IiRRX8OthPUWFcbQ4g7A15twzxVd1Q==
X-Received: by 2002:a05:6512:138d:b0:52c:e054:4149 with SMTP id
 2adb3069b0e04-530bb397770mr2820163e87.15.1722618098097; 
 Fri, 02 Aug 2024 10:01:38 -0700 (PDT)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba2833sm99927445e9.45.2024.08.02.10.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 10:01:37 -0700 (PDT)
Message-ID: <b720de6b-b1bb-4014-910e-c589ab407919@linaro.org>
Date: Fri, 2 Aug 2024 19:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v3 1/2] hw/pci-host/gt64120: Reset config
 registers during RESET phase
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20240801150021.52977-1-philmd@linaro.org>
 <20240801150021.52977-2-philmd@linaro.org>
 <5e765e4d-5314-0737-fccf-635d9365f796@eik.bme.hu>
 <20240801113646-mutt-send-email-mst@kernel.org>
 <0d19415f-4ec8-4089-b158-3cc3183232ed@linaro.org>
 <CAFEAcA9EfC9yB8EYy_wpfGh-1pHx0hByqSkCfcXpKGH7hgFihg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9EfC9yB8EYy_wpfGh-1pHx0hByqSkCfcXpKGH7hgFihg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 1/8/24 19:13, Peter Maydell wrote:
> On Thu, 1 Aug 2024 at 18:03, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> +Peter who is tackling our Reset interface limitations,
>> +Daniel for deprecation advices.
>>
>> On 1/8/24 17:37, Michael S. Tsirkin wrote:
>>> On Thu, Aug 01, 2024 at 05:30:38PM +0200, BALATON Zoltan wrote:
>>>> On Thu, 1 Aug 2024, Philippe Mathieu-Daudé wrote:
>>>>> Reset config values in the device RESET phase, not only once
>>>>> when the device is realized, because otherwise the device can
>>>>> use unknown values at reset.
>>>>>
>>>>> Mention the datasheet referenced. Remove the "Malta assumptions
>>>>> ahead" comment since the reset values from the datasheet are used.
>>>>>
>>>>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> hw/pci-host/gt64120.c | 14 +++++++++++---
>>>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>
>>
>>>>> @@ -1231,8 +1238,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
>>>>> {
>>>>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>>>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>>>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>>>>>
>>>>> -    k->realize = gt64120_pci_realize;
>>>>> +    rc->phases.hold = gt64120_pci_reset_hold;
>>>>
>>>> Why reset_hold and not a simple reset method which is more usual?
>>
>> DeviceReset is deprecated since 4 years now, see commit c11256aa6f
>> ("hw/core: add Resettable support to BusClass and DeviceClass") and
>> the effort to convert the legacy interface to this new API:
> 
>> Peter, Daniel, do we have a way to hint developers about
>> deprecated API uses (like for versioned machines macros,
>> commit a35f8577a0 "hw: add macros for deprecation & removal
>> of versioned machines"), to settle on a release when API
>> must be converted by?
> 
> For reset, the stuff I really want to get converted is
> the complex stuff (eg bus reset, cases where a device
> reset method needs to call its parent method, etc), and
> the ancient legacy stuff (eg qemu_register_reset()).
> Converting that will make the reset process more uniform
> and allow us to get rid of some annoying inter-compatibility
> machinery. (Some of this I've already done -- if you look
> at the commits in that list, you'll see that a lot of them
> are conversions because those classes were using some API
> I wanted to remove like device_class_set_parent_reset().
> Still haven't quite got rid of that because s390 CPUs are
> doing something a bit awkward...)
> 
> Also devices where there's something it needs to do in
> reset that should properly be done in a phase other than
> 'hold' obviously need conversion.
> 
> For a simple leaf device reset, a DeviceClass::reset method
> and a ResettableClass::reset_hold method are essentially
> identical, and the amount of glue code we need to make
> the Resettable machinery be able to call a DeviceClass:reset
> method is minimal. So I don't care about trying to convert
> any of the existing uses in the tree or marking
> DeviceClass::reset as deprecated.
> 
> If we're adding a reset method to a device which didn't
> previously have it, I guess Resettable is preferable,
> but I don't feel strongly enough about that to ask for
> a change at code-review time, and I suspect I've written
> new DeviceClass::reset methods myself.

Thanks for clarifying. I concur Resettable is preferable
when adding a reset method.

