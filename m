Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24A9C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 01:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRhYV-0007RV-Bk; Tue, 17 Jun 2025 21:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1uRhYN-0007Pz-4f
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:25:28 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1uRhYG-00051O-V6
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 21:25:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-311ef4fb43dso5041524a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750209917; x=1750814717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcKJlxotYYNzqhm17rsomT0rEkiw74pK5ylA3za2Brc=;
 b=hRKdtrvq4/OtKLS9u+PjY2gENLLUr6DL+h/A+ChlQdahVFkQZ91fUWhsafKHg7Sftw
 CbHEOwdp9tbf73RUnjCcOHxM3VT8aJrq+WlRPiIv/eyWRTalsJCeFXNwPPSRdsqBVBK7
 ZMhWclA/0iNPnbyfBKabHZOJOgPk6WnW2WihrbNeCt1zuhSO8cLa6dMQG/Y3MfiTOe3q
 2JueIuXphqWtcuIKLDqpMxsT9yTvw2HsT2KtV/F53yQZvwy28N+atdepzV7zuPE33+vY
 I8cgu5qxfVftQh2bwkke/Pn/fF/VZ+Y6wDaIfmRoFY37VbK0b+N001SdOabcxFO2zzIm
 EezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750209917; x=1750814717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcKJlxotYYNzqhm17rsomT0rEkiw74pK5ylA3za2Brc=;
 b=G7LLB9pGrJtOPPnxBE8n+B9xpJbK30Jb4t9i3nsnsIMZKH/5IBE6J06KUVmvQnJQB9
 dfdThbBcQuE/DwLZElF/gsRf05eHCvFh7zOBq8KItpnKxrbcBI3115GKQ8XeHKWUuw4+
 ab3WI6Ed1HFH5RcJaZbrYMOTWPmsPz4V3cy7NP+rVJIKiz5VAqlDuBOuENjnJV2fakEN
 aFmznOCRGXigzqhgEhLnIC0NZ314VCLXTubMd8Nbq1Wr9Zx2yjgY64QYkkTvLeuxPPRv
 8g+Ql3kSs9XTyUhc4dBzNlIDESu9vjvwPkBl2IxUNjpm6a8hGQjlPH+xFDjRzu1+khsq
 h9DQ==
X-Gm-Message-State: AOJu0YzBvKFCAl6QVZN1ARY/XnN3/jx1DHHdSRh/4vyZPAv1++ZRVrAY
 z4z0tCkflVYn4kiFDZ1FD18YBDO+Fu8VfJ6wAmuSDcDZkUpnRCRr/rx6V0i/y9UM4pkqhVS48pu
 DJZE1fddih0qTWk2bLnLGj0ymzXLV87q1AfbZaWiZ
X-Gm-Gg: ASbGncsoX+wNPdhBKdMvhmFpTNA99ZorMskiQt62wOYvyS/UrZuYdtUB77+zbX2kDpX
 orlZ25sTsjDDnkJ6dBkSbHsXD65CrmBjx/Duno+nk+jv5Al7WOZyFo9FQLU84FP2DqRUMif0S8S
 w4EI29MIwZO5oYBqD03ViEPgJIvA98v5ATeg9EHFEqwk3YewXkGFi7zVObV2TOx10BEkYAjSDU
X-Google-Smtp-Source: AGHT+IFH6t3RbREEiBbrFpl6K2pnX6ivmIbfyco8qswlN/4jzxCCxeMAtg1LzgGkAvBrB87Jbo/x9EWbkaAjeMIyhzo=
X-Received: by 2002:a17:90b:1f92:b0:311:e8cc:424e with SMTP id
 98e67ed59e1d1-313f1ce543dmr21814795a91.24.1750209916647; Tue, 17 Jun 2025
 18:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
 <23deafc7-d832-470b-8d8e-aea0125d756f@kaod.org>
In-Reply-To: <23deafc7-d832-470b-8d8e-aea0125d756f@kaod.org>
From: Joe Komlodi <komlodi@google.com>
Date: Tue, 17 Jun 2025 18:25:04 -0700
X-Gm-Features: AX0GCFvq4VR_hFdnvIwoJysTOSa7grY78aoZUC42NOj6kk5zX4qiTtCwvnI5G2c
Message-ID: <CAGDLtxti58hRfOjtr5RJuQE93+UWMOLhfM+YivwU4UZdgXRJfg@mail.gmail.com>
Subject: Re: [PATCH 00/19] i3c: aspeed: Add I3C support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, venture@google.com, peter.maydell@linaro.org, 
 steven_lee@aspeedtech.com, leetroy@gmail.com, jamin_lin@aspeedtech.com, 
 andrew@codeconstruct.com.au, joel@jms.id.au, qemu-arm@nongnu.org, 
 Jeremy Kerr <jk@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=komlodi@google.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi,

On Sun, Jun 15, 2025 at 11:49=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:
>
> Hi
>
> + Jeremy
>
> On 6/13/25 02:03, Joe Komlodi wrote:
> > Hi all,
> >
> > This series adds I3C bus support to QEMU and adds more functionality to=
 the
> > Aspeed I3C controller.
> >
> > This implementation is a basic implementation that introduces IBIs
> > (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't su=
pport
> > multi-controller buses or HDR transfers.
> >
> > First we add the I3C bus and controller model. With that added we exten=
d
> > the functionality of the Aspeed I3C controller so it can do transfers
> > and handle IBIs.
> >
> > Next, we add a mock I3C target. It's intended to be a very simple targe=
t
> > just to verify that I3C is working on the guest. Internally, we've used=
 it
> > on Linux to verify that i3C devices can be probed and can send/receive =
data
> > and IBIs.
> > This target is sort of like an EEPROM, and it can also send IBIs upon
> > reception of a user-defined magic number.>
> > Lastly we add  hotplugging support. The hotplugging doesn't do anything=
 too
> > complicated, it just adds the device attempting to hotplug to the bus. =
It
> > is the device's responsibility to hot-join and go through the DAA proce=
ss
> > to participate on the bus.
> >
> > Thanks,
> > Joe
> >
> > Joe Komlodi (19):
> >    hw/misc/aspeed_i3c: Move to i3c directory
> >    hw/i3c: Add bus support
> >    hw/i3c: Split DesignWare I3C out of Aspeed I3C
> >    hw/i3c/dw-i3c: Add more register fields
> >    hw/i3c/aspeed_i3c: Add more register fields
> >    hw/i3c/dw-i3c: Add more reset values
> >    hw/i3c/aspeed_i3c: Add register RO field masks
> >    hw/i3c/dw-i3c: Add register RO field masks
> >    hw/i3c/dw-i3c: Treat more registers as read-as-zero
> >    hw/i3c/dw-i3c: Use 32 bits on MMIO writes
> >    hw/i3c/dw-i3c: Add IRQ MMIO behavior
> >    hw/i3c/dw-i3c: Add data TX and RX
> >    hw/i3c/dw-i3c: Add IBI handling
> >    hw/i3c/dw-i3c: Add ctrl MMIO handling
> >    hw/i3c/dw-i3c: Add controller resets
> >    hw/i3c/aspeed: Add I3C bus get function
> >    hw/i3c: Add Mock target
> >    hw/arm/aspeed: Build with I3C_DEVICES
> >    hw/i3c: Add hotplug support
> >
> >   hw/Kconfig                            |    1 +
> >   hw/arm/Kconfig                        |    3 +
> >   hw/i3c/Kconfig                        |   15 +
> >   hw/i3c/aspeed_i3c.c                   |  261 ++++
> >   hw/i3c/core.c                         |  669 +++++++++
> >   hw/i3c/dw-i3c.c                       | 1881 ++++++++++++++++++++++++=
+
> >   hw/i3c/meson.build                    |    6 +
> >   hw/i3c/mock-i3c-target.c              |  311 ++++
> >   hw/i3c/trace-events                   |   47 +
> >   hw/i3c/trace.h                        |    2 +
> >   hw/meson.build                        |    1 +
> >   hw/misc/aspeed_i3c.c                  |  383 -----
> >   hw/misc/meson.build                   |    1 -
> >   hw/misc/trace-events                  |    6 -
> >   include/hw/arm/aspeed_soc.h           |    2 +-
> >   include/hw/{misc =3D> i3c}/aspeed_i3c.h |   22 +-
> >   include/hw/i3c/dw-i3c.h               |  201 +++
> >   include/hw/i3c/i3c.h                  |  277 ++++
> >   include/hw/i3c/mock-i3c-target.h      |   52 +
> >   meson.build                           |    1 +
> >   20 files changed, 3735 insertions(+), 407 deletions(-)
> >   create mode 100644 hw/i3c/Kconfig
> >   create mode 100644 hw/i3c/aspeed_i3c.c
> >   create mode 100644 hw/i3c/core.c
> >   create mode 100644 hw/i3c/dw-i3c.c
> >   create mode 100644 hw/i3c/meson.build
> >   create mode 100644 hw/i3c/mock-i3c-target.c
> >   create mode 100644 hw/i3c/trace-events
> >   create mode 100644 hw/i3c/trace.h
> >   delete mode 100644 hw/misc/aspeed_i3c.c
> >   rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (63%)
> >   create mode 100644 include/hw/i3c/dw-i3c.h
> >   create mode 100644 include/hw/i3c/i3c.h
> >   create mode 100644 include/hw/i3c/mock-i3c-target.h
> >
>
> This lacks a MAINTAINER.

Ah, right. I can add that in v2. I can add myself to it, is there
anyone else who should be on it?
>
> Could you please provide functional tests ? some with a standard I2C
> device attached to an I3C legacy bus too.

I can work on that, probably v2 or v3 depending on how long it takes.
>
> Are there any other stakeholders interested in the I3C to get feedback ?
>
> Have there been any changes since:
>
>    https://lore.kernel.org/qemu-devel/20230331010131.1412571-1-komlodi@go=
ogle.com/
>
Nothing too substantial. I decided not to upstream remote I3C since
it's unlikely it would be useful upstream.
I think there might be a couple bugfixes in the DwC controller as
well, but I don't remember off-hand what they were. If there were any,
they were all minor.

Thanks,
Joe

> Thanks,
>
> C.

