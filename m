Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21510A88E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ndr-00027e-Kc; Thu, 26 Mar 2026 12:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5ndn-000273-Rw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5ndl-0001R6-92
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774542780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0TEp474IX80tXqUooK7Clr1Apqly7HeqxiWV/i8QdYw=;
 b=cNnQ+R/trHJKJ+SgiOjlocjnGdccPcmv6w7YMxebAHlvkxNxRHuEBLghFwP211UWAa8oBR
 w+06iEgTfoMAsDBugHa1KlIHPufSgG6b6olxtZtN9h30VKMXWr4KOCePlRj+WSo8YKABaG
 86Vw8KYjiD31XOVxFkrMVZ3+8LTMz/g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-oA4nuwYdOVODo5m1y65q7Q-1; Thu, 26 Mar 2026 12:32:57 -0400
X-MC-Unique: oA4nuwYdOVODo5m1y65q7Q-1
X-Mimecast-MFC-AGG-ID: oA4nuwYdOVODo5m1y65q7Q_1774542777
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8950562d351so49177556d6.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542777; cv=none;
 d=google.com; s=arc-20240605;
 b=JlgSnL+lDnqTSd4Nbry5v+pToVVvJp45fj58/hOGD1beN4YlyxdnsFlFia+yqSseLX
 XlyOpJblsxKeeMZUUNvXtYPzedAMwTZFQJK8KqwztOpdsQ2pev/tYcmVY1DhlqHXZt+h
 SbrrfWFugOv4tyY4Al4u5RKFHEGa/CG0lRequvrl7KyuM3gHuncK+Kwx7kX9EVtdK+rY
 BvPo6WuMk38YPIrvh49o+Wgcgm3fUyYCRJ/GqKbfA6vREJnyhX0O7jtJvaWBx3tLC+x8
 go6Z1vWADW/KGtIh7btDGHz974T0OV+q8EqxGlaULfE8D+ta+3iaDNpP80yfxh4bg2Da
 W4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0TEp474IX80tXqUooK7Clr1Apqly7HeqxiWV/i8QdYw=;
 fh=nwp2bTnwiDDlym3zubbK19oED52DUA9W8gFPhWxh01U=;
 b=Xc/ghH5NIPQvCiG5E4alH+V5VRzPlyon6OfHuaafd8+ZAwI9H7+F6TildcSGOzbTHD
 ZYTwaKPPnHQHwmgcFOpGF57jJ6ZT8/OlCBj37SzH4QNg3QmWFTmqfq/fEj6RyBUF/xXf
 tZrJm/AlNWyaj8EfpNd6pzScc9g4ixAOcPGGgF58YExcVvQaxR4HG/fVFNDLWK1bUR4u
 PjCxjhLN+Bggqudej/Z9ptRXzqGqNXtoZcSeEkk/NtbNePTpRCPsCnTvevKubh5CxmL/
 GYX0gZBdy0pZLouD+hcmJroIl45KXAhcjVuGTDTMpp0sE5lttToHrpg5mzOWvwysW/Kt
 /n0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774542777; x=1775147577; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0TEp474IX80tXqUooK7Clr1Apqly7HeqxiWV/i8QdYw=;
 b=CtCiFhd3/ZeZ7bZwW9LvfuV7lI1T7NOwkbF0LrKzkM25yHkQJhqg9x/DawQ1r3vWtw
 OlJABWI1GVAljpu8GpQn0aoknyDfwXQMCbItYXCE6oY9fCrMSNvWzkXAvv9PtTQZwThH
 VJ2GFjBYk3dzys/a0EPhG5wEMm8kkk54reo1Jmwbfs2HkJ8K5V69fIuB1dkphTdQlK7F
 sRn2zT4h/iDp5fyOKuK24tF/0ch31lBVLexcirzgijSNvjeiyqm+1iFmOkZmDu3+GlID
 fbFVH1OYTdnziRUv/x2OTZU2lxnlxanMQ6jdVd0cdl+2rN1FJKJUa2w9PeKbRuhGaeCn
 n0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542777; x=1775147577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TEp474IX80tXqUooK7Clr1Apqly7HeqxiWV/i8QdYw=;
 b=OREBgR+gAL3TseOm9kYDvaRF9LO0yT/IS1FpinCqrhIC6RLlCXmFe0Uw2VhddKjZ5f
 iRUYr1nmwJNVZ5zr1jO7jR2iAzN+WZRMdB3FimbXKzwLhR8Rev5dbDWKxDKo5609UB+E
 ubCZ8SxE/Pr2qKrQuMFM+Fp7S2wVIJSTfz6cVE4grKGH3Q5/Wj5WeiS2qUiHDGgLIvXS
 +ATaCBthT3GXCpOxBVt99TTziU8zYA16k/rlDMqjssfnve6EpIVY1wHvNQF4ODcOxijm
 UYOF91SGBpu5EFXpcuTWseQTnO0N+PsmrlbJ88I3iNuhgz9sFgOPrOxTbV58I+oobTP8
 /q4Q==
X-Gm-Message-State: AOJu0YwqZx1AgrSxpoIn+Z8duAzCj/Wd7aSKKONESZN6d11ha0aKjpgi
 BFQordi/gh4Rg6OBxkLlpW1A0EYjDzyLgE0F8K8n/UStHMk1flRaxEsvrPij7HEXd5CLXXjtk0N
 gRoV2vD/zY+SdF+dfmq0j9DdH0G1g2ETqestQGPlGxTuaqZ+pmG1FCPAz0CvNBAlyet8GkllYXa
 qa24ysI/MSNf2lbQrNm/ZCaLuey1bz/nE=
X-Gm-Gg: ATEYQzzLltQz1rkwk8riiuJBm/d6xNkNoS7yJUxNao7tM97QR+FRcj/j5OZdPngLMQR
 jODxq2WyFGBg8Rwf6KA/lcMFLtM1qRxhQK3h2ZdrAUNKMQzOiXG6+i56OkR912duVi/q0WTbutJ
 2WoHyM2Kx78GamCnWp6CS8i7nDyZD1Bll/1Y7yADfvpID4j71ICTkqr98T5E9AxGSbX6Avp8+tc
 gf2Rkap
X-Received: by 2002:a05:6214:4411:b0:89a:1575:e1d3 with SMTP id
 6a1803df08f44-89cc49bad49mr121003276d6.12.1774542776828; 
 Thu, 26 Mar 2026 09:32:56 -0700 (PDT)
X-Received: by 2002:a05:6214:4411:b0:89a:1575:e1d3 with SMTP id
 6a1803df08f44-89cc49bad49mr121002366d6.12.1774542776133; Thu, 26 Mar 2026
 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-4-kkostiuk@redhat.com>
 <CAFEAcA9-j6qnKJEyk1F9Nkr0NNP9D9Oue=ptPb5py6ex=mdQnQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9-j6qnKJEyk1F9Nkr0NNP9D9Oue=ptPb5py6ex=mdQnQ@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Mar 2026 18:32:44 +0200
X-Gm-Features: AQROBzDzjwyHHB25VpAUPSIbeTPSUmu3czqMIjS2HfLgmF-rjO2rCPcCT5NxhSw
Message-ID: <CAPMcbCqzvcHU2GGKt1fjTdhY0M=6_NVD61TFoRevQ0S1ba-DNQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] osdep: Remove unused strings.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cf7c9e064defef49"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000cf7c9e064defef49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:20=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> >  include/qemu/osdep.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index f151578b5c..2f0e61ad6b 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);
> >  #include <stdio.h>
> >
> >  #include <string.h>
> > -#include <strings.h>
> >  #include <inttypes.h>
> >  #include <limits.h>
> >  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
>
> This needs more rationale about why we can drop the header.
> POSIX says it brings in ffs(), strncasecmp_l() and strcasecmp_l(),
> which we don't use, but also strcasecmp() and strncasecmp()
> which we definitely do use.
>

Will be ok if I replace strcasecmp with g_ascii_strcasecmp (and other
functions)
in the full QEMU tree?

Currently, I see in QEMU we have a mix of strcasecmp/g_ascii_strcasecmp.
In some places we use glb2, in some libc.


> Some libcs (notably glibc) may also define those in string.h,
> but the manpage says that's a backward-compatibility thing,
> so we shouldn't rely on it.
>
> -- PMM
>
>

--000000000000cf7c9e064defef49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Mar 26, 2026 at 6:20=E2=80=AFPM Peter May=
dell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk &lt;<a href=3D"mailto:kk=
ostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/qemu/osdep.h | 1 -<br>
&gt;=C2=A0 1 file changed, 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>
&gt; index f151578b5c..2f0e61ad6b 100644<br>
&gt; --- a/include/qemu/osdep.h<br>
&gt; +++ b/include/qemu/osdep.h<br>
&gt; @@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);<br>
&gt;=C2=A0 #include &lt;stdio.h&gt;<br>
&gt;<br>
&gt;=C2=A0 #include &lt;string.h&gt;<br>
&gt; -#include &lt;strings.h&gt;<br>
&gt;=C2=A0 #include &lt;inttypes.h&gt;<br>
&gt;=C2=A0 #include &lt;limits.h&gt;<br>
&gt;=C2=A0 /* Put unistd.h before time.h as that triggers localtime_r/gmtim=
e_r<br>
<br>
This needs more rationale about why we can drop the header.<br>
POSIX says it brings in ffs(), strncasecmp_l() and strcasecmp_l(),<br>
which we don&#39;t use, but also strcasecmp() and strncasecmp()<br>
which we definitely do use.<br></blockquote><div><br></div><div>Will be ok =
if I replace=C2=A0strcasecmp with g_ascii_strcasecmp (and other functions)=
=C2=A0<br></div><div>in the full QEMU=C2=A0tree?=C2=A0</div><div>=C2=A0<br>=
</div><div>Currently, I see in QEMU we have a mix of=C2=A0strcasecmp/g_asci=
i_strcasecmp.=C2=A0<br></div><div>In some places we use glb2, in some=C2=A0=
libc.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
Some libcs (notably glibc) may also define those in string.h,<br>
but the manpage says that&#39;s a backward-compatibility thing,<br>
so we shouldn&#39;t rely on it.<br>
<br>
-- PMM<br>
<br>
</blockquote></div></div>

--000000000000cf7c9e064defef49--


