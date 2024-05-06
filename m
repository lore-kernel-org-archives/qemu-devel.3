Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42527C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 21:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s45XA-0002Gh-Dw; Mon, 06 May 2024 17:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s45X8-0002Eq-Hk
 for qemu-devel@nongnu.org; Mon, 06 May 2024 17:06:02 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s45X6-0000Cg-In
 for qemu-devel@nongnu.org; Mon, 06 May 2024 17:06:02 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-23f5a31d948so1155217fac.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715029558; x=1715634358;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mw/pTAb/99xK1qavMOVettMtS07i2utPLsUqaqwEJj0=;
 b=et/vQyA1xjQFMDfmZzLffFcSz6HsLBslGP2DhpfEghMo42pQARAJExvprgEWeQWbip
 HEN8ohAPwYd9+qoFozWx5+GP0ytA5jU/S4fsSdf8Tw5dRmvRPZIhCTkHGDBZBhp8vHpT
 4WG8ezo8Dyjn3UVnBjNNkhlPEe8SNouiFvpKp9zEwLBZLRoe57rx3FnCH2JY5Pvx7H7h
 vHVj3eYOZpZPMn7IHRtV689RnmRKO0L797pwPTflmoorWSsuF4i5CwL5oGUEULkr2U37
 A1U4nZDjNXTms2Uk9lpJEnKWVEWcZmqvClkjwQW3TlpPRQf+sKUMPdYYTQCVW3O03bBf
 mcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715029558; x=1715634358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mw/pTAb/99xK1qavMOVettMtS07i2utPLsUqaqwEJj0=;
 b=J/J9IUV44yYJz4Ku8geTuDwYWenzw32JQWX1XK74B/6wMdXk7W3CC/hdtUPjJZpPbf
 pz8Y6hBdqygJvWk8E44TNtac6IeX+7YYo7PPaNysAK79ttIP2611Yvwj7HNHi5RCBDO/
 6/pm1AYeqDxgzC8tHIfFJwjzKcbOZGwj0AUkSclvl0px8g0ZikhojH+b+yMOuuDpM7Vm
 X3RQ49GierbY4i5v7Isqy/BE5F727wM1pZRfCTyO1095JCQGy86oroAmREPv2Ce/NqC3
 TvhBSbEtxIwN10CGVb3hR/6Z9gh0ckErSXZhXovLtkbw7bxlnv/C1+smzkMK6JlO+P2Y
 nOEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbMMF3uT7UBRpEAhxkcakeXSeenZz7b4bukHAUczM1J3tQfvb5mC4IfOvF79+fRIQOUcBfUFKkJ9KwsDJHg1h6BWt4DqU=
X-Gm-Message-State: AOJu0YyzlM+kh+nZyBnk5VwAOUfCyRoOK+CZuRYMCFGGG4QyR/6InqWl
 nNwi+xSKpwu/LnFNq5871Eg95mTLRThxwKY4D4GMpnWh0JqPBYdcTnBKfgdk02DRs/QRUfbfCau
 1UMeTjp6Mw6BMkwFas8CkM0fZF2EPFCYKV+Kpgg==
X-Google-Smtp-Source: AGHT+IHCQSJg6qGFe2vZx+X0EIoIItw2i6xHnPtHlSw8DtG0mE4BoqwoLfnxf+E3b8IYbVa6T7bQnPNXpHyc9p2M6YI=
X-Received: by 2002:a05:6870:ac06:b0:22a:6c9a:ece8 with SMTP id
 kw6-20020a056870ac0600b0022a6c9aece8mr13787627oab.21.1715029558440; Mon, 06
 May 2024 14:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
 <CAJSP0QVxJ__44uTHfZ+Ry0u9iL0QxyL-ca7ypO6YUmyEE5WL0A@mail.gmail.com>
In-Reply-To: <CAJSP0QVxJ__44uTHfZ+Ry0u9iL0QxyL-ca7ypO6YUmyEE5WL0A@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 6 May 2024 23:05:47 +0200
Message-ID: <CAGNS4TbFdTR5uDupW63o+OvWUq2xHsBq9Ly8Sp-zGUvPbsUiEA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009c50090617cf6feb"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000009c50090617cf6feb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 5:01=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:

> On Thu, 28 Mar 2024 at 03:54, Mattias Nissler <mnissler@rivosinc.com>
> wrote:
> >
> > Stefan, to the best of my knowledge this is fully reviewed and ready
> > to go in - can you kindly pick it up or advise in case there's
> > something I missed? Thanks!
>
> This code is outside the areas that I maintain. I think it would make
> sense for Jag to merge it and send a pull request as vfio-user
> maintainer.


OK, thanks for following up, I'll check with Jag.

--0000000000009c50090617cf6feb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 2024 at 5:01=E2=80=AFP=
M Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Thu, 28 Mar 2024 at 03:54, Mattias Nissler &lt;<a href=3D"mailto:mnis=
sler@rivosinc.com" target=3D"_blank">mnissler@rivosinc.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; Stefan, to the best of my knowledge this is fully reviewed and ready<b=
r>
&gt; to go in - can you kindly pick it up or advise in case there&#39;s<br>
&gt; something I missed? Thanks!<br>
<br>
This code is outside the areas that I maintain. I think it would make<br>
sense for Jag to merge it and send a pull request as vfio-user<br>
maintainer.</blockquote><div><br></div><div>OK, thanks for following up, I&=
#39;ll check with Jag. <br></div></div></div>

--0000000000009c50090617cf6feb--

