Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C89BC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wgB-0006CC-MK; Mon, 31 Aug 2026 03:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x0wgA-0006Bn-4Y
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:43:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x0wg7-0005X5-Ra
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:43:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c160420289bso407203766b.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788162218; cv=none;
 d=google.com; s=arc-20260327;
 b=Ekgngp3Yec28+0hRUjPl4piLQWHcR+p8eyM1EOr7eI7qg99R4VWPKDEgFfXpfMPMP/
 ETpsnkmQ6BKt/fRttLz1zptRZsU9hkqaFfdZE4fNNIMqT7ah+TIQwloHtKoI5otKaXwx
 XsMaFZb1iWzngXBZ0rwijBxImvh/HCimdu+Ma8V4efHgMkNxhddjLN90hKb3hGjQvbw2
 5OVsW1oRPOzpI7aeJSbTu+4jGFEwG1r8jr6uENi3H7GuNoLBF2E7o3bY7LwEP0dwTeNe
 83JlnU4c0BQG85AA91Cd/jqk/Ktil5wi5iaqc3YD/W+djdKLawHRf82ZfCcyum/OdRbw
 hhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FNpBcFg7nRKFLW+/7mFVi5Ejl7T43u2Qf0KILlfVu0Q=;
 fh=QIdIwkjOEVAhudi9ghQLIyGxlRSaA+Em0viZsaX5lbU=;
 b=YhJHOFwS5En7u0rT7sTE7p+iNyKxw6NXjG0/Ubo/f407bLmr59KCf37g6IVUitgpXZ
 q5xnb+SR8J5X5j6QZdea43Es9RueyN9XVA9Gjh3F5+3Yibj9zmr2uxdeqZg+5u9PYCQ9
 rTuvjU0Vz07Ra+TdIPbJ+GOl5JXUL6YYsJjIUSbcBv4c96qxTVPhuW3TNtAlsQGTl38g
 PYo7ghWNh6Y2W8Ga3DxXxms4byqa/vSBWhkMciawJ9yZvj/L+deHRQd/pwmQUilTxwaH
 KUGZF1e31LjpbU9uvowx/FXrNu0seU0h2mBq6dtT5Hp783pZia4bfduNXDz3h6gIfofu
 tDfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788162218; x=1788767018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FNpBcFg7nRKFLW+/7mFVi5Ejl7T43u2Qf0KILlfVu0Q=;
 b=JOzfVETCqy37fzL1Fqopeui8HXD1KanJG9Te6Zj1nN+jCRy1CsQDCqpJOEPSIFR+ch
 xfzp4LKYyYh0805keOGj06+VPw6NbseGwtwKNTScFzkZcXl8Ky8BzwA2uHzH2fVyxaIA
 8P2CP0/baXAwVRNMj4XVYu5g6eLLvfpfmRUHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788162218; x=1788767018;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FNpBcFg7nRKFLW+/7mFVi5Ejl7T43u2Qf0KILlfVu0Q=;
 b=rCoHjWixUj/HKsYXOln08mUz9mqb1ie7ToC+0Cw+W/E+/L9xjQHAKOAQ2f+Yut3nuD
 vEFbj+cNCimuCVugN8m0Y/kRbnSt4/fh1a5WjFYiFqJBwXBHmlEwaWmZJxCgvzU3B92X
 dGsST6YemSWdtZRbOxFda0ok9pH0RSE7wR2Ra5J8zbT5vrMptGEcAeDhKUqUMcRstEk7
 l9CZTtxmxZaAwyD7XKmn5NBrEEWIXO8xJJaWLfWyqNO5Iy0hyMrVbHLbgHsIOlA3kNx7
 +28LrAYvxa7OlJ5jdZHbGl2juaWXQLhq757lNAsz8NtPiVywyHANhgvmTgQ9B1a6lIiL
 dKAg==
X-Gm-Message-State: AFuF++nCTiv6n6xbiyfD5ypW0wg//CkXrCGX/xtJNnKV9RxS+aI6/rj1
 tIYAWqBx4c8fyhWVGtvoU/vil8ajmCFmdSgfPQX1HehztYuNu2X/+CLWaeuJAl3SyqbBKW5wZhh
 iXFRKh+Q3Y55NmnqXCGQhznkCv3vM9G7HnoSNp9T97A==
X-Gm-Gg: AR+sD11bJVC0EmAP3QMCDcQ7UuhfnhOLADjnmlFIFrYbfDYjFFpOE6rHve4tXtfMzKO
 rYCLABK4tj5c4FogsYnkrF0/HeR+2NeiboL15Q5KiyBz51WTJPanZOtyX/lTK5JXWx0VvZjC+QO
 66yXWHrl/zfKa9soaEQl1a5XgNqp6euIpCgmyeNIUXzqtZMoaJY8CblmaBmsCCGs6iWzgtU/mm2
 NXIeUxPrEaOm0OmCFhNM3N2EE0ejI1x47qenPuO9X/HOCeCYzneN2p6lxf9bKoGu6rutXYCPDWy
 4u6YH6CX34nHAA2mQd3zc/sDbB3ApU09C8QYefhneDjaaoXupAuCmXrmH+9jaEXpBXYsQAOVVoj
 m
X-Received: by 2002:a17:907:6092:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c25ab5a0741mr93153966b.23.1788162217597; Mon, 31 Aug 2026
 00:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <CAJqdLrri+kRORx_8cHFhi6cuoVZ1ENup+fprm3XHaVavteHRpQ@mail.gmail.com>
 <CAAjaMXZ80o20S-o7=QbrP+wNKqo==w-9Cc3BfeZGG9DazMTnPA@mail.gmail.com>
In-Reply-To: <CAAjaMXZ80o20S-o7=QbrP+wNKqo==w-9Cc3BfeZGG9DazMTnPA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 31 Aug 2026 09:43:25 +0200
X-Gm-Features: AcwNN1XhiL1Hi17SwYu5iNHT5CAftwUlCygevFgzKQpnl_bWn7MSpXZgI3lN0Mg
Message-ID: <CAJqdLrqi12b4LdhdBywr9JZ0H=dmEJUy8_-JCV7YRU5UmsiRrQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x630.google.com
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

Am Mo., 31. Aug. 2026 um 09:41 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>

Dear Manos,

> Hi Alexander, so sorry for the massive delay but I'm on PTO for a big
> part of August and some of September. Your series is on my priorities
> as soon as I return.

ah, then sorry for bothering you during PTO ;-)
Have a good time!

Kind regards,
Alex

>
> On Mon, Aug 31, 2026 at 10:27=E2=80=AFAM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > Am Mo., 3. Aug. 2026 um 10:12 Uhr schrieb Alexander Mikhalitsyn
> > <alexander@mihalicyn.com>:
> > >
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Dear friends,
> > >
> > > This patchset is aimed to support virtio-sound live migration and bas=
ed on
> > > pre-existing Volker R=C3=BCmelin's patches from qemu-devel lists [1].=
 I tried
> > > to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f5=
3b8a335fc53569.camel@mihalicyn.com/)
> > > if Volker is going to continue his work on this, but received no repl=
y so I
> > > just decided to go forward: take his patches, rebase and resend. Of c=
ourse,
> > > I kept all authorship/tags so I hope that it is fine.
> > >
> > > Testing.
> > >
> > > I manually validated this with Ubuntu 24.04 Desktop VM and found no i=
ssues.
> > > Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/-/p=
ipelines/2626702088).
> > >
> > > Original patchset:
> > > https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c=
0e@t-online.de [1]
> > >
> > > Git tree:
> > > https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration
> > >
> > > Changelog for version 5:
> > > - rebased
> > > - added RWB tags
> > >
> > > Changelog for version 4:
> > > - addressed review feedback from Marc-Andr=C3=A9 Lureau
> > > - and from Manos Pitsidianakis
> > > *there is a detailed changelog under each commit message*
> > >
> > > Changelog for version 3:
> > > - addressed review feedback from Marc-Andr=C3=A9 Lureau:
> > >         - drop VirtIOSoundPCMStream's id field (unused)
> > >         - resurrected error_report(..) in virtio_snd_pcm_start_stop()
> > >         - fixes in "hw/audio/virtio-sound: add stream state variable"
> > >           [ please, look in commit message for details ]
> > >         - added "hw/audio/virtio-sound: remove channel positions fiel=
d
> > >           from VirtIOSoundPCMStream"
> > >         - fixes in "hw/audio/virtio-sound: add missing vmstate fields=
"
> > >           [ details in commit message ]
> > >
> > > Changelog for version 2:
> > > - no code changes (only commit messages)
> > >   followed suggestions from Daniel P. Berrang=C3=A9 (thanks, Daniel!)
> > >   https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
> > >   and added some extra details about what I did with the original
> > >   patches during rebase (for some of them it was simpler and less err=
or
> > >   prone to just drop changes and reimplement them by following the id=
ea
> > >   of the patch, cause base code has changed significantly).
> > >
> > > Changelog relative to the original Volker R=C3=BCmelin's submission:
> > > - rebased:
> > >         - "hw/audio/virtio-sound: return correct command response siz=
e"
> > >                 was dropped as it was already merged
> > >         - "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfe=
r handler"
> > >                 was dropped as it seems to be replaced with another f=
ix
> > >                 https://github.com/qemu/qemu/commit/731655f87f319fd06=
f27282c6cafbc2467ac8045
> > >         - I had to drop all pre-existing Reviewed-by tags cause it wa=
s 2 years since
> > >           this patchset was sent and reviewed and I did a quite signi=
ficant code changes
> > >           during rebase
> > >
> > > Kind regards,
> > > Alex
> > >
> > > Alexander Mikhalitsyn (2):
> > >   hw/audio/virtio-sound: remove channel positions field from
> > >     VirtIOSoundPCMStream
> > >   hw/audio/virtio-sound: drop unused struct
> > >     VirtIOSoundPCMStream.flushing field
> > >
> > > Volker R=C3=BCmelin (8):
> > >   hw/audio/virtio-sound: remove command and stream mutexes
> > >   hw/audio/virtio-sound: allocate an array of streams
> > >   hw/audio/virtio-sound: free all stream buffers on reset
> > >   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
> > >   hw/audio/virtio-sound: add stream state variable
> > >   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
> > >   hw/audio/virtio-sound: introduce virtio_snd_set_active()
> > >   hw/audio/virtio-sound: add missing vmstate fields
> > >
> > >  hw/audio/virtio-snd.c         | 696 ++++++++++++++++++++------------=
--
> > >  include/hw/audio/virtio-snd.h |  26 +-
> > >  2 files changed, 414 insertions(+), 308 deletions(-)
> > >
> > > --
> > > 2.47.3
> > >
> >
> > Gentle ping.
>
> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

