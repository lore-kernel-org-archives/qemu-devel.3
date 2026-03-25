Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94AE109192D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ctf-0008NC-6m; Tue, 24 Mar 2026 21:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w5Cte-0008Mx-GG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:18:58 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w5Ctc-0004Gi-Pw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:18:58 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a1d4a095bso277803a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774401535; cv=none;
 d=google.com; s=arc-20240605;
 b=aI8SwDVnL2yck0BLcfbx5vV1/CD+ZAek49IZVaDaUp/Jaaegmpn+INHt47uCnmbzK0
 JXtT/R4Gf0fEEgMEhYP7VR+/+dJ8xe78NkMUXHCxQ2GziW6LAz3U5qsrwLzwd6MuUt1X
 j1wHiirW7QhOb0m7MPSTz8+k7rzwy1Ghg/l98y6ZphXUUSyFHR4igk6F96J7slUnfzy/
 SRzL5WpDPSVjNwsoNjfSh+i9NRcEtUVf4W/6sUdclKnxnccmTrsdQtwQud+YI9mGYXBw
 znBrDxtViC89lcA5HpF0WCxxGQMBZe5578lof6uZe+lW+/Wzxfcynae3e8cssbPXjxx/
 JfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G2OgRpi0ri4EDkz5QWaDK9Prag90c3dEm8/KTMOsSjo=;
 fh=fJqGvtWqLDKIzOXW1wAsc3/gnAi5Otjc7uqp16gUscQ=;
 b=Np4Z6nQDFjSIVUJ3D5/szFSxeu+sygzc+xndADaLlIJnGjyNB4PEjmuDJdph7UKx0A
 Ao4CFD3MixjIgBE/7rYoN8vyUiECZ2hj0Qwin3A6QJkOcz8vA49iCsOk1tTFeuCw5wNg
 +ognMTNq9DYJLuRpVwOS8GYPqeCZ4khdYIqhzuRLy394iRUm47k+MRW97WmGOCvWL85A
 hbcGp5vEYGOWdPgV8E3GnoRQoxPPiWvVGtxnDhWBPZqEzmQhHNHpQJ2l6MZS8LVih3Ek
 iytfcTPWwyduIHUV3Zk5UbEP/NZqn+g1u9PotgCH/w2+zxH6gvzONXb20wgkAjQbKhUn
 uiZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774401535; x=1775006335; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G2OgRpi0ri4EDkz5QWaDK9Prag90c3dEm8/KTMOsSjo=;
 b=TtkMxFJRTAPB8hTAp7aF2AJZJiUHeEa/eixNNzUXv7jgXUpYZbuMGhqIpCQ822JQfj
 HjP70yJSqa1XM9rVR3Ifb4M/xxqk1iSoC9aSrLlzKozl/ly2Gu4cbedgO0bO0CpT05C3
 OzRMQFN4M7AHvCiAMAVwTQs6ntfKZUNoGE8hJzXULh1u7erfG41CjwOW65fwcmYZo4BC
 4GW5Pbn1CMCswdRGZujgexPup9N9nyyAc5dres8tqBv0DmfYzgNe5PXNu6b1gRDDaLiZ
 AYZ0xK7CLyNFNy6ZVuEwkBGDzrECUZqKtIadSL9MRqXxQq8X9BqpM9JuNjVsGfiHvUa7
 Xdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774401535; x=1775006335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2OgRpi0ri4EDkz5QWaDK9Prag90c3dEm8/KTMOsSjo=;
 b=b1R+oXrVSVTEJR5ZVwlyqO4/t/B7xWMqVeFZ1rMCuwJvyLAkkTnoyd15q4m4UXzdiU
 ch4/+F4JiCOMSVdBOQWK3c+T/lCH3Sugi+rwxbdrgp1rfbyEeCemq4GaWMZIdEetGm5+
 E0LacYVBHxpurkoPXYeFFxzcyiKjAbubunDa9+cW1W/+6DAqn0f7KTsMHoLdr4YQUfiA
 wfs01yiSjOhWB3RXRp0/Qj74YnmGAIu/t5HFGmn04eY1SJ3lP/qF8qTbZoY96w7+zSdU
 lZNle6iQXbFR9p447jOfZG0+q0SA9yGV0C3OMW7rmp8sC/7YpLzr8M/wOVILLtkE4i1G
 YGjg==
X-Gm-Message-State: AOJu0Yxo1oQ+HmN8vs9Tiw4jJePGOMkGJrs+RJOrZouEBMy9PIXv11mI
 ar9birk5QccNPtkSfu37EVxVlTQ3c7qtSJjElc3GxNEkzWM33admiPXuiVyhQMgkKXWRawjKB9m
 qnbcihGmdnRtT9NmkIaWjVWXuBLbK0Cg=
X-Gm-Gg: ATEYQzwlRuFARKfEdqCsO7be/m25hf3aoMw98J+MSM4cnQMR0AAl6USvFhYcyQODe0g
 WW/SP+zJOFfD7kXQr+o8Y08LloPdQpyNejKCV6Tz44Sbxm8IBm9s48lkODVmz+zlzUHGUXlaBEb
 W1kTswOAnt9iJhvaqy5vrVNctPuRszznTsijSu8qq1GXGnl+fjyRajX00apvblPxWCsZ/5dgoDS
 j70nBIM02RKRYS34lHXcxFPIiHcdo0sKuJdBLPl//UFWEU1JVfCGz78Z6+KucBqaeJ2/VUGOvts
 k3WCezhjmEp2m28UIoKobI9PuRiQNSPAfhNE0dbqxZS5hD0MBg==
X-Received: by 2002:a17:90b:53c3:b0:35b:92ba:66e4 with SMTP id
 98e67ed59e1d1-35c0d12f216mr1441809a91.7.1774401535180; Tue, 24 Mar 2026
 18:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrZVn6W0pAyshZ7mhYVcY+gtRk9tJwz5WLLzxoPTDupwA@mail.gmail.com>
 <CABrGZ+GmYG2tg0pWDoBuydWG3abTmMT2wxCu=06fXLQJQCS1YQ@mail.gmail.com>
 <CAATN3NpNvqBLdsz7euvuUGTMYxCusQ+MYSyo0GHgFrvZHTBs7A@mail.gmail.com>
 <CABrGZ+GDw1PwHHiBNpp0_FTOceB=d2uTNXg7nXRufubXR48hUw@mail.gmail.com>
In-Reply-To: <CABrGZ+GDw1PwHHiBNpp0_FTOceB=d2uTNXg7nXRufubXR48hUw@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 19:18:44 -0600
X-Gm-Features: AaiRm51daLrTdKz8EFJ3uxWxW_VA0vJJvRMkE9VD0_uTHgEQQoEz8Yiy4-v8K_U
Message-ID: <CAATN3Nqyiwwye-_DuTb_PEWXzhEDmAK_8oOMvwhZNPwGbm6zug@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
To: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000003182e2064dcf0d42"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1034.google.com
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

--0000000000003182e2064dcf0d42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:00=E2=80=AFPM Matheus Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> On Tue, Mar 24, 2026 at 4:51=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >
> >
> >
> > On Tue, Mar 24, 2026 at 1:30=E2=80=AFPM Matheus Bernardino <
> matheus.bernardino@oss.qualcomm.com> wrote:
> >>
> >> On Mon, Mar 23, 2026 at 5:29=E2=80=AFPM Taylor Simpson <
> ltaylorsimpson@gmail.com> wrote:
> >>
> >> >
> >> > Do these instructions interact with the FP bits in USR (e.g.,
> rounding mode, FP exceptions)?
> >>
> >> They do not. I'll add a new env->hvx_fp_status and use that for the
> >> default nan. This way we can avoid messing up with the scalar
> >> fp_status.
> >
> >
> > That will work for the nan.  Is there any programmer-visible state for
> rounding mode or FP exceptions?
>
> No, rounding is always float_round_nearest_even (the default) and
> FWICT the HVX IEEE FP functions don't track or report any FP
> exceptions.
>

OK, then disregard my comments about checking the exceptions.

--0000000000003182e2064dcf0d42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 2:00=E2=80=AFPM Matheus Bernardino &lt;<a href=3D"mailto:matheus.b=
ernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Mar =
24, 2026 at 4:51=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Mar 24, 2026 at 1:30=E2=80=AFPM Matheus Bernardino &lt;<a href=
=3D"mailto:matheus.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.b=
ernardino@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Mar 23, 2026 at 5:29=E2=80=AFPM Taylor Simpson &lt;<a href=
=3D"mailto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail=
.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Do these instructions interact with the FP bits in USR (e.g.,=
 rounding mode, FP exceptions)?<br>
&gt;&gt;<br>
&gt;&gt; They do not. I&#39;ll add a new env-&gt;hvx_fp_status and use that=
 for the<br>
&gt;&gt; default nan. This way we can avoid messing up with the scalar<br>
&gt;&gt; fp_status.<br>
&gt;<br>
&gt;<br>
&gt; That will work for the nan.=C2=A0 Is there any programmer-visible stat=
e for rounding mode or FP exceptions?<br>
<br>
No, rounding is always float_round_nearest_even (the default) and<br>
FWICT the HVX IEEE FP functions don&#39;t track or report any FP<br>
exceptions.<br></blockquote><div><br></div><div>OK, then disregard my comme=
nts about checking the exceptions.=C2=A0</div></div></div>

--0000000000003182e2064dcf0d42--

