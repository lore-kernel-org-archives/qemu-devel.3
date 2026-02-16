Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75BDE7BD86
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvZI-0002D1-Gi; Mon, 16 Feb 2026 05:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vrvZE-0002Bu-JP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:11:01 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vrvZC-0002io-UM
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:11:00 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-506aa68065eso25547021cf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 02:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771236658; cv=none;
 d=google.com; s=arc-20240605;
 b=dV/XRNatNoyJ+P0MWHjYCKeonHQnGR7TVVrEe6Ir+q0verZJ/K/ndSBIIw2OU468lS
 4gEPBE0ZXpwibqLq4kvHV73avv98gpIwRgTmW+j46qXkInVnQ21pX40ChDTjLxuEL3kY
 8Jk3Xs9sukMgpCyKK24UaOJTTbpKGwKTtLVWTkSocA2i0vR3a2iwD03Ejq1V2oCi1qFh
 2A3z5TSPkuW0VJsngggFBRtfN0lzF7IOMIMTs4gKgf/X+vNdklF5PxwIHLacoo9BY5nb
 vEQU0hDswOHSAXYaWwsltG8y58KF8LzGhZmrZfP3nyAnN2hSsCxFV8XqgqFiTRs1jmtM
 VczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pos3m4CUAqdw7LlYIAp8p0DJFDuwxAtAWoiHvzAfsyw=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=VfzP8y5FUUg9KTj9EExAf3Yb3VT23+QMeAyNP0KgYMv4/z7V42WSfxUsBjB/9mfDV1
 vAFSbfw2U124hbjSXIWMfJP9rmm+Hy8yPqo1vwLDoUloBM6RbS4TVMd4dvqX5DVgEB/O
 frF6z9hlsTbPkKjqBmFLoTixAVuXHxYpEOb0ctCu3hYJe9A49FsNCBD7FLTkZCn9GaIp
 QSFBZUIRzyMZjnfeNH9Bf2+owL19Uonjq3IQBlD0mQw741gccnt58YSBdxyrF/wJ8Lbi
 G/cSf9WAUZOg366COGjn/IDaye9VzswsnVped12UJEEsuAGOhqUnzd1dAlyteiJk7DGq
 ZhqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771236658; x=1771841458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pos3m4CUAqdw7LlYIAp8p0DJFDuwxAtAWoiHvzAfsyw=;
 b=gnMNAMYKiDRdPyjX8QGL9HeceK9POPXLpyUWOq/7KmrcC4w3t8ku+ob3z7Dsu1YcKb
 +mENwJ1796HeoGDwFupXV0iAabrfTZvxCLk9R7H7awE0Nub/9DDzqHRixgUs5hbS0rkO
 +z9kHnuwLGwwvpXywn+FXZjrEqDrETf9kQa/DQeJ7enjrK8xyM4hNJcAim3MF4fP+qMO
 QSyVQ8Uz7j4XZdaRxssflvioys7IxtZqQVtnGdLIhsgROAJtzxqAfijZ2UzYUbKGrwep
 /wBVs0xvFJR46P3S8HPjpji+MLjqbQ/WKilfyNmUvi8LLK2TotcNqyBd0VKYDok+eyT9
 wT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771236658; x=1771841458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pos3m4CUAqdw7LlYIAp8p0DJFDuwxAtAWoiHvzAfsyw=;
 b=AvOZ8XGKHVgjq4syWmHi6xWzIJktGo3XE/hPtWNWGXFiXgVi+2rauodPLICy/zUin4
 aAWHVKlnoB0I1VOXWFVgLytPrKAoalJ+kSzyLW8VmUiR7khB3Oo4hoGQxDRnrnOaHPto
 i/NUMi0gJgEO/soFfXWc5EfaSnR5PjjE7yZ3AUqZVHlN6NNdonakFktbvWryZ15u+J4m
 r0y+bZn+WxzJmG7u1i32/ZOKtcjfEZbIeJEx0AmVbo3Zo+gR8uO3Eg8OSbsxkHGMQnBd
 89MJPOuyIwLgpseuTivR4KeDKIclsiRckRtGCUf/FPOoM/U82uP6NpRSQIm/mEz69k1g
 DOMQ==
X-Gm-Message-State: AOJu0YzepSf7Tq1WcnwUlzZ87wvLym6W9rX9pzqmss4tGv3yPCf5Jk1u
 42a34fQ8dnqj6+uqyB2cYPmH/deY5ocvmPapT8mVif98xBbfLnaxzhViXm0z/puKXDDWn1IeoH5
 HF3bHXtPHptAIKTOyFqs5DX6LoRIZUJIz+dXA
X-Gm-Gg: AZuq6aIqajXAGZZz8ug3etFlrsBLhkKlCbqEWbgSIUFOGEuSOKPklskLjwngMhOaZSc
 GReD3FDe7LW/Lfc65kRBStiN+bDtbBFNKOxAIu5MXoWOMlh/9eqs1sw1FG/DJMF8InIimyc64+k
 +kHr4pvrm5CmSNJQt9pz9BhuvIlarbTW9+m4i0pkhBwA3m5HEwtiWoVgRlFihBbVdb7j7WXjPF/
 Vd5I74/QedCykSffbbdCJY06O3mjP79y6XiaDCUxLYlL7kS348lEq8tHAU+Pya9zyFYFRRpCy66
 SA+ubqdA3dyyDDqJBs1wxln+elL3lfLdMHycpR5k
X-Received: by 2002:ac8:7d4a:0:b0:506:8738:651d with SMTP id
 d75a77b69052e-506a8364795mr127563821cf.62.1771236657694; Mon, 16 Feb 2026
 02:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
 <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
 <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
 <1de4cd68-b623-440a-b88d-e91e5a739979@nutanix.com>
In-Reply-To: <1de4cd68-b623-440a-b88d-e91e5a739979@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Feb 2026 11:10:46 +0100
X-Gm-Features: AaiRm51ss5EAZlPPnoUjIz-nONyeiRiMscSHt8GyWlRdzZtaW_K1SV0BHCu67z4
Message-ID: <CAJ+F1CKxHjovOPWu2GmyRL9n3F8cyE+Gcx1UBUqT6aJfsOrd5Q@mail.gmail.com>
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 16, 2026 at 10:34=E2=80=AFAM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 14/02/2026 10:24, Marc-Andr=C3=A9 Lureau wrote:
>
> > Hi
> >
> > On Fri, Feb 13, 2026 at 4:50=E2=80=AFPM Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >>
> >> On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:
> >>
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Use more correct GTimer, specific for each backend, with a trace even=
t.
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    audio/audio_int.h       |  1 +
> >>>    audio/audio-mixeng-be.c | 25 +++++++++----------------
> >>>    audio/trace-events      |  1 +
> >>>    3 files changed, 11 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/audio/audio_int.h b/audio/audio_int.h
> >>> index dd5f2220d75..e0ed6af67ed 100644
> >>> --- a/audio/audio_int.h
> >>> +++ b/audio/audio_int.h
> >>> @@ -224,6 +224,7 @@ struct AudioMixengBackend {
> >>>        Audiodev *dev;
> >>>
> >>>        QEMUTimer *ts;
> >>> +    GTimer *run_timer;
> >>>        QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
> >>>        QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
> >>>        QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
> >>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> >>> index 343f6ec181e..1b2c1fafa87 100644
> >>> --- a/audio/audio-mixeng-be.c
> >>> +++ b/audio/audio-mixeng-be.c
> >>> @@ -24,13 +24,13 @@
> >>>    #include "system/replay.h"
> >>>    #include "system/runstate.h"
> >>>    #include "trace.h"
> >>> +#include "trace/control.h"
> >>>
> >>>    #define AUDIO_CAP "audio"
> >>>    #include "audio_int.h"
> >>>
> >>>    /* #define DEBUG_OUT */
> >>>    /* #define DEBUG_CAPTURE */
> >>> -/* #define DEBUG_POLL */
> >>>
> >>>    #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
> >>>
> >>> @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const c=
har *msg)
> >>>        audio_run_in(s);
> >>>        audio_run_capture(s);
> >>>
> >>> -#ifdef DEBUG_POLL
> >>> -    {
> >>> -        static double prevtime;
> >>> -        double currtime;
> >>> -        struct timeval tv;
> >>> -
> >>> -        if (gettimeofday (&tv, NULL)) {
> >>> -            perror ("audio_run: gettimeofday");
> >>> -            return;
> >>> -        }
> >>> -
> >>> -        currtime =3D tv.tv_sec + tv.tv_usec * 1e-6;
> >>> -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevti=
me);
> >>> -        prevtime =3D currtime;
> >>> +    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
> >>> +        /* Convert seconds to microseconds for trace event */
> >>> +        int64_t elapsed_us =3D g_timer_elapsed(s->run_timer, NULL) *=
 1000000;
> >>
> >> Not being familiar with g_timer_elapsed() I had a look at the glib doc=
s,
> >> and it seems that g_timer_elapsed() returns a gdouble as opposed to an
> >> int64_t?
> >
> > yes, as seconds. So it is multiplied by 1000000 to get back usec, as be=
fore
>
> Sorry I was probably a little bit vague here: the part I was unsure
> about was what was happening with the conversion from gdouble to int64_t
> without an explicit cast? I was expecting the compiler to complain.

It doesnt complain, the multiply is done in double and the decimal
part is dropped when assigning to int.

thanks

>
> >>
> >>> +        trace_audio_run_poll(msg, elapsed_us);
> >>> +        g_timer_start(s->run_timer);
> >>>        }
> >>> -#endif
> >>>    }
> >>>
> >>>    void audio_generic_run_buffer_in(HWVoiceIn *hw)
> >>> @@ -1545,6 +1535,7 @@ static void audio_mixeng_backend_init(Object *o=
bj)
> >>>        QLIST_INIT(&s->hw_head_in);
> >>>        QLIST_INIT(&s->cap_head);
> >>>        s->ts =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
> >>> +    s->run_timer =3D g_timer_new();
> >>>
> >>>        s->vmse =3D qemu_add_vm_change_state_handler(audio_vm_change_s=
tate_handler, s);
> >>>        assert(s->vmse !=3D NULL);
> >>> @@ -1596,6 +1587,8 @@ static void audio_mixeng_backend_finalize(Objec=
t *obj)
> >>>            s->ts =3D NULL;
> >>>        }
> >>>
> >>> +    g_clear_pointer(&s->run_timer, g_timer_destroy);
> >>> +
> >>>        if (s->vmse) {
> >>>            qemu_del_vm_change_state_handler(s->vmse);
> >>>            s->vmse =3D NULL;
> >>> diff --git a/audio/trace-events b/audio/trace-events
> >>> index 4749c54fc04..d66a712e871 100644
> >>> --- a/audio/trace-events
> >>> +++ b/audio/trace-events
> >>> @@ -61,6 +61,7 @@ audio_timer_delayed(int interval) "interval %d ms"
> >>>
> >>>    # audio-mixeng-be.c
> >>>    audio_get_avail(const char *name, size_t live, uint32_t frontend_f=
rames) "%s: get_avail live %zu frontend frames %u"
> >>> +audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since l=
ast %s: %" PRId64 " us"
> >>>
> >>>    # audio_template.h
> >>>    audio_open_out(const char *name, int freq, int nchannels, int fmt)=
 "open %s, freq %d, nchannels %d, fmt %d"
>
>
> ATB,
>
> Mark.
>
>


--=20
Marc-Andr=C3=A9 Lureau

