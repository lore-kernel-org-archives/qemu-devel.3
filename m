Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A825C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp906-0004eU-RS; Mon, 03 Mar 2025 11:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp904-0004eI-Jo
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp901-00034E-TJ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741020629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tgJADLqh85I7Ie74lMyM0bOFSMJIbVF1rQTeApsbqe8=;
 b=TzoV4bdMgWez4v4IMiBJDJl+VvnPEN4l+SoM6mCxX5gE2z+RZlKojRZT6q+BSh0gzm+wSS
 HtKluPJJdDX2BQCLGK/q0yuNr5ycv103AIxXvJz/vV/7Q+b9vzUvKaZYUM4JzKJ5pYQ+02
 mbl2qgMCBPn2pGF/9IujVVmXf8BZd8s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-oGxzFxOCMKqBbW3GkeDviA-1; Mon, 03 Mar 2025 11:50:26 -0500
X-MC-Unique: oGxzFxOCMKqBbW3GkeDviA-1
X-Mimecast-MFC-AGG-ID: oGxzFxOCMKqBbW3GkeDviA_1741020625
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2236b6fb4a6so111027335ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741020625; x=1741625425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tgJADLqh85I7Ie74lMyM0bOFSMJIbVF1rQTeApsbqe8=;
 b=HMXj8JivmVGcxC+IoZvCPWDsR5ZIF2Vvk9Ak4Ed/smFihdFAdczuIRly1FrdtqAK+b
 Df2KtpaL2JBmDUTRaSD31nYuS4wLDHN2gafF0SzBIo7cn6UMTEEmkJ5CR9IHztschU6C
 q4aThi6W8Ci1nxVy+BekQxNJBR9Hm9gz0kig5zegG+Twnuo4/kdI+xj5+dYHw3YjJRnM
 imxswrd1K/lDR4lHXsFVOob0+tao/0IMwTd/FjZcSveB3Talne57oYBEHarlc25CGRmE
 LGOonPO3T9//Z6uRrzk0cQZpxSChWSCgiFu8y4Iv0/cE5Wq0+hoTt1NYc9fqtpgNH8Wf
 vWlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKHLxV2/nQFRCaSSusQiY9uugGpc4NWdTnj4EGMw89SKKSWNvUfigWYz+46gg0YQkYDklyGc/sGV+o@nongnu.org
X-Gm-Message-State: AOJu0YwLXm8gj2oaiXPGhakcZAOmH/H2VXE3P3XWZUN9aF5qIix7br/C
 DvCpW1Ax5fyhdDK3XUIcmM5mGhErVPFSGdPUfU/Wxttkx+EgQ2MvDYCHf0gneGVZ1BZ+2aVY4sA
 3P4l6J7AiT1xMv49pvtxGvQFillmFNCZZe8ruVUoUWhL3qQQanWpj3M6ZE7Sxht6lvDBucfl3wB
 4WkuC6RaIH3wXMVLBaHG/ouiPU6sw=
X-Gm-Gg: ASbGncsbBHcAvoOexlcCEnIWyyKCeAwW9mn1w4CvXe2pTyLmw8Np7q7Bl29/0VNwdoL
 SVIl2DyDiusLGWKtrT0T/FzYclSKVDhiR1tkNdY90XnER/ZVHOqD7LX7KM2XGTYedhZtkmCih
X-Received: by 2002:a05:6a00:2e05:b0:734:b33:d8ec with SMTP id
 d2e1a72fcca58-734ac32e963mr20637727b3a.1.1741020625121; 
 Mon, 03 Mar 2025 08:50:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4StgDLNGBBjKUu8i36uKhexYPEsnBVbc0givmd/nkQeU/ZPjO+Ymj4UJH0XD7VCMQtz6+CgxzgXCp4AhfxQ8=
X-Received: by 2002:a05:6a00:2e05:b0:734:b33:d8ec with SMTP id
 d2e1a72fcca58-734ac32e963mr20637695b3a.1.1741020624818; Mon, 03 Mar 2025
 08:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
In-Reply-To: <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Mar 2025 17:50:10 +0100
X-Gm-Features: AQ5f1JpKgfxBP9BBoc7sRuIlyo7jBQAskFijEz8rBw3jkWuohOBjULh18j_r24M
Message-ID: <CABgObfZ4-qKX5SCp+3fD2a54SVUZ3+fA--gq6=tf1idjQYVTrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel <qemu-devel@nongnu.org>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e3b2ae062f72f30c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000e3b2ae062f72f30c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 3 mar 2025, 16:05 C=C3=A9dric Le Goater <clg@redhat.com> ha scritto:

> On 3/3/25 15:46, Paolo Bonzini wrote:
> > On 3/3/25 15:30, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> I see PPC is defined in target/ppc/Kconfig so I think these mark th=
e
> target not the host. Vfio-pci works with qemu-system-ppc
> >>>
> >>> I've seen people do this on x86_64 host
> >>
> >> Since this patch does:
> >>
> >>    LINUX && PCI && (...  X86_64 ...)
> >>
> >> these users won't see any change.
> >
> > This is wrong---clearly this patch was never tested on the 32-bit
> platforms where it was supposed to have an effect.
>
> euh it was.
>

Uff=E2=80=94I should have said was *only* tested on the 32-bit platforms wh=
ere it
was supposed to have an effect! The problem is with the 64-bit hosts...

With this patch, on 32-bit and 64-bit host systems :
>
>    # build/qemu-system-i386 -device vfio-pci,?
>    # qemu-system-i386: -device vfio-pci,?: Device 'vfio-pci' not found
>
> Same for qemu-system-ppc and qemu-system-arm
>
> What I am doing wrong ?


... Where you were testing the wrong target. :) qemu-system-i386 should
still support VFIO if compiled on a 64-bit host, according to the subject.

Paolo


>
> > For VFIO_PLATFORM, no objections to deprecating this.
>
> Good let's do that !
>
>
> Thanks,
>
> C.
>
>
>
>

--000000000000e3b2ae062f72f30c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 3 mar 2025, 16:05 C=C3=A9=
dric Le Goater &lt;<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a>&gt;=
 ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
3/3/25 15:46, Paolo Bonzini wrote:<br>
&gt; On 3/3/25 15:30, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt;&gt;&gt; I see PPC is defined in target/ppc/Kconfig so I think =
these mark the target not the host. Vfio-pci works with qemu-system-ppc <br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;ve seen people do this on x86_64 host<br>
&gt;&gt;<br>
&gt;&gt; Since this patch does:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0 LINUX &amp;&amp; PCI &amp;&amp; (...=C2=A0 X86_64 ...=
)<br>
&gt;&gt;<br>
&gt;&gt; these users won&#39;t see any change.<br>
&gt; <br>
&gt; This is wrong---clearly this patch was never tested on the 32-bit plat=
forms where it was supposed to have an effect.<br>
<br>
euh it was.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Uff=E2=80=94I should have said was *only* tested on the 32-bit p=
latforms where it was supposed to have an effect! The problem is with the 6=
4-bit hosts...</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
With this patch, on 32-bit and 64-bit host systems :<br>
<br>
=C2=A0 =C2=A0# build/qemu-system-i386 -device vfio-pci,?<br>
=C2=A0 =C2=A0# qemu-system-i386: -device vfio-pci,?: Device &#39;vfio-pci&#=
39; not found<br>
<br>
Same for qemu-system-ppc and qemu-system-arm<br>
<br>
What I am doing wrong ?</blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">... Where you were testing the wrong target. :) qemu-sys=
tem-i386 should still support VFIO if compiled on a 64-bit host, according =
to the subject.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
<br>
&gt; For VFIO_PLATFORM, no objections to deprecating this.<br>
<br>
Good let&#39;s do that !<br>
<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000e3b2ae062f72f30c--


