Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0772CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclgy-0007bw-7e; Thu, 25 Jun 2026 11:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wclgw-0007bJ-18
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wclgs-0005Js-Lh
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782400106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J71JpUdzFcWjKO3UUnTc9b2EhVPfxl53UMwuY+uK0lA=;
 b=GcaZaToGu3GnQ+nz7AZJKw9FM96EwCLMLLIwehRc2pAlq0HPhmLq7bGUBDV+HYglF6Zc4D
 wQMU6X2sOSEtlMtHAk+JJtj1zTekesSjPYaUVquqts71FlES28WI/2dj6PiE6/F6pwfl7x
 GGsMSC2HskLcW/7QAFg4ps6fV37kb8A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-c8N7br0iPLyvrUCeUY1FbA-1; Thu, 25 Jun 2026 11:08:24 -0400
X-MC-Unique: c8N7br0iPLyvrUCeUY1FbA-1
X-Mimecast-MFC-AGG-ID: c8N7br0iPLyvrUCeUY1FbA_1782400103
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c6afd85980so94365ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782400103; cv=none;
 d=google.com; s=arc-20260327;
 b=mIlAZMSlALHFKarBgGaWpTlFjPfRSqAoC3kAQ1OMETzYrm1ypv/rQLKlxTR9loHNxq
 FPR/0F6b0PMaiwpVD4NrYnW0roWVRdPNps+FeHmH4yYoX80JItlc0E/SZzrVQCFXmJ9O
 LU4VhVlG7jr6ZbnY+dHPb4ZXtJ/IG9AxEmq3wEUgUOTtuQqkYBUDG9wKoOs9BsK4AGgj
 i9TkCp+mYYmBy2/o2wckXsKk2DF0ufyMeln61qka+0cSH4Y9yb6kie37ZaBljizdNBYb
 ffi2hXRlLTHL7Tssbye9SIkEjaqH9JmgcA80r5sbs0XFYZLn1mV68PhRw7hqSNzwA5u4
 GJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J71JpUdzFcWjKO3UUnTc9b2EhVPfxl53UMwuY+uK0lA=;
 fh=hkOusoeKc8PCl0Yn6QlFFaPHii4AiIXes1zW8G0IFjE=;
 b=I28xPMIK0vBmqT26cNwvrF2MlDgwhRj70ssAHRuec/0GzD637zUjuiRSljNaAIDdwf
 IYTS508tjfqDFVpk/Lc8fGqSfzlObhW+oI0NI4HZmS/Fa0W+B7dSFdZ8s/U6oOWbqZwB
 E8Z9gGfsNsfiiCrhcz66IrE/MpUk0zIetRz+txIhGOavISOv1xl50t9a8poEcVowdV0p
 KqFAv8Gs9E5uLmhnuSEueBP/lNWpEpRhNf79iNndS18IyrERU5eJAuz3X1QDpx1mTFeb
 mcFytKtnRMsNWNBAwbcFp22CXYK7XIMd3rgqbkXMVNK+GVgqeQPk2XmFLPhJOeldHKfk
 c5Mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782400103; x=1783004903; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J71JpUdzFcWjKO3UUnTc9b2EhVPfxl53UMwuY+uK0lA=;
 b=oXeIRYjMGZ51gP1F41u7aksGauEuEHo+ygiAzDPJEpXfsCxjBmEx/jQXyHjqFWda+Q
 OSq87D+Ih4rJHL8HlqpeoKVjduuPKmQYQfjznyXHj7anRvlC04I99EgXMMZHzX57t2LX
 qGkMJAkbBpIdM2XPfu8B1BhRqcqhTnoT5OFzKYsbxnnDq2OFLIjYops0vRmE1BHg15Lx
 A7Wg8x/My+hc6MXS4DXdWRhri/Jj202KPdNogqw+BZ3bwGQxdSqAgqeMeSrRIzpRsOzr
 W7nBHXnmCe9nyFIHTFAEURCTJfM8Fp2TlfVF1dsEXJVFJ51LwRzzp5YjfFvJR8L43kJP
 fgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782400103; x=1783004903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J71JpUdzFcWjKO3UUnTc9b2EhVPfxl53UMwuY+uK0lA=;
 b=oaiJ6k6W4X3lhKJAjVxDwnAgK7MzxHcsGzT3AlE2uw4QUuyjEG24jBJbRTGVuzfqms
 tYxnC7E7I+ZVB0YSsZSkRtn1pnki3O4H+pyMyianYi5r/fmxtaTAS3nE6GuY4M/yJdMW
 MCN7dBtN85PBGeoS9lmMVogg5SNUg7u8WwSMmhiuBE4RjlvICSKHzLx1TZtJTs/uuEHX
 WDoDOk0C2/2eFx8C/PoAQ3zEw17kb8LmhZjgFD44lpGApzpdixGBv4t+VTpCByXwPOJA
 4PnPwNrodX9aHcUkjDOosl2y6mYra4KXZLBEuEyOyrfuRewZJbSEQbNdEuBCyGOV1Dzv
 G5Nw==
X-Gm-Message-State: AOJu0YziLK0zuDU/ZrlP+FXHXBLB39qOic3k7gLJJ7K2QbiFw7irMQ2g
 Fnx81nDGAfko+Z2Df4kk2JwyOo75HhlGfcfBC1mqNvzsvch/Ev4kn4ycNwrstaXsIuxmHCl3Jfx
 iBI5JRlOr975YMFYPVXrJGg6FwvPG5Y0C1ekYnsZXFxDOECVC6PQ+jEgklcbaBABpu+dInGEBAq
 kEGmbwNa/SJs2B43fzDJ0Mq1JIbHmCk7J6bBVu7GfaYSfi
X-Gm-Gg: AfdE7clf6ShhgZpqz032YhnhO79p3zcfYUsUp4X5AcDVCXR/xq7iE2dUWPWgWlVZN42
 08Tl2SWRtQDjfeFPw0ULtkFS8IBcFHq6ZD5vcEuo6DcLmywlpGqbRd0fPJSejLj8gOGFf+jcXIc
 EgZCASFS3oxcs1qdu6G/+PNcGR0Q7bFz/Ml9pfL/7YfZFwn7LCHRkLfLyddddhXqXNEH9IVl02+
 MlWLX0odR0k5ylVx+cpJS176ThlxVI/JLJFZCrxf5PtkOhqBXbRDWq4egYjYzwsSSG2pJDFQNz0
 5tYySa3SNlgm
X-Received: by 2002:a17:903:947:b0:2c0:b5c1:8e21 with SMTP id
 d9443c01a7336-2c7fc755250mr31437115ad.16.1782400102830; 
 Thu, 25 Jun 2026 08:08:22 -0700 (PDT)
X-Received: by 2002:a17:903:947:b0:2c0:b5c1:8e21 with SMTP id
 d9443c01a7336-2c7fc755250mr31436615ad.16.1782400102274; Thu, 25 Jun 2026
 08:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-10-alexander@mihalicyn.com>
In-Reply-To: <20260625095250.65073-10-alexander@mihalicyn.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 25 Jun 2026 19:08:09 +0400
X-Gm-Features: AVVi8CfMxkncf_c3CslDqQ_DtTIwxJ8a8eUf48w5jNd0zxthGKHZjU7OxRs0MEE
Message-ID: <CAMxuvax2RyRCAYkW0BAEoq6+eektdpfuD48CBd1F=NUa3gqGiA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] hw/audio/virtio-sound: add placeholder for buffer
 write position
To: alexander@mihalicyn.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 25, 2026 at 1:53=E2=80=AFPM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
>
> When a running audio stream is migrated, on average half of a
> recording stream buffer is lost or half of a playback stream
> buffer is played twice. Add a placeholder for the write position
> of the current stream buffer to the migrated data. Additional
> program code is required to resolve the above issues. However,
> the placeholder makes it possible to add code in a backwards and
> forwards compatible way.

I don't think it's convincing enough. I'd rather have proper
versioning if / when such an improvement is made.

>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>
> ---
>  hw/audio/virtio-snd.c         | 2 ++
>  include/hw/audio/virtio-snd.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index b3de8abcb61..cdd384cf4a0 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -81,6 +81,7 @@ static const VMStateDescription vmstate_virtio_snd_stre=
am =3D {
>      .name =3D "virtio-sound-stream",
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> +        VMSTATE_UINT32(buf_wpos, VirtIOSoundPCMStream),
>          VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
>          VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
>          VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
> @@ -1431,6 +1432,7 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
>                  virtio_snd_pcm_set_active(stream, true);
>              }
>          }
> +        stream->buf_wpos =3D 0;
>      }
>
>      for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index 523c456436b..4c688016c25 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -124,6 +124,8 @@ struct VirtIOSoundPCMStream {
>      virtio_snd_pcm_set_params params;
>      uint32_t id;
>      uint32_t state;
> +    /* placeholder: write position in current VirtIOSoundPCMBuffer */
> +    uint32_t buf_wpos;
>      /* channel position values (VIRTIO_SND_CHMAP_XXX) */
>      uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
>      VirtIOSound *s;
> --
> 2.47.3
>


