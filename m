Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221F0C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 10:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdoAT-0005ub-5L; Fri, 31 Jan 2025 05:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdoAQ-0005tk-Rk
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:22:31 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdoAO-0004bV-7Q
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:22:30 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e479e529ebcso2055169276.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738318947; x=1738923747; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhze54LAvnD5BaSR+1RBKDZaJICorB1PDyxoe5P2oBo=;
 b=UKDVFOtyLi13FlYFjoQOn3i8eIC4XXcIMuZ4eUyLo//VQyp6KrX0M09Mkx2YWreo7V
 LiIqbA06BXbv7GBNFUmtKojh+rq2LC9SQN59ZKpjIP+oz3HkqcsHswoYvH4F8dl9T1CZ
 TfBCm13ee1KP3UHDSYTVgwSBuPJxbTZa2pOmEa56n3uRVHF5SRzMxkKmXoNSLzqbF5wD
 sPM8EUU4eE5Vv5vMeVWAPjpk28uXuuKQp0XAmZO7OW6FJvgS5sOKBrAFjC0eEp7ft6oI
 AMJ2TppArHTuIYT8KUKBO6hgFqMIhk7g/5GDTuz6rr8N28geo0AfZJWxwefZvuoS4blO
 N/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738318947; x=1738923747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhze54LAvnD5BaSR+1RBKDZaJICorB1PDyxoe5P2oBo=;
 b=L4sdGIaEs5ByNm0Temy5TXalHHmfvJrkbBNJoJmIkHtsCh0sVJj0ZUS1VPKvbzfs0N
 OOGAp+pg+KYI34gGuzp2/Fch0LM5J4YVjKXGUgyhwIuc8BuoZFtgt/w4wrFleHWtZruo
 jsmM/iJSA8olffEP5RR4jSSXJhqGM4BSeD/010u6zFlx+kOc7PTmnaay9gVgnQoN+Ljr
 UvMVX+zbwy2Qke6cufUn1HDxLZI1+MlO7yMHdmq4yH7iD2Kng2GJA2/jbsenFZWzluPk
 wxL+i9tfBPHn3h+iygFvNDJHO2OsHpjXcUZQjFNt9CdFq/gfuA8DoeShjiwj+CFKltui
 IZMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV82yY1kK9wpTgkJo0CngEGZzGp2lOBUhhlEs8DFjtPTKGkBwN4NlGAfdtpmNump4F+t+BITyiYx4AD@nongnu.org
X-Gm-Message-State: AOJu0Yz2FHF/NZmUX1zrciie+OwKfuQvfts2C7gS5Fe0y8QvBWbpBw59
 JUVJtQiH2urdkxlM+8Ka3LqOiyUxHA2crYRPMHCz/App5t5h61zgVIvEpYBDVKUC+eu9QK9fGcf
 NKczh32YyyEvniqih8Hx8vhUIYGXE3JGeNtAEkA==
X-Gm-Gg: ASbGncvQNk01UgXDZinMG52nvcJ/mrsAP57xn/fotim6eryqtPJE2yNAeLHg7rjAqKR
 5gMv1jhyqLXxn73CyU9K+K0W8hJpgsJnU6i47IlJpztx5arGrBkKaSdXGfyy7Hepf6gxl7cjDSQ
 ==
X-Google-Smtp-Source: AGHT+IHsix4SdpGExCdxrlzzxAH4PC+VeyjAe7oXb8AIvaIrDPMJaPlOaM2I70TmzItLn08jhSPcf0EkHG5uqRM2QoU=
X-Received: by 2002:a05:6902:200c:b0:e58:32b4:4878 with SMTP id
 3f1490d57ef6-e58a4bd8c38mr8552598276.35.1738318946798; Fri, 31 Jan 2025
 02:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-5-peter.maydell@linaro.org>
 <25be2867-6736-442f-989f-2ce1f2745c05@linaro.org>
In-Reply-To: <25be2867-6736-442f-989f-2ce1f2745c05@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2025 10:22:15 +0000
X-Gm-Features: AWEUYZntnTya7I_VZbaqhA7GRfEuUUnfHD7_BxtY9q8Q_4riolQqRMTmmcqUNkI
Message-ID: <CAFEAcA8uj8=Z01e2uGQ0eJ7AUfvSPLwORVk5NEqVSDk-Gz7U8g@mail.gmail.com>
Subject: Re: [PATCH 04/11] hw/sd/omap_mmc: Convert to SDBus API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Thu, 30 Jan 2025 at 22:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 28/1/25 11:45, Peter Maydell wrote:
> > Convert the OMAP MMC controller to the new SDBus API:
> >   * the controller creates an SDBus bus
> >   * instead of sd_foo functions on the SDState object, call
> >     sdbus_foo functions on the SDBus
> >   * the board code creates a proper TYPE_SD_CARD object and attaches
> >     it to the controller's SDBus, instead of the controller creating
> >     a card directly via sd_init() that never gets attached to any bus
> >   * because the SD card object is on a bus, it gets reset automatically
> >     by the "traverse the qbus tree resetting things" code, and we don't
> >     need to manually reset the card from the controller reset function
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/hw/arm/omap.h |  1 -
> >   hw/arm/omap1.c        | 10 +++++++++-
> >   hw/sd/omap_mmc.c      | 30 ++++++++++--------------------
> >   3 files changed, 19 insertions(+), 22 deletions(-)
>
>
> > @@ -643,6 +630,9 @@ static void omap_mmc_initfn(Object *obj)
> >
> >   static void omap_mmc_realize(DeviceState *dev, Error **errp)
> >   {
> > +    OMAPMMCState *s =3D OMAP_MMC(dev);
> > +
> > +    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, dev, "sd-bus")=
;
>
> Why you don't create the bus in omap_mmc_initfn()?

Good question. I think I was using hw/sd/ssi-sd.c as a guide
(since it's the only other device that directly creates a
TYPE_SD_BUS rather than needing to subclass the bus), and
that put it in realize. But it's probably better in init.

> Anyhow,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

thanks
-- PMM

