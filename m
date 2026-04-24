Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D7AFED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 20:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGN0y-000223-Ps; Fri, 24 Apr 2026 16:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGN0w-00021s-KM
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 16:20:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGN0u-0004Mx-TD
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 16:20:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso5719835f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 13:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777062034; cv=none;
 d=google.com; s=arc-20240605;
 b=Eri9UnZJXHn8uhTQ9HIREUhLgRBQIMd6+x/9ZjX1XKlK1bhIYq5HL3WRh6S0DC1A6p
 5H+rte0etK6UU2tJpY7Ea9NLyaO8iYpFtAK8XviWS4dDxevIBTDWyMzUWu+S7afdZqG1
 zmLhTC+Cd+OTNj9TsvgqdQOeymj0Fycs5MAtj4uP+tcUWKS/hhUnyBKTeomjY834ji3n
 MHydkiNeXtbdiBSDj4eZlKNZvkeo29nBdU6aWif784q6sXC03tq17VYNw3AmKS7IggWe
 697LCnei22ngQB1YyK35pDXpf9YWo8aW+OomutPSQqA7eipjQB1PcswMnA+C24uFfvkp
 kw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IJ6fNzuSCvCYkRa4+sIxpzodEgpF6VksrxgpZsibvcU=;
 fh=WYF2hQMZUdXau+yd+eBZ5VHthFA/VU4yQbUA7zYvoV0=;
 b=B0abQqDYOCinRhdbhsZcxam7/32GRHAX/8zU3GL/g4R6geQb7RaY4lPhZ7i3F8XaBv
 qxPykne5Jh/T892/9WZJL3BiZHD0P8kn3Np6f1eHnh4FcZCi5zQyOQkWsbgZcJQ+lf8R
 WyC5A0QAMnBKbDKeoDe3rl8n1tPXJP/7XKDMMBRAfDfsmNyJC0l2m/NgG+g9lbiUlyvn
 uoaxZNyzwpSxZcvsfM/GIG3S9phQEnzy3EcPCqQXNT+rZj0n3v3EpESCPqftECR4tXJy
 Rk3wDo5TpicFBjejJIYuXkPinqI6VsCEEVs1+B2UpZ+O1VlduuFqHUXdRZvJpxxXLVZJ
 YWnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777062034; x=1777666834; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IJ6fNzuSCvCYkRa4+sIxpzodEgpF6VksrxgpZsibvcU=;
 b=j73KxeFZnm3KJhOSmtqrwM0vABaUTWJ4yGk6+QV+feXeAT2I6caKhLkGGC7Z97ybt+
 wSwLSolyHStGiKOZQRYqRp1beCWSct85jVA98sjWoWv9hC9vYFwl8jOdBUbxFlOMq7PA
 zTA85YYdchgO43fzmqHIP7e84BhxGHC+wyMDGfFDbUCEtKAfnDDZ+qentBgXV6pr2/ex
 Qs9Ky+1F7l+Iw6BuCcY0z/8tmJ9rESTc+8LJKWmkydFZIJoL0nZ1mhxvMjq3RS6lU1d4
 ugZ7uzyjXYvzeSLRGvoBdQw3YtebKsUPsiQDWR7K0OY5e14nEk8D5pSF91Eb/QxcfuEG
 e64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777062034; x=1777666834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ6fNzuSCvCYkRa4+sIxpzodEgpF6VksrxgpZsibvcU=;
 b=Tgm60AVOuUlzAoMx+iesFJdXqOGhCvq5Uqy1eX3/L77gCf9BIiEu6RrC5CdjUn0lE/
 cNbVuFmx4WUv+gr0qYx8HcRFouj9cE7ZokaV5FPq+iXLjgapZjQvjRBJnK5CeyXg5kGw
 1gyDqafRSBnIPgb6b9vbvZy6j6EfqZMQbfN6Ur+MP4uiU2JPxDAoiVQyjentGmtO5kXn
 CHx76XH2m4Nb8oY6MJ62jL6FpBSKtmiNQFsPa+V6tCh+4jJJtbw1Idwa2b4SqgPIL/k2
 zkDhLxXYPtaBaMzU8ucaex/RrDL+UGtKXBpWrFDIX+NsuYG5UscU5q6c+VN3DxFfesJl
 PJ5Q==
X-Gm-Message-State: AOJu0YwR2poxGCT/2sdsLoa9HFa0ieZ7ox0AoYQktBcI/Q9g7iBS5eJb
 ltZaXDHx7rLbEwmqWirpbE0kFmV2aPOAsHi30ZhonVxfBPhKiM9XmHtL8m4jcICn55OErFgrjuN
 vYVBWgBajmRZe5F8dn3w8nPvlb/shQHHn50Tw078FUw==
X-Gm-Gg: AeBDieuQSPKS5BvKPoLuae0OhGcVGQBWMQGRAD0shc40EbAiyKKfNGH7rnrpPNY/SeN
 dXc8Gc5RvbW5wsktG9j/FB84O7Ho3IyJQF/nSQMBPIUXWohtvpWthUwMH8bcsIpBXvaTfIJoWrw
 kFOnzlTBDNx8vuVJJVNaVwwRaOFNJUN9siITJo/1XT+Npt31jRXpJmF0Xdjk7QUAYXtif+qzCkE
 Ua4r3b3koxFLASjeIQAVWDGYWucRetIeMRArNvQ7oZLjVSEa9DFkOLyuQaJbZx96yvczbClTI86
 q0KUlcAMIdrSwyGnQBt9EP1Poz+9Kz2B5xn6Vrem5QbO01SdviRapiwV+5OE
X-Received: by 2002:a05:6000:40dd:b0:43c:f5a0:4e56 with SMTP id
 ffacd0b85a97d-43fe3e1f3f9mr49975133f8f.42.1777062033882; Fri, 24 Apr 2026
 13:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
 <20260424194451.1439316-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260424194451.1439316-2-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 24 Apr 2026 23:20:21 +0300
X-Gm-Features: AQROBzDx9zazeQ-vR7uUp2dUQTY5VzZ5rPe2w-ql3bVy6W3Npdzr8zhpvsp4Prw
Message-ID: <CAAjaMXbr3RdOpBHHAYw+neYiTGVwy3D15DZL+zeoUi_q1EUtdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] contrib/plugins/uftrace_symbols.py: fix symbols
 reading
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000046101506503a7f96"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000046101506503a7f96
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Apr 2026, 22:45 Pierrick Bouvier, <
pierrick.bouvier@oss.qualcomm.com> wrote:

> When running this on hexagon binary, we observe some undefined symbols
> without any address or size.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


 contrib/plugins/uftrace_symbols.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/plugins/uftrace_symbols.py
> b/contrib/plugins/uftrace_symbols.py
> index 02d1221228c..6eb999bca5f 100755
> --- a/contrib/plugins/uftrace_symbols.py
> +++ b/contrib/plugins/uftrace_symbols.py
> @@ -36,8 +36,8 @@ def get_symbols(elf_file):
>      out = out.strip().split('\n')
>      for line in out:
>          info = line.split(' ')
> -        if len(info) == 3:
> -            # missing size information
> +        if len(info) != 4:
> +            # missing size/address information
>              continue
>          addr, size, type, name = info
>          # add only symbols from .text section
> --
> 2.43.0
>
>

--00000000000046101506503a7f96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 24 Apr 2026, 22:45 Pierr=
ick Bouvier, &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierr=
ick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">When running this on hexagon binary, we observe=
 some undefined symbols<br>
without any address or size.<br>
<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.=
qualcomm.com" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@oss.qua=
lcomm.com</a>&gt;<br>
---<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianak=
is@linaro.org">manos.pitsidianakis@linaro.org</a>&gt;</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
=C2=A0contrib/plugins/uftrace_symbols.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_s=
ymbols.py<br>
index 02d1221228c..6eb999bca5f 100755<br>
--- a/contrib/plugins/uftrace_symbols.py<br>
+++ b/contrib/plugins/uftrace_symbols.py<br>
@@ -36,8 +36,8 @@ def get_symbols(elf_file):<br>
=C2=A0 =C2=A0 =C2=A0out =3D out.strip().split(&#39;\n&#39;)<br>
=C2=A0 =C2=A0 =C2=A0for line in out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D line.split(&#39; &#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(info) =3D=3D 3:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # missing size information<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(info) !=3D 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # missing size/address informati=
on<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr, size, type, name =3D info<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# add only symbols from .text section<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>

--00000000000046101506503a7f96--

