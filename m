Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8437CE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 07:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOXWu-0001GL-QC; Fri, 20 Dec 2024 02:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOXWs-0001G8-KE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 02:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOXWr-0004UH-2x
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 02:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734680071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16CLwrYbyzNKczsAULBy78LiIuQvUr95Pa9VjPtABhA=;
 b=dlxFu7eUpwJuZsGBBgnhdQwAkOI30SCTfpbIlKCiIl/RycU+XDV2h14aDKnoLDI1aSUouH
 mffT2E00fuXd+iUN3x2lO4lKaPmL32OypUaLgWfRhLaeq1kUItXhiSF2d0n1SIhKS0T1cy
 RDITH7ca9wADUASrK8rgcjTdKlllj3s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-7M_0-42iM0KBeC8J3AgnZg-1; Fri, 20 Dec 2024 02:34:29 -0500
X-MC-Unique: 7M_0-42iM0KBeC8J3AgnZg-1
X-Mimecast-MFC-AGG-ID: 7M_0-42iM0KBeC8J3AgnZg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso931402f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 23:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734680068; x=1735284868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16CLwrYbyzNKczsAULBy78LiIuQvUr95Pa9VjPtABhA=;
 b=gCuxWdPHQcAtVQ0YOl2G+80TG+gbPEfYaXHLmUWzLFQwQC1NuO08qYVxocZdj+lvQi
 2nffIZlW81e3B5YKaK2XQ0VWYIzYeR1W1Kxd7eBX8roOyteNsdFJx8jHy/vpXDEBFzym
 nyNnI9MrjxYSdWqWAbVKFc0DmEjPa6HIQpkgrKWRtkXwdmTL+ib84VvHOkir6wutzI90
 YeCzvSX+crXMFXaLEeXyZ9a5MnsV9Wv6/cdhHCgyk8lNaB5znpHydUpMLDDavxUlZuhK
 BXENX0E20rlOfknqoYzGGNcDhmpp8Js1jdm+gawjoHQaBC8WcoRBHTf0ZvW7LAUa1+AJ
 Ysdw==
X-Gm-Message-State: AOJu0YyHy8kW2WpIxsJ4wvrFKncMy0bbcyLjYh0N8EbDZiwHIe/4F4xJ
 kdH3AGMSUv6rIREzvjgRsOoRA6EMazTyldUirfs1DYjrUuhK8ts86MRbc74YESkWIMjJPEgn/Gs
 n2CYizfOykdWNQsjjUIn9nL5qeTz1l1D0m/q/gA0h2r+9eZJxyoNKCYgc004GNKniADPYg8qyIC
 Je3/kKSmNH36hCcidA4OaFa0/dLkM=
X-Gm-Gg: ASbGnct9nrs1CVCWUMyvAnWUk6xGsOkaLnIrxBwiCZxwb0SZY46Od9+1en90fBz3CJD
 IM9/rCTmOQQeurh57zOaNvgOnoCscJfQViOOvzA==
X-Received: by 2002:a5d:6d07:0:b0:385:f2a5:ef6a with SMTP id
 ffacd0b85a97d-38a221eaa5fmr1609203f8f.15.1734680068086; 
 Thu, 19 Dec 2024 23:34:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK5Uhg7uOg/qvJmFOLfkQ3FiJ3VQfNzvzvbT50XtW9wbx7PYH4rtFECF5oi/U28ZWREkrulUUl+xC6LXNAOnc=
X-Received: by 2002:a5d:6d07:0:b0:385:f2a5:ef6a with SMTP id
 ffacd0b85a97d-38a221eaa5fmr1609184f8f.15.1734680067798; Thu, 19 Dec 2024
 23:34:27 -0800 (PST)
MIME-Version: 1.0
References: <c22ccbb1-9fdc-410c-85c0-ffa91de16b09@redhat.com>
 <20241219200606.GA723061@fedora>
In-Reply-To: <20241219200606.GA723061@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Dec 2024 08:34:16 +0100
Message-ID: <CABgObfZ_TJe0j2__c+qZJm-A6ck1m95_kMMqOeUbGKnZCS6U2g@mail.gmail.com>
Subject: Re: [PULL v2 00/42] Rust, qdev, target/i386 changes for 2024-12-19
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000003d93b70629aead69"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000003d93b70629aead69
Content-Type: text/plain; charset="UTF-8"

Il gio 19 dic 2024, 21:06 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Hi Paolo,
> Will there be a v3? It wasn't clear to me from Richard and your replies
> to v2 whether another revision is needed.
>

Yes, I will send it now.

Paolo


> Thanks,
> Stefan
>

--0000000000003d93b70629aead69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 19 dic 2024, 21:06 Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi Paolo,<br>
Will there be a v3? It wasn&#39;t clear to me from Richard and your replies=
<br>
to v2 whether another revision is needed.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Yes, I will send it now.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Stefan<br>
</blockquote></div></div></div>

--0000000000003d93b70629aead69--


