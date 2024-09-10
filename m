Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E9AECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 10:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxw2-0008Km-6J; Tue, 10 Sep 2024 06:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snxw0-0008IM-1p
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 06:17:20 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snxvx-00039r-0H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 06:17:19 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdbe4728so5384687a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725963435; x=1726568235; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adMeFvNai4sKgpq/l2xsJ3FjCurUnP6RSssiorm3uis=;
 b=JaE+v8sPsD1qauisOz2HK2DX4iaiPhxLL1CiSJspcLdQXgX1i9egvs0FxUcVuG67OU
 K//I6ROjz1Ppz5eH6wtdzXRkIjTCK9TJ1J9zYLyEgz+KXYL9d7nh5HnPv8ge6tfN+MRZ
 PhR+Vv9vPIY90WW4gqoCBZfioxTUbIm1Gt/vUakOILpH5KIu0obouhOYAHiA3tF7Vtkv
 pwg7uH2VCI/ntW84ub5sBD4MnATpnxg/mZpog66rZnlduAGtorHhoS0Oj2HEJJgAZMpS
 QqqHRKT7oMBq7CKcpPyqgadKWdh1nkKT4QfNS5n5p8X1KRjkxlswTVxkty/u76yd/syo
 7Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725963435; x=1726568235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adMeFvNai4sKgpq/l2xsJ3FjCurUnP6RSssiorm3uis=;
 b=gqZT/dTAQejuGThc+86bqdaRal6lxsxd3SdTTuQYqPadZgu8WTdNjDfSBoSi2BINj7
 WlxQSwncyJZlpaSp1OpnfdkASu5O4m9ZXW3hLxabvlGqYcGndv42SMQV/hnGy0obWDzN
 vi5VtkDgMr10C3Nn0CZt/7RTxUrCSVVjbPtV2tB7zJB7icsPwG3UCQgGlT7DkO+DPgIV
 Fo7m3guSXM+0vVRMm4LbTqi6eJkm5ll+ZojzLAMcF6Tcrt90aAF01NvL6AWG666JkU8T
 UXkLVVSMBtVznUIJdR340wiK4ewuY2lKX+ne+/wieK2i4Hf3q44cvlpgzaGh4ouJSj+p
 yxIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIH9ckZlzXX+HFzcZ6Fd1Rkcgf0OKw3lg92281rU0MV0dzDN6iL0SMdedQ//SwwdC9C864U7PTZQBI@nongnu.org
X-Gm-Message-State: AOJu0YzesGg9CO+xlsGU3RHFS+hnG12nGo1r1MRrCEcgH2Q1pkZmZpxh
 6f+lri/Flpx7kTCQCa4+XXGJ11gDJPyL/4KLfyglDkdbtuoapGHIBbQYDx6a+IB9yAfL/Fd5foZ
 EsVHXK8B8Q42266xQBcdEIIQwsv0yB/AT8IjoweWatO1imFvu
X-Google-Smtp-Source: AGHT+IHJ6Y3cXNvdDGySCLNjF6wdp7Fn3jjZrNwE7udoRmxQTb/Sgvp2km9Wk5IPCJkpjt4uKusgfYFgtw576epymz4=
X-Received: by 2002:a05:6402:530b:b0:5c0:b33d:5fcc with SMTP id
 4fb4d7f45d1cf-5c3eac09850mr6486603a12.20.1725963434666; Tue, 10 Sep 2024
 03:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
 <3f4ce380-0c0b-48ad-9752-c72f5aeac754@roeck-us.net>
 <CAFEAcA_ETkWY=AaPWti8KwO0awdxWqkO4CLAwxaGVr+i4yFz-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_ETkWY=AaPWti8KwO0awdxWqkO4CLAwxaGVr+i4yFz-Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 11:17:03 +0100
Message-ID: <CAFEAcA9==ZeDbhod1zs6JNftvT3owjQe17VQ3Y_5iPN01Oh3-w@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 9 Sept 2024 at 16:02, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 9 Sept 2024 at 15:55, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 9/9/24 06:40, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi,
> > >
> > > On 3/9/24 18:06, Peter Maydell wrote:
> > >> This patchset removes the various Arm machines which we deprecated
> > >> for the 9.0 release and are therefore allowed to remove for the 9.2
> > >> release:
> > >>   akita, borzoi, cheetah, connex, mainstone, n800, n810,
> > >>   spitz, terrier, tosa, verdex, z2
> > >
> > >> The series includes removal of some code which while not strictly
> > >> specific to these machines was in practice used only by them:
> > >>   * the OneNAND flash memory device
> > >>   * the PCMCIA subsystem
> > >>   * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
> > >
> > >> thanks
> > >> -- PMM
> > >>
> > >> Peter Maydell (53):
> > >>    hw/input: Drop ADS7846 device
> > >>    hw/adc: Remove MAX111X device
> > >>    hw/gpio: Remove MAX7310 device
> >
> > max7310 is a gpio controller which is at least somewhat compatible
> > to pca953x. It is used on imx6qdl-sabreauto, and also instantiated
> > by Linux with the INT3491 ACPI ID.
> >
> > Is there real pressure to remove support for such devices ?
>
> "git grep" says the only place we use our max7310 device is
> on the "spitz" board. The point of removing all those
> elderly Arm boards is that all this code is ancient and
> unmaintained. If we were using this device on the imx6
> boards I would have kept it, but we aren't. I don't want
> to keep old, unmaintained, untested, dead code in the tree.

I should clarify here that if anybody is actually using
these devices with some other board model today, then
that would be a good reason to keep them. The situations
that I don't think justify retaining them are "in theory
somebody could create this device on the command line
with some other board" and "some future machine or SoC
model that we don't yet have might want this device".

thanks
-- PMM

