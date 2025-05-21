Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AEFC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjrd-000705-3f; Wed, 21 May 2025 09:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHjrD-0006zE-9r
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHjr9-0006ay-VO
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747835498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLAbJwWk+zXlTB1vrvkrehkS1xSOSoMPDH3c1wuQcsQ=;
 b=BAwOP/kzRSLh8gktO2rUyLrpiBZLfZDAnF9of/9EYF4RXevTe/wbvWn8TnPN7Az3rWZBBw
 3TPEj6JIhZk1D6jICEmY28sEfmIA/CY+vvV6tWrT/xQ5s7u1WZiaXscefStJbpXF/YTY38
 0bf6TJfSjJdHHCR5PKz8jCQffVlCK+0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-vDNp9ju6MK-8p7wfZIoeLw-1; Wed, 21 May 2025 09:51:37 -0400
X-MC-Unique: vDNp9ju6MK-8p7wfZIoeLw-1
X-Mimecast-MFC-AGG-ID: vDNp9ju6MK-8p7wfZIoeLw_1747835495
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-551fe205635so1023208e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 06:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747835493; x=1748440293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLAbJwWk+zXlTB1vrvkrehkS1xSOSoMPDH3c1wuQcsQ=;
 b=dmU639O5IaHRWOodUqemc/er3puuvzMA/12BK8svvg4IP0T2fDCollLTab/Eh0cVWe
 WLINuadMl9IZn/2tVSgO+d1ABoh5pw7S6Rau8TSmRgauv832/uZFsoO9HSWfU7v8Fi7z
 OPY7QP2JlmD5zf/TxoKgDUtOWCcm6zRewOGrEzWpM6JfyewMFENC1j5gzKNE1CRubNNP
 v+usGxsHysI3otqrNvc7SoXTjWqxtEjIU3CHVNIdGFZsQ2lWyLX6Qa5TfPdmfkf17zds
 HRg4yEMJatn6RgJqTBkcJ1yRR/Xq74N7aZjSHPgszSQu7vw558AlHzZUB7STh/+5JkF2
 b7SQ==
X-Gm-Message-State: AOJu0Yx75OPbpsLAVC+e2z4EDESCC6sHN7GTedl4JJmLksxTHqoPHXFh
 0/UY3ozNfs7nPbSvJhFJx0m1/pKJZok89y+XZy1ova8HgxBEFdw5q7Qap++UrTetbZXE5NShJys
 bdtd3ZyhnlLC0mvFcPSzOB3vJBYUT5BMweGrj5GkJ0PKkxHEjv4d7IxAnsOalQ/2MD+WSEKepbM
 MGMblX5yNuNKxyHzCafo1c1rjdh9uJ/D4ncQHbF4w=
X-Gm-Gg: ASbGnctDFaWawXw38hvk9ergBKAG0quEscXY/g69qmkysrqh+d06vnkKHNKCgY307JH
 Lf/E3Ka3oQvXVP2Vu1dZtuZbbQAZiPum4AsBPdeVdc7JzXo/1dL3tEC6kLz7QnHehsrc=
X-Received: by 2002:a05:6512:2216:b0:549:39b1:65c2 with SMTP id
 2adb3069b0e04-550e72443e9mr6505743e87.48.1747835493459; 
 Wed, 21 May 2025 06:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS+CHiLnn3WLec1hDg1Mr4Hq7/8xJ/Vo7edMZtdaoLZVdggk+3kNFQOfoTpnWawi7JaurliNdok8fshU7BKWk=
X-Received: by 2002:a05:6000:2385:b0:3a3:4ba4:f3cd with SMTP id
 ffacd0b85a97d-3a35c821e38mr16589443f8f.1.1747835482114; Wed, 21 May 2025
 06:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250521081845.496442-1-pbonzini@redhat.com>
 <20250521081845.496442-6-pbonzini@redhat.com>
 <CAAjaMXaeM0Nt3dzEJLCiAOeCQzneEDO6yeX3+CF5tZ2dhQ=YLw@mail.gmail.com>
In-Reply-To: <CAAjaMXaeM0Nt3dzEJLCiAOeCQzneEDO6yeX3+CF5tZ2dhQ=YLw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 May 2025 15:51:09 +0200
X-Gm-Features: AX0GCFskEqIBfZzMwAaokzgt7MsktJWVY2naGoodt-FOhBPgcV6fQiBNnrq30nw
Message-ID: <CABgObfbaTced6eqXW_h+Nkth9i0gB_myrtpG64a46K0MQgFRzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] rust: pl011: switch from bilge to bitfield-struct
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Maydell,
 Peter" <peter.maydell@linaro.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000099bb10635a5a9a5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000099bb10635a5a9a5
Content-Type: text/plain; charset="UTF-8"

Il mer 21 mag 2025, 11:22 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> Perhaps it'd be simpler to contribute const-ability to upstream bilge?
> Is From/Into the only problem trait?


Probably.

I was thinking we can generate
> from/into associated methods for each type that are const


Yes, that's what bitfield-struct does too.

. It'd not
> even be a big change and we can carry it as a patch until we can
> catchup with upstream crates.io version in subprojects/. WDYT?
>

Sure, I have no idea how hard it is but I think they'd accept it? The
bitflags/bits part is more important; I put the two together just for
convenience, as a "let's define our standard toolbox" kind of series,
because they conflict. But it's possible to merge just the first part.

Paolo


> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>
>

--000000000000099bb10635a5a9a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 21 mag 2025, 11:22 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank" rel=3D"nore=
ferrer">manos.pitsidianakis@linaro.org</a>&gt; ha scritto:</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
Perhaps it&#39;d be simpler to contribute const-ability to upstream bilge?<=
br>
Is From/Into the only problem trait?</blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Probably.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"> I was thinking we can generate<br>
from/into associated methods for each type that are const</blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, that&#39;s what b=
itfield-struct does too.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">. It&#39;d not<br>
even be a big change and we can carry it as a patch until we can<br>
catchup with upstream <a href=3D"http://crates.io" rel=3D"noreferrer norefe=
rrer noreferrer" target=3D"_blank">crates.io</a> version in subprojects/. W=
DYT?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Sure, I have no idea how hard it is but I think they&#39;d accept it? T=
he bitflags/bits part is more important; I put the two together just for co=
nvenience, as a &quot;let&#39;s define our standard toolbox&quot; kind of s=
eries, because they conflict. But it&#39;s possible to merge just the first=
 part.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Manos Pitsidianakis<br>
Emulation and Virtualization Engineer at Linaro Ltd<br>
<br>
</blockquote></div></div></div>

--000000000000099bb10635a5a9a5--


