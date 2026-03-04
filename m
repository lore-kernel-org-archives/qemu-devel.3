Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD70BEA4E27
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhFc-0006pD-Hr; Wed, 04 Mar 2026 03:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhFZ-0006ov-TN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhFW-00060I-R1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfyargUyCzZdJEnEub4ucfSm+PK5oI2bmxzbN0yQPqE=;
 b=QrLL7lximCW5dqIn0Eo5NxHG9AOilpCrz+Ev6ZIq/0WcwgyVUNymea31dew+e+TzkWAsoC
 CjM7rxQxkr2kmGwW2twjSAkx8amrlBA7MezvoI0ZR+RubQ+3MG+JdclHAP1p/AOx/e4k5z
 ftU16lfOVbk1G1deg7KnhQvfHZGMcP8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-rqXtEWM7ODKXC0Rt7HxSGQ-1; Wed, 04 Mar 2026 03:06:27 -0500
X-MC-Unique: rqXtEWM7ODKXC0Rt7HxSGQ-1
X-Mimecast-MFC-AGG-ID: rqXtEWM7ODKXC0Rt7HxSGQ_1772611586
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35984b91ffeso3156971a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:06:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611586; cv=none;
 d=google.com; s=arc-20240605;
 b=RgOUv3Yh6A9gshfDNsuVbFbTvx9zcpTN3D0qzpNOWH8vLqW8HrAzSaWeDiVi9CdEly
 uSnu0tXYmzsYvFy64uvN75upP7Rhynlw+ZfMFeRqYFJF5wROhJI9MXvnWU3CCJ7xq6Uo
 0/nXvnoFQbvlhuf41bCy9+EzyH5EathiLuX5NbdYzBMVP0pYliXeWSnNSZ2Txu2HINSw
 FIIUVaqNuDIMAQBnlK/13djKRRXdU2CfEyUF2HAFNBc9UGi7H2wUQUOQWMgt90PJMzRd
 5t6PGpX08yOjZI0yWZLx+6VQc6aclhPfsvY/Ph1IvmJXPD+Jof3/0M90quOIcCRK8Us2
 7CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EfyargUyCzZdJEnEub4ucfSm+PK5oI2bmxzbN0yQPqE=;
 fh=KRluflmi68tXtbmYPeJrDmKILnFAFAksDyNGDwIZAYY=;
 b=VzgEf3XkhSyoNStYSxlWK8PoOiuL3BZMS7Y+796xDHO0J22Zgt/0PxCokW0o8mgdyy
 SfsgwkNzUOpk7+mKg6B90vB0HHrjQjWnpw88QaNLYMtGznZjytgQwMIr7glJpOozyGTF
 1DHZ/8aayq22XyxCvK3+SKm8h3mcwSrvl8fn6fdIe32NW5ZlUfVwDbtUR0pDtTr8h1ao
 fdh5BmSiTzqkdQxegpjsgCSLO1e0uQqncWLyrmZUL4L4O4vpL+5uZ55C+h63jYh3wJ1S
 ILj6UUu1wYGYr4q5TdlDOHCmViABU1fgpuzCZxV5wZZiFt3XAIuHbnt/T7He7Kh+Dn56
 PAuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772611586; x=1773216386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfyargUyCzZdJEnEub4ucfSm+PK5oI2bmxzbN0yQPqE=;
 b=nfz2pT78H38v38sUmP35A9peS43MPnW15v2eAxAvb6MVHDAbrqhj2UC3OCXUvYOyhU
 ++AH91d0JixpDnbMUYfS+EilNTG5KeVQu4scev3dIVfVGyJB/FdDDm42V7zFQeVfMegR
 NAA6r8xcy4mV7DVRI82aUG2fD1yVgkzQatnMrqBqOb5RljC7Zp1dJ/04sYMPM12FA+Nm
 8XHU9QlERRavCjzYBdrUpr4mNX5GYtHWycms763P8DuXhVBKQjy6I7aWvbh7UBWFuZBm
 3+44wo8qqgLsgbs7A8rSWEXLV7XI7KSnDkwUSwsdMMCZXoignSN09jo03m2jpXBeGE4A
 tOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772611586; x=1773216386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EfyargUyCzZdJEnEub4ucfSm+PK5oI2bmxzbN0yQPqE=;
 b=IFgvvEtVulbfKirP6KP+1GlKI7gVMnQ5ek+FFo2mpVzLFg+fhcHRZebxGCwdjpkBrf
 brCwaaRS0MkECjWd71PeJhUHFnBTR4YP25DD2cf8hRBYTnmiy4X7dwaqBO8sIpz7KlD4
 ETCbbbdxytcn15AOa4xodkOZYpJoFs6647K4VQJVp848k2PSGhwG8LDz1embz6nVmedp
 kOsb0YfOUMKf+OvJPsRZlsOyFqmTmgP1aln0FckNxUQxsEUKiNuQgh+5lboS/RUsx4t+
 ZjDqjFs8NCBCgf1WNhVNOCFulqGGAlKRPFlje+dLTjxamF3RYBiq5ukEJFjo9pa5mDYg
 2SOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJE+Qd5G39EKSHarNv6pGdW0fDbHVj+OMz5CfZf8qEgQD5+O6GvCeBNWRAHUZMRGxejfC2U1QyBBWe@nongnu.org
X-Gm-Message-State: AOJu0YzzpPw9olKS8RTTlh3mFBgWg1a2h+oVllAViZ3YY6Qhbr9/5Q4x
 39zjjgFIkTNM38asMn0paxzjeOltIt0OANJFwt9p9FjnOa17tPdixYUiL9Pjqu/FDjwY5fMgHqm
 /ZEJ8l+XrtjEgM2vunpI7P6HExXZ9L+jGIT0J17ZXsONlNmDnvKhYJS0NqBSSOmPOTPvhCXRjiO
 +YtXHHuy0BskDGIjSIHv/qyKh+7/Qc0Fk=
X-Gm-Gg: ATEYQzzIeIhQmgtUtwotfOQ5pZMKkaAXWqoCY+mAL3bhieKfuVcONop8kI9trEbSt2G
 JBoAHVkI7KYZlMPWEtIuO7hgt5d4FodlN+211Rz8tAv2nNaStlERz0lP7qa+jpfK52P2Kk3kh6W
 K81qoxVPNYOPlwOe7hW1A8SwxxT3XHhZRFdQCv/G8H9q0SAT+Wykk4cJ4CjgRfc4g9pTiVDsS08
 phDBvLJ8pC4QSfPMn2E2XWiViwxxlcFxKC/nzG9ze+oYRV0VawJ2Y8HhpMB4+7oKyyOO54C86fu
 BAHTm5hrtCLqRU5eiCeNbVNp
X-Received: by 2002:a17:90b:3ec2:b0:352:ece8:1f6c with SMTP id
 98e67ed59e1d1-3599ce32f97mr4499100a91.8.1772611586395; 
 Wed, 04 Mar 2026 00:06:26 -0800 (PST)
X-Received: by 2002:a17:90b:3ec2:b0:352:ece8:1f6c with SMTP id
 98e67ed59e1d1-3599ce32f97mr4499073a91.8.1772611585994; Wed, 04 Mar 2026
 00:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-2-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-2-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Mar 2026 09:06:14 +0100
X-Gm-Features: AaiRm522LLrYt0uJPSXjtWbEJibKV2czxstN11uWxodkZ2ECuUFUAyQQDL5H9gE
Message-ID: <CAMxuvayPDhO3_ciFx4+mSPgX4y94bM50811h+wCXsZaaQrifpw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] coreaudio: Remove extra whitespaces
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Remove extra whitespaces around parentheses.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/coreaudio.m | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index cbda4f143698..bc9ab7477b68 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -272,7 +272,7 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut *co=
re, const char *fn_name)
>  #define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
>      static ret_type glue(coreaudio_, name)args_decl             \
>      {                                                           \
> -        coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;     \
> +        coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;      \
>          ret_type ret;                                           \
>                                                                  \
>          if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
> @@ -313,13 +313,13 @@ static OSStatus audioDeviceIOProc(
>      coreaudioVoiceOut *core =3D hwptr;
>      size_t len;
>
> -    if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
> +    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
>          inInputTime =3D 0;
>          return 0;
>      }
>
>      if (inDevice !=3D core->outputDeviceID) {
> -        coreaudio_buf_unlock (core, "audioDeviceIOProc(old device)");
> +        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
>          return 0;
>      }
>
> @@ -329,7 +329,7 @@ static OSStatus audioDeviceIOProc(
>      /* if there are not enough samples, set signal and return */
>      if (pending_frames < frameCount) {
>          inInputTime =3D 0;
> -        coreaudio_buf_unlock (core, "audioDeviceIOProc(empty)");
> +        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
>          return 0;
>      }
>
> @@ -349,7 +349,7 @@ static OSStatus audioDeviceIOProc(
>          out +=3D write_len;
>      }
>
> -    coreaudio_buf_unlock (core, "audioDeviceIOProc");
> +    coreaudio_buf_unlock(core, "audioDeviceIOProc");
>      return 0;
>  }
>
> @@ -563,7 +563,7 @@ static OSStatus handle_voice_change(
>  static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>  {
>      OSStatus status;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;
> +    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
>      int err;
>      Audiodev *dev =3D hw->s->dev;
>      AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
> @@ -579,7 +579,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct =
audsettings *as)
>      obt_as =3D *as;
>      as =3D &obt_as;
>      as->fmt =3D AUDIO_FORMAT_F32;
> -    audio_pcm_init_info (&hw->info, as);
> +    audio_pcm_init_info(&hw->info, as);
>
>      core->frameSizeSetting =3D audio_buffer_frames(
>          qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610)=
;
> @@ -615,7 +615,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>  {
>      OSStatus status;
>      int err;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;
> +    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
>
>      status =3D AudioObjectRemovePropertyListener(kAudioObjectSystemObjec=
t,
>                                                 &voice_addr,
> @@ -636,7 +636,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>
>  static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>  {
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;
> +    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
>
>      core->enabled =3D enable;
>      update_device_playback_state(core);
>
> --
> 2.53.0
>


