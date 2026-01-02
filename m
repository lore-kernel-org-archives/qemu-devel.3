Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD88FA3752
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbhCl-0003vO-9R; Fri, 02 Jan 2026 10:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vbhCj-0003us-PA
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:36:41 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vbhCi-0000fE-7R
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:36:41 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4510974a8cdso6589362b6e.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767368198; x=1767972998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2GgX3NTigfwNoEoZqppz+Oui5hfkoy70/Lp6vP/uz8=;
 b=jxeeTeF9oib+sz3PsVBabApeLhF5zYpC6JClz4yYKWi14w0Cxsp0O96CcwNcu+pUVt
 Tcd18w2/zNFTFWGJ2pigwWx65ZWCQsDsw2hUrzQgy9m035zLjhSyCeHX7qwhqBPY9AiO
 M03b+4iguAnz0eBlb89/tbFsVwyE1ljMh5YLIq+r9gOIzLUfa5ezcW2qBGBVtnLVsdqK
 lOBstC5o6NLcAopsPusEfKkxNo//ulXfSJxIFfS2Yfeu+Y9lciAV0UAfHQsbw0V8OUpu
 PFV42TDnFp4gQOc4bImeU15TsSPrB5+Gf58prbE+7l0MWDDRSKmNFPV3Vm0BeCbMVnOe
 QiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767368198; x=1767972998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d2GgX3NTigfwNoEoZqppz+Oui5hfkoy70/Lp6vP/uz8=;
 b=PW5qiehLkP0cTvPplFidw4FVH/se/mIuHpase1lyKO6yqDyW6sSMcM01gYT0n+qeDa
 y6VHaKAxCiCaoyQDCBG1v8EmMWh3kz0gRn2fKAd/nX53SoO5l0mfLyZSzLqIQTci/aeK
 x6RlFZrd7wft4j2Pk6WFmoIH1Uyvby2ZWQNdsBqKCZatqQ5c/u9v70YvtOzGxqH/OpzV
 +dHhUjI9dhol5VFUmaDnWlpr50c/inJvLo4dzwy4Ai9K+qjHb9gZ+YvO6Ibioyf5P3yz
 VuATQthis7r4zsQX2jruSt0RmE5DfAzDlzgT1Anyy3/+mV4RJoRFSqalSTpEeoeQQLQ3
 999A==
X-Gm-Message-State: AOJu0YzdQ9jfhE2+vznsqA+yqNd0ptSoG4GEuKNRncPKGCZtclVuGP5G
 K461qfsHNVGf/UZCnDKtpZWxeXbDI+6/QkrP36FWbSUNDx3SrYzwENa8yqvBXb1XnLC3hxg7Lnn
 5AABJmmv00z1p99IkLWpPPXgrJcvjQok=
X-Gm-Gg: AY/fxX6BcX4nas+0KWKryKpZ5AHl/q09r0wmAf+y7p52NYsccR+cH7NuFq3wm9phLD3
 kZ3Ta0y6+lj0LG6kuYLBV2tgT4l4ixliG8t71lN04JMyQ+UpCOf+aYmpIm0dDEnkpHgiVaYO/2X
 x+10HovdMUkI7vugQIcYu8L9YYxuq8XoNhvPZ4DtvJak5/qHrC0rKLM+Sdn2MYWMgYJ5GkOCVDv
 0MO2afzGsU66w84SJapHKLDekxMxfjd6B2HIW3CNQtWNThxb9zFlKIsQGpJnUQtFzu03w==
X-Google-Smtp-Source: AGHT+IGIRp8MUy/njTm1uGCSqgmoKJYtblSVjJVhYCU4Lvs8b3mayf7eP3hCrTDcA21NsAqKqS1REzgndMjzepWPyMA=
X-Received: by 2002:a05:6820:7186:b0:656:9202:58ca with SMTP id
 006d021491bc7-65d0e9f4a9bmr17067002eaf.3.1767368198261; Fri, 02 Jan 2026
 07:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
 <CAFEAcA-VYhtvXK5tyVJWfskqqKFim43DsKfWrpaMxteWueR6aQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-VYhtvXK5tyVJWfskqqKFim43DsKfWrpaMxteWueR6aQ@mail.gmail.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 2 Jan 2026 16:36:27 +0100
X-Gm-Features: AQt7F2rPTFgE6THA1Jnof0h9TiDNlMeZSVRYfpNT_LPODpJusb_MAzWd_bOFMBM
Message-ID: <CAN-aV1FsbAp3JrqoPgz+c4ORayBjsGxTLWOkDMc0WyE2nD-aZw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] hw/arm/smmuv3: Add SMMUv3 sysbus support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oi1-x22f.google.com
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

On Sun, Dec 28, 2025 at 5:59=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 19 Dec 2025 at 22:25, <ruslichenko.r@gmail.com> wrote:
> >
> > By SMMUv3 specification it can be attached either to PCIe Root
> > Complex or regular IO bus devices. However, current
> > implementation only allow to associate with PCI bus.
> >
> > This patch series add support to use SMMU for sysbus devices.
> >
> > One usage example implemented for virtio-mmio, which allow
> > devices to perform DMA operations SMMUv3 with address translation
> > and isolation.
>
> If you want virtio devices behind an SMMU, why not use
> the PCI virtio?
>
> The only SMMU sysbus requirement I'm aware of is that for
> RME we will want to have things like the GIC do GPT lookups,
> which is most conveniently done by having them route through
> the existing for-PCI SMMU, rather than by having an extra
> SMMU just for them.

There may be several reasons for supporting SMMU on sysbus:

Some embedded platforms may not use and don't want to include a full
PCI subsystem, but still want IOMMU isolation with virtio-mmio.

The other reason is to emulate existing SoC platforms. The model may
need to be closer to real-world HW and SMMU is widely used outside the
PCI subsystem.

One more reason is Remote-Port devices in our case, currently ongoing
development here:
https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg02121.html.
Those are platform devices which are emulated by external services.
These devices need to perform SMMU operations for DMA transactions
when they are bus-masters.

BR,
Ruslan

