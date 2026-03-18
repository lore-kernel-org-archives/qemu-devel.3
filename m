Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1CF10854BE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mjx-0008S4-CR; Wed, 18 Mar 2026 04:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schoenebeck@crudebyte.com>)
 id 1w2mjt-0008Rc-W2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:58:54 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schoenebeck@crudebyte.com>)
 id 1w2mjs-0005e2-7L
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=m+X45cG9u7a53HW3UhMxWgBUlt+8X9wzLfiekl6ae8g=; b=fTScFq2/rUw4Sd1u8jMLqMH/KM
 /9DBYwNtO5LIPIcmanxCYiWcAeB9u9DQ9C+yWySk7t5z7516cL2rbuGQ9vMiM1n7XyrfxtsrmAJds
 cG6NKWYhchk4/vHKdwcGLFYTlz2Xmr35aMYyv1A1uf85KQPOO84VtjTOGLmlxabOlODUKe40gT+VH
 1GBNt59lP00VvU9vQOcWXkaBMv87qyNdWnycNkXJA/OGDRHi4/B9f60RtoxmjCTIbyGWwK6p7l6xK
 RqIeC24RkuRW0RWeDUzK37Ee0BZRbhl2GOgkpIgdXystpV1kkkji+BGEA/DyL9Gfbi7QaZy1YLrRr
 C0VmcyT3vRGcrye0facpmmGBBKzwY0gCQ+dfv27hg1+E3fy5k2T+e8E2RgAIrIP1Jr8fnmkQpwAF2
 sHg3FEkhZb47/XulbHYNuWaUU07s0kzgUL1xbv08V/9OAAXrHW4ZfTCPyW2ae1+fzwDIc6XipWA6U
 V5+yRpz4H7k6HaFcYrPUrVbwbsXm7+H2pwALepe68ZhP+riJyF4qNalm6glomsqKMB3gEBYpffE+j
 316gSj38Sp1EcIoU9Hb1TFpFX1QqhzQ84yQoBT76cBPQ9sHQHcYP+zwq3DUuKUxHe0egzTHqsaN8P
 +zcxxjTo1plZZIIgsxmxLdPyEq7V9Tm9Az78DQr6E=;
From: Christian Schoenebeck <schoenebeck@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: dmitry.osipenko@collabora.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com
Subject: Re: [PATCH] audio/mixeng: fix sw/hw mixup in audio_pcm_sw_init_
Date: Wed, 18 Mar 2026 09:58:45 +0100
Message-ID: <6248957.lOV4Wx5bFT@weasel>
In-Reply-To: <20260318084301.653383-1-marcandre.lureau@redhat.com>
References: <20260318084301.653383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=schoenebeck@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wednesday, 18 March 2026 09:43:01 CET marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Commit 42061a14358 ("audio/mixeng: replace redundant pcm_info fields
> with AudioFormat") accidentally changed the conv/clip function selection
> in audio_pcm_sw_init_ to use hw->info.af (the hardware voice format)
> instead of sw->info.af (the software voice format). This causes audio
> distortion when the software and hardware voices use different formats,
> as the wrong conversion functions are applied to the audio data.
>=20
> Fix by using sw->info.af, restoring the original behavior.
>=20
> Fixes: 42061a14358c ("audio/mixeng: replace redundant pcm_info fields with
> AudioFormat") Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio_template.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Haven't tested this, but those changes (hw instead of sw) were definitely
wrong and are likely to cause misbehaviours like the reported one. I also
haven't found further similar issues, so:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>=20
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 228369cf9a1..f0b2458996a 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -172,7 +172,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>      sw->empty =3D true;
>  #endif
>=20
> -    if (audio_format_is_float(hw->info.af)) {
> +    if (audio_format_is_float(sw->info.af)) {
>  #ifdef DAC
>          sw->conv =3D mixeng_conv_float[sw->info.nchannels =3D=3D 2]
>              [sw->info.swap_endianness];
> @@ -187,9 +187,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>          sw->clip =3D mixeng_clip
>  #endif
>              [sw->info.nchannels =3D=3D 2]
> -            [audio_format_is_signed(hw->info.af)]
> +            [audio_format_is_signed(sw->info.af)]
>              [sw->info.swap_endianness]
> -            [audio_format_to_index(hw->info.af)];
> +            [audio_format_to_index(sw->info.af)];
>      }
>=20
>      sw->name =3D g_strdup (name);



