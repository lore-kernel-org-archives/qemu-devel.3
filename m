Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E1EB7EA0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhKk-0000jm-0G; Wed, 04 Mar 2026 03:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhKh-0000iQ-J1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhKf-0006ol-SV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GegA8rrbWUVZfe74eoQ37n9/545WGh8jtOMensLPLY=;
 b=Y9dBA/eVNmHrtLMVgts3iQg/MGLNQhOAmMkQWN56C+YJyXmD0GMY4WJffuV/D9H4VDm4F0
 06Ivmhc0wQwmnrhRS5FArbfwz9yZ62PGx5Zgvqy13ZBavQlSvUH7HNPa/y26hZaCmP1D8D
 r23l7VPwq3fuL5CwZIZFiqJX6QvxrzQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-3z57_VwZOg2-etryHlp9xw-1; Wed, 04 Mar 2026 03:11:47 -0500
X-MC-Unique: 3z57_VwZOg2-etryHlp9xw-1
X-Mimecast-MFC-AGG-ID: 3z57_VwZOg2-etryHlp9xw_1772611906
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-354bc535546so5363811a91.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611906; cv=none;
 d=google.com; s=arc-20240605;
 b=j1YaHLQadVPqOfGnJBGBG3q1hYkSr3G+e4X7TQpyuAv/xaMoDKcKzelgK3oUAf1FLV
 DZNQw9uyFoQ3Js+saLseygczxtY4OMwfGQQAEqDocaiwdaco89e9hsZBLgD/NyUGKP3u
 PlGak84cOZ4aJuit1a/tdpVwy9Z4xXplZC0X9EUDU7Pjy7DY5SBonPEyLy2BWiVSdDYd
 2D3+FJ5f4WMVCeevspz/L/03/SaUVl8At3jLlviuBq7YINaRE50UZHNHHQmCKaNVLH7A
 Qhg1WvICzPSxLJBpuaRzdVCHIKJyoI2zNQbB1Bt09nF3aYdptuxcalVdSAtddZ1u7Tmu
 Ctuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9GegA8rrbWUVZfe74eoQ37n9/545WGh8jtOMensLPLY=;
 fh=WFisdxRSjGamusVjE4eRDV0PNHrnps+0eqArk6R4K14=;
 b=fz/9qDjIF3GOoVdERsohiRiM5kli+W3j/ktzLcRhEmwdlr04alClwf+2wCKovwC7lE
 t/p3wPrJezZISFWcPN6v+dCEyRUt1KDwGZP9QuB95PYWNxXVDS99Keu3cS6yVrtlYJo9
 QB+n3x55HTYJBBnmuzZPbYHctG/nTy2Hewc+jmHIP+5q4e0n4J+0TN9C6rfjnN1vsSbk
 QJLEKAY6gy63QChD47zvBTquTOEhhCFr+VhWtzGF161c+bOf6Wljfi7pcvRN46kjh5AZ
 MoSPOPxoLBYkGE2C6Dgo/0BqAHBmwJqK8km2szV04125Be8pp284q0NM2M3MSndZpic+
 bt2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772611906; x=1773216706; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GegA8rrbWUVZfe74eoQ37n9/545WGh8jtOMensLPLY=;
 b=A2jB7nU3Qstv7GQ1KaAoyPYjp2E2fp6HqJmtIAeSmt2p3s89BJKpwTL52b+ZfCJOOg
 7lAWwfKM8eK+o3JbsGd7WwYextd4IUwE0ohlhJZ4w1zOq+pQD3U/Z9u827arBskpHs77
 LUjvQuQWSzQL5QfZi3qerHyAOFPZzZYeVN7byerOTlVTCKy4VjdHWIzy0K4mmCu+Akcn
 D9BU0unkSKd6vQBTNozZhPlogVfX6JuNfuBULcd2doRrVakjwuePga9kyH0c+0MX6O/h
 LHS5+Rb3gA++KlJLx51MNjggbO3eHP9K5UaOFwHgCeQpazjDdBCsf7k5KmfzPWETvITJ
 vPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772611906; x=1773216706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GegA8rrbWUVZfe74eoQ37n9/545WGh8jtOMensLPLY=;
 b=bOQQsx6DW03mACM6d0CRJpJvdi2NMGHwfb9mT4pbHqy/KJj7KvxStehNW9+pbCoMsC
 RA570AnQTlcKSb5QAKFp23cz6rJMPcqvl/YZLtARkDphA6Ck8tNErlNoLLkGcT9b6GqV
 MGrlV5sEFmgoCRwX+6YMLD+xvNMR0M+G6P6yzGF+71RRnLCgZ7Jj5gW923Du4hYCb0DA
 iNsOFYhdDImEzPhJVjntG9MQdvF6vofCCPDbsZ/Xs0Uwapw6xHAHxKJ0JEm6ZSo5+W2y
 Nv3iPiB20M1rlgjBIvyA3FOC2qSG6TlB1JiWs5TU7Ofo1wxHyspMG+7r74MMqE+/Ga75
 xQbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxdJXWBDtTJQB0QGRlTlFCWzmURHKR3Ss8ZtA2u6O5uXfBJ2JyBSZTPmbKiZh1jfjGy01wBzRRNyoa@nongnu.org
X-Gm-Message-State: AOJu0Yx//QFKvC5IYuEmfIdSqIraGRNGHbmGQYBvWecCQ0PQh7T0+o1E
 8NdF2nfE87WraHZeboc0Jqt15gAFcy3pw5bmxDMRNYCRxktTau9WSSiLIOs0LX20LtheOjxc9B5
 L8cpPVvWqIHhIOU3A85GjYV4kTvLPx0jmIXz5eMlkCxIE1LCPyTY16DEsdRO660YwTJ4fAQSwxV
 qK77SYteWSYoNNUzyjx41/nmHFfu1FmVzh+KXUBO3Ikw==
X-Gm-Gg: ATEYQzy6xDY1yH9y1ybCW6NhwKbvhOhX2yDDrkpp8s7oqOWnxxngFA6kQ4F1ZwuE1Co
 lnkeWH1AJMulGq7HmyQxtvpFAdqXpdg9AkJIMZmT1QNjXFMleybRYiJtkBHD9xidR5E9LsXPac6
 6ToNcA8uB8orZtp5KdfLM6lfKl72A+MMf0JxJ9D5KuhPohhGY5GlaYYiH7RARKHEHMa4YN6M4Wm
 Vdpq2I7+PTNyhZbY9ivlJvP6S0G7X20gtltEWNE2p5AhFUFW4jxftvRzU+xICLub3w5AUvJRYJV
 EYw6j76O8N2HSKSmeBlERWeS
X-Received: by 2002:a17:90b:510f:b0:359:7e05:cc8d with SMTP id
 98e67ed59e1d1-359a69bddf5mr1076555a91.8.1772611905972; 
 Wed, 04 Mar 2026 00:11:45 -0800 (PST)
X-Received: by 2002:a17:90b:510f:b0:359:7e05:cc8d with SMTP id
 98e67ed59e1d1-359a69bddf5mr1076523a91.8.1772611905631; Wed, 04 Mar 2026
 00:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-6-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-6-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Mar 2026 09:11:34 +0100
X-Gm-Features: AaiRm52XaazqqN-Wvj5GNNZc3AdrljCS49oFuhPK9CH73zWgoGlOW05OQ08vk-k
Message-ID: <CAMxuvazWNDURE2rUTvFPf7M-BGHEmbwFgoPwoHANq=Vj74k5UQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] coreaudio: Initialize the buffer for device change
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Phil Dennis-Jordan <phil@philjordan.eu>
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
> Reallocate buffers when the active device change as the required buffer
> size may differ.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  audio/coreaudio.m | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 23c3d1f80ac5..e4ec1df971c8 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -471,6 +471,7 @@ static OSStatus init_out_device(CoreaudioVoiceOut *co=
re)
>      core->device_id =3D device_id;
>      core->device_frame_size =3D device_frame_size;
>      core->hw.samples =3D core->buffer_count * core->device_frame_size;
> +    audio_generic_initialize_buffer_out(&core->hw);

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>      core->ioprocid =3D ioprocid;
>
>      return 0;
>
> --
> 2.53.0
>


