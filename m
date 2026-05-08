Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD64CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPwn-00053P-7m; Fri, 08 May 2026 14:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLPwd-00051l-Mv
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLPwZ-0007zC-FV
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778264937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fm5r/uILlgv2r0k63RBZKfCVpxGXXhRBYkn1/OvS1d0=;
 b=Ys9kr9LzZiWGGA1zDbsU4R8rE4VtMTRPJSXEPqVxA4o24C392svoxzhMhYbhzpsTKAEBOk
 hyPrqc201FIlCCpQVsMS/hMqJ1EacGJy+HRU98hnYsRztcJD8pH/Yr8YPr4vORqV/GD2ip
 DmPE8ceMQo1lZ4W8NrRlHncNAU3hnQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-GGwWBE1dMaOGDlfVEe0CsA-1; Fri, 08 May 2026 14:28:53 -0400
X-MC-Unique: GGwWBE1dMaOGDlfVEe0CsA-1
X-Mimecast-MFC-AGG-ID: GGwWBE1dMaOGDlfVEe0CsA_1778264932
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48d121738feso20711765e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778264932; cv=none;
 d=google.com; s=arc-20240605;
 b=TSic4G4gjz7kNBGoXTGKx9FYMqItQFf3p5FSUJ+wtOD3wZpog9LJtj7V11vpXTM1l9
 fp1RqMcSnilaii9/6ZltBSReQOrrJVdlNmhT8Eug6+RCdGn3y8jTaS7Trqfe3/6p6qKs
 NBiQvVDgTRGLCO5sCCNMY852r9wsfghu7psCiEdxGCkLQKAyykU7jp2qrbFDaof+hiKf
 Wvic0NFkOr4qqJcWwuTVBUPfwiZA5Gg3GAApIdow7q38QyeneMZDb3gCVc1LHQ0Fm6tM
 XngnPZAXaKR5l2ft2Nua1cXr97EAX0ev+KlqLxdZLX6Wf4xq4FzSfM8rUJI/9LSk2udl
 YjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fm5r/uILlgv2r0k63RBZKfCVpxGXXhRBYkn1/OvS1d0=;
 fh=NAT2gutbSkjGg5BRHDC9cr1dtN4p2bRZIx1hsBKc+3o=;
 b=MI7O7c4M1lFOZ70dpLLphkE6FXPmlzR25zClIrr+Wwd/vc7NkeMXVmXGJx/fNY5WDA
 LhNWJ4+uL7D7OpOiSvHV5MNksX67D+wspk/kqiUxi9cnR9uDW0b/UCriU55AOOlslPU3
 mU0Jcg6NqBO2TWzs6evqJML/uAIuK7aVAWYOuWHNConRBcUwFSmw1wSTwxnLdPY7+ZOE
 xUMnuf7kQDXUFUlpIHwOlc1gdXMKuUvQSt+OU6k1MU/RnWbu/lqdRFgmq0DsWhJ1DiQu
 nG0qQAuNJFMrz5wOE4QrNSHXzQdybwXbVZZ3+sIWqtmLQnX7QBPzXYbvaTsVAhNUR8VJ
 It3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778264932; x=1778869732; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fm5r/uILlgv2r0k63RBZKfCVpxGXXhRBYkn1/OvS1d0=;
 b=p/Go2fBq4ubsa18ir4qarPY0tLVhElGezwIB0K4IK6hy+lgWFye2M0r1f/Yr2i6XbF
 ZzKGQfpQENyEWqze6c4B/uC4Y7gjVV6myvXLUn/if8WlB+EeiG7gueL6oG+kY/5wFt5P
 3DIzhxXZTfBvCyhg/sI8rvBAGX/7vI93YW+ZVXKfabLSQuzrywMhcFYmx9cBgxdfbkr4
 TfYHRaIGwI+1DeVQU4gkVaVotRey/ukGKd6P/2irtcOGKicZB+xRDl51GFdoma5hMjEk
 gHjsTfA+Mao6CqTNFAoa61NrCga/ZMsUgEVWZwPs/IoQNLyiKfUN8W96PcTkjHB7NDNH
 f6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778264932; x=1778869732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm5r/uILlgv2r0k63RBZKfCVpxGXXhRBYkn1/OvS1d0=;
 b=jBK6vEKWoqwZKzpvEBa1wYcvDdUUPqTc2sMKoPC5b7Y9ezI7GqRuix68pPel+0MzqU
 6imYDRI+/moIHv678ZL2kPFTsgxsLWSJG2sKKDGRchzRQ9JckfNA6P7jbdqpYcpqsJFp
 ogqku2x4s7W9RMaoxq4pze/3fPotcUrrf2zSB8yBWPP+ylyQyTbNixJDo8iz0OsX4A/E
 3c385A+LlMZ5eKC4V1qYoEFNa6DjYiEaDQA5pdEWa1IJNc1ye9u4DcMvWO0P4nU7aqQ1
 fYc2bhPAc4I8LJxdSiCNP9x+UK8RtT7CeQVnyXawDCoeFMpGkOii85kQahqSes9noiwG
 EXzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SA+uqrStUD2+2ooFNhoeHEndAmi7r3bA1M262mkTply1AX7+qjvLdn57Q1wZ4DeDZPPcxOy45Skxu@nongnu.org
X-Gm-Message-State: AOJu0Yz35wYrp0863b9fKImojhiHLSljr4agbphHzVEZcrCKHWiJo74m
 S60OwPWaacRX2WYLrmZcWLmeEv3BdvaOenoZQYuyPMTZgHzgLh6QKhztGyOqEDi2yyigAh+igUE
 0tdDM+tCkjHw4QDRm8vSVZiifwY9mnQB3wgf4zsRufDsmoviKZZ588a/QXmssYbaUiBO5wQ689w
 lExXG0vTJHRRHpJfd5cFOEe0Mk2PWM8lQ=
X-Gm-Gg: AeBDiesTEXcd+1wCqpcUGwDQAcUIzH8xoeqbmm9eo5xK+ZPYPUkb8g5Ql93T1/GckcG
 aXjSaH/INtHIlEBcNW6GdmUqvhgfBURsIEKq0HbgFh7k5qzP62WniS8qp/lZ66oRD/eLasa5yhc
 SYGncQPVZAW1UjU8YOD1DD8bqHn4BUlpIunmTcqlCbkvcKpXYt3TIu+mh2AJy24Jxa9FSifQC0/
 dn3RkNLhPiYfj+SUWdhvMkJl70scj2SjfhQdp+svbQTmb/W/UomCmkYf/RCc9ppJksup8yjyb+S
 qt8YuoEi/znDF2XFKnY=
X-Received: by 2002:a05:600c:3b17:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48e51e20705mr196338395e9.9.1778264932569; 
 Fri, 08 May 2026 11:28:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b17:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48e51e20705mr196337885e9.9.1778264932081; Fri, 08 May 2026
 11:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <CAFEAcA_sQahkspZ15NP0Hmw9AedH1pHUv__YL_ww3UtmX=LPDA@mail.gmail.com>
In-Reply-To: <CAFEAcA_sQahkspZ15NP0Hmw9AedH1pHUv__YL_ww3UtmX=LPDA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 May 2026 20:28:40 +0200
X-Gm-Features: AVHnY4LyBmIUOEj-phOryiHT_t8XWmUAM8uc-jouXN3pOOfbWbKT6db7fNkTvRc
Message-ID: <CABgObfaHfKgB=UFHV39aSdpY6iPedmKxAHOTOmR60ZGSu6GWiA@mail.gmail.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Levon <john.levon@nutanix.com>, Jag Raman <jag.raman@oracle.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Cedric Le Goater <clg@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000097fd2e065152911c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000097fd2e065152911c
Content-Type: text/plain; charset="UTF-8"

Il ven 8 mag 2026, 16:39 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> However in this case as I understand it the multiprocess
> feature has always been "experimental" (as marked by the
> machine and device names "x-remote", "x-pci-proxy-dev", etc
> having an "x-" prefix). So if we really don't think this is
> likely to be being used by anybody in practice I think the
> experimental state allows us to remove it without waiting.
> Dan, Paolo, what do you think ?
>

Indeed I was going to propose instantly removing it.

Paolo


> -- PMM
>
>

--00000000000097fd2e065152911c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 8 mag 2026, 16:39 Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">However in this case as I understand it the multiprocess<br>
feature has always been &quot;experimental&quot; (as marked by the<br>
machine and device names &quot;x-remote&quot;, &quot;x-pci-proxy-dev&quot;,=
 etc<br>
having an &quot;x-&quot; prefix). So if we really don&#39;t think this is<b=
r>
likely to be being used by anybody in practice I think the<br>
experimental state allows us to remove it without waiting.<br>
Dan, Paolo, what do you think ?<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Indeed I was going to propose instantly remo=
ving it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--00000000000097fd2e065152911c--


