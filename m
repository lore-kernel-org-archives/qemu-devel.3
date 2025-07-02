Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BFAC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX357-0002J4-H9; Wed, 02 Jul 2025 15:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uX354-0002HW-5o
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uX34z-0000t8-0F
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751484306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v11VQJj0EqwhMQCjhCgDFH2PX03lH70WJ7qhV5Bgwkk=;
 b=Pxjd5bGU9NVb6xl6opvUwI6/VkGFB0W25hW+spuoPl4G+Xutj4mqThraz9jc0kCtyKyynz
 jitioIjY7z1/jzkstlS+VYIzR7+4oNwd62R/cEucrZJbSnE9f2JXnphP5sWZRPDX5GrXhS
 WmZWuIsLNsyB/3Fw9nqWwHxHHD8mCNc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-OvhYEnlXOXO_4p8VUEQeBQ-1; Wed, 02 Jul 2025 15:25:04 -0400
X-MC-Unique: OvhYEnlXOXO_4p8VUEQeBQ-1
X-Mimecast-MFC-AGG-ID: OvhYEnlXOXO_4p8VUEQeBQ_1751484303
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2876670f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751484303; x=1752089103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v11VQJj0EqwhMQCjhCgDFH2PX03lH70WJ7qhV5Bgwkk=;
 b=v9pn99b1+ByIs/tM/MsRslrg/B+7PXpSBoiOFpueBH6S42PvoxbQDSxvIMlG3iKcdL
 AxhMpZVLsDX0fS+nI3jJiS2C9n4KIcIyfqmyrRqLR3F6/zRru1/k4roDq0W2fU9Kr05c
 Y/BYLsdwTPd/JHZgs+tjiFFmZUwSVN2zy/MHPQBL7W7Mkre/0Xm5tvCQ6GOrlH3xzhzr
 Zualj0VRRPtcIdSKF9STDyQJCCsniHr41wni+XZstbwllzM1COz1xluFhfZ8GE2zJZ1P
 Y3oW0N2AV23uLxDYM3Zet41GjvAM7Y5Y+KNWFBPRtQQcpS5MtuKRE7Wziw1LYavMX0FZ
 Wxvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG7kjb+4Yw/IF3dTTO2CaTArbtjyxwuqW2Jn6AU2q/BECIX+Ur9NJjL9cD3cJRacsciue66+c7RTMk@nongnu.org
X-Gm-Message-State: AOJu0Yzw0600etdHtRPBfNwD0akPuTXc0O7wCTdmeiixmBWJOcSZTbjI
 IseTqDaloqpHA0ypCdCjY61Dh8LIr+8NGGWXJv5jYLT/mmjdaniEhOhO4Jofzf7T9AI9r8jQasW
 eYKza102RkvkIw2TXBPUQLJB5V0LYgCfBlqTV3/GRVlw3h7sF4Tp3j1CZgJit0kOIz8G6yAzM8b
 n+Va/wkYyHxKAu64+6P85q/+662HX6k52X7HjZMDM=
X-Gm-Gg: ASbGnctLU+HJ3c5SBf44co+8kl+hdWaqABDN5gCHW42o5u7iFznnRGtE/v4E2FqRNNm
 VVc+g3Wx91ok7YSReEx4m1GwnABmPT2DRskhScckJ3A8j8XcfD/BSm80NQm14n4vDVPIoSANIhP
 ZHZA==
X-Received: by 2002:a05:6000:4a0f:b0:3a4:d79a:35a6 with SMTP id
 ffacd0b85a97d-3b1fe6b5791mr3630875f8f.14.1751484302980; 
 Wed, 02 Jul 2025 12:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRIbmWy+k65dFBnN+jqzHuJr1IaLsuFexhNBA2EqFnww2CPYJ7vTDSVbU9PSsU0bziMLkx58mJ0r06nev2Uz0=
X-Received: by 2002:a05:6000:4a0f:b0:3a4:d79a:35a6 with SMTP id
 ffacd0b85a97d-3b1fe6b5791mr3630851f8f.14.1751484302514; Wed, 02 Jul 2025
 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
In-Reply-To: <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Jul 2025 15:24:49 -0400
X-Gm-Features: Ac12FXz_ZfIYaxQNt5qAku5Xc-IYIZj1L6mdVodE4ea3BP-4TZw0Shtaslr7_ko
Message-ID: <CABgObfYEJ9Xu4b6zGp8E-vDsy7DqYHRrn10VBqjZaTgymmrWpQ@mail.gmail.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000ae776d0638f73724"
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

--000000000000ae776d0638f73724
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 2 lug 2025, 15:24 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

>
>
> Il mar 24 giu 2025, 02:45 Markus Armbruster <armbru@redhat.com> ha
> scritto:
>
>> > ... I think I value this a bit higher than Markus, but not really
>> because of offline builds.  Rather, keeping the "accepted" key lower (i.=
e.
>> supporting the packaged sphinx on a wide range of distros) makes it easi=
er
>> to bump the "installed" key when needed, as in this failure to run 5.3.0
>> under Python 3.13.
>>
>> Showing my ignorance again...  I don't understand how keeping "accepted"
>> lower helps.
>>
>
> Because it makes it easier to use distro Python. If distro Python is
> <accepted,
>

Sorry: if distro *sphinx* is <accepted.

Paolo

configure's will try to use the "installed" version. If that version in
> turn is too new for distro Python, you're screwed. So you want to be as
> conservative as needed for accepted, but not more.
>
> Regarding fool or pioneer: for sure we're extraordinarily kind towards
> distros. To some extent we have to do that because of 1) the possible
> competition of other VMMs that completely ignore distros (e.g. because th=
ey
> just use cargo)=E2=80=94packaging is an area where C still has an edge an=
d we want
> to keep that edge 2) we're an infrastructure component that can't just te=
ll
> users to grab a flatpak.
>
> The distro policy (mostly conceived by Dan) has served us well, with only
> small adjustments needed to have newish version of Meson/Rust(*), and
> non-prehistoric versions of Python. I don't see a need to change it, sinc=
e
> at this point we have the tools needed to manage the complexity.
>
> Paolo
>
> (*) Most of the Rust issues would solve themselves by telling users of
> Ubuntu 22.04 and Debian bookworm to install the upstream tool chain with
> rustup instead of relying on distro rustc packages. Unlike Linux, which
> uses unstable features, QEMU sticks to what's been stabilized and that
> means newer releases sometimes.
>
> > This time there was a version that works on both the oldest and newest
>> Python that we support, but there may not always be one because sphinx i=
s
>> all too happy at dropping support for EOL'd versions of Python.
>>
>> Pretty strong hint we shouldn't try to support EOL'd versions of Python
>> either.
>>
>> > Paolo
>> >
>> >> Before I throw my weight behind any given option, I just want to know
>> what we consider our non-negotiable obligations to be.
>> >> Thanks,
>> >> --js
>>
>>

--000000000000ae776d0638f73724
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 2 lug 2025, 15:24 Paolo B=
onzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Il mar 24 giu 2025, 02:45 Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">&gt; ... I think I value this a bit higher than Markus, but n=
ot really because of offline builds.=C2=A0 Rather, keeping the &quot;accept=
ed&quot; key lower (i.e. supporting the packaged sphinx on a wide range of =
distros) makes it easier to bump the &quot;installed&quot; key when needed,=
 as in this failure to run 5.3.0 under Python 3.13.<br>
<br>
Showing my ignorance again...=C2=A0 I don&#39;t understand how keeping &quo=
t;accepted&quot;<br>
lower helps.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Because it makes it easier to use distro Python. If distro Pyth=
on is &lt;accepted,</div></div></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Sorry: if distro *sphinx* is &lt;accepted.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div =
dir=3D"auto"> configure&#39;s will try to use the &quot;installed&quot; ver=
sion. If that version in turn is too new for distro Python, you&#39;re scre=
wed. So you want to be as conservative as needed for accepted, but not more=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regarding fool or pion=
eer: for sure we&#39;re extraordinarily kind towards distros. To some exten=
t we have to do that because of 1) the possible competition of other VMMs t=
hat completely ignore distros (e.g. because they just use cargo)=E2=80=94pa=
ckaging is an area where C still has an edge and we want to keep that edge =
2) we&#39;re an infrastructure component that can&#39;t just tell users to =
grab a flatpak.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The dist=
ro policy (mostly conceived by Dan) has served us well, with only small adj=
ustments needed to have newish version of Meson/Rust(*), and non-prehistori=
c versions of Python. I don&#39;t see a need to change it, since at this po=
int we have the tools needed to manage the complexity.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">(*) Most of the Rust issues would solve themselves by telling =
users of Ubuntu 22.04 and Debian bookworm to install the upstream tool chai=
n with rustup instead of relying on distro rustc packages. Unlike Linux, wh=
ich uses unstable features, QEMU sticks to what&#39;s been stabilized and t=
hat means newer releases sometimes.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
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
</blockquote></div></div></div>

--000000000000ae776d0638f73724--


