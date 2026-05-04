Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE0DFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJoBP-00088n-Cy; Mon, 04 May 2026 03:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wJoBM-00088f-5F
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wJoBK-0006lq-Li
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777881452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTq9SSFHl7oHm4Ni5FaMZCzojdbyRRXWeYkJQ0SFdEk=;
 b=OQTOAsV9aK6pzo/CMJWO+px9FrboveWmjacDAazj+tBcdHyIGhKEs1hoFFmCmb6Y7GL5c0
 ta3TlUdLJEVkfvUnBaBtmARfh94/GgXEz4F/I02sWivNoxwZ7Dhynu0XpBSP9sOeXZo5ZE
 DeM/WQWNK+BslZxRF7ipjnFf6yZqOnc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-xNYpoH23PW2P9XcAReLMLA-1; Mon, 04 May 2026 03:57:30 -0400
X-MC-Unique: xNYpoH23PW2P9XcAReLMLA-1
X-Mimecast-MFC-AGG-ID: xNYpoH23PW2P9XcAReLMLA_1777881449
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4497a0e3acaso2688616f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 00:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777881449; cv=none;
 d=google.com; s=arc-20240605;
 b=UKMltwGU0zP7mta+opocFlK5hz41Id8Q5v6QRPARyI7O9naVgrm376GGqcdL+gEbOo
 HRBUkDjnkuxuwvPAs9EBDeX7Ed/mQ5mRUDDZpJrspG9ylHNoCWdxPzoTTUtDeTg9FFlJ
 sHeG1OaUMheUnBYEHPoZmcE2YQA0jEKsibU3MXGiTQ2ymi2QnqisKBg/FMgFjO9uyZ/u
 y8e3VSzMptaYgwJ1Y5vuWi5pH5/HYQE3S54DJNgxtBzjI6zV6fLV7zVHAXroo51iwDhU
 gLE02HcJ5kZgcXqpwH8hcSvJV6gp+VsJBjemw89JtN8MgimyEtMU0WI9ogKQaP85A4JM
 FC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GTq9SSFHl7oHm4Ni5FaMZCzojdbyRRXWeYkJQ0SFdEk=;
 fh=IAr358B+xlheH8+YMcgGApL1BpAm0jBEe8/MNK8gXYM=;
 b=NIQx7ju1A8a93I812wtS1oiqGW1EOa0b6kQbh4QBZi+pxP50fM3ouoPFeQEw2Mv8HD
 ybJojaH3nB4Tb0DGcMHlEPGQecnNyVSyC1aOtwqz1RIwT+CnEUbBOsg0FbWx2Vt6jq0F
 n8OuM7VGlIxQ1ZZZy7JJJQf8/iI4iX3pekNu25ZvrsiuIFw3AwEPjV3C+5LMPLvtTjfD
 1u3wHyC+cdfWrwRe1u0BB8FNLUVb4sQJE5HqaBY8Gk0/oYLYRpzaRlZQV7kaxdh5jOGa
 ebrRPffXYOccrLAjU9r9CYOvXBM5adRY2AW0mK9BofF8BJjOT81BjIu6mZGobMohHHyT
 IQ9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777881449; x=1778486249; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GTq9SSFHl7oHm4Ni5FaMZCzojdbyRRXWeYkJQ0SFdEk=;
 b=LRWPNPp2B/IpMgcD1n7qT6msCjRkxKkS/3iqqyc9nob8TRA3I0Xl6mmr+tkUq8YxKJ
 TZGiVccQeLwXujC83/g7thcv3d+QJqBoQcD0FoK6vNcaEYEd1xzhhy4z7ZQR8OqLiELC
 9kmXxGsSe3MfSWvjxljqhNju6fHktZB4fM0yq7nFtDci/muQoaqG8HVDANMCcCKpfsMh
 n3mZSOgpAJeiaWnZ1ZVX2fiddnlsXiwOx090nNVL+XtqrxgzFuLTMnnVq2E1xCzF41xR
 Vj2yrVE0zTfIeiZus1RN6VsikQBMMrvLjbHymVi0WV2lJ5y8T/LINC2s6XYLVWre/yM6
 kQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777881449; x=1778486249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTq9SSFHl7oHm4Ni5FaMZCzojdbyRRXWeYkJQ0SFdEk=;
 b=m6UoJh1mj3SyzN4n1b5n0DmO9RCYivzyYVAx0hxJqjlm9q8XFwA8PJO/qpVKLH5bgF
 try0XTByTUaHTmTzL2SEmM9kJjFs/2jc46gUjOaFng6QEfgufyrza+yr3tbiw7qSxRX2
 Ybk3S2I/1w2kc/II2AbnF5U0sNjjo3UyfEtQUWBBE3SqLRbytC0OyTQCas397tqm9AZz
 ekHfUO9i6PXHQdxNhUwvUl5tgf/m54NvcQZfcv3Eb/SNF6nDFwD6R7OmRVV/e1FGBYCZ
 WYgye6d9cbHf1KbnU3C19FDdw32R+mQPSfpcrx/P/Qdks4xeWZoCbihC7iV+whJx4Kqu
 1PCw==
X-Gm-Message-State: AOJu0YzJ2l65WgzhNGJVLTnlo4hhx7+wfTYlKwxNwR5lPH5jrGIeiA6w
 G1k6MNJ42pg4hRejvi4ObbqtJ0cfGe536V1vBEae145dibyE3YTjX+wil252C7UfDNNWgAsILue
 GzsfGxdenfGPzd60RSgKfhZvvV5FAvCL/zDq37CJXK8+Hz12QBwpu1+Ev/L4lK3wo2j+l8txs1O
 i/MJPY/BRczLCkMpRj+gSrfx4+vrZ9bIQ=
X-Gm-Gg: AeBDiesUhUtNEatXBLcnrA1R0m+QSMYHyyhw6Z6QPF9yU4C1pg020eEXHQdaqKQHXYV
 JBc6krG4SRiZnNAzj/0yGE6ypCImkYGjRQGxBZ5pD1QPdAQikKN0h6TZIy7rLVtyCIzs/2XVaZh
 QK1fjrjBsIceBtGQkAJihC5MQLGU09l/KxfaCOemPk2Z34nGs1GBi5VYy33l0NgPxU/4iyOntcX
 +BE39k2eH2IvZvg8+Nug7FVSgfuI7oSPBJIH4OFxPdJ/RZKqkKC/eXPPQ/6cWn/+kA45wGkq7+O
 qa5KPtKE8xWCAT4=
X-Received: by 2002:adf:e752:0:b0:44b:bf4f:c8e6 with SMTP id
 ffacd0b85a97d-44bbf4fc8ecmr10359243f8f.0.1777881449319; 
 Mon, 04 May 2026 00:57:29 -0700 (PDT)
X-Received: by 2002:adf:e752:0:b0:44b:bf4f:c8e6 with SMTP id
 ffacd0b85a97d-44bbf4fc8ecmr10359211f8f.0.1777881448890; Mon, 04 May 2026
 00:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260430172204.1006673-1-pbonzini@redhat.com>
 <20260430172204.1006673-7-pbonzini@redhat.com>
 <09b2ec62-4b67-41da-893d-aaccf011537c@linaro.org>
 <CABgObfZU_r-xF_iUR+DVA_GkcvzFv878CRAcBh5go864aD_Jqg@mail.gmail.com>
 <41b7b58e-3d58-4e48-9656-2b0cfc4659a4@linaro.org>
In-Reply-To: <41b7b58e-3d58-4e48-9656-2b0cfc4659a4@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 May 2026 09:57:19 +0200
X-Gm-Features: AVHnY4IZtaom0wl3XWBVYNc1JSIHC09-5OUau7Nfvd-xtov3T5GR_r8wsw9wAgU
Message-ID: <CABgObfbXgA=gFZ74tGV2rawN_hUHogJ1d_TBef7r99sT9mR23Q@mail.gmail.com>
Subject: Re: [PULL 06/58] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="00000000000036e1df0650f94832"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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

--00000000000036e1df0650f94832
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 4 mag 2026, 09:36 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> Indeed you are right, I missed whole-series review sent to the cover
> letter. I suppose the other my other hiccup is due to emails delivery
> delay, not seeing your PR was sent later the same day. Apologies.
>

No problem - it is not usual to send the PR the same day, which I did only
because there are clearly no functional changes.

And I have been less diligent at times collecting R-b for my own patches,
so...

Paolo

>
> > Paolo
> >
> >
> >     Not a big deal, it just shows this email workflow limits, as
> >     reviewers might wonder what the point of doing public review if
> >     being ignored.
> >
> >      > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com
> >     <mailto:pbonzini@redhat.com>>
> >      > ---
> >      >   hw/misc/Kconfig  | 8 --------
> >      >   hw/riscv/Kconfig | 4 ++++
> >      >   2 files changed, 4 insertions(+), 8 deletions(-)
> >
>
>

--00000000000036e1df0650f94832
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 4 mag 2026, 09:36 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Indeed you are right, I missed whole-series review sent to the c=
over<br>
letter. I suppose the other my other hiccup is due to emails delivery<br>
delay, not seeing your PR was sent later the same day. Apologies.<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No problem=
 - it is not usual to send the PR the same day, which I did only because th=
ere are clearly no functional changes.=C2=A0</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">And I have been less diligent at times collecting R-b =
for my own patches, so...</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Not a big deal, it just shows this email workflow l=
imits, as<br>
&gt;=C2=A0 =C2=A0 =C2=A0reviewers might wonder what the point of doing publ=
ic review if<br>
&gt;=C2=A0 =C2=A0 =C2=A0being ignored.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"m=
ailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@re=
dhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pbonzini@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 | 8 -------=
-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/riscv/Kconfig | 4 ++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A02 files changed, 4 insertions(+),=
 8 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000036e1df0650f94832--


