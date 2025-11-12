Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD87CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 09:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ7V5-0006Lm-KB; Wed, 12 Nov 2025 04:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJ7Uy-0006IR-Go
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:50:47 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJ7Uw-00056X-5y
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:50:43 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640e9f5951aso925358a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762941039; x=1763545839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oborem9Hx1Cg16YWAyrOt/T2NbZEhjUUFRkx46I7H5Q=;
 b=QRaQF/bTTTDT+O8GW8+YAuzSrHPBpxg7wg2D75QR8EC6DdikLyiWzTolGm9sveWTg1
 LRsSsBxNKVPnpSK7caP68mSkmuxE3z3bSLx4vAsb98hqk7KRvOag/Hmf5uMD3g+KBb+T
 lk0aCg8sF3DwMFLWiRGOHE7Zmlv+gALP4xv0Cn7qtrp7p20XUR59nmNuSApwv9Xj1Vmz
 QPrP45wAv6RDJAbLnYMaZdfuBAlFODV34/wIySAevcfpgFIkdZbNXid+RBw0p9+KrqK8
 NSB4NWNRuVJVGYzvYvh1roB1cESrffKgRSa4A0vzmEhW6PgGMzJuKoGqkh9svRfKOG3r
 fVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762941039; x=1763545839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oborem9Hx1Cg16YWAyrOt/T2NbZEhjUUFRkx46I7H5Q=;
 b=crAA46m7+vjHjHml4UVpsdRoOQkh0TshfZC6iA9HD60LHTI2KBCx4sulDHg6oWGGXy
 MGC4Dv3S4THq4ndLhuEIHFgD3JxQWaiXWggvMx10GTC4Zi0pOYRnQI9sxUzjTRUd1xjY
 Rd4KH8rMIPLaRYCTO3CVtMRhtWnfHCx0bWydf9gUw5cwO6f3EEbAfQv+Lh3G0gJLa8bf
 c0oj88Q3NQZCReWkJkuIVG+4H9r+Ml4pZMvVZ3wYIMLv21vX95bwyTnKr8T3qSW2BfAk
 XmHMMuMCD4ZCVsNPilCHW2z8aisxs2duKHU7I5942Wy9f25ZFi8xUG22bbGuALlPlwPX
 YIBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeZHCgbPPvd8TPuqbbnrZgAVVcH8AsvBuBniWmDuPNVnRmeHSkQxb+eO5U3Q4rLbgjDzw5XbyQwkKv@nongnu.org
X-Gm-Message-State: AOJu0Yw5OOTUDsFOC+sKtgWkTelUyZZyoF6GCddm+BLde4emy4D/xWHK
 pGKf5jxXCFWR24uXVe0ylvAP85ruLt9PXtd2qWw8MNhBb7yd0lhKtJSqrmV7ngeDgRbXMvVwqDn
 SvfHyccXRbCoGRb0K+vXLqMkpHSAUcn3GSvbZU5dk
X-Gm-Gg: ASbGncvCIzIJoeLePZT5LLZir+nK2hTUtO9Cf0WrP0sFjyt/rJOfeKcMFQdwGeSlaYx
 DVlGHw4gfEVPMVhRaoHjhUQ3V+KApgT7fUYQ2W45iPufonnMBSzTk8UFivm/mBJxPrq4k6eayzk
 7gKrbSKksjXTcGV3J8HsDIeB6pbxF10QOmD3H1oZX17K/OkQ7Haj19oWSnNQIXXrbvEA6p5MeZ5
 KCl9rUAQyb/U5JfSN3sq3Kg9resUFJjzTdVg5mMOcndhs4TUt0+Z57VFftH
X-Google-Smtp-Source: AGHT+IElWKmdgxF/73TfQCjeyA7kcAPdaQJPSDWk+Qu/wJ3Tm9f+CvmPFIEuxI8QVhu3IlmstmffX8GbSukE/dDz/Jw=
X-Received: by 2002:a17:907:1c0f:b0:b46:57fd:8443 with SMTP id
 a640c23a62f3a-b73313ea9cdmr252027666b.24.1762941039076; Wed, 12 Nov 2025
 01:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 <87o6paj96k.fsf@pond.sub.org> <aRIC1NZXQUxkR7iR@redhat.com>
 <f301fcab-a7d6-1d89-aa56-52397f0d940a@eik.bme.hu>
 <aRITWJo6R_oG9t7R@redhat.com>
In-Reply-To: <aRITWJo6R_oG9t7R@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 12 Nov 2025 10:50:26 +0100
X-Gm-Features: AWmQ_blWr6aCtXEsToCoGI8WaKQXGwEyr-5HfYfV8d1qc3s_Gcaah1flkUAfHF0
Message-ID: <CAJ307Ej66N2y-NjD=bs5R5ADjTaf=2Lv=510U+uQKuemJcNLgg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
To: Kevin Wolf <kwolf@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x536.google.com
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

On Mon, Nov 10, 2025 at 5:31=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 10.11.2025 um 16:36 hat BALATON Zoltan geschrieben:
> > On Mon, 10 Nov 2025, Kevin Wolf wrote:
> > > Am 10.11.2025 um 14:42 hat Markus Armbruster geschrieben:
> > > > Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> > > >
> > > > > On Mon, Nov 10, 2025 at 2:09=E2=80=AFPM Markus Armbruster <armbru=
@redhat.com> wrote:
> > > > > >
> > > > > > Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> > > > > >
> > > > > > > On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Markus Armbruster <a=
rmbru@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> > > > > > > >
> > > > > > > > > This allows more flexibility to vvfat backend. The values=
 of "Number of
> > > > > > > > > Heads" and "Sectors per track" are based on SD specificat=
ions Part 2.
> > > > > > > > >
> > > > > > > > > Due to the FAT architecture, not all sizes are reachable.=
 Therefore, it
> > > > > > > > > could be round up to the closest available size.
> > > > > > > > >
> > > > > > > > > FAT32 has not been adjusted and thus still default to 504=
 Mib.
> > > > > > > > >
> > > > > > > > > For floppy, only 1440 Kib and 2880 Kib are supported.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > > > > > > index 8a479ba090..0bcb360320 100644
> > > > > > > > > --- a/qapi/block-core.json
> > > > > > > > > +++ b/qapi/block-core.json
> > > > > > > > > @@ -3478,11 +3478,17 @@
> > > > > > > > >  #     (default: true)
> > > > > > > > >  #     (since 10.2)
> > > > > > > > >  #
> > > > > > > > > +# @fat-size: size of the device in bytes.  Due to FAT un=
derlying
> > > > > > > > > +#     architecture, this size can be rounded up to the c=
losest valid
> > > > > > > > > +#     size.
> > > > > > > > > +#     (since 10.2)
> > > > > > > > > +#
> > > > > > > >
> > > > > > > > Can you explain again why you moved from @size to @fat-size=
?
> > > > > > >
> > > > > > > Just to be sure, you mean in the above comment, in the commit=
 message or both ?
> > > > > >
> > > > > > Just to me, because I'm not sure I like the change, but that ma=
y well be
> > > > > > due to a lack of understanding of your reasons.
> > > > >
> > > > > Naming `fat-size` instead of `size` ensures the parameter is only
> > > > > recognized by the vvfat backend. In particular, it will be refuse=
d by
> > > > > the default raw format, avoiding confusion:
> > > > >  "-drive file=3Dfat:<path>,size=3D256M" results in a 504M FAT dis=
k
> > > > > truncated to 256M, raw format being implicit.
> > > > >  "-drive file=3Dfat:<path>,fat-size=3D256M" is refused. "fat-size=
" is
> > > > > unsupported by raw format.
> > > >
> > > > I figure throwing in format=3Draw to make raw format explicit doesn=
't
> > > > change anything.  Correct?
> > > >
> > > > >  "-drive file=3Dfat:<path>,format=3Dvvfat,fat-size=3D256M" result=
s in a 256M FAT disk.
> > > > >  "-drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M" is refused=
. "size" is
> > > > > unsupported by vvfat format.
> > > >
> > > > If it was called @size, what behavior would we get?  Just two cases=
, I
> > > > think:
> > > >
> > > > 1. With raw format:
> > > >
> > > >     -drive file=3Dfat:<path>,size=3D256M
> > >
> > > You'd silently get a 504 MiB filesystem truncated to 256 MiB (i.e. a
> > > corrupted file system). It's quite easy to forget format=3Dvvfat, so
> > > something that initially looks like it might be working is not a grea=
t
> > > result for this user error.
> >
> > Why doesn't file=3Dfat: imply format=3Dvvfat? For what is the fat: part=
 in
> > file then?
>
> -drive is built pretty much on the assumption that you have an image
> format that runs on top of a protocol. Format probing probes the image
> format, not the protocol, while prefixes like fat: (or nbd:, http: etc.)
> specify the protocol.
>
> So if you don't specify the format, we first open the protocol level
> (which is vvfat) and then probing will detect that over this protocol,
> we access a raw image. So it's mostly like saying format=3Draw.
>
> I think that format=3D<protocol driver> works is really more accidental,
> but we can't change it now (and probably also don't want to). It results
> in opening only the protocol layer and not stacking any format driver on
> top of it.
>
> Options that you specify in -drive generally go to the top layer. So the
> consequence in our case is that with format=3Dvvfat, the option goes to
> vvfat, but with format=3Draw (or unspecified format), it goes to the raw
> forma driver.
>
> > I currently recommend using:
> >
> > -drive if=3Dnone,id=3Dufat,format=3Draw,file=3Dfat:rw:/dir/to/export
> > -device usb-storage,drive=3Dufat
> >
> > to my users which I got from somewhere but don't remember where and it
> > seems to work but maybe not the best way to specify this.
>
> It's fine, and I might use the same one myself (though you should be
> aware that fat:rw: is risky, it's full of bugs).
>
> But if you add an option like size=3D64M, it goes to the raw driver, whic=
h
> will take whatever image you access on the protocol level and truncate
> it at 64 MiB.
>
> If you want to give the size option on the vvfat level (and create a
> filesystem that is actually only 64 MiB instead of truncating a larger
> one), then obviously format=3Dvvfat allows you to do that because then
> there is no raw format layer to begin with. Or if you do have the raw
> format layer, you can access options of the protocol layer by prefixing
> "file.". So format=3Draw,file.size=3D64M would still pass the size option=
 to
> vvfat.

How is `file.size` working ? I've tried a similar syntax for other
vvfat options (e.g `file.floppy` or the new `file.partitioned`) but
those have no effect. Is this because there are fetched within the
"filename"
Wondering because I'mn ot a fan of the new ":unpartitioned:", I've
added in patch 1. If it can simply be replaced by
`format=3Draw,file.partitioned=3Dfalse` or
`format=3Dvvfat,partitioned=3Dfalse`. I think that would be far enough for
its purpose.

> So the command line does allow you to get the option to the right place,
> it's just very easy to get confused about this and to specify the option
> for the wrong layer.
>
> > After reading this thread I'm confused about how to use this
> > correctly. Is there some documentation on this? There only seems to be
> > some mentions in docs/system/qemu-block-drivers.rst.inc but all of
> > them using older options:
> >
> >   |qemu_system| linux.img -hdb fat:/my_directory
> >   |qemu_system| linux.img -fda fat:floppy:/my_directory
> >   |qemu_system| linux.img -fda fat:floppy:rw:/my_directory
>
> All of those are honestly fine, too, if you're happy with the defaults
> and don't want to set more advanced options.
>
> I'll give you this bonus option if you want to be modern:
>
>     -blockdev vvfat,node-name=3Dufat,dir=3D/my_directory,rw=3Don
>     -device usb-storage,drive=3Dufat
>
> But I don't think any of the other options is going away anytime soon.
>
> Kevin
>

