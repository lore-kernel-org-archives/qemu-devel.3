Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323FDC88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 04:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5FD0-0002sE-8C; Sat, 12 Sep 2026 00:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x5FCw-0002rs-9C
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:19:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x5FCu-0001Du-GJ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:19:18 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-869d181419bso1567188b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 21:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789186755; cv=none;
 d=google.com; s=arc-20260327;
 b=TIhinfqdM7FoMpvTaf2QxNSyiup8czykXI2730cpwdlY8uquMFxjJMTWOx6emWwaLQ
 U41ZpJDdd4YcyNU6sLeW3oTxylPmwruvJ2qy+fERPZ/J9cqsD0DNbJfCjVmW8PeTWhXR
 +Eb51Y+iET95dtq55UxlEdGdQCbtEK9oYX4tGPJcno28rOATBlWJ2nsV7FVQEaDpUxsO
 pvh2A8smLfPbDj92LZYgRzGnQxxNCJM0FUqy+ZlUobMUA3BJ2wPW8DHAiOGNOACIB86a
 oGme4MA/lVw67vQ408EQkRBRaPb1iugetdn3IfLwD7ojlTdQMrmWlhrViFIIiT48CFrC
 oxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GQfF2dvKpzTGruiZA24k1p5F0wWNyBKx3h1w5e3r5Ng=;
 fh=YojO/rUrd9bEiBBeCSQ5G4JUS14mZG7zALMDwLLdQFc=;
 b=A76xpouI6Zpgo9OHakjrAo5oPMKSVnTDJIQfcWSQ7b6cCJk2NJra1pwpsuJD0QbnzY
 bIZBIomKexbGpFQIEqjnMltpFhoJD+l/WXvPjAHL6fYtRs5VrMrbKHTtSnubCWbC6Kxn
 /A6GNuxACecFHxp9WVhnjOAuxXfv5fT6fc89dbJoz0dC6YT1jUZuSNNiJVdp8PHxZdhv
 HK5G9lm92QmYpWQBeg/wpcmaypc3YsAteB3oCKTN7GEWLHXixiqhawkYgGOXmqxw5aaz
 jl4T8nVGzwDW/pfgc1sHE2ZAfsdzrizR7qxQyrs9rEw2uBzRRH3CC/e+I7SR6ZaLIRw6
 6cMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789186755; x=1789791555; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GQfF2dvKpzTGruiZA24k1p5F0wWNyBKx3h1w5e3r5Ng=;
 b=qpw7NmVtVzu9KVHkks84xBe/Ic9BPix6bwVdv0C4IWLbFZ2jKWn09W5F9fZ5gpQcid
 4Q/XvEjwYV/ErVVZDLYv7Tq3wvDXMVEX1KezGFSlViY/E47AK9ccp3rbdpH/10mV88Eb
 vmCatmKvcoBE05d4fSyAH2t58Ph/Hn6H5I9aXGlYzq60uJohdo6+ympoBY8hrz9wOvSI
 lp3bW1I7RVuCeYN/sgwc2kyIdlBzIS/sCEWfRe3J7FyNfiF022Bxpgon1TtQVRrRi8Hx
 WP4xco7oMMiXvJkCO33B5gESshzpivlYHSX6WgzkM7dk8dfT/Ad/oLrY9D5Rxss1/MKv
 AxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789186755; x=1789791555;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GQfF2dvKpzTGruiZA24k1p5F0wWNyBKx3h1w5e3r5Ng=;
 b=sdxeCFCTMpZ4owuyYc1N3oDRRrvjENZ40JYCLvItCqldR50dykCmcuXtQV68oUZDAz
 aTO/WwUJgidKF50O+1x0F1xrSOOcUZTglusxhpi9aRqO+1jQVsk5omUijfMdf7MWwMv2
 jJtrV5CInclyl7XMee2G4V8BGuRLk1eUnuI3ujQbJdXhNfXAtirEs6Tu8Kp0ZrcQKxCF
 WtkiDxw7kp+uS9PXfNOJ6ZFEWPMOnEDyyStPJsgKwo0rUvq50f8btIGQyH0M0xJm2bQg
 xLPwJqS7zXLzp0Y53dNvlbhIqM8kins6mlYJA3pv2LHBOYDfKLhcdYQ/qTLtKQe06ooP
 bsAQ==
X-Gm-Message-State: AFuF++npb/W1bK3Yf03nW1LlBJscxgCqUU0pPOfCblexUchem40ilJ+h
 8Bew8DEII8wpAIFG+f+TMW6fx0ZToLrXzxalPB4S4anRiAU6U0/zxBrpNm1+wkpx3NfC+Lq6m1Q
 kDpFh3r1DofK17tUqYUJQgyplXUHDpY8=
X-Gm-Gg: AYBFou3EpoeNAsw604TWrU98/xag/uHt6/QauGeRewnnVRgrb8PSEFiOGFkaTWPynGA
 msnCgNtb81N2Xp57dWXxwqxv2DcrNFIqiOFdkvLAr5AyJ8YNhIV/6wEMZM/zmPuivwKjcsTu9ey
 zwijqpjQGAivKgPb8d3VJOK06LU7a3c5O+pN2sYZEPYtt8V++4xGHxtVVV1qh7OWNNbDzompvjT
 NWxgU2uDXpF8P35cK6MbmDJpcVOOQ3WZulCw6AY66D6w+sC8yuRbtv6KAdcM1O7srLv05tHIsv5
 sKopUayhL4z8hXGpLrC+1c9xBvHJQZn+zc+vYIHYoKbw7HnLo1/U9tSaWP4usg84XN+FkwEgQWz
 fkRaLCMJaX2ogy5wxXATudg==
X-Received: by 2002:a05:6a21:9087:b0:3d3:ae1f:d7f5 with SMTP id
 adf61e73a8af0-3daed617da0mr14174448637.21.1789186754856; Fri, 11 Sep 2026
 21:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <8e57b80a-1f0e-4471-8804-257971ee781b@oss.qualcomm.com>
In-Reply-To: <8e57b80a-1f0e-4471-8804-257971ee781b@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Fri, 11 Sep 2026 22:19:03 -0600
X-Gm-Features: AcwNN1UW6hioehmU2IJhQq2eLeIlp3O9iyOVlxuMgi0dbimHCPbxyPSB9oB97T8
Message-ID: <CAATN3NpNYm+uPgB5-vCTmFH9g_D3ZaaCA35Y7H4VjLcpkC3iEA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Hexagon (target/hexagon) Check for multiwrites
 in analyze_packet
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000f5cc04065b4180c7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f5cc04065b4180c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

>
> On 9/11/2026 5:08 PM, Taylor Simpson wrote:
> > Currently, we check for register multiwrites during packet decode. The
> > downside of this approach is that it only checks a single destination
> > register for each instruction.  During analyze_packet, we can check
> > for more than one write per instruction.  Further, we can check for
> > different types of registers.  This series adds checks for HVX
> > v-registers and q-registers.
> >
> > Note that multiple writes to a predicate register are allowed on Hexago=
n.
> >
> > Changes in v2
> > - Rebase against latest sources, including Hexagon system mode
> > - Add checks for multiple writes to system registers
> >
> > Taylor Simpson (10):
> >    Hexagon (target/hexagon) Move code out of gen_start_packet
> >    Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
> >    Hexagon (tests/tcg/hexagon) Add tests for multi-destination
> >      instructions
> >    Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
> >    Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
> >    Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
> >    Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
> >    Hexagon (target/hexagon) Check for greg multiwrite in analyze_packet
> >    Hexagon (target/hexagon) Check for sreg multiwrite in analyze_packet
> >    Hexagon (target/hexagon) Remove old way of detecting register
> >      multiwrites
>
> The greg multiwrite change seems to have an issue here. clear_pkt_ctx()
> needs to clear gregs_multi_write?
>
> You can reproduce the test failures locally with `make check-functional`.
>

Correct.  There are problems with both gregs and sregs.  I'll make the
fixes in V3

Should I add a multi-write test to check-functional?  If so, please advise
on the easiest way to do this.

Thanks,
Taylor

--000000000000f5cc04065b4180c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11,=
 2026 at 8:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
On 9/11/2026 5:08 PM, Taylor Simpson wrote:<br>
&gt; Currently, we check for register multiwrites during packet decode. The=
<br>
&gt; downside of this approach is that it only checks a single destination<=
br>
&gt; register for each instruction.=C2=A0 During analyze_packet, we can che=
ck<br>
&gt; for more than one write per instruction.=C2=A0 Further, we can check f=
or<br>
&gt; different types of registers.=C2=A0 This series adds checks for HVX<br=
>
&gt; v-registers and q-registers.<br>
&gt;<br>
&gt; Note that multiple writes to a predicate register are allowed on Hexag=
on.<br>
&gt;<br>
&gt; Changes in v2<br>
&gt; - Rebase against latest sources, including Hexagon system mode<br>
&gt; - Add checks for multiple writes to system registers<br>
&gt;<br>
&gt; Taylor Simpson (10):<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Move code out of gen_start_packe=
t<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Check for GPR multiwrite in anal=
yze_packet<br>
&gt;=C2=A0 =C2=A0 Hexagon (tests/tcg/hexagon) Add tests for multi-destinati=
on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 instructions<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Check for vreg multiwrite in ana=
lyze_packet<br>
&gt;=C2=A0 =C2=A0 Hexagon (tests/tcg/hexagon) Add tests for vreg multiple w=
rites<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Check for qreg multiwrite in ana=
lyze_packet<br>
&gt;=C2=A0 =C2=A0 Hexagon (tests/tcg/hexagon) Add tests for qreg multiple w=
rites<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Check for greg multiwrite in ana=
lyze_packet<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Check for sreg multiwrite in ana=
lyze_packet<br>
&gt;=C2=A0 =C2=A0 Hexagon (target/hexagon) Remove old way of detecting regi=
ster<br>
&gt;=C2=A0 =C2=A0 =C2=A0 multiwrites<br>
<br>
The greg multiwrite change seems to have an issue here. clear_pkt_ctx() <br=
>
needs to clear gregs_multi_write?<br>
<br>
You can reproduce the test failures locally with `make check-functional`.<b=
r></blockquote><div><br></div><div>Correct.=C2=A0 There are problems with b=
oth gregs and sregs.=C2=A0 I&#39;ll make the fixes in V3</div><div><br></di=
v><div>Should I add a multi-write test to check-functional?=C2=A0 If so, pl=
ease advise on the easiest way to do this.</div><div><br></div><div>Thanks,=
</div><div>Taylor</div><div>=C2=A0</div></div></div>

--000000000000f5cc04065b4180c7--

