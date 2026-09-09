Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCD4C79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GNy-0000AN-HJ; Wed, 09 Sep 2026 07:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x4GNv-00009N-OK
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:22:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x4GNt-0001Wb-Kn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:22:35 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso965968166b.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952952; cv=none;
 d=google.com; s=arc-20260327;
 b=i2tAyz4+FZlk2hEAhMBEDsr/4XGN3q/3VKZw+lxv9+WxyREmPJJWrJ3uOtI8A0Ijhz
 ftXhL4NzaOXpkTZDWHRemg9Jw7RZ6AoFuWF/d1qxZoAzLx8P8SLJwV+Z8X6/v5WzAUvJ
 0hxoEfo4DYWZGMfKuTFauONMF5JVDYQ9EBEX2KP8LnsKCsMcDZGlQCW5rKlnNdIqI31h
 QLEz6f3wtzQXahDpcIVOa7m1nrInd/fNFdIK7qYOdIXgU2WTd/qRgfOtrW0GRMz6QJU8
 vw1693BQH7cZts6nuYgdXI/wqGcrcXZOgSdU4te48B0mQ9EAOpJev6TCYcVSZE6pIu55
 5AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ffSjZ5Zuoa4MDyHYWKeH5cD5VyjvpFyap2w9ogDKsU=;
 fh=QIdIwkjOEVAhudi9ghQLIyGxlRSaA+Em0viZsaX5lbU=;
 b=XpoDjMplgb2U2S/u6hCPSmsitHVW/eZiCAQfNOl+KZsw1aYO8h44oPs8Ukva4QyOaq
 7fFavt9emdcGYjW9GFOvjzlT0hBBKpOQ6g8BVKFBHI5nccx3vzeJOzxDt1EPWbbsfSjd
 YeUrOmcz71ltjnstLc1iYmLLNeBkyk9QVQ5l0cjjFGRAJ01wMWpSQ9u/yS2FQ0+3zRfw
 lQKooXCFvWNPZ/fwG4LzK5doG1gfpxD4whJx71kpPFcIZvMcligKtrjU+oBqKW/6sPTT
 tlaSIsYAowu/bsTPAYT3yr9Ox9M9+PStRwjPMkBwnu0cCIsBdMHxCTF/un/YjNZUhtGj
 VstQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788952952; x=1789557752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ffSjZ5Zuoa4MDyHYWKeH5cD5VyjvpFyap2w9ogDKsU=;
 b=NYRKH6dYLq7PAsmUaJ5o8FdGmsMWH2JuPkKR2JnD3l3jLc53ESHbKgb178lVjv4kmh
 6vjJDGGnaYrwDnrKiSS7Gd4cPai5eRYIYDPzE+lsee1joBkiAEzep2KXhl1bAS2th3hR
 KKhkxLiN+yRpodIx1vKZOQ9YTaXJXaPiXhoNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788952952; x=1789557752;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ffSjZ5Zuoa4MDyHYWKeH5cD5VyjvpFyap2w9ogDKsU=;
 b=C1KZmxiaOyIez52ZOCwK/M5Geugry6v4TZ8iswivi0qK+crvqDxTUjwsxTOgdT8enT
 piY2NDpHVfIoEM+ShXp2dSD7CP4hlYlFaRztDY+uGoapFIqyyUPgYFMRDSLMQaHmQfTp
 brZCXMaLmqWr2pomvjQGRUgrvr3Z1WCf4q3cApagqRv/mictrfNL+JoyYx2GWU1qlUEs
 Q8KjFygLTNdAiKj1RwkzW6kIHvDu+EbTpVQsFMHtQzJsN6vC00O5K3YbrLrokjq7pWMv
 JJ5jWY5zGrm2Q6EBXRlMuKaT0FRRPpJtgFCCAZNeWAAdUclvqWzwhtOinxxNQXGNju0f
 QF6A==
X-Gm-Message-State: AFuF++ndiatcc3Wm/C/cdRJ2SfHKWuSsy+dpCrJRXNwZ0SJ72t5jUmOh
 RZyna3wz7v8uJN7EiXADbXbkglVHmrbQ0Kb2vM90E4Wm3RMGqQG5R4guerKoGaD9dRdLAUBLsee
 wfTLYEvCch3PJsUGEdJvnpjkf0IcnuTCAdbZ0pMAlSQ==
X-Gm-Gg: AYBFou2zRMiAwtpCP3IVv1wuZQy2VJRo/48BSqFZxD0/1nvOXs4C69U5hhGSYyktzPh
 zcpLdtXLApFso6nYIzR2E9Af7rEYriLk3FIaPQ+MgynkPnXvOBfm7cVawV0bsGJcrIOWqDjRbam
 d1TTsZqOkVinEaaQabzc6EXCkfAOadhd8qZyBNaeqwlsudD6GXT7gu+pwgZToopobmsguBs84Zg
 FvJGP6hX4CfYuR9XOWdVlf6/I+DFQs/ppxlguHa9bdIZ0OkEJ+FjNPj3aChIBGw8BczS3JDknhL
 jIWEWEHuB7fX2v9upg0awyBFnqMktCDw8wccQ1lxe15IV8e8ucpZnDg+sgoDYLf4S5fyNidfLZU
 w7vwDkB5i+dk=
X-Received: by 2002:a17:907:9810:b0:c25:c787:43c with SMTP id
 a640c23a62f3a-c25f01f0adcmr1818273766b.14.1788952951847; Wed, 09 Sep 2026
 04:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <CAJqdLrri+kRORx_8cHFhi6cuoVZ1ENup+fprm3XHaVavteHRpQ@mail.gmail.com>
 <CAAjaMXZ80o20S-o7=QbrP+wNKqo==w-9Cc3BfeZGG9DazMTnPA@mail.gmail.com>
 <CAJqdLrqi12b4LdhdBywr9JZ0H=dmEJUy8_-JCV7YRU5UmsiRrQ@mail.gmail.com>
 <tl36cd.2tad1k4jeakw8@linaro.org>
In-Reply-To: <tl36cd.2tad1k4jeakw8@linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 9 Sep 2026 13:22:19 +0200
X-Gm-Features: AcwNN1VNgGwU99DKMscfeP1HrT4ssrnbjfqkbmNnt6_ae6cpAD1cbfklRhc-qMc
Message-ID: <CAJqdLrpqOt8Og+smdt4e-WzW_3WP0k-pi6pFwQxYxQPuhRF8PA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62f.google.com
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

Am Mi., 9. Sept. 2026 um 09:33 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Mon, 31 Aug 2026 10:43, Alexander Mikhalitsyn <alexander@mihalicyn.com=
> wrote:
> >Am Mo., 31. Aug. 2026 um 09:41 Uhr schrieb Manos Pitsidianakis
> ><manos.pitsidianakis@linaro.org>:
> >>
> >
> >Dear Manos,
> >
> >> Hi Alexander, so sorry for the massive delay but I'm on PTO for a big
> >> part of August and some of September. Your series is on my priorities
> >> as soon as I return.
> >
> >ah, then sorry for bothering you during PTO ;-)
> >Have a good time!
> >
> >Kind regards,
> >Alex
>

Dear Manos,

> I think this series is now fully reviewed, I will rebase against master
> and send a pull request.

Thank you very much for all the input and reviews!

Kind regards,
Alex

>
> Thanks!
>
> >
> >>
> >> On Mon, Aug 31, 2026 at 10:27=E2=80=AFAM Alexander Mikhalitsyn
> >> <alexander@mihalicyn.com> wrote:
> >> >
> >> > Am Mo., 3. Aug. 2026 um 10:12 Uhr schrieb Alexander Mikhalitsyn
> >> > <alexander@mihalicyn.com>:
> >> > >
> >> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >> > >
> >> > > Dear friends,
> >> > >
> >> > > This patchset is aimed to support virtio-sound live migration and =
based on
> >> > > pre-existing Volker R=C3=BCmelin's patches from qemu-devel lists [=
1]. I tried
> >> > > to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a471=
6f53b8a335fc53569.camel@mihalicyn.com/)
> >> > > if Volker is going to continue his work on this, but received no r=
eply so I
> >> > > just decided to go forward: take his patches, rebase and resend. O=
f course,
> >> > > I kept all authorship/tags so I hope that it is fine.
> >> > >
> >> > > Testing.
> >> > >
> >> > > I manually validated this with Ubuntu 24.04 Desktop VM and found n=
o issues.
> >> > > Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/=
-/pipelines/2626702088).
> >> > >
> >> > > Original patchset:
> >> > > https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd77=
68c0e@t-online.de [1]
> >> > >
> >> > > Git tree:
> >> > > https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration
> >> > >
> >> > > Changelog for version 5:
> >> > > - rebased
> >> > > - added RWB tags
> >> > >
> >> > > Changelog for version 4:
> >> > > - addressed review feedback from Marc-Andr=C3=A9 Lureau
> >> > > - and from Manos Pitsidianakis
> >> > > *there is a detailed changelog under each commit message*
> >> > >
> >> > > Changelog for version 3:
> >> > > - addressed review feedback from Marc-Andr=C3=A9 Lureau:
> >> > >         - drop VirtIOSoundPCMStream's id field (unused)
> >> > >         - resurrected error_report(..) in virtio_snd_pcm_start_sto=
p()
> >> > >         - fixes in "hw/audio/virtio-sound: add stream state variab=
le"
> >> > >           [ please, look in commit message for details ]
> >> > >         - added "hw/audio/virtio-sound: remove channel positions f=
ield
> >> > >           from VirtIOSoundPCMStream"
> >> > >         - fixes in "hw/audio/virtio-sound: add missing vmstate fie=
lds"
> >> > >           [ details in commit message ]
> >> > >
> >> > > Changelog for version 2:
> >> > > - no code changes (only commit messages)
> >> > >   followed suggestions from Daniel P. Berrang=C3=A9 (thanks, Danie=
l!)
> >> > >   https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
> >> > >   and added some extra details about what I did with the original
> >> > >   patches during rebase (for some of them it was simpler and less =
error
> >> > >   prone to just drop changes and reimplement them by following the=
 idea
> >> > >   of the patch, cause base code has changed significantly).
> >> > >
> >> > > Changelog relative to the original Volker R=C3=BCmelin's submissio=
n:
> >> > > - rebased:
> >> > >         - "hw/audio/virtio-sound: return correct command response =
size"
> >> > >                 was dropped as it was already merged
> >> > >         - "hw/audio/virtio-sound: fix segmentation fault in tx/rx =
xfer handler"
> >> > >                 was dropped as it seems to be replaced with anothe=
r fix
> >> > >                 https://github.com/qemu/qemu/commit/731655f87f319f=
d06f27282c6cafbc2467ac8045
> >> > >         - I had to drop all pre-existing Reviewed-by tags cause it=
 was 2 years since
> >> > >           this patchset was sent and reviewed and I did a quite si=
gnificant code changes
> >> > >           during rebase
> >> > >
> >> > > Kind regards,
> >> > > Alex
> >> > >
> >> > > Alexander Mikhalitsyn (2):
> >> > >   hw/audio/virtio-sound: remove channel positions field from
> >> > >     VirtIOSoundPCMStream
> >> > >   hw/audio/virtio-sound: drop unused struct
> >> > >     VirtIOSoundPCMStream.flushing field
> >> > >
> >> > > Volker R=C3=BCmelin (8):
> >> > >   hw/audio/virtio-sound: remove command and stream mutexes
> >> > >   hw/audio/virtio-sound: allocate an array of streams
> >> > >   hw/audio/virtio-sound: free all stream buffers on reset
> >> > >   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
> >> > >   hw/audio/virtio-sound: add stream state variable
> >> > >   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
> >> > >   hw/audio/virtio-sound: introduce virtio_snd_set_active()
> >> > >   hw/audio/virtio-sound: add missing vmstate fields
> >> > >
> >> > >  hw/audio/virtio-snd.c         | 696 ++++++++++++++++++++---------=
-----
> >> > >  include/hw/audio/virtio-snd.h |  26 +-
> >> > >  2 files changed, 414 insertions(+), 308 deletions(-)
> >> > >
> >> > > --
> >> > > 2.47.3
> >> > >
> >> >
> >> > Gentle ping.
> >>
> >> --
> >> Manos Pitsidianakis
> >> Emulation and Virtualization Engineer at Linaro Ltd

