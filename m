Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A262E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvAj-0004Fl-Up; Mon, 16 Feb 2026 04:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vrvAf-0004FV-Qu
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:45:39 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vrvAd-0003tO-Cb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:45:37 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-502a789834fso27111421cf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 01:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771235134; cv=none;
 d=google.com; s=arc-20240605;
 b=GH1nSfR+NblQX+u7Lbsmn4dkXYwfkjWhoZO8YHUcNsO042SIkWRyKhEMtFr9U6FJUt
 4rLrLLgbIRw/pDUifInSBq38H7YEPF7pyINIJ0TJGRnJClgAEcQ0wv68NbsiuaCjJQi8
 c9NyuiOBwGf9RCslL4hKhU8872vsvaZjaAG+JGb5QtAcbSltuyffaMbvjbjcmGVgdH55
 szpGHg27Mh0x9u0nMkhoKtmUyOlkwXnPKTP1rWfy/F9QQODlvoAnujCyCE+WpxQof1vQ
 IfXkvDfRnwRTmEGz04zgXFUoVvmNcxTS2PPOyiiz+49Cj9Sz3rbYX7PET1fGyT6SexZj
 /CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1sPC5ASPbtn/JJf8VUWTIaZlKN62iYIjo6JPOZLxako=;
 fh=aXxe+MZ3/GfU28+aM3kjSxvcfAzLVXyPCg0P992PjkI=;
 b=JMg/HvN0ms3xPxN44C6rPrDycMuZ/dU4vN/DzfcfepLLmGxk62hf//+PXwHi02hg5w
 blfl56TBtgwzJSz9jBzZgT4nxAR6AT0Eev2unjdJsENPAI8alXs6S+gHI5WZW8Mv55of
 ORTKRrveH0CRLr+zfKnwZWuxZPxf/8HPdFW3qu2IDcBq1/2GyLdD7vGmFam2q/rrToof
 rNR/Wm49dkkikCxvH90mPmfQK7B203NGP0C6hJl9X6LWVdBjeryBpvoHMGkgWCa/7rbl
 U9Hyh801S9EBGprj6Y/iibfnvWNsPvuvJIWnvQzD0JD7LNKFIQfEa5q6O19R+rm2xrKb
 6ZFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771235134; x=1771839934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sPC5ASPbtn/JJf8VUWTIaZlKN62iYIjo6JPOZLxako=;
 b=Oz0c3tPEAz5/5HThqmt7qEAykZiebnMoYNaFalGXpeeOS09s5QyqXK1nTZcRRz9Rqv
 n9MlROO/vUTDl0GIhL7afxB/X9xlWd6M0shXK3DvRRccnIdWLXTf8QPPawPohvLP/Zfr
 Te8VtsfhVpcH82gMaC7XGB+91EN+zT1H5SNIFuZKMoI0whaKPE0PMAYjGVTg2rr1Dtl6
 FRRbt52IReTbXXRL8+pYXbBV9B/nUqtYvKN5hjaC+iysOqU5F0TvRO9Uo8694dh6MwLY
 JVltme8Ozd3Njtu8VcphfTyfKS5NSA4h/SZhUk0yaNQv+Fe9b8b8urFsdcUrc9V/5yA7
 BCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771235134; x=1771839934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1sPC5ASPbtn/JJf8VUWTIaZlKN62iYIjo6JPOZLxako=;
 b=ZKKxg9SFLaR9TG7/uPiUBH45G5KbY38Lbkxd2ojkLzA3KgSSLoO04Wmr0v8OttJmvR
 2izuF8aMdZgV626ZRr2Wxrg2r3nSEvqXZdpMaEReCT0kn9cgcc8Jr0GsQOQFgqCmIRYE
 OU/FUCs8Ud0u5H3zinnUJ9pb/dmVaJbkoT+cLxhMVjccDxo1Zs1cMa7q5lhFCiFS06Cj
 3HEwHUQ46TTIsACa21idjppkn7SZSRwnw3wcYZbJXeHYeOt3DtnvzSWg+3L81fLi/7aB
 y/Pa4FFMihutexouKSX3liBKZJSZWtmjbJSjV2CijnbNw14GR4oOs6tTbw6DjlA8zKlF
 eX1A==
X-Gm-Message-State: AOJu0Yw67L2r+KBv/O8dsapQnwDQu805Xi6+vFhmV+o0LlOIrV8Y8KhW
 jgQZwgn/L1clfE6Yb4OpMFGpBPphTFvkO52oE/Ed6tRqDu6gamXnjFyVgu0RzAHIO6kTm1r0POn
 P88yUj+/7eA1x0x8CnUX8ttgh46QshRE=
X-Gm-Gg: AZuq6aJQt9xZ9/7k+7UZU643n4wafWmzS2GObPGQSxe8m3Sd+t7aghfK95jN90+sbbE
 XMPLU08Z5C1iHEkaamjsdPJc5wxTWnCXrS8EppGXoQC/OvVJ+sWFeDH/qVKEjB7CaiwCj1jyAgA
 0uFjhc3wlEj22ZwLrbRNHPeA4xH3XxU1BTJN5jJ51Iv+BxrIYYCIX77/abW9PTX4EbSjFO9EMkm
 AgLIe9S2E+qcNGTJDXtMqMIOQjsfvYHMVmRSG6csteGhuMScJOLZ1UlgMcJsrQRa1pFCmTitxNX
 /CvQyCYebV3PNPmBFSpiRlPgqNVt+B3+83M8hDb9
X-Received: by 2002:ac8:5f11:0:b0:502:effc:401 with SMTP id
 d75a77b69052e-506a6b749cdmr125621731cf.74.1771235133541; Mon, 16 Feb 2026
 01:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-32-marcandre.lureau@redhat.com>
 <6f204d62-f14b-479c-ab37-1dcca6b5bd30@nutanix.com>
 <CAMxuvazGyHmW1iUcyaKuEdwjvmHRxP_oF-0vno2eZc+-8XH_mQ@mail.gmail.com>
 <265f1343-64f6-4357-a82f-d20bad056904@nutanix.com>
In-Reply-To: <265f1343-64f6-4357-a82f-d20bad056904@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Feb 2026 10:45:22 +0100
X-Gm-Features: AaiRm51TX71Y3T4s_qTy6gxsUjOFf1132n1IRnYAGIK8D9CJ6DX6PwA8aTs1Wl4
Message-ID: <CAJ+F1CJc7s5Jt2cvjSSewUp3GTbRK2dYLDRK4souGCPcH84L8w@mail.gmail.com>
Subject: Re: [PATCH 31/43] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Mon, Feb 16, 2026 at 10:32=E2=80=AFAM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 14/02/2026 08:20, Marc-Andr=C3=A9 Lureau wrote:
>
> > Hi
> >
> > On Fri, Feb 13, 2026 at 4:28=E2=80=AFPM Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >>
> >> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
> >>
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> The audio_pcm_info structure stored three fields (bits, is_signed,
> >>> is_float) that were always derived from the AudioFormat enum. This
> >>> redundancy meant the same information was represented twice, with no
> >>> type-level guarantee that they stayed in sync.
> >>>
> >>> Replace these fields with a single AudioFormat field, and add helper
> >>> functions to extract the derived properties when needed:
> >>> - audio_format_bits()
> >>> - audio_format_is_signed()
> >>> - audio_format_is_float()
> >>>
> >>> This improves type safety by making AudioFormat the single source of
> >>> truth, eliminating the possibility of inconsistent state between the
> >>> format enum and its derived boolean/integer representations.
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    audio/audio_int.h       |   4 +-
> >>>    audio/audio_template.h  |  12 +--
> >>>    include/qemu/audio.h    |  49 +++++++++
> >>>    audio/audio-mixeng-be.c | 218 ++++++++++++------------------------=
----
> >>>    audio/dbusaudio.c       |  12 +--
> >>>    audio/coreaudio.m       |   2 +-
> >>>    6 files changed, 126 insertions(+), 171 deletions(-)
> >>>
> >>> diff --git a/audio/audio_int.h b/audio/audio_int.h
> >>> index 5334c4baad2..dd5f2220d75 100644
> >>> --- a/audio/audio_int.h
> >>> +++ b/audio/audio_int.h
> >>> @@ -45,9 +45,7 @@ struct audio_callback {
> >>>    };
> >>>
> >>>    struct audio_pcm_info {
> >>> -    int bits;
> >>> -    bool is_signed;
> >>> -    bool is_float;
> >>> +    AudioFormat af;
> >>>        int freq;
> >>>        int nchannels;
> >>>        int bytes_per_frame;
> >>> diff --git a/audio/audio_template.h b/audio/audio_template.h
> >>> index 08d60422589..3da91a4782c 100644
> >>> --- a/audio/audio_template.h
> >>> +++ b/audio/audio_template.h
> >>> @@ -173,7 +173,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
> >>>        sw->empty =3D true;
> >>>    #endif
> >>>
> >>> -    if (sw->info.is_float) {
> >>> +    if (audio_format_is_float(hw->info.af)) {
> >>>    #ifdef DAC
> >>>            sw->conv =3D mixeng_conv_float[sw->info.nchannels =3D=3D 2=
]
> >>>                [sw->info.swap_endianness];
> >>> @@ -188,9 +188,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
> >>>            sw->clip =3D mixeng_clip
> >>>    #endif
> >>>                [sw->info.nchannels =3D=3D 2]
> >>> -            [sw->info.is_signed]
> >>> +            [audio_format_is_signed(hw->info.af)]
> >>>                [sw->info.swap_endianness]
> >>> -            [audio_bits_to_index(sw->info.bits)];
> >>> +            [audio_format_to_index(hw->info.af)];
> >>>        }
> >>>
> >>>        sw->name =3D g_strdup (name);
> >>> @@ -300,7 +300,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(Audi=
oMixengBackend *s,
> >>>            goto err1;
> >>>        }
> >>>
> >>> -    if (hw->info.is_float) {
> >>> +    if (audio_format_is_float(hw->info.af)) {
> >>>    #ifdef DAC
> >>>            hw->clip =3D mixeng_clip_float[hw->info.nchannels =3D=3D 2=
]
> >>>                [hw->info.swap_endianness];
> >>> @@ -315,9 +315,9 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(Audi=
oMixengBackend *s,
> >>>            hw->conv =3D mixeng_conv
> >>>    #endif
> >>>                [hw->info.nchannels =3D=3D 2]
> >>> -            [hw->info.is_signed]
> >>> +            [audio_format_is_signed(hw->info.af)]
> >>>                [hw->info.swap_endianness]
> >>> -            [audio_bits_to_index(hw->info.bits)];
> >>> +            [audio_format_to_index(hw->info.af)];
> >>>        }
> >>>
> >>>        glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
> >>> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> >>> index b6b6ee9b560..a2fbc286eb1 100644
> >>> --- a/include/qemu/audio.h
> >>> +++ b/include/qemu/audio.h
> >>> @@ -185,6 +185,55 @@ bool audio_be_set_dbus_server(AudioBackend *be,
> >>>
> >>>    const char *audio_application_name(void);
> >>>
> >>> +static inline int audio_format_bits(AudioFormat fmt)
> >>
> >> Does the inline make a difference here? My understanding is that the
> >> compiler treats this as a weak hint these days, and generally does the
> >> right thing by itself.
> >
> > If you drop "inline" you get -Werror=3Dunused-function.
>
> Ah I guess because this is a header file? Yeah that does make it
> trickier, I guess let's keep the compiler happy then.
>
> >>
> >>> +{
> >>> +    switch (fmt) {
> >>> +    case AUDIO_FORMAT_S8:
> >>> +    case AUDIO_FORMAT_U8:
> >>> +        return 8;
> >>> +
> >>> +    case AUDIO_FORMAT_S16:
> >>> +    case AUDIO_FORMAT_U16:
> >>> +        return 16;
> >>> +
> >>> +    case AUDIO_FORMAT_F32:
> >>> +    case AUDIO_FORMAT_S32:
> >>> +    case AUDIO_FORMAT_U32:
> >>> +        return 32;
> >>> +
> >>> +    case AUDIO_FORMAT__MAX:
> >>> +     break;
> >>> +    }
> >>
> >> I'm not sure that AUDIO_FORMAT__MAX is a valid choice here - can you
> >> drop the explicit case for AUDIO_FORMAT__MAX and then simply have a
> >> default that calls g_assert_not_reached() instead?
> >
> > We need to handle all variants, because -Werror=3Dswitch. That
>
> Does that also include the use of default? I was thinking something
> along the lines of this to help make things clearer:
>
> static inline int audio_format_bits(AudioFormat fmt)
> {
>      switch (fmt) {
>      case AUDIO_FORMAT_S8:
>      case AUDIO_FORMAT_U8:
>          return 8;
>
>      case AUDIO_FORMAT_S16:
>      case AUDIO_FORMAT_U16:
>          return 16;
>
>      case AUDIO_FORMAT_F32:
>      case AUDIO_FORMAT_S32:
>      case AUDIO_FORMAT_U32:
>          return 32;
>
>      default:
>          break;
>      }
>
>      g_assert_not_reached();
> }

That works, but is it any better? If we introduce a new format, it
would not warn. And if we used -Wswitch-enum, it would complain.

>
> >>> +    g_assert_not_reached();
> >>> +}
> >>> +
> >>> +static inline bool audio_format_is_float(AudioFormat fmt)
> >>
> >> Same comment here re: inline.
> >>
> >>> +{
> >>> +    return fmt =3D=3D AUDIO_FORMAT_F32;
> >>> +}
> >>> +
> >>> +static inline bool audio_format_is_signed(AudioFormat fmt)
> >>
> >> And here.
> >>
> >>> +{
> >>> +    switch (fmt) {
> >>> +    case AUDIO_FORMAT_S8:
> >>> +    case AUDIO_FORMAT_S16:
> >>> +    case AUDIO_FORMAT_S32:
> >>> +    case AUDIO_FORMAT_F32:
> >>> +        return true;
> >>> +
> >>> +    case AUDIO_FORMAT_U8:
> >>> +    case AUDIO_FORMAT_U16:
> >>> +    case AUDIO_FORMAT_U32:
> >>> +        return false;
> >>> +
> >>> +    case AUDIO_FORMAT__MAX:
> >>
> >> Same comment here re: AUDIO_FORMAT__MAX.
> >>
> >>> +     break;
> >>> +    }
> >>> +
> >>> +    g_assert_not_reached();
> >>> +}
> >>> +
> >>>    #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
> >>>        DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
> >>>
> >>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> >>> index a0e542754e5..146026d0b39 100644
> >>> --- a/audio/audio-mixeng-be.c
> >>> +++ b/audio/audio-mixeng-be.c
> >>> @@ -62,23 +62,28 @@ int audio_bug (const char *funcname, int cond)
> >>>        return cond;
> >>>    }
> >>>
> >>> -static inline int audio_bits_to_index (int bits)
> >>> +/*
> >>> + * Convert audio format to mixeng_clip index. Used by audio_pcm_sw_i=
nit_ and
> >>> + * audio_mixeng_backend_add_capture()
> >>> + */
> >>> +static int audio_format_to_index(AudioFormat af)
> >>>    {
> >>> -    switch (bits) {
> >>> -    case 8:
> >>> +    switch (af) {
> >>> +    case AUDIO_FORMAT_U8:
> >>> +    case AUDIO_FORMAT_S8:
> >>>            return 0;
> >>> -
> >>> -    case 16:
> >>> +    case AUDIO_FORMAT_U16:
> >>> +    case AUDIO_FORMAT_S16:
> >>>            return 1;
> >>> -
> >>> -    case 32:
> >>> +    case AUDIO_FORMAT_U32:
> >>> +    case AUDIO_FORMAT_S32:
> >>>            return 2;
> >>> -
> >>> -    default:
> >>> -        audio_bug ("bits_to_index", 1);
> >>> -        AUD_log (NULL, "invalid bits %d\n", bits);
> >>> -        return 0;
> >>> +    case AUDIO_FORMAT_F32:
> >>> +    case AUDIO_FORMAT__MAX:
> >>
> >> Same comment re: AUDIO_FORMAT__MAX.
> >>
> >>> +        break;
> >>>        }
> >>> +
> >>> +    g_assert_not_reached();
> >>>    }
> >>>
> >>>    void AUD_vlog (const char *cap, const char *fmt, va_list ap)
> >>> @@ -172,141 +177,68 @@ static int audio_validate_settings (const stru=
ct audsettings *as)
> >>>
> >>>    static int audio_pcm_info_eq (struct audio_pcm_info *info, const s=
truct audsettings *as)
> >>>    {
> >>> -    int bits =3D 8;
> >>> -    bool is_signed =3D false, is_float =3D false;
> >>> -
> >>> -    switch (as->fmt) {
> >>> -    case AUDIO_FORMAT_S8:
> >>> -        is_signed =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_U8:
> >>> -        break;
> >>> -
> >>> -    case AUDIO_FORMAT_S16:
> >>> -        is_signed =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_U16:
> >>> -        bits =3D 16;
> >>> -        break;
> >>> -
> >>> -    case AUDIO_FORMAT_F32:
> >>> -        is_float =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_S32:
> >>> -        is_signed =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_U32:
> >>> -        bits =3D 32;
> >>> -        break;
> >>> -
> >>> -    default:
> >>> -        abort();
> >>> -    }
> >>> -    return info->freq =3D=3D as->freq
> >>> +    return info->af =3D=3D as->fmt
> >>> +        && info->freq =3D=3D as->freq
> >>>            && info->nchannels =3D=3D as->nchannels
> >>> -        && info->is_signed =3D=3D is_signed
> >>> -        && info->is_float =3D=3D is_float
> >>> -        && info->bits =3D=3D bits
> >>>            && info->swap_endianness =3D=3D (as->endianness !=3D HOST_=
BIG_ENDIAN);
> >>>    }
> >>>
> >>>    void audio_pcm_init_info (struct audio_pcm_info *info, const struc=
t audsettings *as)
> >>>    {
> >>> -    int bits =3D 8, mul;
> >>> -    bool is_signed =3D false, is_float =3D false;
> >>> -
> >>> -    switch (as->fmt) {
> >>> -    case AUDIO_FORMAT_S8:
> >>> -        is_signed =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_U8:
> >>> -        mul =3D 1;
> >>> -        break;
> >>> -
> >>> -    case AUDIO_FORMAT_S16:
> >>> -        is_signed =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_U16:
> >>> -        bits =3D 16;
> >>> -        mul =3D 2;
> >>> -        break;
> >>> -
> >>> -    case AUDIO_FORMAT_F32:
> >>> -        is_float =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_S32:
> >>> -        is_signed =3D true;
> >>> -        /* fall through */
> >>> -    case AUDIO_FORMAT_U32:
> >>> -        bits =3D 32;
> >>> -        mul =3D 4;
> >>> -        break;
> >>> -
> >>> -    default:
> >>> -        abort();
> >>> -    }
> >>> -
> >>> +    info->af =3D as->fmt;
> >>>        info->freq =3D as->freq;
> >>> -    info->bits =3D bits;
> >>> -    info->is_signed =3D is_signed;
> >>> -    info->is_float =3D is_float;
> >>>        info->nchannels =3D as->nchannels;
> >>> -    info->bytes_per_frame =3D as->nchannels * mul;
> >>> +    info->bytes_per_frame =3D as->nchannels * audio_format_bits(as->=
fmt) / 8;
> >>>        info->bytes_per_second =3D info->freq * info->bytes_per_frame;
> >>>        info->swap_endianness =3D (as->endianness !=3D HOST_BIG_ENDIAN=
);
> >>>    }
> >>>
> >>> -void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *bu=
f, int len)
> >>> +void audio_pcm_info_clear_buf(struct audio_pcm_info *info, void *buf=
, int len)
> >>>    {
> >>>        if (!len) {
> >>>            return;
> >>>        }
> >>>
> >>> -    if (info->is_signed || info->is_float) {
> >>> -        memset(buf, 0x00, len * info->bytes_per_frame);
> >>> -    } else {
> >>> -        switch (info->bits) {
> >>> -        case 8:
> >>> -            memset(buf, 0x80, len * info->bytes_per_frame);
> >>> -            break;
> >>> -
> >>> -        case 16:
> >>> -            {
> >>> -                int i;
> >>> -                uint16_t *p =3D buf;
> >>> -                short s =3D INT16_MAX;
> >>> -
> >>> -                if (info->swap_endianness) {
> >>> -                    s =3D bswap16 (s);
> >>> -                }
> >>> -
> >>> -                for (i =3D 0; i < len * info->nchannels; i++) {
> >>> -                    p[i] =3D s;
> >>> -                }
> >>> -            }
> >>> -            break;
> >>> +    switch (info->af) {
> >>> +    case AUDIO_FORMAT_U8:
> >>> +        memset(buf, 0x80, len * info->bytes_per_frame);
> >>
> >> This doesn't look right - isn't this the signed version?
> >
> > No,
> >
> >>
> >>> +        break;
> >>> +    case AUDIO_FORMAT_U16: {
> >>> +        int i;
> >>> +        uint16_t *p =3D buf;
> >>> +        short s =3D INT16_MAX;
> >>>
> >>> -        case 32:
> >>> -            {
> >>> -                int i;
> >>> -                uint32_t *p =3D buf;
> >>> -                int32_t s =3D INT32_MAX;
> >>> +        if (info->swap_endianness) {
> >>> +            s =3D bswap16(s);
> >>> +        }
> >>>
> >>> -                if (info->swap_endianness) {
> >>> -                    s =3D bswap32 (s);
> >>> -                }
> >>> +        for (i =3D 0; i < len * info->nchannels; i++) {
> >>> +            p[i] =3D s;
> >>> +        }
> >>
> >> I think this is signed too?
> >>
> >>> +        break;
> >>> +    }
> >>> +    case AUDIO_FORMAT_U32: {
> >>> +        int i;
> >>> +        uint32_t *p =3D buf;
> >>> +        int32_t s =3D INT32_MAX;
> >>>
> >>> -                for (i =3D 0; i < len * info->nchannels; i++) {
> >>> -                    p[i] =3D s;
> >>> -                }
> >>> -            }
> >>> -            break;
> >>> +        if (info->swap_endianness) {
> >>> +            s =3D bswap32(s);
> >>> +        }
> >>>
> >>> -        default:
> >>> -            AUD_log (NULL, "audio_pcm_info_clear_buf: invalid bits %=
d\n",
> >>> -                     info->bits);
> >>> -            break;
> >>> +        for (i =3D 0; i < len * info->nchannels; i++) {
> >>> +            p[i] =3D s;
> >>>            }
> >>
> >> And also here.
> >>
> >>> +        break;
> >>> +    }
> >>> +    case AUDIO_FORMAT_S8:
> >>> +    case AUDIO_FORMAT_S16:
> >>> +    case AUDIO_FORMAT_S32:
> >>> +    case AUDIO_FORMAT_F32:
> >>> +        memset(buf, 0x00, len * info->bytes_per_frame);
> >>
> >> ... and this the unsigned version? I think they've been swapped.
> >
> > no, unsigned PCM use mid-range value for zero.
>
> Sigh. Yes of course you're right, sorry for the noise.
>
> >>> +        break;
> >>> +    case AUDIO_FORMAT__MAX:
> >>> +        g_assert_not_reached();
> >>
> >> This looks more like I would expect, although possibly replace the cas=
e
> >> with a default? I expect that another assert() would have tripped by n=
ow
> >> with real usage if AUDIO_FORMAT__MAX were specified, but I think it
> >> would be good to be consistent.
> >
> > Unfortunately, the compiler complains for non-void functions if you
> > don't finish the function with the g_assert_not_reached().
> >
> >>
> >>>        }
> >>>    }
> >>>
> >>> @@ -719,8 +651,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, =
void *buf, size_t buf_len)
> >>>    #ifdef DEBUG_AUDIO
> >>>    static void audio_pcm_print_info (const char *cap, struct audio_pc=
m_info *info)
> >>>    {
> >>> -    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
> >>> -          cap, info->bits, info->is_signed, info->is_float, info->fr=
eq,
> >>> +    dolog("%s: %s, freq %d, nchan %d\n",
> >>> +          cap, AudioFormat_str(info->af), info->freq,
> >>>              info->nchannels);
> >>
> >> More dolog. Presumably this gets converted to error_report() later?
> >>
> >>>    }
> >>>    #endif
> >>> @@ -1759,15 +1691,15 @@ static CaptureVoiceOut *audio_mixeng_backend_=
add_capture(
> >>>
> >>>            cap->buf =3D g_malloc0_n(hw->mix_buf.size, hw->info.bytes_=
per_frame);
> >>>
> >>> -        if (hw->info.is_float) {
> >>> +        if (audio_format_is_float(hw->info.af)) {
> >>>                hw->clip =3D mixeng_clip_float[hw->info.nchannels =3D=
=3D 2]
> >>>                    [hw->info.swap_endianness];
> >>>            } else {
> >>>                hw->clip =3D mixeng_clip
> >>>                    [hw->info.nchannels =3D=3D 2]
> >>> -                [hw->info.is_signed]
> >>> +                [audio_format_is_signed(hw->info.af)]
> >>>                    [hw->info.swap_endianness]
> >>> -                [audio_bits_to_index(hw->info.bits)];
> >>> +                [audio_format_to_index(hw->info.af)];
> >>>            }
> >>>
> >>>            QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
> >>> @@ -1869,29 +1801,6 @@ audsettings audiodev_to_audsettings(AudiodevPe=
rDirectionOptions *pdo)
> >>>        };
> >>>    }
> >>>
> >>> -int audioformat_bytes_per_sample(AudioFormat fmt)
> >>> -{
> >>> -    switch (fmt) {
> >>> -    case AUDIO_FORMAT_U8:
> >>> -    case AUDIO_FORMAT_S8:
> >>> -        return 1;
> >>> -
> >>> -    case AUDIO_FORMAT_U16:
> >>> -    case AUDIO_FORMAT_S16:
> >>> -        return 2;
> >>> -
> >>> -    case AUDIO_FORMAT_U32:
> >>> -    case AUDIO_FORMAT_S32:
> >>> -    case AUDIO_FORMAT_F32:
> >>> -        return 4;
> >>> -
> >>> -    case AUDIO_FORMAT__MAX:
> >>> -        ;
> >>> -    }
> >>> -    abort();
> >>> -}
> >>> -
> >>> -
> >>>    /* frames =3D freq * usec / 1e6 */
> >>>    int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
> >>>                            audsettings *as, int def_usecs)
> >>> @@ -1914,8 +1823,7 @@ int audio_buffer_samples(AudiodevPerDirectionOp=
tions *pdo,
> >>>    int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
> >>>                           audsettings *as, int def_usecs)
> >>>    {
> >>> -    return audio_buffer_samples(pdo, as, def_usecs) *
> >>> -        audioformat_bytes_per_sample(as->fmt);
> >>> +    return audio_buffer_samples(pdo, as, def_usecs) * audio_format_b=
its(as->fmt) / 8;
> >>>    }
> >>>
> >>>    void audio_rate_start(RateCtl *rate)
> >>> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> >>> index e284542b2dd..72d6194033b 100644
> >>> --- a/audio/dbusaudio.c
> >>> +++ b/audio/dbusaudio.c
> >>> @@ -147,9 +147,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutLi=
stener *listener,
> >>>        qemu_dbus_display1_audio_out_listener_call_init(
> >>>            listener,
> >>>            (uintptr_t)hw,
> >>> -        hw->info.bits,
> >>> -        hw->info.is_signed,
> >>> -        hw->info.is_float,
> >>> +        audio_format_bits(hw->info.af),
> >>> +        audio_format_is_signed(hw->info.af),
> >>> +        audio_format_is_float(hw->info.af),
> >>>            hw->info.freq,
> >>>            hw->info.nchannels,
> >>>            hw->info.bytes_per_frame,
> >>> @@ -273,9 +273,9 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInList=
ener *listener, HWVoiceIn *hw)
> >>>        qemu_dbus_display1_audio_in_listener_call_init(
> >>>            listener,
> >>>            (uintptr_t)hw,
> >>> -        hw->info.bits,
> >>> -        hw->info.is_signed,
> >>> -        hw->info.is_float,
> >>> +        audio_format_bits(hw->info.af),
> >>> +        audio_format_is_signed(hw->info.af),
> >>> +        audio_format_is_float(hw->info.af),
> >>>            hw->info.freq,
> >>>            hw->info.nchannels,
> >>>            hw->info.bytes_per_frame,
> >>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> >>> index 40d7986b1d7..08bab353831 100644
> >>> --- a/audio/coreaudio.m
> >>> +++ b/audio/coreaudio.m
> >>> @@ -359,7 +359,7 @@ static OSStatus init_out_device(coreaudioVoiceOut=
 *core)
> >>>        AudioValueRange frameRange;
> >>>
> >>>        AudioStreamBasicDescription streamBasicDescription =3D {
> >>> -        .mBitsPerChannel =3D core->hw.info.bits,
> >>> +        .mBitsPerChannel =3D audio_format_bits(core->hw.info.af),
> >>>            .mBytesPerFrame =3D core->hw.info.bytes_per_frame,
> >>>            .mBytesPerPacket =3D core->hw.info.bytes_per_frame,
> >>>            .mChannelsPerFrame =3D core->hw.info.nchannels,
>
> Having said that, given that the unsigned/signed bit is actually
> correct, then regardless of the final form of the switch() statements
> then this seems okay:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
>


thnks

--=20
Marc-Andr=C3=A9 Lureau

