Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A09C7113E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPR1I-0006N4-Pc; Wed, 11 Jun 2025 15:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPR1H-0006Ms-3B
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:21:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPR1F-0000oy-7A
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 15:21:54 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so531165a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749669711; x=1750274511; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwz44GEUT3ZCSN76rbHNV9dQ+12xKYJ0ba5kBVe8jYE=;
 b=GNhBLGTA3kHPVBhrje2le5U01zuRlETZEOADdU0fH0xoMVjCqk7A3ebWCeFD8w7zZ3
 eBddqkg+xPAtUQ/sTIkF/VDWzX1gtjeLpKiRl3DW0gBShTtodN/Zsen59A01l2Edo5+Y
 JHizilOBvumOLpxWbqBuploILH9yclUCh1pv9mRWTRHHVZ+fP0P03Fn/Df203Od4YavQ
 IaZiIMaXmkGy024bRQrbjHHoq3PFy0NC3gD4SppuvDQlANFcUGHvdvyoPcDohlkIDvyP
 FgQXKZmNj1g2m+IBm7DIITDpe6goMj5V7l6ncAKc2hAr5J9avAlTtLyIQqKwVfSvw8Kd
 eFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749669711; x=1750274511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwz44GEUT3ZCSN76rbHNV9dQ+12xKYJ0ba5kBVe8jYE=;
 b=FejhPbSkZ7MXWAcR30cWp7YID27/IRY0YKaO2n+pR4cYTqepUElJKUiWZTZuldWz4Y
 VLYBpuaChNzpzKsO4xTmM4UkwGQ+Cry8770zsi60SiJNxg2s33qMSnKWGTRVvyh50nAX
 TWhnvn0sm3HjlTH8np6CLhjDnUNPaBuKcOWIYBV+D2OSk9wk75UyodbEXnzCJ2akXxiz
 kLYCilCYcRxwLMw1GMpN04+XNolv9BmcixauA/rk1ki1gGjnuxODiAwT/zu/9nhJjICk
 w9FOm0VQ1k99oucJX00dHy3vkneurjRyDEpuNKcRVdfwBGy5vRIU/mXn/3FrzL4ozrCT
 XHVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgdWVReXOoAK8+aiabIo+5skZUxgdNk6ZpfCQQWVRv8pv4qy3a322qtvixQdxtVWgtv1TwetURaYOW@nongnu.org
X-Gm-Message-State: AOJu0YwBT7gIXGonz7aFCXNMvf2FG/A/i9oWR8CqFEnOodgCDVma6Wbu
 PBmZYUBQ6grf6u29ra5CiHcZm0QIpeNabWYJX5nhx6rYL8gIOphpfqfjRAL+1T9gpVdTgBqj3TV
 aTdG8ITq7VUnm5rheaTKmwEjJjVeXAuAUOw==
X-Gm-Gg: ASbGncsa1uLOU16fiyQ5oiNMp/HTjHy+vmG8kCbmzR0f5ZuE4Xe0z9VLJXttfjn6/IS
 j3NvvizG5WjZzMqjjE0I6nZ5IbVCE54/3YFQlnRpRVaA7usZeKZBxVwKorO2oAnJMBJ+LgOR9we
 d3qgMvHciKlb+Y0/y+VR9Yw+/pkVq0Ue+Gj9mDzHx36w==
X-Google-Smtp-Source: AGHT+IHNPPnah2cqbNyaDNBiNXuSGgk3YZkuLxREFsD2SuvwinBPKMphLl5ib25VVK38mwFT9qWKNLm/blBMY35oKXo=
X-Received: by 2002:a05:6402:2399:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-6086754ed6fmr330272a12.30.1749669711028; Wed, 11 Jun 2025
 12:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <aEnEiqfa57eH53Gf@redhat.com>
In-Reply-To: <aEnEiqfa57eH53Gf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Jun 2025 15:21:38 -0400
X-Gm-Features: AX0GCFu8BmkTztJ3OjZiz3Kke5oN9p7eH89zPXpLAKxdajTJdEMuc74oe0WgYmI
Message-ID: <CAJSP0QX7pcNTz_uSdMBzDhTRbUkrmmSPziBs82-GscRHM-xiug@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Jun 11, 2025 at 2:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> FYI, this seabios 1.17.0 release appears to have broken the
> ability to use virtio-pci with libguestfs+QEMU:
>
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D2372329
>
> so I'd suggest we hold off on this pull request until
> the regression is diagnosed.

Thanks, Daniel. I have pushed a revert to staging.

Stefan

>
> On Wed, Jun 11, 2025 at 09:50:35AM +0200, Gerd Hoffmann wrote:
> > The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600=
c40f:
> >
> >   Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.=
com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-pull-=
request
> >
> > for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952de1=
:
> >
> >   seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
> >
> > ----------------------------------------------------------------
> > seabios: update to 1.17.0 release
> >
> > ----------------------------------------------------------------
> >
> > Gerd Hoffmann (2):
> >   seabios: update submodule to 1.17.0
> >   seabios: update binaries to 1.17.0
> >
> >  pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
> >  pc-bios/bios-microvm.bin          | Bin 131072 -> 131072 bytes
> >  pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
> >  pc-bios/vgabios-ati.bin           | Bin 39424 -> 39424 bytes
> >  pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
> >  pc-bios/vgabios-cirrus.bin        | Bin 38912 -> 39424 bytes
> >  pc-bios/vgabios-qxl.bin           | Bin 39424 -> 39424 bytes
> >  pc-bios/vgabios-ramfb.bin         | Bin 28672 -> 28672 bytes
> >  pc-bios/vgabios-stdvga.bin        | Bin 39424 -> 39424 bytes
> >  pc-bios/vgabios-virtio.bin        | Bin 39424 -> 39424 bytes
> >  pc-bios/vgabios-vmware.bin        | Bin 39424 -> 39424 bytes
> >  pc-bios/vgabios.bin               | Bin 38912 -> 38912 bytes
> >  roms/seabios                      |   2 +-
> >  13 files changed, 1 insertion(+), 1 deletion(-)
> >
> > --
> > 2.49.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>

