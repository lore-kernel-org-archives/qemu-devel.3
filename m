Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54509C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAW4d-0006MG-I7; Thu, 01 May 2025 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uAW4b-0006Ll-Nz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:43:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uAW4Z-0005jw-PJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:43:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so1647366a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746114218; x=1746719018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T1SAqMDJ5jJs5oF5beA0wYsapWxBF8EiItJpg1Hu60Q=;
 b=CiB36qNlJIgpxJ5f2PV5qTVQIKyTPEWeY1Sj51w7SMyJlnSH6J2ROWhjdVyc7FzYkQ
 ThPNzWl/mFgeJSE6iR3GCUYEEDIh+49Y3KQqJreIrMjztrNy99kjFu/vIxDeMO3tHYxi
 WHCFyRvuYmHb+cinmNeT2v6XgY3DcZvwH/nvk4WX0I9SS0txjFRy+AJSwNBmsZTc4MWj
 mHLDRI0YHey+aP4uWDBxRvONm+p1XqUmizKoJRQHZo2d5HXHTMXFRVN1A1yWEPdmBRWJ
 dEiZbivXcvegrOkbjAE04ZgXjDgBf1rLchMi+dajHI2lQpDiBfFcrgb5sEykTe2eNZL/
 QsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746114218; x=1746719018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1SAqMDJ5jJs5oF5beA0wYsapWxBF8EiItJpg1Hu60Q=;
 b=wkSsKO7fkxlXjtNOE8lc0IvpKl8Kwq3EZFbr5Xr9hHIZBl/7AK8rh+t7+UuNOTfI3h
 oO9VpMG0UMSXIPO+zK1KbUG4OLr1ANp72JmvfEuhxj1frtdmSc5Y5DFBDrN/gojfcxEf
 xb2pUVNFckW1++dSQ4rhk8xsZ44BCBaBvV58G8Xs/g/Md5a2JsCrUd1Qr9EM2HlMzYVe
 0jCTbza6OYaqYNiPeVH+ukse/zCWBecG+lFg2rxPg9EWkAE7IjTHPB+loeHTPtkOxkdn
 Ihl54Ox8cny21j6JDmQhslP9xVDkKAorz+ZmKSpRe1EbRs6kzfzgumyjB/k11FA+N9im
 vt/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAzsRw6evGLotgqoIssYieLyK3EWu5Vceuy7n0FZB8PQWIRvok7wd/GTdwkFCzxqPiMXtKCJrWTJHi@nongnu.org
X-Gm-Message-State: AOJu0YwvMN97jXBbSZ7fL35Fz7QUScsoeJEkkH/S9bgadWFQ/Z/j8qV3
 tvxqss16RO6mCd4Pga+0gsYEM9cphxPtAKBAPZ5+cStZfZM4DRJwr0YOZVXjzEBp/wkntg2Lb/2
 CE3He605pm7t9ufk3+DITnBoNe8c=
X-Gm-Gg: ASbGncsNpIERzM/HyimERTHCm9ZQuIsUqIcaQWDOIEDtPjkzQ8yXF+flaWQGfDjOGFC
 70kVmOE5uvztXplJbtDqpQ975jLrW1bHD4eZd26fBFSU+85Z+DJiz7Yl5SRcAfXBi/gXkNL6YBR
 JN8c5wLTeZ/AT3CXcV5ERS
X-Google-Smtp-Source: AGHT+IGBH7D5RwzgQchXmPfjaqNwU6AGQMPO95/jQBQYNs0klau5k/KL+Rog0U7rCfdXUSGUb6ELRQBpf2VADyDYD54=
X-Received: by 2002:a05:6402:510e:b0:5f9:3174:dcbf with SMTP id
 4fb4d7f45d1cf-5f93174e0bfmr1122068a12.32.1746114217959; Thu, 01 May 2025
 08:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
In-Reply-To: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 1 May 2025 11:43:28 -0400
X-Gm-Features: ATxdqUEhH8l-nuYbD_VAJhm_50li1KgVsFTfySxIc_cwfC9E7_sSpJRZui6amas
Message-ID: <CAJSP0QVpxQDfuBOQiMyP41ufaJ=56Xh2sRhWSON=FvVuxDabaw@mail.gmail.com>
Subject: Re: OSUOSL in trouble
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Hajnoczi, Stefan" <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b2eb0e063414e505"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000b2eb0e063414e505
Content-Type: text/plain; charset="UTF-8"

On Thu, May 1, 2025, 01:11 Paolo Bonzini <pbonzini@redhat.com> wrote:

> From LWN
>
> > Lance Albertson writes that the Oregon State University Open Source Lab,
> the home of many prominent free-software projects over the years, has run
> into financial trouble:
> >
> > I am writing to inform you about a critical and time-sensitive situation
> facing the Open Source Lab. Over the past several years, we have been
> operating at a deficit due to a decline in corporate donations. While OSU's
> College of Engineering (CoE) has generously filled this gap, recent changes
> in university funding have led to a significant reduction in CoE's budget.
> As a result, our current funding model is no longer sustainable and CoE
> needs to find ways to cut programs.
> > Earlier this week, I was informed that unless we secure $250,000 in
> committed funds, the OSL will be forced to shut down later this year.
>
> I propose migrating the two VMs we have to Digital Ocean and scrapping the
> DO Kubernetes cluster. However that means we need to move CI to Amazon in
> the next 1-2 months, before the Microsoft credits expire.
>

I agree. I will also apply for the next round of Amazon funding.

Paolo, please let me know how I can help with migrating VMs or setting up a
CI Kubernetes cluster on Amazon.

Stefan

--000000000000b2eb0e063414e505
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, May 1, 2025, 01:11 Paolo Bonzini &lt;<a href=
=3D"mailto:pbonzini@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto">From LWN</div><=
div dir=3D"auto"><br></div>&gt; Lance Albertson writes that the Oregon Stat=
e University Open Source Lab, the home of many prominent free-software proj=
ects over the years, has run into financial trouble:<div dir=3D"auto">&gt;<=
/div><div dir=3D"auto">&gt; I am writing to inform you about a critical and=
 time-sensitive situation facing the Open Source Lab. Over the past several=
 years, we have been operating at a deficit due to a decline in corporate d=
onations. While OSU&#39;s College of Engineering (CoE) has generously fille=
d this gap, recent changes in university funding have led to a significant =
reduction in CoE&#39;s budget. As a result, our current funding model is no=
 longer sustainable and CoE needs to find ways to cut programs.</div><div d=
ir=3D"auto">&gt; Earlier this week, I was informed that unless we secure $2=
50,000 in committed funds, the OSL will be forced to shut down later this y=
ear.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I propose migrating=
 the two VMs we have to Digital Ocean and scrapping the DO Kubernetes clust=
er. However that means we need to move CI to Amazon in the next 1-2 months,=
 before the Microsoft credits expire.</div></div></blockquote></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">I agree. I will also apply for the n=
ext round of Amazon funding.=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo, please let me know how I can help with migrating VMs or s=
etting up a CI Kubernetes cluster on Amazon.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Stefan</div></div>

--000000000000b2eb0e063414e505--

