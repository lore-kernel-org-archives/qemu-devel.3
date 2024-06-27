Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53708C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpuL-0005jj-Ha; Thu, 27 Jun 2024 10:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sMpu3-0005jF-2t
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:15:11 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sMptt-00067z-Cs
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:15:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so6061826a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719497698; x=1720102498;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v8dLCQbGGaNygF2l3kbb4xVDsdt4jEl0YzVu5MDdb00=;
 b=Zj1D3ln1JlzSxnIkoNokbp1hfBFPpkH4tg/sBzBiAaZ5PXNc4YnaPZ/9c64EE4qDmg
 k+CCZoBRzG8QTVcDfd6WLTvDBzPL8E1UsvSI3l1QkapmF9SikucLgz4f4sKQhcZ5wW5S
 nXpGoZXxWq9Dw2czKPXaxOQvzVbjF+bq7Q6l8qZME6tbahE23665/27oxJNxCneiPazN
 D+gD49soe+4LmnWd2ZcWb0p2BJZGI9wdK3HZlsNwErfnEWC1WkDnqjrrb8UCgxi/W4z4
 UMcoHJuX7pPOzOyAy9pF8hVYtNRUHhq/2LbCfPv3J8RrkXIl0enRsD9r/qEeBkkWgYHU
 FOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719497698; x=1720102498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8dLCQbGGaNygF2l3kbb4xVDsdt4jEl0YzVu5MDdb00=;
 b=fHn18yLcmggNzZj3EQxzhvcA2WdgkHLUck1pX0HUccoqM53tRdYyeBHCo5kJcGiIJX
 BY276FqtuTvzyr7j8FymLfMJU/nwMT9qEoTleFCDrKzaVshpHLDnbWMhhPJ8JtllDS7B
 GER9kTdOHiZJXNQ9NpNATI4f/d6M/uudxo260JlO5e2ZO051gTJeFLxUnxpUYGJDBSYU
 LAOSez5e06lISLiJxmF8m4GEvanfJvhl6a2Xs4tf/4aLmrR6Im9JPoN5FmgM4QiAAKbs
 5FaXrOc+tbP0vSSp/BYcq24JAuvCAuFdZKT7t7zqxBFIJFg9gVbIlI1T6y7jX9HGebff
 pugQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCrQFGh9Rs8EDD9vP7gozvvc2jeYmsEpMdrBn+prqa6IXFUhbETBMNNnsbJXHQJX2GdV4MYnVonxl6ZQKx3FMp8EaHyew=
X-Gm-Message-State: AOJu0YzKZpsWdB9YTGISzwK0tLAjhiKm1DbNbtIIm7YUbgNTDpqDmfPb
 LKRpr0uQ/aV4cSYVPOVuxU7mC8UQgTQRDL68Uq1/ZSWufeWgen8G8AkHm1SEMYm4g+fRKsOSUd3
 N6Gd4/Qs5DIpzgZ/fuskTHJ+wG15C+Jp4PoAthQ==
X-Google-Smtp-Source: AGHT+IHQqeSh1qUY+NiZxZ8TMI0XbALYXda9aiBo0VPyTYrNshXy74MXWKlcOM0/ewTyg8KmYx/U8ZKY7RdEXPD4qj0=
X-Received: by 2002:a17:90a:db91:b0:2c8:5ca0:70a5 with SMTP id
 98e67ed59e1d1-2c85ca070c4mr12059086a91.20.1719497698260; Thu, 27 Jun 2024
 07:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
 <mvm4j9gp0xd.fsf@suse.de> <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
In-Reply-To: <mvmv81un7m9.fsf@suse.de>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 27 Jun 2024 08:14:46 -0600
Message-ID: <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007f54e1061bdfc13f"
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102c.google.com
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

--0000000000007f54e1061bdfc13f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024, 1:54=E2=80=AFAM Andreas Schwab <schwab@suse.de> wrote=
:

> On Jun 26 2024, Warner Losh wrote:
>
> > On Wed, Jun 26, 2024 at 9:48=E2=80=AFAM Richard Henderson <
> > richard.henderson@linaro.org> wrote:
> >
> >> On 6/26/24 01:23, Andreas Schwab wrote:
> >> > On Jun 25 2024, Richard Henderson wrote:
> >> >
> >> >> can always force the use of a non-zero base with -B or -R.
> >> >
> >> > $ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64
> >> > host mmap_min_addr=3D0x1000 (fallback)
> >> > qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual addres=
s
> >> space that is in use (omit the -B option or choose a different value)
> >> >
> >>
> >> Well, sure, but that obviously is where qemu-riscv64 itself is located=
.
> >> Still not a valid test case.
> >>
> >
> > Yea, what happens if you say -B 0x3ee000000 or something else that won'=
t
> > conflict?
>
> I didn't chose that number, qemu did.  If it doesn't work then qemu must
> be fixed.
>

And when you are diagnosing the root cause of the bug, the submitter of the
bug sometimes needs to do diagnostic tests when requested, not attack the
volunteers who are trying to help. If that's all you do, there will be no
fix. You can't talk to me like that and expect any reaction but "I have
better things to do with my time than deal with this jerk" regardless of
the merits of the original complaint.

Warner

--=20
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
>

--0000000000007f54e1061bdfc13f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 27, 2024, 1:54=E2=80=AFAM Andreas Schwab &=
lt;<a href=3D"mailto:schwab@suse.de">schwab@suse.de</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Jun 26 2024, Warner Losh wrote:<br>
<br>
&gt; On Wed, Jun 26, 2024 at 9:48=E2=80=AFAM Richard Henderson &lt;<br>
&gt; <a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank" rel=
=3D"noreferrer">richard.henderson@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; On 6/26/24 01:23, Andreas Schwab wrote:<br>
&gt;&gt; &gt; On Jun 25 2024, Richard Henderson wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; can always force the use of a non-zero base with -B or -R=
.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; $ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64<br>
&gt;&gt; &gt; host mmap_min_addr=3D0x1000 (fallback)<br>
&gt;&gt; &gt; qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual=
 address<br>
&gt;&gt; space that is in use (omit the -B option or choose a different val=
ue)<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; Well, sure, but that obviously is where qemu-riscv64 itself is loc=
ated.<br>
&gt;&gt; Still not a valid test case.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yea, what happens if you say -B 0x3ee000000 or something else that won=
&#39;t<br>
&gt; conflict?<br>
<br>
I didn&#39;t chose that number, qemu did.=C2=A0 If it doesn&#39;t work then=
 qemu must<br>
be fixed.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">And when you are diagnosing the root cause of the bug, the submit=
ter of the bug sometimes needs to do diagnostic tests when requested, not a=
ttack the volunteers who are trying to help. If that&#39;s all you do, ther=
e will be no fix. You can&#39;t talk to me like that and expect any reactio=
n but &quot;I have better things to do with my time than deal with this jer=
k&quot; regardless of the merits of the original complaint.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
-- <br>
Andreas Schwab, SUSE Labs, <a href=3D"mailto:schwab@suse.de" target=3D"_bla=
nk" rel=3D"noreferrer">schwab@suse.de</a><br>
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE=C2=A0 1748 E4D4 88E3 0EEA =
B9D7<br>
&quot;And now for something completely different.&quot;<br>
</blockquote></div></div></div>

--0000000000007f54e1061bdfc13f--

