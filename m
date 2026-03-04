Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E3BEC1439
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhGT-0007FF-9d; Wed, 04 Mar 2026 03:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhGR-0007F0-Sp
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhGP-00063y-Dn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE1uUu04m+jTCw0XLYoDcgTP376cY3s6D+xfhfU6hqo=;
 b=K4zbfdXB4+4/EfDmDCpupMT2KgMQZ4LkjubPoBk7MD5tpNDSoZqRdvkrEgNyW5xXZppK8X
 bDNBOE7IKppQcZRzYL/wsX5GgiAJBRnZo7DKG6kXG6UDuZ20aUZ4eOeE1LKUC1DhWDXsAh
 ueF2WSUhCFwV2+d/fh4dTB+aBpHn43Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-rTzovolMOrOev6JlOKwOyQ-1; Wed, 04 Mar 2026 03:07:23 -0500
X-MC-Unique: rTzovolMOrOev6JlOKwOyQ-1
X-Mimecast-MFC-AGG-ID: rTzovolMOrOev6JlOKwOyQ_1772611642
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso30939325a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611642; cv=none;
 d=google.com; s=arc-20240605;
 b=k//hJiH6EDoaQEffqB+GbY+kMqGyM3hAmRKatKN9kjmeEYj2AdOX1VQDXCV9L2tmbP
 UHHU5Z3KX3qm06wzLSLHQmG2FyuHJJmmZh+UeQHw3OC5lAQV/J76BQantOgbARYUrJ6m
 cMh/GqP8QvSJZCnNWX+guiOy/jXKXHSjiYnZV7oC6bWm3SsuT4f6lPqyKrO/Yb7beGIH
 CnCPRxGeuphenn55XcQwXjhc8+/WPkYIf9VclLwxdglvkRDU2saQuWBpm7dFeAdkPQUK
 8bKr8ljOpVz5tzpLdF9pae3WXrwfGhoYjHlQD5mVpkC6YgBKr+b7hGKsBzjAeZHSBcsu
 HS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EE1uUu04m+jTCw0XLYoDcgTP376cY3s6D+xfhfU6hqo=;
 fh=N8PwqrPQD8I/duFeK9Yzjm95bDO7eRRFdg4C+rv6p8c=;
 b=F536o2UFJR4dIv+AsEW3gnEEQDTySLmDEucW0yL/o+YhCMVKAla1+8aldneAs52uST
 aecSydog+/zv8tH+HU+S6nP9W5mPZDWWVqrTZYLeZ+Ld95Uc2JW1kUilktksamdpJ5af
 VLG7GWLJne+WAuY8D6ROrD3dQBnIDeBWprevFwvI4T472YriuFN0vaU4NPaxQ/fa1cyp
 s5LT0K65A4G1Sc/B4dXQxXZaVFOQADPpQExg7CsOQBTXiCAV2gNU00TlIvp6drZEzMvN
 pRkUWhVNp0wY0rnJweybS/fJEu9gKiB6eChe2XxLy3EAKIZdgXRXkQQyfTXCH8eE1/Vh
 5VQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772611642; x=1773216442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EE1uUu04m+jTCw0XLYoDcgTP376cY3s6D+xfhfU6hqo=;
 b=nGDaWde8gE2j4XZCYksvh6YyjP9OlyffyoGfCU1KU/ORVUO8CekOHSnAC3HLdrAejS
 i1hXHk8AoJFmfs1vForxcsE9q3KLRSc9oR5E1+GY4WRI8h/GcdWUHrzGwIH6dqa4C3QZ
 BE6ZQRr6rpz7T3HXe3APuERlydvf3rP483Q4XQLy5HYUwkyOtTPTg3E0T0FK5Wj8zmXm
 akdiX++ki+9dsY7Ejjl4QA7FSggw/GgBHNh/6RlFc7Ne3QBVPq5+u4B/he3Q6Awz4oTn
 U/+MN+SeC9u6UGdRvWXkMMMUVPL1kK2XEYt2UQX3YzTJIn8vU8kVkT2ErqjQpZCG6RRd
 tFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772611642; x=1773216442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EE1uUu04m+jTCw0XLYoDcgTP376cY3s6D+xfhfU6hqo=;
 b=iIeSDevI+PQ+PrEXD5TlbKRQzGiWiHDsQFNAOpyWgCQS7j/P3bHFJVWeWLCi55LQgg
 rQ5lQyOziXzszxgcZ0PvWJ+iA0LYiJzySwjlFWWE/V4zkt14cAI0cnPIBpl7wkSEIyhD
 3Gjy8aPdX+O4eTIETc75yU62Z86+MbvuuATUyLZlvWAKKIP+ActvgyXVwhkwqVjR8QHr
 32Pnr+BRhSlWtj+A0F8y/H90yeCQwMjivViv3QIBH7feE1weoxltA8caHGXnxiybtfVf
 /kX/o1n6wExasJbQgkC8mg8ruUCOQvuKud5jNATWGriK/Y54/dIvt7wR3TsHATPJj5Hj
 4RYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgeES967QxH7c4IAO2Wl5cY3oaJJIAqoCazBjD57VqDQ7iOBmPVpOw6CvLcGk8OmtqC5zy/9fopOP6@nongnu.org
X-Gm-Message-State: AOJu0YziFfDF6rVXHyJRpZvl6jLvVwJcscIx5C0L/q/QjdCNkpMgoamr
 188ssxqyu/pVQX6fngntgIZDQx9txsmYuACSkGw1IQi6e3V/2mYelGFNMB2llN0ZSo6jNl8x59C
 iy8VahcKla9ygwAFq6rGiMxGgUreIkgPnMUtFxWbFinWpVQbe8wbUoZjgmrlcHwPQT2IB/uCmSu
 V0arf6jd3bge6eFAK8ridTqW3RFwfh82M=
X-Gm-Gg: ATEYQzzwIBzZ/tZIurLyF55S5tG7XcrefCgch6lO5vUdNVY/Hay8AVdvpHlIGBapou6
 7GwvoJP3J0nioqOPX2QHEq/NtcaXgbVuXz0aeVL1Jd3jJIPryHQzVC+vx+6xiSRLHFMRNJvOjiz
 aJzrM7ywgDaj69R+oHt2emCUyr/y8BLh+9CFiWt2fWadTeHb9mMQ3J5HSZF2fwpkgqr9aPXC6zH
 G/9pgj/XWtxd4jAi+YCgpgxnqn0hiLFscfW83xHJZRYPlV7t7Hn7LiAZGvgQI5ksxDM2tnJie4Q
 JgCp+cLPWjVGyYDY0KEoRTVn
X-Received: by 2002:a17:90a:d604:b0:354:a284:3fff with SMTP id
 98e67ed59e1d1-359a6a53308mr1307136a91.25.1772611642038; 
 Wed, 04 Mar 2026 00:07:22 -0800 (PST)
X-Received: by 2002:a17:90a:d604:b0:354:a284:3fff with SMTP id
 98e67ed59e1d1-359a6a53308mr1307108a91.25.1772611641601; Wed, 04 Mar 2026
 00:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-3-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-3-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Mar 2026 09:07:10 +0100
X-Gm-Features: AaiRm50YVdpuvsYiUzharOodoYmD7Dzq3JhujcPgVmyk0f2nu-u4SAzhGIcoMi8
Message-ID: <CAMxuvawRx83eNX_LaJAShNDM=m74v2_NX34aLSYwNR0g6cfG5A@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] coreaudio: Improve naming
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 devel@daynix.com
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
> coreaudio had names that are not conforming to QEMU codding style.
> coreaudioVoiceOut also had some members that are prefixed with redundant
> words like "output" or "audio".
> Global names included "out" to tell they are specific to output devices,
> but this rule was not completely enforced.
> The frame size had three different names "frameSize", "bufferFrameSize",
> and "frameCount".
>
> Replace identifiers to fix these problems.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/coreaudio.m | 188 +++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 95 insertions(+), 93 deletions(-)
>
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index bc9ab7477b68..736227eb2b7a 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -43,34 +43,34 @@
>  typedef struct coreaudioVoiceOut {
>      HWVoiceOut hw;
>      pthread_mutex_t buf_mutex;
> -    AudioDeviceID outputDeviceID;
> -    int frameSizeSetting;
> -    uint32_t bufferCount;
> -    UInt32 audioDevicePropertyBufferFrameSize;
> +    AudioDeviceID device_id;
> +    int frame_size_setting;
> +    uint32_t buffer_count;
> +    UInt32 device_frame_size;
>      AudioDeviceIOProcID ioprocid;
>      bool enabled;
> -} coreaudioVoiceOut;
> +} CoreaudioVoiceOut;
>
> -static const AudioObjectPropertyAddress voice_addr =3D {
> +static const AudioObjectPropertyAddress voice_out_addr =3D {
>      kAudioHardwarePropertyDefaultOutputDevice,
>      kAudioObjectPropertyScopeGlobal,
>      kAudioObjectPropertyElementMain
>  };
>
> -static OSStatus coreaudio_get_voice(AudioDeviceID *id)
> +static OSStatus coreaudio_get_voice_out(AudioDeviceID *id)
>  {
>      UInt32 size =3D sizeof(*id);
>
>      return AudioObjectGetPropertyData(kAudioObjectSystemObject,
> -                                      &voice_addr,
> +                                      &voice_out_addr,
>                                        0,
>                                        NULL,
>                                        &size,
>                                        id);
>  }
>
> -static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
> -                                             AudioValueRange *framerange=
)
> +static OSStatus coreaudio_get_out_framesizerange(AudioDeviceID id,
> +                                                 AudioValueRange *framer=
ange)
>  {
>      UInt32 size =3D sizeof(*framerange);
>      AudioObjectPropertyAddress addr =3D {
> @@ -87,7 +87,7 @@ static OSStatus coreaudio_get_framesizerange(AudioDevic=
eID id,
>                                        framerange);
>  }
>
> -static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *frames=
ize)
> +static OSStatus coreaudio_get_out_framesize(AudioDeviceID id, UInt32 *fr=
amesize)
>  {
>      UInt32 size =3D sizeof(*framesize);
>      AudioObjectPropertyAddress addr =3D {
> @@ -104,7 +104,7 @@ static OSStatus coreaudio_get_framesize(AudioDeviceID=
 id, UInt32 *framesize)
>                                        framesize);
>  }
>
> -static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *frames=
ize)
> +static OSStatus coreaudio_set_out_framesize(AudioDeviceID id, UInt32 *fr=
amesize)
>  {
>      UInt32 size =3D sizeof(*framesize);
>      AudioObjectPropertyAddress addr =3D {
> @@ -121,8 +121,8 @@ static OSStatus coreaudio_set_framesize(AudioDeviceID=
 id, UInt32 *framesize)
>                                        framesize);
>  }
>
> -static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
> -                                           AudioStreamBasicDescription *=
d)
> +static OSStatus coreaudio_set_out_streamformat(AudioDeviceID id,
> +                                               AudioStreamBasicDescripti=
on *d)
>  {
>      UInt32 size =3D sizeof(*d);
>      AudioObjectPropertyAddress addr =3D {
> @@ -139,7 +139,7 @@ static OSStatus coreaudio_set_streamformat(AudioDevic=
eID id,
>                                        d);
>  }
>
> -static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result=
)
> +static OSStatus coreaudio_get_out_isrunning(AudioDeviceID id, UInt32 *re=
sult)
>  {
>      UInt32 size =3D sizeof(*result);
>      AudioObjectPropertyAddress addr =3D {
> @@ -243,7 +243,8 @@ static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(OSS=
tatus status,
>  #define coreaudio_playback_logerr(status, ...) \
>      coreaudio_logerr2(status, "playback", __VA_ARGS__)
>
> -static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_na=
me)
> +static int coreaudio_voice_out_buf_lock(CoreaudioVoiceOut *core,
> +                                        const char *fn_name)
>  {
>      int err;
>
> @@ -256,7 +257,8 @@ static int coreaudio_buf_lock(coreaudioVoiceOut *core=
, const char *fn_name)
>      return 0;
>  }
>
> -static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_=
name)
> +static int coreaudio_voice_out_buf_unlock(CoreaudioVoiceOut *core,
> +                                          const char *fn_name)
>  {
>      int err;
>
> @@ -269,20 +271,20 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut *=
core, const char *fn_name)
>      return 0;
>  }
>
> -#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
> -    static ret_type glue(coreaudio_, name)args_decl             \
> -    {                                                           \
> -        coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;      \
> -        ret_type ret;                                           \
> -                                                                \
> -        if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
> -            return 0;                                           \
> -        }                                                       \
> -                                                                \
> -        ret =3D glue(audio_generic_, name)args;                   \
> -                                                                \
> -        coreaudio_buf_unlock(core, "coreaudio_" #name);             \
> -        return ret;                                             \
> +#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args)       \
> +    static ret_type glue(coreaudio_, name)args_decl                   \
> +    {                                                                 \
> +        CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;            =
\
> +        ret_type ret;                                                 \
> +                                                                      \
> +        if (coreaudio_voice_out_buf_lock(core, "coreaudio_" #name)) { \
> +            return 0;                                                 \
> +        }                                                             \
> +                                                                      \
> +        ret =3D glue(audio_generic_, name)args;                         =
\
> +                                                                      \
> +        coreaudio_voice_out_buf_unlock(core, "coreaudio_" #name);     \
> +        return ret;                                                   \
>      }
>  COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>  COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *=
size),
> @@ -298,7 +300,7 @@ static ret_type glue(coreaudio_, name)args_decl      =
       \
>   * callback to feed audiooutput buffer. called without BQL.
>   * allowed to lock "buf_mutex", but disallowed to have any other locks.
>   */
> -static OSStatus audioDeviceIOProc(
> +static OSStatus out_device_ioproc(
>      AudioDeviceID inDevice,
>      const AudioTimeStamp *inNow,
>      const AudioBufferList *inInputData,
> @@ -307,33 +309,33 @@ static OSStatus audioDeviceIOProc(
>      const AudioTimeStamp *inOutputTime,
>      void *hwptr)
>  {
> -    UInt32 frameCount, pending_frames;
> +    UInt32 frame_size, pending_frames;
>      void *out =3D outOutputData->mBuffers[0].mData;
>      HWVoiceOut *hw =3D hwptr;
> -    coreaudioVoiceOut *core =3D hwptr;
> +    CoreaudioVoiceOut *core =3D hwptr;
>      size_t len;
>
> -    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
> +    if (coreaudio_voice_out_buf_lock(core, "out_device_ioproc")) {
>          inInputTime =3D 0;
>          return 0;
>      }
>
> -    if (inDevice !=3D core->outputDeviceID) {
> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
> +    if (inDevice !=3D core->device_id) {
> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(old devi=
ce)");
>          return 0;
>      }
>
> -    frameCount =3D core->audioDevicePropertyBufferFrameSize;
> +    frame_size =3D core->device_frame_size;
>      pending_frames =3D hw->pending_emul / hw->info.bytes_per_frame;
>
>      /* if there are not enough samples, set signal and return */
> -    if (pending_frames < frameCount) {
> +    if (pending_frames < frame_size) {
>          inInputTime =3D 0;
> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(empty)")=
;
>          return 0;
>      }
>
> -    len =3D frameCount * hw->info.bytes_per_frame;
> +    len =3D frame_size * hw->info.bytes_per_frame;
>      while (len) {
>          size_t write_len, start;
>
> @@ -349,16 +351,16 @@ static OSStatus audioDeviceIOProc(
>          out +=3D write_len;
>      }
>
> -    coreaudio_buf_unlock(core, "audioDeviceIOProc");
> +    coreaudio_voice_out_buf_unlock(core, "out_device_ioproc");
>      return 0;
>  }
>
> -static OSStatus init_out_device(coreaudioVoiceOut *core)
> +static OSStatus init_out_device(CoreaudioVoiceOut *core)
>  {
> +    AudioValueRange value_range;
>      OSStatus status;
> -    AudioValueRange frameRange;
>
> -    AudioStreamBasicDescription streamBasicDescription =3D {
> +    AudioStreamBasicDescription stream_basic_description =3D {
>          .mBitsPerChannel =3D audio_format_bits(core->hw.info.af),
>          .mBytesPerFrame =3D core->hw.info.bytes_per_frame,
>          .mBytesPerPacket =3D core->hw.info.bytes_per_frame,
> @@ -369,21 +371,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>          .mSampleRate =3D core->hw.info.freq
>      };
>
> -    status =3D coreaudio_get_voice(&core->outputDeviceID);
> +    status =3D coreaudio_get_voice_out(&core->device_id);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not get default output device")=
;
>          return status;
>      }
> -    if (core->outputDeviceID =3D=3D kAudioDeviceUnknown) {
> +    if (core->device_id =3D=3D kAudioDeviceUnknown) {
>          error_report("coreaudio: Could not initialize playback: "
>                       "Unknown audio device");
>          return status;
>      }
>
>      /* get minimum and maximum buffer frame sizes */
> -    status =3D coreaudio_get_framesizerange(core->outputDeviceID,
> -                                          &frameRange);
> +    status =3D coreaudio_get_out_framesizerange(core->device_id, &value_=
range);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -393,34 +394,34 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>          return status;
>      }
>
> -    if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMinimum=
;
> +    if (value_range.mMinimum > core->frame_size_setting) {
> +        core->device_frame_size =3D value_range.mMinimum;
>          warn_report("coreaudio: Upsizing buffer frames to %f",
> -                    frameRange.mMinimum);
> -    } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMaximum=
;
> +                    value_range.mMinimum);
> +    } else if (value_range.mMaximum < core->frame_size_setting) {
> +        core->device_frame_size =3D value_range.mMaximum;
>          warn_report("coreaudio: Downsizing buffer frames to %f",
> -                    frameRange.mMaximum);
> +                    value_range.mMaximum);
>      } else {
> -        core->audioDevicePropertyBufferFrameSize =3D core->frameSizeSett=
ing;
> +        core->device_frame_size =3D core->frame_size_setting;
>      }
>
>      /* set Buffer Frame Size */
> -    status =3D coreaudio_set_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFra=
meSize);
> +    status =3D coreaudio_set_out_framesize(core->device_id,
> +                                         &core->device_frame_size);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not set device buffer frame siz=
e %" PRIu32,
> -                                  (uint32_t)core->audioDevicePropertyBuf=
ferFrameSize);
> +                                  (uint32_t)core->device_frame_size);
>          return status;
>      }
>
>      /* get Buffer Frame Size */
> -    status =3D coreaudio_get_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFra=
meSize);
> +    status =3D coreaudio_get_out_framesize(core->device_id,
> +                                         &core->device_frame_size);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -429,19 +430,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>                                    "Could not get device buffer frame siz=
e");
>          return status;
>      }
> -    core->hw.samples =3D core->bufferCount * core->audioDevicePropertyBu=
fferFrameSize;
> +    core->hw.samples =3D core->buffer_count * core->device_frame_size;
>
>      /* set Samplerate */
> -    status =3D coreaudio_set_streamformat(core->outputDeviceID,
> -                                        &streamBasicDescription);
> +    status =3D coreaudio_set_out_streamformat(core->device_id,
> +                                            &stream_basic_description);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not set samplerate %lf",
> -                                  streamBasicDescription.mSampleRate);
> -        core->outputDeviceID =3D kAudioDeviceUnknown;
> +                                  stream_basic_description.mSampleRate);
> +        core->device_id =3D kAudioDeviceUnknown;
>          return status;
>      }
>
> @@ -456,8 +457,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *co=
re)
>       * with the callers of AudioObjectGetPropertyData.
>       */
>      core->ioprocid =3D NULL;
> -    status =3D AudioDeviceCreateIOProcID(core->outputDeviceID,
> -                                       audioDeviceIOProc,
> +    status =3D AudioDeviceCreateIOProcID(core->device_id,
> +                                       out_device_ioproc,
>                                         &core->hw,
>                                         &core->ioprocid);
>      if (status =3D=3D kAudioHardwareBadDeviceError) {
> @@ -465,20 +466,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>      }
>      if (status !=3D kAudioHardwareNoError || core->ioprocid =3D=3D NULL)=
 {
>          coreaudio_playback_logerr(status, "Could not set IOProc");
> -        core->outputDeviceID =3D kAudioDeviceUnknown;
> +        core->device_id =3D kAudioDeviceUnknown;
>          return status;
>      }
>
>      return 0;
>  }
>
> -static void fini_out_device(coreaudioVoiceOut *core)
> +static void fini_out_device(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
>      UInt32 isrunning;
>
>      /* stop playback */
> -    status =3D coreaudio_get_isrunning(core->outputDeviceID, &isrunning)=
;
> +    status =3D coreaudio_get_out_isrunning(core->device_id, &isrunning);
>      if (status !=3D kAudioHardwareBadObjectError) {
>          if (status !=3D kAudioHardwareNoError) {
>              coreaudio_logerr(status,
> @@ -486,7 +487,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
>          }
>
>          if (isrunning) {
> -            status =3D AudioDeviceStop(core->outputDeviceID, core->iopro=
cid);
> +            status =3D AudioDeviceStop(core->device_id, core->ioprocid);
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D =
kAudioHardwareNoError) {
>                  coreaudio_logerr(status, "Could not stop playback");
>              }
> @@ -494,20 +495,20 @@ static void fini_out_device(coreaudioVoiceOut *core=
)
>      }
>
>      /* remove callback */
> -    status =3D AudioDeviceDestroyIOProcID(core->outputDeviceID,
> +    status =3D AudioDeviceDestroyIOProcID(core->device_id,
>                                          core->ioprocid);
>      if (status !=3D kAudioHardwareBadDeviceError && status !=3D kAudioHa=
rdwareNoError) {
>          coreaudio_logerr(status, "Could not remove IOProc");
>      }
> -    core->outputDeviceID =3D kAudioDeviceUnknown;
> +    core->device_id =3D kAudioDeviceUnknown;
>  }
>
> -static void update_device_playback_state(coreaudioVoiceOut *core)
> +static void update_out_device_playback_state(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
>      UInt32 isrunning;
>
> -    status =3D coreaudio_get_isrunning(core->outputDeviceID, &isrunning)=
;
> +    status =3D coreaudio_get_out_isrunning(core->device_id, &isrunning);
>      if (status !=3D kAudioHardwareNoError) {
>          if (status !=3D kAudioHardwareBadObjectError) {
>              coreaudio_logerr(status,
> @@ -520,7 +521,7 @@ static void update_device_playback_state(coreaudioVoi=
ceOut *core)
>      if (core->enabled) {
>          /* start playback */
>          if (!isrunning) {
> -            status =3D AudioDeviceStart(core->outputDeviceID, core->iopr=
ocid);
> +            status =3D AudioDeviceStart(core->device_id, core->ioprocid)=
;
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D =
kAudioHardwareNoError) {
>                  coreaudio_logerr(status, "Could not resume playback");
>              }
> @@ -528,7 +529,7 @@ static void update_device_playback_state(coreaudioVoi=
ceOut *core)
>      } else {
>          /* stop playback */
>          if (isrunning) {
> -            status =3D AudioDeviceStop(core->outputDeviceID,
> +            status =3D AudioDeviceStop(core->device_id,
>                                       core->ioprocid);
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D =
kAudioHardwareNoError) {
>                  coreaudio_logerr(status, "Could not pause playback");
> @@ -538,22 +539,22 @@ static void update_device_playback_state(coreaudioV=
oiceOut *core)
>  }
>
>  /* called without BQL. */
> -static OSStatus handle_voice_change(
> +static OSStatus handle_voice_out_change(
>      AudioObjectID in_object_id,
>      UInt32 in_number_addresses,
>      const AudioObjectPropertyAddress *in_addresses,
>      void *in_client_data)
>  {
> -    coreaudioVoiceOut *core =3D in_client_data;
> +    CoreaudioVoiceOut *core =3D in_client_data;
>
>      bql_lock();
>
> -    if (core->outputDeviceID) {
> +    if (core->device_id) {
>          fini_out_device(core);
>      }
>
>      if (!init_out_device(core)) {
> -        update_device_playback_state(core);
> +        update_out_device_playback_state(core);
>      }
>
>      bql_unlock();
> @@ -563,7 +564,7 @@ static OSStatus handle_voice_change(
>  static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>  {
>      OSStatus status;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>      int err;
>      Audiodev *dev =3D hw->s->dev;
>      AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
> @@ -581,13 +582,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struc=
t audsettings *as)
>      as->fmt =3D AUDIO_FORMAT_F32;
>      audio_pcm_init_info(&hw->info, as);
>
> -    core->frameSizeSetting =3D audio_buffer_frames(
> +    core->frame_size_setting =3D audio_buffer_frames(
>          qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610)=
;
>
> -    core->bufferCount =3D cpdo->has_buffer_count ? cpdo->buffer_count : =
4;
> +    core->buffer_count =3D cpdo->has_buffer_count ? cpdo->buffer_count :=
 4;
>
>      status =3D AudioObjectAddPropertyListener(kAudioObjectSystemObject,
> -                                            &voice_addr, handle_voice_ch=
ange,
> +                                            &voice_out_addr,
> +                                            handle_voice_out_change,
>                                              core);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
> @@ -597,8 +599,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct =
audsettings *as)
>
>      if (init_out_device(core)) {
>          status =3D AudioObjectRemovePropertyListener(kAudioObjectSystemO=
bject,
> -                                                   &voice_addr,
> -                                                   handle_voice_change,
> +                                                   &voice_out_addr,
> +                                                   handle_voice_out_chan=
ge,
>                                                     core);
>          if (status !=3D kAudioHardwareNoError) {
>              coreaudio_playback_logerr(status,
> @@ -615,11 +617,11 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>  {
>      OSStatus status;
>      int err;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>
>      status =3D AudioObjectRemovePropertyListener(kAudioObjectSystemObjec=
t,
> -                                               &voice_addr,
> -                                               handle_voice_change,
> +                                               &voice_out_addr,
> +                                               handle_voice_out_change,
>                                                 core);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_logerr(status, "Could not remove voice property change=
 listener");
> @@ -636,10 +638,10 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>
>  static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>  {
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>
>      core->enabled =3D enable;
> -    update_device_playback_state(core);
> +    update_out_device_playback_state(core);
>  }
>
>  static void audio_coreaudio_class_init(ObjectClass *klass, const void *d=
ata)
>
> --
> 2.53.0
>


