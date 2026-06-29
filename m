Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C52C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAiZ-0001rX-09; Mon, 29 Jun 2026 08:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1weAgB-0007Ao-VJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1weAg9-0007mf-0n
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47362928f65so860653f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782734492; cv=none;
 d=google.com; s=arc-20260327;
 b=RiupAXy+Omo/daQHpY5n/77hKxLwkqdI9H6J0ShLP832bc3T+VI6FMOUlQcBkTtl+c
 RQWMFrIoqVqbB/J9LsVxQ0wKHZR+G69KDmMFsKXu9+zMseU1FnjZkvLXTxmd7VGW+zcW
 kR4dvwLaE1a2IptxkIQem1/XZW9mhNg9a5sPkFF12y5A2Z4triaJOOPVOOfoa3XqgFZs
 BsbJ/h5A53B1jFnw/El95oTWU+pslOqiT4tZZuabWBkFB7oD8mMa8TXZ9iwtpsFE1XL6
 DOb6dQHJH269aj7j0bAUDgUZm+dWM1EGQelorzpF+MU2fYc43LHjyM4G5lFddRG0w4A4
 47AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gqE4D1/c18zHfiu8KnIhjq7ZyZs0Olnm0rRW7CetrCA=;
 fh=CukSOekYFEZMpB8oD5eSkKAGPk+P/7dxmT6gKBA6EdM=;
 b=TxXpt7BUGsXAksa+aGnBY+TTFlcArCZeCFXmfmQTYDVBRON6Tif/ayyW6oOa7Sl8j9
 xlSv7rSaZl1jIoB5QZHxdxs0ivQh7aFLG7PG0HHEDztmJ92vccIZD9hjdGbo46QBhMST
 RYfHPkcF4AzgObzqg1Kf7oS39fgiWTi4HqWDSI1vSthc6md3dqI067zqQsY4MBMQaAkZ
 cSUOTma+36Z4UDr56YmlTtF5vAmssw0L+6ut+grv9+qeAr/W9TNaHObCok/0cG3ZOPfq
 hQAQNzOeWacQsV6YvfbC0aUPLzj6yAVi0dGemAB+Rd56ginPc7M7SDHiuZMkzKJNGEO6
 rryw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734492; x=1783339292; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gqE4D1/c18zHfiu8KnIhjq7ZyZs0Olnm0rRW7CetrCA=;
 b=m4oeFRYEZ0cZFIxgKKyd7tS7+FoO2YjIXRU+cpbg6ru6tF1WcIdJ1voYLiRDXyRojK
 86EiYlERAPsyNmYh/43clQwHnAxWvjkBdr+SakioVLvjVK5qvKPoJOON8A0Mw/K8/lqJ
 XCTaYZCCEvJ2TBhBrU3y8as18vXvZrq2say5mP6Aj/GxqOVu5HezssyYtqc705Q4Kr0z
 7y4tQpCE1eXT43wkSp6l0Nx91l2gn17pUp5mwpzRLXhKEIXZXGMInbGv931tiZl8tYG2
 +07Oa6iiUvcw5PdEzxpMhNGEzb0cQHkwISO4e1j9UaNvyHXVyBOnANUDmlZyfV1BM7Ym
 NGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734492; x=1783339292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqE4D1/c18zHfiu8KnIhjq7ZyZs0Olnm0rRW7CetrCA=;
 b=BzVZjsoYTaurwx4MtaL+TRxF42OBKngQQU8FJIqCjYFly0/5bf+/FOfguWVp0vDmCX
 M6OsNPjySScIN0lO/UoYE0kEBWQub/c7YQaaDzCFKaTbxXf3ePIbIUE0/cg5kYiVPLTO
 vkuj0gkwoyONp5jYU4lO5sYhXtC6W1mrYSUJu2ZDwIIDeIWW/KXCuFFxSKAhlDDB7wiY
 t2Yt7UH4bcjkMDhrmVm1UU/k6THpR+khReW7wMLl9qgibRmfFCdb7gIYvNMqk0nQY86u
 JavxxtIaoEtLkLTc0xpoxtkVXwDZ9ZEFhVgr/hn2GDwOdS7Xa70Ta9+oTbF7vU+wAaIu
 KDIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpirh1NX53Ues6pFyEzS2gThjhRlmbjcL1hQuGQhTzu3xw9hFX+ZmsxEs9Jte0ENCe0jmfAM8a7/duh@nongnu.org
X-Gm-Message-State: AOJu0YwVpdz6OJNPtoPOwYGTzmvXjCMPXb1iXL+pqIABzhpn2M7ORle1
 fgdS/o0AEQ0vmMnxkQKSntgB+s4+Fkm6JrdO3KZ8t4VcRZNLMTXGmumIfZfT66sOJP7XR2cZCnF
 i/QFRilXWUCxu2BdPuzII5ch9FO/F0+Ljyl+hYb+s3g==
X-Gm-Gg: AfdE7ckwzrapNH4wCmaVYYWgAzGSG19LukwedbJTqy5RX7y5PiQxsD3T7lhldnZo9Ti
 uFGlLSPm2CW3E2H17oQ2qcLygetnGzCgQeGW64OFSRkXljtnZ10kTnTUkJnFLmptUQ9x/rOaj+1
 PMuyAlt7jz7dItpBpXB+yZKRpPq8E/lTO9YllWZ215pI1PVtVUs1IwLxfbihanud5eer116lZvQ
 vHHKjlvy55ANmbie84/9k0noxL6opH4KWDotroAe43AWRVIbC7XsXW6rViTxtTyrjegejYSOARl
 VKBQsrGcrO+flG02GgTuro/StCvMdedMi823L7hj3KB5hPBie3ZhcwOEPx4GvjhzO6HVdbTn5as
 d7zNPTkQqs1OvrrMy+N4=
X-Received: by 2002:a5d:64c6:0:b0:472:7ded:6aef with SMTP id
 ffacd0b85a97d-474febcd3d4mr298326f8f.2.1782734491244; Mon, 29 Jun 2026
 05:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2-jr2XBTby4zqf6CTA@mail.gmail.com>
 <CH3PR12MB8481967103B141D5CE6E0BED8EE82@CH3PR12MB8481.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8481967103B141D5CE6E0BED8EE82@CH3PR12MB8481.namprd12.prod.outlook.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Jun 2026 15:01:18 +0300
X-Gm-Features: AVVi8CfdDdUAYXoDbF1nEExRIdM_ymRXVXKaGUxP7kMEr9z2ao5SJGt59CZVK4w
Message-ID: <CAAjaMXaRNKF1hdJNoNgroy0iea3SsNO-nAfBHX5zGMVvbf2Brw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] hw/audio/virtio-sound: basic migration support
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000147ab80655633865"
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000147ab80655633865
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026, 14:32 Aleksandr Mikhalitsyn, <
aleksandr.mikhalitsyn@futurfusion.io> wrote:

> Dear Manos,
>
> (replying from my @futurfusion.io address)
>
> I'm using my personal email address hosted at Gmail, cause it works just
> well with plain text email and does not corrupt patches.
> While Microsoft Outlook (behind futurfusion.io) doesn't work that good,
> so I still do SoB tags with my work email, but send
> them through Gmail servers. Hope it is fine.
>

Ok, that is good enough proof for me! No need to do anything different then
for future revisions.



> I'm ready to do all necessary actions to proof that these two email belon=
g
> to me, for example I send my series from
> my Gmail and then reply from futurfusion.io with some ACK to prove that
> it's me.
>
> Also, in Linux kernel I have a proper email mapping:
>
> https://github.com/torvalds/linux/blob/dc59e4fea9d83f03bad6bddf3fa2e52491=
777482/.mailmap#L38
>
> P.S. Sorry for doing non-inline reply, it's again because of terrible
> Outlook.
>
> P.S.2. I'll continue my work on patches next week, cause I'm currently
> away from home on vacation. ;)
> Huge thanks for such a fast review of my patch submission!
>
> Kind regards,
> Alex
>
> ------------------------------
> *From:* Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> *Sent:* Monday, June 29, 2026 13:04
> *To:* Alexander Mikhalitsyn <alexander@mihalicyn.com>
> *Cc:* qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Volker R=C3=BCmelin =
<
> vr_qemu@t-online.de>; Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>;
> St=C3=A9phane Graber <stgraber@stgraber.org>; Daniel P . Berrang=C3=A9 <
> berrange@redhat.com>; Gerd Hoffmann <kraxel@redhat.com>; Michael S.
> Tsirkin <mst@redhat.com>; Aleksandr Mikhalitsyn <
> aleksandr.mikhalitsyn@futurfusion.io>
> *Subject:* Re: [PATCH v3 0/9] hw/audio/virtio-sound: basic migration
> support
>
> Hi Alexander,
>
> On Fri, Jun 26, 2026 at 3:35=E2=80=AFPM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Could you please send your patches from your
> aleksandr.mikhalitsyn@futurfusion.io address for the next revision?
> Replying to review comments with your personal email is fine, but the
> s-o-b should match your sending address. We do not know if the address
> belongs to you otherwise. This is not explicitly stated in our Code
> Provenance documentation but we need a way to verify your S-o-b
> provenance.
>
> Thanks,
>
> >
> > Dear friends,
> >
> > This patchset is aimed to support virtio-sound live migration and based
> on
> > pre-existing Volker R=C3=BCmelin's patches from qemu-devel lists [1]. I=
 tried
> > to ask (
> https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a335fc535=
69.camel@mihalicyn.com/
> )
> > if Volker is going to continue his work on this, but received no reply
> so I
> > just decided to go forward: take his patches, rebase and resend. Of
> course,
> > I kept all authorship/tags so I hope that it is fine.
> >
> > Testing.
> >
> > I manually validated this with Ubuntu 24.04 Desktop VM and found no
> issues.
> > Also, it was validated with CI (
> https://gitlab.com/mihalicyn/qemu/-/pipelines/2626702088).
> >
> > Original patchset:
> >
> https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e@t=
-online.de
>  [1]
> >
> > Git tree:
> > https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration
> >
> > Changelog for version 3:
> > - addressed review feedback from Marc-Andr=C3=A9 Lureau:
> >         - drop VirtIOSoundPCMStream's id field (unused)
> >         - resurrected error_report(..) in virtio_snd_pcm_start_stop()
> >         - fixes in "hw/audio/virtio-sound: add stream state variable"
> >           [ please, look in commit message for details ]
> >         - added "hw/audio/virtio-sound: remove channel positions field
> >           from VirtIOSoundPCMStream"
> >         - fixes in "hw/audio/virtio-sound: add missing vmstate fields"
> >           [ details in commit message ]
> >
> > Changelog for version 2:
> > - no code changes (only commit messages)
> >   followed suggestions from Daniel P. Berrang=C3=A9 (thanks, Daniel!)
> >   https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
> >   and added some extra details about what I did with the original
> >   patches during rebase (for some of them it was simpler and less error
> >   prone to just drop changes and reimplement them by following the idea
> >   of the patch, cause base code has changed significantly).
> >
> > Changelog relative to the original Volker R=C3=BCmelin's submission:
> > - rebased:
> >         - "hw/audio/virtio-sound: return correct command response size"
> >                 was dropped as it was already merged
> >         - "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer
> handler"
> >                 was dropped as it seems to be replaced with another fix
> >
> https://github.com/qemu/qemu/commit/731655f87f319fd06f27282c6cafbc2467ac8=
045
> >         - I had to drop all pre-existing Reviewed-by tags cause it was =
2
> years since
> >           this patchset was sent and reviewed and I did a quite
> significant code changes
> >           during rebase
> >
> > Kind regards,
> > Alex
> >
> > Alexander Mikhalitsyn (1):
> >   hw/audio/virtio-sound: remove channel positions field from
> >     VirtIOSoundPCMStream
> >
> > Volker R=C3=BCmelin (8):
> >   hw/audio/virtio-sound: remove command and stream mutexes
> >   hw/audio/virtio-sound: allocate an array of streams
> >   hw/audio/virtio-sound: free all stream buffers on reset
> >   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
> >   hw/audio/virtio-sound: add stream state variable
> >   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
> >   hw/audio/virtio-sound: introduce virtio_snd_set_active()
> >   hw/audio/virtio-sound: add missing vmstate fields
> >
> >  hw/audio/trace-events         |   3 +-
> >  hw/audio/virtio-snd.c         | 679 ++++++++++++++++++++--------------
> >  include/hw/audio/virtio-snd.h |  26 +-
> >  3 files changed, 399 insertions(+), 309 deletions(-)
> >
> > --
> > 2.47.3
> >
>
> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>

--000000000000147ab80655633865
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 29 Jun 2026, 14:32 Aleks=
andr Mikhalitsyn, &lt;<a href=3D"mailto:aleksandr.mikhalitsyn@futurfusion.i=
o">aleksandr.mikhalitsyn@futurfusion.io</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Dear Manos,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
(replying from my @<a href=3D"http://futurfusion.io" target=3D"_blank" rel=
=3D"noreferrer">futurfusion.io</a> address)</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
I&#39;m using my personal email address hosted at Gmail, cause it works jus=
t well with plain text email and does not corrupt patches.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
While Microsoft Outlook (behind <a href=3D"http://futurfusion.io" target=3D=
"_blank" rel=3D"noreferrer">futurfusion.io</a>) doesn&#39;t work that good,=
 so I still do SoB tags with my work email, but send</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
them through Gmail servers. Hope it is fine.</div></div></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Ok, that is good enough=
 proof for me! No need to do anything different then for future revisions.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
I&#39;m ready to do all necessary actions to proof that these two email bel=
ong to me, for example I send my series from</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
my Gmail and then reply from <a href=3D"http://futurfusion.io" target=3D"_b=
lank" rel=3D"noreferrer">futurfusion.io</a> with some ACK to prove that it&=
#39;s me.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Also, in Linux kernel I have a proper email mapping:</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<a href=3D"https://github.com/torvalds/linux/blob/dc59e4fea9d83f03bad6bddf3=
fa2e52491777482/.mailmap#L38" target=3D"_blank" rel=3D"noreferrer">https://=
github.com/torvalds/linux/blob/dc59e4fea9d83f03bad6bddf3fa2e52491777482/.ma=
ilmap#L38</a></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
P.S. Sorry for doing non-inline reply, it&#39;s again because of terrible O=
utlook.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
P.S.2. I&#39;ll continue my work on patches next week, cause I&#39;m curren=
tly away from home on vacation. ;)</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Huge thanks for such a fast review of my patch submission!</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Kind regards,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_7993606734492337038divRplyFwdMsg">
<div style=3D"direction:ltr;font-family:Calibri,sans-serif;font-size:11pt;c=
olor:rgb(0,0,0)">
<b>From:</b>=C2=A0Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidian=
akis@linaro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis@l=
inaro.org</a>&gt;<br>
<b>Sent:</b>=C2=A0Monday, June 29, 2026 13:04<br>
<b>To:</b>=C2=A0Alexander Mikhalitsyn &lt;<a href=3D"mailto:alexander@mihal=
icyn.com" target=3D"_blank" rel=3D"noreferrer">alexander@mihalicyn.com</a>&=
gt;<br>
<b>Cc:</b>=C2=A0<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" =
rel=3D"noreferrer">qemu-devel@nongnu.org</a> &lt;<a href=3D"mailto:qemu-dev=
el@nongnu.org" target=3D"_blank" rel=3D"noreferrer">qemu-devel@nongnu.org</=
a>&gt;; Volker R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de" targ=
et=3D"_blank" rel=3D"noreferrer">vr_qemu@t-online.de</a>&gt;; Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_bl=
ank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;; St=C3=A9phane =
Graber &lt;<a href=3D"mailto:stgraber@stgraber.org" target=3D"_blank" rel=
=3D"noreferrer">stgraber@stgraber.org</a>&gt;; Daniel P . Berrang=C3=A9 &lt=
;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer=
">berrange@redhat.com</a>&gt;; Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@r=
edhat.com" target=3D"_blank" rel=3D"noreferrer">kraxel@redhat.com</a>&gt;;
 Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">mst@redhat.com</a>&gt;; Aleksandr Mikhalitsyn &lt;<a hr=
ef=3D"mailto:aleksandr.mikhalitsyn@futurfusion.io" target=3D"_blank" rel=3D=
"noreferrer">aleksandr.mikhalitsyn@futurfusion.io</a>&gt;<br>
<b>Subject:</b>=C2=A0Re: [PATCH v3 0/9] hw/audio/virtio-sound: basic migrat=
ion support</div>
<div style=3D"direction:ltr">=C2=A0</div>
</div>
<div style=3D"font-size:11pt">Hi Alexander,<br>
<br>
On Fri, Jun 26, 2026 at 3:35=E2=80=AFPM Alexander Mikhalitsyn<br>
&lt;<a href=3D"mailto:alexander@mihalicyn.com" target=3D"_blank" rel=3D"nor=
eferrer">alexander@mihalicyn.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Alexander Mikhalitsyn &lt;<a href=3D"mailto:aleksandr.mikhalitsy=
n@futurfusion.io" target=3D"_blank" rel=3D"noreferrer">aleksandr.mikhalitsy=
n@futurfusion.io</a>&gt;<br>
<br>
Could you please send your patches from your<br>
<a href=3D"mailto:aleksandr.mikhalitsyn@futurfusion.io" target=3D"_blank" r=
el=3D"noreferrer">aleksandr.mikhalitsyn@futurfusion.io</a> address for the =
next revision?<br>
Replying to review comments with your personal email is fine, but the<br>
s-o-b should match your sending address. We do not know if the address<br>
belongs to you otherwise. This is not explicitly stated in our Code<br>
Provenance documentation but we need a way to verify your S-o-b<br>
provenance.<br>
<br>
Thanks,<br>
<br>
&gt;<br>
&gt; Dear friends,<br>
&gt;<br>
&gt; This patchset is aimed to support virtio-sound live migration and base=
d on<br>
&gt; pre-existing Volker R=C3=BCmelin&#39;s patches from qemu-devel lists [=
1]. I tried<br>
&gt; to ask (<a href=3D"https://lore.kernel.org/qemu-devel/9d7ea128c711c201=
688a4716f53b8a335fc53569.camel@mihalicyn.com/" id=3D"m_7993606734492337038O=
WA6941f02b-1969-9e4e-711e-d2b9cc4c83b5" target=3D"_blank" rel=3D"noreferrer=
">https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a335fc535=
69.camel@mihalicyn.com/</a>)<br>
&gt; if Volker is going to continue his work on this, but received no reply=
 so I<br>
&gt; just decided to go forward: take his patches, rebase and resend. Of co=
urse,<br>
&gt; I kept all authorship/tags so I hope that it is fine.<br>
&gt;<br>
&gt; Testing.<br>
&gt;<br>
&gt; I manually validated this with Ubuntu 24.04 Desktop VM and found no is=
sues.<br>
&gt; Also, it was validated with CI (<a href=3D"https://gitlab.com/mihalicy=
n/qemu/-/pipelines/2626702088" id=3D"m_7993606734492337038OWA61c1378e-0a4d-=
e5fb-1e7d-9b656bd415cf" target=3D"_blank" rel=3D"noreferrer">https://gitlab=
.com/mihalicyn/qemu/-/pipelines/2626702088</a>).<br>
&gt;<br>
&gt; Original patchset:<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-=
bf6cd7768c0e@t-online.de" id=3D"m_7993606734492337038OWA1039b5e4-0041-23a6-=
64ed-eb1366130103" target=3D"_blank" rel=3D"noreferrer">
https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-o=
nline.de</a>=C2=A0[1]<br>
&gt;<br>
&gt; Git tree:<br>
&gt; <a href=3D"https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-mi=
gration" id=3D"m_7993606734492337038OWA96413e88-a0a1-d43d-49c7-fa6040c3e94d=
" target=3D"_blank" rel=3D"noreferrer">
https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration</a><br>
&gt;<br>
&gt; Changelog for version 3:<br>
&gt; - addressed review feedback from Marc-Andr=C3=A9 Lureau:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drop VirtIOSoundPCMS=
tream&#39;s id field (unused)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - resurrected error_re=
port(..) in virtio_snd_pcm_start_stop()<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fixes in &quot;hw/au=
dio/virtio-sound: add stream state variable&quot;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ please, =
look in commit message for details ]<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - added &quot;hw/audio=
/virtio-sound: remove channel positions field<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from VirtI=
OSoundPCMStream&quot;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fixes in &quot;hw/au=
dio/virtio-sound: add missing vmstate fields&quot;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ details =
in commit message ]<br>
&gt;<br>
&gt; Changelog for version 2:<br>
&gt; - no code changes (only commit messages)<br>
&gt;=C2=A0=C2=A0 followed suggestions from Daniel P. Berrang=C3=A9 (thanks,=
 Daniel!)<br>
&gt;=C2=A0=C2=A0 <a href=3D"https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xs=
r_4p@redhat.com/" id=3D"m_7993606734492337038OWAcb3276a6-3c46-78e3-4327-2ea=
66bbac108" target=3D"_blank" rel=3D"noreferrer">
https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/</a><br>
&gt;=C2=A0=C2=A0 and added some extra details about what I did with the ori=
ginal<br>
&gt;=C2=A0=C2=A0 patches during rebase (for some of them it was simpler and=
 less error<br>
&gt;=C2=A0=C2=A0 prone to just drop changes and reimplement them by followi=
ng the idea<br>
&gt;=C2=A0=C2=A0 of the patch, cause base code has changed significantly).<=
br>
&gt;<br>
&gt; Changelog relative to the original Volker R=C3=BCmelin&#39;s submissio=
n:<br>
&gt; - rebased:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - &quot;hw/audio/virti=
o-sound: return correct command response size&quot;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 was dropped as it was already merged<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - &quot;hw/audio/virti=
o-sound: fix segmentation fault in tx/rx xfer handler&quot;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 was dropped as it seems to be replaced with ano=
ther fix<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 <a href=3D"https://github.com/qemu/qemu/commit/=
731655f87f319fd06f27282c6cafbc2467ac8045" id=3D"m_7993606734492337038OWA87d=
1e5d7-4be7-48e0-dec6-cdd7ab5c86b6" target=3D"_blank" rel=3D"noreferrer">
https://github.com/qemu/qemu/commit/731655f87f319fd06f27282c6cafbc2467ac804=
5</a><br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - I had to drop all pr=
e-existing Reviewed-by tags cause it was 2 years since<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this patch=
set was sent and reviewed and I did a quite significant code changes<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 during reb=
ase<br>
&gt;<br>
&gt; Kind regards,<br>
&gt; Alex<br>
&gt;<br>
&gt; Alexander Mikhalitsyn (1):<br>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: remove channel positions field from=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOSoundPCMStream<br>
&gt;<br>
&gt; Volker R=C3=BCmelin (8):<br>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: remove command and stream mutexes<b=
r>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: allocate an array of streams<br>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: free all stream buffers on reset<br=
>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop=
()<br>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: add stream state variable<br>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: introduce virtio_snd_pcm_open()<br>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: introduce virtio_snd_set_active()<b=
r>
&gt;=C2=A0=C2=A0 hw/audio/virtio-sound: add missing vmstate fields<br>
&gt;<br>
&gt;=C2=A0 hw/audio/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 3 +-<br>
&gt;=C2=A0 hw/audio/virtio-snd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 679 ++++++++++++++++++++--------------<br>
&gt;=C2=A0 include/hw/audio/virtio-snd.h |=C2=A0 26 +-<br>
&gt;=C2=A0 3 files changed, 399 insertions(+), 309 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.47.3<br>
&gt;<br>
<br>
--<br>
Manos Pitsidianakis<br>
Emulation and Virtualization Engineer at Linaro Ltd</div>
</div>

</blockquote></div></div></div>

--000000000000147ab80655633865--

