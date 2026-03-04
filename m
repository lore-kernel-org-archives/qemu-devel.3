Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C56EB7EA0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhKQ-0000SW-4q; Wed, 04 Mar 2026 03:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhKK-0000R3-2V
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhKI-0006kz-7J
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynxTwUrd9XYU2u/xup18B6wE2ZoqMEa4HIe89y02Nco=;
 b=GeBACJHiOeaqCoXFvJSZ6eIBQ9FsrGMy+AGtID8nMJtp83FbDnrqSX4YCPdWvWuE93Xy5K
 wK3oSTM6QsIsyixpYxYs6IfgRgl/+x1w3Nx8gaGAW1icEsK6u7EtKtE3yJouyVIUOiWjaP
 QNvvPfQNixvqNocoLZwcPw61X8wdCbA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-2yVC03aUMqS68aVIzHUoKg-1; Wed, 04 Mar 2026 03:11:23 -0500
X-MC-Unique: 2yVC03aUMqS68aVIzHUoKg-1
X-Mimecast-MFC-AGG-ID: 2yVC03aUMqS68aVIzHUoKg_1772611882
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ae59e057f1so32450655ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611882; cv=none;
 d=google.com; s=arc-20240605;
 b=XkuUCXAeyOQxHTBWiWD6Brv/XsWYRZx2JN+pt5A2ljJqiKUMEwXdy5OYThA+LYDMjR
 w3jHMayMy2VmY08mUdGU8WbSsAaoZOPOJNaG+8+OD0tXBqVhvWUv9CT6mYzzPC5q8nLG
 q9zdV1p8+DIvI+8OSwpk7O4ov9nzP9f6NK71Jx5zuyVBZfunw+n9dRgePUwygGb4M9Hx
 MDt2do+anwdxs1sARXRvhjwydtRGbjVyMuwWuaevy3a0MvCzg82n6kOMbrCuGX9NkP5/
 crHOvLpRbZINZsFbzrPWm+k/8bcjheJ0g4VGKCsCN/2L7D5TN0HZyB5SNb/nRrAjd18Z
 D4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ynxTwUrd9XYU2u/xup18B6wE2ZoqMEa4HIe89y02Nco=;
 fh=peBri4/zZVpPm8ha0ga5WJF3wBYaGMFfBNTR07Fh5jE=;
 b=XxO3uANmbUXIFft1Eza9/quQAPq7JbUMyqFWZK2M/q+4QWydAwjaZ8TQTjAS/Wy3Uo
 wdkX0b1+6NbkfMxcsd0m6Wla3EFz6Lh5J3bGkaEdo3q0asRgqIDa/A/Ig9/yEAOZNJUZ
 YXu/D8IOGb40P8GGgpNeVNCXjurU71gjWW/vw5MifHAjROLN4Zlka/4jGGPKVfg/hKHr
 izjUPzIB0NWML7Hj/HQmRYYMCMSgG1GbtWM3sBluOsie834/al75rbsIwdpRfOeMABrZ
 gNsliojd3kv7tj6d1cxcuU0gYGtQyqlqAGYgaEQh88av0Xp8zB5rxkb9t+W7f8XMSERf
 DOTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772611882; x=1773216682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynxTwUrd9XYU2u/xup18B6wE2ZoqMEa4HIe89y02Nco=;
 b=CnXOgEMjSyycLrPNYMjQWoOzgGRJ05hC3P0lu7jKeiju70z9Tl+eiRzLU+fEtJpbN6
 uAJJUBM9gh2YVDqOSSU96HYe6aWu8DcU66dZDEKpceuEN1Pkn9FDplnrS96mzWJt6lQ8
 tnKLiERLI/QEUFAzQoqebIZHuafywDwq39JhJ6e3iVndZpRlj6FadiOWit38H1HhBjqD
 XIO9tBfgwRI9pHhbVesRAWHN24pmIGfmLGtsXrZawEaNGZZ2PznmMH3NVOCNnJD4y3lm
 hmQboRcxeoZ03JaMbtLtd+PEyP/VFxNoNQ2Zo8VixL7Z2ux19+qm/UZGPF56j/slYFli
 iW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772611882; x=1773216682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ynxTwUrd9XYU2u/xup18B6wE2ZoqMEa4HIe89y02Nco=;
 b=FqpQamSbc1frw3zkIXFSqwdxWYEHZBRZHraJyijQkftc0+FKqaeJ7N3XJUXfn0hq5/
 sc7tNEh1OZodUQmjjXP+AUkqjgPn8/Yz90YkpIRoOQQr1+q6tYL+++grvI9CGNbELsJc
 GvXqz1x2a8dRiNgGClmqL/WQc67Pw7mdzVLSpIghr0CsydxWmSTmmi9g0DPnm/R4kcF3
 Me1TWWBIRCt8624UuSsKTYrDFiGZI56aCbL4gxwkNMW0dFFsvT/KoTj6h2evPXcMVrnk
 hUCCoj+MwZBRjAHVHUgMtq7Iv501F1TAyxNA3R9eMQXw8tvvjOr2LvxzJejRp3T2eqqX
 6YEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVilTN9GaLjA/Xxf869NtnA+UlopmFXXljp0cRfwtxaaURlvGcn/0r0eAvsaC5Hwi7Yp73lRQQcyRlT@nongnu.org
X-Gm-Message-State: AOJu0YxPfsIh9QwmFlhOFkZLoZ3vzsnyOqCVHoY/mzo1A65lMzD8iXMj
 sjud+sXQ7iClncCGbSdCyHPu7urRXHAryPmArNHZXFaYZEfU8ieJnt0GT0N0HQelfj54LcCJG3j
 32I7m34RDZ8Iu1SRB98RSqF1HIMx6/imDKDSp7QnQ/z8i6+V3kCNdQEXjcNObtQJOxQRZ0q3lEx
 gMNZHBYHZGlkFGQr16aQh5cKEgWy6VdL9qFY1WXziHfw==
X-Gm-Gg: ATEYQzxFqElinrYkFOmmlL1y4czru20FeyunGSexZ3/mpjF+xlEtP7WpbHmtzIRSO8z
 In2WO+/Oqdcc+L2e43qnWvG41IXE8/YQnJMIQrXiyn4TnrbK8XnfVLQVubBpMkqECvLdlz1/VFZ
 nlLdfI5zUyxju3oiWbBxW3HS/5dBH9D6WBYAV307QZVDNXgQXG+kbCAPciauvYKO5qqd0wI68LX
 tc078VQp84J6wSKDjxXXl2UoB6KLGoevIUrEfZjxiVw/eRKQVkmGDCxvAWjRmWddL05DCCQ19xk
 9oR13Tko0ztu1vNk0JPly6Nu
X-Received: by 2002:a17:902:ebc6:b0:2aa:e3c2:f925 with SMTP id
 d9443c01a7336-2ae6aa8f904mr11989535ad.34.1772611881692; 
 Wed, 04 Mar 2026 00:11:21 -0800 (PST)
X-Received: by 2002:a17:902:ebc6:b0:2aa:e3c2:f925 with SMTP id
 d9443c01a7336-2ae6aa8f904mr11989395ad.34.1772611881335; Wed, 04 Mar 2026
 00:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Mar 2026 09:11:09 +0100
X-Gm-Features: AaiRm53tQWBthFELIriF-pGQ0dy8twU2_TvF4iJkzdOtBDdtIKoWtwxqhFC9aA4
Message-ID: <CAMxuvazpuFWh4swznXdup4F6=ueP8p_RDGxB68PP9RV1TQnw=Q@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] audio: Add functions to initialize buffers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 4, 2026 at 7:17=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> These functions can be used to re-initialize buffers when hardware
> parameters change due to device hotplug, for example.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/audio_int.h       |  2 ++
>  audio/audio-mixeng-be.c | 24 ++++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 06f79ade6b0a..290cf373b49f 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -141,9 +141,11 @@ static inline void *advance(void *p, size_t incr)
>  int wav_start_capture(AudioBackend *state, CaptureState *s, const char *=
path,
>                        int freq, int bits, int nchannels);
>
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
>  void audio_generic_run_buffer_in(HWVoiceIn *hw);
>  void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
>  void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
>  void audio_generic_run_buffer_out(HWVoiceOut *hw);
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 370404505111..1419e7521503 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -1187,14 +1187,20 @@ void audio_run(AudioMixengBackend *s, const char =
*msg)
>      }
>  }
>
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul =3D hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul =3D g_malloc(hw->size_emul);
> +    hw->pos_emul =3D hw->pending_emul =3D 0;
> +}
> +
>  void audio_generic_run_buffer_in(HWVoiceIn *hw)
>  {
>      AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s)=
;
>
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul =3D hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul =3D g_malloc(hw->size_emul);
> -        hw->pos_emul =3D hw->pending_emul =3D 0;
> +        audio_generic_initialize_buffer_in(hw);
>      }
>
>      while (hw->pending_emul < hw->size_emul) {
> @@ -1227,6 +1233,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, vo=
id *buf, size_t size)
>      hw->pending_emul -=3D size;
>  }
>
> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul =3D hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul =3D g_malloc(hw->size_emul);
> +    hw->pos_emul =3D hw->pending_emul =3D 0;
> +}
> +
>  size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
>  {
>      if (hw->buf_emul) {
> @@ -1260,9 +1274,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
>  void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
>  {
>      if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul =3D hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul =3D g_malloc(hw->size_emul);
> -        hw->pos_emul =3D hw->pending_emul =3D 0;
> +        audio_generic_initialize_buffer_out(hw);
>      }
>
>      *size =3D MIN(hw->size_emul - hw->pending_emul,
>
> --
> 2.53.0
>


