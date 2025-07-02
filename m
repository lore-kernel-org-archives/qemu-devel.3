Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947DBC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX34T-000204-GL; Wed, 02 Jul 2025 15:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uX34R-0001zL-Cc
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uX34J-0000Vv-Fb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751484264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=prjD3zkGXzYEEFW3q8BL3sJrl4rPwukG4cfHgI4Mng0=;
 b=fXsd2vk25KlWgC/sIYo49wxFvIDttmQY1GXjo2YC18+rcoY6gTGC/J7bCP1sAyX/E46W7r
 bt0dknXgTKQvC70vmbxiRXStdzkiFtFP4TnLzqjpX5uJnjwVIv3k2vdn+zrzEWIhKYfoSL
 GZiAo7N11YTvyKnZ8WFUyVRtylUqvjs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-dH8-weV1NRefDEARN8boDg-1; Wed, 02 Jul 2025 15:24:22 -0400
X-MC-Unique: dH8-weV1NRefDEARN8boDg-1
X-Mimecast-MFC-AGG-ID: dH8-weV1NRefDEARN8boDg_1751484261
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d90929d6so1901212f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751484261; x=1752089061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prjD3zkGXzYEEFW3q8BL3sJrl4rPwukG4cfHgI4Mng0=;
 b=M4aounnwCMk6GQuBLO8MBIQzCyciYIfAO+daiSr/qb7SZxNuYwZzaZtZuajm0+0gAr
 AezPW+T/mWCJO2aKv0vzyNQRXcpdSsFJ3StdOBzslWcgOoaxwdFAnwcHKyEMszQjVO3m
 P1KT5Yp1Tz744PpiLwvfCBN7bmu0m9tNlJzgFsWbwGhRPk54ELfNQ09cDtn8Qe3hBc2I
 yVT0+T4qVLGZ2Z7W0dGOvK7RAA94B942iaT8k9iB1gTY1j6a59CRzaXn0BIqhUhWhrFy
 Xx3uwfpaVrPz3sVUB4pwFrASPpBJQD/Y//2xAzCnfbSac27X6pJRQ5d2G7g99rQQq+4M
 2EGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOvW2UFbSVXF8I+dfE58QO6LfFr7gC0OSyaylGzWtOFExeDuS61VH9ebLSUpScGIpqeoquU9zGfoU0@nongnu.org
X-Gm-Message-State: AOJu0YyuglD0SR8kb5PXYPhtlhaQvc6ukx4DDYj8br7CerT9vixnlAhX
 fa9ZHlewHkKAcYqNpbGWrvXjZmIjTAV5oesJsxGpx1bOM6+K3RCxi3kVkDUSaY4ocT2MXP3oq7Z
 jOGr36Ozddqc4tpMAkPvoysSNPNqSoMgmgBAm7XrEiSO92qdG+ASZdHAudcqrkTZ2+Q1PRI2VlV
 O73aMMJX0ALmrnifRxblVnzateOy2LK9M=
X-Gm-Gg: ASbGncvkDCnLMQORY9ZlZMIoC3p2WvkazMrhqT9YXPW50t7h9QDZX8xPC/vpA0JKYkj
 Y4s1kwhraIEHwUl9weOvWAMWmTXIVE9zKzLLkyQXPl1YvzJp1klu+ptX6FzbGtPbP29w1V9ZGeu
 KD3Q==
X-Received: by 2002:a05:6000:1786:b0:3a4:d0fe:42b2 with SMTP id
 ffacd0b85a97d-3b1fee672aamr3409332f8f.19.1751484261257; 
 Wed, 02 Jul 2025 12:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZLPEHzNheQ/dlYX2Bw7MQpKblHwJp3jrYPjy/+ciLjQsWWQLHX0+640zwBHUEf+y4usPh86ZMUnYyTQnQyts=
X-Received: by 2002:a05:6000:1786:b0:3a4:d0fe:42b2 with SMTP id
 ffacd0b85a97d-3b1fee672aamr3409319f8f.19.1751484260869; Wed, 02 Jul 2025
 12:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
In-Reply-To: <87qzz9myd0.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Jul 2025 15:24:09 -0400
X-Gm-Features: Ac12FXyDiEC1x1KApEX4smKg_hBqe6xgP_rsWJpueLxRy-Oa91FKidVQzdi6D40
Message-ID: <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000032fdec0638f73581"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

--00000000000032fdec0638f73581
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 24 giu 2025, 02:45 Markus Armbruster <armbru@redhat.com> ha scritto:

> > ... I think I value this a bit higher than Markus, but not really
> because of offline builds.  Rather, keeping the "accepted" key lower (i.e=
.
> supporting the packaged sphinx on a wide range of distros) makes it easie=
r
> to bump the "installed" key when needed, as in this failure to run 5.3.0
> under Python 3.13.
>
> Showing my ignorance again...  I don't understand how keeping "accepted"
> lower helps.
>

Because it makes it easier to use distro Python. If distro Python is
<accepted, configure's will try to use the "installed" version. If that
version in turn is too new for distro Python, you're screwed. So you want
to be as conservative as needed for accepted, but not more.

Regarding fool or pioneer: for sure we're extraordinarily kind towards
distros. To some extent we have to do that because of 1) the possible
competition of other VMMs that completely ignore distros (e.g. because they
just use cargo)=E2=80=94packaging is an area where C still has an edge and =
we want
to keep that edge 2) we're an infrastructure component that can't just tell
users to grab a flatpak.

The distro policy (mostly conceived by Dan) has served us well, with only
small adjustments needed to have newish version of Meson/Rust(*), and
non-prehistoric versions of Python. I don't see a need to change it, since
at this point we have the tools needed to manage the complexity.

Paolo

(*) Most of the Rust issues would solve themselves by telling users of
Ubuntu 22.04 and Debian bookworm to install the upstream tool chain with
rustup instead of relying on distro rustc packages. Unlike Linux, which
uses unstable features, QEMU sticks to what's been stabilized and that
means newer releases sometimes.

> This time there was a version that works on both the oldest and newest
> Python that we support, but there may not always be one because sphinx is
> all too happy at dropping support for EOL'd versions of Python.
>
> Pretty strong hint we shouldn't try to support EOL'd versions of Python
> either.
>
> > Paolo
> >
> >> Before I throw my weight behind any given option, I just want to know
> what we consider our non-negotiable obligations to be.
> >> Thanks,
> >> --js
>
>

--00000000000032fdec0638f73581
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 24 giu 2025, 02:45 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
&gt; ... I think I value this a bit higher than Markus, but not really beca=
use of offline builds.=C2=A0 Rather, keeping the &quot;accepted&quot; key l=
ower (i.e. supporting the packaged sphinx on a wide range of distros) makes=
 it easier to bump the &quot;installed&quot; key when needed, as in this fa=
ilure to run 5.3.0 under Python 3.13.<br>
<br>
Showing my ignorance again...=C2=A0 I don&#39;t understand how keeping &quo=
t;accepted&quot;<br>
lower helps.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Because it makes it easier to use distro Python. If distro Pyth=
on is &lt;accepted, configure&#39;s will try to use the &quot;installed&quo=
t; version. If that version in turn is too new for distro Python, you&#39;r=
e screwed. So you want to be as conservative as needed for accepted, but no=
t more.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regarding fool o=
r pioneer: for sure we&#39;re extraordinarily kind towards distros. To some=
 extent we have to do that because of 1) the possible competition of other =
VMMs that completely ignore distros (e.g. because they just use cargo)=E2=
=80=94packaging is an area where C still has an edge and we want to keep th=
at edge 2) we&#39;re an infrastructure component that can&#39;t just tell u=
sers to grab a flatpak.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
The distro policy (mostly conceived by Dan) has served us well, with only s=
mall adjustments needed to have newish version of Meson/Rust(*), and non-pr=
ehistoric versions of Python. I don&#39;t see a need to change it, since at=
 this point we have the tools needed to manage the complexity.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">(*) Most of the Rust issues would solve themselves by =
telling users of Ubuntu 22.04 and Debian bookworm to install the upstream t=
ool chain with rustup instead of relying on distro rustc packages. Unlike L=
inux, which uses unstable features, QEMU sticks to what&#39;s been stabiliz=
ed and that means newer releases sometimes.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt; This time there was a version that works on both the oldest and newest=
 Python that we support, but there may not always be one because sphinx is =
all too happy at dropping support for EOL&#39;d versions of Python.<br>
<br>
Pretty strong hint we shouldn&#39;t try to support EOL&#39;d versions of Py=
thon<br>
either.<br>
<br>
&gt; Paolo<br>
&gt;<br>
&gt;&gt; Before I throw my weight behind any given option, I just want to k=
now what we consider our non-negotiable obligations to be.<br>
&gt;&gt; Thanks,<br>
&gt;&gt; --js<br>
<br>
</blockquote></div></div></div>

--00000000000032fdec0638f73581--


