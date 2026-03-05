Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E80F47CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyDF8-0003C9-NC; Thu, 05 Mar 2026 13:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyDEw-0003BZ-PT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:16:04 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyDEt-0006gR-5S
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:16:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b790af67so2923994f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772734556; x=1773339356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlmsCJf2fzHTAC0WK8L7tDQENhBUUh9+SRB8PgBoI0Y=;
 b=PQ+fEu3oz8NR791Tv2BI2BtI9tadlSot14vNfOzFfBCdFC32ZvDNmqZnnb5z9c2aJg
 uN/fv/B+vpwGc5VDSDytL1RWEHcF2HsnSffTb/FTb5QPtmUdgMAVzF3VEKQxIh4+gnu+
 FkAHlPcWuMzkGRkPmSTHzG/IH6VAkZqF73CM22QeGvUbWygzmizKXxBg6jaol7YzBVoQ
 rVUa6ifxSx1p1ThLzu7NUZeU/hbGiqTIotMsLfboAatSx1igbIUNZdmnqXvuQCWvTlfY
 0qft7wOygAVYhi8It3AOZBiLV+mQ9wPWBpqkVUxydvaGLYeapPMFUnfIsUIPESRQepyM
 uv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772734556; x=1773339356;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NlmsCJf2fzHTAC0WK8L7tDQENhBUUh9+SRB8PgBoI0Y=;
 b=UXT/kqKBbsUuCUaAXegBn74XBP5DP4/NwBXuYlL2IbOYg0K9+lDcglsTPb0wsrBHXU
 cTQgWYlEs9telEn9Kf9vNUjb7YZrd3scdHvtwMFIf2C0+hghT7/2iBzpgQRqncWX1tgJ
 GTzoD6c0bbuTibZmjuRddXa5By+9V2Ugh2MPDCY1TkujHo3JZFpHppgZwy2y0FVmvDHg
 fFX3uJEKHzL7jkhU0WcNifrAZmeAu8GUHGPJnmPrBflyiAUghUjBXXZqqiSpIl05js3K
 qF2yN7ISCE4OqMWZerVjniGlVkPXJl8BPOpOu8iTxaT3gvMFqJ8l5zi5SQszw8+LxX/X
 XJdA==
X-Gm-Message-State: AOJu0Yyhyvo/jcWZc2gkvDoQ/1AOGzODwapkOPyNzfEASbgCPi2ZzXa2
 70JZsSgM+rjhISqG86cA5YPJCW/QC2Pf+SubQxZL3Nq3PF8JxLypVI53
X-Gm-Gg: ATEYQzw+ul4U0o7UjXDJnfcu0WXNKBF7g7lg3DFhmpLm89W0JpE3pi7kRPvQc49IzVm
 cdwuh9fjNlnhxjpNNlFiDO9lrFp/v9sSqR7AFJprhhjok0bQ5l3j92zOc4x3P1zriOjRfVOA/5i
 2PFjLx+Q8DEJvksJNxAG01288flSKE5fO4b+LNvIBp/j1qwuv3yJCnZCOqhJSRYjCgRgcn38gVJ
 KJIrGCoCgGmsfjEvvNUkeuftIkoiET1xECr7WRjkvocZO0psbGL0AeclTB1YRrcpkEl3ozt86O+
 Ro2Lt+9TheOtVqQNy/MR9qis5nsc7hwXoe7M3lZbTTIDR+MMx1MF1p49UN7ISyY8k+/ZZAU1Q0x
 Phi1ZaH0RNx/avLT43gwSdeiSLP0afNyBx3kokohAStrr+KMWcy0FGjL9oXvJSQXlHvaSgKhLsK
 HU8Uuy3T93MuXocapWPYMuV/ZZs8xZ+A==
X-Received: by 2002:a05:6000:438a:b0:439:c560:bb79 with SMTP id
 ffacd0b85a97d-439cfd65a2emr6126449f8f.17.1772734555672; 
 Thu, 05 Mar 2026 10:15:55 -0800 (PST)
Received: from ehlo.thunderbird.net ([185.238.219.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ac9f3e5bsm42100771f8f.37.2026.03.05.10.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 10:15:55 -0800 (PST)
Date: Thu, 05 Mar 2026 17:53:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 12/13] hw/char/serial: Inherit from SysBusDevice
In-Reply-To: <CAFEAcA9LLOTOrkUQW3Q74rrOiXGa7BoC8Lu11O9ESC-36WHtew@mail.gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
 <CAFEAcA9LLOTOrkUQW3Q74rrOiXGa7BoC8Lu11O9ESC-36WHtew@mail.gmail.com>
Message-ID: <A0F637F1-BB16-42CB-AC5E-80D71DF8057B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 5=2E M=C3=A4rz 2026 10:07:23 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>On Tue, 3 Mar 2026 at 22:22, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> SerialState currently inherits just from DeviceState and serial devices
>> use SerialState as an "IP block"=2E Since DeviceState doesn't have an A=
PI
>> to provide MMIO regions or IRQs, all serial devices access attributes
>> internal to SerialState directly=2E Fix this by having SerialState inhe=
rit
>> from SysBusDevice=2E
>>
>> In addition, DeviceState doesn't participate in the reset framework
>> while SysBusDevice does=2E This allows for implementing reset
>> functionality more idiomatically=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>
>
>> diff --git a/hw/char/diva-gsp=2Ec b/hw/char/diva-gsp=2Ec
>> index 2ea60103ea=2E=2E55c42effe9 100644
>> --- a/hw/char/diva-gsp=2Ec
>> +++ b/hw/char/diva-gsp=2Ec
>> @@ -56,13 +56,13 @@ typedef struct PCIDivaSerialState {
>>  static void diva_pci_exit(PCIDevice *dev)
>>  {
>>      PCIDivaSerialState *pci =3D DO_UPCAST(PCIDivaSerialState, dev, dev=
);
>> -    SerialState *s;
>>      int i;
>>
>>      for (i =3D 0; i < pci->ports; i++) {
>> -        s =3D pci->state + i;
>> -        qdev_unrealize(DEVICE(s));
>> -        memory_region_del_subregion(&pci->membar, &s->io);
>> +        SysBusDevice *sbd =3D SYS_BUS_DEVICE(pci->state + i);
>> +        qdev_unrealize(DEVICE(sbd));
>> +        memory_region_del_subregion(&pci->membar,
>> +                                    sysbus_mmio_get_region(sbd, 0));
>>      }
>>      qemu_free_irqs(pci->irqs, pci->ports);
>>  }
>
>The ordering here looks a little odd -- is it really OK to
>keep using sbd (passing it to sysbus_mmio_get_region()) after
>we have unrealized the device ? Remove the region from the membar
>first and then unrealize would seem a more natural order=2E

Indeed=2E Will add a patch before this one=2E

Thanks,
Bermhard

>Perhaps the MR refcounts here save us, though=2E
>
>> diff --git a/hw/char/serial-pci-multi=2Ec b/hw/char/serial-pci-multi=2E=
c
>> index 38e5a78e6f=2E=2E4e51d14111 100644
>> --- a/hw/char/serial-pci-multi=2Ec
>> +++ b/hw/char/serial-pci-multi=2Ec
>> @@ -50,13 +50,13 @@ typedef struct PCIMultiSerialState {
>>  static void multi_serial_pci_exit(PCIDevice *dev)
>>  {
>>      PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, d=
ev);
>> -    SerialState *s;
>>      int i;
>>
>>      for (i =3D 0; i < pci->ports; i++) {
>> -        s =3D pci->state + i;
>> -        qdev_unrealize(DEVICE(s));
>> -        memory_region_del_subregion(&pci->iobar, &s->io);
>> +        SysBusDevice *sbd =3D SYS_BUS_DEVICE(pci->state + i);
>> +        qdev_unrealize(DEVICE(sbd));
>> +        memory_region_del_subregion(&pci->iobar,
>> +                                    sysbus_mmio_get_region(sbd, 0));
>>      }
>>  }
>
>Similarly here=2E
>
>Otherwise
>Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>
>thanks
>-- PMM

