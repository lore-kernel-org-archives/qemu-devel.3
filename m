Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E98E9D3EC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vne9n-0002nJ-4w; Wed, 04 Feb 2026 09:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vne9m-0002nB-3i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vne9k-0001KP-88
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770216418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlMRIaJx+KVtZ0Su30azIvUxOzLVOa6xZD39SNV66wE=;
 b=JAX0Gf4FMbxOTWxtzFu2zHso/ifzlEDG1DAh0JNSsYxg3upOxpUY8YREuJDCrdzjCJGsy0
 k1J4y4mXA+/gdtzbSqMghyQVtMOUiK2gktpPhaaOziNMVSO6nKP9XLo4941So4izOAydoX
 lBTHED9IujOa5V4v0m3XLBmILbuRlYo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-5WMSkwZ5OLOmzviHziXnuQ-1; Wed, 04 Feb 2026 09:46:57 -0500
X-MC-Unique: 5WMSkwZ5OLOmzviHziXnuQ-1
X-Mimecast-MFC-AGG-ID: 5WMSkwZ5OLOmzviHziXnuQ_1770216416
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a13cd9a784so60969075ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216416; cv=none;
 d=google.com; s=arc-20240605;
 b=doTU1c11ubpSieZ7G54QZ3YnUj/8jwUZSlSEjM0tGSyk7qmjb1hvheU5jUi7Qm/44e
 up6ob4ezC64k3A8gGIAeIFlwe1hZW/AJlpyVEXQgdK1UJCo4MrN+YZZCxD43sqSJKw1e
 w/0Yhz2iKfWs/Ce8N/n66kExt2KHOzycZw/7BNSba84BUWdiPew3rmeKmlQlmjJ8wgAH
 YaBzAnxB+j+3sJLKPAqUwzG9ZqrgRXV9w4RatyCln89IUZLTgEOdTh95fzAnPK87/MmP
 vUCM1vos8jUsGJ4EduPrtS3pwWjmT+HRZIEptbuOSQa8Vezj/mThl4lSun2WUm1UaVAw
 gYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hlMRIaJx+KVtZ0Su30azIvUxOzLVOa6xZD39SNV66wE=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=gqhPAN+sYSHKCIjJyHzDFbn3frLrgoiivek05BqgrFsffGgoi1nYjQDFWAVNgv21/i
 0kFR/FG1qkE17HDfmmtn5uJjDFkeyy9WNJu9F2NlUZ3ykAAFCferWZeXwyDOAMjYct6Y
 df+2DQnw+/f9PiRur4uWanhrstmfvX4EEXeY64ZCMvc7pPW7dAekxuZUzzJSsa37O/o7
 SNjQEJEKQ58sVLd/e59EgrB+FG0yX3u3S1GZtoHoqtrgYL5eaN1U5MRT5WhacuhJCpOg
 5rhV8LG/QTmiZiO964kH+XfuxCFHCOOxWQu4f/HKZNqDQDRieBu3Hs4ElAxd6ImPBew3
 19YQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770216416; x=1770821216; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlMRIaJx+KVtZ0Su30azIvUxOzLVOa6xZD39SNV66wE=;
 b=IIiwh8mpB9YdBwv17cvDtcaRAub+iCftlbI5l7O8djsNiNQs8wBQKwRgXqPHc/E9Ap
 0zJkxF8Ywf/BX47Uk0VF9Od2stG8MRRV4YgkjB9bU1Dyot5wPnRcp41d8F1ouH2UpRr/
 VGA3iCG6CXegs80u+sHO0ydTOhOLBqEPWJBzHt+8IxXzyzsqhVX7myI9hd0gjzsd7ebw
 RriFYtoOob/vpJsX4OmiVEI6GE64jc4xk71j2cIXqy/FNW3pU8MAOn/fsTFz8yzeglY5
 dBhT7OBx7Zf5WiCvn12xNTQZLVur7g53EYVgEjKMsODqpaok2RIsOu+Dfbn/Lbs6cGPP
 RWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770216416; x=1770821216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlMRIaJx+KVtZ0Su30azIvUxOzLVOa6xZD39SNV66wE=;
 b=g01ZRVfCndzHL9zHJ04lvL17B+P+UQdoFoeyEbL7wMh8HGVQ5SiWgEjjQs6U3Lnr4w
 OKvX5e+GYJBcn2iAY/3FtgNoU8SwoIPsrQqQwpgHpOw3wZwZ71alDB+7301NaoFLzuyw
 V18CluE751HJQtZemHtuvzM5X+VUTg/SV53T9pF5nw53IDxIUuJkPb6ksS409qo9ZJgq
 AGly1rk3//ryt1pEy/BFpcrsHukiS+2Ne+1r+f9lUsbZMmSBIpPUOXTRzEZqf1zVvRqB
 WjQ7PynCxphTP0A+GCToDQlDpTNdDtHaUGM5cXxNH8fzc12yePqju7gdhhP42UrxOLcd
 trsg==
X-Gm-Message-State: AOJu0Yw0PVrn/+Dk2+2afPdh22HEWWJvRLF/5Q/FdUFSATJCSDpWh1tw
 oQC4WGYM5tgE9oQMZVhVMlp7CIlLXnBZhk9p+FRpIjKghtSz1jYNBkL7+ZFP1horTFTML01/Nyn
 9fCKeVUEABWx8wHIhb9atrOqC+9VbfL6+TBw0twaMJFIEWgh/jry0fV/YKk/bQ240+tDErmREN+
 ddby/UVcpsUO3Mz/4zJVBWNGnqclPRg2aiG/yE6cPWIg==
X-Gm-Gg: AZuq6aJkyGp/+9a/Ze/mK8G4HFWCX6Ppbb0suuCG8oM/4KJQGiXdG8VTJUQaC/3+50N
 PF6TtxGxn2d9Ogwik5MLufObwv8qul5sVUmcS4C+3WkaIIuaH17xsKPcOpG8baE2DcVGVzAl5sr
 hbDQJSQ5IsmEZ1iegC1KIqPBd8vFQNehB+Ote+s93vxcLse7HfdQ3JRQ1AgT5YwnmAaOb1aOuBx
 B0S/FpIGypfb7UACKInxb2RcA==
X-Received: by 2002:a17:903:acf:b0:2a9:649:6f5 with SMTP id
 d9443c01a7336-2a933ce91d2mr32376495ad.12.1770216415868; 
 Wed, 04 Feb 2026 06:46:55 -0800 (PST)
X-Received: by 2002:a17:903:acf:b0:2a9:649:6f5 with SMTP id
 d9443c01a7336-2a933ce91d2mr32376015ad.12.1770216415388; Wed, 04 Feb 2026
 06:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-36-marcandre.lureau@redhat.com>
 <d799845e-5e05-4e28-b3d3-a32842a9be13@nutanix.com>
In-Reply-To: <d799845e-5e05-4e28-b3d3-a32842a9be13@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Feb 2026 18:46:43 +0400
X-Gm-Features: AZwV_QhiwBSt8ORcXi6ImTH1UtlOmH9jIUxJv7G0jkQkR_4kLVYH9lCSEXcZ1q8
Message-ID: <CAMxuvaxhm0FpFYKH+uW3dcTwiOSUNccp2_qB=okUqk9N+fydgQ@mail.gmail.com>
Subject: Re: [PATCH 35/37] audio-be: add some state trace for debugging
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

On Wed, Feb 4, 2026 at 3:50=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio-be.c   | 5 +++++
> >   audio/trace-events | 4 ++++
> >   2 files changed, 9 insertions(+)
> >
> > diff --git a/audio/audio-be.c b/audio/audio-be.c
> > index b3fa8d9c549..23083a75c3a 100644
> > --- a/audio/audio-be.c
> > +++ b/audio/audio-be.c
> > @@ -4,6 +4,7 @@
> >   #include "qemu/audio.h"
> >   #include "qemu/audio-capture.h"
> >   #include "qapi/error.h"
> > +#include "trace-audio.h"
>
> Are we supposed to be including trace-audio.h directly as opposed to
> just trace.h?
>

That's a good question. There is also sometimes the "trace/.."
prefix.. I'll leave it as it is for now

> >
> >   bool audio_be_check(AudioBackend **be, Error **errp)
> >   {
> > @@ -134,6 +135,8 @@ void audio_be_set_active_out(AudioBackend *be, SWVo=
iceOut *sw, bool on)
> >   {
> >       AudioBackendClass *klass =3D AUDIO_BACKEND_GET_CLASS(be);
> >
> > +    trace_audio_be_set_active_out(sw, on);
> > +
> >       if (!sw) {
> >           return;
> >       }
> > @@ -145,6 +148,8 @@ void audio_be_set_active_in(AudioBackend *be, SWVoi=
ceIn *sw, bool on)
> >   {
> >       AudioBackendClass *klass =3D AUDIO_BACKEND_GET_CLASS(be);
> >
> > +    trace_audio_be_set_active_in(sw, on);
> > +
> >       if (!sw) {
> >           return;
> >       }
> > diff --git a/audio/trace-events b/audio/trace-events
> > index 7e3f1593c81..f7f639d9605 100644
> > --- a/audio/trace-events
> > +++ b/audio/trace-events
> > @@ -26,6 +26,10 @@ pw_vol(const char *ret) "set volume: %s"
> >   pw_period(uint64_t quantum, uint32_t rate) "period =3D%" PRIu64 "/%u"
> >   pw_audio_init(void) "Initialize PipeWire context"
> >
> > +# audio-be.c
> > +audio_be_set_active_in(void *sw, bool on) "sw=3D%p, on=3D%d"
> > +audio_be_set_active_out(void *sw, bool on) "sw=3D%p, on=3D%d"
> > +
> >   # audio.c
> >   audio_timer_start(int interval) "interval %d ms"
> >   audio_timer_stop(void) ""
>
> Otherwise:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
>
> ATB,
>
> Mark.
>


