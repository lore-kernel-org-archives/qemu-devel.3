Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE913EDF154
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 10:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrCpS-0007VI-7e; Sat, 14 Feb 2026 05:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vrCpM-0007Ui-JI
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 05:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vrCpJ-0002Hf-Mc
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 05:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771064676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lN6kVJ3U9MAyA8lgXu1UfYM34FNS2hElcM0/mlsTWRM=;
 b=UZ0a8Wc+/qNrtGM/rud2DjdlPvBGaYvf454OfEKzwF6A+xB3FZDjwnRggL7S/UxivZWyuu
 1o56v8OUC9s1TItE1ENmcmEeFmuorwAqtlMujZWUC6tDjUoGL5YPYTzjP7ZbtvYMPSwUc4
 FH01K1dBi0v14zTL6YWFTWCZYO63JpE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Fwm7zo16Nxy58QipAQMLWQ-1; Sat, 14 Feb 2026 05:24:33 -0500
X-MC-Unique: Fwm7zo16Nxy58QipAQMLWQ-1
X-Mimecast-MFC-AGG-ID: Fwm7zo16Nxy58QipAQMLWQ_1771064666
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3562370038dso1588968a91.3
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 02:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771064666; cv=none;
 d=google.com; s=arc-20240605;
 b=bjRPD9Sfpz0RVY5q6sBK4DrqXmXKhW6R9lLi3PofsIpzkQo8+npHAOYwOc+MM2huBk
 8QL5zaeVNAvHc2n8gY1w9EfXYHgCqUKBQ63leUHvHOLuDNtyBgscRx45lOXiTTNeqFuC
 hTKu9v/47YYEL0D5a5eUNDfGDhznEmYOyXX+w1okHhSk2tuW2vYqgH6uteun0kcyUyRi
 DGdXFwbNjkeYjIudWB0NjZ5InUCGhhNFRhjUMsPBh40oz+pDtnCOnQptOiLmDXlhU1kH
 EY9vzK8H9HRt8CkukA9XYcho3CByEcsochWG0+31NeQdWIvPJcM5cbehy74rSl5EPWiC
 fVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lN6kVJ3U9MAyA8lgXu1UfYM34FNS2hElcM0/mlsTWRM=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=Tce9sqGuHVvvjOvnAAHkiTlJUkmZHFsKU/S3gt4OQWtNJv7bfXKwIB0WcGSbalD/Iq
 SxlzIZf6pgllPdwT49C4NAVZ1so44/obMe3bNFQynnA+Hzo9TWZJOxNfhomFzjDC12ig
 f0Fs1wEfbhNTOOUWzkgE3EY0J47Of9PP52CczI6l/1CJjvEQ7voWKmikcT/9LtlOaPDL
 oOwryiNlM9CZCX2ntvPJv5z8g6LVyjMKwX6GGs1tUqpBcB2eVlYICU8koNwI2ggrG0sq
 jPDK7sTRsosTARL949Gv7G4Dwd2qyVn9O6GOa+DYYtvUwru6dO4mr4zdA0Q2TY10y5Ar
 R91g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771064666; x=1771669466; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lN6kVJ3U9MAyA8lgXu1UfYM34FNS2hElcM0/mlsTWRM=;
 b=Skwa99Cw1Fw4byIWAnyGsAbhGPGMKcHJWFSvNkx/Swj1RYkMVToCdb1nvkZsZm5F6q
 fNQ/MMqhJZVoQiE9HN6Kp43bwIGBw1DT/NhxL7TqarJirnuSVqEZ+UEzx7Xon9UmEG93
 7kQ37dZuYt9NVogDa8rpQWaP0vLkFQ5u3O3mH7AUyNUH7DSpO7p1HWCF7YClCsaF13Xn
 g/3edVQDNFcwt2sh9ZpTCTINF496Ra0ppjsLKwVghG+LFpYM4sijWSo5PHDefblzP1C+
 laaxyP9SCD3Cg55c1T0TgfF76L8m23GaVgC738bHOlWtyM7jPeGzc2kQ52JjSszdhDSc
 d9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771064666; x=1771669466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lN6kVJ3U9MAyA8lgXu1UfYM34FNS2hElcM0/mlsTWRM=;
 b=UJimCCshx7XZq7UVm6EEizUad4V5OHRCweqggnRZyqoS7vaBwPIaE1N9p+jCX+gxyj
 Ggb/F+JGzL4JFvbF//HSgiVHel53tbqVvhZTKTLqijKGZDRruYRiz+wrhf6oNmf6W8qK
 +jqSGxE0ZsHfNfzZz5LSMq+ZbJZXyYkZKvaZQlb21tGPuZxwWItmvcKjRk8b2coCplkX
 ixu6/vRA6nUCZ3OV0Sw6R9anIf7b/KkNm+C7rE7pp5OgzyUQ8TWGU30x57xc8slvRLly
 dLbzgZkvif+c1Tw8z8ylmrt/NWTQBpXzUivaZAK4lMZc7MWaay8rMPKJ7cIkhJeMMf1a
 Vnxg==
X-Gm-Message-State: AOJu0YxAxwt+BFT4j2Kww2iRYF/gYyQ1FMyoNcp2uR+odETLLGnAzpIX
 NJx69Md7GrsOvu1O1OKznjnMwQPSAchnx1ThpwahDvWo99foBWjuBZ7LmXsPSuiQVPQK8gKGuUi
 7Sar7S51hEn0ZaHIjqZJHtxv006BFEMXLwqW7jcrNjaqqnQ+NK6/g1tymO8N3rdSw034xoklO8b
 RKnP8uJzQ1Kg4OMP6eRHVfETGpklqyDdM=
X-Gm-Gg: AZuq6aKlDBOm0Lvz7rl5ULhdBZcr9SlzXsVbw4g/qzeVZyE5VtmeGe44dtAP1kG/T1g
 CA9yljChFy7Gg3lWpUY6IlywH8AqBMVCYEIx/p8i2AXptasWfApbqKgIp2VLNzVw4spqHbeQmXG
 dkg70eIBfmZR1lmKSNWaf35WG+ZmuWbTc83hQLdXE54RG6Pr+2QK8EdtrB273k+EufGLKNf14ze
 PQpFSAhg/EUgaglFewsuLvkbio8dvKJzv8+8oU=
X-Received: by 2002:a17:90b:3fcb:b0:356:1edc:b73 with SMTP id
 98e67ed59e1d1-356aad701d5mr4468579a91.24.1771064666012; 
 Sat, 14 Feb 2026 02:24:26 -0800 (PST)
X-Received: by 2002:a17:90b:3fcb:b0:356:1edc:b73 with SMTP id
 98e67ed59e1d1-356aad701d5mr4468567a91.24.1771064665616; Sat, 14 Feb 2026
 02:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
 <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
In-Reply-To: <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 14 Feb 2026 14:24:14 +0400
X-Gm-Features: AZwV_Qih1hh8WY6MuK66Ro0KijSA1HwiG8bP6jw0h3Vqul41KFVm5GwrOePS1ew
Message-ID: <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
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

On Fri, Feb 13, 2026 at 4:50=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Use more correct GTimer, specific for each backend, with a trace event.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio_int.h       |  1 +
> >   audio/audio-mixeng-be.c | 25 +++++++++----------------
> >   audio/trace-events      |  1 +
> >   3 files changed, 11 insertions(+), 16 deletions(-)
> >
> > diff --git a/audio/audio_int.h b/audio/audio_int.h
> > index dd5f2220d75..e0ed6af67ed 100644
> > --- a/audio/audio_int.h
> > +++ b/audio/audio_int.h
> > @@ -224,6 +224,7 @@ struct AudioMixengBackend {
> >       Audiodev *dev;
> >
> >       QEMUTimer *ts;
> > +    GTimer *run_timer;
> >       QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
> >       QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
> >       QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
> > diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> > index 343f6ec181e..1b2c1fafa87 100644
> > --- a/audio/audio-mixeng-be.c
> > +++ b/audio/audio-mixeng-be.c
> > @@ -24,13 +24,13 @@
> >   #include "system/replay.h"
> >   #include "system/runstate.h"
> >   #include "trace.h"
> > +#include "trace/control.h"
> >
> >   #define AUDIO_CAP "audio"
> >   #include "audio_int.h"
> >
> >   /* #define DEBUG_OUT */
> >   /* #define DEBUG_CAPTURE */
> > -/* #define DEBUG_POLL */
> >
> >   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
> >
> > @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const cha=
r *msg)
> >       audio_run_in(s);
> >       audio_run_capture(s);
> >
> > -#ifdef DEBUG_POLL
> > -    {
> > -        static double prevtime;
> > -        double currtime;
> > -        struct timeval tv;
> > -
> > -        if (gettimeofday (&tv, NULL)) {
> > -            perror ("audio_run: gettimeofday");
> > -            return;
> > -        }
> > -
> > -        currtime =3D tv.tv_sec + tv.tv_usec * 1e-6;
> > -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime=
);
> > -        prevtime =3D currtime;
> > +    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
> > +        /* Convert seconds to microseconds for trace event */
> > +        int64_t elapsed_us =3D g_timer_elapsed(s->run_timer, NULL) * 1=
000000;
>
> Not being familiar with g_timer_elapsed() I had a look at the glib docs,
> and it seems that g_timer_elapsed() returns a gdouble as opposed to an
> int64_t?

yes, as seconds. So it is multiplied by 1000000 to get back usec, as before

>
> > +        trace_audio_run_poll(msg, elapsed_us);
> > +        g_timer_start(s->run_timer);
> >       }
> > -#endif
> >   }
> >
> >   void audio_generic_run_buffer_in(HWVoiceIn *hw)
> > @@ -1545,6 +1535,7 @@ static void audio_mixeng_backend_init(Object *obj=
)
> >       QLIST_INIT(&s->hw_head_in);
> >       QLIST_INIT(&s->cap_head);
> >       s->ts =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
> > +    s->run_timer =3D g_timer_new();
> >
> >       s->vmse =3D qemu_add_vm_change_state_handler(audio_vm_change_stat=
e_handler, s);
> >       assert(s->vmse !=3D NULL);
> > @@ -1596,6 +1587,8 @@ static void audio_mixeng_backend_finalize(Object =
*obj)
> >           s->ts =3D NULL;
> >       }
> >
> > +    g_clear_pointer(&s->run_timer, g_timer_destroy);
> > +
> >       if (s->vmse) {
> >           qemu_del_vm_change_state_handler(s->vmse);
> >           s->vmse =3D NULL;
> > diff --git a/audio/trace-events b/audio/trace-events
> > index 4749c54fc04..d66a712e871 100644
> > --- a/audio/trace-events
> > +++ b/audio/trace-events
> > @@ -61,6 +61,7 @@ audio_timer_delayed(int interval) "interval %d ms"
> >
> >   # audio-mixeng-be.c
> >   audio_get_avail(const char *name, size_t live, uint32_t frontend_fram=
es) "%s: get_avail live %zu frontend frames %u"
> > +audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since las=
t %s: %" PRId64 " us"
> >
> >   # audio_template.h
> >   audio_open_out(const char *name, int freq, int nchannels, int fmt) "o=
pen %s, freq %d, nchannels %d, fmt %d"
>
>
> ATB,
>
> Mark.
>


