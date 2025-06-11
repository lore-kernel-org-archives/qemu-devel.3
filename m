Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2EAC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKly-0000Oz-GR; Wed, 11 Jun 2025 08:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uPKlv-0000Nt-UY
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uPKlt-00025W-MF
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749645695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VgSVYXRuPRidvd+jTmNUTWe/WYONYOQKxJUNfID6WIk=;
 b=cYno8sohzboo7Hdy5nTzDknO7JFco7uishG5F8iMZttWlLE4plQHAiZphu1hLTJAwXtK+Q
 YFj+oTnoWOI/6tSGBYP3ObN+vMq1HoiUCiPSH8QKBA8nMvHoglzVRoKNB9TYoV3VP9bWPw
 OTS16ZgEarl6rNx98wTOet/9VTwr+Tc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-g0l1qmz2OHiqu97caTBOPw-1; Wed, 11 Jun 2025 08:41:33 -0400
X-MC-Unique: g0l1qmz2OHiqu97caTBOPw-1
X-Mimecast-MFC-AGG-ID: g0l1qmz2OHiqu97caTBOPw_1749645693
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fafb2f0a33so99110516d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749645693; x=1750250493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VgSVYXRuPRidvd+jTmNUTWe/WYONYOQKxJUNfID6WIk=;
 b=EyIxDMARaPTsvYqbCylJtBXUSSRWDwWEMf60OyEAMtw/8S14qxmhAEfuFBZH14wDxH
 qn9SxN3xQUcK2BOI7N9SsyRB3h++2rl0HI7cSHvIMzxaEHcXjt2UiPmdpbfWeU1vsJYd
 gysZ/vZh1zR9sguRMVZDG6wLxp5RsczcjU5dDe9jWeEDU5wLMNq2gfimMXkd4bBx20Bq
 LE2VC136Z9guzyOYGrQlSns8I3HfOTgXbLChzhfGyb5zdo8ehaNOCJulwxrRTTySz/GP
 nyfLyJgyl0KDsnSKfBMQ2fYixDeJuK4Rq980MKYSqSb5+DIXVokjEgS3cA7zgx9XcsBo
 07UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW/o6e4MWT0oSaQMdl/sWB8Xo6H3GamQwMhbw0v1dPYg/id/nHOYVBjxpMo4sPgL6bGSVXOpVzvEkp@nongnu.org
X-Gm-Message-State: AOJu0YySTveF1qqFI7GL0/4UgHmQzFhWndCUZJB8F28PXpWIT46kZlSC
 DPrf1r8ZTuCEVF7fgy+kHLiPvKyM7Dvc3njSU/6WFezIaojhl5Flq/SPr69ycfcQc1TTC9QHh3y
 SRoV6s/M4HpHZzLpW25qWdQifOEpHLuXIbgCLMG71Eb00QBSD4jXTVy9HfEReghO/vyRfV5/kaL
 dEgQW32zaCh4w1+rbQtu2KOg9AbgYRYnE=
X-Gm-Gg: ASbGncu0dn87O/OTKqQL6KrFmCBUxofjvK64eM3rfT3o6olua9/J+WmuaDG6Cdscoaz
 pUgjbRG0IimDmUsY/mk8k/0BpDwr4ofuMp0FkLk46tUUojVJMTKB33v1DPW0vm2mWEcXVhDagrY
 vGfY2rAsrxyroFOOeyrkWr1SKjyBl3kOgvFsWJ
X-Received: by 2002:a05:6214:e64:b0:6fa:c697:97b5 with SMTP id
 6a1803df08f44-6fb2c36a355mr55435556d6.20.1749645693197; 
 Wed, 11 Jun 2025 05:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJCoMQG06toQzG4ZLCqx73G6O2HeyBEX4cakZuQsRih7DrJrUqP67yE5e+lI67n2ENhA8P7CnhPW2YOy4r4oU=
X-Received: by 2002:a05:6214:e64:b0:6fa:c697:97b5 with SMTP id
 6a1803df08f44-6fb2c36a355mr55435186d6.20.1749645692834; Wed, 11 Jun 2025
 05:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250521151616.3951178-1-jmarcin@redhat.com>
 <aEl31gjAjlt5zj-l@x1.local>
In-Reply-To: <aEl31gjAjlt5zj-l@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jun 2025 16:41:21 +0400
X-Gm-Features: AX0GCFt0S9Vrln_aPYrJAz5b01YdA7CakhURj50V3xermjVgyloaovaMAhioy-I
Message-ID: <CAMxuvaxTKMEVHOQyjcyWFw=+LbyfbFJgMb4ZfSjkiT-VJsjAWw@mail.gmail.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
To: Peter Xu <peterx@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001315b06374b22d0"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000001315b06374b22d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 11, 2025 at 4:34=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> >
> > If a virtual machine is paused for an extended period time, for example=
,
> > due to an incoming migration, there are also no changes on the screen.
> > VNC in such case increases the display update interval by
> > VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> > to VNC_REFRESH_INTERVAL_MAX (3000 ms).
> >
> > When the machine resumes, it can then take up to 3 seconds for the firs=
t
> > display update. Furthermore, the update interval is then halved with
> > each display update with changes on the screen. If there are moving
> > elements on the screen, such as a video, this can be perceived as
> > freezing and stuttering for few seconds before the movement is smooth
> > again.
> >
> > This patch resolves this issue, by adding a listener to VM state change=
s
> > and changing the update interval when the VM state changes to RUNNING.
> > The update_displaychangelistener() function updates the internal timer,
> > and the display is refreshed immediately if the timer is expired.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
>
> [add Dan]
>
> Ping - anyone is willing to pick this one up?
>

I haven't started gathering pending UI patches. Feel free to pick it up

--00000000000001315b06374b22d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 11, 2=
025 at 4:34=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pe=
terx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote=
:<br>
&gt; From: Juraj Marcin &lt;<a href=3D"mailto:jmarcin@redhat.com" target=3D=
"_blank">jmarcin@redhat.com</a>&gt;<br>
&gt; <br>
&gt; If a virtual machine is paused for an extended period time, for exampl=
e,<br>
&gt; due to an incoming migration, there are also no changes on the screen.=
<br>
&gt; VNC in such case increases the display update interval by<br>
&gt; VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up=
<br>
&gt; to VNC_REFRESH_INTERVAL_MAX (3000 ms).<br>
&gt; <br>
&gt; When the machine resumes, it can then take up to 3 seconds for the fir=
st<br>
&gt; display update. Furthermore, the update interval is then halved with<b=
r>
&gt; each display update with changes on the screen. If there are moving<br=
>
&gt; elements on the screen, such as a video, this can be perceived as<br>
&gt; freezing and stuttering for few seconds before the movement is smooth<=
br>
&gt; again.<br>
&gt; <br>
&gt; This patch resolves this issue, by adding a listener to VM state chang=
es<br>
&gt; and changing the update interval when the VM state changes to RUNNING.=
<br>
&gt; The update_displaychangelistener() function updates the internal timer=
,<br>
&gt; and the display is refreshed immediately if the timer is expired.<br>
&gt; <br>
&gt; Signed-off-by: Juraj Marcin &lt;<a href=3D"mailto:jmarcin@redhat.com" =
target=3D"_blank">jmarcin@redhat.com</a>&gt;<br>
<br>
[add Dan]<br>
<br>
Ping - anyone is willing to pick this one up?<br></blockquote><div><br></di=
v><div>I haven&#39;t started gathering pending UI patches. Feel free to pic=
k it up=C2=A0</div></div></div>

--00000000000001315b06374b22d0--


