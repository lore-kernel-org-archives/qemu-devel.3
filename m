Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17460C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 11:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGsa-0003Bi-Sy; Tue, 04 Feb 2025 06:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfGsZ-0003BP-KV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 06:14:07 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfGsX-00075j-Tm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 06:14:07 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so4687242276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738667644; x=1739272444; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thiD4j80Mv7xsDwugV4l2c1tMBplcXNdWyHZacUZvWE=;
 b=IvsfoywlkhOVv+HIJtrhdn00izKy61cr4aNIqI5dDW8BhpHze769cR8fqeg0HFS2ew
 AgGlU98S/TixAJyz899wUXOP9VTiI387DlFu0c1BkOwdT/DjkplhZ4aMI4FasNGzUiWd
 RkwVhsZjI56uzKQGH1e8U7i549idj9dyZ0v/dX3GDVsx6L+O7QWMu6krjq8EisuYBeGb
 dBg/opHOnr632jQFE7oa10cPwgTdymLnw1mIWFZH4wqwlDXMju5foOkGnV5ikl2T5cm0
 Rh3VjLrDi4P30wfxyKLKFQbQ2h6mNPE+1rN1xW5F9Dpo9q5GZeP2ZpsRgSVRYW0MNd+f
 C7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738667644; x=1739272444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thiD4j80Mv7xsDwugV4l2c1tMBplcXNdWyHZacUZvWE=;
 b=vMDyGdS182TiSxhSesrgQn69GSEq+j6VhmdLX0XAoZiF1NFIwx2liJqvcFsLW8HC33
 0/azVaccWXyXKmF2cYJhaVw8zxmISbkFoKATNELO41u9Eq5dBjjv8gjdSFrW/clkzBeJ
 KmJQarbWc5akQT659MbE/XDi+zu2Aa3pImmYho1me0ttWqcoBRGGuWIBQoERTkojqGvc
 9tAMplfFHVVJw+ihWRHAWrNIVgkR0jKAOvy11VvMEBmZLpdcFlGEs8o3Lr18HCgWmNhc
 vi/pCD93o2OQxpFLAWzCNwvYL4fvaJw/xsTeYk7Hmf/CKA+BllY4Ws/w1tsLwU6ks0nO
 VqqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRrZzrO1LO4duztpeDeGNhJ2H3eMk7ph1G5k/n44NjT1aMI4i6zxptPsleFlMSTmi+IJUsQ+rVR9i/@nongnu.org
X-Gm-Message-State: AOJu0YxiZAUqj77CACxjOKsDFirAkG38+Qeom6OEEfVg2AC5IKHKUBXf
 uS9JbdOpti29df+IIUf4DsKRaK0tZTWvYu7AW0DN+nONx8+LgKukRryp5IttOjqACUsQ8N+C1Jt
 mw3jXAlO+i4to7XvAe/JWqGtrnv6qHw/XXrw3pg==
X-Gm-Gg: ASbGncu1GcxNGXnX4PRZSPEE9sKaxrYCtSzbSki5D/6WwRE/1WP5G4AQFEwjtLOFzsK
 ZySYAveHupFIgIc3hjOc+sINwyn6dqdzkWxj1V0rJq6+j8daz/xOWE2F8vRijvu7nOlVJGQzPiA
 ==
X-Google-Smtp-Source: AGHT+IGKAxDPYAn2Q94DK/SSOg6Jy3Gb9mjRvvbtWorg28x3CPpX3c6Vhv8DfJrUh5p8nEIPKbx0D9ffY5AS9bNUKKY=
X-Received: by 2002:a05:6902:32a4:b0:e58:98d3:34c5 with SMTP id
 3f1490d57ef6-e58a4b7d841mr15497188276.37.1738667644406; Tue, 04 Feb 2025
 03:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <Z6HklNsu0Mzgh7bC@redhat.com>
In-Reply-To: <Z6HklNsu0Mzgh7bC@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 11:13:53 +0000
X-Gm-Features: AWEUYZl_B3Bj1KsctcUsgZ3kChxP7iL1n1klQlbOVCUPjF0vVDI27NqqpCnoLMY
Message-ID: <CAFEAcA9m8g=K-0RU31kswbNSKWnUqA78KxNkcXEAqR=BhWc9bA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>, 
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 4 Feb 2025 at 09:57, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Tue, Feb 04, 2025 at 10:51:04AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 4/2/25 10:22, Peter Maydell wrote:
> > > On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:
> > > >
> > > > All previous raspi machines can be created using the
> > > > generic machine. Deprecate the old names to maintain
> > > > a single one. Update the tests.
> > > >
> > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > >
> > > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > > index 4a3c302962a..c9a11a52f78 100644
> > > > --- a/docs/about/deprecated.rst
> > > > +++ b/docs/about/deprecated.rst
> > > > @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-=
ml605`` and ``xlnx-zynqmp-pmu`` ma
> > > >   Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for l=
ittle endian
> > > >   CPUs. Big endian support is not tested.
> > > >
> > > > +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b=
`` and ``raspi4b`` machines (since 10.0)
> > > > +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''''''''''''''''''''''''''''''''''''''
> > > > +
> > > > +The Raspberry Pi machines have been unified under the generic ``ra=
spi`` machine,
> > > > +which takes the model as argument.
> > > > +
> > > > +    - `raspi0`` is now an alias for ``raspi,model=3DZero``
> > > > +    - `raspi1ap`` is now an alias for ``raspi,model=3D1A+``
> > > > +    - `raspi2b`` is now an alias for ``raspi,model=3D2B``
> > > > +    - `raspi3ap`` is now an alias for ``raspi,model=3D3A+``
> > > > +    - `raspi3b`` is now an alias for ``raspi,model=3D3B``
> > > > +    - `raspi4b`` is now an alias for ``raspi,model=3D4B``
> > >
> > > This is not how we typically handle "we have a bunch
> > > of different devboards in one family". What's wrong with the
> > > existing set of machine names?
> >
> > Zoltan and you don't want to add more machine names, then you
> > don't want a generic machine. This is very confusing.
>
> IMHO we can have distinct machines for each model, but
> *NOT* have further machines for each RAM size within a
> model.

Yes, this was what I was intending to suggest. Apologies
if I was confusing with what I said the previous time round.

thanks
-- PMM

