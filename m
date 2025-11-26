Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A8AD1039A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 10:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOCJO-0002nX-HM; Wed, 26 Nov 2025 04:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOCJM-0002mn-EG
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 04:59:44 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOCJA-0006nS-IU
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 04:59:34 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so711876666b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764151168; x=1764755968; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztvrIFUR6I4loWKzW9Isao6gbDOdjEZqRSP5BhGTaVE=;
 b=bduO1zzAYOn13ZHKRav3/HVrIxLUlHXgcbg1jofADCq8B3VoXspzxivV9FzY/Mk1xk
 n5yM9s90ZpTa0UsOhmmGkX0cjAwwtNhSaL0i+k1zpSIMx6hftNCdNPpTVmzz3agZQ6sj
 HBmHT8RddSLtUTcsTRMZ/LTB/UbeDhML2ZxodT+R6wO64CileWIO21P0s04WL1CBvWjk
 n5ujfB664CmzZVdCeMIUAMDUjJGwa632mdKJvZP81CzjVR7x1nF7y2sCpweJptO9hwIL
 XTjR3PuNpx/IId1VNNjywL4rnV7gp44rSCCWbm3MMnEHpy47TMuQ3/9kdu0DYHITML8U
 newQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764151168; x=1764755968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztvrIFUR6I4loWKzW9Isao6gbDOdjEZqRSP5BhGTaVE=;
 b=uQ6T+8Pu7URMNryQKRovODw+wUFwICzIYaADDNyhfZ7oiGIR0H51ICqzBqgStsddD+
 SYqBrCOwHDGiTu2GNZcUW8IuBXMMGdpgrT2MmV4n5q6lvau3TavVRjMojzyNJ4q4tox+
 Az28HnpqVR9N3EXcko0Bh2NdggLsUiFfxdoJvVqo8l02siY2nAKLlucs1k+TejWXkho7
 AJVlpG+wnqUbe01/nn9AqKNsNc/V9ADal0mleylSt13sR5AEFzxRiq8PyexMMdJBD6gz
 FXqxdsQSSlZZLhiiBTfwF6psdMTso16Zjn/ctKlvKh49PD+OeYhFiFtOxYcFRpZbJR8I
 9KkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCG4cxnWYqNdh11S4dbsaPmLceNfLw21dJGmw4iSWS6nMHryc0jm5a8ldO7tM0Tb+Fiy5yRUwfeA+P@nongnu.org
X-Gm-Message-State: AOJu0YxUn6Ruq5fnZRAASnRbMYccSqbb5QaUzPRV1JXoL0kgT7SDD/EX
 6er/Y//VdNVcat2FETskNi+4Z+yzW7kax7v/S/YBW/Fg855w/8RV0UcqVvgJnCBdLh0lmsgNavq
 8T+fOnNZgftp2yUrwXg8QC46cTg9mLOuFKG1AGSSP
X-Gm-Gg: ASbGncvfPVYQ59aE5jX0TpFLkeGvu3/xVFMHMPOHdASZ3QyxLvfv9oRxb8IaAZ0xWej
 iZ71Nr7n7p7cymw+dAV/JUHIvMqI9I0WD8invm8IoHrfaV3NjUHiK3WoWhj1HmAKUKjXZL8sL6o
 8n6FTjP0LUtRZSHAn+R7y0JPELa/82ATIZ5CCi2dkNUS1tHesT4illTLC+MNwjAoFNBu+/dykKv
 K/DGzKGwkOtIicq01W88MbLhBMUZyoQw1fXareIy+w91UIed8J6M4cPFrc22yU4af39MXrUHBvo
 9I/wjDatOgS62lP56D/KAH2irn0g
X-Google-Smtp-Source: AGHT+IEyzYVQX/znYchapxU5pqNvBaLspt2km+LvMMJCQ6RdkfK7yv6fZaBUOcy5i+NRH1hq94qUlQQ6Vzw6dc85LKo=
X-Received: by 2002:a17:907:1ca8:b0:b76:4c16:6b06 with SMTP id
 a640c23a62f3a-b76c546d9demr676836666b.1.1764151168379; Wed, 26 Nov 2025
 01:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
 <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org>
 <aRH_2gcYOH31UB38@redhat.com> <87ecq5f201.fsf@pond.sub.org>
 <CAJ307EjFMrXOmQMF5YckQ6hMGdFGtdYdAH3fWShcvwEXAtBrrw@mail.gmail.com>
 <87c7d0d6-8f8f-b6f2-3c81-0b0572dbad2c@eik.bme.hu>
 <CAJ307Eg74VNkYvewc5bnhafD+ccXzALmvS400Gz++8Mx5gcKkQ@mail.gmail.com>
In-Reply-To: <CAJ307Eg74VNkYvewc5bnhafD+ccXzALmvS400Gz++8Mx5gcKkQ@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 26 Nov 2025 10:59:17 +0100
X-Gm-Features: AWmQ_bkpJYPBMosJXcCRskdrSA98PjyANz2-GRk5dtRSdenHrts8NbbHLEhML-0
Message-ID: <CAJ307EjdoHZjSYCt7TKSLo=hqDS7y_azUBYsQszh3cAKG3jU-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, 
 hreitz@redhat.com, eblake@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x632.google.com
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

On Fri, Nov 14, 2025 at 2:47=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:
> On Fri, Nov 14, 2025 at 2:25=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.h=
u> wrote:
> > On Fri, 14 Nov 2025, Cl=C3=A9ment Chigot wrote:
> > > 1. "mbr" vs "partitioned".
> > > I do think "partitioned" is clearer, a bit more casual friendly. "mbr=
"
> > > requires knowledge about FAT format, while what's a partition should
> > > be known by a wider audience.
> > > Side note, in V3, I'll remove the "unpartitioned" keyword to simply
> > > replace it by "partitoned=3Dfalse" (I wasn't aware such an obvious
> > > possibility was working...). So we might even call it
> > > "partition/partitions=3Dtrue|false".
> > >
> > > 2. The default value. Should it be "false" for @floppy ?
> > > IMO, having a default value independent of other arguments is always
> > > better. Hence, I'll push for keeping "partitioned=3Dtrue" as the
> > > default, and having users forcing "partitioned=3Dfalse" for floppy (a=
n
> > > error being raised otherwise). As we'll probably change the default
> > > behavior with floppy anyway (cf patch 2), I don't think it will hurt =
a
> > > lot to make users passing a new flag.
> > [...]
> > 2. Having different defaults for floppy or disk would keep existing
> > command lines working. Otherwise why not make partitioned=3Dfalse the
> > default and let users who need it set explicitly. That would also work =
for
> > most cases without having to type out this option.
>
> Yes, I forgot about that one (though linked to patch 2). If we don't
> change the default size of floppy, the existing command lines will
> stay as is, hence introducing a new mandatory option is a bad idea.
> Overall the tradeoff is "simple default CLI" vs "non-conditional
> defaults". Both have pros and cons and I don't have a strong feeling
> about which ones should be prefered. So, I'll let you, the
> maintainers, decide which one is the best for QEMU, its block devices
> and vvfat future ;)

@Kevin Wolf gentle ping as VVFAT maintainer.
I'd like to have some insights about my 2 questions and the one raised
by Zoltan. V3 doesn't have much modification yet apart from `fat-size`
renamed in `fs-size` for patch 5, so I don't find it worth pushing it
while these questions remain open.

Thanks in advance.
Cl=C3=A9ment

> > Regards,
> > BALATON Zoltan

