Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811B6D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 18:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ8se-0006Jv-0j; Mon, 01 Dec 2025 13:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQ8sR-0006JP-Te
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQ8sP-0005nz-In
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764614635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2eH5KD6Kms7ohdnaJsjqFf8Dfq6DQCOK9Upj59dm9M=;
 b=N6oe9gTGuGNVqOLuupC/q8nf9k6I+thft1YdBlWTumZRAV6nK1q3+sdY/8kEL4fqlsmwlf
 R0AyRc4y05IZD3FR3WZ23RWs5darj9dChmQtU2c/JNle8+Jh4c8isnL+S089dxtNKcFjEB
 fMCdNhVeikspUg5FW8mGhGhxGZ0cNYM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-G8oaCYLcNQW0N7Ij0xhDfA-1; Mon, 01 Dec 2025 13:43:51 -0500
X-MC-Unique: G8oaCYLcNQW0N7Ij0xhDfA-1
X-Mimecast-MFC-AGG-ID: G8oaCYLcNQW0N7Ij0xhDfA_1764614631
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-297f587dc2eso90774205ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764614631; x=1765219431; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C2eH5KD6Kms7ohdnaJsjqFf8Dfq6DQCOK9Upj59dm9M=;
 b=cxs1O1Q4YwsOkpMU4j/QJUULuSCJeZX5yXWrn0ZPQcuQ2MHOxH3X/CWlbgetAlDSg9
 vWbdXzaBlXmd880uimasn7N1gcaVueqTeboFpN9VS4DXQc6CF+Om6qrsGN+wgNZDV6bX
 tm+zLqn0tfPdurNtZitdN8+easli7+P0cpvhh8ndeZUUA9HuGjyMCvzCL2QUTirplV9R
 cfwwCe4Ttd2w1TODEcbajOf4cfiWjuZtH//XhEsipQG6xD0RCacbQ0J8BDklEy9lEwd4
 f03rEJKI3otYFso1hiHvAvzb1SLLRxg0a0Phhf9aWzWtpmlj3bef/SmfuTIZvW+yNq68
 yvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614631; x=1765219431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2eH5KD6Kms7ohdnaJsjqFf8Dfq6DQCOK9Upj59dm9M=;
 b=w9Ayr5Jrtvctz3NwXKh5Qo+1LvcshwTcK6yI8wUFBOGQJCgwGm8Vb6fxV7kF3gMBRK
 cW6djRLMk7puKoxB75V+vBWsA6Bn/Zs03unLr+oqDI438N9qWYN4JfSKdj0DHm90gGZ8
 Y6jDO2uJvFxMvbM8a4aX4+Br+kMIsO3/w9dK9zzthFRn+3Qu3jOhYQXZlilC4x3sxDS3
 gm5YsvPBIv8TAmlTrmK5nFS0yokZAGkZnvlxVGAX5rrpBoW80kFYXkMXWFP+Xdpd5inQ
 IsvaYDK/CErkD0jzSSlBV2FdxlYZxkAk1szeF3DLaIA2u7w8QRs7pUnt7YxUyqAwNMNk
 +Y8A==
X-Gm-Message-State: AOJu0Yz1+aq1a3jksJ+gs4gQQCejjC3qnfQFDIEYP+usPLulaJ49l72O
 LEF58G7TVGZZTa2hT97S8wanCC94tfnJDPpPDed1Oxl5MgH6IjPIWQv3ikZvqF3KNq8Mq7DRS0X
 mTklOVSqriUMRPqWdvS7vBiGDYPsHntGIqQDnO01ZOiiYuZhZaJw3Z8Uk6QI7oNy9ttjnxFCONf
 kgyN+5cWrYJtIQI1HJj9W7ssuqqQFf22I=
X-Gm-Gg: ASbGnctjsGxALECZrvm64x3lh7z1Vue77jayvTz+1+2Ims/rkv8Lo9EJ23lFSfcv4h8
 FWxAeuQOpH+EFhAlpe0xftPgTF0h3u9n78e6Jwb4Qcl07Y79X4Gbp2uRBckwNCAGx6Bv4kYFY0l
 joZWJ4Levanj7VPg0Wqm65SbeE9BHEXvy1wxEZOCk+5aeXSi2Uu97kgTj6lbdNrLTt5MOvOVetT
 M+1ttKdYtqp0hTf/tFR0YqJpA==
X-Received: by 2002:a17:903:19ed:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-29b6beb1e22mr459984055ad.17.1764614630788; 
 Mon, 01 Dec 2025 10:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhr/QEDszNAJuFWOFICNF5RW2GBpCxrv9rHGFyswVprifd/SuNVjmvNhsEYOv3B5hnsrv7xoU0RvPHc+eWp0w=
X-Received: by 2002:a17:903:19ed:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-29b6beb1e22mr459983705ad.17.1764614630344; Mon, 01 Dec 2025
 10:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <20251201112309.4163921-9-marcandre.lureau@redhat.com>
 <f25c53b4-3f47-242f-0e39-778fa0bc3f35@eik.bme.hu>
In-Reply-To: <f25c53b4-3f47-242f-0e39-778fa0bc3f35@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 1 Dec 2025 22:43:39 +0400
X-Gm-Features: AWmQ_bmSSuRVcajf6kso9UJ-ECzWzSy2Mdy9s9O6GUzKwYzEJ5z0pog-KtdvyFg
Message-ID: <CAMxuvaw=9v_TPytdW3kTtd9mD0r6-H4V8BUiZ6VS4UJkc0_Lfw@mail.gmail.com>
Subject: Re: [RFC 08/24] audio: add QOM module-objects for each backend
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="000000000000351a730644e85c4e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000351a730644e85c4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Dec 1, 2025 at 5:20=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:

> On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This will allow to use QOM and the dynamic object module loading.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > audio/audio_int.h   |  2 ++
> > audio/alsaaudio.c   | 39 +++++++++++++++++++++++++++++++++++++++
> > audio/dbusaudio.c   | 36 ++++++++++++++++++++++++++++++++++++
> > audio/dsoundaudio.c | 36 ++++++++++++++++++++++++++++++++++++
> > audio/jackaudio.c   | 36 ++++++++++++++++++++++++++++++++++++
> > audio/noaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
> > audio/ossaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
> > audio/paaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
> > audio/pwaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
> > audio/sdlaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
> > audio/sndioaudio.c  | 36 ++++++++++++++++++++++++++++++++++++
> > audio/spiceaudio.c  | 36 ++++++++++++++++++++++++++++++++++++
> > audio/wavaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
> > audio/coreaudio.m   | 36 ++++++++++++++++++++++++++++++++++++
> > 14 files changed, 473 insertions(+)
>
> This patch is entirely QOM boiler plate... Are the empty functions really
> needed? Could this use OBJECT_DECLARE_SIMPLE_TYPE instead to cut this
> down?
>

Right, I did this patch systematically, and to provide placeholders for the
later patches. But I can now simplify it.

thanks


>
> Regards,
> BALATON Zoltan

--000000000000351a730644e85c4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 1, 20=
25 at 5:20=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.=
hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Mon, 1 Dec 2025, <a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;<br>
&gt; This will allow to use QOM and the dynamic object module loading.<br>
&gt;<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt; audio/audio_int.h=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt; audio/alsaaudio.c=C2=A0 =C2=A0| 39 +++++++++++++++++++++++++++++++++++=
++++<br>
&gt; audio/dbusaudio.c=C2=A0 =C2=A0| 36 +++++++++++++++++++++++++++++++++++=
+<br>
&gt; audio/dsoundaudio.c | 36 ++++++++++++++++++++++++++++++++++++<br>
&gt; audio/jackaudio.c=C2=A0 =C2=A0| 36 +++++++++++++++++++++++++++++++++++=
+<br>
&gt; audio/noaudio.c=C2=A0 =C2=A0 =C2=A0| 36 ++++++++++++++++++++++++++++++=
++++++<br>
&gt; audio/ossaudio.c=C2=A0 =C2=A0 | 36 +++++++++++++++++++++++++++++++++++=
+<br>
&gt; audio/paaudio.c=C2=A0 =C2=A0 =C2=A0| 36 ++++++++++++++++++++++++++++++=
++++++<br>
&gt; audio/pwaudio.c=C2=A0 =C2=A0 =C2=A0| 36 ++++++++++++++++++++++++++++++=
++++++<br>
&gt; audio/sdlaudio.c=C2=A0 =C2=A0 | 36 +++++++++++++++++++++++++++++++++++=
+<br>
&gt; audio/sndioaudio.c=C2=A0 | 36 ++++++++++++++++++++++++++++++++++++<br>
&gt; audio/spiceaudio.c=C2=A0 | 36 ++++++++++++++++++++++++++++++++++++<br>
&gt; audio/wavaudio.c=C2=A0 =C2=A0 | 36 +++++++++++++++++++++++++++++++++++=
+<br>
&gt; audio/coreaudio.m=C2=A0 =C2=A0| 36 +++++++++++++++++++++++++++++++++++=
+<br>
&gt; 14 files changed, 473 insertions(+)<br>
<br>
This patch is entirely QOM boiler plate... Are the empty functions really <=
br>
needed? Could this use OBJECT_DECLARE_SIMPLE_TYPE instead to cut this <br>
down?<br></blockquote><div><br></div><div>Right, I did this patch systemati=
cally, and to provide placeholders for the later patches. But I can now sim=
plify it.</div><div><br></div><div>thanks</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan</blockquote></div></div>

--000000000000351a730644e85c4e--


