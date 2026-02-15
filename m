Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90C0EF5871
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 10:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrZpn-0004EK-Fi; Sun, 15 Feb 2026 05:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vrZpm-0004EA-5T
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 05:58:38 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vrZpk-0001MV-HP
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 05:58:37 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-5069df1dea8so18771901cf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 02:58:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771153115; cv=none;
 d=google.com; s=arc-20240605;
 b=ZDEQauNVI5rDbTsIk+XLKTHSaGiSM64nt3necfSBftZVrDaaI2oUCQrIbrAsM5iO7b
 CNbXOUsdLMSyMnTBv3d0PrV5SHImuDMNJ3tiVb9LnTvDtz/I3nIDWC8YVEZ6I047ed11
 cLqZJpTqp0IeCMGdETE4f3TlSwS7G2evvMU5zAuU3U6J9K/fgFnJ8m/NPHm99+s9jCYk
 Dd24hC01Oc+7dET6qMhbe9YpCWmPuwY2GVdwm1RoLcQiUumSZn3oFfDcgcUNRDPJcqIw
 T9/mwIjbQcZQ3w4xRao6DbOaTRJIvzWdar9gDLWoC8rWVs4bnsNltF7XJuoTlLcBAKe4
 tF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pv71UurbeNFxWe4YeODf+fV6Uj1qTcbKDaBXbVI55l4=;
 fh=xn47K8435XqPi1YrShxqxiwYzpUMmRaMowMWkinyv9s=;
 b=PHvTRS+AQCsEQvwDEjrplyGs+sl2xV1G43cpoXA5+HKunw9Rp1N197zG/mck8brKWI
 169l4kCatxnny/CiXfVmpRorweLDvBl3QgveOpBX0sCk8kmJUnZFa5Gj7YtdypqQ2P12
 Yi/H3bUa19wgCwQ80sqI+rmYrfzz1zxGUT4r+aQpZAU6T8OU8kKQHXcqffj25kj8Qxk+
 EulpvmnzW0gBd/6gQ7wr+cPgFK/rSAj+2yhGIV2KO6+L8zSULkT9Vyuw4sO/b+dkMESh
 Zks1iSRSXQMMT63NIS9bUOxUNZ1QWQzzKQ+lEidOusUGy2zQE+w4NhuFO5afYSZd1N6e
 ultA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771153115; x=1771757915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pv71UurbeNFxWe4YeODf+fV6Uj1qTcbKDaBXbVI55l4=;
 b=bZhW0uBcKvEMilDOb/Ev4XS4eB3Xwyo/1XtAVL15aY3gi9ZXP/ltuND7PNqLI6L7JQ
 ZJSveKtxxzLwLcOnxjjFvc60GUrhz56Ii3G61eQOQj7Z+FeHsIrnmtr27+Rcs8LGhYSZ
 KKhVq6UEVUy8hrQrJSlnUF77QWrgOralLMAEr3IJx/kGpICmaBLtWxACi1oVgjVvYpWA
 4u5JrLE//WN5zcCwGR+24ZkkhJPyWZbJfuhIwLwVo80DoDxsFx0OJEyXrNTZPe1SNg2n
 WBrTXTm80U0BdS2wFebyZku5pNE1W0GNghBA5ehNFheGJObn0QlsEQ8BRvUKp/HyZAQz
 BkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771153115; x=1771757915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pv71UurbeNFxWe4YeODf+fV6Uj1qTcbKDaBXbVI55l4=;
 b=QLNEE4ShUH2p3OsbyH2guaajhUa3Twa5mVwNnXanAVearxcS6nM3pejOYblq9gHZmy
 CZKk5C0Dq/BD+2E9iN/S79yyNsSCXHI0MvOgokAkQ/mNgF95ikPFcE1O8NTrxZ0j72Gc
 n8Ik9Jc4paKNLC98WZel+s++bDaVKnHrh6VOi3/CBajhrj3UbVy1Khbltba6awhWv707
 Zv6b/RVDqpmAYhnKj9T5sbsjggtNJaOBvFB7XnBdim2U6IGFU4b8lRRKs8eo3LQKkYiT
 0IQAynfQa2DTUH8RFZVfnX5vMJwWoE7XbsetLP//JCCyRy30cN1QzBIcsNPNAusn5WoZ
 CYRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV64qGCR3AN5ktwlENzXXQbvntNdRC+4YY6FcwBGt2PYtMxUg1c0rPKBDBR1Y+RCvXaH64kKyIOhAcP@nongnu.org
X-Gm-Message-State: AOJu0Yxm5nG8QuVvxcOOI0YLHJFayBK9n0QcEW8soWrgzrSNjiHym6OC
 H80f5c5/C8B0WXu0JP/QGac0KKuuuBR+nRKgyPN05jVpKdMiiwdk0+lL4yBfmb9kkesPNqmLX7i
 Mf541dJBFyD68977zy9+wrR9Lse51pQk=
X-Gm-Gg: AZuq6aJeOIk8ZpRzYrUwEdmq7yI3YRYzHlw3DQoQeBINGYUNsc4tDPussfx08Oz62rh
 1mAjqC+R9f5Xcy1UYn4iK3TlMl49DMlSTYsJ8jQ0t9vCWheSQHxBKlz1KB/Bve9aTfbE3Al9D6e
 2mIKcuQzpmGgM0WJSBG/xCwGWxlO2ZjYmebt+doG+6ymVyHvN2kD61viALdBnKL+r4DLxM1nMUz
 cXh/1fTZC/DZmey2yuYM4NVBONQP6Bs3FNCj62qE5v8sAhFVjYRajfQumHxeesvjB8+Yl0rFSyM
 ui4Agv8jUWoLh/QK0lmFYJ0xNvYZNneKWHQd4GzYl1wVTt49U/I=
X-Received: by 2002:a05:622a:138e:b0:4ff:b2bf:ac05 with SMTP id
 d75a77b69052e-506a834b74cmr100511061cf.55.1771153115052; Sun, 15 Feb 2026
 02:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
 <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
 <CAMxuvay8QBghas9-vmf_2mqL2aDj9byFOmK+G1G1562E5KLvKQ@mail.gmail.com>
 <9647b133-f824-74ea-f1c4-3691ee99222f@eik.bme.hu>
In-Reply-To: <9647b133-f824-74ea-f1c4-3691ee99222f@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 15 Feb 2026 14:58:23 +0400
X-Gm-Features: AZwV_QhofacxogHBzv2G3JwLWLr5OL7N3zg9C7UvFtsv9llPUs7Q3mpFUr4_CKM
Message-ID: <CAJ+F1CLRjGe5=TU8rXhCtzskyH4Q8YTdZoV4oZp9SqhOCOdXNA@mail.gmail.com>
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

Hi

On Sat, Feb 14, 2026 at 1:13=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Sat, 14 Feb 2026, Marc-Andr=C3=A9 Lureau wrote:
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
> >>>   audio/audio_int.h       |  1 +
> >>>   audio/audio-mixeng-be.c | 25 +++++++++----------------
> >>>   audio/trace-events      |  1 +
> >>>   3 files changed, 11 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/audio/audio_int.h b/audio/audio_int.h
> >>> index dd5f2220d75..e0ed6af67ed 100644
> >>> --- a/audio/audio_int.h
> >>> +++ b/audio/audio_int.h
> >>> @@ -224,6 +224,7 @@ struct AudioMixengBackend {
> >>>       Audiodev *dev;
> >>>
> >>>       QEMUTimer *ts;
> >>> +    GTimer *run_timer;
> >>>       QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
> >>>       QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
> >>>       QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
> >>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> >>> index 343f6ec181e..1b2c1fafa87 100644
> >>> --- a/audio/audio-mixeng-be.c
> >>> +++ b/audio/audio-mixeng-be.c
> >>> @@ -24,13 +24,13 @@
> >>>   #include "system/replay.h"
> >>>   #include "system/runstate.h"
> >>>   #include "trace.h"
> >>> +#include "trace/control.h"
> >>>
> >>>   #define AUDIO_CAP "audio"
> >>>   #include "audio_int.h"
> >>>
> >>>   /* #define DEBUG_OUT */
> >>>   /* #define DEBUG_CAPTURE */
> >>> -/* #define DEBUG_POLL */
> >>>
> >>>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
> >>>
> >>> @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const c=
har *msg)
> >>>       audio_run_in(s);
> >>>       audio_run_capture(s);
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
> There's #define NANOSECONDS_PER_SECOND 1000000000LL in qemu/timer.h. Do w=
e
> need a MICROSECONDS_PER_SECOND constant there (or defined here) to make i=
t
> more obvious?

That shouldn't be controversial, added

thanks


--=20
Marc-Andr=C3=A9 Lureau

