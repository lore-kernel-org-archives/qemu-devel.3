Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9BAEB363D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxC9P-0005o4-02; Mon, 02 Mar 2026 17:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aerosound161@gmail.com>)
 id 1vxC9N-0005nk-0k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:54:05 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aerosound161@gmail.com>)
 id 1vxC9L-00082U-2F
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:54:04 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3599019ae92so728642a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772492041; cv=none;
 d=google.com; s=arc-20240605;
 b=iRyHx5QzW+aLSjht6SVbMi3dMc6RisNzuf/kpUV0z9NFE9lR7uGmspAVKkuFFqsOUB
 FyA5MDETXZG7mxg/R64mloRZWY945OL1srrzcoUnvY6fE4w0Khf8ydAfb1k3Oq1dpq5I
 aSYxzJhjnvPMsML1cINViZWHAD4AUplZT6k6IorjfkeCyCTPPTHUP/aqhQu3hl3o/ROT
 +M6ktYPJfbdbkLoFNmGkNjhjIhIyBhQO8TBYHFfB54TLF9f/9Wgg+n2m1ExklzQuHNYK
 yq4bCp6atgPr2/wLMLhwyf9IOYyx/VjDxINV4FJag8Z7A9Lbuqz088sMWMh7eJL6N/mu
 MZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KHzbZuoMERKyiPzNzSOJUvnmQBDgxmBMbilXxOyWjlM=;
 fh=76g8U45BX02vHMJChMfTw+x9S6cGwL6ACO0wA65IZkY=;
 b=kHdJdu8L9kBbf6paV78nzwa+FaE+nYQoB+9EyT5OBBysXlVqewt8OeFU0BO59GVlxb
 q86RJR4djc7m7kXEElBokHHsrEJBimNlPR6OUCGHas8MB8Nr0YCax+yubE8kZDEJJ7wh
 X4qP1ewW8KsgeOjd/WOjGH4MlE1pV03OOjpd5t4U5zMvSMrkDvvlQCr29G9L/PJSXc1q
 jTyBmEnaLeb4IgjFP+5STmLqN/H4yynt75orlLk5pY0sPrZjzUzvAHfXWIjJ4yz2bLRE
 JcVWl2fula30e+oFCoXEU+PKc6Ibz21cAlI4AFeR3WVnnfsnWJ4xG9tIoUg8cSUOKXbQ
 9+Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772492041; x=1773096841; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KHzbZuoMERKyiPzNzSOJUvnmQBDgxmBMbilXxOyWjlM=;
 b=YACXY4j1X+kromUavn2KuoqVAvEO0rLcHhHweFdyiMi3+WPgOZv4xZdd8IJ/fUdRH5
 1WFv6nnzeqoVR1kQofgxS8xkEd2YNBBOmMWHrubVfZd8VY9iIl0ZHxSViyQhURwKHxbg
 v8swNJfVQececNE6TcdjIIMUtxxHrWp69TwE4eeGdbG60ng6CSZNjBbdcZ5RO3VogXcQ
 v1rhf7O8TFU84xnVmpT+jnrpadMxjB3j7Lkci/05AUhWoTEdKQBsEoXWc1oXNtoXEJyY
 Ltj90IUQe0sG4lifzeoWlYubiEGJLAuFZatsHveaVBk7yNUmET+He2HW1I6gveCbg7C+
 xJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772492041; x=1773096841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHzbZuoMERKyiPzNzSOJUvnmQBDgxmBMbilXxOyWjlM=;
 b=HgcMSG9oxbmj81NtWn9KMJOUwmUAKModGVIX12SBJ1d6Kd7XtxfrlV4IW3E8Z1ra4V
 BCcbU7tebJU1JUoEwHekPK4+21SiT1qKo2RIPULKx8wFJMTThajWTYz/tecf6x7WAOsn
 FVCIlT5YTKXFShEBp+k3zvRQK2CEKMwEb7ehjND+n02OJPv2rSFUyOYVlKdH5Rn7K66U
 SevfQ00Ekn63lCg4H9+/10xVxuoDBprYemtOyDMSxs8iSqB8rRDcPXWGfbf+F35m+y7Y
 aYTXOn7b4ISOl1Q5HlD+4lh3PYZbpJaHYcCOcTU08BMnht0zGvd5UHCwO6luXHj7eH0m
 Adgw==
X-Gm-Message-State: AOJu0YzJCqnPSlK97SGM5enGbKAhsnujPnnHrnzQOxUJMv3Fhas2MJLZ
 fUF0rUjTW03kDZbkHMfbvSsTIs3zoYK353Wt39CDkCN/SPf85h0a39k+W0Zdt3krWNN696Z5K05
 6TTAO6ijyeqtm6LLWMoqSrlbxo3upCXJlS+MM63akdVVJ
X-Gm-Gg: ATEYQzxUbCE1/aSCoTapR6EBpbhlWNO+iIUr1xSBk9/6IvRw7fOPqre/w4EwOPp+hJC
 w3ui7riWah1x/9M6acGgCqDzXigDtW+gs9sXrw/37jmc/7iJhzsGHwMhTTB6eHHqzLf9Hsc0RYG
 Z7vCslmvz/O6IxmgE8QjDgxSVaC6Ud/pXdkjyMBuwz7k462+RCnvGXmO00UrN5dxEpZiVMhA8m2
 KC9eOQ7pRdaGdM+a1m0C5sQfZsyZgGdAYSc1q5RGSnKxBSVVr/hH3242Gc8m2G8PYBjbqE7LeCr
 2vFj4Khwea7YYSEuDqEtiDUSkkkGCihYwpWdPpWyuA==
X-Received: by 2002:a17:90b:2487:b0:359:8f13:6689 with SMTP id
 98e67ed59e1d1-3598f136831mr2926267a91.34.1772492040947; Mon, 02 Mar 2026
 14:54:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHxyR9KTC0QzbSYQTAqpBxnyEWJG9+xMGENHps4vfJEPR16Dww@mail.gmail.com>
 <9abb752c-8f26-408e-b6d3-4d4cc2fb86b0@redhat.com>
In-Reply-To: <9abb752c-8f26-408e-b6d3-4d4cc2fb86b0@redhat.com>
From: Ammar Yasser <aerosound161@gmail.com>
Date: Tue, 3 Mar 2026 00:53:49 +0200
X-Gm-Features: AaiRm51CBoZJiLoPMpE_jDJqN8dDU6uLP0JUdSeWHnLD_f2C2CUzQxSfe23kPXk
Message-ID: <CAHxyR9LgW-MY8PWs_hpGUh=AiYNfD-W8FirmkGMO1Xguby4Lxg@mail.gmail.com>
Subject: Re: GSoC virtio-rtc project
To: "mvaralar@redhat.com" <mvaralar@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>, francesco@valla.it
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000077cd34064c12769b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=aerosound161@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000077cd34064c12769b
Content-Type: text/plain; charset="UTF-8"

Hello maintainers

Re-introducing myself in case you missed my email to the mailing list.
I'm Ammar, a software engineer working with Linux kernel and virtualization.
I'm interested in contributing to QEMU for GSoC 2026, particularly the
virtio-rtc vhost-user device project. If accepted, this would be my second
GSoC participation. I participated in 2024 with KubeVirt, which was my
original introduction to QEMU.

I have the following questions in order to formulate a successful proposal:

1. What would you like to see from a successful proposal ? The current
points i am studying and plan to include in mine are:

- an overview of the RTC device spec
- how it would interact with QEMU
- some of the rust data types and enums we would introduce for requests,
different error types.. etc
- a breakdown for some of the RTC C implementations that currently exist in
QEMU (allwinner, aspeed, goldfish.. etc), and what ideas can we borrow from
them in our rust implementation

I am leaving out implementation specific details out of the current phase.
Let me know if this sounds appropriate

2. I am looking for issues I can tackle to familiarize myself with the
vhost-device repo and how one device is structured. Any ones you have that
are relevant to the project or you think are important in general?

Thanks in advance

Ammar


On Mon, 2 Mar 2026 at 09:12, Thomas Huth <thuth@redhat.com> wrote:

> On 01/03/2026 23.15, Ammar Yasser wrote:
> > Hi,
> >
> > I'm Ammar, a software engineer working with Linux kernel and
> virtualization.
> > I'm interested in contributing to QEMU for GSoC 2026, particularly the
> > virtio-rtc vhost-user device project.
> >
> > I've been reading the virtio-rtc device spec, the kernel driver code,
> and
> > QEMU's virtual clock implementations. And i'd like to ask:
> >
> > - Are there recommended starter issues or small tasks?
>
>   Hi!
>
> If you want to get started with contributing to QEMU, we've got a bunch of
> small task in the bug tracker here:
>
> https://gitlab.com/qemu-project/qemu/-/issues?label_name%5B%5D=Bite%20Sized
>
> > - Who would be the best maintainer to coordinate with?
>
> Mentors are mentioned here:
>
>   https://wiki.qemu.org/Internships/ProjectIdeas/VhostUserRTC
>
>   HTH,
>    Thomas
>
>

--00000000000077cd34064c12769b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello maintainers<br><br>Re-introducing myself in case you=
 missed my email to the mailing list.<br>I&#39;m Ammar, a software engineer=
 working with Linux kernel and virtualization.<br>I&#39;m interested in con=
tributing to QEMU for GSoC 2026, particularly the virtio-rtc vhost-user dev=
ice project. If accepted, this would be my second GSoC participation. I par=
ticipated in=C2=A02024 with KubeVirt, which was my original introduction to=
 QEMU.<br><br>I have the following questions in order to formulate a succes=
sful proposal:<br><br>1. What would you like to see from a successful propo=
sal ? The current points i am studying and plan to include in mine are:<div=
><br><div>- an overview of the RTC device spec</div><div>- how it would int=
eract with QEMU</div><div>- some of the rust data types and enums we would =
introduce for requests, different error types.. etc</div><div>- a breakdown=
 for some of the RTC C implementations that currently exist in QEMU (allwin=
ner, aspeed, goldfish.. etc), and what ideas can=C2=A0we borrow from them i=
n our rust implementation<br><br>I am leaving out implementation specific d=
etails out of the current phase. Let me know if this sounds appropriate</di=
v><div><br></div><div>2. I am looking for issues I can tackle to familiariz=
e myself with the vhost-device repo and how one device is structured. Any o=
nes you have that are relevant to the project or you think are important in=
 general?=C2=A0<br><br>Thanks in advance<br><br>Ammar<br><br></div></div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, 2 Mar 2026 at 09:12, Thomas Huth &lt;<a href=3D=
"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On 01/03/2026 23.15, Ammar Yasser=
 wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I&#39;m Ammar, a software engineer working with Linux kernel and virtu=
alization.<br>
&gt; I&#39;m interested in contributing to QEMU for GSoC 2026, particularly=
 the <br>
&gt; virtio-rtc vhost-user device project.<br>
&gt; <br>
&gt; I&#39;ve been reading the virtio-rtc device spec, the kernel driver co=
de, and <br>
&gt; QEMU&#39;s=C2=A0virtual clock implementations. And i&#39;d like to ask=
:<br>
&gt; <br>
&gt; - Are there recommended starter issues or small tasks?<br>
<br>
=C2=A0 Hi!<br>
<br>
If you want to get started with contributing to QEMU, we&#39;ve got a bunch=
 of <br>
small task in the bug tracker here:<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues?label_name%5B%5D=
=3DBite%20Sized" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qe=
mu-project/qemu/-/issues?label_name%5B%5D=3DBite%20Sized</a><br>
<br>
&gt; - Who would be the best maintainer to coordinate with?<br>
<br>
Mentors are mentioned here:<br>
<br>
=C2=A0 <a href=3D"https://wiki.qemu.org/Internships/ProjectIdeas/VhostUserR=
TC" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Internships/=
ProjectIdeas/VhostUserRTC</a><br>
<br>
=C2=A0 HTH,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
</blockquote></div>

--00000000000077cd34064c12769b--

