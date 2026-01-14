Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0689D39000
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 18:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg5Bn-0001JJ-AK; Wed, 14 Jan 2026 13:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vg5BK-0001BL-1u
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vg5BI-00030k-3j
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768413677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rac4gVT1tSjjgnqwurDIfAEgN8bzCpei57YWEAJRSGo=;
 b=aIA/znxpTCe+z7k0pynrquILbiJDI+w7LQVn+cBOKzQ/shf9piq8+xa6Q/jDb+k05L1kL4
 JTMgPDdhyzzjqElciIGpf1glMOFE+VHoXuWC3tg4sGDiM8lnlU2UA9arpZdH1mzw97uSJu
 9wchgowLmAbo2dmvraqoUUSyUfDKLf4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-bVjLI6gXNIChQ1cGDMcpCQ-1; Wed, 14 Jan 2026 13:01:15 -0500
X-MC-Unique: bVjLI6gXNIChQ1cGDMcpCQ-1
X-Mimecast-MFC-AGG-ID: bVjLI6gXNIChQ1cGDMcpCQ_1768413675
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c38781efcso8827358a91.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 10:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768413675; x=1769018475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rac4gVT1tSjjgnqwurDIfAEgN8bzCpei57YWEAJRSGo=;
 b=glAx57LqQa5EIC5QfFEQIWar8FmsNv8BPq4hS5Nx7DZiVZLUCiTsIisN7MOmT96GhJ
 fMKLnpkCBMNlolzN0z3DqUW7KOub8MHbbNBrMJH2hbXtk+5BtxCLOU4XL37RV0ohUxPg
 xflcx3gINut8TofJRtkREBJZgq9OLQDMA15QgMK+JF1hdkRiZbdn15h8Bynt9EFKBtai
 reqviPO5RMcw8pPzvHbtUytXOYQ25fgPLz/rZx1rA9LW8Y/9HMioNIDvWoeRaqQReWGk
 dMSWEss/ZNAmME8lNmEn4QDwYPhsCptbe2y2EcACs9TUcuihwbwgAIgzBU+TkHmMzT+p
 fhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768413675; x=1769018475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rac4gVT1tSjjgnqwurDIfAEgN8bzCpei57YWEAJRSGo=;
 b=GJly9CGHz/s07acvCn4XjHxHBinx2edwB+MvozSNiL+PU3tICNslDI7wpa2DzIDgfl
 lSTMU7Ns2n2IIxsKaErGUPC8RbFTWBypppbB1vLSDxu0/MFiBYJD1uiHTEGm4mBd5Fqu
 Kg2Y5e+p494jx7av3cAMw6QBACxt0oTjWG1DsD9k7jgXNwUhrxpwqAZXSBXYbHIDqcJ8
 JCCYZq7dWG3FOxmC80k7nPmj1kW/hD6GkoXtn2W8TxLPpRk/V9CyY/UgMekGQwkrwnnN
 VlENxekIgYHH1wMPrWVTqMn4jYKZkcmLT0aNmTmh8/47pW0zbDjnkXUp/M5RFHMpoczP
 pwpw==
X-Gm-Message-State: AOJu0Yxnc5aiiwxR5b5cnuFWRT9WjFoQZqgG6CEuZTRXQUl7P3Pcd3YV
 FCbl4umyRUAQK90kmt5S5fXRx59QD5IkeTi5IZXh6gKnmMvGF2k1DEWc7SwFSrTWDKyNYn3bxZ3
 2tf6f30SyFB5jKbu5adulJhXfxEFmkXjCbz0ff9kwzAYDccSX5u/6dKrhXfpKCEIX+l8dYAuo2B
 Z2of5lM6Nxx2KwNbrzOzHNfoA4hBiGptU=
X-Gm-Gg: AY/fxX5DNLKqcZcs1Drq4fafopuQWU0O0BpxiX7AqVW8AkMaDRPjeYU9jT7AYX9NHtg
 22tunEVgrO05NqFaxhTehK3yRfMfFFtQjgJRoPNetoPdPHKfnyWQwQkbxnAYpowTcVrBDLx0Xae
 QvwmaTXGw1HUUCTE2xVn/XSRcAXZv+JHc3EORpL8IO92SyXeqo75oPOw2j09eqIj91VqI74j6gC
 NNQKx+U9b/dZ3Tb0c0L2OUMXQ==
X-Received: by 2002:a17:90b:4b12:b0:34a:e9b:26b1 with SMTP id
 98e67ed59e1d1-35109130655mr3668722a91.26.1768413672494; 
 Wed, 14 Jan 2026 10:01:12 -0800 (PST)
X-Received: by 2002:a17:90b:4b12:b0:34a:e9b:26b1 with SMTP id
 98e67ed59e1d1-35109130655mr3668464a91.26.1768413669609; Wed, 14 Jan 2026
 10:01:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
In-Reply-To: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Jan 2026 22:00:57 +0400
X-Gm-Features: AZwV_QjeZOAr7_qdDH8vGJHRHPgOpr_S4fW8ljfJI9RUGnaQIXInwmFwzdcBwpE
Message-ID: <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000097ebef06485ce4b4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

--00000000000097ebef06485ce4b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jan 6, 2026 at 1:47=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:

> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code internship
> program again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email by
> January 30th.
>
> About Google Summer of Code
> -----------------------------------------
> GSoC (https://summerofcode.withgoogle.com/) offers paid open
> source remote work internships to eligible people wishing to participate
> in open source development. QEMU has been doing internship for
> many years. Our mentors have enjoyed helping talented interns make
> their first open source contributions and some former interns continue
> to participate today.
>
> Who can mentor
> ----------------------
> Regular contributors to QEMU and KVM can participate as mentors.
> Mentorship involves about 5 hours of time commitment per week to
> communicate with the intern, review their patches, etc. Time is also
> required during the intern selection phase to communicate with
> applicants. Being a mentor is an opportunity to help someone get
> started in open source development, will give you experience with
> managing a project in a low-stakes environment, and a chance to
> explore interesting technical ideas that you may not have time to
> develop yourself.
>
> How to propose your idea
> ------------------------------
> Reply to this email with the following project idea template filled in:
>

Rather than replying to this mail, I sketched some ideas of things I have
in mind on the wiki directly:

https://wiki.qemu.org/Internships/ProjectIdeas/RDPUSB
https://wiki.qemu.org/Internships/ProjectIdeas/VFIOUSER
https://wiki.qemu.org/Internships/ProjectIdeas/ModernHMP
https://wiki.qemu.org/Internships/ProjectIdeas/mkosiTestAssets

I will try to reach the various people involved in those related projects
to see if they are reasonable proposals.

We have a lot of ideas on the wiki (
https://wiki.qemu.org/Internships/ProjectIdeas/), that have various
status.. I wonder if they wouldn't be better under qemu.git docs/ with some
form, so we could send patches to discuss them instead. Arf, a QEMU
Enhancement Proposal, I have too much ideas :)

--00000000000097ebef06485ce4b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 6, 20=
26 at 1:47=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.=
com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Dear QEMU and KVM communities,<br>
QEMU will apply for the Google Summer of Code internship<br>
program again this year. Regular contributors can submit project<br>
ideas that they&#39;d like to mentor by replying to this email by<br>
January 30th.<br>
<br>
About Google Summer of Code<br>
-----------------------------------------<br>
GSoC (<a href=3D"https://summerofcode.withgoogle.com/" rel=3D"noreferrer" t=
arget=3D"_blank">https://summerofcode.withgoogle.com/</a>) offers paid open=
<br>
source remote work internships to eligible people wishing to participate<br=
>
in open source development. QEMU has been doing internship for<br>
many years. Our mentors have enjoyed helping talented interns make<br>
their first open source contributions and some former interns continue<br>
to participate today.<br>
<br>
Who can mentor<br>
----------------------<br>
Regular contributors to QEMU and KVM can participate as mentors.<br>
Mentorship involves about 5 hours of time commitment per week to<br>
communicate with the intern, review their patches, etc. Time is also<br>
required during the intern selection phase to communicate with<br>
applicants. Being a mentor is an opportunity to help someone get<br>
started in open source development, will give you experience with<br>
managing a project in a low-stakes environment, and a chance to<br>
explore interesting technical ideas that you may not have time to<br>
develop yourself.<br>
<br>
How to propose your idea<br>
------------------------------<br>
Reply to this email with the following project idea template filled in:<br>=
</blockquote><div><br></div><div>Rather than replying to this mail, I sketc=
hed some ideas of things I have in mind on the wiki directly:</div><div><br=
></div><div><a href=3D"https://wiki.qemu.org/Internships/ProjectIdeas/RDPUS=
B">https://wiki.qemu.org/Internships/ProjectIdeas/RDPUSB</a></div><div><a h=
ref=3D"https://wiki.qemu.org/Internships/ProjectIdeas/VFIOUSER">https://wik=
i.qemu.org/Internships/ProjectIdeas/VFIOUSER</a></div><div><a href=3D"https=
://wiki.qemu.org/Internships/ProjectIdeas/ModernHMP">https://wiki.qemu.org/=
Internships/ProjectIdeas/ModernHMP</a></div><div><a href=3D"https://wiki.qe=
mu.org/Internships/ProjectIdeas/mkosiTestAssets">https://wiki.qemu.org/Inte=
rnships/ProjectIdeas/mkosiTestAssets</a>=C2=A0</div><div><br></div><div>I w=
ill try to reach the various people involved in those related projects to s=
ee if they are reasonable proposals.=C2=A0</div><div><br></div><div>We have=
 a lot of ideas on the wiki (<a href=3D"https://wiki.qemu.org/Internships/P=
rojectIdeas/">https://wiki.qemu.org/Internships/ProjectIdeas/</a>), that ha=
ve various status.. I wonder if they wouldn&#39;t be better under qemu.git =
docs/ with some form, so we could send patches to discuss them instead. Arf=
, a QEMU Enhancement Proposal, I have too much ideas :)</div><div><br></div=
></div></div>

--00000000000097ebef06485ce4b4--


