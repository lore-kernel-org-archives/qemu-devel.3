Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A19C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HMc-0006gi-Qp; Tue, 07 May 2024 05:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HML-0006PG-DW
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:43:43 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HMJ-0007YF-IQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:43:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c86f0661d0so1252474b6e.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715075018; x=1715679818;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yCfH8pLjqNtK2cbAONxC7pdpIJi3NCGIQ+sMxzXhlVo=;
 b=UZ0gbAbwnxdq3bYKlmAagYQ8T+gCZpLCWHFly0kitl55e7Equ1V8D9fM1xiH83DWZI
 r5IoKSzihBkDeloVJuZ30WMMXONbF/1kNpsaVhQhSAcRQgKI3J5qps/mb+McWawcEIgu
 kEGm/qsUnf/68GQ3yfNOVknhrxyX5hKi9CDVFTNAy3rgxM1J/eYvuwxfah4PAgllSCeq
 N292ngZY0MGYXyxszl3w2FKzGZoa07imXNIWCsKzqayZK846LtKfAdqF2bbnxE7LMqBy
 4eW9IWIaeqS3XjQ4/qkWw5gWK3XPCxpZDGBpVCmHLMybxD15yJuuLToQrwHDM+myibaV
 SQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075018; x=1715679818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yCfH8pLjqNtK2cbAONxC7pdpIJi3NCGIQ+sMxzXhlVo=;
 b=cIUBU/67HyZHgyRtSRAG5o7hQIS8reIWE4e1x1pgEtzczkZdr75q44KoPKDRkUsIJ/
 Gnw/gneP4O8Vu0SViFcoR24hZIhIcN40MgebqdnKBpH7z4r3TvkpisGqnUT8o9Ls6dhc
 d6i+hSyp0y3LsGIJhV9HVpP8TaF0vqEwXkACN7sjT9BcSIN/10BPbZ9yVty/JnMspen1
 +3rp2zUKvBba/R08zn69zpvZD0DqEAtme3ahlToRgQiyAXEoHo3LUHktm63oxpLLxUrY
 Gv01AIXY6vpz4oQJh6H+pWR3vQXTh2I1OnT9c1FnAouDB0xOZdOTG358rXZ2b0ECFyqf
 7kdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSlKT+miCWbnh5ZOj77DOUAy87ckVa/YCWsl4ESSZGOtDVP/2LjhFuRPEC+RgrzZOX0u/sFVon09IZ3gzOIKNBFPNgloM=
X-Gm-Message-State: AOJu0Yz/qDnCL46zyB8W/kFnZ2r39lVC57EbmrWOx3ixonQdSGS9ULJ3
 MT0OYGUgSfgVX5osi8cMF9yI1QZeHY25crzaTaD0WD+DUh8Vi/g0vndmwpS5WaKNRuubhZr9Gts
 tpprJgzYcOQDS0dL1kRPfRAf42h7gfnOwHdCiiA==
X-Google-Smtp-Source: AGHT+IG+rGtbF5ynBBjJil67UAcqtRPA7nLGO/h5HMLmyFZXqNe1HNS0DenPbIBK3EU6rMOqBlsywkkweEmbnUWuBL4=
X-Received: by 2002:a05:6808:13d6:b0:3c3:dcb9:118a with SMTP id
 5614622812f47-3c9797329bemr922965b6e.28.1715075018526; Tue, 07 May 2024
 02:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
 <ZjjsyF_ZMIPGqcci@x1n>
 <CAGNS4TaSxprHvoVCMRLw2YCGA2FXirO=Wp-TgzzxquwaL6y51Q@mail.gmail.com>
In-Reply-To: <CAGNS4TaSxprHvoVCMRLw2YCGA2FXirO=Wp-TgzzxquwaL6y51Q@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 7 May 2024 11:43:27 +0200
Message-ID: <CAGNS4TYUPwQFWZ5Pc3eqTkLX2u0_mP5EFMJgGLUva3CGL=ZxLg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000003e3e8e0617da053a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x230.google.com
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

--0000000000003e3e8e0617da053a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 11:07=E2=80=AFPM Mattias Nissler <mnissler@rivosinc.=
com>
wrote:

>
>
> On Mon, May 6, 2024 at 4:44=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
>> On Thu, Mar 28, 2024 at 08:53:36AM +0100, Mattias Nissler wrote:
>> > Stefan, to the best of my knowledge this is fully reviewed and ready
>> > to go in - can you kindly pick it up or advise in case there's
>> > something I missed? Thanks!
>>
>> Fails cross-compile on mipsel:
>>
>> https://gitlab.com/peterx/qemu/-/jobs/6787790601
>
>
> Ah, bummer, thanks for reporting. 4GB of bounce buffer should be plenty,
> so switching to 32 bit atomics seems a good idea at first glance. I'll ta=
ke
> a closer look tomorrow and send a respin with a fix.
>

To close the loop on this: I have posted v9 with patch #2 adjusted to use
uint32_t for size accounting to fix this.

--0000000000003e3e8e0617da053a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 2024 at 11:07=E2=80=AF=
PM Mattias Nissler &lt;<a href=3D"mailto:mnissler@rivosinc.com">mnissler@ri=
vosinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 2024 at 4:4=
4=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_b=
lank">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Thu, Mar 28, 2024 at 08:53:36AM +0100, Mattias Ni=
ssler wrote:<br>
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
n with a fix. <br></div></div></div></blockquote><div><br></div><div>To clo=
se the loop on this: I have posted v9 with patch #2 adjusted to use uint32_=
t for size accounting to fix this.<br></div></div></div>

--0000000000003e3e8e0617da053a--

