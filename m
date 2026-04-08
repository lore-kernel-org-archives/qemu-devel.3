Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DCC10FC45F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcSY-0005xM-Vv; Wed, 08 Apr 2026 19:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcSV-0005wf-0n
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:37:19 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcST-0001yE-J6
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:37:18 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-356337f058aso294706a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775691436; cv=none;
 d=google.com; s=arc-20240605;
 b=hXWXT/QS57DVatQp3KSKu8ocz4AgD23ZLINSwx4hZjJJGSMIAzneoGKkvvxbrc3p8S
 qRoTgr8tGZNlKC19h80Usfu5IBUSoFbXYDLHTMsF5gBUxBhQW9T5RyBZWs4xnRnfO+KS
 pesbXGG2H1sI8si0ITGvs8gIzulyd/PYAOaUytU/qIAFlji0jk3iFr7/vcvLrCL48Re1
 ZomFngeDlDV51VkscWmrxXD3kGuj4z+EvxVv/EEZ9zSGIte+INih8rNSmt3S1eG7aU0T
 z4oouShwOw6l5Dn3S578pRKpesTP9NEROi8qHdws+ZNeZMIwkHGSAIjkrxVCt8vh+6ET
 az/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uzxIP0+Wu+c1/3nvu77bVLUcE+U/rAZDyHkF9UnDmVo=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=G8I+Zs8hjuzYMzxICRSf0QfeNH2xRhlmGoI2M4gWpQzvQgrPPh38gbIc0C66dTlkU/
 vVsQCSTN1qKk5AAtfFrLIpgjWC+b64KzjBpQTlZ2jWQLEBHSyE61URf6newpdw2wkNAL
 KPurfbzOHRShaZA746gcssWLYpxi47Cv85mFpEt3HuKWGvfl/TeBoQUv8OjedMENu3UE
 d7leN+jQXUZV5Q9c0DVX3dp5smTU9iDVsYM7gYOkJPCr+zKp+wRGYgr20N9q50QS/Yj7
 MiDSu3A4tgI8IVysMX6HxHLyenRqIfXDj/JSvclOrOtukOw18ZYJY5J63hD52KL5nqN2
 r7bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775691436; x=1776296236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uzxIP0+Wu+c1/3nvu77bVLUcE+U/rAZDyHkF9UnDmVo=;
 b=E9S4z7xGF8Nl5m2SwQ6o33+uwINUEeJUz+iAWlRXeLpntY+pKgMOVGHPXhq4AyG3Wx
 fH9HctGMc2ARCk2l/KhLMhVm4CjIXZvUXM7N2xJfmXaOuJbHE3O7YwKhGj2cfDGhXhOL
 tBc8ow0KC4rANpxsIEgyofxWgbvHrEdzWmhIDDcZigiRsgT1ZGbIvaa/QbDiimsEvxAA
 wm+2QfZvP8CewRalZY0zQYOicW0U6yYCQ/xcw7ZybJgKjJJpmBOwo0QvSHC6k8pQ6r4m
 vq1juLNcsdisnJpUdg8NDUmBlMmHV2dG4t2P8z65JyJyhzd58CMEnoexFsEfbRa3jztS
 pp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775691436; x=1776296236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzxIP0+Wu+c1/3nvu77bVLUcE+U/rAZDyHkF9UnDmVo=;
 b=OFKwQUMqBXSNPSLOjr75xYLQGKqy987T5sQ0mglP1osvzAuj8hpbFZYXVU7j+tpLSa
 WzwfVPjjbSTCgKPDAr1jE/73DItJXEOupcBRGyUHNnuCzrS/uqCoa/MpwxSy26heVTp3
 gm4eMP4P+lWZcTYJtuRPZy/YbwIe5AH0nEOb6bhnoftfhk2ldK9iJzmiUsEDThpGT/6M
 6YAAUa9DHJ1yHwYN+2aYJrP0yjeISdquv1VgOVeLierYBQVXI56/yldbKarDOgJnMfeR
 yLqYK4AlOFJO3nXf0WeA0977M3IRt5/ZZt7UFMZoy9S/Ie/+Xotgy7Bd6oMCMQ/pMUCg
 cqbg==
X-Gm-Message-State: AOJu0YxAhsGOquI5t9JiW8zyLeE5K46GyY+OKrotwB15MhOXxGSkaiEZ
 S2leGbD/RN849026+XGtL/ZdZ25RPLXDCmAPP6xiJxCAa4Vz4RltvLE/39j+GqX5/GWT9SnnvRZ
 12unOp1wzBaMfYxqZZY5JIjTmo5IBrz4=
X-Gm-Gg: AeBDievrCK7daG7UCHib8BbUOYUhkgqUXZx0xT6nB5eYEBkP6wvehUgKGOy9brGZ0+3
 zn4iQ3ZxcWWe+DQNeozMtyJ+21lIp+8Ngs1KsTipO/ncIP4Cty41eB5kSVjB63N3b5vdP7NNd11
 vGmaAg4lV8F1rr33K36DWQlzWuLPCv13praxg1O8mN9wmqm+o+USTZ2jOcdnRqOBpsE68mMqrqp
 x+ll4Uq9ZffMWyW8WH8OjUmsoTSCIgGfdgpNmenvWoEfoBWqDkpgvEaM2LfQFqpKMVIwN4Y0yha
 EtHd7/x1Z7Fqd1wrRnftOu/0F/EfXksCRVM9aug=
X-Received: by 2002:a17:90a:3f09:b0:35e:30bc:96ed with SMTP id
 98e67ed59e1d1-35e30bc9af6mr2111557a91.10.1775691435994; Wed, 08 Apr 2026
 16:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <99bac24648fdd5c5903e057eb4c9208d851070a4.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <99bac24648fdd5c5903e057eb4c9208d851070a4.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 17:37:04 -0600
X-Gm-Features: AQROBzDBnijb1Qk-Kb9tGyJmnsuuBZDjCtvj-ZgFAnfp8885B7uu-OqfWk7CAMM
Message-ID: <CAATN3Nq=RF19ORFqX3be7KVh8JqVMTLw2K9uHZTarxs4spiXnA@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] target/hexagon: add v68 HVX IEEE float
 conversion insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="00000000000045f27d064efb610d"
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

--00000000000045f27d064efb610d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point conversion instructions:
> - vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations
> - vcvt_hf_sf, vcvt_sf_hf: float <-> half float conversions
> - vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float
> - vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  4 +
>  target/hexagon/mmvec/hvx_ieee_fp.c           | 18 ++++
>  target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 97 ++++++++++++++++++++
>  4 files changed, 137 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000045f27d064efb610d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point conversion instructions:<br>
- vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations<br>
- vcvt_hf_sf, vcvt_sf_hf: float &lt;-&gt; half float conversions<br>
- vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float<br>
- vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 +<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 18 ++++<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 18 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 97=
 ++++++++++++++++++++<br>
=C2=A04 files changed, 137 insertions(+)<br></blockquote><div><br></div><di=
v>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--00000000000045f27d064efb610d--

