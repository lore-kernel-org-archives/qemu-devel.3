Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA6CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgj0-0006Lr-Tg; Fri, 02 Oct 2026 13:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xCgiu-0006LJ-8N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:07:05 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xCgiq-0001nn-L3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:07:03 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so648518a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960818; cv=none;
 d=google.com; s=arc-20260327;
 b=lPT4A5wOWrlbPgjqQMf3CmYsyEPKr0SgrdnO6uODt6IV/vjPDQrPItLvak49BI2R+l
 YWaX1dklTaTGU2Ki4NijFo720hrLc9fCtW0EyCup1FbMhdTnwsTcbjtRhgqgAdOFxrCE
 ws1f93hut1nItdtUC/QmAgNuAiYKLdXkLbZEN+CCjs71X8II2S7CxdIDW8TajllHPGbs
 zlS5ogFDqTUej37lrFsDMb+70B/q1pmgCZYKd3VMiiYu4ydlD6b2vPR25SdONSJRMU7f
 J0qsACgvLdTJ/VZzZPte01zHds5NJ5P/7KP7MtwWUzEt3dm97Va1luSCyiyN8BUwAT3A
 JeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EdzkP4H+Ytt5Y2R1+BII7fVFFgZux+fpIpPKaTbCxQg=;
 fh=ZY42IKakwEggoisEzVAtYxLW7OPmO5+fJ/ez2T4velY=;
 b=MDXuz0+ytUbWwFSzw7BGT/9GOz26nW6A2JUovxaVP2vLrxcqO8jwiFDgdFPjCBRBdQ
 h7gkDHgGuWSszufk2v7QLR9onkzd8Tq+Ovb2GkIeq1MeZjdU0Q/b+oSXb4XX0sHA3MB5
 PUjM5H4XNlcwyHN6cfxTE2nLav1be+n98Kb4TwNIFDoVY9T68da1ogsv1Me0PHBokKAF
 j8H7nfSDaZRrfeuW5iJRwhJTpgEnjQCo2tXpDSqCO2rg52N3qBWwvIDb7l6mVLtFt12u
 nCbykLgGt+cPvUE9seHUxG3o445Wwec7iuF5M6wp92qus+esHlxSsA+u2ZvtiafGs3Mr
 rsGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1790960818; x=1791565618; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EdzkP4H+Ytt5Y2R1+BII7fVFFgZux+fpIpPKaTbCxQg=;
 b=BnoEKZVJ5335c6lLlQgF9T3HtjZ/00I6GaZV8fMYGmA3C1mbUtvOLTeF5UNbDZy9VE
 9G0voQ8QvokYwWUdVw+FZi59lJ6OrnKXccAb7u8ajaG9ZO0YsDBORx//LwfeLFlIgpLg
 lEyQbbr7SE4jqXrNQ/tlX54COJaO5lB4JTwRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960818; x=1791565618;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EdzkP4H+Ytt5Y2R1+BII7fVFFgZux+fpIpPKaTbCxQg=;
 b=CY/L9S8+esdVtwY4bOx4IvKvylp3jlgGxIRHegCAbbY2L6y9QsGRybA+GBdwFH+O0F
 qLImhw3iWB+BGxyfTRrmS8b8cGRf3qmfBYldibbPrkOvNFGdXDlDtp+WpZSwrMpocTvE
 BMp7ITi2Q/OkEW3pw/YxI2cHCk7AZy1YMv3LxTniRIwq2xtg0Bk8j6+1rkiV4hpNXu6B
 foJ80rbsRdUOxWIzd0/qa6jX9ppheLNGrcBM6BEh3Ra6Exvzs4V+ml+LAhU+6HrjhyNF
 3TcS+BMDf5taa4nQpMmDLOi9tMh1SqFk8gkiYSmdFmuwBT5zPUnkMpbXJArSxnx6Pe4H
 30cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8gee+CgGedLGQRePzpwE/waIg14rCqZGCKty+MbMi/4D+eSIH0FMcLtHXEU8vA0sr+PXlC5iExTKh@nongnu.org
X-Gm-Message-State: AFq9FYITIbiol1QX8r3DIEa5h0WA2LgrS+fz4YypefHf1j583cdTKyPL
 worNhE3G0NRG8o39SfCGyG/5BwMQ//JVntdoEg1nrM5didGdtyxQ8fhSKY4u49MKYq+gJzBKn0f
 nphEgZxpCD/dos5kZTRjzmkKqPeoq8T0Tb5NuHKiKgg==
X-Gm-Gg: AYBFou2HeVzorHVWpumeIZxrFI/7vjK97cPfNzmpomS/cIm5jq8Bd6TNM6Bt87QVFlT
 As3e2gO3jyntFJ/HQ7nWdmYT7wvBUwCBbRm54UCy8ZVrGFbwwnLxaZqXZbq+t8aAmlEctazvqQV
 0cMWQMX1Dfrz1GyLlPHavFF/J+L/tEZ/F+fWLEruGnRSripJ0sMVNoWGV8sDH4SLKZjL/+tEcN/
 lzmRp7cQDLwqfNa9u7twmjmphcVw3Zvbyrev0BP5LWT/zCEtaMzxJ2xUGQkqQVcrxL9a/BOTK02
 PvSkMTln/UUXWfbyY2C6Sog6LRbb0NKB53GMvBlaP2F75BA/kLXAnzf8R8Y3pNo5ZhBE8M+krzu
 aA21g+R8QjwePZRWpQyLh
X-Received: by 2002:a05:6402:24c7:b0:6ab:1cd:a2b0 with SMTP id
 4fb4d7f45d1cf-6afad8bd80bmr90612a12.15.1790960817545; Fri, 02 Oct 2026
 10:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
 <20260919085510.3388454-11-manos.pitsidianakis@linaro.org>
 <CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com>
 <c58c324d1ce1f095c0036c43691d61d9dcac6f1d.camel@mihalicyn.com>
 <CAFEAcA-J9R2ZOSR+Y=5xOidR6fZq2Y9Z6f9MZoSxgRK0iNTzhA@mail.gmail.com>
In-Reply-To: <CAFEAcA-J9R2ZOSR+Y=5xOidR6fZq2Y9Z6f9MZoSxgRK0iNTzhA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 2 Oct 2026 19:06:46 +0200
X-Gm-Features: AclHuK8EgMTKWFPDhFRSd0vkAVgYouGaHmllM0Cr1zeKLZ57euSDdraOTg5tmi4
Message-ID: <CAJqdLronpmuKPezWUYHRtG3xNDSBDMEzUaM2PpmoNn-QSDiUqA@mail.gmail.com>
Subject: Re: [PULL v2 10/10] hw/audio/virtio-sound: add missing vmstate fields
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 aleksandr.mikhalitsyn@futurfusion.io, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x529.google.com
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

Am Fr., 2. Okt. 2026 um 16:38 Uhr schrieb Peter Maydell
<peter.maydell@linaro.org>:
>
> On Fri, 2 Oct 2026 at 15:07, Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > On Fri, 2026-10-02 at 14:49 +0100, Peter Maydell wrote:
> > > Here we call virtio_snd_pcm_get_stream(), but we don't check
> > > for a NULL return, unlike the other callsites.
> > >
> > > This NULL can't actually happen, because it only occurs for an
> > > out-of-range index, and here our index is by construction
> > > in-bounds. So this is a Coverity false positive.
> >
> > yes, I did know about this, but haven't expected Coverity to overreact here,
> > cause I specifically checked that NULL pointer dereference is not possible.
> >
> > My fault, sorry :-(
>
> No worries -- the coverity scan only runs on head-of-git and it's
> hard to tell what it's going to complain about in advance (and it
> has plenty of false-positive reports on perfectly good code).
>
> > > But I think it would probably be slightly better to follow the
> > > convention that seems to be used in the rest of the file, which
> > > is that virtio_snd_pcm_get_stream() is used when dealing with
> > > stream IDs from the guest that need validation, and for "loop over
> > > all streams" (as we do in virtio_snd_realize(), virtio_snd_unrealize()
> > > and virtio_snd_reset()) we write that like:
> > >
> > >     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> > >         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
> > >         ...
> > >     }
> > >
> > > What do you think?
> >
> > I'm happy to submit a patch for this if you and Manos don't mind.
>
> That would be great.

https://lore.kernel.org/qemu-devel/20261002165039.212819-1-alexander@mihalicyn.com

Kind regards,
Alex

>
> thanks
> -- PMM

