Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C534C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KIh-0000KN-Ku; Tue, 01 Sep 2026 04:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x1KIg-0000Jq-AY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:57:02 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x1KId-0007zF-2p
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:57:02 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66f8908a887so650334d50.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 01:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788253017; cv=none;
 d=google.com; s=arc-20260327;
 b=CA3Ob5Bh4vZ0x9BKy0ITR47KA+WEabPB8o6kR8gkOh/+lSCxptuXtDpAa/5xbW2Ahh
 f/x9ARPbfXikoHGjPXLgKZ8gVnTgW3ZMSeb9QHq693Br6ZNJwwajNPYvRNuv1iatZEY4
 DyPfNi9+zF7zO9NzqtNoOwY1fk/RvyDXx5afYeMWmBIglXeZNXQqjDGfQbK0qND+yoby
 iARKtlfLkY9ijkJ+wtWzHvMl0mperB4v4Y+VzPMsUZ+T47jQ/jknW4IqjAYH8gI6aByN
 GZMhfkcOZArgVx+8A3/QJZ7z1Vk3smF8SOMNDJa4hS81kmD8RtNmvXzm+SPooOEbpmIG
 EZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cq8YbfnJO8CtC22hnEedOTnWA4GJcNao2yClP9ojwDQ=;
 fh=11jEt3wyKLw9AVZE63XVeXY/Q3tuaWJzeur7fDLEH80=;
 b=Uxfk/WJpfSOvghs11SmNYQLAeeu06393ZCQ0JvtkllXRssDceSLDhG0LPASn1yjsXS
 I7+rKmPIctSGUvZWe0XACKOl8Mw/ccCoiIQRcMfwwivmuOvkRY29/ob9VCVl9M+buDo9
 6OYTwSuUd33P/88ghdb/2zRUh6tLgf0m3icECeKAuV7oJv7e9tXms28J3K6jO3cI5ryB
 hXNhgUOjxeVKOx6uvQs9KFNy9J4zLAkeZIHK8lz0z0iprNmIptOG1bvSTb130aJRgdiv
 cnlV4Kb5vFHDqC3MDhPe/McppQWFIpPbfBqeLE4t3i1rxK/zN7+mkeafuaboK5T8pvfZ
 ELbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788253017; x=1788857817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cq8YbfnJO8CtC22hnEedOTnWA4GJcNao2yClP9ojwDQ=;
 b=Q02Zjgl4Ve1emeidF80AvUOoMgra9VShAxZJbZkfqyGadfga+NDSaKU83MVkTPqNrW
 gMZrHW+BKvz9Mvqk7lJuXUgUK5+9hxHSnO905mtK6xd6YUI3xgD4AsQD35b/B1DXFO5C
 ERpJo9ifH5eKHVsiB1zM3Ci2hI1rxD2RTJUCIMGXew0NFb8Ox+DiATmpQvOd2OruknJE
 DognZt1pDV7jpYfVXV2/iR5f47nZyA2DuWPfnmMYyIhdIOaCeizKbXEaQMrvKZ35rXzq
 IiyHFq3a+RHtEXEww3TrHR046Xl2nZMQS/p8e8RcNDnADpWC9fhZKAbuun1PsQtKLs+R
 X1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253017; x=1788857817;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cq8YbfnJO8CtC22hnEedOTnWA4GJcNao2yClP9ojwDQ=;
 b=LFgiLPtrsd7G/VOSdUZTPBA970+0ttlV+ywTureZkxngBJHpyHVEw/OGbVTm4mPFqx
 kOylOzFKyMuWzeVM28zyRJ5cg9IYR5FnRRzZ9i0ceMFiDH9gZ4oamNZPzw9DVPvtKaJr
 Wd9D1EHA8PvZpQn53OXL1gFncOtgv7zc3ZiC8ME2Kxl+CXdUHf7TISI91yu5ALxtiHye
 zC4PM8lETFxZNmzAZyNQGilLxw0fRSz4emaGS15x46WI0RMUXyLM1BJXAcrsqgPl7D0a
 AFZs68/VPFOg/UNHJW7I5EQ01iPj8EbaAjXEWx3QOiHf9iG1qpGyP5jSz1lPEQK4GTCq
 QM7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoyFx8iDVH73aEnebuLg9AtiWID2JUMNj3XJjMUGHyOOp6H+J2Y/TxSTr0s1EeWCKnChkl1FV2KphY@nongnu.org
X-Gm-Message-State: AFuF++kS3+1cYk8Z+gBVSdUP87V5nWrPuNd37/qqTEJBSaedR4DUpExR
 wZsaAde3QngC3y7BW0HQDkEG4oA3NGrzaxYMUlXA9xfS0O2IKVBFEhb5dvXD5nJYxudQxaFHEow
 oc4F+tk8Ohn5bqBY/sorbDVjGIiwi1fE=
X-Gm-Gg: AYBFou0HazSxtrzJU3gm/yMVknn6o9/7Yr2rZVi/oKVnl2zwXq4vViRJMYKPlgSAigN
 c+d9/RUyRgrQZiLGJ7mspfGccJSdKF6OBclPfNzsmx0ZWg1OliVt6dNh7DJnzv9dMz1VKG76XXi
 GELWia3hQDylLx0j02ovxONhLqQSeu9MuxQg7cVFudapQBZxoGrIs05Bx6sxJ1yx6Yd/DqsbiHD
 T2Ah//+/a1mdaWxojVsjAjrr21EfdflOpv8X/LYKjMWYzQt6rsfg855uKjSTyXJ2IpiEk3KkRmi
 1hGZYsPN5aEILyKygXRKT/n+GkDdhPljqVolO4QPK3l7
X-Received: by 2002:a05:690e:43c6:b0:66f:80b6:e954 with SMTP id
 956f58d0204a3-66f80b6f278mr2191446d50.42.1788253016861; Tue, 01 Sep 2026
 01:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
 <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
 <ac30bd54b6f1f4e4753638c9e95dbb85d8b81eca.camel@alistair23.me>
 <CAFEAcA9zz60hTDMEMePnc1osis7dPjn5KmSksrWKATpSMc8SHw@mail.gmail.com>
 <3796c9917796a0fe26f2462645d95cc7039539af.camel@alistair23.me>
 <a7c8c510-3391-4ab8-ab5a-c5432c9fb216@kaod.org>
In-Reply-To: <a7c8c510-3391-4ab8-ab5a-c5432c9fb216@kaod.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 1 Sep 2026 16:56:44 +0800
X-Gm-Features: AcwNN1W96iyzyiIRe5Dkw3W0pE6hdTHOcsaf3iHwkrWyoWMAWbyvMiTeSTSAiYY
Message-ID: <CAEUhbmWO70G1sBUX7s5VzGbM-FqhRSirDEn7YbW0T2qKEVwbhg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Alistair <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>,
 Portia Stephens <stephensportia@gmail.com>, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 qemu-ppc@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Troy Lee <leetroy@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Aug 31, 2026 at 9:03=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 8/28/26 02:07, Alistair wrote:
> > On Thu, 2026-08-27 at 12:17 +0100, Peter Maydell wrote:
> >> On Thu, 27 Aug 2026 at 12:03, Alistair <alistair@alistair23.me>
> >> wrote:
> >>>
> >>> On Thu, 2026-08-27 at 11:53 +0100, Peter Maydell wrote:
> >>>> But isn't this just the way the SSI specification is? If we're
> >>>> modelling a "you just have to get this right in software" bit
> >>>> of hardware then we don't need to somehow try to add extra
> >>>> checks in QEMU for whether the software hasn't actually done
> >>>> things right.
> >>>
> >>>  From my reading of things this is a bug in QEMU, not a guest issue.
> >>>
> >>> The fact that aspeed_smc_flash_setup() for example iterates over a
> >>> larger value to send a single byte at a time shows that currently
> >>> everyone *thinks* think function should send a single byte.
> >>
> >> Doesn't that just show that the aspeed flash controller knows
> >> it is always talking to an 8-bit SSI device ? It wouldn't
> >
> > But I don't think that's guaranteed to be true.
> >
> > On real hardware the software could know that it's only ever connected
> > to an 8-bit SSI device, and set the driver accordingly. That seems
> > entirely possible.
> >
> > But the hardware seems to support larger sizes reading [1].
> >
> > In this case the QEMU code is the hardware, and I don't see how we know
> > we are only ever accessing an 8-bit device.
> >
> > 1:
> > https://patchew.org/linux/20220304083643.1079142-1-clg@kaod.org/2022030=
4083643.1079142-5-clg@kaod.org/
>
> On the Aspeed SoC, MMIO accesses (1, 2, 4 bytes) to the SPI controller
> are converted by the hardware into SPI bus transfers. The exact
> serialization is hardware-specific. QEMU's choice is to generate
> byte-oriented SPI transfers.
>
> In any case, SPI is generally byte-oriented, with bits shifted over
> 1/2/4/8 I/O lines. So byte transfer is sufficient.

Correct, one evidence is the spi-mem driver interface in the Linux
kernel for the spi-nor dummy cycles is converted to bytes. Although
some spi-nor devices do support different bit widths other than
8-bit/16-bit/24-bit/32-bit, other bit widths that are not multiple of
8 are currently not supported in the kernel, neither does QEMU.

>
> C.
>
> >
> >> surprise me if the SPI-NOR standard in particular insisted on
> >> 8-bit transfers, though I can't find anything claiming to be
> >> that standard.
> >>
> >>> So it does seem broken today. Making the current function clear
> >>> seems
> >>> like a good step. Supporting different or larger transfers in the
> >>> future is then possible.
> >>
> >> I think the current interface already supports different or
> >> larger transfers. We just happen to not be using that.
> >
> > Kind of. It does support larger transfers, but there is no size
> > argument. So how can the SSI device know how much was sent? Everything
> > seems to just assume a single byte, but it has no way to actually know
> > that.
> >

Regards,
Bin

