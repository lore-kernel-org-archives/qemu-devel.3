Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F273CDE002
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5qM-0002Oj-BT; Fri, 26 Jun 2026 08:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5qK-0002Ni-F9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:39:36 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5qI-0004C9-Jj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:39:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c07ea058c0cso148713366b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782477573; cv=none;
 d=google.com; s=arc-20260327;
 b=KLx89eYsWNCPZuBgsj0PwcLLmrLdtmlbDwywWA5EPV04x8WAp8wg+Bxac7SMHSJNGu
 k68HicsfiJF5L5xemKdAw12vtuld/Ja2CpZejO9pSGadInfEbC8cv+yWaecrEpLqRBs6
 Ts7i0qBKs20rKqBgZfVC3LLNnjUh2NA9gZpUHVPC6TIuoypFUFraSbH6y5JbNZdJnF+P
 pjUpixe27JTU1w7GoWu91KUlo6C+kSAkQ/HC0gImGqt4MgFvT1EOQA0qeA7e5komZpv0
 /+NDXWS5i/tfDlgLL48u/zyYZq+xcfiFF9lq9tD/AFsJJeG2PoKb8STHlX6OBNIQDfDt
 NiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P1HTbxHSaEi8ExycT/Z8AspQ7wuGyfzdcCgnP9bLcq4=;
 fh=df+e0CpHihWKx7yC+JeHiR1g/vhFBvZW4sBDizWGkF8=;
 b=fkTjF1w4t1FXbfAxMnVWfinYVHmJiF3sh/eHjNex5JSJ6samdNnEODsvDrodPQoJPK
 B0J0iVM5yM1R1oxzDKHcqgyrjqPXbd7lNOL4zAcayu6SBQ7qTFHL3rpolY0VWXrgrFJU
 9bPbOIMNT1vcCYSwHe34lGgQ8Dtarr3Atr4fp1RJGZI2aIUXaSTZW0aJ9ABHYfBY1ILn
 5ttMn9V7x6x2XIC8ibfA5Fp1JAP4w5w4lXLDJkGS2sGDGQ9+BXcYADn4d136vPCMan3q
 75xztInlBSzmW49Klm8vEzZx2nhLanDY0ejd46YM9/yF5Q/3Y0CMS5k2J+Gz4JPvBYkC
 8RkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477573; x=1783082373; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1HTbxHSaEi8ExycT/Z8AspQ7wuGyfzdcCgnP9bLcq4=;
 b=iRubr+nEqdJbvndL/3B//daHywCJ7SZ32+RHrBR6ab7bpZnQHnlziXC9o6L565e+3x
 F+LgwfjatTJ3A3hypaKSa6EH2al5V2URhBPPqwJG2iy+XUJgvphAbdrMq5TLD+5PSyRJ
 JSmZUW1qMjnL/5eixhif3vuR+FUDCejMBKol4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477573; x=1783082373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P1HTbxHSaEi8ExycT/Z8AspQ7wuGyfzdcCgnP9bLcq4=;
 b=UhMa2Mk0ApW3SlMxIG9GVTEHRRjnB6d1v87gdhVJQq0eCHKOoYKpwDxaoEJ3/WtYD7
 OTlsfzKNV5/0XqiQtDXTZqJb+BpjPAcjc831AQx9aJsf8xvCbrW0zpJ1LYJ3ZcgYo6px
 aipPiQTmzrsXWSZsTcCYDWOmhU+Eo6NCb0z/DHOeTiWrDke+y7KkCZmQwgKTcYiia9gI
 ZMhWmYC/Zr1rPEVT2Psbx27TepracTtoUUY8CvCPAsY6eK2ldAzV8Y1dEZuVyriO8O3V
 2kuyuo00I497SBT0PLytLak4V0hKB0BIOQ1QmNUv3QJX3A9OxljBlGKgH3Hrv50sfPuB
 ZREQ==
X-Gm-Message-State: AOJu0YyqFv/OaxMkoDUxHeRRUJ2SBNZxKXjlJvwBjONgLisRNiXWjmlt
 ADsmaswZHHRYgfb0iauqlgxqW+0j+twnB3F3ptleUL9IMwJTyM+/B8MYw+9KR2A486SQdRDnbj/
 Oz3GsbpHBOmtIC+VBci65BaqprEOkabMy5XjO9+Mtew==
X-Gm-Gg: AfdE7ckhNvEnAVHV6F60MdA7PF+QKIpuv0AdWX3+jEcsb2isOkpMxdTavKgxNpOd9vj
 qIULQrj22bkZlcWQlU6h9p/hEffhFAeF7uPX5aMdonDPn4Kx2oAwpMvlA8FM9LSpU6PYFOyFo8o
 LgyE22O+5YSbxKiYmgAOKe9ddvn+R0//qylv1g3A+8mXjc5rA7xtrRXeVG3guRYjgiPGOy0K3vx
 YDYFspgMdDSk391Tr3fow0OaG3ztTno3BzggnT4kivxUAkyD3o9W9Yro0bxDhuITi7rH2PhR/Y2
 smfFVtX/p4gF+0gGaxALbvB/uK9m
X-Received: by 2002:a17:906:ba8d:b0:bec:929b:cedb with SMTP id
 a640c23a62f3a-c1205ef77dbmr404904266b.46.1782477572213; Fri, 26 Jun 2026
 05:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-10-alexander@mihalicyn.com>
 <CAMxuvax2RyRCAYkW0BAEoq6+eektdpfuD48CBd1F=NUa3gqGiA@mail.gmail.com>
In-Reply-To: <CAMxuvax2RyRCAYkW0BAEoq6+eektdpfuD48CBd1F=NUa3gqGiA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 14:39:20 +0200
X-Gm-Features: AVVi8CeVT9LFbR9RJTEPyPyuF0_9RsxCqvfjIEHtAdas9DNPAdQt-tV8CeaeLOY
Message-ID: <CAJqdLroDQDQkbPM5yM0cdiPVABU-+DRjGQ8LRT0jO=ibMuiG1w@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] hw/audio/virtio-sound: add placeholder for buffer
 write position
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
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

Am Do., 25. Juni 2026 um 17:08 Uhr schrieb Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com>:
>
> Hi
>
> On Thu, Jun 25, 2026 at 1:53=E2=80=AFPM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >
> > When a running audio stream is migrated, on average half of a
> > recording stream buffer is lost or half of a playback stream
> > buffer is played twice. Add a placeholder for the write position
> > of the current stream buffer to the migrated data. Additional
> > program code is required to resolve the above issues. However,
> > the placeholder makes it possible to add code in a backwards and
> > forwards compatible way.
>
> I don't think it's convincing enough. I'd rather have proper
> versioning if / when such an improvement is made.

completely agree, I have added versioning and dropped this patch in -v3.

>
> >
> > Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > ---
> >  hw/audio/virtio-snd.c         | 2 ++
> >  include/hw/audio/virtio-snd.h | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index b3de8abcb61..cdd384cf4a0 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -81,6 +81,7 @@ static const VMStateDescription vmstate_virtio_snd_st=
ream =3D {
> >      .name =3D "virtio-sound-stream",
> >      .fields =3D (const VMStateField[]) {
> >          VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT32(buf_wpos, VirtIOSoundPCMStream),
> >          VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
> >          VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
> >          VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
> > @@ -1431,6 +1432,7 @@ static int virtio_snd_post_load(VirtIODevice *vde=
v)
> >                  virtio_snd_pcm_set_active(stream, true);
> >              }
> >          }
> > +        stream->buf_wpos =3D 0;
> >      }
> >
> >      for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-sn=
d.h
> > index 523c456436b..4c688016c25 100644
> > --- a/include/hw/audio/virtio-snd.h
> > +++ b/include/hw/audio/virtio-snd.h
> > @@ -124,6 +124,8 @@ struct VirtIOSoundPCMStream {
> >      virtio_snd_pcm_set_params params;
> >      uint32_t id;
> >      uint32_t state;
> > +    /* placeholder: write position in current VirtIOSoundPCMBuffer */
> > +    uint32_t buf_wpos;
> >      /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> >      uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> >      VirtIOSound *s;
> > --
> > 2.47.3
> >
>

