Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A114010BA42D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w60A1-00088u-MA; Fri, 27 Mar 2026 01:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w60A0-00087n-GH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 01:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w609y-0001sA-S8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 01:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774590906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=03EVKB6fewwDocXTeyXtHvVFAw7W/xFOrFdEzUs16n0=;
 b=ITC2DBseFpwCzq7GVltTdVVWLaP2JayhvBLTDfbTjN1CWCqwt3jo1bDTlsaLAvzisImgSl
 eI5jEu1ryjNZ5XL2nEOpoxILfK8bfNmbir49dbtwzwaEfFuckK6mBWPPeXP4JOB0/jqaEn
 z4Vr47zKmfd9MzpRp/jlABg7ICROTbA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-2d2QWR98MHKCQacb2GI0rA-1; Fri, 27 Mar 2026 01:55:03 -0400
X-MC-Unique: 2d2QWR98MHKCQacb2GI0rA-1
X-Mimecast-MFC-AGG-ID: 2d2QWR98MHKCQacb2GI0rA_1774590902
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48531e6012bso19988035e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 22:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774590902; cv=none;
 d=google.com; s=arc-20240605;
 b=VeI4xHxVnKVnR8eAEwrlXgePqLiPwLH8JOpu/YAmDW3nnCH/ijClAor2YaB6SlDcXQ
 dYufO3bKAQpOD0Nw6nAZ5BRcg+quk3nWPRAYyppeZmdiy2qzh+vAabDryrn0kEsUYbL0
 aVOVjmCwgbKLx3hNbTBPCQ6M7B4lgrPni5b0HRD95tRcGYbE9cW7qKYAa9Lt7D3bCkyr
 p2IwxVzXcAZIkASKxvjrIZ88ovAheI4Dauz7xPWHZZIIW4lp+l27NnSWfjjyVMJ8rfMb
 nUcTXKOfzKgvGdtK3VxhiDPkgPJryeEac+8L2Xpi56wWSJsuFtZ1/oVuakChnogkjWwY
 qx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=03EVKB6fewwDocXTeyXtHvVFAw7W/xFOrFdEzUs16n0=;
 fh=oplsUAZLlUeIeHYL+uMskN//dSkzki86JD3O2VV2NWI=;
 b=kWuNuVUao+puZ1jqzmxRDGADpAx9IUTJopvaTvFLyaonRyJIPAbFJAbPIDQXTKkfV5
 PNIOJ7lZeC6XFyxkeh2iK54QFM0yZBy8EOQjU/rZHq5Lds+TrYN0WryX6kkrm7y6hxMl
 +lIu3Eskyr3zSyfZnJYMv2fWmFxcTE7uFjPbULnAoCBzo5zCJqk8fa1KtSleng+fcLM5
 dRcciaZyqXA4MIWZuX44Vk3XNX+mExdipNeDYx6mRIgBaTBTPCO4x3iogsrF3Mxyetfd
 yBjfbP6dOZiXiy2vPWtWY9odsQsyjr+iNo9IAxiyDFNj51c8Wr0YgPgIOd1Km3Aw2VHm
 iVLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774590902; x=1775195702; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=03EVKB6fewwDocXTeyXtHvVFAw7W/xFOrFdEzUs16n0=;
 b=Y3vRyYQDvllRtP8ZgKst5VI7vL550daRvtXYWeBwZj3EcOf3Cx/sRuxZSxfC+k5eqn
 rtgmP5yCvC1ubFbcYJvcFvoyhnh9bBDXMYZX41Qu0q1CJFpzbLUS8UcElBPVenGzfDnj
 4i+XHtfVbIS1fG7V8QG/Um0Txta4az9DcfpuI/RpkgX8XwrBL/ta+Y4ktxj2h6ULge/0
 sw/L8oYnlck837s5sD/pCmlFpy6w+4oAYcPyoxZL72wABYWqOuu+N8RGoCDM9oEyMmip
 x4vL89hLYepl/qqjaQlwGHBgbj2N7UeEYOGA+FWKcTcMBdJQC9WKNnIiCP+eORw+uICm
 lM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774590902; x=1775195702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03EVKB6fewwDocXTeyXtHvVFAw7W/xFOrFdEzUs16n0=;
 b=oV8cvOUve/BImievs1avUw2RvTuV26K/yOBKG0yeihfSXneR0ByjnET4Z+9iPT0Jh3
 llX2Z8AZNW0FUZa4YZ+kbzNKNoOfmzRb7hpGJyVY8eSIzd/H7jANU+HaI2fVIQM1HhxK
 lrs3gp2HX2B9WoEU+VU14UUcEUg9dzSi7/kWLT8VFQHC69S/TgWenJ72lWzg8FwibKxg
 FBg6TNHJhwN+OWmMrXziRoUILDm8Fdo+S+7lIgoU9cWcgSNbINF9hFIWqutX5LvGFurd
 Edi89jsnW1Vjjx2MofEJ2hdLaAMloyXkc6UOb/nqj2bBvjmGJG4LC/RVhEpxDBiMRvVt
 ndoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7rzoQ29Sgs6OJtj0NG0QXxV1vm6HPHzkEdSAVpCVeDkOGP2uC81EPW80Gf73yaXqLQU1JmG+V8bDZ@nongnu.org
X-Gm-Message-State: AOJu0YxnRr2Wr4ZtPInqZfdORQisNurarrEndRcYLaONh4ZDo+aJXptp
 MdLsi1gNXOq/o4y4n1KkLdb47d6KEUBdI+8LVyYx+L4XFQY8ZBHx53OhVUKcAf7bp29vTN8QELl
 MIVk3ZyWMcNlWUh0bCXjksGAKjtz6fltoMLsMFc3Kz2wHNg6Gq4+vZgJI4vWstC/whN1Go1BhrF
 mYCTvAXpIsGO/Mo64TkAdGwgi1Xxgmp4E=
X-Gm-Gg: ATEYQzxjD5mU5ZiFj4HlxCbb5TzkNRrSSJLYiQoQ3zwks2+nWFsYYxo7wPXbW8jnB0p
 ggex4+LRV+C4DeYmLRNTev4lvbirQM0fHfg9lDHkPzem17zZGgHUOOdkgrlnBKeaSLHb36aCJr8
 Gr2zsihbxJ+uLV3uYCK+C+Xgg4XherqfntBzw7jcuQffj2qWa32FVYFpu99Z6D1iq3lwIuqUn5Z
 Pzaw7maz8/k6zT6vwslSlEeRI81xvt8LDrXCro9oJLvtLufQvXn3aVCfpjEr93GOKEEqDyTk8f9
 q6g8
X-Received: by 2002:a05:600c:3510:b0:486:ffa3:593 with SMTP id
 5b1f17b1804b1-487280abccdmr14735975e9.28.1774590902477; 
 Thu, 26 Mar 2026 22:55:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3510:b0:486:ffa3:593 with SMTP id
 5b1f17b1804b1-487280abccdmr14735695e9.28.1774590901998; Thu, 26 Mar 2026
 22:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
In-Reply-To: <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Mar 2026 06:54:48 +0100
X-Gm-Features: AQROBzD7Ff1rKEiEcZwEeFJtWC6QHOvVXNfF70idHJ9CJ9XddZI92r8BQiEQykA
Message-ID: <CABgObfaAesjQmxg-doaHu46J+oWFcCaPq3vogSc5qucmvhQ+kg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?IkRhbmllbCBQIC4gQmVycmFuZ8OpIg==?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000055ebd6064dfb2422"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--00000000000055ebd6064dfb2422
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 26 mar 2026, 17:34 Mohamed Mediouni <mohamed@unpredictable.fr> ha
scritto:

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
> mature with Clang as a compiler instead of of MSVC.
>
> Is it more of a packaging issue with distributions?
>

Yeah, I think this is about *Fedora* mingw specifically.

The packaging/version pinning aspect probably can be handled with a Meson
subproject for glib (and other dependencies if any).

Paolo


> Thank you,
> -Mohamed
>
>

--00000000000055ebd6064dfb2422
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 26 mar 2026, 17:34 Mohame=
d Mediouni &lt;<a href=3D"mailto:mohamed@unpredictable.fr">mohamed@unpredic=
table.fr</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
&gt; On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk &lt;<a href=3D"mailto:kk=
ostiuk@redhat.com" target=3D"_blank" rel=3D"noreferrer">kkostiuk@redhat.com=
</a>&gt; wrote:<br>
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
MinGW-w64 is available for arm64 Windows, although it=E2=80=99s more<br>
mature with Clang as a compiler instead of of MSVC.<br><br>
Is it more of a packaging issue with distributions?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, I think this is ab=
out *Fedora* mingw specifically.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">The packaging/version pinning aspect probably can be handled with=
 a Meson subproject for glib (and other dependencies if any).</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
Thank you,<br>
-Mohamed<br>
<br>
</blockquote></div></div></div>

--00000000000055ebd6064dfb2422--


