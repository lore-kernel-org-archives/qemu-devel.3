Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F35C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljt5-0006qK-QQ; Mon, 20 Jul 2026 05:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wljt1-0006pT-1Q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:02:08 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wljsw-0005ZC-3a
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:02:04 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so10892950a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 02:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784538120; cv=none;
 d=google.com; s=arc-20260327;
 b=mykEbNCnGgsTwMAeoPRkeJ/zCtKzOVp9izTAe69vO0oDDjZrivpGtBRJvvSMLp0p9V
 H8dODZjC37gPz8mzuMaljBlmGnHEQzCcUfSDO5YqMloKX2EDD5MtbzGTH7TwpsI5PLOm
 MaBDgbyCWv7z9WO9t+f8ylHMEv446xLuaT5KLB+kuLNwqMkqShZB1cEl9oHFlcGWporX
 XHHZvEIjpNaIOSv4QU1ejM7vbA1qUKl6Cac9kvblpNClSz2LNb56sgFVTARcHGnjytB9
 00PiZm5KQ19nNXa4J4yKK9h7yh0mxFxCyp6cS9NZuquD/mClwfiR4psSG0vyshjXk2s4
 9C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ONAXVvPXJh7SC5912v7TEsZEjblzAd/g+/PfCPHVlzA=;
 fh=73W7Ai9r/ud1TUtB+afMqkPQHTtJWUNcu/T9z3b7Rms=;
 b=OUP9abg99TjiRlvBPJjk77nXq/pm6PwTVDR20zBLyowCvm2/XOt4iDRmZfkE1lstT5
 so0mKTDDkyda3EicNDvq0mGXTSKsn/x5ZtMLNQ1REQdCS3upanz36h9lrLU5m1KlGrpB
 Aip3CQUQ82YSvequdXD54/U7oM9qr4h1Y5UuWPC3IIX6EZuwLFdzEUCEMhLpIfYX0KQ/
 mzFZJr/AQQXJU9xXByzCUjyS+g0WD2PyTE5ftBjR2qle4xtBBcXAtFGURfPnkS0Pp63/
 tyBtIeCdBsTFwoWIDiJh/vU8bL3+Pie1lSw7vJBmez4NqwXb+of2rSupqepgJ6lqMT7O
 nPZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784538120; x=1785142920; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ONAXVvPXJh7SC5912v7TEsZEjblzAd/g+/PfCPHVlzA=;
 b=GJTjyiL/tyP/h52aY8HDXbN/qTKolwejV+BuGJ8uvOKXR0HdylMh4+1t0yqf49I/Jk
 lOR+B685HtAMI8P+0gHbOjFMQkwxHTQr4tkmJBDObnz0vundSx3STmWI7V69zyVafj5L
 Inp5L+q1QmuqEpkRvBni7kaZ+zkn6HLvwl0reDlbaKTOI1WN0R42CkJbBEeaWuQSAMG3
 8pX9CgEE8GH0JHz6DOzwJjpe3QXF4ru41S8Ag//srJqLOLPgIoI7nGyjjlYDIXk9AafD
 d01Fa4SusSoJqiyj+w/ZW4rsJ/94wDtaKD4wSwx97HYuVINkT6Ys4m4+qfoLSK1Yk3lS
 NiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784538120; x=1785142920;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ONAXVvPXJh7SC5912v7TEsZEjblzAd/g+/PfCPHVlzA=;
 b=KiXYfBtB1wuSsjOiMopyv67qv3kbkQFGTXRElf1jpuNtw1qgtChRF3Mf5jYjwj6ehN
 /S2vso32OS7hMxyPBAJoJqLjVwWIMqHpQBnfONWO6Fexo3seWSzmF5mYQdN5+cJssdzS
 zK0CCng2I7LjEVzFKOpcLeLPncbwLIlQ/TLVCd66wUalAvKJKg9J1s5YlrNTrUjbCyyq
 MDAO+Nxiz1EmRUrZur2upEYUc8wqpXUTdw2dlbyF9vf81Qhm1WjeXZYdRI275gBy++Lh
 91f3PY/hpXXgOqWGoezURTFmlRaQmK374J7qh2Wgx0ZGyFfbq94feDNdpByF/3k3CMBs
 SKLg==
X-Gm-Message-State: AOJu0YxVgc7hRCiPQlZY/uyOhuAp0ljBKg3bzPH4RBxGEcL9/1rO3Jsx
 u4K982gbaxLg1n7coIz6ru3VP4uGOdfWV+J6+2AL49R3SgdMNJx3bt4Rmruuz6lKxKZ4yV0uryj
 2f5ABwxBcERsOlAqe5IPesdiBDWgFwEQ=
X-Gm-Gg: AfdE7cmfHH353AqXZlmQbRNV36Adf08t+KGiJ/UqgHzfAra1APGkP4vDNxHBDWOZWsG
 gldHVYSd44qo8WiOWS1iPDaRdvZBJloTS8rZHYAzECAD2gEhtOUFXxHaWaRGn+j6maVBWD5jgwF
 GUxy5lrO/M2QBGPmA6IrZm69h89ROKEFMsO3G6t+VpA0EOHjnrFfZfXsKKnpYYO8xk5vrUl7S1B
 iQq/swq2ZFyvhJv8EF77JIwVW8ciKMtdubxIsV4adr9MM1W1CqGGPTs/LyJoCEdq+MEPCn70l+Y
 VGsgaGNapFwWzQWkGFXo
X-Received: by 2002:a17:907:25c8:b0:c19:8408:5b54 with SMTP id
 a640c23a62f3a-c198408629emr44876466b.60.1784538119785; Mon, 20 Jul 2026
 02:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260709095056.1803725-1-peter.maydell@linaro.org>
 <20260709201237.46ba7f2d-72-amachhiw@linux.ibm.com>
 <CAFEAcA8__tL8Dh5XwAK_GifA2boh1uMfL_eZgMTFvyMq15hLwA@mail.gmail.com>
 <CAEuJdmrG_rRsivvfhEsVV+7y-q=NZ0L6hzxXPdgWGmX7OOLaHg@mail.gmail.com>
 <CAFEAcA-uotw_dqhV9zkgu8MkuQiPx9kYON4KjWgrnKBTojVbtQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-uotw_dqhV9zkgu8MkuQiPx9kYON4KjWgrnKBTojVbtQ@mail.gmail.com>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Mon, 20 Jul 2026 14:31:46 +0530
X-Gm-Features: AUfX_mwRRMsXbSw8Py2lrSgp1KWoJO1D_qRhXQ1bcNz4drNcCvT4ImzlE2uRX1w
Message-ID: <CAEuJdmroX7y_89UF5A_85NrvLYo7LD=rF=-PYMh_d9+Epm-hDg@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Remove unused helper_lscbx()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000b7d5910657072813"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ed1-x532.google.com
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

--000000000000b7d5910657072813
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul, 2026, 2:29=E2=80=AFpm Peter Maydell, <peter.maydell@linaro.=
org>
wrote:

> On Mon, 20 Jul 2026 at 09:48, Harsh Prateek Bora
> <harsh.prateek.bora@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > I am travelling till July end.
> > If it's urgent, Could you please take it via your next PR or I can take
> it via next PPC PR in August.
>
> It's not super urgent, but I'm happy to pick it up via my tree
> as it's a pretty small safe change.
>

Sure, thanks Peter.

Regards
Harsh


> thanks
> -- PMM
>

--000000000000b7d5910657072813
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 20 Jul, 2026, 2:29=E2=80=
=AFpm Peter Maydell, &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.=
maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">O=
n Mon, 20 Jul 2026 at 09:48, Harsh Prateek Bora<br>
&lt;<a href=3D"mailto:harsh.prateek.bora@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">harsh.prateek.bora@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Peter,<br>
&gt;<br>
&gt; I am travelling till July end.<br>
&gt; If it&#39;s urgent, Could you please take it via your next PR or I can=
 take it via next PPC PR in August.<br>
<br>
It&#39;s not super urgent, but I&#39;m happy to pick it up via my tree<br>
as it&#39;s a pretty small safe change.<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Sure, thanks Peter.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Regards=C2=A0</div><div dir=3D"auto">Har=
sh</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div></div>

--000000000000b7d5910657072813--

