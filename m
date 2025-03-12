Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A73C2BA1B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPxo-0002Ub-KW; Wed, 12 Mar 2025 13:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tsPxm-0002U9-1w
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:33:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tsPxf-0004qp-UO
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:33:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5491eb379so15154a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741800816; x=1742405616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/uorSczeLTSXhGU4Khn7ChTxs8hFr3Y2FB0G8PCHEY=;
 b=eEAT/1p+x8on53MnWphyds9v8uhMPHlJ+OaYm7oKpYLRg6CDDugF2KjXDUSQ9F+Rhw
 +4S3kOgh9/Efco2s/d2lNpETrKq15Zoclva7UQGJ1p5JpVboW93DVRcSNrJZaIpP20ub
 XtBCy/83pOr2G27HBDwsiM2UeJc7J/5OfIE73/xWXsXeBwTNa37owo9OXHd5J6PLO9O5
 7d0SOUm4HitE4+3Zg1IWCLTNP9BRtOXyqMxtEr8nRTP5nE2I0wLSHim+nifqg1Relb/S
 Shdv8fgiq3Zh+UmjBtZsobZOk/RWAzk7lNQ1Zlj72DaWquEG6TY2rnkhdd/nhg4k6h5L
 nZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741800816; x=1742405616;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/uorSczeLTSXhGU4Khn7ChTxs8hFr3Y2FB0G8PCHEY=;
 b=tWeLV4DVohkRX9NR529AWfXhLnEDxGvZ5w/6CpIs4bBzWaa9c/jkf/b65XrpdwsXQ8
 OJIPpmdoRvsWxRwZHG8CKYNiUWOzOtiQFR17RBHw4G37iusfUKdXbq1zlxe+4MJVapkM
 wz+PQsjzVHTRACXWQt9f3yUr6fWVaUSNhglO97p3ABrdwiH4Ji8AM4XurRRYm3c/2cxQ
 F8mI0Y0DPLoHsGPeIem3o+1Onn9Ih+Tv0fdRqSlEENOdXrzm3R0g8+lrt1F6de7wSWqE
 hZ9eCJbEVb5r7EPTi/dUUiYGyIfs9QUbj5cNWOrhrx1pGUA9jnznYJWx6F21CcGE+8CJ
 HB2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc3wbvxrPJF5db91njpMjOtQd79jZD8WkjFEBVY3ZXfz1inwc7kBbkz3O2iTSIElqPG+gZPCVhRDie@nongnu.org
X-Gm-Message-State: AOJu0YyKcbP/r7F2m1bqcsMMsjUyc+ZMNtYNhDrJWBjNBIWyYI5zvATE
 55N52M4kDlufcqsqDx80rHpGJa8X8BC7B3b25m9LrcsKaaj5BdtoAcEKNw==
X-Gm-Gg: ASbGncsE9glx4GIBUetyJk2YNE8EF38A9xDhwKiQjlWwRJBgbNqKvrrYyNO9dPisko6
 i4kKs4T9UrYOP0YMZhJOiF8N2NegsZ+bQPx6YuA3MLrJwOXY8Bedu66b+zaO1yHSXB9Zi/Sy4jR
 4y1P3nm3wHHIsiWddSTYg/y99UaH5oTM2E6JmZEXQ21Cz/SkfdsmavbuNFOsW297dN6qrAWaK3U
 WjacBIlHsyFMg28IpLBO9Uf/XckA2nt9qCQ2H+pd5n9F5l9jVwIn/K6kY/Ou63H2Bjyew3U6CT2
 6oYTY9+Y0B/bD1+IU/k0QeayzsXeD0gJ9lBbHJT6pkGhJW+MKhghCUJCdwZiprN6VvXvf8zLSsb
 ZQjdH7qSNZyH295hDku613c3covKWfBCz9YHcFkfUmh9w2Vb2gDKP
X-Google-Smtp-Source: AGHT+IGLttfrMVN2uVwKyU/laENHaAebUCv9H3G4vUaJFILwHXrW2KjIq5sxyrw39NG0ba4EJ/0SWw==
X-Received: by 2002:a05:6402:2681:b0:5e7:c42d:d8ca with SMTP id
 4fb4d7f45d1cf-5e7c42dd91cmr3698544a12.14.1741800815708; 
 Wed, 12 Mar 2025 10:33:35 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2c4e-b100-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2c4e:b100:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c768f213sm9821838a12.74.2025.03.12.10.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:33:35 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:33:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 31/43] hw/arm: Add i.MX 8M Plus EVK board
In-Reply-To: <CAFEAcA9YvYCmbzJmzV60McWTBNWt-mgkpnOpBY1_VE6_S+9W=g@mail.gmail.com>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
 <20250225180510.1318207-32-peter.maydell@linaro.org>
 <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
 <CAFEAcA-JgjX2U3wQ47X5JQ2SU1yMpx=0rWkctbj40w0Xjufpmg@mail.gmail.com>
 <e7640bea-5bb7-4f4b-8614-ed8d521dd7a5@linaro.org>
 <0261bcf8-d01d-4f63-9edf-f572519dd8af@kaod.org>
 <CAFEAcA9YvYCmbzJmzV60McWTBNWt-mgkpnOpBY1_VE6_S+9W=g@mail.gmail.com>
Message-ID: <0673B63B-AF76-4B18-95BB-EF71DF12C1E4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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



Am 12=2E M=C3=A4rz 2025 11:13:01 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>On Wed, 12 Mar 2025 at 10:44, C=C3=A9dric Le Goater <clg@kaod=2Eorg> wrot=
e:
>>
>> On 3/12/25 11:27, Philippe Mathieu-Daud=C3=A9 wrote:
>> > + C=C3=A9dric for Aspeed
>> >
>> > On 12/3/25 11:20, Peter Maydell wrote:
>> >> The bug is that this is directly inheriting from TYPE_DEVICE,
>> >> not from TYPE_SYSBUS_DEVICE=2E Doing the former is almost always
>> >> wrong, because it means the device is never reset=2E
>> >>
>> >> (It looks like we do this wrong for other fsl SoCs too,
>> >> but they're marked user_creatable =3D false=2E)
>> >
>> > IIRC it is deliberately that way for the Aspeed SoCs, because
>> > otherwise there were issue when building the multi-SoC fby35 machines
>
>Multi-SoC shouldn't have a problem with sysbus devices existing=2E
>They just mean that you can't use the convenient sysbus_mmio_map()
>function but have to be more careful with managing MemoryRegions
>in the different SoCs and using sysbus_mmio_get_region() to get
>a sysbus device's MMIO regions so you can manually map them to
>the right places=2E
>
>> AspeedSoCState was introduced long ago (2016) and the fby35 is "recent"=
,
>> from 2022=2E I am not sure that's the reason=2E
>>
>> Regarding the reset, the SoC functions are sysbus devices and all have
>> a reset=2E The SoC doesn't have any=2E Maybe that's why we are not seei=
ng
>> issues=2E
>
>Yeah, it works out in this case=2E But I think it is in general
>a bad idea to add new direct-inheritors from TYPE_DEVICE=2E
>If anybody needs to add a reset method to the SoC container
>object in future then they'll be confused about why it doesn't
>work, for instance=2E
>
>I think that in general people expect that TYPE_DEVICE is
>"devices are like this" and TYPE_SYSBUS_DEVICE is "if you
>also need the sysbus-specifics, most notably providing MMIO
>regions for registers"=2E That's a totally reasonable expectation
>but unfortunately it's wrong, because a few key parts of
>"this is an internal device that we don't need users to create"
>are only in TYPE_SYSBUS_DEVICE=2E

I'll send a patch fixing inheritance from TYPE_SYSBUS_DEVICE and setting u=
ser_creatable =3D false=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

