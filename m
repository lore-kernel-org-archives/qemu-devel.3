Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166E5CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCE10-0004ki-PC; Fri, 24 Oct 2025 05:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vCE0y-0004k8-R0
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:23:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vCE0w-0003M9-H9
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:23:16 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c09141cabso2941426a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1761297791; x=1761902591; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waB0gaPwKBSEDmPisShu5MxUwYFBmo+FNO9kxGGC25I=;
 b=KgHvPtN3ocp4IP6J8Ho36iahQdMskwDxGaHgL8TcYAMBBHqtzmdpguLJ2iiny1D7gP
 D3g3WtIEPdZ576HfC5q6Z24r5Gp9RemcXK4GV+MDHC5l76qFm1ljDXmrDp7w9MImhswc
 KDCOBTWtXAx7zjCh4t/LAjMZ/tIggiaumsMIJHfZFYlEFXXYoXsnpBOV/WwobPfOvJHh
 e3xNgvaTeGk6/cUMo8mGDFFGfjlTFAR3EK69cRrDB+2sccRxIMyBsrKmJWZ+xUfJBipO
 M6PMpoktMZlygzfn0J2Xijlw2YSiBnugIHuxlMcvD3/dppfnA/N/3jOL2+91YjvKra5+
 5Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761297791; x=1761902591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=waB0gaPwKBSEDmPisShu5MxUwYFBmo+FNO9kxGGC25I=;
 b=FFdUbVLH9GOl2f4bX8IHjXLpJhatVfr4IzzjfN7QPHXXYIBBbEeXhNmPEpFa0tgcQv
 eQHfnvKOvq9fqDIWHkODpsZENNYc2jpGjAfOk+HXG1A6Erpuqg6UktFTHd0nYF2wnsV4
 ikxDV85UN2kN+NdwV6OZaZ8qWCdgTe7g/yA5xzls1RLELbYDsrAOjr5vsyCqHrPhUTVh
 7+UV8VIpjG1WWEHuzWHBtDH3BQ9m/DqhxPXnp9F/eTVgZCEzQd1OGsEhwoi6yMXtruFt
 uzLFfqUyp7XpvldigUPgSs6dUDENA7yg3r/RY/Pg5VCnzF0lJCiVljjEcXPcrZ+2A0AI
 ZP4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUrrPP/8FpbIC/c77X2NHBnd/cRJo3OfU0vdzIie5yvYPDu6CCdGCUddBWSuPhNFY21PY4QZ1lsMjq@nongnu.org
X-Gm-Message-State: AOJu0YztluKsj5FeToO0rlIjclWBScaImbwZFWWzBfzdi/SzpXKTa4HI
 KhMxGF2YRFJ4Sp+x0fNoxbN2K7x4GGnIs2ifSFJK5Pq0Y8ldZCZmEhtgEF+knht3QYIRU0/rbAo
 4lN4mFt0zj4ngtQip/FcDvYG8woMCUfdYUG38cRgq
X-Gm-Gg: ASbGnctoG5UK/tnfTE8FqmPle+c+micdl+3vy88b907LB6bJfVu+oLhVPkXyfLa8Ilb
 nzEJHWQnZYARsC4gdBPgyqXQfRVHpHQL9YTNH1I4FcHoYLViFnCqZ7a5aJs/rUKkMTEbmtxdpQ8
 rqLqwo2yHrR1gZqaIDBeuNPN/+sF/hQWN/2J+ROjjvk3aeEcbxJabFeOaIs2Rbc+E0MMnvAuMpp
 VyeBFzvj0vWDTNxG1/oogvAqU7aB8fRFjr4pzpmT+Ck96zb+NXSnPpW30ps04Sm+bpH4CBFJ+sU
 2dqwo5hu6P52V00+Cxg=
X-Google-Smtp-Source: AGHT+IF4zObRKZbZZ8EDtvODPz6B+gns8z5He1zHbzC9UZZKZZpk00kJWgTvvBUvytZ9jxhldu3D5nX8zN70Ij/nfRI=
X-Received: by 2002:aa7:cf04:0:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-63c1f6df7e5mr20978541a12.33.1761297791380; Fri, 24 Oct 2025
 02:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
In-Reply-To: <87ms5g3dnq.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 24 Oct 2025 11:23:00 +0200
X-Gm-Features: AWmQ_blXKPHarIGfymzIQcnaFYkhHEG8aGEKRv8nYhj2_9AP57TGT5WCKkz6ZR8
Message-ID: <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, hreitz@redhat.com, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x531.google.com
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

On Fri, Oct 24, 2025 at 10:35=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Kevin Wolf <kwolf@redhat.com> writes:
>
> > Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
> >> This allows more flexibility to vvfat backend. The value for "Number o=
f
> >> Heads" and "Sectors per track" are based on SD specifications Part 2.
>
> This is too terse to remind me of how vvfat picks cylinders, heads, and
> sectors before this patch, so I need to go dig through the source code.
> I figure it depends on configuration parameters @floppy and @fat-type
> like this:
>
>     floppy  fat-type    cyls heads secs   cyls*heads*secs*512
>     false      12         64    16   63         31.5 MiB
>     false      16       1024    16   63        504   MiB
>     false      32       1024    16   63        504   MiB
>     true       12         80     2   18       1440   KiB
>     true       16         80     2   36       2880   KiB
>     true       32         80     2   36       2880   KiB
>
> How exactly does the new parameter @size change this?

My prime goal was to create a 256 Mib VVFAT disk. As you can see,
today for hard-disks there are only two possibilities: 31.5 Mib or 504
Mib. Hence, I've introduced the option `size=3Dxxx` to allow more
granular choices.
This option changes how cyls, heads and secs parameters are computed
to be as closed as possible of its value.

I did try to keep it simple. I could have introduced options to select
cylinders, heads, etc. But I think "size=3Dxxx" would be more intuitive.
There are also approximations made, as not all sizes can be reached. I
didn't add errors or warnings for them. I'm fine adding them.

> >> Some limitations remains, the size parameter is recognized only when
> >> "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dxxx" i=
s
> >> keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
> >> FAT12. FAT32 has not been adjusted and thus still default to 504MB.
>
> 31.5MiB unless I'm mistaken.

True, I will fix it.

> I'm not sure what you're trying to convey in this paragraph.  As far as
> I can tell, you're adding a @size parameter to vvfat, so of course it
> doesn't affect raw.

Yes, but AFAICT, `if=3Dsd,format=3Draw` will result in vvfat backend being
called. I didn't manage to make the new option work with
`if=3Dsd,format=3Draw,size=3D256Mb`. Thus, when the "size" option is not
provided, I keep the previous value (those for your above comment).
Hence this paragraph to mostly warn people about the current
limitation.

> >> Moreover, for flopyy, size=3D1M is creating a disk 1.44 MB, and size=
=3D2M a
>
> floppy
>
> >> disk of 2.88 MB. This avoids having to worry about float operations.
>
> More on this part below.
>
> >> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >> ---
> >>  block/vvfat.c | 165 ++++++++++++++++++++++++++++++++++++++++++-------=
-
> >>  1 file changed, 141 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/block/vvfat.c b/block/vvfat.c
> >> index 6526c585a2..4537c39d5c 100644
> >> --- a/block/vvfat.c
> >> +++ b/block/vvfat.c
> >> @@ -1091,6 +1091,11 @@ static QemuOptsList runtime_opts =3D {
> >>              .type =3D QEMU_OPT_BOOL,
> >>              .help =3D "Do not add a Master Boot Record on this disk",
> >>          },
> >> +        {
> >> +            .name =3D BLOCK_OPT_SIZE,
> >> +            .type =3D QEMU_OPT_SIZE,
> >> +            .help =3D "Virtual disk size"
> >> +        },
> >>          { /* end of list */ }
> >>      },
> >>  };
> >
> > Like in patch 1, you need additional changes, in particular to add the
> > option to the QAPI schema in qapi/block-core.json.
> >
> >> @@ -1148,10 +1153,141 @@ static void vvfat_parse_filename(const char *=
filename, QDict *options,
> >>      qdict_put_bool(options, "no-mbr", no_mbr);
> >>  }
> >>
> >> +static void vvfat_get_size_parameters(uint64_t size, BDRVVVFATState *=
s,
> >> +                                      bool floppy, Error **errp)
> >> +{
> >> +    if (floppy) {
> >> +        /*
> >> +         * Floppy emulation only supports 1.44 MB or 2.88 MB (default=
).
> >> +         * In order to avoid floating operations ambiguity, 1 MB is
> >> +         * recognized for 1.44 MB and 2 MB for 2.88 MB.
> >> +         */
> >> +        if (!size) {
> >> +            size =3D 2 * 1024 * 1024;
> >> +        } else {
> >> +            if (size =3D=3D 1024 * 1024 && s->fat_type =3D=3D 16) {
> >> +                error_setg(errp,
> >> +                           "floppy FAT16 unsupported size; only suppo=
rt 2M "
> >> +                           "(for an effective size of 2.88 MB)");
> >> +            } else if (size !=3D 2 * 1024 * 1024 && size !=3D 1024 * =
1024) {
> >> +                error_setg(errp,
> >> +                           "floppy unsupported size; should be 1MB (f=
or "
> >> +                           "an effective size of 1.44 MB) or 2.88M (f=
or "
> >> +                           "2.88MB)");
> >> +            }
> >> +        }
> >
> > This is horrible. To be fair, it's pretty hard to do something not
> > horrible when the usual units to describe floppy sizes are already
> > horrible. :-)
>
> Yes :)

I did have a first version that ignored this new size option for
floppy. I did extend it because why not. But if you find it will bring
too much complexity I can bring it back.

> > But I'd still like us to do better here.
> >
> > To me it looks a bit like what we really want is an enum for floppy
> > sizes (though is there any real reason why we have only those two?), bu=
t
> > an arbitrary size for hard disks.
> >
> > Without the enum, obviously, users could specify 1440k and that would d=
o
> > the right thing. Maybe special casing whatever 1.44M and 2.88M result
> > in and translating them into 1440k and 2880k could be more justifiable
> > than special casing 1M and 2M, but it would still be ugly.
> >
> > Markus, do you have any advice how this should be represented in QAPI?
>
> Maybe, but first I'd like to understand what @size does.
>

