Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA10FC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 20:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txttc-0004Mq-95; Thu, 27 Mar 2025 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1txtta-0004MR-2Z; Thu, 27 Mar 2025 16:32:10 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1txttU-00048A-MB; Thu, 27 Mar 2025 16:32:09 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so2739797a12.0; 
 Thu, 27 Mar 2025 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743107512; x=1743712312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRva02BIpqgcEgGjsHLXlgEs/CvX+XGoESnQeztOR/U=;
 b=W/kvrdLypMqb156og+7zKOkba/EbP7Mq3hSKwSno938vLtkKA3m2YYIaAZN7F10rDK
 LoA+YURB/D6/Y2uuVpDc3Y32TsVhii0j+5IltVTqQPl3nGbL8aRa0EbR+LKmJ4odAIby
 JKrExX1S/glS+4LQU+Kvak5FNe9T5esnFMQApvBupjux9K3M8yuVEZLpzIcfbh3s+cfi
 2sTvNL773O3NVUdWPNT/w3wecQkitIvD/Mkv1rY32KZVGkG5OES2Ev6YMY04nj63SUMF
 Q4QuOBAsfO61bJE6icKWXxcOLqWWVGKZxwEzwn2PDBsy55zuXb40ZyJ+ESW2ZyCx3b5x
 gFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743107512; x=1743712312;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRva02BIpqgcEgGjsHLXlgEs/CvX+XGoESnQeztOR/U=;
 b=YdO0/ZtxkNGAp4oVeoDfPPikmM5/0bBf1uITKFO2mPU5J0om+uar836aVBJ4B37dyv
 tYtAyjsOFP7I4i2Yu6sA8/mUajDOCKdbGOVCoQVilAkiHt1sDKCQ3xPXRVCPdWp9Vyuv
 ngtG4VomngthOAxgXXMWsXEC4qHgNzpUC56rNoADIDgAvQRiIlAaChGpVGUbrdbiJnVC
 RV3oaz0s08YvyDJU7ZGMsqFqQV0BUem6ITli07DmTRt6m3BDPiUkEDRIRbfWQOrvQVUg
 nz0wdorURfDbX4ujpv824grYvrRRxMTbZ454Qv6oC72UKNQ7wWE0utSIhnktmf770pzd
 EB2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV45SpzMSr9CSqy9pgPKAaIZvA6GpA+JB4W8IzcP6oU6xAnk+EVDAunKDB5la38fDdlj9iaZEdTSuC6jA==@nongnu.org,
 AJvYcCVQ5mUQT7T01xbHoeU3J0uX6PN8BEozyH2EZw1PPZACpCBsEWcuiU705UqI1nxbh/sHrHS1pV3DsQ==@nongnu.org,
 AJvYcCVc7FtQyt1AuP20ao4/RsE2Nqnk+6pL9JFN4+D1aDYTSQ929ldLDDIHdhaGIjqpdqrz6dffBHXMg51SZQ==@nongnu.org,
 AJvYcCWKtsixI7R4H3KpYjaAqpJH0Kq/YuiF2FZzA4qa7KVzbntANZnGuJppTZXFrPzrALXR3UDCbI2qmT4=@nongnu.org,
 AJvYcCX+XJnTr/8GIdSvutPRgEEIXNVfUCsLmWmj2BKwQKtWZLMht2APCja2RBrSI376mQ8s5VzqiP1BYulAkw==@nongnu.org
X-Gm-Message-State: AOJu0YyF6XjU0Y5oYEA5opDeyzAsiobLhQ3XGLSa3ol0GCVWfj+O5PYN
 ZK+C5495Ov32Nv0d+4RhItqHFkmvfsUN+O7DjQrIi2Yc63LM2OUf
X-Gm-Gg: ASbGncvwdKx0bo9MmOCPo8/Jh5EN+su485JHuAoJVcI8EOGghBLvj3GdnaQ9KR0feFR
 Adu+MFNuClWCW1VmLPqYLHCfDCHt+p1nA35HNtuaDunK1OtvY8e66K64xCb6Ou5DoS2s20ZIgXV
 tAuYwz6lCNrJRXjjR1yUxxwMDqRinByCbm06vdnd1lg5lkFtZ01jNBVnXVSM1ec994xmH4biZR3
 a2xNARPSjKDZ0F7A05+n1qvGv1Yje5Xe8YaTULYJjIRHr5MfBPFv1WFKoJWyn49W+9BhgYcgUzi
 wGZ3kQA2EmS47bB3NumV0MWiyD9ocE1HBFM29lhNyLGTqfSUVbV5IAAz0pA5ytEfbC7Q4jVjObV
 q9I5lZ2BdZaqyfprevTXsXzRmB34Kc5BgkBT8lPwpNrB10BlOnZb6PBZcO/USCZU=
X-Google-Smtp-Source: AGHT+IG55z0YhH4CG1HN/2e/KDzBE2BO/cdF0vNwiMC9M+kWoY+6oiiFIBx1oKoV1PYthQrl/yfMSA==
X-Received: by 2002:a17:907:96a5:b0:ac3:5c8e:d3f5 with SMTP id
 a640c23a62f3a-ac6faf163b0mr480044266b.27.1743107511756; 
 Thu, 27 Mar 2025 13:31:51 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1d64-9300-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:1d64:9300:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7192ea05fsm49891666b.86.2025.03.27.13.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 13:31:51 -0700 (PDT)
Date: Thu, 27 Mar 2025 20:31:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
CC: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH-for-10.0 10/12] hw/rtc: Categorize and add description
In-Reply-To: <20250325224310.8785-11-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
 <20250325224310.8785-11-philmd@linaro.org>
Message-ID: <02CA7571-F36C-4ABB-BEBD-71582944B3F9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 25=2E M=C3=A4rz 2025 22:43:08 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/rtc/ds1338=2Ec  | 2 ++
> hw/rtc/m41t80=2Ec  | 2 ++
> hw/rtc/rs5c372=2Ec | 2 ++

For rs5c372:
Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>

> 3 files changed, 6 insertions(+)
>
>diff --git a/hw/rtc/ds1338=2Ec b/hw/rtc/ds1338=2Ec
>index 8dd17fdc07c=2E=2E56162917c1b 100644
>--- a/hw/rtc/ds1338=2Ec
>+++ b/hw/rtc/ds1338=2Ec
>@@ -230,6 +230,8 @@ static void ds1338_class_init(ObjectClass *klass, voi=
d *data)
>     k->send =3D ds1338_send;
>     device_class_set_legacy_reset(dc, ds1338_reset);
>     dc->vmsd =3D &vmstate_ds1338;
>+    dc->desc =3D "Maxim DS1338 RTC";
>+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> }
>=20
> static const TypeInfo ds1338_types[] =3D {
>diff --git a/hw/rtc/m41t80=2Ec b/hw/rtc/m41t80=2Ec
>index 96006956798=2E=2E55f52d95c51 100644
>--- a/hw/rtc/m41t80=2Ec
>+++ b/hw/rtc/m41t80=2Ec
>@@ -99,6 +99,8 @@ static void m41t80_class_init(ObjectClass *klass, void =
*data)
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>     I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
>=20
>+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>+    dc->desc =3D "ST M41T80 RTC";
>     dc->realize =3D m41t80_realize;
>     sc->send =3D m41t80_send;
>     sc->recv =3D m41t80_recv;
>diff --git a/hw/rtc/rs5c372=2Ec b/hw/rtc/rs5c372=2Ec
>index 5542f74085a=2E=2E98067ad06d1 100644
>--- a/hw/rtc/rs5c372=2Ec
>+++ b/hw/rtc/rs5c372=2Ec
>@@ -216,6 +216,8 @@ static void rs5c372_class_init(ObjectClass *klass, vo=
id *data)
>     I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>=20
>+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>+    dc->desc =3D "Ricoh RS5C372 RTC";
>     k->event =3D rs5c372_event;
>     k->recv =3D rs5c372_recv;
>     k->send =3D rs5c372_send;

