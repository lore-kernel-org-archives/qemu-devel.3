Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35989EF99FF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 07:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrAGL-0006Yl-Tp; Sat, 14 Feb 2026 02:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vrAGG-0006YT-M6
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 02:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vrAGC-0004Ri-67
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 02:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771054809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySToZXsYNyygNIOSR0tL2C1UVDYz5/Ok/N2XSDXKdSA=;
 b=Hwj+8y2qiNYhgtYcenHHcUhVEYexebolUnHpAzqJ4oz/B96VLTBdsy7yXZZ2aPeYn3VRg6
 NLozuJvFJraEg5ZD2Awpk+9QVJN68LWvgCd3lROmORCuGpi+JWkboolFlO43T622dNR9AX
 yAqxrcQ5L5j8EMIlz3ujYGOaB8pgd2o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-n206wLTSPKmujDitlPG4Tg-1; Sat, 14 Feb 2026 02:40:07 -0500
X-MC-Unique: n206wLTSPKmujDitlPG4Tg-1
X-Mimecast-MFC-AGG-ID: n206wLTSPKmujDitlPG4Tg_1771054806
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf0dbd073so17874305ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 23:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771054806; cv=none;
 d=google.com; s=arc-20240605;
 b=FKQxjJaZ/KJL+TXgYalTms4bl2Q4LC38LojUfsVi7uQCDpJZeVlU/BlIICoziHXUge
 mXtVl/H59j4g3iuQAMx8DyAqv7ISMGWgnVsvmesu8Q/yEMZnA6jdDSMjtruVfeyeuLRl
 dmG38z1ldZ94sA1DR5mkuS4sfI3uCauA6u/59BrYSh4PTSSOniMs9BABdTxS1M2ftvIV
 hShcx7SpQKDmEWwTQvOumzg3MryJWH8UFPBulrZos2qfaQHe66kZs0Kb+9CA5GEW2Evv
 rgB503OMDCGSILGNsPF46wPKf/WKx+nRv8c902G61guVDHQpbjpSOQDH0GTMyQTMlJWi
 I8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ySToZXsYNyygNIOSR0tL2C1UVDYz5/Ok/N2XSDXKdSA=;
 fh=zZeCa5XiibcSk2bG2RrSIkO6qE6M5DHehoxNWYa1mBk=;
 b=V9j1u7MGFukv90Mjoan6JfKbT+jtb71v8tZ29nfr6jx9ZpFee+5ul3+yLxm1Qt7Ybk
 ttamd349wPAt0zDYfzgisirXJbtALBWb8+4DwLTGghHvvCjkEtyNuNIMo8tTxJlaboaj
 gIMPCWzolrwVMX4Eif2GVumUAl4y1g4KzJpQNE5/ZULh+exSYFQ5kOsIhdsTABOu2Y/f
 CFbtdqRgx+6qnNW0sehWTHWQ7uijjq/5egmZuhIw2vmwAdxVIWWsbtoEyXPYLTMmVEI4
 aogYJ9DxXIVW8AsWyHovO5kW+mYR92sPDKNxxr/cFG7kZw59G8qntQoHdzx79afT8JoS
 q3wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771054806; x=1771659606; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySToZXsYNyygNIOSR0tL2C1UVDYz5/Ok/N2XSDXKdSA=;
 b=ZDGqKZc8LWZ9jidLeOHGu8kWOoFus5DpmvT1aBGCyUJhvNmAGnJ9OctekNnuBHRXUb
 o+gWhuJcMOUSrYynVyMnJXwjZiYoL+WCnal3f+24AFigVMGCw2Ge6sl5ny+FAXqvthE1
 7YN2xjdNYe8AtteuXcpd7zvY1b0l8QQWiHnuon8ZAsnQQaf6RK6egIpednzP556tdI0D
 UQms4O0/LqE3JvH5aovdH7nm21AIJ+cmRUrj0lIVYDw3w6c8Rw/XJ/ZbUDRF7Q8jTuve
 tIN02PVIo7TsRR86fPcv8dfX07DOa6NZOF8a8iFcAgcLwY2S4uXE8v5WwFa6pwUnRYyG
 8hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771054806; x=1771659606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ySToZXsYNyygNIOSR0tL2C1UVDYz5/Ok/N2XSDXKdSA=;
 b=banKSchxnWkMmkOWZequZEVsx8WWW/8A8XbALuo5NTaekj6qtsN9VBMfRpLHPIUze4
 b8qNBdL30AqUilR2IBPLGDCS7jhof4F4uk3+/JgKmlzluR15nyjHGNdz2XvLDdZeS7O3
 YBv4WPXZi5zoIP7MRKfg/6XmT5oGYOEq+/fmCAoCOcFdkE/pGhEg8KrpUPmihky9qm8/
 w0DVv26XAt9AmzaTDRLZbWAUkjHbJVlPLFdWUqjQ+5w6caOkHGd89rTrDE6VlzudYKrm
 gEEF4nzy+6nZvGoCY77bBuo2krQ99ts8ekn5tUpocn8/j7LCx+qjPt6N23cW2mgJga8S
 aAeQ==
X-Gm-Message-State: AOJu0Yw4HWn48gxKODCYVWuFrFoktfFJnXytXZRmLHjECay48i7Xx7mg
 KvHiBbxixC2LOzLX6wZINmqGI4uA13m1D5BaEe6xbuFclBhe/xl1W6vXaesVUPwL46zWdZM5Fe0
 U5OFd13rizi/tANPXqsuX91Og4vtDH0ChdEIbRLFwYUlFQhyGvZazsYeWUpepj1um2klZwKQfRs
 2/RFulqf8tyjiypPeRxb+efS4lw9jcB5Q=
X-Gm-Gg: AZuq6aIIM4W1lRz6z9MBvRT4hJkmO4MfAPoS1G71jQVWGukvtj0aR2QuxOSVs5svlnP
 ZZkM3SspQTqIpbInQEFJ6xtvsmkcYtCLAKtr73hwKNow9o0VLsSZQMQ0E0W3sp1ro22m51PZa2g
 OgLssraU+jNbLsPL0bNpZ03hQK4f3I9XgqdXN6wiPGqtJkNi+xMq4/e+zgZNpwogIzr9kvZwKYs
 NdpV4Ij8OYQrQ5noGqGvLQKZT74WdIA16/FXCo=
X-Received: by 2002:a17:903:19cf:b0:2ab:3cba:4304 with SMTP id
 d9443c01a7336-2ab505e4f39mr43593155ad.43.1771054805648; 
 Fri, 13 Feb 2026 23:40:05 -0800 (PST)
X-Received: by 2002:a17:903:19cf:b0:2ab:3cba:4304 with SMTP id
 d9443c01a7336-2ab505e4f39mr43592815ad.43.1771054804861; Fri, 13 Feb 2026
 23:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-17-marcandre.lureau@redhat.com>
 <2429b419-80dc-46ff-a12c-05974b812bed@nutanix.com>
In-Reply-To: <2429b419-80dc-46ff-a12c-05974b812bed@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 14 Feb 2026 11:39:53 +0400
X-Gm-Features: AZwV_Qj3s9h5xJZVNZJJP2nIdtVLPWYN09yW53J7av9zu_MGz4l9Fm49WgZtbt8
Message-ID: <CAMxuvaytcFa8=bPLRXfs+C-KSVoSySHgP69ig5i_eDcpBECnGg@mail.gmail.com>
Subject: Re: [PATCH 16/43] audio: move pcm_ops into AudioMixengBackendClass
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Thomas Huth <huth@tuxfamily.org>,
 Alexandre Ratchov <alex@caoua.org>
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

On Fri, Feb 13, 2026 at 11:50=E2=80=AFAM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Remove the separate audio_pcm_ops structure and move its function
> > pointers directly into AudioMixengBackendClass. This is a cleaner
> > QOM-style design where the PCM operations are part of the class
> > vtable rather than a separate indirection through hw->pcm_ops.
> >
> > The HWVoiceOut and HWVoiceIn structures no longer need to store
> > a pcm_ops pointer, as the operations are now accessed through
> > the class with AUDIO_MIXENG_BACKEND_GET_CLASS().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio_int.h       |  71 +++++++++-----------
> >   audio/audio_template.h  |  16 +++--
> >   audio/alsaaudio.c       |  29 ++++-----
> >   audio/audio-mixeng-be.c | 139 ++++++++++++++++++++++-----------------=
-
> >   audio/dbusaudio.c       |  33 +++++-----
> >   audio/dsoundaudio.c     |  33 +++++-----
> >   audio/jackaudio.c       |  29 ++++-----
> >   audio/noaudio.c         |  29 ++++-----
> >   audio/ossaudio.c        |  33 +++++-----
> >   audio/paaudio.c         |  33 +++++-----
> >   audio/pwaudio.c         |  33 +++++-----
> >   audio/sdlaudio.c        |  46 +++++++------
> >   audio/sndioaudio.c      |  32 +++++----
> >   audio/spiceaudio.c      |  45 ++++++-------
> >   audio/wavaudio.c        |  17 ++---
> >   audio/coreaudio.m       |  27 ++++----
> >   16 files changed, 308 insertions(+), 337 deletions(-)
> >
> > diff --git a/audio/audio_int.h b/audio/audio_int.h
> > index bd9c7a29e41..5334c4baad2 100644
> > --- a/audio/audio_int.h
> > +++ b/audio/audio_int.h
> > @@ -39,8 +39,6 @@ AUD_vlog(const char *cap, const char *fmt, va_list ap=
);
> >   void G_GNUC_PRINTF(2, 3)
> >   AUD_log(const char *cap, const char *fmt, ...);
> >
> > -struct audio_pcm_ops;
> > -
> >   struct audio_callback {
> >       void *opaque;
> >       audio_callback_fn fn;
> > @@ -81,7 +79,6 @@ typedef struct HWVoiceOut {
> >       size_t samples;
> >       QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
> >       QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
> > -    struct audio_pcm_ops *pcm_ops;
> >       QLIST_ENTRY (HWVoiceOut) entries;
> >   } HWVoiceOut;
> >
> > @@ -101,7 +98,6 @@ typedef struct HWVoiceIn {
> >
> >       size_t samples;
> >       QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
> > -    struct audio_pcm_ops *pcm_ops;
> >       QLIST_ENTRY (HWVoiceIn) entries;
> >   } HWVoiceIn;
> >
> > @@ -136,40 +132,6 @@ struct SWVoiceIn {
> >       QLIST_ENTRY (SWVoiceIn) entries;
> >   };
> >
> > -struct audio_pcm_ops {
> > -    int    (*init_out)(HWVoiceOut *hw, audsettings *as);
> > -    void   (*fini_out)(HWVoiceOut *hw);
> > -    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
> > -    void   (*run_buffer_out)(HWVoiceOut *hw);
> > -    /*
> > -     * Get the free output buffer size. This is an upper limit. The si=
ze
> > -     * returned by function get_buffer_out may be smaller.
> > -     */
> > -    size_t (*buffer_get_free)(HWVoiceOut *hw);
> > -    /*
> > -     * get a buffer that after later can be passed to put_buffer_out; =
optional
> > -     * returns the buffer, and writes it's size to size (in bytes)
> > -     */
> > -    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
> > -    /*
> > -     * put back the buffer returned by get_buffer_out; optional
> > -     * buf must be equal the pointer returned by get_buffer_out,
> > -     * size may be smaller
> > -     */
> > -    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
> > -    void   (*enable_out)(HWVoiceOut *hw, bool enable);
> > -    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
> > -
> > -    int    (*init_in) (HWVoiceIn *hw, audsettings *as);
> > -    void   (*fini_in) (HWVoiceIn *hw);
> > -    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
> > -    void   (*run_buffer_in)(HWVoiceIn *hw);
> > -    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
> > -    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
> > -    void   (*enable_in)(HWVoiceIn *hw, bool enable);
> > -    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
> > -};
> > -
> >   audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)=
;
> >   int audioformat_bytes_per_sample(AudioFormat fmt);
> >   int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
> > @@ -220,11 +182,42 @@ struct AudioMixengBackendClass {
> >       AudioBackendClass parent_class;
> >
> >       const char *name;
> > -    struct audio_pcm_ops *pcm_ops;
> >       int max_voices_out;
> >       int max_voices_in;
> >       size_t voice_size_out;
> >       size_t voice_size_in;
> > +
> > +    int    (*init_out)(HWVoiceOut *hw, audsettings *as);
> > +    void   (*fini_out)(HWVoiceOut *hw);
> > +    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
> > +    void   (*run_buffer_out)(HWVoiceOut *hw);
> > +    /*
> > +     * Get the free output buffer size. This is an upper limit. The si=
ze
> > +     * returned by function get_buffer_out may be smaller.
> > +     */
> > +    size_t (*buffer_get_free)(HWVoiceOut *hw);
> > +    /*
> > +     * get a buffer that after later can be passed to put_buffer_out; =
optional
> > +     * returns the buffer, and writes it's size to size (in bytes)
> > +     */
> > +    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
> > +    /*
> > +     * put back the buffer returned by get_buffer_out; optional
> > +     * buf must be equal the pointer returned by get_buffer_out,
> > +     * size may be smaller
> > +     */
> > +    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
> > +    void   (*enable_out)(HWVoiceOut *hw, bool enable);
> > +    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
> > +
> > +    int    (*init_in) (HWVoiceIn *hw, audsettings *as);
> > +    void   (*fini_in) (HWVoiceIn *hw);
> > +    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
> > +    void   (*run_buffer_in)(HWVoiceIn *hw);
> > +    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
> > +    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
> > +    void   (*enable_in)(HWVoiceIn *hw, bool enable);
> > +    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
> >   };
> >
> >   struct AudioMixengBackend {
> > diff --git a/audio/audio_template.h b/audio/audio_template.h
> > index 7187571c668..08d60422589 100644
> > --- a/audio/audio_template.h
> > +++ b/audio/audio_template.h
> > @@ -223,13 +223,14 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **h=
wp)
> >   {
> >       HW *hw =3D *hwp;
> >       AudioMixengBackend *s =3D hw->s;
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(s);
> >
> >       if (!hw->sw_head.lh_first) {
> >   #ifdef DAC
> >           audio_detach_capture(hw);
> >   #endif
> >           QLIST_REMOVE(hw, entries);
> > -        glue(hw->pcm_ops->fini_, TYPE) (hw);
> > +        glue(k->fini_, TYPE)(hw);
> >           glue(s->nb_hw_voices_, TYPE) +=3D 1;
> >           glue(audio_pcm_hw_free_resources_ , TYPE) (hw);
> >           object_unref(hw->s);
> > @@ -274,8 +275,8 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioM=
ixengBackend *s,
> >           return NULL;
> >       }
> >
> > -    if (audio_bug(__func__, !k->pcm_ops)) {
> > -        dolog("No host audio driver or missing pcm_ops\n");
> > +    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
> > +        dolog("No host audio driver or missing init_%s\n", NAME);
> >           return NULL;
> >       }
> >
> > @@ -285,13 +286,12 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(Audi=
oMixengBackend *s,
> >        */
> >       hw =3D g_malloc0(glue(k->voice_size_, TYPE));
> >       hw->s =3D AUDIO_MIXENG_BACKEND(object_ref(s));
> > -    hw->pcm_ops =3D k->pcm_ops;
> >
> >       QLIST_INIT (&hw->sw_head);
> >   #ifdef DAC
> >       QLIST_INIT (&hw->cap_head);
> >   #endif
> > -    if (glue (hw->pcm_ops->init_, TYPE) (hw, as)) {
> > +    if (glue(k->init_, TYPE)(hw, as)) {
> >           goto err0;
> >       }
> >
> > @@ -330,7 +330,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioM=
ixengBackend *s,
> >       return hw;
> >
> >    err1:
> > -    glue (hw->pcm_ops->fini_, TYPE) (hw);
> > +    glue(k->fini_, TYPE)(hw);
> >    err0:
> >       object_unref(hw->s);
> >       g_free (hw);
> > @@ -495,6 +495,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
> >       const struct audsettings *as)
> >   {
> >       AudioMixengBackend *s =3D AUDIO_MIXENG_BACKEND(be);
> > +    AudioMixengBackendClass *k;
> >       AudiodevPerDirectionOptions *pdo;
> >
> >       if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> > @@ -503,6 +504,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
> >           goto fail;
> >       }
> >
> > +    k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(s);
> >       pdo =3D glue(audio_get_pdo_, TYPE)(s->dev);
> >
> >       ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
> > @@ -513,7 +515,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
> >           goto fail;
> >       }
> >
> > -    if (audio_bug(__func__, !AUDIO_MIXENG_BACKEND_GET_CLASS(s)->pcm_op=
s)) {
> > +    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
> >           dolog("Can not open `%s' (no host audio driver)\n", name);
> >           goto fail;
> >       }
> > diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> > index a49da32cc4e..d3697a148da 100644
> > --- a/audio/alsaaudio.c
> > +++ b/audio/alsaaudio.c
> > @@ -922,21 +922,6 @@ audio_alsa_realize(AudioBackend *abe, Audiodev *de=
v, Error **errp)
> >       return audio_alsa_parent_class->realize(abe, dev, errp);
> >   }
> >
> > -static struct audio_pcm_ops alsa_pcm_ops =3D {
> > -    .init_out =3D alsa_init_out,
> > -    .fini_out =3D alsa_fini_out,
> > -    .write    =3D alsa_write,
> > -    .buffer_get_free =3D alsa_buffer_get_free,
> > -    .run_buffer_out =3D audio_generic_run_buffer_out,
> > -    .enable_out =3D alsa_enable_out,
> > -
> > -    .init_in  =3D alsa_init_in,
> > -    .fini_in  =3D alsa_fini_in,
> > -    .read     =3D alsa_read,
> > -    .run_buffer_in =3D audio_generic_run_buffer_in,
> > -    .enable_in =3D alsa_enable_in,
> > -};
> > -
> >   static void audio_alsa_class_init(ObjectClass *klass, const void *dat=
a)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -946,11 +931,23 @@ static void audio_alsa_class_init(ObjectClass *kl=
ass, const void *data)
> >
> >       b->realize =3D audio_alsa_realize;
> >       k->name =3D "alsa";
> > -    k->pcm_ops =3D &alsa_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(ALSAVoiceOut);
> >       k->voice_size_in =3D sizeof(ALSAVoiceIn);
> > +
> > +    k->init_out =3D alsa_init_out;
> > +    k->fini_out =3D alsa_fini_out;
> > +    k->write =3D alsa_write;
> > +    k->buffer_get_free =3D alsa_buffer_get_free;
> > +    k->run_buffer_out =3D audio_generic_run_buffer_out;
>
> Is it possible to set k->run_buffer_out to
> audio_generic_run_buffer_out() in audio_mixeng_backend_class_init()?
> This would probably make sense as a follow-up patch to this one.

Yes, in principle we should be able to make all audio_generic fns
overridable default methods. However, this must be done carefully,
because each backend mixes or wraps a different subset of those. Also,
having all audio_generic methods together is not a suitable default
(audio_generic_run_buffer_in would be called recursively through
audio_generic_read). I'll leave that for another cleanup series :)


>
> > +    k->enable_out =3D alsa_enable_out;
> > +
> > +    k->init_in =3D alsa_init_in;
> > +    k->fini_in =3D alsa_fini_in;
> > +    k->read =3D alsa_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
>
> Same here?
>
> > +    k->enable_in =3D alsa_enable_in;
> >   }
> >
> >   static const TypeInfo audio_alsa_info =3D {
> > diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> > index 9d16fb5e654..8f06afba821 100644
> > --- a/audio/audio-mixeng-be.c
> > +++ b/audio/audio-mixeng-be.c
> > @@ -526,7 +526,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void=
 *buf, size_t buf_len)
> >
> >       audio_pcm_sw_resample_in(sw, live, frames_out_max, &total_in, &to=
tal_out);
> >
> > -    if (!hw->pcm_ops->volume_in) {
> > +    if (!AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)->volume_in) {
> >           mixeng_volume(sw->resample_buf.buffer, total_out, &sw->vol);
> >       }
> >       sw->clip(buf, sw->resample_buf.buffer, total_out);
> > @@ -579,8 +579,10 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOu=
t *hw, int *nb_live)
> >
> >   static size_t audio_pcm_hw_get_free(HWVoiceOut *hw)
> >   {
> > -    return (hw->pcm_ops->buffer_get_free ? hw->pcm_ops->buffer_get_fre=
e(hw) :
> > -            INT_MAX) / hw->info.bytes_per_frame;
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> > +
> > +    return (k->buffer_get_free ? k->buffer_get_free(hw) : INT_MAX) /
> > +        hw->info.bytes_per_frame;
> >   }
> >
> >   static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size=
_t len)
> > @@ -673,7 +675,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, vo=
id *buf, size_t buf_len)
> >       if (frames_in_max > sw->resample_buf.pos) {
> >           sw->conv(sw->resample_buf.buffer + sw->resample_buf.pos,
> >                    buf, frames_in_max - sw->resample_buf.pos);
> > -        if (!sw->hw->pcm_ops->volume_out) {
> > +        if (!AUDIO_MIXENG_BACKEND_GET_CLASS(sw->hw->s)->volume_out) {
> >               mixeng_volume(sw->resample_buf.buffer + sw->resample_buf.=
pos,
> >                             frames_in_max - sw->resample_buf.pos, &sw->=
vol);
> >           }
> > @@ -806,7 +808,7 @@ static size_t audio_mixeng_backend_write(AudioBacke=
nd *be, SWVoiceOut *sw,
> >       if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
> >           return audio_pcm_sw_write(sw, buf, size);
> >       } else {
> > -        return hw->pcm_ops->write(hw, buf, size);
> > +        return AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)->write(hw, buf, s=
ize);
> >       }
> >   }
> >
> > @@ -829,7 +831,7 @@ static size_t audio_mixeng_backend_read(AudioBacken=
d *be,
> >       if (audio_get_pdo_in(hw->s->dev)->mixing_engine) {
> >           return audio_pcm_sw_read(sw, buf, size);
> >       } else {
> > -        return hw->pcm_ops->read(hw, buf, size);
> > +        return AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)->read(hw, buf, si=
ze);
> >       }
> >
> >   }
> > @@ -863,12 +865,14 @@ static void audio_mixeng_backend_set_active_out(A=
udioBackend *be, SWVoiceOut *sw
> >           SWVoiceCap *sc;
> >
> >           if (on) {
> > +            AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CL=
ASS(s);
> > +
> >               hw->pending_disable =3D 0;
> >               if (!hw->enabled) {
> >                   hw->enabled =3D true;
> >                   if (runstate_is_running()) {
> > -                    if (hw->pcm_ops->enable_out) {
> > -                        hw->pcm_ops->enable_out(hw, true);
> > +                    if (k->enable_out) {
> > +                        k->enable_out(hw, true);
> >                       }
> >                       audio_reset_timer (s);
> >                   }
> > @@ -908,14 +912,15 @@ static void audio_mixeng_backend_set_active_in(Au=
dioBackend *be, SWVoiceIn *sw,
> >       hw =3D sw->hw;
> >       if (sw->active !=3D on) {
> >           AudioMixengBackend *s =3D sw->s;
> > +        AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(=
s);
> >           SWVoiceIn *temp_sw;
> >
> >           if (on) {
> >               if (!hw->enabled) {
> >                   hw->enabled =3D true;
> >                   if (runstate_is_running()) {
> > -                    if (hw->pcm_ops->enable_in) {
> > -                        hw->pcm_ops->enable_in(hw, true);
> > +                    if (k->enable_in) {
> > +                        k->enable_in(hw, true);
> >                       }
> >                       audio_reset_timer (s);
> >                   }
> > @@ -932,8 +937,8 @@ static void audio_mixeng_backend_set_active_in(Audi=
oBackend *be, SWVoiceIn *sw,
> >
> >                   if (nb_active =3D=3D 1) {
> >                       hw->enabled =3D false;
> > -                    if (hw->pcm_ops->enable_in) {
> > -                        hw->pcm_ops->enable_in(hw, false);
> > +                    if (k->enable_in) {
> > +                        k->enable_in(hw, false);
> >                       }
> >                   }
> >               }
> > @@ -1040,12 +1045,13 @@ static void audio_capture_mix_and_clear(HWVoice=
Out *hw, size_t rpos,
> >
> >   static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> >       size_t clipped =3D 0;
> >
> >       while (live) {
> >           size_t size =3D live * hw->info.bytes_per_frame;
> >           size_t decr, proc;
> > -        void *buf =3D hw->pcm_ops->get_buffer_out(hw, &size);
> > +        void *buf =3D k->get_buffer_out(hw, &size);
> >
> >           if (size =3D=3D 0) {
> >               break;
> > @@ -1055,8 +1061,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw=
, size_t live)
> >           if (buf) {
> >               audio_pcm_hw_clip_out(hw, buf, decr);
> >           }
> > -        proc =3D hw->pcm_ops->put_buffer_out(hw, buf,
> > -                                           decr * hw->info.bytes_per_f=
rame) /
> > +        proc =3D k->put_buffer_out(hw, buf, decr * hw->info.bytes_per_=
frame) /
> >               hw->info.bytes_per_frame;
> >
> >           live -=3D proc;
> > @@ -1068,8 +1073,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw=
, size_t live)
> >           }
> >       }
> >
> > -    if (hw->pcm_ops->run_buffer_out) {
> > -        hw->pcm_ops->run_buffer_out(hw);
> > +    if (k->run_buffer_out) {
> > +        k->run_buffer_out(hw);
> >       }
> >
> >       return clipped;
> > @@ -1077,6 +1082,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw=
, size_t live)
> >
> >   static void audio_run_out(AudioMixengBackend *s)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(s);
> >       HWVoiceOut *hw =3D NULL;
> >       SWVoiceOut *sw;
> >
> > @@ -1092,8 +1098,8 @@ static void audio_run_out(AudioMixengBackend *s)
> >               if (hw->pending_disable) {
> >                   hw->enabled =3D false;
> >                   hw->pending_disable =3D false;
> > -                if (hw->pcm_ops->enable_out) {
> > -                    hw->pcm_ops->enable_out(hw, false);
> > +                if (k->enable_out) {
> > +                    k->enable_out(hw, false);
> >                   }
> >               }
> >
> > @@ -1102,8 +1108,8 @@ static void audio_run_out(AudioMixengBackend *s)
> >                                   hw_free * sw->info.bytes_per_frame);
> >               }
> >
> > -            if (hw->pcm_ops->run_buffer_out) {
> > -                hw->pcm_ops->run_buffer_out(hw);
> > +            if (k->run_buffer_out) {
> > +                k->run_buffer_out(hw);
> >               }
> >
> >               continue;
> > @@ -1146,8 +1152,8 @@ static void audio_run_out(AudioMixengBackend *s)
> >   #endif
> >               hw->enabled =3D false;
> >               hw->pending_disable =3D false;
> > -            if (hw->pcm_ops->enable_out) {
> > -                hw->pcm_ops->enable_out(hw, false);
> > +            if (k->enable_out) {
> > +                k->enable_out(hw, false);
> >               }
> >               for (sc =3D hw->cap_head.lh_first; sc; sc =3D sc->entries=
.le_next) {
> >                   sc->sw.active =3D false;
> > @@ -1157,8 +1163,8 @@ static void audio_run_out(AudioMixengBackend *s)
> >           }
> >
> >           if (!live) {
> > -            if (hw->pcm_ops->run_buffer_out) {
> > -                hw->pcm_ops->run_buffer_out(hw);
> > +            if (k->run_buffer_out) {
> > +                k->run_buffer_out(hw);
> >               }
> >               continue;
> >           }
> > @@ -1202,16 +1208,17 @@ static void audio_run_out(AudioMixengBackend *s=
)
> >
> >   static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> >       size_t conv =3D 0;
> >
> > -    if (hw->pcm_ops->run_buffer_in) {
> > -        hw->pcm_ops->run_buffer_in(hw);
> > +    if (k->run_buffer_in) {
> > +        k->run_buffer_in(hw);
> >       }
> >
> >       while (samples) {
> >           size_t proc;
> >           size_t size =3D samples * hw->info.bytes_per_frame;
> > -        void *buf =3D hw->pcm_ops->get_buffer_in(hw, &size);
> > +        void *buf =3D k->get_buffer_in(hw, &size);
> >
> >           assert(size % hw->info.bytes_per_frame =3D=3D 0);
> >           if (size =3D=3D 0) {
> > @@ -1222,7 +1229,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, =
size_t samples)
> >
> >           samples -=3D proc;
> >           conv +=3D proc;
> > -        hw->pcm_ops->put_buffer_in(hw, buf, proc * hw->info.bytes_per_=
frame);
> > +        k->put_buffer_in(hw, buf, proc * hw->info.bytes_per_frame);
> >       }
> >
> >       return conv;
> > @@ -1367,6 +1374,8 @@ void audio_run(AudioMixengBackend *s, const char =
*msg)
> >
> >   void audio_generic_run_buffer_in(HWVoiceIn *hw)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> > +
> >       if (unlikely(!hw->buf_emul)) {
> >           hw->size_emul =3D hw->samples * hw->info.bytes_per_frame;
> >           hw->buf_emul =3D g_malloc(hw->size_emul);
> > @@ -1376,8 +1385,7 @@ void audio_generic_run_buffer_in(HWVoiceIn *hw)
> >       while (hw->pending_emul < hw->size_emul) {
> >           size_t read_len =3D MIN(hw->size_emul - hw->pos_emul,
> >                                 hw->size_emul - hw->pending_emul);
> > -        size_t read =3D hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_e=
mul,
> > -                                        read_len);
> > +        size_t read =3D k->read(hw, hw->buf_emul + hw->pos_emul, read_=
len);
> >           hw->pending_emul +=3D read;
> >           hw->pos_emul =3D (hw->pos_emul + read) % hw->size_emul;
> >           if (read < read_len) {
> > @@ -1415,6 +1423,8 @@ size_t audio_generic_buffer_get_free(HWVoiceOut *=
hw)
> >
> >   void audio_generic_run_buffer_out(HWVoiceOut *hw)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> > +
> >       while (hw->pending_emul) {
> >           size_t write_len, written, start;
> >
> > @@ -1423,7 +1433,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
> >
> >           write_len =3D MIN(hw->pending_emul, hw->size_emul - start);
> >
> > -        written =3D hw->pcm_ops->write(hw, hw->buf_emul + start, write=
_len);
> > +        written =3D k->write(hw, hw->buf_emul + start, write_len);
> >           hw->pending_emul -=3D written;
> >
> >           if (written < write_len) {
> > @@ -1458,10 +1468,11 @@ size_t audio_generic_put_buffer_out(HWVoiceOut =
*hw, void *buf, size_t size)
> >
> >   size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> >       size_t total =3D 0;
> >
> > -    if (hw->pcm_ops->buffer_get_free) {
> > -        size_t free =3D hw->pcm_ops->buffer_get_free(hw);
> > +    if (k->buffer_get_free) {
> > +        size_t free =3D k->buffer_get_free(hw);
> >
> >           size =3D MIN(size, free);
> >       }
> > @@ -1469,7 +1480,7 @@ size_t audio_generic_write(HWVoiceOut *hw, void *=
buf, size_t size)
> >       while (total < size) {
> >           size_t dst_size =3D size - total;
> >           size_t copy_size, proc;
> > -        void *dst =3D hw->pcm_ops->get_buffer_out(hw, &dst_size);
> > +        void *dst =3D k->get_buffer_out(hw, &dst_size);
> >
> >           if (dst_size =3D=3D 0) {
> >               break;
> > @@ -1479,7 +1490,7 @@ size_t audio_generic_write(HWVoiceOut *hw, void *=
buf, size_t size)
> >           if (dst) {
> >               memcpy(dst, (char *)buf + total, copy_size);
> >           }
> > -        proc =3D hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
> > +        proc =3D k->put_buffer_out(hw, dst, copy_size);
> >           total +=3D proc;
> >
> >           if (proc =3D=3D 0 || proc < copy_size) {
> > @@ -1492,22 +1503,23 @@ size_t audio_generic_write(HWVoiceOut *hw, void=
 *buf, size_t size)
> >
> >   size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
> >   {
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->=
s);
> >       size_t total =3D 0;
> >
> > -    if (hw->pcm_ops->run_buffer_in) {
> > -        hw->pcm_ops->run_buffer_in(hw);
> > +    if (k->run_buffer_in) {
> > +        k->run_buffer_in(hw);
> >       }
> >
> >       while (total < size) {
> >           size_t src_size =3D size - total;
> > -        void *src =3D hw->pcm_ops->get_buffer_in(hw, &src_size);
> > +        void *src =3D k->get_buffer_in(hw, &src_size);
> >
> >           if (src_size =3D=3D 0) {
> >               break;
> >           }
> >
> >           memcpy((char *)buf + total, src, src_size);
> > -        hw->pcm_ops->put_buffer_in(hw, src, src_size);
> > +        k->put_buffer_in(hw, src, src_size);
> >           total +=3D src_size;
> >       }
> >
> > @@ -1521,13 +1533,13 @@ static bool audio_mixeng_backend_realize(AudioB=
ackend *abe,
> >       AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(be)=
;
> >
> >       be->dev =3D dev;
> > -    if (!k->pcm_ops->get_buffer_in) {
> > -        k->pcm_ops->get_buffer_in =3D audio_generic_get_buffer_in;
> > -        k->pcm_ops->put_buffer_in =3D audio_generic_put_buffer_in;
> > +    if (!k->get_buffer_in) {
> > +        k->get_buffer_in =3D audio_generic_get_buffer_in;
> > +        k->put_buffer_in =3D audio_generic_put_buffer_in;
> >       }
> > -    if (!k->pcm_ops->get_buffer_out) {
> > -        k->pcm_ops->get_buffer_out =3D audio_generic_get_buffer_out;
> > -        k->pcm_ops->put_buffer_out =3D audio_generic_put_buffer_out;
> > +    if (!k->get_buffer_out) {
> > +        k->get_buffer_out =3D audio_generic_get_buffer_out;
> > +        k->put_buffer_out =3D audio_generic_put_buffer_out;
> >       }
> >
> >       audio_init_nb_voices_out(be, k, 1);
> > @@ -1546,18 +1558,19 @@ static void audio_vm_change_state_handler (void=
 *opaque, bool running,
> >                                              RunState state)
> >   {
> >       AudioMixengBackend *s =3D opaque;
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(s);
> >       HWVoiceOut *hwo =3D NULL;
> >       HWVoiceIn *hwi =3D NULL;
> >
> >       while ((hwo =3D audio_pcm_hw_find_any_enabled_out(s, hwo))) {
> > -        if (hwo->pcm_ops->enable_out) {
> > -            hwo->pcm_ops->enable_out(hwo, running);
> > +        if (k->enable_out) {
> > +            k->enable_out(hwo, running);
> >           }
> >       }
> >
> >       while ((hwi =3D audio_pcm_hw_find_any_enabled_in(s, hwi))) {
> > -        if (hwi->pcm_ops->enable_in) {
> > -            hwi->pcm_ops->enable_in(hwi, running);
> > +        if (k->enable_in) {
> > +            k->enable_in(hwi, running);
> >           }
> >       }
> >       audio_reset_timer (s);
> > @@ -1627,16 +1640,17 @@ static void audio_mixeng_backend_init(Object *o=
bj)
> >   static void audio_mixeng_backend_finalize(Object *obj)
> >   {
> >       AudioMixengBackend *s =3D AUDIO_MIXENG_BACKEND(obj);
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(s);
> >       HWVoiceOut *hwo, *hwon;
> >       HWVoiceIn *hwi, *hwin;
> >
> >       QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
> >           SWVoiceCap *sc;
> >
> > -        if (hwo->enabled && hwo->pcm_ops->enable_out) {
> > -            hwo->pcm_ops->enable_out(hwo, false);
> > +        if (hwo->enabled && k->enable_out) {
> > +            k->enable_out(hwo, false);
> >           }
> > -        hwo->pcm_ops->fini_out (hwo);
> > +        k->fini_out(hwo);
> >
> >           for (sc =3D hwo->cap_head.lh_first; sc; sc =3D sc->entries.le=
_next) {
> >               CaptureVoiceOut *cap =3D sc->cap;
> > @@ -1650,10 +1664,10 @@ static void audio_mixeng_backend_finalize(Objec=
t *obj)
> >       }
> >
> >       QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
> > -        if (hwi->enabled && hwi->pcm_ops->enable_in) {
> > -            hwi->pcm_ops->enable_in(hwi, false);
> > +        if (hwi->enabled && k->enable_in) {
> > +            k->enable_in(hwi, false);
> >           }
> > -        hwi->pcm_ops->fini_in (hwi);
> > +        k->fini_in(hwi);
> >           QLIST_REMOVE(hwi, entries);
> >       }
> >
> > @@ -1694,8 +1708,6 @@ static const VMStateDescription vmstate_audio =3D=
 {
> >       }
> >   };
> >
> > -static struct audio_pcm_ops capture_pcm_ops;
> > -
> >   static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> >       AudioBackend *be,
> >       struct audsettings *as,
> > @@ -1736,7 +1748,6 @@ static CaptureVoiceOut *audio_mixeng_backend_add_=
capture(
> >
> >           hw =3D &cap->hw;
> >           hw->s =3D s;
> > -        hw->pcm_ops =3D &capture_pcm_ops;
> >           QLIST_INIT (&hw->sw_head);
> >           QLIST_INIT (&cap->cb_head);
> >
> > @@ -1817,14 +1828,15 @@ static void audio_mixeng_backend_set_volume_out=
(AudioBackend *be, SWVoiceOut *sw
> >   {
> >       if (sw) {
> >           HWVoiceOut *hw =3D sw->hw;
> > +        AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(=
hw->s);
> >
> >           sw->vol.mute =3D vol->mute;
> >           sw->vol.l =3D nominal_volume.l * vol->vol[0] / 255;
> >           sw->vol.r =3D nominal_volume.l * vol->vol[vol->channels > 1 ?=
 1 : 0] /
> >               255;
> >
> > -        if (hw->pcm_ops->volume_out) {
> > -            hw->pcm_ops->volume_out(hw, vol);
> > +        if (k->volume_out) {
> > +            k->volume_out(hw, vol);
> >           }
> >       }
> >   }
> > @@ -1834,14 +1846,15 @@ static void audio_mixeng_backend_set_volume_in(=
AudioBackend *be, SWVoiceIn *sw,
> >   {
> >       if (sw) {
> >           HWVoiceIn *hw =3D sw->hw;
> > +        AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(=
hw->s);
> >
> >           sw->vol.mute =3D vol->mute;
> >           sw->vol.l =3D nominal_volume.l * vol->vol[0] / 255;
> >           sw->vol.r =3D nominal_volume.r * vol->vol[vol->channels > 1 ?=
 1 : 0] /
> >               255;
> >
> > -        if (hw->pcm_ops->volume_in) {
> > -            hw->pcm_ops->volume_in(hw, vol);
> > +        if (k->volume_in) {
> > +            k->volume_in(hw, vol);
> >           }
> >       }
> >   }
> > diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> > index d78d5799952..9d5331b8c47 100644
> > --- a/audio/dbusaudio.c
> > +++ b/audio/dbusaudio.c
> > @@ -691,23 +691,6 @@ dbus_audio_set_server(AudioBackend *s,
> >       return true;
> >   }
> >
> > -static struct audio_pcm_ops dbus_pcm_ops =3D {
> > -    .init_out =3D dbus_init_out,
> > -    .fini_out =3D dbus_fini_out,
> > -    .write    =3D audio_generic_write,
> > -    .get_buffer_out =3D dbus_get_buffer_out,
> > -    .put_buffer_out =3D dbus_put_buffer_out,
> > -    .enable_out =3D dbus_enable_out,
> > -    .volume_out =3D dbus_volume_out,
> > -
> > -    .init_in  =3D dbus_init_in,
> > -    .fini_in  =3D dbus_fini_in,
> > -    .read     =3D dbus_read,
> > -    .run_buffer_in =3D audio_generic_run_buffer_in,
> > -    .enable_in =3D dbus_enable_in,
> > -    .volume_in =3D dbus_volume_in,
> > -};
> > -
> >   static void audio_dbus_class_init(ObjectClass *klass, const void *dat=
a)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -718,11 +701,25 @@ static void audio_dbus_class_init(ObjectClass *kl=
ass, const void *data)
> >       b->realize =3D audio_dbus_realize;
> >       b->set_dbus_server =3D dbus_audio_set_server;
> >       k->name =3D "dbus";
> > -    k->pcm_ops =3D &dbus_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(DBusVoiceOut);
> >       k->voice_size_in =3D sizeof(DBusVoiceIn);
> > +
> > +    k->init_out =3D dbus_init_out;
> > +    k->fini_out =3D dbus_fini_out;
> > +    k->write =3D audio_generic_write;
> > +    k->get_buffer_out =3D dbus_get_buffer_out;
> > +    k->put_buffer_out =3D dbus_put_buffer_out;
> > +    k->enable_out =3D dbus_enable_out;
> > +    k->volume_out =3D dbus_volume_out;
> > +
> > +    k->init_in =3D dbus_init_in;
> > +    k->fini_in =3D dbus_fini_in;
> > +    k->read =3D dbus_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
> > +    k->enable_in =3D dbus_enable_in;
> > +    k->volume_in =3D dbus_volume_in;
> >   }
> >
> >   static const TypeInfo audio_dbus_info =3D {
> > diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> > index b8bc6c8c7be..afd901518cc 100644
> > --- a/audio/dsoundaudio.c
> > +++ b/audio/dsoundaudio.c
> > @@ -667,23 +667,6 @@ audio_dsound_realize(AudioBackend *abe, Audiodev *=
dev, Error **errp)
> >       return true;
> >   }
> >
> > -static struct audio_pcm_ops dsound_pcm_ops =3D {
> > -    .init_out =3D dsound_init_out,
> > -    .fini_out =3D dsound_fini_out,
> > -    .write    =3D audio_generic_write,
> > -    .buffer_get_free =3D dsound_buffer_get_free,
> > -    .get_buffer_out =3D dsound_get_buffer_out,
> > -    .put_buffer_out =3D dsound_put_buffer_out,
> > -    .enable_out =3D dsound_enable_out,
> > -
> > -    .init_in  =3D dsound_init_in,
> > -    .fini_in  =3D dsound_fini_in,
> > -    .read     =3D audio_generic_read,
> > -    .get_buffer_in =3D dsound_get_buffer_in,
> > -    .put_buffer_in =3D dsound_put_buffer_in,
> > -    .enable_in =3D dsound_enable_in,
> > -};
> > -
> >   static void audio_dsound_class_init(ObjectClass *klass, const void *d=
ata)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -693,11 +676,25 @@ static void audio_dsound_class_init(ObjectClass *=
klass, const void *data)
> >
> >       b->realize =3D audio_dsound_realize;
> >       k->name =3D "dsound";
> > -    k->pcm_ops =3D &dsound_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D 1;
> >       k->voice_size_out =3D sizeof(DSoundVoiceOut);
> >       k->voice_size_in =3D sizeof(DSoundVoiceIn);
> > +
> > +    k->init_out =3D dsound_init_out;
> > +    k->fini_out =3D dsound_fini_out;
> > +    k->write =3D audio_generic_write;
>
> Same here too?
>
> > +    k->buffer_get_free =3D dsound_buffer_get_free;
> > +    k->get_buffer_out =3D dsound_get_buffer_out;
> > +    k->put_buffer_out =3D dsound_put_buffer_out;
> > +    k->enable_out =3D dsound_enable_out;
> > +
> > +    k->init_in =3D dsound_init_in;
> > +    k->fini_in =3D dsound_fini_in;
> > +    k->read =3D audio_generic_read;
>
> And here?
>
> > +    k->get_buffer_in =3D dsound_get_buffer_in;
> > +    k->put_buffer_in =3D dsound_put_buffer_in;
> > +    k->enable_in =3D dsound_enable_in;
> >   }
> >
> >   static const TypeInfo audio_dsound_info =3D {
> > diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> > index e69b313afe5..681eb17df55 100644
> > --- a/audio/jackaudio.c
> > +++ b/audio/jackaudio.c
> > @@ -652,21 +652,6 @@ static int qjack_thread_creator(jack_native_thread=
_t *thread,
> >   }
> >   #endif
> >
> > -static struct audio_pcm_ops jack_pcm_ops =3D {
> > -    .init_out       =3D qjack_init_out,
> > -    .fini_out       =3D qjack_fini_out,
> > -    .write          =3D qjack_write,
> > -    .buffer_get_free =3D audio_generic_buffer_get_free,
>
> And here?
>
> > -    .run_buffer_out =3D audio_generic_run_buffer_out,
> > -    .enable_out     =3D qjack_enable_out,
> > -
> > -    .init_in        =3D qjack_init_in,
> > -    .fini_in        =3D qjack_fini_in,
> > -    .read           =3D qjack_read,
> > -    .run_buffer_in  =3D audio_generic_run_buffer_in,
> > -    .enable_in      =3D qjack_enable_in
> > -};
> > -
> >   static void qjack_error(const char *msg)
> >   {
> >       dolog("E: %s\n", msg);
> > @@ -682,11 +667,23 @@ static void audio_jack_class_init(ObjectClass *kl=
ass, const void *data)
> >       AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> >
> >       k->name =3D "jack";
> > -    k->pcm_ops =3D &jack_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(QJackOut);
> >       k->voice_size_in =3D sizeof(QJackIn);
> > +
> > +    k->init_out =3D qjack_init_out;
> > +    k->fini_out =3D qjack_fini_out;
> > +    k->write =3D qjack_write;
> > +    k->buffer_get_free =3D audio_generic_buffer_get_free;
> > +    k->run_buffer_out =3D audio_generic_run_buffer_out;
> > +    k->enable_out =3D qjack_enable_out;
> > +
> > +    k->init_in =3D qjack_init_in;
> > +    k->fini_in =3D qjack_fini_in;
> > +    k->read =3D qjack_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
> > +    k->enable_in =3D qjack_enable_in;
> >   }
> >
> >   static const TypeInfo audio_jack_info =3D {
> > diff --git a/audio/noaudio.c b/audio/noaudio.c
> > index d1fba117133..2f4c3a77457 100644
> > --- a/audio/noaudio.c
> > +++ b/audio/noaudio.c
> > @@ -110,31 +110,28 @@ static void no_enable_in(HWVoiceIn *hw, bool enab=
le)
> >       }
> >   }
> >
> > -static struct audio_pcm_ops no_pcm_ops =3D {
> > -    .init_out =3D no_init_out,
> > -    .fini_out =3D no_fini_out,
> > -    .write    =3D no_write,
> > -    .buffer_get_free =3D audio_generic_buffer_get_free,
> > -    .run_buffer_out =3D audio_generic_run_buffer_out,
> > -    .enable_out =3D no_enable_out,
> > -
> > -    .init_in  =3D no_init_in,
> > -    .fini_in  =3D no_fini_in,
> > -    .read     =3D no_read,
> > -    .run_buffer_in =3D audio_generic_run_buffer_in,
> > -    .enable_in =3D no_enable_in
> > -};
> > -
> >   static void audio_none_class_init(ObjectClass *klass, const void *dat=
a)
> >   {
> >       AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> >
> >       k->name =3D "none";
> > -    k->pcm_ops =3D &no_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(NoVoiceOut);
> >       k->voice_size_in =3D sizeof(NoVoiceIn);
> > +
> > +    k->init_out =3D no_init_out;
> > +    k->fini_out =3D no_fini_out;
> > +    k->write =3D no_write;
> > +    k->buffer_get_free =3D audio_generic_buffer_get_free;
> > +    k->run_buffer_out =3D audio_generic_run_buffer_out;
> > +    k->enable_out =3D no_enable_out;
> > +
> > +    k->init_in =3D no_init_in;
> > +    k->fini_in =3D no_fini_in;
> > +    k->read =3D no_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
> > +    k->enable_in =3D no_enable_in;
> >   }
> >
> >   static const TypeInfo audio_none_info =3D {
> > diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> > index 15fdf54eb3e..95b7963ed0c 100644
> > --- a/audio/ossaudio.c
> > +++ b/audio/ossaudio.c
> > @@ -755,23 +755,6 @@ audio_oss_realize(AudioBackend *abe, Audiodev *dev=
, Error **errp)
> >       return audio_oss_parent_class->realize(abe, dev, errp);
> >   }
> >
> > -static struct audio_pcm_ops oss_pcm_ops =3D {
> > -    .init_out =3D oss_init_out,
> > -    .fini_out =3D oss_fini_out,
> > -    .write    =3D oss_write,
> > -    .buffer_get_free =3D oss_buffer_get_free,
> > -    .run_buffer_out =3D oss_run_buffer_out,
> > -    .get_buffer_out =3D oss_get_buffer_out,
> > -    .put_buffer_out =3D oss_put_buffer_out,
> > -    .enable_out =3D oss_enable_out,
> > -
> > -    .init_in  =3D oss_init_in,
> > -    .fini_in  =3D oss_fini_in,
> > -    .read     =3D oss_read,
> > -    .run_buffer_in =3D audio_generic_run_buffer_in,
> > -    .enable_in =3D oss_enable_in
> > -};
> > -
> >   static void audio_oss_class_init(ObjectClass *klass, const void *data=
)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -781,11 +764,25 @@ static void audio_oss_class_init(ObjectClass *kla=
ss, const void *data)
> >
> >       b->realize =3D audio_oss_realize;
> >       k->name =3D "oss";
> > -    k->pcm_ops =3D &oss_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(OSSVoiceOut);
> >       k->voice_size_in =3D sizeof(OSSVoiceIn);
> > +
> > +    k->init_out =3D oss_init_out;
> > +    k->fini_out =3D oss_fini_out;
> > +    k->write =3D oss_write;
> > +    k->buffer_get_free =3D oss_buffer_get_free;
> > +    k->run_buffer_out =3D oss_run_buffer_out;
> > +    k->get_buffer_out =3D oss_get_buffer_out;
> > +    k->put_buffer_out =3D oss_put_buffer_out;
> > +    k->enable_out =3D oss_enable_out;
> > +
> > +    k->init_in =3D oss_init_in;
> > +    k->fini_in =3D oss_fini_in;
> > +    k->read =3D oss_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
> > +    k->enable_in =3D oss_enable_in;
> >   }
> >
> >   static const TypeInfo audio_oss_info =3D {
> > diff --git a/audio/paaudio.c b/audio/paaudio.c
> > index 056158755c6..e98b4a33b68 100644
> > --- a/audio/paaudio.c
> > +++ b/audio/paaudio.c
> > @@ -913,23 +913,6 @@ static void audio_pa_finalize(Object *obj)
> >       }
> >   }
> >
> > -static struct audio_pcm_ops qpa_pcm_ops =3D {
> > -    .init_out =3D qpa_init_out,
> > -    .fini_out =3D qpa_fini_out,
> > -    .write    =3D qpa_write,
> > -    .buffer_get_free =3D qpa_buffer_get_free,
> > -    .get_buffer_out =3D qpa_get_buffer_out,
> > -    .put_buffer_out =3D qpa_put_buffer_out,
> > -    .volume_out =3D qpa_volume_out,
> > -
> > -    .init_in  =3D qpa_init_in,
> > -    .fini_in  =3D qpa_fini_in,
> > -    .read     =3D qpa_read,
> > -    .get_buffer_in =3D qpa_get_buffer_in,
> > -    .put_buffer_in =3D qpa_put_buffer_in,
> > -    .volume_in =3D qpa_volume_in
> > -};
> > -
> >   static void audio_pa_class_init(ObjectClass *klass, const void *data)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -939,11 +922,25 @@ static void audio_pa_class_init(ObjectClass *klas=
s, const void *data)
> >
> >       b->realize =3D audio_pa_realize;
> >       k->name =3D "pa";
> > -    k->pcm_ops =3D &qpa_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(PAVoiceOut);
> >       k->voice_size_in =3D sizeof(PAVoiceIn);
> > +
> > +    k->init_out =3D qpa_init_out;
> > +    k->fini_out =3D qpa_fini_out;
> > +    k->write =3D qpa_write;
> > +    k->buffer_get_free =3D qpa_buffer_get_free;
> > +    k->get_buffer_out =3D qpa_get_buffer_out;
> > +    k->put_buffer_out =3D qpa_put_buffer_out;
> > +    k->volume_out =3D qpa_volume_out;
> > +
> > +    k->init_in =3D qpa_init_in;
> > +    k->fini_in =3D qpa_fini_in;
> > +    k->read =3D qpa_read;
> > +    k->get_buffer_in =3D qpa_get_buffer_in;
> > +    k->put_buffer_in =3D qpa_put_buffer_in;
> > +    k->volume_in =3D qpa_volume_in;
> >   }
> >
> >   static const TypeInfo audio_pa_info =3D {
> > diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> > index 7cadf7121bb..39b2b8f0a0d 100644
> > --- a/audio/pwaudio.c
> > +++ b/audio/pwaudio.c
> > @@ -822,23 +822,6 @@ audio_pw_finalize(Object *obj)
> >       g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
> >   }
> >
> > -static struct audio_pcm_ops qpw_pcm_ops =3D {
> > -    .init_out =3D qpw_init_out,
> > -    .fini_out =3D qpw_fini_out,
> > -    .write =3D qpw_write,
> > -    .buffer_get_free =3D qpw_buffer_get_free,
> > -    .run_buffer_out =3D audio_generic_run_buffer_out,
> > -    .enable_out =3D qpw_enable_out,
> > -    .volume_out =3D qpw_volume_out,
> > -    .volume_in =3D qpw_volume_in,
> > -
> > -    .init_in =3D qpw_init_in,
> > -    .fini_in =3D qpw_fini_in,
> > -    .read =3D qpw_read,
> > -    .run_buffer_in =3D audio_generic_run_buffer_in,
> > -    .enable_in =3D qpw_enable_in
> > -};
> > -
> >   static void audio_pw_class_init(ObjectClass *klass, const void *data)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -848,11 +831,25 @@ static void audio_pw_class_init(ObjectClass *klas=
s, const void *data)
> >
> >       b->realize =3D audio_pw_realize;
> >       k->name =3D "pipewire";
> > -    k->pcm_ops =3D &qpw_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(PWVoiceOut);
> >       k->voice_size_in =3D sizeof(PWVoiceIn);
> > +
> > +    k->init_out =3D qpw_init_out;
> > +    k->fini_out =3D qpw_fini_out;
> > +    k->write =3D qpw_write;
> > +    k->buffer_get_free =3D qpw_buffer_get_free;
> > +    k->run_buffer_out =3D audio_generic_run_buffer_out;
> > +    k->enable_out =3D qpw_enable_out;
> > +    k->volume_out =3D qpw_volume_out;
> > +
> > +    k->init_in =3D qpw_init_in;
> > +    k->fini_in =3D qpw_fini_in;
> > +    k->read =3D qpw_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
> > +    k->enable_in =3D qpw_enable_in;
> > +    k->volume_in =3D qpw_volume_in;
> >   }
> >
> >   static const TypeInfo audio_pw_info =3D {
> > diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> > index 90867c0c11d..4fb9abd66c3 100644
> > --- a/audio/sdlaudio.c
> > +++ b/audio/sdlaudio.c
> > @@ -468,29 +468,6 @@ static void audio_sdl_finalize(Object *obj)
> >       SDL_QuitSubSystem(SDL_INIT_AUDIO);
> >   }
> >
> > -static struct audio_pcm_ops sdl_pcm_ops =3D {
> > -    .init_out =3D sdl_init_out,
> > -    .fini_out =3D sdl_fini_out,
> > -  /* wrapper for audio_generic_write */
> > -    .write    =3D sdl_write,
> > -  /* wrapper for audio_generic_buffer_get_free */
> > -    .buffer_get_free =3D sdl_buffer_get_free,
> > -  /* wrapper for audio_generic_get_buffer_out */
> > -    .get_buffer_out =3D sdl_get_buffer_out,
> > -  /* wrapper for audio_generic_put_buffer_out */
> > -    .put_buffer_out =3D sdl_put_buffer_out,
> > -    .enable_out =3D sdl_enable_out,
> > -    .init_in =3D sdl_init_in,
> > -    .fini_in =3D sdl_fini_in,
> > -  /* wrapper for audio_generic_read */
> > -    .read =3D sdl_read,
> > -  /* wrapper for audio_generic_get_buffer_in */
> > -    .get_buffer_in =3D sdl_get_buffer_in,
> > -  /* wrapper for audio_generic_put_buffer_in */
> > -    .put_buffer_in =3D sdl_put_buffer_in,
> > -    .enable_in =3D sdl_enable_in,
> > -};
> > -
> >   static void audio_sdl_class_init(ObjectClass *klass, const void *data=
)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -500,11 +477,32 @@ static void audio_sdl_class_init(ObjectClass *kla=
ss, const void *data)
> >
> >       b->realize =3D audio_sdl_realize;
> >       k->name =3D "sdl";
> > -    k->pcm_ops =3D &sdl_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(SDLVoiceOut);
> >       k->voice_size_in =3D sizeof(SDLVoiceIn);
> > +
> > +    k->init_out =3D sdl_init_out;
> > +    k->fini_out =3D sdl_fini_out;
> > +    /* wrapper for audio_generic_write */
> > +    k->write =3D sdl_write;
> > +    /* wrapper for audio_generic_buffer_get_free */
> > +    k->buffer_get_free =3D sdl_buffer_get_free;
> > +    /* wrapper for audio_generic_get_buffer_out */
> > +    k->get_buffer_out =3D sdl_get_buffer_out;
> > +    /* wrapper for audio_generic_put_buffer_out */
> > +    k->put_buffer_out =3D sdl_put_buffer_out;
> > +    k->enable_out =3D sdl_enable_out;
> > +
> > +    k->init_in =3D sdl_init_in;
> > +    k->fini_in =3D sdl_fini_in;
> > +    /* wrapper for audio_generic_read */
> > +    k->read =3D sdl_read;
> > +    /* wrapper for audio_generic_get_buffer_in */
> > +    k->get_buffer_in =3D sdl_get_buffer_in;
> > +    /* wrapper for audio_generic_put_buffer_in */
> > +    k->put_buffer_in =3D sdl_put_buffer_in;
> > +    k->enable_in =3D sdl_enable_in;
> >   }
> >
> >   static const TypeInfo audio_sdl_info =3D {
> > diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> > index 8be0efbc2d6..bc62f670a33 100644
> > --- a/audio/sndioaudio.c
> > +++ b/audio/sndioaudio.c
> > @@ -527,32 +527,30 @@ static void sndio_fini_in(HWVoiceIn *hw)
> >       sndio_fini(self);
> >   }
> >
> > -static struct audio_pcm_ops sndio_pcm_ops =3D {
> > -    .init_out        =3D sndio_init_out,
> > -    .fini_out        =3D sndio_fini_out,
> > -    .enable_out      =3D sndio_enable_out,
> > -    .write           =3D audio_generic_write,
> > -    .buffer_get_free =3D sndio_buffer_get_free,
> > -    .get_buffer_out  =3D sndio_get_buffer_out,
> > -    .put_buffer_out  =3D sndio_put_buffer_out,
> > -    .init_in         =3D sndio_init_in,
> > -    .fini_in         =3D sndio_fini_in,
> > -    .read            =3D audio_generic_read,
> > -    .enable_in       =3D sndio_enable_in,
> > -    .get_buffer_in   =3D sndio_get_buffer_in,
> > -    .put_buffer_in   =3D sndio_put_buffer_in,
> > -};
> > -
> >   static void audio_sndio_class_init(ObjectClass *klass, const void *da=
ta)
> >   {
> >       AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> >
> >       k->name =3D "sndio";
> > -    k->pcm_ops =3D &sndio_pcm_ops;
> >       k->max_voices_out =3D INT_MAX;
> >       k->max_voices_in =3D INT_MAX;
> >       k->voice_size_out =3D sizeof(SndioVoice);
> >       k->voice_size_in =3D sizeof(SndioVoice);
> > +
> > +    k->init_out =3D sndio_init_out;
> > +    k->fini_out =3D sndio_fini_out;
> > +    k->write =3D audio_generic_write;
> > +    k->buffer_get_free =3D sndio_buffer_get_free;
> > +    k->get_buffer_out =3D sndio_get_buffer_out;
> > +    k->put_buffer_out =3D sndio_put_buffer_out;
> > +    k->enable_out =3D sndio_enable_out;
> > +
> > +    k->init_in =3D sndio_init_in;
> > +    k->fini_in =3D sndio_fini_in;
> > +    k->read =3D audio_generic_read;
> > +    k->get_buffer_in =3D sndio_get_buffer_in;
> > +    k->put_buffer_in =3D sndio_put_buffer_in;
> > +    k->enable_in =3D sndio_enable_in;
> >   }
> >
> >   static const TypeInfo audio_sndio_info =3D {
> > diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> > index 4f20f7f73a9..fa1cb04dbf7 100644
> > --- a/audio/spiceaudio.c
> > +++ b/audio/spiceaudio.c
> > @@ -296,29 +296,6 @@ static void line_in_volume(HWVoiceIn *hw, Volume *=
vol)
> >   }
> >   #endif
> >
> > -static struct audio_pcm_ops audio_callbacks =3D {
> > -    .init_out =3D line_out_init,
> > -    .fini_out =3D line_out_fini,
> > -    .write    =3D audio_generic_write,
> > -    .buffer_get_free =3D line_out_get_free,
> > -    .get_buffer_out =3D line_out_get_buffer,
> > -    .put_buffer_out =3D line_out_put_buffer,
> > -    .enable_out =3D line_out_enable,
> > -#if (SPICE_INTERFACE_PLAYBACK_MAJOR >=3D 1) && \
> > -        (SPICE_INTERFACE_PLAYBACK_MINOR >=3D 2)
> > -    .volume_out =3D line_out_volume,
> > -#endif
> > -
> > -    .init_in  =3D line_in_init,
> > -    .fini_in  =3D line_in_fini,
> > -    .read     =3D line_in_read,
> > -    .run_buffer_in =3D audio_generic_run_buffer_in,
> > -    .enable_in =3D line_in_enable,
> > -#if ((SPICE_INTERFACE_RECORD_MAJOR >=3D 2) && (SPICE_INTERFACE_RECORD_=
MINOR >=3D 2))
> > -    .volume_in =3D line_in_volume,
> > -#endif
> > -};
> > -
> >   static void audio_spice_class_init(ObjectClass *klass, const void *da=
ta)
> >   {
> >       AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > @@ -328,11 +305,31 @@ static void audio_spice_class_init(ObjectClass *k=
lass, const void *data)
> >
> >       b->realize =3D spice_audio_realize;
> >       k->name =3D "spice";
> > -    k->pcm_ops =3D &audio_callbacks;
> >       k->max_voices_out =3D 1;
> >       k->max_voices_in =3D 1;
> >       k->voice_size_out =3D sizeof(SpiceVoiceOut);
> >       k->voice_size_in =3D sizeof(SpiceVoiceIn);
> > +
> > +    k->init_out =3D line_out_init;
> > +    k->fini_out =3D line_out_fini;
> > +    k->write =3D audio_generic_write;
> > +    k->buffer_get_free =3D line_out_get_free;
> > +    k->get_buffer_out =3D line_out_get_buffer;
> > +    k->put_buffer_out =3D line_out_put_buffer;
> > +    k->enable_out =3D line_out_enable;
> > +#if (SPICE_INTERFACE_PLAYBACK_MAJOR >=3D 1) && \
> > +        (SPICE_INTERFACE_PLAYBACK_MINOR >=3D 2)
> > +    k->volume_out =3D line_out_volume;
> > +#endif
> > +
> > +    k->init_in =3D line_in_init;
> > +    k->fini_in =3D line_in_fini;
> > +    k->read =3D line_in_read;
> > +    k->run_buffer_in =3D audio_generic_run_buffer_in;
> > +    k->enable_in =3D line_in_enable;
> > +#if ((SPICE_INTERFACE_RECORD_MAJOR >=3D 2) && (SPICE_INTERFACE_RECORD_=
MINOR >=3D 2))
> > +    k->volume_in =3D line_in_volume;
> > +#endif
> >   }
> >
> >   static const TypeInfo audio_spice_info =3D {
> > diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> > index 57a2e686785..090f3f4dc60 100644
> > --- a/audio/wavaudio.c
> > +++ b/audio/wavaudio.c
> > @@ -190,25 +190,22 @@ static void wav_enable_out(HWVoiceOut *hw, bool e=
nable)
> >       }
> >   }
> >
> > -static struct audio_pcm_ops wav_pcm_ops =3D {
> > -    .init_out =3D wav_init_out,
> > -    .fini_out =3D wav_fini_out,
> > -    .write    =3D wav_write_out,
> > -    .buffer_get_free =3D audio_generic_buffer_get_free,
> > -    .run_buffer_out =3D audio_generic_run_buffer_out,
> > -    .enable_out =3D wav_enable_out,
> > -};
> > -
> >   static void audio_wav_class_init(ObjectClass *klass, const void *data=
)
> >   {
> >       AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> >
> >       k->name =3D "wav";
> > -    k->pcm_ops =3D &wav_pcm_ops;
> >       k->max_voices_out =3D 1;
> >       k->max_voices_in =3D 0;
> >       k->voice_size_out =3D sizeof(WAVVoiceOut);
> >       k->voice_size_in =3D 0;
> > +
> > +    k->init_out =3D wav_init_out;
> > +    k->fini_out =3D wav_fini_out;
> > +    k->write =3D wav_write_out;
> > +    k->buffer_get_free =3D audio_generic_buffer_get_free;
> > +    k->run_buffer_out =3D audio_generic_run_buffer_out;
> > +    k->enable_out =3D wav_enable_out;
> >   }
> >
> >   static const TypeInfo audio_wav_info =3D {
> > diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> > index c7602dad223..af614144bd1 100644
> > --- a/audio/coreaudio.m
> > +++ b/audio/coreaudio.m
> > @@ -646,30 +646,27 @@ static void coreaudio_enable_out(HWVoiceOut *hw, =
bool enable)
> >       update_device_playback_state(core);
> >   }
> >
> > -static struct audio_pcm_ops coreaudio_pcm_ops =3D {
> > -    .init_out =3D coreaudio_init_out,
> > -    .fini_out =3D coreaudio_fini_out,
> > -  /* wrapper for audio_generic_write */
> > -    .write    =3D coreaudio_write,
> > -  /* wrapper for audio_generic_buffer_get_free */
> > -    .buffer_get_free =3D coreaudio_buffer_get_free,
> > -  /* wrapper for audio_generic_get_buffer_out */
> > -    .get_buffer_out =3D coreaudio_get_buffer_out,
> > -  /* wrapper for audio_generic_put_buffer_out */
> > -    .put_buffer_out =3D coreaudio_put_buffer_out,
> > -    .enable_out =3D coreaudio_enable_out
> > -};
> > -
> >   static void audio_coreaudio_class_init(ObjectClass *klass, const void=
 *data)
> >   {
> >       AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> >
> >       k->name =3D "coreaudio";
> > -    k->pcm_ops =3D &coreaudio_pcm_ops;
> >       k->max_voices_out =3D 1;
> >       k->max_voices_in =3D 0;
> >       k->voice_size_out =3D sizeof(coreaudioVoiceOut);
> >       k->voice_size_in =3D 0;
> > +
> > +    k->init_out =3D coreaudio_init_out;
> > +    k->fini_out =3D coreaudio_fini_out;
> > +    /* wrapper for audio_generic_write */
> > +    k->write =3D coreaudio_write;
> > +    /* wrapper for audio_generic_buffer_get_free */
> > +    k->buffer_get_free =3D coreaudio_buffer_get_free;
> > +    /* wrapper for audio_generic_get_buffer_out */
> > +    k->get_buffer_out =3D coreaudio_get_buffer_out;
> > +    /* wrapper for audio_generic_put_buffer_out */
> > +    k->put_buffer_out =3D coreaudio_put_buffer_out;
> > +    k->enable_out =3D coreaudio_enable_out;
> >   }
> >
> >   static const TypeInfo audio_coreaudio_info =3D {
>
> Regardless:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>

thanks


