Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E999EFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVUT-0002Sd-Aq; Thu, 30 Apr 2026 13:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIVUK-0002Is-6H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:47:49 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIVUD-0003TJ-1A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:47:42 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6530287803cso1317465d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777571257; cv=none;
 d=google.com; s=arc-20240605;
 b=QoR0bwD3i96I9kbIuY34x1Bxk5RM3CiqTqlS8xDIx4IZS3R9XimBPlTrSEz4hzYBBa
 FLyWaPmXErFpz0W8X+d/N8qLogMULWypNJt4lnomRJBdGtvZAEdlUAwyOoqIOPQXxBJV
 MqzSMDgnPShp1adP2qc61jEa67A/RFYso0iuMaiorLYBbSnp2xWpl6Z94za/qJ+BngEH
 nB62kij64B+Qn+Kg3AvJfICZjvJXdP6/0V4RWZa3/XPqPT30jb+yf8Cs0PuR93gVNy1N
 rePY3sVd3wg+JibJWvOZXxM6u9zLxWAD8rGvjjhm7fyQK9A670h5s7zUbk0W/v0mcPeg
 mcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+xsimC4zkj0u+Nzi3MHOnfRd+xMdIt5+KK2Pf+MhexI=;
 fh=LQhq4Jhj8OAQPsF8kySYPfwOtGsuuF3EYzuvfR7PILE=;
 b=DRkqzS+kgmHOw24QnzG9NI24hOBJE7e6Mv1vD/A0tFdMM1aCfbJHG+xTJpPRXoOpYr
 ySLU9hLMQ4lni+erX6GLxujfZ73lYLaAdmcEb2FjKTEWppffNUNIDLvvJ+bIV25o94G1
 pqRwl7u7FzguGlPbc0FjAGBM9vuWwJzspD4S7VE41UXDBcEvakYfD7AojHTlrO2t3+Nf
 g1P7lFNMP/gDFGi5cVr0QiHwG8nzwLdjuo2TWbIxBLc5RZfrMCn6G3GI88zOFOweMg2P
 /t6+uVREeALu3HPG64lHwtmwXUdeGuNdkuvd9snKX6HdfUjTFmPEL8mMYTvcw206ajZm
 lBsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777571257; x=1778176057; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xsimC4zkj0u+Nzi3MHOnfRd+xMdIt5+KK2Pf+MhexI=;
 b=yM2Nx7Eqf9ZxEQGNvc379jJt0KCfHJH10je7uuppHi+5OC+w8doSxk2wmjuE8x9Zt3
 Mngt+krWiSchiP2PWjfPUjcadB8eyZFVD3KQ0OFG6HKoTYABUkbFHZ9l5kAQ6Be3ZZ2V
 ciGz/Ssbne9MuFL2yGFFPB78/TonljatoVB8KsboyO2A4pBdsC1hTQ0o0Lb8K3tdDHwx
 2MsUm3I6Cb5bipEEpu4MDy6cmSfKE1NFY5rEWIsOtaKgLGHn0GIrWMBG5mdNGXtdJGXk
 3vGFTLUeBg6t6zv01S/8A1AMmHAg9FuC0IOy2EaKkIAS3b/09g0JjVuh4mPiFfmhbL6A
 QKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777571257; x=1778176057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xsimC4zkj0u+Nzi3MHOnfRd+xMdIt5+KK2Pf+MhexI=;
 b=oLwnhhAiYa6jPd4+iYzDsPfMm9fX5Wak0KH0JvtY2v5zKXVPAhyNIqzZqul3AQjCI3
 gKHhrNfcmHImOTLJK2iD/lMEwvEdEeLMgjvP5tEWMv9znCkITnUjabyk3T3UAUrz2pHv
 FM+EysGGhvklUPA6H5bie/fCaYSsUqdnGXUXqr8PClKdjdHxG5fAgZVymP4oioNagsyc
 Du7yZqm3hwUv6RejtRy567sCr4rEZ1ssNmqh5bmlcI0610Lkee/NOGCSv3CWGchC/kID
 O4xddI24JFfqjUVyX1/U1mwCQbnBANqjWDUkdi2Idym5LTYt9nBYDjZ2kg1dPMYEtHHq
 wT3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Y5LcXrItwQMRv4ydRnwRNskyQ2uJx7CnNDz1drSQ6nMljMx37xJzcJyAVFhwHSftTcS6oilJEeSHg@nongnu.org
X-Gm-Message-State: AOJu0YybzWptimun7WdHPOHG3m+R8RqmUN34PohPZH0/Iji1Cmp4Z0qK
 MZveV36svbTBqzVJJL8XOZThYt9KzSps9itlOXfCHC6YPlVmnQUIAAFm+8yz4hk43ydHn4vKAcl
 IcXgu6k631LqXLZALNBJx6gb+U4aTgsjnGjzud347Uw==
X-Gm-Gg: AeBDietD3NuVNOglK5mOSSAW+M7Fs/TegxiCR8QB3QGTQTmp0Z/VUEjP36FE6SEMB2K
 YnBWe9Wt7jcva5XQDhgOf8D7+/2GYThklpXdUxrHlxZWzRFe97X7T9lfbR9W8jKE9IUukva/cav
 4dHafeN7qmwdy5j2jTLJVJ2kvYpFzUpuGMaj3uilfjDYLK01Tm2lQTXvigicfDCk0xBG+j3Kr+a
 EsTr8fVFnynmbSstOnNweTmGdqTTiCHBb/4xyDbANJPhMK94u+lApTJech6kF2rVLEXjzQkrMMk
 CTd0xMN5iEOcNjpSNN/mdyK6svCUF646AFm9l6yg0r+JsOjSq+mamxM+v4ZCeahsSU9B5xB31ym
 yhA==
X-Received: by 2002:a05:690e:4809:b0:651:b2d9:7754 with SMTP id
 956f58d0204a3-65c2b87cc3dmr703631d50.38.1777571257178; Thu, 30 Apr 2026
 10:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
 <20260428055254.76581-2-kane_chen@aspeedtech.com>
 <2b4f5cca-f064-4326-863c-9ab164e11c44@kaod.org>
In-Reply-To: <2b4f5cca-f064-4326-863c-9ab164e11c44@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 18:47:24 +0100
X-Gm-Features: AVHnY4KX-x91-963dm6junMSietxMqUsmDE1oQDD4JQaRTzwFg9Gbw93p5ENBOg
Message-ID: <CAFEAcA__w=Nrs0tr0W3TyHmKM3V=J1+Wa5vLKA8kv0iNaL5Avg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 30 Apr 2026 at 18:26, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 4/28/26 07:52, Kane Chen wrote:
> > There is a mismatch between the Aspeed OTP model and the Aspeed SBC
> > model in how the guest-provided address is handled.
> > aspeed_sbc_otp_prog() passes a word-indexed address directly
> > to address_space_write() without converting it to a byte offset,
> > whereas aspeed_otp_write() expects a byte offset and applies an
> > additional shift (otp_addr << 2). This double-shift confusion means
> > that an out-of-range word address can lead to a write beyond the
> > allocated storage.
> >
> > Fix this by adding bounds checking on the word offset before
> > converting to byte offset and passing to address_space_write().
> > This matches the existing bounds check in aspeed_sbc_otp_read().
> >
> > Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>
> > Cc: qemu-stable@nongnu.org
> > Fixes: 1a00754ccf15 ("hw/misc: Add Aspeed Secure Boot Controller model"=
)
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3436
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> > ---
> >   hw/misc/aspeed_sbc.c  | 14 +++++++++++---
> >   hw/nvram/aspeed_otp.c | 13 ++++++-------
> >   2 files changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> > index 065e822e70..8b74dca13c 100644
> > --- a/hw/misc/aspeed_sbc.c
> > +++ b/hw/misc/aspeed_sbc.c
> > @@ -159,13 +159,21 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s=
,
> >       MemTxResult ret;
> >       AspeedOTPState *otp =3D &s->otp;
> >       uint32_t value =3D s->regs[R_CAMP1];
> > +    uint32_t otp_offset =3D otp_addr << 2;
> >
> > -    ret =3D address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECI=
FIED,
> > -                        &value, sizeof(value));
> > +    if (otp_addr >=3D OTP_TOTAL_DWORD_COUNT) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid OTP addr 0x%x\n",
> > +                      otp_addr);
>
> This log event could be on one line.
>
> > +        return false;
> > +    }
> > +
> > +    ret =3D address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPE=
CIFIED,
> > +                              &value, sizeof(value));
> >       if (ret !=3D MEMTX_OK) {
> >           qemu_log_mask(LOG_GUEST_ERROR,
> >                         "Failed to write OTP memory, addr =3D %x\n",
> > -                      otp_addr);
> > +                      otp_offset);
> >           return false;
> >       }
> >
> > diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
> > index a60289000c..1a9d3841b8 100644
> > --- a/hw/nvram/aspeed_otp.c
> > +++ b/hw/nvram/aspeed_otp.c
> > @@ -57,12 +57,12 @@ static bool valid_program_data(uint32_t otp_addr,
> >       return has_programmable_bits !=3D 0;
> >   }
> >
> > -static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
> > +static bool program_otpmem_data(void *opaque, hwaddr otp_offset,
> >                                uint32_t prog_bit, uint32_t *value)
> >   {
> >       AspeedOTPState *s =3D opaque;
> > +    uint32_t otp_addr =3D otp_offset >> 2;
>
> I think 'opt_addr' is a bit confusing. It's a word offset.

It's the variable name we're currently using for that meaning
everywhere in these two devices, though. It might be better
to keep that cleanup in a separate patch from this one.

-- PMM

