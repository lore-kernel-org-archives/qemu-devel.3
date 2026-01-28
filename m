Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E69D3F08E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8M2-0007RX-72; Wed, 28 Jan 2026 11:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vl8M0-0007Oa-EE
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:25:17 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vl8Ly-0007sq-Av
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:25:16 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79478ec4cf1so22845617b3.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:25:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769617512; cv=none;
 d=google.com; s=arc-20240605;
 b=AghfrX+X1wK/1VmBtTGd5xuJe9Yqx6Npdc9Q+cJxeuBxJ0UNZSZLSYWC/61K7/gjIh
 O8HjJjkyr8oA99tD3pgLV6Ko5wHRJkiNfrh4D/cmnXHTGA3djfTZh8/PSBIK7RsCQDkx
 O+vDJYHImHCsoEmTSqoaHlcQlIaLzG4avB98q9olb6XMm9CPi93Jp5WkaesQ1ebi/f3G
 iuUH5/4GkCgO7OKRAnU/BKd5DlJ4EHbFAc8wt34yBmTUyBTOlszgmyVd/8gtAnhNlEt2
 8qBHoLpNSvIOa18YGW0YTrLx8zkToOCumCf20CTszQuS2kNoVr50bxB1XdNwfryA+DxE
 kWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kNWW//Fcg/Ik+gcxV3m4+UymViexcY5IqHxCf4R+Ytc=;
 fh=gWl+z12zAse6isZjSG61pfxc0nkk+bmqopTZHf+6P04=;
 b=jlFydWl9jbsxTv2/UdAu5lplwno9sxcvCc/+nfC5uV2WzG8e+fxjpde5LF82r32X3E
 9bvsvaYsDyzKiOwbNZQy5vNvjMfePkDGZTDqRADOKG6c6mDfmUpbWqmRjazkVxRWohEB
 GPK1IvWhqzfSIn69Px2Yt6RyBsf5jZxsRd2AzZ9OdAMQigp4nW0B2iIyrsGDTcwLnn4R
 8NbBE2f7r3doMxq4N4F2cRvgdKXqv7Fjv/GpZXa67r/uCkT4vGEGNX6/WRbFY55dnAGS
 FElSXMjoSI7IkJNIYkQyciL132ny4SCaedwC3joizLm2NUncNi+AnqJoO7uvOV7y4ZhT
 /Pww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769617512; x=1770222312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNWW//Fcg/Ik+gcxV3m4+UymViexcY5IqHxCf4R+Ytc=;
 b=du8MjygBDRSyxaxbwwsIkq3RE7u9G/V7VqIiGe1XRfb+Bb7qmckjYsssenU3TA8eKM
 hZiRTPgAi35+m8pcT5ZuLD36hC52Gv+flJAJ5apaiZ2xMuRd+7JdUuEM4jDyddulV2ot
 CA4Z1i2nGv7fErGJSQX0Jxs9clJHIKdFyoZV8iWV0EiV/7qaDftldoj09rVvYdEMUPhV
 WAH9QIbM81Z46JHebNldcJyOOJlgX1SgimjsOdI8QeDnbcEL7JKV/TBaRa1i68rsUAI/
 L+bnNUFBof6mju5SsrqsK+Am1dnedNlLZbCoi7lgfZynvAq22H83QUncZOwcBS153Zkd
 vb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769617512; x=1770222312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kNWW//Fcg/Ik+gcxV3m4+UymViexcY5IqHxCf4R+Ytc=;
 b=KZAkKxrj6xRAF7JRSZDONyYcmnO5pxSc93YuOoXse2vzs8YPKLGohb2XnFscrjrnBA
 uhMMeEDEBg5+C67tlnr/3pCKzKYXCaaNwd945Q6JEvnljcr8aXLaQ6973V8IhEInPCL0
 +obS5xGHBAXLETfyV9XRpDQbCdNQPKVEO+dVL3zh8B7kPXuQplIfIVoBHNPosXw7p8mP
 l+9pjYOISbp8u6WIes88h9DQ1EtuBCFmoKb6WMO2lYFltjKGNHrOZ4aHt6KcianG/uVE
 QAViW8IbEfxum+KVt5j9dcgNUld1SCytQdG1Xzvfs0K9YY7CIHSehM/nUhId9q7L29B8
 5PRQ==
X-Gm-Message-State: AOJu0Yxil4gt7Qoxk89sFuRz03M9xjY66A2JQepG6OBGQlTYGac5XO5y
 APphyDmlonOo+IOF2trEVtm3EgZUOxEzDabnaqH7+Q+X1uWY0Q8UTp8QVGCzmF2udUnem5A1+Hk
 BhbhSwpW27Ud7zMu0jkMuRMALLOKFkoZPJWTtAmtHOw==
X-Gm-Gg: AZuq6aIDzG3ALLQJ0pKL0UVDnIyDtRmRE210LTeFfYRxnbGvvgjqsv3Lkl9HKnSWtkJ
 F18lvv9snY2TWZNU/b7JFSjyXKZKIOsOXEJDN1ksD96a0h+xHtXuEQZ+jrLtimPxo++Hx1O1pg1
 8nDpHvhofZTXzDNesJea2a2eSLmURWmey8jS8G0qNdbYbA4jShNFk6DyOrcxpNqPKcmM1k5WlZF
 fKJqzyr/gZbOzKozAPYmBKiQuvHGrJDkLWEcy7LeevmxeJGfIfxPvolGO6LvwUncsrDnQ==
X-Received: by 2002:a05:690c:a789:b0:785:fe77:ccce with SMTP id
 00721157ae682-7947ac01fe2mr37317007b3.44.1769617512100; Wed, 28 Jan 2026
 08:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
 <20260128105839.3487840-3-alex.bennee@linaro.org>
In-Reply-To: <20260128105839.3487840-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Jan 2026 16:25:00 +0000
X-Gm-Features: AZwV_Qj7SJxIJqr1FzwkHSVhyP-xonhXYQ2yVYk8RXvHb-_qxfJbukHXBwlNIh8
Message-ID: <CAFEAcA_sT6pGhXPpgaEqkJOVuAj3e1KMz_AP6-MZ6YP41YvoRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/functional: migrate sbsa_ref test images
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 28 Jan 2026 at 10:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> As the builds in codelinaro.org are going away migrate the binaries to
> share.linaro.org. As the hotlinks don't encode the filename we need to
> explicitly tell uncompress how to handle the files.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> @@ -54,15 +54,11 @@ class Aarch64SbsarefMachine(QemuSystemTest):
>
>      timeout =3D 180
>
> -    ASSET_FLASH0 =3D Asset(
> -        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-r=
ef/'
> -         '20241122-189881/edk2/SBSA_FLASH0.fd.xz'),
> -        '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a=
5')
> +    ASSET_FLASH0 =3D Asset('https://share.linaro.org/downloadFile?id=3Dk=
yoMLGC9zXa4oA7',
> +                         '76eb89d42eebe324e4395329f47447cda9ac920aabcf99=
aca85424609c3384a5')
>
> -    ASSET_FLASH1 =3D Asset(
> -        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-r=
ef/'
> -         '20241122-189881/edk2/SBSA_FLASH1.fd.xz'),
> -        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412f=
c')
> +    ASSET_FLASH1 =3D Asset('https://share.linaro.org/downloadFile?id=3DD=
j1HRXnDnKtU6Nj',
> +                         'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb=
59ab7d93e5f0d412fc')

Is there really no way to have a human readable filename here? I know what
edk2/SBSA_FLASH1.fd.xz is; I have no idea what
f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc is
going to be.

If we can't have useful filenames, can we have comments saying what
the filenames
would be if we could have them?

thanks
-- PMM

