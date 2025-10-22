Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33B1CCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTl6-0005mP-Hh; Wed, 22 Oct 2025 03:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBTl3-0005m8-Ql
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:59:45 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBTl1-0000tc-Qb
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:59:45 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4e89ffd95b9so10134021cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761119982; x=1761724782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWzAS2UQX6+D3Ypq6wa/mf0MMGPrZqopf/pWSpkOOYc=;
 b=T5Ra0+cGJj4TWl0jHf3uNKBe8WxJ4TlVBjyQGb0k9gcVn5YAylvBz+0g6JHoegeXXu
 QxWy3Xp+ql7K5O+Ggt0t3U9cT5DOcSxUxrAdd84zh1LdTfBaS2wC32yWei0AuMMbg48Z
 V9+p6nG55sfh2EV3dWEW9j0UI5tSSXn5kkgUE9qYeVebVUbtSlOf9KO4W6lskdQAJN6K
 6+eqrlzkLm/bTSfNNzFeKXK5byoVjJH6eDyDeAmWgf1W2+4FwlhGLB1KgdGAQllgJO9D
 0VpU4RHZ0PILktX8MvahowsvZ3//gLHoF+RJ4u/nhMcrHsNTPF7z3vgSBlHs18I57CnF
 IckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761119982; x=1761724782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWzAS2UQX6+D3Ypq6wa/mf0MMGPrZqopf/pWSpkOOYc=;
 b=GyHwixr4J5yNNqeOgF12ejI4TC/5WiNNLU3kc6ae7OBE/DfUFMlt6A+mvSpVYn4TAI
 3Vnj1rzGhfwLgb6LYIBTUAnGVMU0nEmZ4DO9Q7W5gJmuVOBbeo8YBRWRHB1gV6BroF8Z
 uhnDiZ1qQFdsBNxOLwmsRHktC4DtnS7ITrZpAq1y6QzKEFxa9Fx86IexUeLdOGm095Q8
 UqBfBsltAj2hD8/h+UuvFvwJ5NFaCdu+Z5XTx5elSKkNaqglUKDXbkgyieCLgRvCWlA0
 IU1eUpOU8urdJ4xqiVREQWSvGp1tg2/mb7lQVvruz2qTHnKvlpG8glVYG9zh63tFdLYA
 xVCg==
X-Gm-Message-State: AOJu0YwvnRma1c2aRONTFVh+9/Cry9KItLwEY9EakqMU5bQ8i/HF7vEi
 Cm8wO18gtd3EWWk1xeoooIylyD1bd8zspm1GZfyue43o8NoXVUoApEJSUWJHeLe7xcNl3G3N9dh
 3OEhaywUOVfFXzSARu1RNT8tG71XkeEg=
X-Gm-Gg: ASbGnctRzJKiK3Wly7bmhgM7cTSw5apCGcRKWHc3PipxhcjAPdPG+QoZMpRt4mAWhwA
 a+HheTr+G5Ti8dvf93Y4tFZG4pjFECauDWFp4HXhAtBEHbfjRJl+YAL+GtlGQupvzAdTF9uqxzU
 rrX9pl0EQzzhPEpDcKGEHlzuFJgVuTFCvcaT0/C8jNYv8EcAJi0CkKz5Joe4dAsdaPgSCzcR+B5
 WDHQ5DgFVRsntGiYc1x+fxhjPs98nrXuKO/yfs5PgnGB3bsm3baSokeECx+duf9xczquCeFLaR+
 ov5EQeqQK4H7Rdxq
X-Google-Smtp-Source: AGHT+IE7Q51Tt91LzZ7HpDFr1NQIuB8+NQyeGO6Hw9wDQOm9f3Dp6CqPpcjnTgO+/4gW35DbKAFysseGvL3ktx51/7o=
X-Received: by 2002:a05:622a:1986:b0:4b6:299d:dfe4 with SMTP id
 d75a77b69052e-4e89d2b95fcmr222699481cf.32.1761119981535; Wed, 22 Oct 2025
 00:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022075352.66756-2-philmd@linaro.org>
In-Reply-To: <20251022075352.66756-2-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Oct 2025 11:59:29 +0400
X-Gm-Features: AS18NWAzG9uYlzAI0Ap_8u7Ch4nRGpUNjSiMuHQEUCaAAsQgMkp-QZTrhZE4X2I
Message-ID: <CAJ+F1CJGpvkb_cxO99CAmbW_qW0NagVscTXyyXidiEsS7dMF+w@mail.gmail.com>
Subject: Re: [PATCH v2 44/42] audio: Rename @endianness argument as
 @big_endian for clarity
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 22, 2025 at 11:55=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> @endianness is used as a boolean, rename for clarity.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/alsaaudio.c | 32 ++++++--------------------------
>  audio/ossaudio.c  | 14 +++-----------
>  audio/paaudio.c   |  8 ++++----
>  audio/pwaudio.c   | 12 ++++++------
>  4 files changed, 19 insertions(+), 47 deletions(-)
>
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 89f6dad1a97..7d7da576dc9 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -264,7 +264,7 @@ static int alsa_poll_in (HWVoiceIn *hw)
>      return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
>  }
>
> -static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
> +static snd_pcm_format_t aud_to_alsafmt(AudioFormat fmt, bool big_endian)
>  {
>      switch (fmt) {
>      case AUDIO_FORMAT_S8:
> @@ -274,39 +274,19 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat=
 fmt, int endianness)
>          return SND_PCM_FORMAT_U8;
>
>      case AUDIO_FORMAT_S16:
> -        if (endianness) {
> -            return SND_PCM_FORMAT_S16_BE;
> -        } else {
> -            return SND_PCM_FORMAT_S16_LE;
> -        }
> +        return big_endian ? SND_PCM_FORMAT_S16_BE : SND_PCM_FORMAT_S16_L=
E;
>
>      case AUDIO_FORMAT_U16:
> -        if (endianness) {
> -            return SND_PCM_FORMAT_U16_BE;
> -        } else {
> -            return SND_PCM_FORMAT_U16_LE;
> -        }
> +        return big_endian ? SND_PCM_FORMAT_U16_BE : SND_PCM_FORMAT_U16_L=
E;
>
>      case AUDIO_FORMAT_S32:
> -        if (endianness) {
> -            return SND_PCM_FORMAT_S32_BE;
> -        } else {
> -            return SND_PCM_FORMAT_S32_LE;
> -        }
> +        return big_endian ? SND_PCM_FORMAT_S32_BE : SND_PCM_FORMAT_S32_L=
E;
>
>      case AUDIO_FORMAT_U32:
> -        if (endianness) {
> -            return SND_PCM_FORMAT_U32_BE;
> -        } else {
> -            return SND_PCM_FORMAT_U32_LE;
> -        }
> +        return big_endian ? SND_PCM_FORMAT_U32_BE : SND_PCM_FORMAT_U32_L=
E;
>
>      case AUDIO_FORMAT_F32:
> -        if (endianness) {
> -            return SND_PCM_FORMAT_FLOAT_BE;
> -        } else {
> -            return SND_PCM_FORMAT_FLOAT_LE;
> -        }
> +        return big_endian ? SND_PCM_FORMAT_FLOAT_BE : SND_PCM_FORMAT_FLO=
AT_LE;
>
>      default:
>          dolog ("Internal logic error: Bad audio format %d\n", fmt);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 86c4805675e..c6cad47a015 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -131,7 +131,7 @@ static void oss_poll_in (HWVoiceIn *hw)
>      qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
>  }
>
> -static int aud_to_ossfmt (AudioFormat fmt, int endianness)
> +static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
>  {
>      switch (fmt) {
>      case AUDIO_FORMAT_S8:
> @@ -141,18 +141,10 @@ static int aud_to_ossfmt (AudioFormat fmt, int endi=
anness)
>          return AFMT_U8;
>
>      case AUDIO_FORMAT_S16:
> -        if (endianness) {
> -            return AFMT_S16_BE;
> -        } else {
> -            return AFMT_S16_LE;
> -        }
> +        return big_endian ? AFMT_S16_BE : AFMT_S16_LE;
>
>      case AUDIO_FORMAT_U16:
> -        if (endianness) {
> -            return AFMT_U16_BE;
> -        } else {
> -            return AFMT_U16_LE;
> -        }
> +        return big_endian ? AFMT_U16_BE : AFMT_U16_LE;
>
>      default:
>          dolog ("Internal logic error: Bad audio format %d\n", fmt);
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 6b9b6d219ab..0c06a397195 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -316,7 +316,7 @@ unlock_and_fail:
>      return 0;
>  }
>
> -static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness=
)
> +static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian=
)
>  {
>      int format;
>
> @@ -327,14 +327,14 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat=
 afmt, int endianness)
>          break;
>      case AUDIO_FORMAT_S16:
>      case AUDIO_FORMAT_U16:
> -        format =3D endianness ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
> +        format =3D big_endian ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
>          break;
>      case AUDIO_FORMAT_S32:
>      case AUDIO_FORMAT_U32:
> -        format =3D endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
> +        format =3D big_endian ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
>          break;
>      case AUDIO_FORMAT_F32:
> -        format =3D endianness ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32L=
E;
> +        format =3D big_endian ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32L=
E;
>          break;
>      default:
>          dolog ("Internal logic error: Bad audio format %d\n", afmt);
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 0fd59d9fe60..30f717ccacf 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -324,7 +324,7 @@ done_unlock:
>  }
>
>  static int
> -audfmt_to_pw(AudioFormat fmt, int endianness)
> +audfmt_to_pw(AudioFormat fmt, bool big_endian)
>  {
>      int format;
>
> @@ -336,19 +336,19 @@ audfmt_to_pw(AudioFormat fmt, int endianness)
>          format =3D SPA_AUDIO_FORMAT_U8;
>          break;
>      case AUDIO_FORMAT_S16:
> -        format =3D endianness ? SPA_AUDIO_FORMAT_S16_BE : SPA_AUDIO_FORM=
AT_S16_LE;
> +        format =3D big_endian ? SPA_AUDIO_FORMAT_S16_BE : SPA_AUDIO_FORM=
AT_S16_LE;
>          break;
>      case AUDIO_FORMAT_U16:
> -        format =3D endianness ? SPA_AUDIO_FORMAT_U16_BE : SPA_AUDIO_FORM=
AT_U16_LE;
> +        format =3D big_endian ? SPA_AUDIO_FORMAT_U16_BE : SPA_AUDIO_FORM=
AT_U16_LE;
>          break;
>      case AUDIO_FORMAT_S32:
> -        format =3D endianness ? SPA_AUDIO_FORMAT_S32_BE : SPA_AUDIO_FORM=
AT_S32_LE;
> +        format =3D big_endian ? SPA_AUDIO_FORMAT_S32_BE : SPA_AUDIO_FORM=
AT_S32_LE;
>          break;
>      case AUDIO_FORMAT_U32:
> -        format =3D endianness ? SPA_AUDIO_FORMAT_U32_BE : SPA_AUDIO_FORM=
AT_U32_LE;
> +        format =3D big_endian ? SPA_AUDIO_FORMAT_U32_BE : SPA_AUDIO_FORM=
AT_U32_LE;
>          break;
>      case AUDIO_FORMAT_F32:
> -        format =3D endianness ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORM=
AT_F32_LE;
> +        format =3D big_endian ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORM=
AT_F32_LE;
>          break;
>      default:
>          dolog("Internal logic error: Bad audio format %d\n", fmt);
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

