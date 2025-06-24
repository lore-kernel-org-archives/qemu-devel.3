Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD0DC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 16:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU6Vl-0001Mf-Pn; Tue, 24 Jun 2025 12:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uU6Vj-0001MD-5P
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:28:39 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uU6Vh-0007MU-29
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 12:28:38 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3137c2021a0so675797a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1750782515; x=1751387315;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zt6AYzfONTJzp4QyyVjiNAZF2nGdfB2H83PviQv/aSw=;
 b=lvYJApJEh5RtwxKMbTqcTr1ijwNWxfV4EDe/R8vI1j9WGJ06g8gHLijpLEDXCZFP80
 uXc4rZXuDuOb6rh2T0DsORxo9qLea5Qu3XD1+w4vbyxAqnMv0Xjt79l8N1hEio3RTmOs
 ZNntpkUTSOW//h6LmB0qKpYoGfcVhfDaEXCdzvLzGTxFr7zEEbWcl9WZ3+hwgC5i9yZl
 bOVJZ4bw5+tVNjftx7Vsirn0k8hLWSHWURdMJMz9vs4vBpSFApKft7R3jikECFpty47U
 s2zl+GZ2U9COZWobPlJFWEoiNQgQPuZIyMixxoXdEcqoBQjTgh59T3MMM6up/61Ns2Q+
 n39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750782515; x=1751387315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zt6AYzfONTJzp4QyyVjiNAZF2nGdfB2H83PviQv/aSw=;
 b=POjLaNyDOkdBL9KMI9EFfhf0rlLt4yGkEMUxQS93vKkuCi1J0O5LdaYOsW1NjS5aHH
 l+rrj4aK3YjbQE2VjFFROQgvvvZXACmDxJl5HbXp0pgdcFjp/CvA7hbag0zu6Zlqtu9Z
 Mi32jb5pGxLYQQe3rtrtQOlqENHxyUSckT4FEmtaKDw0lW71VRMtkVgeZ8rsDd8te3Ke
 iRDqSjRh4A+8elgs3Q0oFX65vvj6vtO7F+c0B88ZuDpxFHTV2jKpUCIPABYYAqOHJ+Ka
 K3Ras/j3aIa0tOyJLgYdCrepaO2Npm3F/UEW07mq7/TJcFKCsSVji5VYLOQdCyS8ws6w
 QyDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3w8ZWOJ3hO0FWJoLgqAESV4pCeQjfMUbO2JiJyKunCWx0OQhiU8CYmXzl3rjaYDgGCEAou+t795TA@nongnu.org
X-Gm-Message-State: AOJu0YxsVnzXBw+jgYkhtysQA6J97f09B4vJX1XU929/gVScXVns1zOc
 oQDUB92jbiAW8bZKLsaiFlL7SnvaNqSoc2GbwitIeVX5cwZlMG1ZoMx5CJl5baP07jgEIocEJuL
 6byTNGew9bUnLfaca/u7fCNw+FblHgpCQCkQxFtLk4Q==
X-Gm-Gg: ASbGncthrQCfHN7Mmx+c9UnYVheM3Nyckil3HezOnwn18F8d5VK35iPSDlDBxkhVWRP
 TqWvXtd2YpXDN1EbCoVMl8wJ6NovYVGd/cJDzho71aBQFzDjgLD2f78eokwARKKyQFKGEfPdusj
 6EIo8LJEc7f3IwIEUc3ymh5x+1CmTaPU4Jwvoq+gWyjyBO
X-Google-Smtp-Source: AGHT+IE0bc5nytY8CIFIlt/WrGJGi5vbLv90ySuOMYNDaWpj3dXBs8cbIJc+8FplT7Z+yJu5qsYFuDA/vgNsG9upZ3E=
X-Received: by 2002:a17:90a:e704:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-315aa289688mr24216223a91.24.1750782514888; Tue, 24 Jun 2025
 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
In-Reply-To: <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Jun 2025 10:28:23 -0600
X-Gm-Features: AX0GCFu2C4bt6N2POkLvXBZbzDREhcHhZkPmIBH_EQlHwhh9NvEW4sYQvc16vyo
Message-ID: <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 24, 2025 at 10:02=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 22/06/2025 03.46, Warner Losh wrote:
> >
> >
> > On Sat, Jun 21, 2025, 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om
> > <mailto:stefanha@gmail.com>> wrote:
> >
> >     On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefanha@g=
mail.com
> >     <mailto:stefanha@gmail.com>> wrote:
> >
> >     (I forgot to CC qemu-devel)
> >
> >      >
> >      > Hi,
> >      > This might only be temporary, but the CI is getting HTTP 404 Not=
 Found
> >      > for the following URL:
> >      > https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/1=
4.1/
> >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso <https://
> >     download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/
> >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso>
> >      >
> >      > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848
> >     <https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848>
> >      >
> >      > Stefan
> >
> >
> > Time to bump the version to 14.3.
>
> Hmm, while we're used to refresh the CI images for the *host* environment=
s,
> it's rather ugly to see images for the *guests* of the functional tests
> disappear. Maybe we should rather remove that test if the URL is not stab=
le?

Yes. Most of our images have a shelf life of about a year to 18 months. And=
 QEMU
should be testing all the 'supported' FreeBSD images, just like for
other projects.
The question becomes how can we, the FreeBSD Project, remove the friction t=
hat's
here now because we timeout / move the older images as they pass out of sup=
port.

We've also just shifted to a more frequent release cadence, so the
releases have gone
from living for  18-24 months down to just 12. We just released
FreeBSD 14.3, and 14.1
is only a year old. So what's the best way of dealing with this? We
could have a 14-latest
but the md5 would change...

So I'm open to making a change, but I need help crafting something
that will work, since
I'm not clever enough to suggest something here.

Warner

