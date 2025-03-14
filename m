Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0124FC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszEL-000327-6X; Fri, 14 Mar 2025 03:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tszEJ-00031a-Ng; Fri, 14 Mar 2025 03:13:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tszEH-0003n2-Kk; Fri, 14 Mar 2025 03:13:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so16663275e9.1; 
 Fri, 14 Mar 2025 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741936390; x=1742541190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SsaUUzbjsBPHKpOyEqhtEsr93/DVBm/FeEW1GgjrV0=;
 b=gWCw0xuuatmoiQR4TZY30l3QloipYqcglZ2r7DTgkN5JsNyC5kvuBGn2DhCsu5RFQv
 Ut2pPrATwdU5Fvl98zua5NnJrtY+3uov2cvoXLc+3wqeqRgfekQrx6zvVhMu748Jcwsg
 Ud5sD7340/BUeGmSp+iTtA3d2lDw6llbQtTwXU+OCZaK01THEQ/pPrCDbbNvRcjA2GeD
 Myd95uESF1XEGoq9whgHSpsj44Qp2MIy/uHVU2xIK8nAYI8xqH3r34NATgcxUmcuGbIT
 mNaZDOypYCSBPv4R4QQZSPxSwcb6mp3ciNKI6ThtLubF7EEq7MnC0vlhNJzTdzg+4qsR
 DeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741936390; x=1742541190;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SsaUUzbjsBPHKpOyEqhtEsr93/DVBm/FeEW1GgjrV0=;
 b=GbFC0FiWxf+2WEWnpPHHaIssIYPhdMzoAaD/7MrtD4s1HKvNy+EEm6Yl0GZ3VDx5cr
 lnpetWrDBlljMQQ6ZeX5qaIJfkReAqHfFDkSzOFR4KM56lg6vr4YZLOm38sN7LK4tBM2
 Oe5WKkGxX5QDUHxKH3eFM087w5G8NyXpXesPSz0h0+miVrXYzSH9ofFlxzT53t1DI7XL
 jftx8BkKdYzdZt9R7/2XfJXL/K1bwqWgdgLFEo7Aduq5gei5hfoVXtjxLzWRGxTTcUSW
 RhfNwaU7Ib5s7yT1Nfv6ZeagzvdO/bN4zxIEL5uTb8RukqAvPsIql4GK8Gxo5D19aw3U
 Hq5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0sXxN1yY4LdNVFtGFDRNIm8rSnHd4Hp9vU4WiyWaw7f7IdakxBGyeUwsrUoTHWgwYp4oUg0dyug==@nongnu.org
X-Gm-Message-State: AOJu0YxeMh1wF2xI1pbyauJw2uENXHm1O9WmH0ZuOpcHJujmCeJGsLfk
 wDnEY13w2Ib7rDsyWYcyKqxk/b7xplssF9ikQpaA2+CArEjTctlN
X-Gm-Gg: ASbGnctmVegu6KF9+2yXZBLMGGgteAdPa0bh7wrxiivU4FUU4RoVbfNdwWZKHd8EMJi
 9Hjbq+EnwPNu7iyA8NzLd6jh/LE3LkcKCo5lEVTNfNPMzhpYBBc88SafpdoNAB/M3aabcwn37/E
 jIckI4wkDCDYCMA7CbL+ZOn/Sqk6AMPJW/CXX/yBaLPVt/TKzNxi/H0etJYI2DTx6IQtIZQ8DNR
 xjZeuL7FUu2Z8WVwwuKfiJGU224SRq3bTJGV5KEWEjCKAU53/PxTJKdotTlrARJas2cj0g8G6Jg
 gLKm2UIIFHohCwu07JpLak2MTSwZe5WMNVf5eydt
X-Google-Smtp-Source: AGHT+IEcAOSz5B63FapUwf6O3edLJnnxDqjUrwlYTvH4/4CGWOsgWNFZRMeQtKNiKkiu99T4cz7Fgg==
X-Received: by 2002:a5d:64a2:0:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3971d23799cmr1726195f8f.19.1741936390033; 
 Fri, 14 Mar 2025 00:13:10 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.47]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8e43244sm4698251f8f.60.2025.03.14.00.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 00:13:09 -0700 (PDT)
Date: Fri, 14 Mar 2025 07:13:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_hw/arm/fsl-imx8mp=3A_Make_SoC_not?=
 =?US-ASCII?Q?_user-creatable=2C_derive_from_TYPE=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <CAFEAcA9ivdbKoe2ip9njx4hFkkCsQCUHnMDrKeH-iQ_5368bJw@mail.gmail.com>
References: <20250312212611.51667-1-shentey@gmail.com>
 <20250312212611.51667-2-shentey@gmail.com>
 <065c6990-d2dc-7b03-cd0c-344ee6b6a619@eik.bme.hu>
 <CAFEAcA9ivdbKoe2ip9njx4hFkkCsQCUHnMDrKeH-iQ_5368bJw@mail.gmail.com>
Message-ID: <B6268CD2-A3FE-4215-9532-8728CD95DD15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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



Am 13=2E M=C3=A4rz 2025 10:12:18 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>On Wed, 12 Mar 2025 at 23:58, BALATON Zoltan <balaton@eik=2Ebme=2Ehu> wro=
te:
>>
>> On Wed, 12 Mar 2025, Bernhard Beschow wrote:
>> > Fixes a crash when creating the SoC object on the command line:
>> >
>> >  $ =2E/qemu-system-aarch64  -M virt -device fsl-imx8mp
>> >  **
>> >  ERROR:=2E=2E/=2E=2E/devel/qemu/tcg/tcg=2Ec:1006:tcg_register_thread:=
 assertion failed:
>> >  (n < tcg_max_ctxs)
>> >  Bail out! ERROR:=2E=2E/=2E=2E/devel/qemu/tcg/tcg=2Ec:1006:tcg_regist=
er_thread:
>> >  assertion failed: (n < tcg_max_ctxs)
>> >  Aborted (core dumped)
>> >
>> > Furthermore, the SoC object should be derived from TYPE_SYS_BUS_DEVIC=
E such that
>> > it gets properly reset=2E
>> >
>> > Fixes: a4eefc69b237 "hw/arm: Add i=2EMX 8M Plus EVK board"
>> > Reported-by: Thomas Huth <thuth@redhat=2Ecom>
>> > Suggested-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>> > Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>> > diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>> > index 1ea98e1463=2E=2E9133d49383 100644
>> > --- a/hw/arm/fsl-imx8mp=2Ec
>> > +++ b/hw/arm/fsl-imx8mp=2Ec
>> > @@ -698,13 +698,15 @@ static void fsl_imx8mp_class_init(ObjectClass *=
oc, void *data)
>> >     device_class_set_props(dc, fsl_imx8mp_properties);
>> >     dc->realize =3D fsl_imx8mp_realize;
>> >
>> > +    /* Reason: SoC can only be instantiated from a board */
>> > +    dc->user_creatable =3D false;
>>
>> I think sysbus devices are not user creatable by default (that's why
>> dynamic sysbus device was introduced) so either this or the =2Eparent c=
hange
>> below is enough=2E You can have both just in case but maybe not necessa=
ry as
>> other sysbus devices usually don't set user_createble either=2E
>
>Yes, that's correct -- we don't need to manually set the
>user_creatable flag here now we've changed the parent class
>to be sysbus=2E

I'll send a patch later this day=2E

Best regards,
Bernhard

>
>-- PMM

