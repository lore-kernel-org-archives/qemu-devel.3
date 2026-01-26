Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6AED1951B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkV5F-0007zX-UI; Mon, 26 Jan 2026 17:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkV5D-0007zH-8Z
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:29:19 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkV5A-00046x-F2
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:29:19 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65819e75691so8742322a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:29:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769466553; cv=none;
 d=google.com; s=arc-20240605;
 b=EqSfCUAty+UKRwkrRjIKFVnBSRq30eYKwRu0t2PpCDjbYgcbZ7ODbRn0UDnCLjjQZS
 Yr3cBbSr2/3pXTKeqtyKCSUBFM37ipTLnlujqUvnIyVOZ1Azm97LaCvsNgTfaebHeEB8
 epnF18+7IIwKqE2ta01jrEh2slFPjf6ixKPwGL9T9l2gSwYcGb5S4QfEzDHUT+fxAbWd
 IWWXKrZwVB8S4i2vkIbw62QqmgfrEcwsmfZKO6PZZsk8teugfXkBZ4+/QL6NlQQWoPqD
 a4+q1MmfdEuRK+naQsnV8tC2+tbakPA5OdFEYbl7wic1q5Y/KkqC3oH9t74ExBiB7SlI
 +JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pZbdeT1pWT2TN4VkrBX4R8t3vE9qLa6Bt2GMpVsv/LY=;
 fh=EV5Jjn7+zMHQlP31mZzEDY79bBCF7WNvOLclF+onpMY=;
 b=kjO9OtQ6vBffVQuHKnTvNOv3qVse1wI8oxPX8VzfjRF9+pZE1smWfRVEGHe7IbIo0+
 ZD2N8uIHtIEaqpCZf6VOABI1Tdf7piiT/wumdZJ50AYVbygvm3/YpbqCvjYH93XEmfBg
 Pi9yMYSa3Vpc0H9U6/NZBO/rp/AtRKtkh6P1UcIr4jqwc79P1jRpoE6JvGa8C9XtpjFq
 PK/VyZMf2F/acpStTB+vCVUUU+5hf4s83kvxXNMu9vknvUc3QYT0DOd0B9PXMaTS6+/W
 94iayz3WUzRyTAW1LJqWYpT+SgTh5Yljuj4vGdf9OPBTp0pLG2aMcnRR3yo+6LYelXmw
 8NPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769466553; x=1770071353; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZbdeT1pWT2TN4VkrBX4R8t3vE9qLa6Bt2GMpVsv/LY=;
 b=FNmU0AnD/aWMl+xjsTUomed89A5Ka3UXdChNWQzV4xGQ5yA38V7Mw7+OTspuRr97Gn
 jy0YqzJGiiRCgCZsV3wDhJrtIvG1xYh2eEsudOu5QfOD00uJeuTCE+Byw0lKowmXBlrT
 Eehu8uCVeDhdaMCs8Lx1FeI4fsxA9AJQJyrG6Lh3xa2QErAZDxfSpyi3MeYQgX6EqhDP
 T5khFGWUFA4SvSbg/Tan2prqz0xbbNJLWpmVaQg7RK+TtXvgJAeBjxxGDCMzzXpuTOtQ
 yD81hmqtcHBIXPm2UA3/Yuj4GLV26Yk99W1NT0aIbzsrfNn6UFeUKGhdro3qfExDv5wg
 Tt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769466553; x=1770071353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZbdeT1pWT2TN4VkrBX4R8t3vE9qLa6Bt2GMpVsv/LY=;
 b=Z7WsND0bF3sFMICvVxj9LMO9kzw4r6MKw6FZUBGSa1azNaCPY7a1aGuyNUWcOoOxCs
 8ziSFhmRC6dyStaweTH5G9ghg+k81pYBYu5cXlpp+395HzOek1USpMRrfsf42xYlWlvg
 /vqtlsJe3O9tKaSZuydmmEMFm1tLt3YEcTWRgvzMhbejG86+l5TDdOknDjyy53MXLG/O
 xp/61Z9HsGxWfJl62lPpIXD2/y1OKB750M+TMJJWprMQ+sGbfmNog1ZDwyVBR5V0YMc+
 iCXUavlVTDFGh2hmTgDqd7bjsrPEEzBN/ykfrf6UPWD7hQ0b8/x6pujFy7UsiSeVCkm8
 JGEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWprkyCHHbZSVvBjarUilk9dgjUg5cfw7KNeiaJZ2s6bqi73HuBRmXjtnk7+G7H6no1Bt2v/+aon2V/@nongnu.org
X-Gm-Message-State: AOJu0YxAOomMAZ8qTlgYIGlRiQsrxQBRjOZVhEfmeIBgwlPRW6DpOs+a
 9XntvdcHvpi0Goi5t6CWSAw6aKCfRRNvv48LdpznZnVgKADsTSUOuEEuadmlHIhhMRiSrU34Jqb
 +ATknoRQiE37GaZpT3TBNH2ALhAgjoZo=
X-Gm-Gg: AZuq6aKSqWmUdLPNQFFvTLLDUmQVJ09A9VHJeRjQRJu8tmEt15ANz8ZvQJMG3Tjeest
 8npNO7PC4wJBku/vkZBUSHte13K5RQ7oN9Bqq2aUh/lvOw1vqj4rtGKlpYpn07O1mstW1pMzePj
 9XEg8+MQIZLUpeU4Ac6ks4utoXgJlVbAUbNzpxoDWKSeKowYGsC+IRbUjubICz+94qi00vPaT16
 BQhxkvBvc4VOC+zFz413iI4EnUX/0qyPq8FaiIQpbfTfHYXopgMGmPh311JOFzOiDigZx96okhl
 f3pv
X-Received: by 2002:a05:6402:510e:b0:658:1689:3f66 with SMTP id
 4fb4d7f45d1cf-658706aa5cemr4017010a12.11.1769466552605; Mon, 26 Jan 2026
 14:29:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 26 Jan 2026 17:29:00 -0500
X-Gm-Features: AZwV_QjeiSGE9qOfd4lomdCKhHJfL1YgEOBHoSe8fPGKDAlY3x6Z0UbEfLbcn0M
Message-ID: <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jan 23, 2026 at 3:44=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Jan 22, 2026 at 7:46=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 1/22/26 3:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi
> > >
> > > On Thu, Jan 22, 2026 at 2:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
> > >>
> > >> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
> > >>> On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > >>>> Once we have written some scripts that can build gcc, binutils, li=
nux,
> > >>>> busybox we've opened the door to be able to support every machine =
type
> > >>>> on every target, provided there has been a gcc/binutils/linux port=
 at
> > >>>> some time (which covers practically everything). Adding new machin=
es
> > >>>> becomes cheap then - just a matter of identifying the Linux Kconfi=
g
> > >>>> settings, and everything else stays the same. Adding new targets m=
eans
> > >>>> adding a new binutils build target, which should again we relative=
ly
> > >>>> cheap, and also infrequent. This has potential to be massively mor=
e
> > >>>> sustainable than a reliance on distros, and should put us on a pat=
hway
> > >>>> that would let us cover almost everything we ship.
> > >>>
> > >>> Isn't that essentially reimplementing half of buildroot, or the
> > >>> system image builder that Rob Landley uses to produce toybox
> > >>> test images ?
> > >>
> > >> If we can use existing tools to achieve this, that's fine.
> > >>
> > >
> > > Imho, both approaches are complementary. Building images from scratch=
,
> > > like toybox, to cover esoteric minimal systems. And more complete and
> > > common OSes with mkosi which allows you to have things like python,
> > > mesa, networking, systemd, tpm tools, etc for testing.. We don't want
> > > to build that from scratch, do we?
> > >
> >
> > I ran into this need recently, and simply used podman (or docker) for
> > this purpose.
> >
> > $ podman build -t rootfs - < Dockerfile
> > $ container=3D$(podman create rootfs)
> > $ podman export -o /dev/stdout $container |
> > /sbin/mke2fs -t ext4 -d - out.ext4 10g
> > $ podman rm -f $container
> >
> > It allows to create image for any distro (used it for alpine and
> > debian), as long as they publish a docker container. As well, it gives
> > flexibility to have a custom init, skipping a lengthy emulated boot wit=
h
> > a full system. As a bonus, it's quick to build, and does not require
> > recompiling the world to get something.
> >
> > You can debug things too by running the container on your host machine,
> > which is convenient.
> >
>
> Very nice! I didn't realize you could export and reuse a container that w=
ay.
>
> I wonder how this workflow can be extended and compare to mkosi
> (beside the limitation to produce tar/fs image)
>
> For qemu VM testing, it would fit better along with our Dockerfile &
> lcitool usage.
>
> I wish a tool would help to (cross) create & boot such (reproducible)
> images & vm easily.

Hi Marc-Andr=C3=A9,
I would like to submit QEMU's GSoC application in the next day or two.
A minimum of 4 project ideas is mentioned in the latest guidelines
from Google and we're currently at 3 ideas. Do you want to update the
project idea based on the feedback so we can add it to the list?
https://wiki.qemu.org/Internships/ProjectIdeas/mkosiTestAssets

Thanks,
Stefan

