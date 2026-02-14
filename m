Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C33EDF154
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 10:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrCtD-0008QO-3x; Sat, 14 Feb 2026 05:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vrCtB-0008Q1-Nb
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 05:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vrCt9-0002YP-GG
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 05:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771064914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRGneOR+Ihx3Q4jrHaNUcYO9cEVocNL/qhzjxja+5xI=;
 b=TmG3kGTqea+IdEQYnQ00efSIoRbAidkvLdHROOJTJuinY3JR8AWlMY4fLhdzGYO1Lc+vtr
 BPOL3jreTbTpBC7zH3LuUWTpPswhaoC4RrC9u0tjnoqbwbvUPx+zDJFIE2p9mmfm4xvNIp
 31aFYYBtVrdoqqKzlU6SWa4oF3UTHH8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-zu_w4kW2MCmjO63wIyOPgw-1; Sat, 14 Feb 2026 05:28:33 -0500
X-MC-Unique: zu_w4kW2MCmjO63wIyOPgw-1
X-Mimecast-MFC-AGG-ID: zu_w4kW2MCmjO63wIyOPgw_1771064912
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35449510446so1671856a91.0
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 02:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771064912; cv=none;
 d=google.com; s=arc-20240605;
 b=bDjs/WsMNcFjrkhEq4ebpMi88ZiEiLJ1tyId7mQUxvMuwyv1jOxtl5ei2IGVTbUMAY
 s1zoNacL0RDOAENShVyv/n+ZsGDE0l0aya3SAoVA8vFZNTa3orAA3vZ3aJnb3o8WKUtY
 etcb19tOQ16LOQSj2IWEbFhkvQbikoi46cw9ikEDXZenNyPJs34yEzHdGG+aw2rHcoJd
 lEk2YT7uYXcyjQr7MN+S6VkneeCLB6DtFZ4Jq8IeCzPVoCrb2inLD+8IVlCse6XVLUD4
 xhRw60D7t+2JwwupzfCNc91oMAWb0EsZYTesR2zAlKkqqOEKknFVBrXmV8o7104lZ0Ck
 6keA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QRGneOR+Ihx3Q4jrHaNUcYO9cEVocNL/qhzjxja+5xI=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=HNE9FGhtgi38VXpl3GNwhtooDE4d/PbDlViBK/roUkfwDJRZnQ/SPZS0pehIERGd39
 vPu1Du0qawh16qNZ9cWZxcMuXieOevOfkBQyYPX0HAI6e9agFOUay0YNS2hgNHTckL0O
 9FdAEzWDQ7key4p1j0KBDp8KztKwSWY2d4pVOTE5tFffnruirKhzxrw8iZYpfzDt4Acp
 dXqeDRaybr/mT8IQ9qPGa3gGqZxFi3n2peepaJF62pC9rB+I1s90FRimlo5LJCcso9u1
 c6sRWWMKXI2wNcFN+lnPLpdZvb5Sjmnq7+asPYCsSHh/GzG/ar5qtPdXGqXpxCUxVOsA
 MFHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771064912; x=1771669712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRGneOR+Ihx3Q4jrHaNUcYO9cEVocNL/qhzjxja+5xI=;
 b=bQFMfFax0LjXpze77Xsch10gxgnQllX6jrjizGS34XvcYtZfypqkOYAHqak1OIv8z9
 9Lkiwn6dtTwz+IsPQpfA3Mlogorh2azwDuBf6nmp+mY2+hvKTaL3ih0SFM1uOGt419PA
 YRXu8SVRCgm/i+fUsNHju83MSTZmhas/zRzdRLZJKDi1Wr8hlLnQkizVIPM6T0fBTUGo
 uBn1jwHr98lE33zWoXggo2fecKSeSU54Epgj50kPcFSOGNBZ/TY6wNKQYwzGsIJBn6O2
 kod2B/fc+T9mklSGS99xhf8XAW5d7wR90yh7vBR4eqN+U9hFCXZLd7kP7n2hVPPm7HFk
 EGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771064912; x=1771669712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QRGneOR+Ihx3Q4jrHaNUcYO9cEVocNL/qhzjxja+5xI=;
 b=G2SVy25c6NM7dA4UMRQSLKxojsbVQ4OLTSqKHVZz+oX+yJbP3rxXyywjIp1Xm4fLfo
 k/PhXNlntTgPuwEoXemunKq4oNrAeHMSAgBZ7Ewo0yF8tQ+OdsY8NPBw16O5VQoNvHsy
 aXn1WJEoSE0vHml+uat72u9OibbYZ3lhEumBqJzoN3AJFZyyAIXz/a6//KAFTkbe2Bai
 KL7PXj4dKhKh4WkYgZ2Eqk7ZDbm6gLoCtjpRId0UKp/HZn7Kb/q6bVtBwb4aEvPWDsML
 X8VVvWhOz3pLZbHvp0eINSAWXucsr4gCexuehfpIypFECCzS/rt60doxWZITOVlmvpps
 ujDw==
X-Gm-Message-State: AOJu0YwUvsH0B9pdERdRoSJIX1S6C+pcBDq9zqTawrjoONLvDqnnfmjV
 RCmpVzxm+yJJVom4vGWWqz2+T7TSqBDoGs5BoVxhy797D7Ll6bD+TaAMdql63EvA6RIR38bHnXg
 JYLFpY1q6Bfc5lXOv6ALwIfi9vS6Uzubtbtr+3pKWEJ/AlwVQAztaSLEnSf6n6QSVIv9xhmPUAS
 dpTY4K109xwmJyNObjHE+5Ae3KFSETxj4=
X-Gm-Gg: AZuq6aLGBce3VV3jCF8w6Uid56+AkUFLFzsxgaStTtgu9Y3SQ4Q7D+030SUvp8+T4nD
 oVJR1cvlZW4t+GXAEIq8oBxGsQJqKyqtGceb5QgfTZI1mzMTwXuWSyf8yDPBDMjmuKRZpa5Fc+0
 ui31oYe30ZWaUA1QUegQ10S2U/f67pf23YVXAA+uT20xy10WDq96T9x80ghi0g2Lf71Tjwd9JQM
 dGipj1CkpOwp4UIfms8rkNb812ZNz4WTIxpquE=
X-Received: by 2002:a17:90b:3c4c:b0:354:e86a:3066 with SMTP id
 98e67ed59e1d1-356aa39c273mr3977709a91.0.1771064912305; 
 Sat, 14 Feb 2026 02:28:32 -0800 (PST)
X-Received: by 2002:a17:90b:3c4c:b0:354:e86a:3066 with SMTP id
 98e67ed59e1d1-356aa39c273mr3977698a91.0.1771064911960; Sat, 14 Feb 2026
 02:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-38-marcandre.lureau@redhat.com>
 <0ab12e2a-906a-44c7-90c9-e3c86675adf3@nutanix.com>
In-Reply-To: <0ab12e2a-906a-44c7-90c9-e3c86675adf3@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 14 Feb 2026 14:28:20 +0400
X-Gm-Features: AZwV_Qgo4HTC9-srnvdaxEhy29qRO4G-20_RyTMOpnsFp6qd3R7E9ZEKl97_aKU
Message-ID: <CAMxuvawzN7dt0TpgXZ8UsGmfCwR06qmaOS4ZFw50b4UeC4ephA@mail.gmail.com>
Subject: Re: [PATCH 37/43] audio: replace DEBUG_AUDIO with trace
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 13, 2026 at 4:57=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio_template.h  | 10 +++++-----
> >   audio/audio-mixeng-be.c |  9 ---------
> >   audio/trace-events      |  1 +
> >   3 files changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/audio/audio_template.h b/audio/audio_template.h
> > index c47a2f202f0..e884c8e9b1a 100644
> > --- a/audio/audio_template.h
> > +++ b/audio/audio_template.h
> > @@ -556,11 +556,11 @@ static SW *glue(audio_mixeng_backend_open_, TYPE)=
 (
> >       sw->callback.fn =3D callback_fn;
> >       sw->callback.opaque =3D callback_opaque;
> >
> > -#ifdef DEBUG_AUDIO
> > -    dolog ("%s\n", name);
> > -    audio_pcm_print_info ("hw", &sw->hw->info);
> > -    audio_pcm_print_info ("sw", &sw->info);
> > -#endif
> > +    trace_audio_voice_pair(G_STRINGIFY(TYPE), name,
> > +                           AudioFormat_str(sw->hw->info.af),
> > +                           sw->hw->info.freq, sw->hw->info.nchannels,
> > +                           AudioFormat_str(sw->info.af),
> > +                           sw->info.freq, sw->info.nchannels);
>
> A little unsure of the "pair" naming here?

hw & sw voices, that's the terminology used (create_voice_pair) in the file=
.

>
> >       return sw;
> >
> > diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> > index 5303c08a285..5165768a531 100644
> > --- a/audio/audio-mixeng-be.c
> > +++ b/audio/audio-mixeng-be.c
> > @@ -620,15 +620,6 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, v=
oid *buf, size_t buf_len)
> >       return total_in * sw->info.bytes_per_frame;
> >   }
> >
> > -#ifdef DEBUG_AUDIO
> > -static void audio_pcm_print_info (const char *cap, struct audio_pcm_in=
fo *info)
> > -{
> > -    dolog("%s: %s, freq %d, nchan %d\n",
> > -          cap, AudioFormat_str(info->af), info->freq,
> > -          info->nchannels);
> > -}
> > -#endif
> > -
> >   #define DAC
> >   #include "audio_template.h"
> >   #undef DAC
> > diff --git a/audio/trace-events b/audio/trace-events
> > index 7a73d6eb84f..ed04792d508 100644
> > --- a/audio/trace-events
> > +++ b/audio/trace-events
> > @@ -74,3 +74,4 @@ audio_out_played(size_t played) "played=3D%zu"
> >   # audio_template.h
> >   audio_open_out(const char *name, int freq, int nchannels, int fmt) "o=
pen %s, freq %d, nchannels %d, fmt %d"
> >   audio_open_in(const char *name, int freq, int nchannels, int fmt) "op=
en %s, freq %d, nchannels %d, fmt %d"
> > +audio_voice_pair(const char *type, const char *name, const char *hw_fm=
t, int hw_freq, int hw_nchannels, const char *sw_fmt, int sw_freq, int sw_n=
channels) "%s: name=3D%s hw=3D%s/%d/%d sw=3D%s/%d/%d"
>
> Otherwise:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

thanks

>
>
> ATB,
>
> Mark.
>


