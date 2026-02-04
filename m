Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CBFE9D3E8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vne5C-0001O2-7g; Wed, 04 Feb 2026 09:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vne59-0001Ne-RF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vne55-0007fk-7H
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770216130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raZ5+jnC3V7nVclHeuahDlSVrKbgjL9VWTmMf/9cf3o=;
 b=O1MFTO/0jOz/bKyD0QuLxYHRmn/B9vcOhczeWFCSUlhztyzT62o2nT4EM5EYS1szWCFLlx
 ezZmpikoBpa0ZPSibDjb70tjR5fnJg7/evFAj9L/4i0tn/K4KdYPaKLVJ2+fDWYint5Mlm
 rdhsWPTy+CrTCrCyGMLzUTdD/F1VTKM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-afS_FrpuNM-vrNDNM5cylQ-1; Wed, 04 Feb 2026 09:42:08 -0500
X-MC-Unique: afS_FrpuNM-vrNDNM5cylQ-1
X-Mimecast-MFC-AGG-ID: afS_FrpuNM-vrNDNM5cylQ_1770216126
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c43f8ef9bso1185721a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:42:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216126; cv=none;
 d=google.com; s=arc-20240605;
 b=FwZ1VRtcQyazxkR5GA+KTD5J3eSPzxeuaTCTa4P7jCJkytLtroWReM5X2ML8EKeopw
 68+6Zn2vf/tuvJbC83mKHdi0LKnst5FZ4yTU5sMeozRIu4ToQpu620d6aYlSjcp7xv6A
 wbkVsCT2nz0etyWGCqQv+K8VK5+55K9D6shuXPQE91pYl8pBsnOr5nrc+ruR2Rb9kUHz
 G07T/isYAELxJYpkQ3sDetUEVGzVWVpNe7Y/VUjcPot/LVAtGX/pXuFRDg0+3lhTMPTX
 SWye1K+pe1janBAHfdL1/32tLmjWsiryzwuD1TGKBHLfnhRlAjtVT7FvO192m1Lu69oL
 WwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=raZ5+jnC3V7nVclHeuahDlSVrKbgjL9VWTmMf/9cf3o=;
 fh=q3BOJLspLl+E+DSYSXtxoT8Z5FXSdQ+iVJdbeMgLNZg=;
 b=Lz1TqJ4JQgLaOHq892mZy8BL40C6WNyT1pg8naloI5fxZCGaErDF4Md3HzhQ5foOvK
 7epbWasrWSXkZrH7fmCO/sTFhFO2TPW+kxodFdUZKNpwOXlEHpDOzT1iigWH5fKd4ozM
 T6eIcmGBD/qHXppGuYh5c5bxIMbqXf+wFswGwx9iFxd7zTrscUNME80fzDA6A2xL0a0z
 hu04yEdul0JQW9X6e43//nJffr1hGlFszNhaiuq+M7IIEkENHGSGVoDzkQDJ7//sSMu0
 g+9dIlzFl2aOy4Qgqa0OuO7cPla7YiJLpwM5iuoe4jmNsDDmBqX08fior9bM6rp1S8AJ
 etYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770216126; x=1770820926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raZ5+jnC3V7nVclHeuahDlSVrKbgjL9VWTmMf/9cf3o=;
 b=MfJSQLdGsG9GBOvo/a6GzbfzwRtvEUDgPnEQsbyWTOSFhC2f5Du3tbL838TD57Djs2
 cUaao2uKcxIuTn1s5rZ9PGoC85YZfgQMdYfR5tyHWCUz93g4RabcBGjPhkszBcRzend+
 uS7SiycdXqL+seSq5FO1ocvuS5PymhqR9EnhtA4b9HGmfua+fFVheeJaKQGcHFZxjucE
 Z+uJhPe8W9EqpvySWkAoGfV25G6FvEyIUj1YThBRu+b1ULi2torRbUKmlvqhBCaCzvSy
 zs/CmJOZY4bYzWuI0nz4Z3gue59d3NRu0QzrG1LGMlexYVoKuUgclAuOFJ6zjQ32pzgg
 dH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770216126; x=1770820926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=raZ5+jnC3V7nVclHeuahDlSVrKbgjL9VWTmMf/9cf3o=;
 b=lLR8N26VP5t6p8TEenGT8uQqNMETs00dCulA3OInA4ArUlX0iTlWPLsHfYxDm5UyWk
 808H8y2miClRThJ0cSWwuvvvNyur0NO2WlMNVqaIubB+rru/foRVtHxrjsSRds2kZOsN
 U9IDehQptiwMFSvPCL1Reox8oXIvw8scmt4LPYUmRPWZMpOF7MGkjj7WQVaT7pZFwa3I
 h4649hahrxtL8Z5w32QUOG8xqHDQFf6ofYdOyXOj379WwmcTuj8GiWJbT7huiYoENmsu
 e2e8x8hD2OoqKARl48ciHurUmW19cx3g8bZtxPkHhgq77zr4mOL7Z4pLphBvCYPCLPT6
 W9OA==
X-Gm-Message-State: AOJu0YyLAsbKjIz6pxc0T+NlDiP2tRGk994ba8JTulPcJnTyrJEDgLc7
 REDAfNQlX5OUTOdbNwDL0NUO3Gwp2sH2nueu4f5rpRf2AABlJ/2LIUfw6jns3RFjTfOeCyosVyt
 Ld4+pa583aUzPRX+EDn9du9mhWeR1eoMl8ZRCqBXZx2KHgwqShCbXXIQwfV7ERAadbatt3k9Mxf
 wfg34z40+5WUOe7jzgTKInYHXAlkPp33A=
X-Gm-Gg: AZuq6aK68KYweR3H9Gvpl8C3SOb/tFEBp47nRZY0rU92Tcj9o2IwaT7f7NFPCSoHoIp
 vZIL3MLndfSh8Lbpv7QRc1aBogN8rZ62vkTN9dZbqI2yKr1WcWatijDEQv+BFCc8KL8nBlafQ03
 lt14SxmhT/nYOxS8E0uNzQwgKeAWqwHlddaAOiMNCyX/rzLlCYb1b+5/EUipO2D9Jqb9aoNRe6Z
 vj5k/5fwOl7mcc3pLiNx9yQhg==
X-Received: by 2002:a17:90b:254c:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-354777ef744mr5427746a91.11.1770216125388; 
 Wed, 04 Feb 2026 06:42:05 -0800 (PST)
X-Received: by 2002:a17:90b:254c:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-354777ef744mr5427711a91.11.1770216124452; Wed, 04 Feb 2026
 06:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-31-marcandre.lureau@redhat.com>
 <41aaa36a-89ed-4fdb-982c-73038e2dd097@nutanix.com>
In-Reply-To: <41aaa36a-89ed-4fdb-982c-73038e2dd097@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Feb 2026 18:41:51 +0400
X-Gm-Features: AZwV_QifmCk2r7cFUFtOeK6oRnOkmFXT_GVMzIHbVZ5YIDW_9mbqBmdhgHj4qzw
Message-ID: <CAMxuvawSBxKdeuSXJp8KW4WYFKGNh4sLf+q-hvGh0-KST5XpeA@mail.gmail.com>
Subject: Re: [PATCH 30/37] audio: make all the backend-specific APIs take the
 be
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Feb 4, 2026 at 3:42=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This will allow to dispatch to different implementations next.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio_template.h       |  2 +-
> >   include/qemu/audio-capture.h |  9 ++--
> >   include/qemu/audio.h         | 34 ++++++++-------
> >   audio/audio.c                | 18 ++++----
> >   audio/wavcapture.c           |  7 ++-
> >   hw/audio/ac97.c              | 24 +++++------
> >   hw/audio/adlib.c             |  9 ++--
> >   hw/audio/asc.c               | 16 +++----
> >   hw/audio/cs4231a.c           | 16 +++----
> >   hw/audio/es1370.c            | 12 +++---
> >   hw/audio/gus.c               |  9 ++--
> >   hw/audio/hda-codec.c         | 20 +++++----
> >   hw/audio/lm4549.c            | 12 +++---
> >   hw/audio/pcspk.c             |  4 +-
> >   hw/audio/sb16.c              | 14 +++---
> >   hw/audio/via-ac97.c          | 14 +++---
> >   hw/audio/virtio-snd.c        | 14 +++---
> >   hw/audio/wm8750.c            | 24 +++++------
> >   hw/display/xlnx_dp.c         | 10 ++---
> >   hw/usb/dev-audio.c           | 12 +++---
> >   tests/audio/test-audio.c     | 83 ++++++++++++++++++-----------------=
-
> >   ui/vnc.c                     |  2 +-
> >   22 files changed, 192 insertions(+), 173 deletions(-)
> >
> > diff --git a/audio/audio_template.h b/audio/audio_template.h
> > index 512abbfe22f..33f2ff432eb 100644
> > --- a/audio/audio_template.h
> > +++ b/audio/audio_template.h
> > @@ -569,7 +569,7 @@ SW *glue (AUD_open_, TYPE) (
> >       return NULL;
> >   }
> >
> > -bool glue(AUD_is_active_, TYPE)(SW *sw)
> > +bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
> >   {
> >       return sw ? sw->active : 0;
> >   }
> > diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.=
h
> > index a07412db857..f500b0a7f8c 100644
> > --- a/include/qemu/audio-capture.h
> > +++ b/include/qemu/audio-capture.h
> > @@ -36,8 +36,11 @@ CaptureVoiceOut *AUD_add_capture(
> >       AudioBackend *be,
> >       struct audsettings *as,
> >       struct audio_capture_ops *ops,
> > -    void *opaque
> > -    );
> > -void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
> > +    void *opaque);
> > +
> > +void AUD_del_capture(
> > +    AudioBackend *be,
> > +    CaptureVoiceOut *cap,
> > +    void *cb_opaque);
> >
> >   #endif /* QEMU_AUDIO_CAPTURE_H */
> > diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> > index 03ce9adbc88..e87708e3d1e 100644
> > --- a/include/qemu/audio.h
> > +++ b/include/qemu/audio.h
> > @@ -63,7 +63,7 @@ typedef struct AudioBackendClass {
> >
> >   bool AUD_backend_check(AudioBackend **be, Error **errp);
> >
> > -SWVoiceOut *AUD_open_out (
> > +SWVoiceOut *AUD_open_out(
> >       AudioBackend *be,
> >       SWVoiceOut *sw,
> >       const char *name,
> > @@ -72,11 +72,11 @@ SWVoiceOut *AUD_open_out (
> >       const struct audsettings *settings
> >       );
> >
> > -void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
> > -size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
> > -int  AUD_get_buffer_size_out (SWVoiceOut *sw);
> > -void AUD_set_active_out(SWVoiceOut *sw, bool on);
> > -bool AUD_is_active_out(SWVoiceOut *sw);
> > +void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
> > +size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size=
_t size);
> > +int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
> > +void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
> > +bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
> >
> >   #define AUDIO_MAX_CHANNELS 16
> >   typedef struct Volume {
> > @@ -85,19 +85,23 @@ typedef struct Volume {
> >       uint8_t vol[AUDIO_MAX_CHANNELS];
> >   } Volume;
> >
> > -void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol);
> > -void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol);
> > +void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)=
;
> > +void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
> >
> >   static inline void
> > -AUD_set_volume_out_lr(SWVoiceOut *sw, bool mut, uint8_t lvol, uint8_t =
rvol) {
> > -    AUD_set_volume_out(sw, &(Volume) {
> > +AUD_set_volume_out_lr(AudioBackend *be, SWVoiceOut *sw,
> > +                      bool mut, uint8_t lvol, uint8_t rvol)
> > +{
> > +    AUD_set_volume_out(be, sw, &(Volume) {
> >           .mute =3D mut, .channels =3D 2, .vol =3D { lvol, rvol }
> >       });
> >   }
> >
> >   static inline void
> > -AUD_set_volume_in_lr(SWVoiceIn *sw, bool mut, uint8_t lvol, uint8_t rv=
ol) {
> > -    AUD_set_volume_in(sw, &(Volume) {
> > +AUD_set_volume_in_lr(AudioBackend *be, SWVoiceIn *sw,
> > +                     bool mut, uint8_t lvol, uint8_t rvol)
> > +{
> > +    AUD_set_volume_in(be, sw, &(Volume) {
> >           .mute =3D mut, .channels =3D 2, .vol =3D { lvol, rvol }
> >       });
> >   }
> > @@ -112,9 +116,9 @@ SWVoiceIn *AUD_open_in(
> >       );
> >
> >   void AUD_close_in(AudioBackend *be, SWVoiceIn *sw);
> > -size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
> > -void AUD_set_active_in(SWVoiceIn *sw, bool on);
> > -bool AUD_is_active_in(SWVoiceIn *sw);
> > +size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *pcm_buf, size_t=
 size);
> > +void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on);
> > +bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw);
> >
> >   void audio_cleanup(void);
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index a03ca397d33..6bfec5e1d75 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -846,7 +846,7 @@ static void audio_timer (void *opaque)
> >   /*
> >    * Public API
> >    */
> > -size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
> > +size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t s=
ize)
> >   {
> >       HWVoiceOut *hw;
> >
> > @@ -868,7 +868,7 @@ size_t AUD_write(SWVoiceOut *sw, void *buf, size_t =
size)
> >       }
> >   }
> >
> > -size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
> > +size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t siz=
e)
> >   {
> >       HWVoiceIn *hw;
> >
> > @@ -890,7 +890,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t si=
ze)
> >       }
> >   }
> >
> > -int AUD_get_buffer_size_out(SWVoiceOut *sw)
> > +int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> >   {
> >       if (!sw) {
> >           return 0;
> > @@ -903,7 +903,7 @@ int AUD_get_buffer_size_out(SWVoiceOut *sw)
> >       return sw->hw->samples * sw->hw->info.bytes_per_frame;
> >   }
> >
> > -void AUD_set_active_out(SWVoiceOut *sw, bool on)
> > +void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
> >   {
> >       HWVoiceOut *hw;
> >
> > @@ -951,7 +951,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
> >       }
> >   }
> >
> > -void AUD_set_active_in(SWVoiceIn *sw, bool on)
> > +void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> >   {
> >       HWVoiceIn *hw;
> >
> > @@ -996,7 +996,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
> >       }
> >   }
> >
> > -static size_t audio_get_avail (SWVoiceIn *sw)
> > +static size_t audio_get_avail(SWVoiceIn *sw)
> >   {
> >       size_t live;
> >
> > @@ -1937,7 +1937,7 @@ CaptureVoiceOut *AUD_add_capture(
> >       return cap;
> >   }
> >
> > -void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
> > +void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_=
opaque)
> >   {
> >       struct capture_callback *cb;
> >
> > @@ -1976,7 +1976,7 @@ void AUD_del_capture (CaptureVoiceOut *cap, void =
*cb_opaque)
> >       }
> >   }
> >
> > -void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
> > +void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
> >   {
> >       if (sw) {
> >           HWVoiceOut *hw =3D sw->hw;
> > @@ -1992,7 +1992,7 @@ void AUD_set_volume_out(SWVoiceOut *sw, Volume *v=
ol)
> >       }
> >   }
> >
> > -void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
> > +void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
> >   {
> >       if (sw) {
> >           HWVoiceIn *hw =3D sw->hw;
> > diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> > index b33a38ff45b..2950ceaf242 100644
> > --- a/audio/wavcapture.c
> > +++ b/audio/wavcapture.c
> > @@ -1,4 +1,5 @@
> >   #include "qemu/osdep.h"
> > +#include "qemu/audio.h"
> >   #include "qemu/qemu-print.h"
> >   #include "qemu/error-report.h"
> >   #include "audio_int.h"
> > @@ -10,6 +11,7 @@ typedef struct {
> >       int freq;
> >       int bits;
> >       int nchannels;
> > +    AudioBackend *audio_be;
> >       CaptureVoiceOut *cap;
> >   } WAVState;
> >
> > @@ -84,7 +86,7 @@ static void wav_capture_destroy (void *opaque)
> >   {
> >       WAVState *wav =3D opaque;
> >
> > -    AUD_del_capture (wav->cap, wav);
> > +    AUD_del_capture(wav->audio_be, wav->cap, wav);
> >       g_free (wav);
> >   }
> >
> > @@ -159,6 +161,7 @@ int wav_start_capture(AudioBackend *state, CaptureS=
tate *s, const char *path,
> >           return -1;
> >       }
> >
> > +    wav->audio_be =3D state;
> >       wav->path =3D g_strdup (path);
> >       wav->bits =3D bits;
> >       wav->nchannels =3D nchannels;
> > @@ -169,7 +172,7 @@ int wav_start_capture(AudioBackend *state, CaptureS=
tate *s, const char *path,
> >           goto error_free;
> >       }
> >
> > -    cap =3D AUD_add_capture(state, &as, &ops, wav);
> > +    cap =3D AUD_add_capture(wav->audio_be, &as, &ops, wav);
> >       if (!cap) {
> >           error_report("Failed to add audio capture");
> >           goto error_free;
> > diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> > index 0694f0adf9c..65a4141b8af 100644
> > --- a/hw/audio/ac97.c
> > +++ b/hw/audio/ac97.c
> > @@ -246,15 +246,15 @@ static void voice_set_active(AC97LinkState *s, in=
t bm_index, int on)
> >   {
> >       switch (bm_index) {
> >       case PI_INDEX:
> > -        AUD_set_active_in(s->voice_pi, on);
> > +        AUD_set_active_in(s->audio_be, s->voice_pi, on);
> >           break;
> >
> >       case PO_INDEX:
> > -        AUD_set_active_out(s->voice_po, on);
> > +        AUD_set_active_out(s->audio_be, s->voice_po, on);
> >           break;
> >
> >       case MC_INDEX:
> > -        AUD_set_active_in(s->voice_mc, on);
> > +        AUD_set_active_in(s->audio_be, s->voice_mc, on);
> >           break;
> >
> >       default:
> > @@ -378,15 +378,15 @@ static void reset_voices(AC97LinkState *s, uint8_=
t active[LAST_INDEX])
> >
> >       freq =3D mixer_load(s, AC97_PCM_LR_ADC_Rate);
> >       open_voice(s, PI_INDEX, freq);
> > -    AUD_set_active_in(s->voice_pi, active[PI_INDEX]);
> > +    AUD_set_active_in(s->audio_be, s->voice_pi, active[PI_INDEX]);
> >
> >       freq =3D mixer_load(s, AC97_PCM_Front_DAC_Rate);
> >       open_voice(s, PO_INDEX, freq);
> > -    AUD_set_active_out(s->voice_po, active[PO_INDEX]);
> > +    AUD_set_active_out(s->audio_be, s->voice_po, active[PO_INDEX]);
> >
> >       freq =3D mixer_load(s, AC97_MIC_ADC_Rate);
> >       open_voice(s, MC_INDEX, freq);
> > -    AUD_set_active_in(s->voice_mc, active[MC_INDEX]);
> > +    AUD_set_active_in(s->audio_be, s->voice_mc, active[MC_INDEX]);
> >   }
> >
> >   static void get_volume(uint16_t vol, uint16_t mask, int inverse,
> > @@ -416,7 +416,7 @@ static void update_combined_volume_out(AC97LinkStat=
e *s)
> >       lvol =3D (lvol * plvol) / 255;
> >       rvol =3D (rvol * prvol) / 255;
> >
> > -    AUD_set_volume_out_lr(s->voice_po, mute, lvol, rvol);
> > +    AUD_set_volume_out_lr(s->audio_be, s->voice_po, mute, lvol, rvol);
> >   }
> >
> >   static void update_volume_in(AC97LinkState *s)
> > @@ -427,7 +427,7 @@ static void update_volume_in(AC97LinkState *s)
> >       get_volume(mixer_load(s, AC97_Record_Gain_Mute), 0x0f, 0,
> >                  &mute, &lvol, &rvol);
> >
> > -    AUD_set_volume_in_lr(s->voice_pi, mute, lvol, rvol);
> > +    AUD_set_volume_in_lr(s->audio_be, s->voice_pi, mute, lvol, rvol);
> >   }
> >
> >   static void set_volume(AC97LinkState *s, int index, uint32_t val)
> > @@ -904,7 +904,7 @@ static int write_audio(AC97LinkState *s, AC97BusMas=
terRegs *r,
> >           int copied;
> >           to_copy =3D MIN(temp, sizeof(tmpbuf));
> >           pci_dma_read(&s->dev, addr, tmpbuf, to_copy);
> > -        copied =3D AUD_write(s->voice_po, tmpbuf, to_copy);
> > +        copied =3D AUD_write(s->audio_be, s->voice_po, tmpbuf, to_copy=
);
> >           dolog("write_audio max=3D%x to_copy=3D%x copied=3D%x",
> >                 max, to_copy, copied);
> >           if (!copied) {
> > @@ -948,7 +948,7 @@ static void write_bup(AC97LinkState *s, int elapsed=
)
> >       while (elapsed) {
> >           int temp =3D MIN(elapsed, sizeof(s->silence));
> >           while (temp) {
> > -            int copied =3D AUD_write(s->voice_po, s->silence, temp);
> > +            int copied =3D AUD_write(s->audio_be, s->voice_po, s->sile=
nce, temp);
> >               if (!copied) {
> >                   return;
> >               }
> > @@ -978,7 +978,7 @@ static int read_audio(AC97LinkState *s, AC97BusMast=
erRegs *r,
> >       while (temp) {
> >           int acquired;
> >           to_copy =3D MIN(temp, sizeof(tmpbuf));
> > -        acquired =3D AUD_read(voice, tmpbuf, to_copy);
> > +        acquired =3D AUD_read(s->audio_be, voice, tmpbuf, to_copy);
> >           if (!acquired) {
> >               *stop =3D 1;
> >               break;
> > @@ -1275,7 +1275,7 @@ static void ac97_realize(PCIDevice *dev, Error **=
errp)
> >       AC97LinkState *s =3D AC97(dev);
> >       uint8_t *c =3D s->dev.config;
> >
> > -    if (!AUD_backend_check (&s->audio_be, errp)) {
> > +    if (!AUD_backend_check(&s->audio_be, errp)) {
> >           return;
> >       }
> >
> > diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> > index f79654627f5..dd5d9cf6772 100644
> > --- a/hw/audio/adlib.c
> > +++ b/hw/audio/adlib.c
> > @@ -95,7 +95,7 @@ static void adlib_write(void *opaque, uint32_t nport,=
 uint32_t val)
> >       int a =3D nport & 3;
> >
> >       s->active =3D 1;
> > -    AUD_set_active_out (s->voice, 1);
> > +    AUD_set_active_out(s->audio_be, s->voice, 1);
> >
> >       adlib_kill_timers (s);
> >
> > @@ -143,7 +143,8 @@ static int write_audio (AdlibState *s, int samples)
> >           int nbytes, wbytes, wsampl;
> >
> >           nbytes =3D samples << SHIFT;
> > -        wbytes =3D AUD_write (
> > +        wbytes =3D AUD_write(
> > +            s->audio_be,
> >               s->voice,
> >               s->mixbuf + (pos << (SHIFT - 1)),
> >               nbytes
> > @@ -255,7 +256,7 @@ static void adlib_realizefn (DeviceState *dev, Erro=
r **errp)
> >       as.fmt =3D AUDIO_FORMAT_S16;
> >       as.endianness =3D HOST_BIG_ENDIAN;
> >
> > -    s->voice =3D AUD_open_out (
> > +    s->voice =3D AUD_open_out(
> >           s->audio_be,
> >           s->voice,
> >           "adlib",
> > @@ -269,7 +270,7 @@ static void adlib_realizefn (DeviceState *dev, Erro=
r **errp)
> >           return;
> >       }
> >
> > -    s->samples =3D AUD_get_buffer_size_out (s->voice) >> SHIFT;
> > +    s->samples =3D AUD_get_buffer_size_out(s->audio_be, s->voice) >> S=
HIFT;
> >       s->mixbuf =3D g_malloc0 (s->samples << SHIFT);
> >
> >       adlib_portio_list[0].offset =3D s->port;
> > diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> > index a934c2e82c0..43cd51939a3 100644
> > --- a/hw/audio/asc.c
> > +++ b/hw/audio/asc.c
> > @@ -355,12 +355,12 @@ static void asc_out_cb(void *opaque, int free_b)
> >                * loop because the FIFO has run out of data, and the dri=
ver
> >                * reuses the stale content in its circular audio buffer.
> >                */
> > -            AUD_write(s->voice, s->silentbuf, samples << s->shift);
> > +            AUD_write(s->audio_be, s->voice, s->silentbuf, samples << =
s->shift);
> >           }
> >           return;
> >       }
> >
> > -    AUD_write(s->voice, s->mixbuf, generated << s->shift);
> > +    AUD_write(s->audio_be, s->voice, s->mixbuf, generated << s->shift)=
;
> >   }
> >
> >   static uint64_t asc_fifo_read(void *opaque, hwaddr addr,
> > @@ -470,9 +470,9 @@ static void asc_write(void *opaque, hwaddr addr, ui=
nt64_t value,
> >               asc_fifo_reset(&s->fifos[1]);
> >               asc_lower_irq(s);
> >               if (value !=3D 0) {
> > -                AUD_set_active_out(s->voice, 1);
> > +                AUD_set_active_out(s->audio_be, s->voice, 1);
> >               } else {
> > -                AUD_set_active_out(s->voice, 0);
> > +                AUD_set_active_out(s->audio_be, s->voice, 0);
> >               }
> >           }
> >           break;
> > @@ -489,7 +489,7 @@ static void asc_write(void *opaque, hwaddr addr, ui=
nt64_t value,
> >           {
> >               int vol =3D (value & 0xe0);
> >
> > -            AUD_set_volume_out_lr(s->voice, 0, vol, vol);
> > +            AUD_set_volume_out_lr(s->audio_be, s->voice, 0, vol, vol);
> >               break;
> >           }
> >       }
> > @@ -545,7 +545,7 @@ static int asc_post_load(void *opaque, int version)
> >       ASCState *s =3D ASC(opaque);
> >
> >       if (s->regs[ASC_MODE] !=3D 0) {
> > -        AUD_set_active_out(s->voice, 1);
> > +        AUD_set_active_out(s->audio_be, s->voice, 1);
> >       }
> >
> >       return 0;
> > @@ -614,7 +614,7 @@ static void asc_reset_hold(Object *obj, ResetType t=
ype)
> >   {
> >       ASCState *s =3D ASC(obj);
> >
> > -    AUD_set_active_out(s->voice, 0);
> > +    AUD_set_active_out(s->audio_be, s->voice, 0);
> >
> >       memset(s->regs, 0, sizeof(s->regs));
> >       asc_fifo_reset(&s->fifos[0]);
> > @@ -658,7 +658,7 @@ static void asc_realize(DeviceState *dev, Error **e=
rrp)
> >       }
> >
> >       s->shift =3D 1;
> > -    s->samples =3D AUD_get_buffer_size_out(s->voice) >> s->shift;
> > +    s->samples =3D AUD_get_buffer_size_out(s->audio_be, s->voice) >> s=
->shift;
> >       s->mixbuf =3D g_malloc0(s->samples << s->shift);
> >
> >       s->silentbuf =3D g_malloc(s->samples << s->shift);
> > diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> > index 7489cf42b7d..3b8ed092fe4 100644
> > --- a/hw/audio/cs4231a.c
> > +++ b/hw/audio/cs4231a.c
> > @@ -327,7 +327,7 @@ static void cs_reset_voices (CSState *s, uint32_t v=
al)
> >           goto error;
> >       }
> >
> > -    s->voice =3D AUD_open_out (
> > +    s->voice =3D AUD_open_out(
> >           s->audio_be,
> >           s->voice,
> >           "cs4231a",
> > @@ -339,7 +339,7 @@ static void cs_reset_voices (CSState *s, uint32_t v=
al)
> >       if (s->dregs[Interface_Configuration] & PEN) {
> >           if (!s->dma_running) {
> >               k->hold_DREQ(s->isa_dma, s->dma);
> > -            AUD_set_active_out (s->voice, 1);
> > +            AUD_set_active_out(s->audio_be, s->voice, 1);
> >               s->transferred =3D 0;
> >           }
> >           s->dma_running =3D 1;
> > @@ -347,7 +347,7 @@ static void cs_reset_voices (CSState *s, uint32_t v=
al)
> >       else {
> >           if (s->dma_running) {
> >               k->release_DREQ(s->isa_dma, s->dma);
> > -            AUD_set_active_out (s->voice, 0);
> > +            AUD_set_active_out(s->audio_be, s->voice, 0);
> >           }
> >           s->dma_running =3D 0;
> >       }
> > @@ -356,7 +356,7 @@ static void cs_reset_voices (CSState *s, uint32_t v=
al)
> >    error:
> >       if (s->dma_running) {
> >           k->release_DREQ(s->isa_dma, s->dma);
> > -        AUD_set_active_out (s->voice, 0);
> > +        AUD_set_active_out(s->audio_be, s->voice, 0);
> >       }
> >   }
> >
> > @@ -465,7 +465,7 @@ static void cs_write (void *opaque, hwaddr addr,
> >                   if (s->dma_running) {
> >                       IsaDmaClass *k =3D ISADMA_GET_CLASS(s->isa_dma);
> >                       k->release_DREQ(s->isa_dma, s->dma);
> > -                    AUD_set_active_out (s->voice, 0);
> > +                    AUD_set_active_out(s->audio_be, s->voice, 0);
> >                       s->dma_running =3D 0;
> >                   }
> >               }
> > @@ -551,11 +551,11 @@ static int cs_write_audio (CSState *s, int nchan,=
 int dma_pos,
> >
> >               for (i =3D 0; i < copied; ++i)
> >                   linbuf[i] =3D s->tab[tmpbuf[i]];
> > -            copied =3D AUD_write (s->voice, linbuf, copied << 1);
> > +            copied =3D AUD_write(s->audio_be, s->voice, linbuf, copied=
 << 1);
> >               copied >>=3D 1;
> >           }
> >           else {
> > -            copied =3D AUD_write (s->voice, tmpbuf, copied);
> > +            copied =3D AUD_write(s->audio_be, s->voice, tmpbuf, copied=
);
> >           }
> >
> >           temp -=3D copied;
> > @@ -614,7 +614,7 @@ static int cs4231a_pre_load (void *opaque)
> >       if (s->dma_running) {
> >           IsaDmaClass *k =3D ISADMA_GET_CLASS(s->isa_dma);
> >           k->release_DREQ(s->isa_dma, s->dma);
> > -        AUD_set_active_out (s->voice, 0);
> > +        AUD_set_active_out(s->audio_be, s->voice, 0);
> >       }
> >       s->dma_running =3D 0;
> >       return 0;
> > diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> > index 566f93f1eae..44b204730b5 100644
> > --- a/hw/audio/es1370.c
> > +++ b/hw/audio/es1370.c
> > @@ -411,7 +411,7 @@ static void es1370_update_voices (ES1370State *s, u=
int32_t ctl, uint32_t sctl)
> >
> >                   if (i =3D=3D ADC_CHANNEL) {
> >                       s->adc_voice =3D
> > -                        AUD_open_in (
> > +                        AUD_open_in(
> >                               s->audio_be,
> >                               s->adc_voice,
> >                               "es1370.adc",
> > @@ -421,7 +421,7 @@ static void es1370_update_voices (ES1370State *s, u=
int32_t ctl, uint32_t sctl)
> >                               );
> >                   } else {
> >                       s->dac_voice[i] =3D
> > -                        AUD_open_out (
> > +                        AUD_open_out(
> >                               s->audio_be,
> >                               s->dac_voice[i],
> >                               i ? "es1370.dac2" : "es1370.dac1",
> > @@ -438,9 +438,9 @@ static void es1370_update_voices (ES1370State *s, u=
int32_t ctl, uint32_t sctl)
> >               int on =3D (ctl & b->ctl_en) && !(sctl & b->sctl_pause);
> >
> >               if (i =3D=3D ADC_CHANNEL) {
> > -                AUD_set_active_in (s->adc_voice, on);
> > +                AUD_set_active_in(s->audio_be, s->adc_voice, on);
> >               } else {
> > -                AUD_set_active_out (s->dac_voice[i], on);
> > +                AUD_set_active_out(s->audio_be, s->dac_voice[i], on);
> >               }
> >           }
> >       }
> > @@ -627,7 +627,7 @@ static void es1370_transfer_audio (ES1370State *s, =
struct chan *d, int loop_sel,
> >               int acquired, to_copy;
> >
> >               to_copy =3D MIN(to_transfer, sizeof(tmpbuf));
> > -            acquired =3D AUD_read (s->adc_voice, tmpbuf, to_copy);
> > +            acquired =3D AUD_read(s->audio_be, s->adc_voice, tmpbuf, t=
o_copy);
> >               if (!acquired) {
> >                   break;
> >               }
> > @@ -646,7 +646,7 @@ static void es1370_transfer_audio (ES1370State *s, =
struct chan *d, int loop_sel,
> >
> >               to_copy =3D MIN(to_transfer, sizeof(tmpbuf));
> >               pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
> > -            copied =3D AUD_write (voice, tmpbuf, to_copy);
> > +            copied =3D AUD_write(s->audio_be, voice, tmpbuf, to_copy);
> >               if (!copied) {
> >                   break;
> >               }
> > diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> > index 69ddc419191..1ede1c4a51d 100644
> > --- a/hw/audio/gus.c
> > +++ b/hw/audio/gus.c
> > @@ -87,7 +87,8 @@ static int write_audio (GUSState *s, int samples)
> >           int nbytes, wbytes, wsampl;
> >
> >           nbytes =3D samples << s->shift;
> > -        wbytes =3D AUD_write (
> > +        wbytes =3D AUD_write(
> > +            s->audio_be,
> >               s->voice,
> >               s->mixbuf + (pos << (s->shift - 1)),
> >               nbytes
> > @@ -257,7 +258,7 @@ static void gus_realizefn (DeviceState *dev, Error =
**errp)
> >       as.fmt =3D AUDIO_FORMAT_S16;
> >       as.endianness =3D HOST_BIG_ENDIAN;
> >
> > -    s->voice =3D AUD_open_out (
> > +    s->voice =3D AUD_open_out(
> >           s->audio_be,
> >           NULL,
> >           "gus",
> > @@ -272,7 +273,7 @@ static void gus_realizefn (DeviceState *dev, Error =
**errp)
> >       }
> >
> >       s->shift =3D 2;
> > -    s->samples =3D AUD_get_buffer_size_out (s->voice) >> s->shift;
> > +    s->samples =3D AUD_get_buffer_size_out(s->audio_be, s->voice) >> s=
->shift;
> >       s->mixbuf =3D g_malloc0 (s->samples << s->shift);
> >
> >       isa_register_portio_list(d, &s->portio_list1, s->port,
> > @@ -287,7 +288,7 @@ static void gus_realizefn (DeviceState *dev, Error =
**errp)
> >       s->emu.opaque =3D s;
> >       s->pic =3D isa_bus_get_irq(bus, s->emu.gusirq);
> >
> > -    AUD_set_active_out (s->voice, 1);
> > +    AUD_set_active_out(s->audio_be, s->voice, 1);
> >   }
> >
> >   static const Property gus_properties[] =3D {
> > diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> > index 6445d227594..0373d2f7271 100644
> > --- a/hw/audio/hda-codec.c
> > +++ b/hw/audio/hda-codec.c
> > @@ -275,7 +275,8 @@ static void hda_audio_input_cb(void *opaque, int av=
ail)
> >       while (to_transfer) {
> >           uint32_t start =3D (uint32_t) (wpos & B_MASK);
> >           uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer=
);
> > -        uint32_t read =3D AUD_read(st->voice.in, st->buf + start, chun=
k);
> > +        uint32_t read =3D AUD_read(st->state->audio_be, st->voice.in,
> > +                                 st->buf + start, chunk);
> >           wpos +=3D read;
> >           to_transfer -=3D read;
> >           st->wpos +=3D read;
> > @@ -354,7 +355,8 @@ static void hda_audio_output_cb(void *opaque, int a=
vail)
> >       while (to_transfer) {
> >           uint32_t start =3D (uint32_t) (rpos & B_MASK);
> >           uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer=
);
> > -        uint32_t written =3D AUD_write(st->voice.out, st->buf + start,=
 chunk);
> > +        uint32_t written =3D AUD_write(st->state->audio_be, st->voice.=
out,
> > +                                     st->buf + start, chunk);
> >           rpos +=3D written;
> >           to_transfer -=3D written;
> >           st->rpos +=3D written;
> > @@ -375,7 +377,8 @@ static void hda_audio_compat_input_cb(void *opaque,=
 int avail)
> >
> >       while (avail - recv >=3D sizeof(st->compat_buf)) {
> >           if (st->compat_bpos !=3D sizeof(st->compat_buf)) {
> > -            len =3D AUD_read(st->voice.in, st->compat_buf + st->compat=
_bpos,
> > +            len =3D AUD_read(st->state->audio_be, st->voice.in,
> > +                           st->compat_buf + st->compat_bpos,
> >                              sizeof(st->compat_buf) - st->compat_bpos);
> >               st->compat_bpos +=3D len;
> >               recv +=3D len;
> > @@ -408,7 +411,8 @@ static void hda_audio_compat_output_cb(void *opaque=
, int avail)
> >               }
> >               st->compat_bpos =3D 0;
> >           }
> > -        len =3D AUD_write(st->voice.out, st->compat_buf + st->compat_b=
pos,
> > +        len =3D AUD_write(st->state->audio_be, st->voice.out,
> > +                        st->compat_buf + st->compat_bpos,
> >                           sizeof(st->compat_buf) - st->compat_bpos);
> >           st->compat_bpos +=3D len;
> >           sent +=3D len;
> > @@ -440,9 +444,9 @@ static void hda_audio_set_running(HDAAudioStream *s=
t, bool running)
> >           }
> >       }
> >       if (st->output) {
> > -        AUD_set_active_out(st->voice.out, st->running);
> > +        AUD_set_active_out(st->state->audio_be, st->voice.out, st->run=
ning);
> >       } else {
> > -        AUD_set_active_in(st->voice.in, st->running);
> > +        AUD_set_active_in(st->state->audio_be, st->voice.in, st->runni=
ng);
> >       }
> >   }
> >
> > @@ -466,9 +470,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
> >           return;
> >       }
> >       if (st->output) {
> > -        AUD_set_volume_out_lr(st->voice.out, muted, left, right);
> > +        AUD_set_volume_out_lr(st->state->audio_be, st->voice.out, mute=
d, left, right);
> >       } else {
> > -        AUD_set_volume_in_lr(st->voice.in, muted, left, right);
> > +        AUD_set_volume_in_lr(st->state->audio_be, st->voice.in, muted,=
 left, right);
> >       }
> >   }
> >
> > diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
> > index f85226d1ac5..b875e83d454 100644
> > --- a/hw/audio/lm4549.c
> > +++ b/hw/audio/lm4549.c
> > @@ -101,11 +101,11 @@ static void lm4549_audio_transfer(lm4549_state *s=
)
> >       uint32_t i;
> >
> >       /* Activate the voice */
> > -    AUD_set_active_out(s->voice, 1);
> > +    AUD_set_active_out(s->audio_be, s->voice, 1);
> >       s->voice_is_active =3D 1;
> >
> >       /* Try to write the buffer content */
> > -    written_bytes =3D AUD_write(s->voice, s->buffer,
> > +    written_bytes =3D AUD_write(s->audio_be, s->voice, s->buffer,
> >                                 s->buffer_level * sizeof(uint16_t));
> >       written_samples =3D written_bytes >> 1;
> >
> > @@ -129,14 +129,14 @@ static void lm4549_audio_out_callback(void *opaqu=
e, int free)
> >       static uint32_t prev_buffer_level;
> >
> >   #ifdef LM4549_DEBUG
> > -    int size =3D AUD_get_buffer_size_out(s->voice);
> > +    int size =3D AUD_get_buffer_size_out(s->audio_be, s->voice);
> >       DPRINTF("audio_out_callback size =3D %i free =3D %i\n", size, fre=
e);
> >   #endif
> >
> >       /* Detect that no data are consumed
> >          =3D> disable the voice */
> >       if (s->buffer_level =3D=3D prev_buffer_level) {
> > -        AUD_set_active_out(s->voice, 0);
> > +        AUD_set_active_out(s->audio_be, s->voice, 0);
> >           s->voice_is_active =3D 0;
> >       }
> >       prev_buffer_level =3D s->buffer_level;
> > @@ -285,7 +285,7 @@ static int lm4549_post_load(void *opaque, int versi=
on_id)
> >
> >       /* Request data */
> >       if (s->voice_is_active =3D=3D 1) {
> > -        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->voice)=
);
> > +        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->audio_=
be, s->voice));
> >       }
> >
> >       return 0;
> > @@ -323,7 +323,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback d=
ata_req_cb, void* opaque,
> >           &as
> >       );
> >
> > -    AUD_set_volume_out_lr(s->voice, 0, 255, 255);
> > +    AUD_set_volume_out_lr(s->audio_be, s->voice, 0, 255, 255);
> >
> >       s->voice_is_active =3D 0;
> >
> > diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> > index 916c56fa4c0..a74a263b37e 100644
> > --- a/hw/audio/pcspk.c
> > +++ b/hw/audio/pcspk.c
> > @@ -106,7 +106,7 @@ static void pcspk_callback(void *opaque, int free)
> >
> >       while (free > 0) {
> >           n =3D MIN(s->samples - s->play_pos, (unsigned int)free);
> > -        n =3D AUD_write(s->voice, &s->sample_buf[s->play_pos], n);
> > +        n =3D AUD_write(s->audio_be, s->voice, &s->sample_buf[s->play_=
pos], n);
> >           if (!n)
> >               break;
> >           s->play_pos =3D (s->play_pos + n) % s->samples;
> > @@ -164,7 +164,7 @@ static void pcspk_io_write(void *opaque, hwaddr add=
r, uint64_t val,
> >       if (s->voice) {
> >           if (gate) /* restart */
> >               s->play_pos =3D 0;
> > -        AUD_set_active_out(s->voice, gate & s->data_on);
> > +        AUD_set_active_out(s->audio_be, s->voice, gate & s->data_on);
> >       }
> >   }
> >
> > diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> > index 3c5beb9dfa3..da0c33ea41b 100644
> > --- a/hw/audio/sb16.c
> > +++ b/hw/audio/sb16.c
> > @@ -185,11 +185,11 @@ static void control (SB16State *s, int hold)
> >
> >       if (hold) {
> >           k->hold_DREQ(isa_dma, dma);
> > -        AUD_set_active_out (s->voice, 1);
> > +        AUD_set_active_out(s->audio_be, s->voice, 1);
> >       }
> >       else {
> >           k->release_DREQ(isa_dma, dma);
> > -        AUD_set_active_out (s->voice, 0);
> > +        AUD_set_active_out(s->audio_be, s->voice, 0);
> >       }
> >   }
> >
> > @@ -215,7 +215,7 @@ static void continue_dma8 (SB16State *s)
> >           as.fmt =3D s->fmt;
> >           as.endianness =3D 0;
> >
> > -        s->voice =3D AUD_open_out (
> > +        s->voice =3D AUD_open_out(
> >               s->audio_be,
> >               s->voice,
> >               "sb16",
> > @@ -378,7 +378,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uin=
t8_t d0, int dma_len)
> >           as.fmt =3D s->fmt;
> >           as.endianness =3D 0;
> >
> > -        s->voice =3D AUD_open_out (
> > +        s->voice =3D AUD_open_out(
> >               s->audio_be,
> >               s->voice,
> >               "sb16",
> > @@ -879,7 +879,7 @@ static void legacy_reset (SB16State *s)
> >       as.fmt =3D AUDIO_FORMAT_U8;
> >       as.endianness =3D 0;
> >
> > -    s->voice =3D AUD_open_out (
> > +    s->voice =3D AUD_open_out(
> >           s->audio_be,
> >           s->voice,
> >           "sb16",
> > @@ -1196,7 +1196,7 @@ static int write_audio (SB16State *s, int nchan, =
int dma_pos,
> >           }
> >
> >           copied =3D k->read_memory(isa_dma, nchan, tmpbuf, dma_pos, to=
_copy);
> > -        copied =3D AUD_write (s->voice, tmpbuf, copied);
> > +        copied =3D AUD_write(s->audio_be, s->voice, tmpbuf, copied);
> >
> >           temp -=3D copied;
> >           dma_pos =3D (dma_pos + copied) % dma_len;
> > @@ -1302,7 +1302,7 @@ static int sb16_post_load (void *opaque, int vers=
ion_id)
> >               as.fmt =3D s->fmt;
> >               as.endianness =3D 0;
> >
> > -            s->voice =3D AUD_open_out (
> > +            s->voice =3D AUD_open_out(
> >                   s->audio_be,
> >                   s->voice,
> >                   "sb16",
> > diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
> > index 019d2968534..5b344d7a0fc 100644
> > --- a/hw/audio/via-ac97.c
> > +++ b/hw/audio/via-ac97.c
> > @@ -53,7 +53,7 @@ static void codec_volume_set_out(ViaAC97State *s)
> >       rvol /=3D 255;
> >       mute =3D CODEC_REG(s, AC97_Master_Volume_Mute) >> MUTE_SHIFT;
> >       mute |=3D CODEC_REG(s, AC97_PCM_Out_Volume_Mute) >> MUTE_SHIFT;
> > -    AUD_set_volume_out_lr(s->vo, mute, lvol, rvol);
> > +    AUD_set_volume_out_lr(s->audio_be, s->vo, mute, lvol, rvol);
> >   }
> >
> >   static void codec_reset(ViaAC97State *s)
> > @@ -189,7 +189,7 @@ static void out_cb(void *opaque, int avail)
> >           while (temp) {
> >               to_copy =3D MIN(temp, sizeof(tmpbuf));
> >               pci_dma_read(&s->dev, c->addr, tmpbuf, to_copy);
> > -            copied =3D AUD_write(s->vo, tmpbuf, to_copy);
> > +            copied =3D AUD_write(s->audio_be, s->vo, tmpbuf, to_copy);
> >               if (!copied) {
> >                   stop =3D true;
> >                   break;
> > @@ -208,7 +208,7 @@ static void out_cb(void *opaque, int avail)
> >                       c->stat |=3D STAT_PAUSED;
> >                   } else {
> >                       c->stat &=3D ~STAT_ACTIVE;
> > -                    AUD_set_active_out(s->vo, 0);
> > +                    AUD_set_active_out(s->audio_be, s->vo, 0);
> >                   }
> >                   if (c->type & STAT_EOL) {
> >                       via_isa_set_irq(&s->dev, 0, 1);
> > @@ -317,20 +317,20 @@ static void sgd_write(void *opaque, hwaddr addr, =
uint64_t val, unsigned size)
> >           break;
> >       case 1:
> >           if (val & CNTL_START) {
> > -            AUD_set_active_out(s->vo, 1);
> > +            AUD_set_active_out(s->audio_be, s->vo, 1);
> >               s->aur.stat =3D STAT_ACTIVE;
> >           }
> >           if (val & CNTL_TERM) {
> > -            AUD_set_active_out(s->vo, 0);
> > +            AUD_set_active_out(s->audio_be, s->vo, 0);
> >               s->aur.stat &=3D ~(STAT_ACTIVE | STAT_PAUSED);
> >               s->aur.clen =3D 0;
> >           }
> >           if (val & CNTL_PAUSE) {
> > -            AUD_set_active_out(s->vo, 0);
> > +            AUD_set_active_out(s->audio_be, s->vo, 0);
> >               s->aur.stat &=3D ~STAT_ACTIVE;
> >               s->aur.stat |=3D STAT_PAUSED;
> >           } else if (!(val & CNTL_PAUSE) && (s->aur.stat & STAT_PAUSED)=
) {
> > -            AUD_set_active_out(s->vo, 1);
> > +            AUD_set_active_out(s->audio_be, s->vo, 1);
> >               s->aur.stat |=3D STAT_ACTIVE;
> >               s->aur.stat &=3D ~STAT_PAUSED;
> >           }
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 9101560f387..47fef61af88 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -463,7 +463,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
*s, uint32_t stream_id)
> >                                            stream,
> >                                            virtio_snd_pcm_out_cb,
> >                                            &as);
> > -        AUD_set_volume_out_lr(stream->voice.out, 0, 255, 255);
> > +        AUD_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, =
255);
> >       } else {
> >           stream->voice.in =3D AUD_open_in(s->audio_be,
> >                                           stream->voice.in,
> > @@ -471,7 +471,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
*s, uint32_t stream_id)
> >                                           stream,
> >                                           virtio_snd_pcm_in_cb,
> >                                           &as);
> > -        AUD_set_volume_in_lr(stream->voice.in, 0, 255, 255);
> > +        AUD_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 25=
5);
> >       }
> >
> >       return cpu_to_le32(VIRTIO_SND_S_OK);
> > @@ -561,9 +561,9 @@ static void virtio_snd_handle_pcm_start_stop(VirtIO=
Sound *s,
> >               stream->active =3D start;
> >           }
> >           if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> > -            AUD_set_active_out(stream->voice.out, start);
> > +            AUD_set_active_out(s->audio_be, stream->voice.out, start);
> >           } else {
> > -            AUD_set_active_in(stream->voice.in, start);
> > +            AUD_set_active_in(s->audio_be, stream->voice.in, start);
> >           }
> >       } else {
> >           error_report("Invalid stream id: %"PRIu32, stream_id);
> > @@ -1166,7 +1166,8 @@ static void virtio_snd_pcm_out_cb(void *data, int=
 available)
> >                   buffer->populated =3D true;
> >               }
> >               for (;;) {
> > -                size =3D AUD_write(stream->voice.out,
> > +                size =3D AUD_write(stream->s->audio_be,
> > +                                 stream->voice.out,
> >                                    buffer->data + buffer->offset,
> >                                    MIN(buffer->size, available));
> >                   assert(size <=3D MIN(buffer->size, available));
> > @@ -1258,7 +1259,8 @@ static void virtio_snd_pcm_in_cb(void *data, int =
available)
> >                       return_rx_buffer(stream, buffer);
> >                       break;
> >                   }
> > -                size =3D AUD_read(stream->voice.in,
> > +                size =3D AUD_read(stream->s->audio_be,
> > +                        stream->voice.in,
> >                           buffer->data + buffer->size,
> >                           MIN(available, (stream->params.period_bytes -
> >                                           buffer->size)));
> > diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> > index 336fb6d20bd..bc347fe5376 100644
> > --- a/hw/audio/wm8750.c
> > +++ b/hw/audio/wm8750.c
> > @@ -72,7 +72,7 @@ static inline void wm8750_in_load(WM8750State *s)
> >       if (s->idx_in + s->req_in <=3D sizeof(s->data_in))
> >           return;
> >       s->idx_in =3D MAX(0, (int) sizeof(s->data_in) - s->req_in);
> > -    AUD_read(*s->in[0], s->data_in + s->idx_in,
> > +    AUD_read(s->audio_be, *s->in[0], s->data_in + s->idx_in,
> >                sizeof(s->data_in) - s->idx_in);
> >   }
> >
> > @@ -80,7 +80,7 @@ static inline void wm8750_out_flush(WM8750State *s)
> >   {
> >       int sent =3D 0;
> >       while (sent < s->idx_out)
> > -        sent +=3D AUD_write(*s->out[0], s->data_out + sent, s->idx_out=
 - sent)
> > +        sent +=3D AUD_write(s->audio_be, *s->out[0], s->data_out + sen=
t, s->idx_out - sent)
> >                   ?: s->idx_out;
> >       s->idx_out =3D 0;
> >   }
> > @@ -145,30 +145,30 @@ static void wm8750_vol_update(WM8750State *s)
> >   {
> >       /* FIXME: multiply all volumes by s->invol[2], s->invol[3] */
> >
> > -    AUD_set_volume_in_lr(s->adc_voice[0], s->mute,
> > +    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[0], s->mute,
> >                       s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invo=
l[0]),
> >                       s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invo=
l[1]));
> > -    AUD_set_volume_in_lr(s->adc_voice[1], s->mute,
> > +    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[1], s->mute,
> >                       s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invo=
l[0]),
> >                       s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invo=
l[1]));
> > -    AUD_set_volume_in_lr(s->adc_voice[2], s->mute,
> > +    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[2], s->mute,
> >                       s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invo=
l[0]),
> >                       s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invo=
l[1]));
> >
> >       /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
> >
> >       /* Speaker: LOUT2VOL ROUT2VOL */
> > -    AUD_set_volume_out_lr(s->dac_voice[0], s->mute,
> > +    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[0], s->mute,
> >                       s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->ou=
tvol[4]),
> >                       s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->ou=
tvol[5]));
> >
> >       /* Headphone: LOUT1VOL ROUT1VOL */
> > -    AUD_set_volume_out_lr(s->dac_voice[1], s->mute,
> > +    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[1], s->mute,
> >                       s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->ou=
tvol[2]),
> >                       s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->ou=
tvol[3]));
> >
> >       /* MONOOUT: MONOVOL MONOVOL */
> > -    AUD_set_volume_out_lr(s->dac_voice[2], s->mute,
> > +    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[2], s->mute,
> >                       s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->ou=
tvol[6]),
> >                       s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->ou=
tvol[6]));
> >   }
> > @@ -182,9 +182,9 @@ static void wm8750_set_format(WM8750State *s)
> >       wm8750_out_flush(s);
> >
> >       if (s->in[0] && *s->in[0])
> > -        AUD_set_active_in(*s->in[0], 0);
> > +        AUD_set_active_in(s->audio_be, *s->in[0], 0);
> >       if (s->out[0] && *s->out[0])
> > -        AUD_set_active_out(*s->out[0], 0);
> > +        AUD_set_active_out(s->audio_be, *s->out[0], 0);
> >
> >       for (i =3D 0; i < IN_PORT_N; i ++)
> >           if (s->adc_voice[i]) {
> > @@ -235,9 +235,9 @@ static void wm8750_set_format(WM8750State *s)
> >        * for mixing or combining paths to different ports, so we
> >        * connect both channels to where the left channel is routed.  */
> >       if (s->in[0] && *s->in[0])
> > -        AUD_set_active_in(*s->in[0], 1);
> > +        AUD_set_active_in(s->audio_be, *s->in[0], 1);
> >       if (s->out[0] && *s->out[0])
> > -        AUD_set_active_out(*s->out[0], 1);
> > +        AUD_set_active_out(s->audio_be, *s->out[0], 1);
> >   }
> >
> >   static void wm8750_clk_update(WM8750State *s, int ext)
> > diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> > index a24e95f0a73..deda7efe15d 100644
> > --- a/hw/display/xlnx_dp.c
> > +++ b/hw/display/xlnx_dp.c
> > @@ -331,7 +331,7 @@ static inline void xlnx_dp_audio_activate(XlnxDPSta=
te *s)
> >   {
> >       bool activated =3D ((s->core_registers[DP_TX_AUDIO_CONTROL]
> >                      & DP_TX_AUD_CTRL) !=3D 0);
> > -    AUD_set_active_out(s->amixer_output_stream, activated);
> > +    AUD_set_active_out(s->audio_be, s->amixer_output_stream, activated=
);
> >       xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(=
0),
> >                                         &s->audio_buffer_0);
> >       xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(=
1),
> > @@ -401,7 +401,7 @@ static void xlnx_dp_audio_callback(void *opaque, in=
t avail)
> >       /* Send the buffer through the audio. */
> >       if (s->byte_left <=3D MAX_QEMU_BUFFER_SIZE) {
> >           if (s->byte_left !=3D 0) {
> > -            written =3D AUD_write(s->amixer_output_stream,
> > +            written =3D AUD_write(s->audio_be, s->amixer_output_stream=
,
> >                                   &s->out_buffer[s->data_ptr], s->byte_=
left);
> >           } else {
> >                int len_to_copy;
> > @@ -413,12 +413,12 @@ static void xlnx_dp_audio_callback(void *opaque, =
int avail)
> >               while (avail) {
> >                   len_to_copy =3D MIN(AUD_CHBUF_MAX_DEPTH, avail);
> >                   memset(s->out_buffer, 0, len_to_copy);
> > -                avail -=3D AUD_write(s->amixer_output_stream, s->out_b=
uffer,
> > +                avail -=3D AUD_write(s->audio_be, s->amixer_output_str=
eam, s->out_buffer,
> >                                      len_to_copy);
> >               }
> >           }
> >       } else {
> > -        written =3D AUD_write(s->amixer_output_stream,
> > +        written =3D AUD_write(s->audio_be, s->amixer_output_stream,
> >                               &s->out_buffer[s->data_ptr], MAX_QEMU_BUF=
FER_SIZE);
> >       }
> >       s->byte_left -=3D written;
> > @@ -1401,7 +1401,7 @@ static void xlnx_dp_realize(DeviceState *dev, Err=
or **errp)
> >                                              s,
> >                                              xlnx_dp_audio_callback,
> >                                              &as);
> > -    AUD_set_volume_out_lr(s->amixer_output_stream, 0, 255, 255);
> > +    AUD_set_volume_out_lr(s->audio_be, s->amixer_output_stream, 0, 255=
, 255);
> >       xlnx_dp_audio_activate(s);
> >       s->vblank =3D ptimer_init(vblank_hit, s, DP_VBLANK_PTIMER_POLICY)=
;
> >       ptimer_transaction_begin(s->vblank);
> > diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> > index dfda2dccc04..0f36587fc6f 100644
> > --- a/hw/usb/dev-audio.c
> > +++ b/hw/usb/dev-audio.c
> > @@ -669,7 +669,7 @@ static void output_callback(void *opaque, int avail=
)
> >               return;
> >           }
> >
> > -        written =3D AUD_write(s->out.voice, data, len);
> > +        written =3D AUD_write(s->audio_be, s->out.voice, data, len);
> >           avail -=3D written;
> >           s->out.buf.cons +=3D written;
> >
> > @@ -683,7 +683,7 @@ static int usb_audio_set_output_altset(USBAudioStat=
e *s, int altset)
> >   {
> >       switch (altset) {
> >       case ALTSET_OFF:
> > -        AUD_set_active_out(s->out.voice, false);
> > +        AUD_set_active_out(s->audio_be, s->out.voice, false);
> >           break;
> >       case ALTSET_STEREO:
> >       case ALTSET_51:
> > @@ -692,7 +692,7 @@ static int usb_audio_set_output_altset(USBAudioStat=
e *s, int altset)
> >               usb_audio_reinit(USB_DEVICE(s), altset_channels[altset]);
> >           }
> >           streambuf_init(&s->out.buf, s->buffer, s->out.channels);
> > -        AUD_set_active_out(s->out.voice, true);
> > +        AUD_set_active_out(s->audio_be, s->out.voice, true);
> >           break;
> >       default:
> >           return -1;
> > @@ -805,7 +805,7 @@ static int usb_audio_set_control(USBAudioState *s, =
uint8_t attrib,
> >               }
> >               fprintf(stderr, "\n");
> >           }
> > -        AUD_set_volume_out(s->out.voice, &s->out.vol);
> > +        AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
> >       }
> >
> >       return ret;
> > @@ -980,8 +980,8 @@ static void usb_audio_reinit(USBDevice *dev, unsign=
ed channels)
> >
> >       s->out.voice =3D AUD_open_out(s->audio_be, s->out.voice, TYPE_USB=
_AUDIO,
> >                                   s, output_callback, &s->out.as);
> > -    AUD_set_volume_out(s->out.voice, &s->out.vol);
> > -    AUD_set_active_out(s->out.voice, 0);
> > +    AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
> > +    AUD_set_active_out(s->audio_be, s->out.voice, 0);
> >   }
> >
> >   static const VMStateDescription vmstate_usb_audio =3D {
> > diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> > index e1e518df2a7..c05285967c1 100644
> > --- a/tests/audio/test-audio.c
> > +++ b/tests/audio/test-audio.c
> > @@ -137,7 +137,7 @@ static void test_sine_callback(void *opaque, int av=
ail)
> >
> >       generate_sine_samples(buffer, frames_to_write, s->frames_written)=
;
> >
> > -    bytes_written =3D AUD_write(s->voice, buffer,
> > +    bytes_written =3D AUD_write(s->be, s->voice, buffer,
> >                                 frames_to_write * sizeof(int16_t) * CHA=
NNELS);
> >       s->frames_written +=3D bytes_written / (sizeof(int16_t) * CHANNEL=
S);
> >   }
> > @@ -158,7 +158,7 @@ static void test_audio_out_sine_wave(void)
> >                                         &state, test_sine_callback);
> >
> >       g_test_message("Playing 440Hz sine wave for %d seconds...", DURAT=
ION_SECS);
> > -    AUD_set_active_out(state.voice, true);
> > +    AUD_set_active_out(state.be, state.voice, true);
> >
> >       /*
> >        * Run the audio subsystem until all frames are written or timeou=
t.
> > @@ -183,7 +183,7 @@ static void test_audio_out_sine_wave(void)
> >
> >       g_assert_cmpint(state.frames_written, =3D=3D, state.total_frames)=
;
> >
> > -    AUD_set_active_out(state.voice, false);
> > +    AUD_set_active_out(state.be, state.voice, false);
> >       AUD_close_out(state.be, state.voice);
> >   }
> >
> > @@ -219,13 +219,13 @@ static void test_audio_out_active_state(void)
> >       be =3D get_test_audio_backend();
> >       voice =3D open_test_voice_out(be, "test-active", NULL, dummy_audi=
o_callback);
> >
> > -    g_assert_false(AUD_is_active_out(voice));
> > +    g_assert_false(AUD_is_active_out(be, voice));
> >
> > -    AUD_set_active_out(voice, true);
> > -    g_assert_true(AUD_is_active_out(voice));
> > +    AUD_set_active_out(be, voice, true);
> > +    g_assert_true(AUD_is_active_out(be, voice));
> >
> > -    AUD_set_active_out(voice, false);
> > -    g_assert_false(AUD_is_active_out(voice));
> > +    AUD_set_active_out(be, voice, false);
> > +    g_assert_false(AUD_is_active_out(be, voice));
> >
> >       AUD_close_out(be, voice);
> >   }
> > @@ -239,13 +239,13 @@ static void test_audio_out_buffer_size(void)
> >       be =3D get_test_audio_backend();
> >       voice =3D open_test_voice_out(be, "test-buffer", NULL, dummy_audi=
o_callback);
> >
> > -    buffer_size =3D AUD_get_buffer_size_out(voice);
> > +    buffer_size =3D AUD_get_buffer_size_out(be, voice);
> >       g_test_message("Buffer size: %d bytes", buffer_size);
> >       g_assert_cmpint(buffer_size, >, 0);
> >
> >       AUD_close_out(be, voice);
> >
> > -    g_assert_cmpint(AUD_get_buffer_size_out(NULL), =3D=3D, 0);
> > +    g_assert_cmpint(AUD_get_buffer_size_out(NULL, NULL), =3D=3D, 0);
> >   }
> >
> >   static void test_audio_out_volume(void)
> > @@ -258,13 +258,13 @@ static void test_audio_out_volume(void)
> >       voice =3D open_test_voice_out(be, "test-volume", NULL, dummy_audi=
o_callback);
> >
> >       vol =3D (Volume){.mute =3D false, .channels =3D 2, .vol =3D {255,=
 255}};
> > -    AUD_set_volume_out(voice, &vol);
> > +    AUD_set_volume_out(be, voice, &vol);
> >
> >       vol =3D (Volume){.mute =3D true, .channels =3D 2, .vol =3D {255, =
255}};
> > -    AUD_set_volume_out(voice, &vol);
> > +    AUD_set_volume_out(be, voice, &vol);
> >
> >       vol =3D (Volume){.mute =3D false, .channels =3D 2, .vol =3D {128,=
 128}};
> > -    AUD_set_volume_out(voice, &vol);
> > +    AUD_set_volume_out(be, voice, &vol);
> >
> >       AUD_close_out(be, voice);
> >   }
> > @@ -277,13 +277,13 @@ static void test_audio_in_active_state(void)
> >       be =3D get_test_audio_backend();
> >       voice =3D open_test_voice_in(be, "test-in-active", NULL, dummy_au=
dio_callback);
> >
> > -    g_assert_false(AUD_is_active_in(voice));
> > +    g_assert_false(AUD_is_active_in(be, voice));
> >
> > -    AUD_set_active_in(voice, true);
> > -    g_assert_true(AUD_is_active_in(voice));
> > +    AUD_set_active_in(be, voice, true);
> > +    g_assert_true(AUD_is_active_in(be, voice));
> >
> > -    AUD_set_active_in(voice, false);
> > -    g_assert_false(AUD_is_active_in(voice));
> > +    AUD_set_active_in(be, voice, false);
> > +    g_assert_false(AUD_is_active_in(be, voice));
> >
> >       AUD_close_in(be, voice);
> >   }
> > @@ -298,10 +298,10 @@ static void test_audio_in_volume(void)
> >       voice =3D open_test_voice_in(be, "test-in-volume", NULL, dummy_au=
dio_callback);
> >
> >       vol =3D (Volume){.mute =3D false, .channels =3D 2, .vol =3D {255,=
 255}};
> > -    AUD_set_volume_in(voice, &vol);
> > +    AUD_set_volume_in(be, voice, &vol);
> >
> >       vol =3D (Volume){.mute =3D true, .channels =3D 2, .vol =3D {255, =
255}};
> > -    AUD_set_volume_in(voice, &vol);
> > +    AUD_set_volume_in(be, voice, &vol);
> >
> >       AUD_close_in(be, voice);
> >   }
> > @@ -414,7 +414,7 @@ static void test_audio_capture(void)
> >                                   &sine_state, test_sine_callback);
> >       sine_state.voice =3D voice;
> >
> > -    AUD_set_active_out(voice, true);
> > +    AUD_set_active_out(be, voice, true);
> >
> >       start_time =3D g_get_monotonic_time();
> >       while (sine_state.frames_written < sine_state.total_frames ||
> > @@ -459,10 +459,10 @@ static void test_audio_capture(void)
> >           g_assert_cmpfloat(match_ratio, >=3D, 0.9);
> >       }
> >
> > -    AUD_set_active_out(voice, false);
> > +    AUD_set_active_out(be, voice, false);
> >       AUD_close_out(be, voice);
> >
> > -    AUD_del_capture(cap, &state);
> > +    AUD_del_capture(be, cap, &state);
> >       g_assert_true(state.destroy_called);
> >
> >       g_free(state.captured_samples);
> > @@ -470,26 +470,27 @@ static void test_audio_capture(void)
> >
> >   static void test_audio_null_handling(void)
> >   {
> > +    AudioBackend *be =3D get_test_audio_backend();
> >       uint8_t buffer[64];
> >
> >       /* AUD_is_active_out/in(NULL) should return false */
> > -    g_assert_false(AUD_is_active_out(NULL));
> > -    g_assert_false(AUD_is_active_in(NULL));
> > +    g_assert_false(AUD_is_active_out(be, NULL));
> > +    g_assert_false(AUD_is_active_in(be, NULL));
> >
> >       /* AUD_get_buffer_size_out(NULL) should return 0 */
> > -    g_assert_cmpint(AUD_get_buffer_size_out(NULL), =3D=3D, 0);
> > +    g_assert_cmpint(AUD_get_buffer_size_out(be, NULL), =3D=3D, 0);
> >
> >       /* AUD_write/read(NULL, ...) should return size (no-op) */
> > -    g_assert_cmpuint(AUD_write(NULL, buffer, sizeof(buffer)), =3D=3D,
> > +    g_assert_cmpuint(AUD_write(be, NULL, buffer, sizeof(buffer)), =3D=
=3D,
> >                        sizeof(buffer));
> > -    g_assert_cmpuint(AUD_read(NULL, buffer, sizeof(buffer)), =3D=3D,
> > +    g_assert_cmpuint(AUD_read(be, NULL, buffer, sizeof(buffer)), =3D=
=3D,
> >                        sizeof(buffer));
> >
> >       /* These should not crash */
> > -    AUD_set_active_out(NULL, true);
> > -    AUD_set_active_out(NULL, false);
> > -    AUD_set_active_in(NULL, true);
> > -    AUD_set_active_in(NULL, false);
> > +    AUD_set_active_out(be, NULL, true);
> > +    AUD_set_active_out(be, NULL, false);
> > +    AUD_set_active_in(be, NULL, true);
> > +    AUD_set_active_in(be, NULL, false);
> >   }
> >
> >   static void test_audio_multiple_voices(void)
> > @@ -503,17 +504,17 @@ static void test_audio_multiple_voices(void)
> >       out2 =3D open_test_voice_out(be, "test-multi-out2", NULL, dummy_a=
udio_callback);
> >       in1 =3D open_test_voice_in(be, "test-multi-in1", NULL, dummy_audi=
o_callback);
> >
> > -    AUD_set_active_out(out1, true);
> > -    AUD_set_active_out(out2, true);
> > -    AUD_set_active_in(in1, true);
> > +    AUD_set_active_out(be, out1, true);
> > +    AUD_set_active_out(be, out2, true);
> > +    AUD_set_active_in(be, in1, true);
> >
> > -    g_assert_true(AUD_is_active_out(out1));
> > -    g_assert_true(AUD_is_active_out(out2));
> > -    g_assert_true(AUD_is_active_in(in1));
> > +    g_assert_true(AUD_is_active_out(be, out1));
> > +    g_assert_true(AUD_is_active_out(be, out2));
> > +    g_assert_true(AUD_is_active_in(be, in1));
> >
> > -    AUD_set_active_out(out1, false);
> > -    AUD_set_active_out(out2, false);
> > -    AUD_set_active_in(in1, false);
> > +    AUD_set_active_out(be, out1, false);
> > +    AUD_set_active_out(be, out2, false);
> > +    AUD_set_active_in(be, in1, false);
> >
> >       AUD_close_in(be, in1);
> >       AUD_close_out(be, out2);
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index a61a4f937d6..c142d9fc7c0 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -1289,7 +1289,7 @@ static void audio_add(VncState *vs)
> >   static void audio_del(VncState *vs)
> >   {
> >       if (vs->audio_cap) {
> > -        AUD_del_capture(vs->audio_cap, vs);
> > +        AUD_del_capture(vs->vd->audio_be, vs->audio_cap, vs);
> >           vs->audio_cap =3D NULL;
> >       }
> >   }
>
> Hurrah!
>

I didn't realize that was exciting ;)

> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

thanks


