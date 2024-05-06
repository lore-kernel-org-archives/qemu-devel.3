Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8F7C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 21:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s45ZI-00035m-EB; Mon, 06 May 2024 17:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s45ZF-00035H-NF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 17:08:13 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s45ZE-0000nJ-0J
 for qemu-devel@nongnu.org; Mon, 06 May 2024 17:08:13 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f05b8fc6c1so862724a34.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715029690; x=1715634490;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z/loUhp5PrsBYSFWbwTS+0yfJJR9vjwcisKcGSpp6iI=;
 b=RfEo3SX05QHQbplaOM+1Z2wResriPQfg963QlskG0CFf/pHSyv3ke0/hLicuq97mHa
 VKaktSbfzYcjNW5HV9OafBdnsUlV0X1rLq30yHV3LzwMr/eIk5DIktlgvekGliyd8YH7
 mELDhMi9fBLlUrJTeFPhhF1HLO9VVrigQ56R61bXjBS2cBgTlxnRgEnxQgTss9QjHSbW
 YEOs79VC6mdYg3q0u/2F4BWDDGQ93jBd7CqZlfF3KUkXYCasaERd+X89JOyO0yX6d7C9
 evVuiqjPSZtXnX0XSbbylFi80uX+YNS6ioYCvY9JtTHl53QLhFuZzMioVFrCm7RpVC5R
 N9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715029690; x=1715634490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z/loUhp5PrsBYSFWbwTS+0yfJJR9vjwcisKcGSpp6iI=;
 b=QRYLp8/4xCzHgIuxmpmVU2foXrWMmihvqFS9vKqj6KTuG4ROH13ZbcLHpYvXK6NTbQ
 6gWXhtv3pBFsp0JxZrCXnbwOS0/t1gfBft+Jm7T0SPTy8F8U788JMY9smAH8ZraF7A/2
 Yl2Ra3SElbEIPFzCygdkCV1XANcQnrdSOCjRsgqyn/HR+MhGc0IXsY9gFbc4Lbwj4fKC
 ZXlcR7E2fSeeDDx4qHUw8MybrsnTFFx9/JlJwwYiXtKV4j1SVXVHAVIgrnEFkX42+7I0
 IDQihBmuL87cNvgsWzozllkHKnNInlWvVPtHAKPTWUoZkqWpOWRuPnQqRkrh0Ibhbjrx
 SYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZuXx13INXQN0mLBXnRDKqc76u6PjPk9iTsdskbQJQrtAvc8u+RlCB80ALm7HrCmXR8E/bMozOFpOcDtz+JYsphMW1D0U=
X-Gm-Message-State: AOJu0Yz4Kj5cg9IUWtiVWR326EJaOdt3wSjKwfEoQOjh+5QldL8oB5bI
 wUhBRk7A+M1YhVSlewuDcLs2ESAskhPiPtZQLd8dcqqDOQZ9zlCHCBTKfSSntbKoPM8t9fdhfV4
 pbzERE8HVfOsFdhyTvyEjJA944Jfh0OyX12pvPQ==
X-Google-Smtp-Source: AGHT+IHk83H1LbLbgeXy1rhJDqBJSijyh2jEZtuBHC8q6qDqnKHNYotBOITFXBqa6J752ulyK18YWae85ZB1JBeG0iE=
X-Received: by 2002:a05:6871:799e:b0:23c:ffe8:a80c with SMTP id
 pb30-20020a056871799e00b0023cffe8a80cmr12517231oac.52.1715029690482; Mon, 06
 May 2024 14:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
 <ZjjsyF_ZMIPGqcci@x1n>
In-Reply-To: <ZjjsyF_ZMIPGqcci@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 6 May 2024 23:07:59 +0200
Message-ID: <CAGNS4TaSxprHvoVCMRLw2YCGA2FXirO=Wp-TgzzxquwaL6y51Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: multipart/alternative; boundary="0000000000007b1aad0617cf77d6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x32d.google.com
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

--0000000000007b1aad0617cf77d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:44=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Thu, Mar 28, 2024 at 08:53:36AM +0100, Mattias Nissler wrote:
> > Stefan, to the best of my knowledge this is fully reviewed and ready
> > to go in - can you kindly pick it up or advise in case there's
> > something I missed? Thanks!
>
> Fails cross-compile on mipsel:
>
> https://gitlab.com/peterx/qemu/-/jobs/6787790601


Ah, bummer, thanks for reporting. 4GB of bounce buffer should be plenty, so
switching to 32 bit atomics seems a good idea at first glance. I'll take a
closer look tomorrow and send a respin with a fix.

--0000000000007b1aad0617cf77d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 2024 at 4:44=E2=80=AFP=
M Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu=
, Mar 28, 2024 at 08:53:36AM +0100, Mattias Nissler wrote:<br>
&gt; Stefan, to the best of my knowledge this is fully reviewed and ready<b=
r>
&gt; to go in - can you kindly pick it up or advise in case there&#39;s<br>
&gt; something I missed? Thanks!<br>
<br>
Fails cross-compile on mipsel:<br>
<br>
<a href=3D"https://gitlab.com/peterx/qemu/-/jobs/6787790601" rel=3D"norefer=
rer" target=3D"_blank">https://gitlab.com/peterx/qemu/-/jobs/6787790601</a>=
</blockquote><div><br></div><div>Ah, bummer, thanks for reporting. 4GB of b=
ounce buffer should be plenty, so switching to 32 bit atomics seems a good =
idea at first glance. I&#39;ll take a closer look tomorrow and send a respi=
n with a fix. <br></div></div></div>

--0000000000007b1aad0617cf77d6--

