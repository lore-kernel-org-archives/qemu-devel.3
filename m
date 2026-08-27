Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7F2C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZbL-0001qw-JF; Thu, 27 Aug 2026 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wzZbJ-0001n4-Vk
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:53:02 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wzZbG-0000p9-Uy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:53:01 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4678d3e490bso427448fac.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787835177; cv=none;
 d=google.com; s=arc-20260327;
 b=OPk+7aCx2DOu5Vue96HexW4iAmz/M39DeIbJ3iNvFT3lMu9jnXx/bXekeg+l5LnWLR
 C0NpPSBM+f3Inb9AXfPZglFxGX0UeJ86YiaTc/+cZzm24ZWvPuMTZWTDvppjga7CWY71
 448f87a5rvdYPO99aKEXA4gNgdpJDUmwbPV9lvNpBOipiHGmkvgBS6if9Uo958y9nM1t
 GTSoAuJJ3CQ9yslID4XXir/L+70uShz2kWOgau5T5BznYBJ5G6u2Aw++FcCBu3P1Fc2P
 YO5/gM9eSotVR+qlP7hknBfjH2uLVn81UPDx0yM5oEfpefykXvkcuPpGEU83AkDkuI/V
 q9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=972qMNuHpujV1LYeJOJewE8qoLbYh3ct+xxAxq/EtDQ=;
 fh=9ysVbe5KS4Lhzj0G7Qybi58mU7ICweieEe8Mn1OfeYU=;
 b=NSEu+GzZafaqzcJjG3ZyqdiHo+Jo2jPxjov4xOTbTgdJzDcejNkzEfa4WxtK7GQRdt
 pQYPUQhL+COXxjlL9SQGfzlu1Y5yOuh3wMJCfoWMBBhjvRSdja4i72PRr+VUXypfJBql
 RSiaSzbIqBxNc1h6eky9tOmK1cbmrcjgtZ8onTAw+BCjzJWi0T+1GmGtxn0aLq3JQJNl
 KnIumOHn2pgV+Ps6jG7zlVxWkxUNZjlZGYbLwMM4twcKDpa6B1kz7TUqykmRHh3c9ozn
 s+ZE3+NoLim/6eXFv9mm1nWpHFYlksCMCuw/b/kAXRnHEgUs146AT56GM3ZHYNWyakuH
 H/UA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787835177; x=1788439977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=972qMNuHpujV1LYeJOJewE8qoLbYh3ct+xxAxq/EtDQ=;
 b=KLejYhhx/VqlRIcjiu/huxzeeXGoBy9pw2Z1ps/SCNcpYZEkOmrsrgsYiou/LoQkpI
 kVlPTP+oOkOB4gXttWAgHpdBUYU8kb9EVQWFKNuWFKLSVCFxkqwkEZzrok+B4FuWo2p+
 oOrHNoTXTkl9VqyGqEO+5KIbANvBH6soqNC4boGepzJHkiLC2LNnLtO7qWruQ4BwdZTJ
 PI/OpMJUEjvIZBgVVIi+XERcV2GXERXVXpVUvOysOZbgQROoZlxBsJ/zWQwxg7a8VJmo
 X68SFJO2XIzxyxy6yg0TTnINmpoR6mz6Hrya1Mz8aGC7IDVuroh2LKTonHJ9iMkJzNj8
 +hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835177; x=1788439977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=972qMNuHpujV1LYeJOJewE8qoLbYh3ct+xxAxq/EtDQ=;
 b=Qo9+fLBx471LO1B4FKcD039uq1Xv6G610Ti3qFaMv617MOswyPqXXHyGtsxfpz3pnG
 ARW41D3F9078VEmdDVUAJR3NKyJ2Q5YkAxDW8gTaTVQDqRFCT7xbnpQMdn6sTA+4G1O/
 htvOid+l1QSmaG/OW7YUiRsCi4jRejLtyy7v7yGFxbxPCl8JBqwy427xHs7QN1bthGl4
 JdU1XRRk72k4jTJR7QD+k17TYp0bfFCa0vxw/eSOSAHCc/ymKkkzOBje1oExw0waZgbZ
 VL+oQNwW2eOlvSFZaLs5YutQMRA6MeMP6rZ+wLaVikTAZzkuAaoIzc4lk6m1iDrWjXWZ
 Is+g==
X-Gm-Message-State: AFuF++nGgHEoe/jzlmNYQh/OdjUlWoQrzoQzW66AAa7bdMu3NgQFrsao
 D4HzjFo54ExGAJnTZ5xjyn9B03/scLK7J3I1IBdc+Pds4M0bsj6afZZC62w+tGg5mQQM9KA9ws9
 dEdBiq9O3qJk2JwuhRtUjeGeX27zWqZM=
X-Gm-Gg: AR+sD12Q/Tdix9UZP9eLb31t9kJJbNd6YliI/oh2GUJgnD/bonfdBpOJme3FzmJHks+
 4hRaqXnbZH+9Af+LYq902LbGNelKk4w1m/b9gCm8zbt3e/J6v+DZ75/idT40TLVkpnTy1jcVahC
 vYMVJtcnmdW1lXl5ZFtyLW4dBtopJSCoi6x+pfR37TK6UW4jKmq0s6+9Mtbll62Z0Fx174l33ov
 jcRT+sD6eQ2JLqMTyNztd0cxgjkJeti3xlegFn+ED6XgS4hrm5JVRpCbNOopzclp/pURejOBw0N
 3j9W5WONIX9l05+SCZwKlqN3J7BZUY2LZMvH2VFOT+tIY2BB+Gu1RDaP
X-Received: by 2002:a05:6820:2e8e:b0:6b0:31d0:5fc9 with SMTP id
 006d021491bc7-6b1b000b6e8mr3898956eaf.7.1787835177486; Thu, 27 Aug 2026
 05:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
 <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
In-Reply-To: <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
From: Portia Stephens <stephensportia@gmail.com>
Date: Thu, 27 Aug 2026 22:52:46 +1000
X-Gm-Features: AcwNN1WVKjgO4vdGB-g71tMRr9kieksa0kFkCi8R0mhD7uVbUPbImyxUUUZGX6k
Message-ID: <CACYNXwLEXFQ7s1PFgfWfk+O2k41W3Y=arJ=rxOyboqaR-9v70Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: Peter Maydell <peter.maydell@linaro.org>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=stephensportia@gmail.com; helo=mail-oa1-x2f.google.com
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

On Thu, Aug 27, 2026 at 8:53=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 27 Aug 2026 at 11:37, Portia Stephens <stephensportia@gmail.com> =
wrote:
> >
> > On Thu, Aug 27, 2026 at 7:19=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
> > > >
> > > > From: Portia Stephens <portias@oss.tenstorrent.com>
> > > >
> > > > The ssi_transfer function comments say that it takes a word varying
> > > > between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to tran=
sfer
> > > > but there is no means to indicate the number of bits that should
> > > > actually be transferred. All child classes of SSI_PERIPHERAL class =
have
> > > > transfer functions that, despite accepting a 32-bit tx, only transf=
er a
> > > > single byte; m25p80_transfer8(), ssi_sd_transfer(), ssd0323_transfe=
r().
> > > >
> > > > The current implementation depends on the SSI model to know
> > > > what peripheral model will be attached and what transfer size it
> > > > expects which is error prone. If a SSI_PERIPHERAL model was written=
 that
> > > > accepted 32-bit transfers, it could not attach to any existing SSI
> > > > models.
> > >
> > > What is the motivation for this change?
> >
> > The motivation came from reviewing the designware ssi driver [1] and
> > realizing how error prone it was. The designware ssi supports varying
> > frame width but there is no way for the controller logic to know what
> > the transfer size an attached device expects.
>
> But isn't this just the way the SSI specification is? If we're
> modelling a "you just have to get this right in software" bit
> of hardware then we don't need to somehow try to add extra
> checks in QEMU for whether the software hasn't actually done
> things right.
>
> > It seems like all the
> > code, that is actually connected to devices, is just written to expect
> > 8-bit transfers so it should be made explicit.
> >
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg1218153.html
> >
> > >
> > > As far as I know for the hardware SSI protocol, it is indeed
> > > the case that the SSI controller (and/or the guest software) needs
> > > to know what transfer size the attached device expects: the
> > > controller just transmits (or expects to receive) however many
> > > bits it is programmed for.
> >
> > This is true but do the devices currently model only support 8-bit
> > transfers in hardware, do they not support multiframe transfer? SPI
> > supports varying framewidth but the devices are not actually modeled
> > in this way.
>
> Do the actual devices we implement support varying framewidth,
> or do they actually have exactly one frame width that the controller
> needs to be programmed by the guest to use ?

From my reading of the m25p80 spec, it does not have a fixed frame
width. The frame would be determined by the CS being driven and the
clock running. A frame could be 1 byte cmd + 3 byte address for a
register read. For read mode, 1 byte cmd + 3 byte address + variable
length read data. I don't understand how the 8-bit transfer size
actually maps to what hardware does.

When writing a controller that supports varying framewidths, it
requires the controller model to know what transfer width will be
expected from the device connected. You could have guest software that
correctly sets the controller framewidth to 32-bits and connects a
device that provides a 32-bit transfer function. How can the
controller differentiate this from the case where the guest software
correctly sets a 32-bit framewidth on the controller for a m25p80 read
which has a 8-bit transfer size and the controller needs to call the
transfer function 4 times to clock out the requested read data.

Maybe I am misunderstanding what a transfer is or what a framewidth
actually is or what the realistic use cases are here.

>
> > A better solution may be to have multiple transfer functions,
> > ssi_transfer8, ssi_transfer32, etc. This would require the device to
> > explicitly set what it is expecting. It is challenging since the only
> > model's not using 8-bit transfer don't have any devices connected
> > upstream so testing is challenging.
>
> This doesn't allow for bit widths that aren't a multiple of 8.
>
> thanks
> -- PMM

