Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86289C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 09:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFV30-0004if-0Q; Thu, 15 May 2025 05:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uFV2y-0004fv-1H
 for qemu-devel@nongnu.org; Thu, 15 May 2025 05:38:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uFV2w-0002Yr-27
 for qemu-devel@nongnu.org; Thu, 15 May 2025 05:38:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so8732895e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747301911; x=1747906711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nf74C8dyQbzmDJW4x186+d2hXHBsvWL7V4UL6mKmWpE=;
 b=loccD3X6uoF+iuU71S09MdvevqNMTxv7bRmGrMQzByYjG8Zb9GjIDpx/kM8O/PbfER
 EqeLJQOIBTFd2z8UWWAVXAt474dRFxRDvrK36GxJjdMylbxG3GvRlzuMbd3nIaZ8mjfV
 Gf9r/Hz523lEKB47ukd+YpUfB5I/aITWAoiqiTFDeSfqCTxfUvFRfh9EvuMr4ZwX/B4t
 r6fSTEsEHm8vON6YMQc2JHlJd5d3akeuP9YG3SI7MDCfU4sOd8xatoKuCT6B2pmUO3+N
 NkDmK9xpBmBBWNT8wrwY7tuBpXBN64uZLvszbaEa4Zb2bQh1kX/2N2rEPyApFjAFI+o8
 XyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747301911; x=1747906711;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nf74C8dyQbzmDJW4x186+d2hXHBsvWL7V4UL6mKmWpE=;
 b=Ed/e2pmQt/+vKc+Omli4mMTaCPEZBYw061BpHTGhlAXXryrIWO7pFnbtaPWda2oJbj
 +9yuwotijRNrC8L/f4KXQ6J1JEnVWQqzYvVGKHKwsZcIh8iDw6/vCMGbIXj0vFRp2A4V
 g3lVf4qeJSkGsa5gLBnt/7oAcatBBwj6/AyZ4RzV8cZOKvgZzbo4D4L/o+4CjKgv9Ghp
 PxZLE0685ut/MD+PMsw6oCJGBUlnkjDy/DYayz+CatcREh9DDFHA7jnBBl4rA/ZXkGfo
 VRC/sEwXONjukskNnPtFw9qacPVvOE1zwCALtSf1LVX5XeAKtuWDyuhWHav3E+7SkFi9
 8hAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm25aTCcyio00H+y9XAd9eYkYnuz++44tl2yTHg4eGaESimhDYgb8MuwaWLzQh4Ckd/fwSrTn/3kPT@nongnu.org
X-Gm-Message-State: AOJu0YzP+U4gjSQ12MEgQ+F7rwiXkiopD0z0DkogxC9399Qyv8+2tfwr
 /Su8I+Jv6j6M53DpGmBJ2L4QJrfoBu+csCmr+llw1zj6iqJVwRRM
X-Gm-Gg: ASbGnctMjxqM/Dm0l+UnXbPP6fUxc3z1L3NzvX24XHyKovK5hGI3Sm2L+l+TDXXB14P
 gc8XmOFGd+BEjmJ4smwL/QUY+AVHWIynNuu1IGsNxK91z5AFFkm4l4MAtffe8iMJvCjuUTDR3Yf
 pjLPHqNJI/embG3vO4tE/DeQE19MlxNcZWiFSqGOCL9Z+ZVPqtGyBZMWF/W8iyVlUtlA/ecMLn4
 2cRIE5/eYNfo3lmwNQkAohvHU+FoPMNIZLGaGJXi7Vr7eBLA0Sq3iE9a/NBejt50TV3zfTTS6Fc
 3TrYuW6joDBl1ftEBVsSESka1NEmFpTI4Hsx1v2+djvYUA==
X-Google-Smtp-Source: AGHT+IGIIotvCQQtMIhVh39ymDobTZtR/WY3AfKwjFHFnw3JOHSg4EXQjqPAROXef2kmxSFZjD/rWQ==
X-Received: by 2002:a05:6000:2210:b0:3a0:b571:e917 with SMTP id
 ffacd0b85a97d-3a3496a59bcmr6385106f8f.14.1747301910892; 
 Thu, 15 May 2025 02:38:30 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ecccbsm22356064f8f.32.2025.05.15.02.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 02:38:30 -0700 (PDT)
Date: Thu, 15 May 2025 09:38:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
In-Reply-To: <a656a836-6464-4e0a-810b-e3e95617838e@nutanix.com>
References: <20250512210928.4195-1-shentey@gmail.com>
 <a656a836-6464-4e0a-810b-e3e95617838e@nutanix.com>
Message-ID: <D063FE9B-B10C-4C20-9E9A-86FB7AECEBC7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E Mai 2025 09:02:56 UTC schrieb Mark Cave-Ayland <mark=2Ecaveayland=
@nutanix=2Ecom>:
>On 12/05/2025 22:09, Bernhard Beschow wrote:
>
>> Commit 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
>> attempted to refactor RTC IRQ wiring which was previously done in
>> pc_basic_device_init() but forgot about the isapc machine=2E Fix this b=
y
>> wiring in the code section dedicated exclusively to the isapc machine=
=2E
>>=20
>> Resolves: https://urldefense=2Eproofpoint=2Ecom/v2/url?u=3Dhttps-3A__gi=
tlab=2Ecom_qemu-2Dproject_qemu_-2D_issues_2961&d=3DDwIDAg&c=3Ds883GpUCOChKO=
HiocYtGcg&r=3Dc23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=3Dzy9ANkk1dnktv=
Dbix39oQju-ro1U35C5_dEQr6pECga8-YnCMKMlisUou43EzMJ-&s=3D0BQaI4PyU_roe0kyQTE=
Sxn57VNCBnJV3kEV6F-GpL8I&e=3D
>> Fixes: 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
>> cc: qemu-stable
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/i386/pc_piix=2Ec | 5 +++++
>>   1 file changed, 5 insertions(+)
>>=20
>> diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> index 0dce512f18=2E=2E4c37f5419a 100644
>> --- a/hw/i386/pc_piix=2Ec
>> +++ b/hw/i386/pc_piix=2Ec
>> @@ -285,6 +285,8 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
>>           pcms->idebus[0] =3D qdev_get_child_bus(dev, "ide=2E0");
>>           pcms->idebus[1] =3D qdev_get_child_bus(dev, "ide=2E1");
>>       } else {
>> +        uint32_t irq;
>> +
>>           isa_bus =3D isa_bus_new(NULL, system_memory, system_io,
>>                                 &error_abort);
>>           isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>> @@ -292,6 +294,9 @@ static void pc_init1(MachineState *machine, const c=
har *pci_type)
>>           x86ms->rtc =3D isa_new(TYPE_MC146818_RTC);
>>           qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>>           isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>> +        irq =3D object_property_get_uint(OBJECT(x86ms->rtc), "irq",
>> +                                       &error_fatal);
>> +        isa_connect_gpio_out(x86ms->rtc, 0, irq);
>>             i8257_dma_init(OBJECT(machine), isa_bus, 0);
>>           pcms->hpet_enabled =3D false;
>
>I see in 56b1f50e3c10 that the commit also introduced the ISA_DEVICE() QO=
M cast in isa_connect_gpio_out() as a safety check, so it's probably worth =
adding it here too=2E Otherwise looks good to me - nice detective work!
>
>Reviewed-by: Mark Cave-Ayland <mark=2Ecaveayland@nutanix=2Ecom>

Hi Mark,

thanks for the tag!

I deliberately removed the ISA_DEVICE() QOM cast since it is not needed=2E=
 That said I'd still prefer to have it as you suggest because x86ms->rtc co=
uld be a pointer to MC146818RtcState=2E I'll send a v2 let Michael pick his=
 favorite solution=2E

Best regards,
Bernhard

>
>
>ATB,
>
>Mark=2E
>

