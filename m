Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32D4F53D76
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2BED-0006XV-Go; Mon, 16 Mar 2026 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2BE2-0006X5-QE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:55:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2BDx-0000n7-UM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:55:29 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2aecefc7503so20987505ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773680124; cv=none;
 d=google.com; s=arc-20240605;
 b=VhjvTzS+PQlooelD7PLFx+YMCoz4mzw85YWaGDVZmzlS1kHTUcy8IBahLZOi300qXh
 f0M6IWa5rscrkBpzopI7GvOQQwJytuU8ufZhvqH0z6erNO+Q+tfTtUYsVVEasmcUqco2
 mZU9PCJkjuDzqgreI32tr4L8uqKr7Dvbb9rukR208I2hqQ/0qKkMQ0HeRCQ/K/Uq7fkc
 gVK43Xj/u+3HVEtPGu/YN5wJfajtheZhg7VzYJ/uffFlAyNXFaP47jAKX5/fDRKCfKDK
 AXYNsURDHIxNOh6IFEQgvoZGZewultbzySN9FzJPqlPnHygYwz1BCsbQ9E+2ksmAkg/V
 hYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FkzDjEXghZmNw0jZFhY0tNGm1mxtVCG8CbGzX1vUCFg=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=ggghcV6TDoyA8qsK0Hqk6P+nIBdeUzVLJdKdZoOIcOTAPMjhwjoM//4o9xBLtVUSvN
 l+1F/xa33RrFuvDnn81SR1uf+blU68aoyYGB/UanvC3PaOBiOBGfN7tiYzFD448oDAag
 bYHMf37c4pn2tsS1F6NNuhT2rFw5k7+vG9RIsG0lcbOOCjqMNzhS3ebgNkqPj1jES1MT
 DjaCkP0SpR50M3nGWGLpMQRHP7pS1DD6BeXFsDAgsNmxTsPdwRny92Se0b2+FLKqZWag
 2I8qZYO8DQxNxv4be+Z2YbF1leDP9dJz+drcnDzQgU17k+eP5TUN83gL9APhB9UWQUcH
 4+0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773680124; x=1774284924; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FkzDjEXghZmNw0jZFhY0tNGm1mxtVCG8CbGzX1vUCFg=;
 b=g4Xj2RFBbmYFsuJIBy0nWBvuoegQ1E4YWdCJqvGPq4UDnDOWfibCbgWZMhvTiyldf4
 K38gIdNxkA/Wi708W0TMuRptR+Tg9YLpyVIquCSSg4SvROs4r/rsBbA8avPMCuwdNWoW
 wZ8NBuPBetIjnFtmuvjSPC18BRCWNfFw14Blkuk1JT077LXAkL8iyPpLcQRqGFIGPQcT
 7NCD4WmcL4bJVSRKik/b7HHIboi8Zf0IFuQ5UBG07G36MYqINTpXEsP9xoE1QeybD3vc
 1PEC3LBsskw+MnvvPv/znFIVxWJG5oECDv9jE1m5SFHSlxw6Qt89P/pwqX11WXRgVL+B
 4fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773680124; x=1774284924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkzDjEXghZmNw0jZFhY0tNGm1mxtVCG8CbGzX1vUCFg=;
 b=eROFP7QsjeMdAJpFKxgz0gXM4+yJ9qFHXD6zfwajyqw4rvcFpNr2Um9qv8EWzs3xXz
 RJ5DY4C2wyytYrXr4U9twkpdIZ/pQJyvCa8qF9ptLWrJNmV0Lv3EXDUXzuD1uf4kqv4w
 m4vS80TOnVpiAj/vj3E8rku17sVRfVwukkY2fbtuxB0Br+TIG2qvggHulLHwfRaAs930
 bwesSuZW/AyLRQYBuXF5pXX9odBjFT80g+NoWV+OP8EfGuFko3Zg+VDMzv27fpiBdmWZ
 kWl7kfxEuMs5vTdT/uvqursCms0NsPy56Lrw2M7Yi5uxUUjxTAOuX8/wO/3rl0NWVH7/
 IFYw==
X-Gm-Message-State: AOJu0YwgW8LkPohZ3QuiLk7wx0hN4tS+bATWfZKUwh6nMv3ZLkkZFoVQ
 5+BZlH6IyWRJvw9V1JNK2e0hrtUIACtrvPvNesDhutzhKwFolZsY3bJt7GlGJCbqOFjy+nQijPR
 4z7Z+KiZwZKnEDidsoEHsHA2FEcHTZ+A=
X-Gm-Gg: ATEYQzxtQXLbDW3wBCGjnLzDiahavTPbYvmGZN6bubzcQwYIBmf8vHTUf5jUSWVY0SK
 ZL31NExxgOe3VtshcR7xJn6mM14B7pD1eDAxp0D5x/X9WCnmQl3dOWebViu7aJm1ZPPJOfXFz0H
 xbihEE5VLu4VkfreCzyER3DbPUf8mIbFCY6lQvU/v/eXzxgL+4vpFDRYPEAk0mkuotVaIF7hq/8
 iRhB1KzSysn1bA17uidaVHPmwVOCBAaiSm81xETsDDeePuckfM0w3FQni45XI0SIgqyiCWoSpKR
 JezkWrTYuXR628ivFR00wepoWKo+rpLVADb1zuNU901OErnD
X-Received: by 2002:a17:903:8c3:b0:2ae:c7e6:a13b with SMTP id
 d9443c01a7336-2aeca92b90emr129180995ad.4.1773680124047; Mon, 16 Mar 2026
 09:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-24-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-24-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 10:55:12 -0600
X-Gm-Features: AaiRm50kcCiKXiGOPEcEvbMuQ7poR752ZG9YeJX630P5PtHVuMIW20O9QjeU1YQ
Message-ID: <CAATN3NroFnCQvOdQ0LT5C4DES_79oxkRpymq2uqvKUJaC6k-WA@mail.gmail.com>
Subject: Re: [PATCH v3 23/32] target/hexagon: Add pkt_ends_tb to translation
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000bd3628064d27151a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62a.google.com
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

--000000000000bd3628064d27151a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h |   1 +
>  target/hexagon/translate.c | 102 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 82b327312ec..4e090565aac 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -85,6 +85,7 @@ typedef struct DisasContext {
>      TCGv branch_taken;
>      TCGv dczero_addr;
>      bool pcycle_enabled;
> +    bool pkt_ends_tb;
>

You don't need this as part of DisasContext


>      uint32_t num_cycles;
>  } DisasContext;
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
>
> -    if (pkt->pkt_has_cof) {
> +    if (ctx->pkt_ends_tb || ctx->base.is_jmp =3D=3D DISAS_NORETURN) {
>

Just call pkt_ends_tb() here

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000bd3628064d27151a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/translate.h |=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/translate.c | 102 ++++++++++++++++++++++++++++++++++++=
-<br>
=C2=A02 files changed, 101 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h<br>
index 82b327312ec..4e090565aac 100644<br>
--- a/target/hexagon/translate.h<br>
+++ b/target/hexagon/translate.h<br>
@@ -85,6 +85,7 @@ typedef struct DisasContext {<br>
=C2=A0 =C2=A0 =C2=A0TCGv branch_taken;<br>
=C2=A0 =C2=A0 =C2=A0TCGv dczero_addr;<br>
=C2=A0 =C2=A0 =C2=A0bool pcycle_enabled;<br>
+=C2=A0 =C2=A0 bool pkt_ends_tb;<br></blockquote><div><br></div><div>You do=
n&#39;t need this as part of DisasContext</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0uint32_t num_cycles;<br>
=C2=A0} DisasContext;<br>
<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br><br=
>
-=C2=A0 =C2=A0 if (pkt-&gt;pkt_has_cof) {<br>
+=C2=A0 =C2=A0 if (ctx-&gt;pkt_ends_tb || ctx-&gt;base.is_jmp =3D=3D DISAS_=
NORETURN) {<br></blockquote><div><br></div><div>Just call pkt_ends_tb() her=
e</div><div>=C2=A0</div><div>Otherwise</div><div>Reviewed-by: Taylor Simpso=
n &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com<=
/a>&gt;</div></div></div>

--000000000000bd3628064d27151a--

