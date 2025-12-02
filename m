Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE42CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQPkU-000876-S5; Tue, 02 Dec 2025 07:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQPkT-00086j-Re
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQPkR-0000tR-5f
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764679489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTrzgJu0wZ0v2i6GcsESL+/PNxsodFl9p5QZ4QUUkdU=;
 b=JRNR97WTgRhnSxcRo80UX1BA+WbNB0WEcwrW1SHUVBaxF2HC1yAGSGP/orezHPLQAPEnnK
 p15hRipXOEVHAfSAxP3+D6ceyPfgc3kW4peOz2skBzs2cT0LpZ4rW6/COzUSqGBhqQh7jR
 JSvJlV1u329XygoqRaLEVT/UAvZz5As=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-GRmQPOSeNEuWqvdwsr7INA-1; Tue, 02 Dec 2025 07:44:47 -0500
X-MC-Unique: GRmQPOSeNEuWqvdwsr7INA-1
X-Mimecast-MFC-AGG-ID: GRmQPOSeNEuWqvdwsr7INA_1764679487
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3416dc5754fso9823643a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764679487; x=1765284287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BTrzgJu0wZ0v2i6GcsESL+/PNxsodFl9p5QZ4QUUkdU=;
 b=dRHbHCIsC3v6FDR9xvVqF3Zs48fzjZX10vsgSJEQvtrJPvXxWZKIXPJxn5SbsLZG5A
 pgeV0nZx4pV/dujghzrsbdrL6KEBWDcnjhNyMogSyfkg7fSe6RaPBFbTthW0ObCRosDT
 svk5Sa4XJuV6GgIw+dMfBzxk5Mt72xjnhcfMAfflEMnQ2c0jD4xDZM51JjT5XEGxfq38
 PCiOw96OcN4PP4Wh2ARZ0RHtJOy0Q+DioMcYD0I8N39BGrzoJn5V3cuwThag6RBg0XeJ
 YZzlnzaDCftodRIc+2npp5ja4MFFGb6Kawz+rwlkUsCu7pgAL4fZQlvofUAQUMyOgmpD
 aw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679487; x=1765284287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTrzgJu0wZ0v2i6GcsESL+/PNxsodFl9p5QZ4QUUkdU=;
 b=Q7HRe4KSdfhZDCi/1LCEo0apmNB7QA5XYLlYAa2WQI1q4yqlaNu27SXI+fpqwO6tov
 dmMGDZA2MJhgmMbvN/YMTI83AonZcI8tX4zOUCzU9hGC+778//82cs52q2Cm57RnzXxQ
 7UUKSIaBIZHIKDZrH2PT5a55d8c9tUYIaIDHNGaE4KM6YP6q6/IEcpWzeTkrP1j7vCI8
 oWGG5Lf3y5D0MOBdBzhgjVFQhQ+w9jSxa3rcEjUo8G8kJ/JdTFACboRmfFhfBRLWatcJ
 z4I+0KbpuwNe7l5UsIFL5T7Wkb9w0I3LmcEdWzPIL4bk0iXetraLN4C00169//sHpQ86
 avkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYhMi9Yku4IYJlRN/5euFIU3URJ17cliEhg6UJUd9sgyFiK50Ny92kfMWUJ9NehUjZNQtC7AG2rQws@nongnu.org
X-Gm-Message-State: AOJu0YwU/mdxXIrwYxRILDrhugF4bF5+tmdeoYVhDabUlqsGgbN0BhBo
 ZfK/1xxq2xM28creBHaJe/0ile9ChYwRBM5ebpaLXyBHPaN3+xu9gb/AjNBmy0iNORRAOgxHbZl
 km/61pTvkWtIY4gNV9GZD4NXoBpWHD+wCCxdJskowi2lnR9rHQNKwBlWSyboXXwrFQlPyat2zwe
 ZEK1ZMrJ+VhtjJiRfCxGmZmyZH8VX7xCc=
X-Gm-Gg: ASbGncuoTA08qiOXUoNq73MthX/xgElAurnezVzKQmBYDpTSnrz5MuT6j4jVUtK7tcR
 2s/CFSgTgmQPY+6SqyWa+8aEnHQNqlzZYSW1JtxRZ+sOKvcaIWpax/FWJp8Zd5Jiwx5Ai0pjIp/
 CpXMyxICWal8YPl3FQCLleLI0Bc1ICQNLaDbPfUR4staRzmgaEpTErguUFVIDIeXIl8XqceVG03
 +rQrg4notuiohAm5R5XXjVSuA==
X-Received: by 2002:a17:90b:3848:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-34733e54ff1mr40456532a91.3.1764679486881; 
 Tue, 02 Dec 2025 04:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDdb6beepnPK9mPvXxUzN2e2p83f+HMhPSkjplvYPs1riOm7CWJ9OG9Fi0wk9HSYCyMkP7uVBoQ4zNAfx4DzM=
X-Received: by 2002:a17:90b:3848:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-34733e54ff1mr40456505a91.3.1764679486493; Tue, 02 Dec 2025
 04:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
 <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
 <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
In-Reply-To: <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 2 Dec 2025 16:44:35 +0400
X-Gm-Features: AWmQ_bm2jh18oV_4aveBAteIOfmXSLe3NbMxybsQhcxMxQbcYAhxfvXHbArl1zs
Message-ID: <CAMxuvayp1WiqWe40Ox69DQ+R0X3VrJ_ai001Z04KbEouFGwCjg@mail.gmail.com>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
To: Geoffrey McRae <geoff@hostfission.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexandre Ratchov <alex@caoua.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dirty.ice.hu@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="000000000000ef677b0644f775c5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ef677b0644f775c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geoffrey

On Tue, Dec 2, 2025 at 4:31=E2=80=AFPM Geoffrey McRae <geoff@hostfission.co=
m> wrote:

>
> The PipeWire and PulseAudio backends are used by a large number of users
> in the VFIO community. Removing these would be an enormous determent to
> QEMU.
>

They come with GStreamer pulse/pipe elements.


>
> Audio output from QEMU has always been problematic, but with the
> PulseAudio and later, the PipeWire interface, it became much more user
> friendly for those that wanted to configure the VM to output native
> audio into their sound plumbing.
>

Could you be more specific?


> I do not agree that ALSA is as useful as you state it is, it's dependent
> on the host system's audio hardware support. If the sound device doesn't
> support hardware mixing (almost none do anymore), or the bitrate/sample
> rate QEMU wishes to use, your out of luck.
>
> What I do think needs fixing here is the removal of the forced S16 audio
> format, and the resampler which forces all output to 48KHz. This though
> would require changes to the SPICE protocol as currently it is fixed at
> two channel 48KHz S16 also IIRC.
>
>
Why is it a problem that Spice requires 48khz? Afaik, you can't have both
Spice & another backend (unlike VNC which does monitor to capture)


> IMHO adding GStreamer is unnecessary, we have the modern PipeWire
> interface which is compatible with everything. I see absolutely no
> reason to add so much complexity to the project for little to no gain.
>
>
Pipewire alone is not compatible with Windows or OSX, afaik.

--000000000000ef677b0644f775c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Geoffrey</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Dec 2, 2025 at 4:31=E2=80=AFPM Geoffrey McRae &lt;<a href=3D"mailto:geoff@h=
ostfission.com">geoff@hostfission.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><br>
The PipeWire and PulseAudio backends are used by a large number of users <b=
r>
in the VFIO community. Removing these would be an enormous determent to <br=
>
QEMU.<br></blockquote><div><br></div><div>They come with GStreamer pulse/pi=
pe elements.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Audio output from QEMU has always been problematic, but with the <br>
PulseAudio and later, the PipeWire interface, it became much more user <br>
friendly for those that wanted to configure the VM to output native <br>
audio into their sound plumbing.<br></blockquote><div><br></div><div>Could =
you be more specific?</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
I do not agree that ALSA is as useful as you state it is, it&#39;s dependen=
t <br>
on the host system&#39;s audio hardware support. If the sound device doesn&=
#39;t <br>
support hardware mixing (almost none do anymore), or the bitrate/sample <br=
>
rate QEMU wishes to use, your out of luck.<br>
<br>
What I do think needs fixing here is the removal of the forced S16 audio <b=
r>
format, and the resampler which forces all output to 48KHz. This though <br=
>
would require changes to the SPICE protocol as currently it is fixed at <br=
>
two channel 48KHz S16 also IIRC.<br>
<br></blockquote><div><br></div><div>Why is it a problem that Spice require=
s 48khz? Afaik, you can&#39;t have both Spice &amp; another backend (unlike=
 VNC which does monitor to capture)</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
IMHO adding GStreamer is unnecessary, we have the modern PipeWire <br>
interface which is compatible with everything. I see absolutely no <br>
reason to add so much complexity to the project for little to no gain.<br><=
br></blockquote><div><br></div><div>Pipewire alone is not compatible with W=
indows or OSX, afaik.</div><div>=C2=A0</div></div></div>

--000000000000ef677b0644f775c5--


