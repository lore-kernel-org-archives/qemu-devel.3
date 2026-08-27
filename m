Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C139C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXjy-0001ZD-Rw; Thu, 27 Aug 2026 06:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzXjx-0001Xi-9P
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:53:49 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzXjv-0001pj-ER
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:53:49 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-836c718715fso20779987b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787828026; cv=none;
 d=google.com; s=arc-20260327;
 b=HF3h5ANraY91f5kQE8HjdrNQef3utWda2pVCtAac8/4Ef2iFejwzLONc55hNQqD/kf
 FebsJnyxYL2n0KcTCkk/YUCDH92dBQ/kmu6/g55m8FjPZBERMxHdHoCwYOURDhiP9D2x
 /9uih1d25yPvZNRgZzI47V7aatTkKNJGatHEvYRZFjKzsqSfiak0LABZ/IbTKNGx3QTW
 t7R8hz/9w6ne1sN0Eyxh2jUcaKBYP3b8fuAT351IGUHD61hlJTsRr3bZdaoATOrhb02N
 Wkkl9RyKuq3LiiuJPs0qm8rttYl//DrFesWrP9tkgPYRRiGoTsvv+PUKJM0Bs8RHUjIb
 EWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7TUcKTyYcB4X+tUX4hV0sfuwd8gnmpa0hEZ32GqGZ2c=;
 fh=dOeKOk9xtK3ccMmh4EDMoXkvf7aM4FZV+MeO3kmL+D8=;
 b=g1qcr8X+MJPHDW2Ckxdv6BJ7PPZ+N3x6MttakBkUkAJ7yMiPgByuYVq2TjgqVGKgWc
 /PqaFFs6m3f7DtSDE40KihN9JJNCWoS+2DtgzGMfW+SamnaJh2sttL3YqlzTpPP1rL1X
 JuULWZdDm9VUsCldsWc1pV/tYVeh/fQdxnhT8+PN5KJGXDCaBVi7ZhHVPddtdW7wjFff
 XgG2ZwIa9eViicZkAnYIbK3npBScWdPGANAVQxWL4TcwQJdbxcLVrcMNpXCyrk8otvIc
 4qZSWwSbvjh/YMc5fTdeXBq4ES1rCBbLcR+Yx+7CCGbE+6sklEFXDMEpel94R29mIddr
 rNVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787828026; x=1788432826; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7TUcKTyYcB4X+tUX4hV0sfuwd8gnmpa0hEZ32GqGZ2c=;
 b=jKPjEqFKV/WiN8VCWG21rZgpVc+mCRINDMCAIitcsU07C5+8+ZpFPO/FdVahU1QL1O
 vBBip17NSy39EMV4CYTUaz482tc8lo0yXwKAHhO8cRLx0/foKm8m/wAnntSwVuvsjBjZ
 gF3/SpuMQY7J6L/PKzmgaSX6fpDc5aoODAuhBc0ONyNHwVfXwWCDtn6ni7ZP4dA8KAQu
 Bel7fJupKFZUtH+W533zi8Mk4tEGmuh9fHwRsQlMjohwWkMD4n81pAX0YWDlKQFpF4fA
 Ut9E4l85r22zH90UhUYNc7UXWzKnzB9Dnr+bWYChsQKyu7j0SJl0qobzHOWmzqlY1Aw+
 yOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787828026; x=1788432826;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7TUcKTyYcB4X+tUX4hV0sfuwd8gnmpa0hEZ32GqGZ2c=;
 b=s6eK0awTfB+EKuoXArSXYvRyn186DdzdM5hWwlkC+8n1sXKeUov0ROPii8b7sWRJc4
 9pm7JMcH3O5yhqvG8WPt2igqSDg4Y5V+nc7/ApadvPh4cTuRCa/NR4P6hNKa3FMhP9S/
 UOySVNu4xkwZemulPWnu115Pvtg35IF4aQmteMhI7zeiTrCR5Fb5lwk4oOMIBPTeCBih
 AKmUPjZWxdUz+LU+4xRwVeMk+4U6Qdp146x1DZFzN4LNY572Puw02CCCIMKA9w087We8
 oCwneaEk2WM/QRoLSw/QG650zVjBHLArbBlLmC3K8RKPU/gE3ur1eua/TriqRW6enLSa
 3xvQ==
X-Gm-Message-State: AFuF++mprVP3sX4KRC3WukB3TspVPDB/CYYyi4r7BFtOnEYHdvAPa0Ro
 WCP5kNplh613z6XmQUHThRqOtgY3J6l9GzUpU4nmkX3CdSA/W5KyFPa3H2yvPeD+zW5wJXh2Y8x
 F+K/blYkbt07zd9X+jAuMFA3V1NwTWZdWtl+xVXk2lELGuGKtfqxNE+4=
X-Gm-Gg: AR+sD114iSpqvQYB95G45U8Zo2j4Vo0VLmBG+XV7fnfrzWdqLSZSsvMT8yG8u2GqISz
 HJ/LGnsT4EfV9dmMim3xF1YiVqxubMbxeyRQemEnxZRqZBuhWccPEhzkEoMhCRFQjk1pEBTgsL6
 LIgIAPkhSiYomPCkMSuQgRRp7aSKSugAT/88phsQDf6WUXpuV7hQAy5wMmAzimCabFm6AeM+k8A
 yd9Yfgmvg2LL4fyAj7gGjp8cALX41z+MEj+AqmgqB5y86cTX8ci7V0p61D3EurCkvyKEIqixVxs
 +/hJc9ofT+VjeIGO/ncYi9Rc/yNn3Hyjvq6w4Wr/juqrqY0vIgB3wTKGwvtoLhcVyUI5DmXRxbu
 st5k4IiRgK0hgrw3dlQXYkNZc7XD0
X-Received: by 2002:a05:690c:dc8:b0:814:6ca5:ef99 with SMTP id
 00721157ae682-8573de63a48mr61414297b3.16.1787828026140; Thu, 27 Aug 2026
 03:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
In-Reply-To: <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 11:53:34 +0100
X-Gm-Features: AcwNN1Us5zYsPmaWkIyn7V2C1n4UiSVfAh9qdl50bZhzi1-dgiE8QM8X1FUQR24
Message-ID: <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: Portia Stephens <stephensportia@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Troy Lee <leetroy@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 27 Aug 2026 at 11:37, Portia Stephens <stephensportia@gmail.com> wr=
ote:
>
> On Thu, Aug 27, 2026 at 7:19=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
> > >
> > > From: Portia Stephens <portias@oss.tenstorrent.com>
> > >
> > > The ssi_transfer function comments say that it takes a word varying
> > > between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to transf=
er
> > > but there is no means to indicate the number of bits that should
> > > actually be transferred. All child classes of SSI_PERIPHERAL class ha=
ve
> > > transfer functions that, despite accepting a 32-bit tx, only transfer=
 a
> > > single byte; m25p80_transfer8(), ssi_sd_transfer(), ssd0323_transfer(=
).
> > >
> > > The current implementation depends on the SSI model to know
> > > what peripheral model will be attached and what transfer size it
> > > expects which is error prone. If a SSI_PERIPHERAL model was written t=
hat
> > > accepted 32-bit transfers, it could not attach to any existing SSI
> > > models.
> >
> > What is the motivation for this change?
>
> The motivation came from reviewing the designware ssi driver [1] and
> realizing how error prone it was. The designware ssi supports varying
> frame width but there is no way for the controller logic to know what
> the transfer size an attached device expects.

But isn't this just the way the SSI specification is? If we're
modelling a "you just have to get this right in software" bit
of hardware then we don't need to somehow try to add extra
checks in QEMU for whether the software hasn't actually done
things right.

> It seems like all the
> code, that is actually connected to devices, is just written to expect
> 8-bit transfers so it should be made explicit.
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg1218153.html
>
> >
> > As far as I know for the hardware SSI protocol, it is indeed
> > the case that the SSI controller (and/or the guest software) needs
> > to know what transfer size the attached device expects: the
> > controller just transmits (or expects to receive) however many
> > bits it is programmed for.
>
> This is true but do the devices currently model only support 8-bit
> transfers in hardware, do they not support multiframe transfer? SPI
> supports varying framewidth but the devices are not actually modeled
> in this way.

Do the actual devices we implement support varying framewidth,
or do they actually have exactly one frame width that the controller
needs to be programmed by the guest to use ?

> A better solution may be to have multiple transfer functions,
> ssi_transfer8, ssi_transfer32, etc. This would require the device to
> explicitly set what it is expecting. It is challenging since the only
> model's not using 8-bit transfer don't have any devices connected
> upstream so testing is challenging.

This doesn't allow for bit widths that aren't a multiple of 8.

thanks
-- PMM

