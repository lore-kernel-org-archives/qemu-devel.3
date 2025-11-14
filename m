Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A247FCDE027
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 08:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJp44-0004Lx-7v; Fri, 14 Nov 2025 03:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJp3P-00047F-B6
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:21:13 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJp3N-00085S-8x
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:21:10 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-640aaa89697so2407371a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1763108465; x=1763713265; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yKP2q2n26hyS1LvyZ+r81R1M2eVj1Wbiwe11uS3Mqc=;
 b=ULuFbPsdlkEB49qas6HN4tTn5zVjHcbII+qBbAKN8M+vLDuJD9B9O8NNf5cVzfBPI1
 k1sbDNVcL9+CdgsjTiwflnrbD9mME3HFX7I7D/kuvG4DCfrCyt3XlrB2McI+Owc8AOe9
 iQyXFt9FWZeSX8obMmqHVEcejX022OFot0yEdeN1P2bsgL/ZacyrVVTAJ49Ytb0T3U7G
 xhAQslV9egdT7YZ838ZLjqzQ04k4z26I6rxmb1b+wGv45wWfZsd3pVhO5uiytliJPEqn
 pWoNCXKUhWgOukJGsXG7UOna+zhw6o2mo3l4PS0hXv+ifD4Db2hUosm+gXa8juyscAUF
 uCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763108465; x=1763713265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7yKP2q2n26hyS1LvyZ+r81R1M2eVj1Wbiwe11uS3Mqc=;
 b=VCZKjBP5mFRAWq2KKL0FvUfKU1vb0OxTYuMn1relL+TdInVPpoNu3nm82tjE6UzLPX
 T4R4DQgvlPrlwBj0sCktj8UKwbeeMVZcUooBVI+V1sY30EUTqAnHBNStkrkbT8qXWREX
 JA6FS4G1uIZ6aZRtBAgwaN5JrU5y2Asf1soYAxmglIv66hAhs2SKIoWG/PvsEAlh7qFz
 XXkpDSh6T0bovsGEl00PVU9j0jFIu5nuiqy/BdYQ/7J0jL+kfPj0PIKFYlPg5hmyBHDP
 ZGi/n6JLV6rd9qwbQhmhY2TrSBO4mANCHYr4BVZHc2a+YxqPb8G01S5FrHgfByAssk7H
 Ig9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmlNOe5zo0CMx08DzyuvT1YuVuOHmFvWRDscJEss/3dKUnxHCev1ouFB0t2B08VO+B8Vfpj5UZYs2A@nongnu.org
X-Gm-Message-State: AOJu0Yxv8BMm4+evclesZkCgn1urADHWkGfrWjAUf/E690uX4TFwgde2
 hLz1Ek0fF0+/wKDX4L2Z0t939dXI/yDC8xh0ck+4dyC+RamUJp6v1u1rAweZEBr0wwieKhD3rJX
 LJrGt79KjsxusnHySoK5S0WX3yCN8C8bSFwZu/D3Y
X-Gm-Gg: ASbGncvBcqeoJVBVWqdqttBu37jsT2DFHVzyqWBdVwgG2//rJH7XO2DwVV3YGoLZn6H
 RftHhcxIe2pg16ZMBrldw3SL1hNWvFG010q8lOdVY0/hxVPBp1I3Ydhn30WYfbQRAFQei+ORAKS
 zaPffixmzUaxqdbr7ImqFWht3pZgbtsZD3k2WSUZjTqFNYELN5zkR2gLR6ZM0yVVUf62aCn7JS/
 63yXTLynupVWWJ+ruYRB7kzqFsN7txec5rRF3cQeCXjtRx7FN/ydmxjSy8Q+wL5osSeWC5Fcm2d
 okCW9mtxnt81e9LtGA8=
X-Google-Smtp-Source: AGHT+IHHZjC8tNrXN9ht3/Xt8U5mzYEA24WxyFA9Hye8LypFQf/Kl6y42UYo+T91Oa/VYQlqoHocBWSgja8DwcMgpko=
X-Received: by 2002:a17:907:d0f:b0:b72:b710:cbfd with SMTP id
 a640c23a62f3a-b73678f4784mr192804466b.36.1763108465209; Fri, 14 Nov 2025
 00:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
 <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org>
 <aRH_2gcYOH31UB38@redhat.com> <87ecq5f201.fsf@pond.sub.org>
In-Reply-To: <87ecq5f201.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 14 Nov 2025 09:20:54 +0100
X-Gm-Features: AWmQ_bnYPQscuZUZ982hCSD9uYzGMQYGbn9EhA4X4q6x_Q9xjCNIT0UppeqJIRU
Message-ID: <CAJ307EjFMrXOmQMF5YckQ6hMGdFGtdYdAH3fWShcvwEXAtBrrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52b.google.com
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

On Tue, Nov 11, 2025 at 8:43=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Kevin Wolf <kwolf@redhat.com> writes:
>
> > Am 10.11.2025 um 14:20 hat Markus Armbruster geschrieben:
> >> BALATON Zoltan <balaton@eik.bme.hu> writes:
> >>
> >> > On Mon, 10 Nov 2025, Cl=C3=A9ment Chigot wrote:
> >> >> On Mon, Nov 10, 2025 at 11:07=E2=80=AFAM Markus Armbruster <armbru@=
redhat.com> wrote:
> >> >>>
> >> >>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> >> >>>
> >> >>>> This option tells whether a hard disk should be partitioned or no=
t. It
> >> >>>> defaults to true and have the prime effect of preventing a master=
 boot
> >> >>>> record (MBR) to be initialized.
> >> >>>>
> >> >>>> This is useful as some operating system (QNX, Rtems) don't
> >> >>>> recognized FAT mounted disks (especially SD cards) if a MBR is pr=
esent.
> >> >>>>
> >> >>>> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> [...]
>
> >> >>> Not sure I like "partitioned".  Is a disk with an MBR and a partit=
ion
> >> >>> table contraining a single partition partitioned?  Call it "mbr"?
> >> >>
> >> >> It used to be called "mbr/no-mbr" but Kevin suggested renaming it i=
n
> >> >> V1. Honestly I'm fine with both options:
> >> >> - Technically, the option prevents MBR which has a side effect for
> >> >> preventing partition tables
> >>
> >> Yes, because the partition table is part of the MBR.  I'd rather name
> >> the option after the entire thing it controls, not one of its parts.
> >>
> >> >> - Even it has a single partition, I think it makes sense to call a
> >> >> disk "partitioned" as long as it has a partition table
> >> >>
> >> >> But I'm not that familiar with disk formats, etc. I'll let you deci=
de
> >> >> with Kevin, which one you prefer.
> >>
> >> Kevin is the maintainer, I just serve as advisor here.
> >
> > I figured that the meaning of "partitioned" is easier to understand for
> > a casual user than having or not having an MBR ("I don't want to boot
> > from this disk, why would I care about a boot record?").
>
> Fair point.
>
> Possible counter-points:
>
> * The default is almost always right for the casual user.  The
>   exception, as far as I understand, is certain guest OSes refuse to
>   play ball with certain devices when they have an MBR.
>
> * The configuration interface isn't exactly casual-user-friendly to
>   begin with.  @fat-type, what's that, and why do I care?  @floppy,
>   what's that, and why do I care?
>
> Anyway, you decide.

AFAICT, there are two open questions for that patch:

1. "mbr" vs "partitioned".
I do think "partitioned" is clearer, a bit more casual friendly. "mbr"
requires knowledge about FAT format, while what's a partition should
be known by a wider audience.
Side note, in V3, I'll remove the "unpartitioned" keyword to simply
replace it by "partitoned=3Dfalse" (I wasn't aware such an obvious
possibility was working...). So we might even call it
"partition/partitions=3Dtrue|false".

2. The default value. Should it be "false" for @floppy ?
IMO, having a default value independent of other arguments is always
better. Hence, I'll push for keeping "partitioned=3Dtrue" as the
default, and having users forcing "partitioned=3Dfalse" for floppy (an
error being raised otherwise). As we'll probably change the default
behavior with floppy anyway (cf patch 2), I don't think it will hurt a
lot to make users passing a new flag.

> > But if people think that "mbr" is better, that's fine with me.
> >
> > The only thing I really didn't want is the negative "no-mbr" and the
> > double negation in "no-mbr=3Doff" that comes with it.
>
> Yes, negative names should definitely be avoided for boolean options.
>
> [...]
>

