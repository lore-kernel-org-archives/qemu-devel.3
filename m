Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C532110A88E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5noV-0006xP-8G; Thu, 26 Mar 2026 12:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5noT-0006x0-Q1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5noR-0005iz-Na
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774543442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwHTe8ieVuYoKhBgW/zXH3lQtkUmzTsi18GIPiqbaWQ=;
 b=eblgONBaTAmNOk7LKDBSrOTkRpLm+MdaWBxpvzXJU2uX5N41duoxI4rQm4dcu4gsjgF2oP
 CEMKI0iZDZbtlcdrqC3mmqDzi7723DD4ykVf6sz89cRK7ptUpqbI2Au19yPtP4uONRyIM2
 aZwQfXDWzftVEHZELHnwnA6jyKsKJL4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-xAgZG4vIM3KlPbsjXkxY1Q-1; Thu, 26 Mar 2026 12:44:00 -0400
X-MC-Unique: xAgZG4vIM3KlPbsjXkxY1Q-1
X-Mimecast-MFC-AGG-ID: xAgZG4vIM3KlPbsjXkxY1Q_1774543440
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899e89bf366so36515696d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543440; cv=none;
 d=google.com; s=arc-20240605;
 b=ZF0BvjA9L+KhjgVCLHPGlvau/X1BgZMQ+x+71F7egjXm9zFbhLxGRoO/oumZ3Tk2uJ
 34bS8vYABfYLYiitYxq036hP55g2D/Akl5xNw+OSKTq4OPqmFyo34aITFd+XSTBIvfhC
 RdCaB9t4Sf6XBFrBkiZgmA9r60H5XxhUT3KRFyZM1L/FUL7+2MEsP+sFOAEKHA4L8Ua0
 K4O0uDuIGFvKCZ6S1tdel0u182Od0IukdjPgv1rzBEPqiza+Gp3V6Ku/L+DSf8W5uvdT
 GifnN5cF4cliAQUFccu33sJCXZSVcsckos49ngTY192ocfEOgQNsXZg0Nu/WRmGMrUMc
 P7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pwHTe8ieVuYoKhBgW/zXH3lQtkUmzTsi18GIPiqbaWQ=;
 fh=Nvj5cnyRZEdzWBUIkmUFOLUNlIu7hIIJHYSkjBsffXI=;
 b=fUgJ3OBUTmc7iVC72/PNHr2nFchYVl3UtSO8qz/p71XkbYGLLoX/IkzzuEspn7VY3P
 OS4fBBwm2IMEdfasKnMoayB3Tr6T/yK9kyxp6UvEftRhLiK9ZPIb7lojB9tKFIzqTWx8
 Trsk/lxWS8wIG+QVX/Eij940sTcvLs2ej5S1+MkgWPonHx3bhgXeS8XqQtaFlEWegrA7
 bpLq7ObV/IBRvAYf9MFB2BotVJEKHEWA0hibSP+RsFbUkaJE+ifawORox4ND9wt61dzX
 03kar62oNiWEEOCOLUJeLqGH2F+5uRST9L4qdtEk7uFr+KHKaqSaU/J7iZpNYS0N3hXS
 NPEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774543440; x=1775148240; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pwHTe8ieVuYoKhBgW/zXH3lQtkUmzTsi18GIPiqbaWQ=;
 b=MEFsH/Ao9E5wtY8ktcLG/JLepX5Nt5bmjUANd+Em/u4TiJoiT4N66lC/Ccf8dgA9Sa
 NUn4cR+JDaNf2264MMmBoXc0akkgzVdk/x5MfU9CE62R3rhSPoxkDJmJMeHysnv9zgDr
 hRrQOX7v8cfYenJgzmcMW4Vs6o54klhikyoo9WV8J4TnPoZQEBr6Wjd29YpUXbGnInlK
 Z408ibz6AxQ/FThnQhpNxb0kgN07QKjicE8J0RaMnMTozaWuW9YHuYkoz+aytH3NGmF0
 BpGrDRWK5yi8SFgZmKSVNMtWfzvrZ1uqh+/uhl/z8bV7snIEpl5UJFgJDuYd3f67hpp0
 I+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543440; x=1775148240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwHTe8ieVuYoKhBgW/zXH3lQtkUmzTsi18GIPiqbaWQ=;
 b=ViFCFvd8Q0qjk7erR6IbVQYBn4j8MizoCJp1nixUJPkVq+oF/1HvVEqHEvM4dtL5Ea
 4FBHKanr4p9m2Fms/p95UMm/M/Lx8p2Vk9mIKfDcn4qSMj57S3WkraEXRxPbeY3Ie8Jg
 yul7JiKqqNHrAdax+fDdxWJuRdqCBtDRsk6D6L7+Pha1uGIcJNf1hhueKp35WhKl3AYP
 V563e191w8Cy0x1kto7nTlgS1ouDlbSW0NA2PcqkhYn6VMPydvEfVsqv8yR01uP9fhS4
 g+Vidu7SPoJ3CzuJsd4JdPeQ/FRp/iprVzpE/B9e0Xyl2hCdv5AJA3DPbMmptjjen5iD
 YO6g==
X-Gm-Message-State: AOJu0YxwR/x/CL8Rpbn88qCvLmGlflUIxMt0YhIUK+qNieq+b/fkYUmF
 b+sbRF/5hN/ovEPOO3aQOXXVWqMXBCH19h0Jl4VceYOjhdAg/8z46T36e+iQGxijWZWwb0A6KtQ
 Jmi7ZNrCzuw1jmOjHbHrQCwUGWAIslvrEo42UCUBy6fijUZYXFo1tMNw7NwL0JSAAzYMOijKrU4
 L7BFR6g1TrVOVvwrSNVUGKZqJm3vbCGX4=
X-Gm-Gg: ATEYQzySacnRounj8eHaSpIHVPwMaCvfNddOMf75v8s/SkjLC9XKqqQzwHaxsMEQ/P1
 C5TNovf7dVOhsa5/87J7XFVKLEuroZ6Y7LXGnxxHtcCNesHWd6PI/J7dc/COz3Bc0xGZZeQvYvl
 lXgyYEGw+g5TlCgqPECUje8uyVrVXrw+8tHdjlzZ9sgrjn+r56dAv7V9+Q0Hkx8WctZxjxwm9NW
 Fwrxbji
X-Received: by 2002:a05:6214:2e44:b0:89c:8cc8:7c6a with SMTP id
 6a1803df08f44-89cc49841c3mr116602596d6.5.1774543439734; 
 Thu, 26 Mar 2026 09:43:59 -0700 (PDT)
X-Received: by 2002:a05:6214:2e44:b0:89c:8cc8:7c6a with SMTP id
 6a1803df08f44-89cc49841c3mr116602086d6.5.1774543439063; Thu, 26 Mar 2026
 09:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
In-Reply-To: <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Mar 2026 18:43:48 +0200
X-Gm-Features: AQROBzCgg7T-XVZzMrGuYXPeNadVkYOwl33wHkkHaPuhrQW4IDsURR8exRPEMQ8
Message-ID: <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005301cb064df017f3"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000005301cb064df017f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:35=E2=80=AFPM Mohamed Mediouni <mohamed@unpredict=
able.fr>
wrote:

>
> > On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> > This is the first set of changes to allow building qemu-ga with
> Microsoft Windows Clang.
> > It includes some cleanups and fixes that also make the code more
> portable.
> > The main goal is to be able to build qemu-ga with the MSVC toolchain
> > because MinGW-w64 is not available for ARM64 Windows.
> >
> Hello,
>
> MinGW-w64 is available for arm64 Windows, although it=E2=80=99s more

mature with Clang as a compiler instead of of MSVC.
>

I expect to use clang from the MSVC environment, not the MSVC compiler


>
> Is it more of a packaging issue with distributions?
>
> Thank you,
> -Mohamed
>
>
>

--0000000000005301cb064df017f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><br></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 26, 2026 at 6:35=E2=80=AFPM Mohamed Mediouni &l=
t;<a href=3D"mailto:mohamed@unpredictable.fr">mohamed@unpredictable.fr</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt; On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk &lt;<a href=3D"mailto:kk=
ostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; This is the first set of changes to allow building qemu-ga with Micros=
oft Windows Clang.<br>
&gt; It includes some cleanups and fixes that also make the code more porta=
ble.<br>
&gt; The main goal is to be able to build qemu-ga with the MSVC toolchain<b=
r>
&gt; because MinGW-w64 is not available for ARM64 Windows.<br>
&gt; <br>
Hello,<br>
<br>
MinGW-w64 is available for arm64 Windows, although it=E2=80=99s more=C2=A0<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">mature with C=
lang as a compiler instead of of MSVC.<br></blockquote><div><br></div><div>=
I expect to use clang from the MSVC environment, not the MSVC compiler</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Is it more of a packaging issue with distributions?<br>
<br>
Thank you,<br>
-Mohamed<br>
<br>
<br>
</blockquote></div></div>

--0000000000005301cb064df017f3--


