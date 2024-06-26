Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20091C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 15:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMUyZ-0003IU-8w; Wed, 26 Jun 2024 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sMUyU-0003B6-Qp
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:54:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sMUyR-0001tX-PM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:54:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7066f68e22cso3232032b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719417258; x=1720022058;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nmg0M+BfElfb4Qi01C0VYSmJOt4qxm83BG7qHL0XGIE=;
 b=EkjWraa9e71W9Bu/iBExHxBNxqTRoTro7S3jUFgQEDH4w35d/bEq0Rsy/uFPeLPYki
 C2t8c5K7SFDJb76an4AJem0unGeuNSGsWOOPZEqYDW8NOsQGXFNLV/pTAyglnHHj0eOF
 b7Buixo3sKtYmesdQiBFlSaaOlvY0KaiU4nawpQ43ZPF0LisVL0IbMfxhqrv9Yyk7TAJ
 Db7w4psw+Ma//QpEuu6suTIzLcjefroU3xwxhKcBwC9FeSA5Tnrnq/OeURKbIlNvEt1U
 Bb1eQ/3KoMr477ANcLbMsqBElGCZbLGMyUzWI4Ik9K9/uTREKBqE7rDQe0T7Ckgu/wI6
 thxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417258; x=1720022058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nmg0M+BfElfb4Qi01C0VYSmJOt4qxm83BG7qHL0XGIE=;
 b=nRuuzM42SZazyJB+0W5e4SHhyLGVglyY6oo+EySbKoRw9ZSUaSoTUdKpsgrqE3WgZi
 YC9iioE3jZ9JgylnUlLH7QVy9E9hsrs57S/SyAm/d6Dnk5R95K+THvst9RMXyw2hq3ko
 j49zAbPGIfcbu6MtSmkI+H9OrP4Oh38JlkD814QOS6VCbfP9l0Jx/0q44dNFRKYM/vil
 IQ5VL4Bx2peDR4lgohZ5lJTz7DR9V8/6dnQ4vG7Yz+lJH+bTSZnGiHVuK2saAkUjgqql
 eYDkxQL20dIZ8p2DQfEOXVhyGjTP3Z9KtPRwv6rsgBseSsyDIQovPtnxYjFgcyCc5nIP
 48aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv15quAcvG0OE5od2/RzHI+ui4QIyL4gPm/N0U02aArVTKPh8HLp5ds1gyrnOIIF+qdDEaiIDU47uPtQnsUPvevZcG1V8=
X-Gm-Message-State: AOJu0Yz9DpNkJxwCTZjkArdho/k16pVFLO6CF4BEjwfJSay+Lv2Bpen4
 RD2dThMyEt2n4fcjJBM7nijoA2Fzc8PwRTvzwpDErLvcUW0CAYro1yvaB94WXOsJxlTa/2oc54M
 5Y68ssNFnMg3OftG86yrwURpDDqWzMycsfN9IUv0Fa8VWlG0BSUA=
X-Google-Smtp-Source: AGHT+IHLXP5Nz27AwGPWbjhiMGjOktLOJ9PwXduum96I6ZBontFkED5QgdMMeMn429wUOSRLeiq3hh0iwh1e5Oop4AA=
X-Received: by 2002:a05:6a20:7b23:b0:1bd:1df4:bd43 with SMTP id
 adf61e73a8af0-1bd1df4be82mr4930848637.54.1719417257652; Wed, 26 Jun 2024
 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
 <mvm4j9gp0xd.fsf@suse.de> <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
In-Reply-To: <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 26 Jun 2024 09:54:06 -0600
Message-ID: <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dd0be4061bcd0644"
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000dd0be4061bcd0644
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:48=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/26/24 01:23, Andreas Schwab wrote:
> > On Jun 25 2024, Richard Henderson wrote:
> >
> >> can always force the use of a non-zero base with -B or -R.
> >
> > $ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64
> > host mmap_min_addr=3D0x1000 (fallback)
> > qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual address
> space that is in use (omit the -B option or choose a different value)
> >
>
> Well, sure, but that obviously is where qemu-riscv64 itself is located.
> Still not a valid test case.
>

Yea, what happens if you say -B 0x3ee000000 or something else that won't
conflict?

Warner

--000000000000dd0be4061bcd0644
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 26, 2024 at 9:48=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 6/26/24 01:23, Andreas Schwab wrote:<br>
&gt; On Jun 25 2024, Richard Henderson wrote:<br>
&gt; <br>
&gt;&gt; can always force the use of a non-zero base with -B or -R.<br>
&gt; <br>
&gt; $ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64<br>
&gt; host mmap_min_addr=3D0x1000 (fallback)<br>
&gt; qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual address =
space that is in use (omit the -B option or choose a different value)<br>
&gt; <br>
<br>
Well, sure, but that obviously is where qemu-riscv64 itself is located.<br>
Still not a valid test case.<br></blockquote><div><br></div><div>Yea, what =
happens if you say -B 0x3ee000000 or something else that won&#39;t conflict=
?</div><div><br></div><div>Warner=C2=A0</div></div></div>

--000000000000dd0be4061bcd0644--

