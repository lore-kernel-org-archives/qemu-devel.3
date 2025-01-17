Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBA8C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjMw-0005gx-DD; Fri, 17 Jan 2025 05:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tYjMu-0005gm-2w
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:14:24 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tYjMr-0001wb-VD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:14:23 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso34651755ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1737108859; x=1737713659;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p2P3o6s6J0d7vRSKQ44I+lSGTA7c77TuILDbqbva5DI=;
 b=ZC7XfbOzNZVQRbho5dmN5wo/zJWfnrFa/uEIN5ir+fboxvqsL2vqFHlcQtnilhYe2i
 XcWifFZBh4BQWsjj/c9tKgTc8vef79sBjo8ak9zKgc/UIkTDdqUggHGe4FWafZ52dFmP
 rkFNgOvVzPJzoXzIlmgO/dP6K+GjdPMg2Lhgbf94CrCEAOJBS7ouSNsrh9l/UAYKV37a
 Dzf6Da48LpJQVlnILB1u4fORpulmlJUyxlV2nlX9cuLn/H7KPKhZJBP5AoaVqwjqbXIx
 Zq8fshVOHG327RVHjNyH/OzlBPwN3HlWetJ7ltpQByZooeHgAFfFjXy+skGjOBW7KyRR
 glJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737108859; x=1737713659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p2P3o6s6J0d7vRSKQ44I+lSGTA7c77TuILDbqbva5DI=;
 b=QAQNsRA1iXikBkMFf6JJ//QXF3r207+jGF1fomeihUWD7E4BDjOlKu2Des7w1XstuN
 sXD6J6bPvUfpLkK7fZOo33rFKYUeuFtPfeuP0KL/Y4wBi7FPdjPcqSSws30lH6dUYpQY
 a7dsTW/zCcXZ0q6ou9tIq/v3dVBC8rWkBUSy3cn3xbmAQXevKF5M0ZPAdSpRLuS1sTDX
 ZILCnR9ux/03a4/qE5y45ez8+Ux9rZrlbYZ+DSk2e5j135tNqfmDzm4PY283csRwoO0L
 89qxC03kE7C++LGiJJuY/N6BwlAUxf7lYD6fMoDb5hrXctRd2yRGdJmp4E4onLtZ492K
 wrtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBsOPtDWF/z1FsAAlUtJowBquH4oIZQt9vDD5Qs5w84XslGAGISsW+cVU6IvnfXEduPU5gHO438oqB@nongnu.org
X-Gm-Message-State: AOJu0YzIPqANwJl9D3nauffettrxA3NJDgPa7I/cv0a2Jf7vyAHQcA8Z
 ddtFEJouWG+keqB9IHtSEarM5GrPpo03VqWergfmsWt4owgJv5my6xhKu4MDNjlJiqcBRzRLMgd
 hnA1Y6TdDDZPku58f/wBeWCQ2mRMOIkWDEpsw
X-Gm-Gg: ASbGnctGuGh74aN+5WZYId8+gEw/j4kxKQdVRxXt1DfFFv605imwO01UQ+fSOBZ9Gll
 D+/vMOb0YleKgdPFmTP2c8yQg4e6VTiRbn1YSfA==
X-Google-Smtp-Source: AGHT+IEwszwYrdXzFiQ0Wz5VK3aaJMR1YxSY01gLaJuGaI89twtBvruFxa0P1pT3gofkfNlDwLL8YXrc/5pB7jBT5XY=
X-Received: by 2002:a17:90a:e18f:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2f782c7a769mr3456256a91.12.1737108859657; Fri, 17 Jan 2025
 02:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
 <20250117-coreaudio-v4-2-f8d4fa4cb5f4@daynix.com>
In-Reply-To: <20250117-coreaudio-v4-2-f8d4fa4cb5f4@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 17 Jan 2025 11:14:08 +0100
X-Gm-Features: AbW1kvbI6RzOBpjvp9yoSJ2_HYfMzm4r_csVs14x5v5YV42MmPr-aNqmoWQ8gE4
Message-ID: <CAGCz3vsEsxc_GmKyS5dqS38A+dJ64tGSMVME0kch2cHF3J8-Rw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] audio: Add functions to initialize buffers
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 devel@daynix.com
Content-Type: multipart/alternative; boundary="000000000000844088062be42cae"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::633;
 envelope-from=lists@philjordan.eu; helo=mail-pl1-x633.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000844088062be42cae
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 07:48, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> These functions can be used to re-initialize buffers when hardware
> parameters change due to device hotplug, for example.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


> ---
>  audio/audio_int.h |  2 ++
>  audio/audio.c     | 24 ++++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 2d079d00a259..9ba4a144d571 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -187,9 +187,11 @@ struct audio_pcm_ops {
>      void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
>  };
>
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
>  void audio_generic_run_buffer_in(HWVoiceIn *hw);
>  void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
>  void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
>  void audio_generic_run_buffer_out(HWVoiceOut *hw);
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
> diff --git a/audio/audio.c b/audio/audio.c
> index 87b4e9b6f2f3..17c6bbd0ae9e 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>  #endif
>  }
>
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul = g_malloc(hw->size_emul);
> +    hw->pos_emul = hw->pending_emul = 0;
> +}
> +
>  void audio_generic_run_buffer_in(HWVoiceIn *hw)
>  {
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> +        audio_generic_initialize_buffer_in(hw);
>      }
>
>      while (hw->pending_emul < hw->size_emul) {
> @@ -1446,6 +1452,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw,
> void *buf, size_t size)
>      hw->pending_emul -= size;
>  }
>
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul = g_malloc(hw->size_emul);
> +    hw->pos_emul = hw->pending_emul = 0;
> +}
> +
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
>  {
>      if (hw->buf_emul) {
> @@ -1477,9 +1491,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
>  {
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> +        audio_generic_initialize_buffer_out(hw);
>      }
>
>      *size = MIN(hw->size_emul - hw->pending_emul,
>
> --
> 2.47.1
>
>
>

--000000000000844088062be42cae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Jan 2025=
 at 07:48, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">ak=
ihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">These functions can be used to re-initialize buffers =
when hardware<br>
parameters change due to device hotplug, for example.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@ph=
iljordan.eu">phil@philjordan.eu</a>&gt;<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0audio/audio_int.h |=C2=A0 2 ++<br>
=C2=A0audio/audio.c=C2=A0 =C2=A0 =C2=A0| 24 ++++++++++++++++++------<br>
=C2=A02 files changed, 20 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/audio/audio_int.h b/audio/audio_int.h<br>
index 2d079d00a259..9ba4a144d571 100644<br>
--- a/audio/audio_int.h<br>
+++ b/audio/audio_int.h<br>
@@ -187,9 +187,11 @@ struct audio_pcm_ops {<br>
=C2=A0 =C2=A0 =C2=A0void=C2=A0 =C2=A0(*volume_in)(HWVoiceIn *hw, Volume *vo=
l);<br>
=C2=A0};<br>
<br>
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw);<br>
=C2=A0void audio_generic_run_buffer_in(HWVoiceIn *hw);<br>
=C2=A0void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);<br>
=C2=A0void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t siz=
e);<br>
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw);<br>
=C2=A0void audio_generic_run_buffer_out(HWVoiceOut *hw);<br>
=C2=A0size_t audio_generic_buffer_get_free(HWVoiceOut *hw);<br>
=C2=A0void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);<br>
diff --git a/audio/audio.c b/audio/audio.c<br>
index 87b4e9b6f2f3..17c6bbd0ae9e 100644<br>
--- a/audio/audio.c<br>
+++ b/audio/audio.c<br>
@@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw)<br>
+{<br>
+=C2=A0 =C2=A0 g_free(hw-&gt;buf_emul);<br>
+=C2=A0 =C2=A0 hw-&gt;size_emul =3D hw-&gt;samples * hw-&gt;info.bytes_per_=
frame;<br>
+=C2=A0 =C2=A0 hw-&gt;buf_emul =3D g_malloc(hw-&gt;size_emul);<br>
+=C2=A0 =C2=A0 hw-&gt;pos_emul =3D hw-&gt;pending_emul =3D 0;<br>
+}<br>
+<br>
=C2=A0void audio_generic_run_buffer_in(HWVoiceIn *hw)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (unlikely(!hw-&gt;buf_emul)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;size_emul =3D hw-&gt;samples * hw-&gt;i=
nfo.bytes_per_frame;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;buf_emul =3D g_malloc(hw-&gt;size_emul)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;pos_emul =3D hw-&gt;pending_emul =3D 0;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 audio_generic_initialize_buffer_in(hw);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (hw-&gt;pending_emul &lt; hw-&gt;size_emul) {<br>
@@ -1446,6 +1452,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void=
 *buf, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0hw-&gt;pending_emul -=3D size;<br>
=C2=A0}<br>
<br>
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw)<br>
+{<br>
+=C2=A0 =C2=A0 g_free(hw-&gt;buf_emul);<br>
+=C2=A0 =C2=A0 hw-&gt;size_emul =3D hw-&gt;samples * hw-&gt;info.bytes_per_=
frame;<br>
+=C2=A0 =C2=A0 hw-&gt;buf_emul =3D g_malloc(hw-&gt;size_emul);<br>
+=C2=A0 =C2=A0 hw-&gt;pos_emul =3D hw-&gt;pending_emul =3D 0;<br>
+}<br>
+<br>
=C2=A0size_t audio_generic_buffer_get_free(HWVoiceOut *hw)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (hw-&gt;buf_emul) {<br>
@@ -1477,9 +1491,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)<br>
=C2=A0void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (unlikely(!hw-&gt;buf_emul)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;size_emul =3D hw-&gt;samples * hw-&gt;i=
nfo.bytes_per_frame;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;buf_emul =3D g_malloc(hw-&gt;size_emul)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;pos_emul =3D hw-&gt;pending_emul =3D 0;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 audio_generic_initialize_buffer_out(hw);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0*size =3D MIN(hw-&gt;size_emul - hw-&gt;pending_emul,<b=
r>
<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000844088062be42cae--

