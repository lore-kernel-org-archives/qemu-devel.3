Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344EFCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUg3w-0001RJ-UA; Wed, 03 Jun 2026 03:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1wUg3i-0001PB-2s
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:30:39 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1wUg3g-00012V-AZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:30:37 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6607048fa62so3347110d50.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 00:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780471835; cv=none;
 d=google.com; s=arc-20240605;
 b=Tl7URxwdwnQA/YIDiXQdlDQdZtOxCahoYFSB/uZ8uVF9wMnJM63GjEd9xBIsN958mt
 EllgRQN++zZdCcCN+iVNJRL4yEtyMyyqiHOmwEn1u8N1AncYlEtXjGSiFduUxfGC5quy
 0rONXcFqQI8enuOjQXYQl/xPtsjo6HiRktAnzohyx8ywqf4k2gTZz+ZbyZK8n4W3wJzs
 MzG3IpTXHrdEBlzbCpWwz6pQg0/fMBumK31F2715Sk9nDIR6RsfY1D2jgJfYMkD5pD9N
 aafJHZVk+2XNWmVp0ORhe4/XzUqvb6jKFgpuRm0bnwGfY4nF9LZwLCcVqqRBtCUdIUvZ
 BWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LjazypgeQLq3yHGTdpZl3axpvIb/t81rsyb+MITFR+Y=;
 fh=nZdtq5wRx4Il7hQNfRts2f1Z8kKZch3QoOWuKTX1WPQ=;
 b=iIjjdwcILQ2V20O88us+pwPJPM4WZPpFFeXKAYNodw46L0hKxLzeLdWlH2PA1Hybmh
 bx/aygsLXW3QQbZ68RJWA4sUKWeJqtR41vE0xdIYk3gktfUGlumE4CwzCh/8E2pzP1W+
 Bx506UmGEoXMuAoZjd1SocjaiukmPtmGeOTcg+vtd2qVCc5LMGqFnViXx6pdeyectoXL
 oyz0+sCAuLwTfQ+cPmkGxQdwa0i3QGDOkIFc8HmV1rssIMHrOoGdXOiT1zhaogBtVZKx
 KN0SPLFb3ohIWwufihQnxiV3alZcEMXBtCjUHarUjT5q1iqSsQ/Rp7VsPOvhvKsqFlyU
 exIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780471835; x=1781076635; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LjazypgeQLq3yHGTdpZl3axpvIb/t81rsyb+MITFR+Y=;
 b=eTd3Oun/0wdTFu3KfxrJ22/KDH2E03v/RAlwGBfnAEvQG3lo65X/MtI7H0dg9wSEuB
 qkzRpD4I+oH+SL4UKHUrIyI6YG65mIwMDmctiEwrzU/1NR8yiC/hNGsyzvITxioT0euB
 T2QEF1KrpZw9sMpYAi7STD2vMVaRyn0qOAmKlCSgDL84mkv/9hJ8gK7uE1257ys/6e7V
 1DFDRxwp26mKgabjkGoj0oMcFCMrF7zgDIFtzMQn0GNqrSZ9MB4ajClKr88nvOMPobKX
 dyQXLmkzGkp95KlpKvXwhy8zMRLP87cIQwwkVGBgjhVRLlx+jpIwEkR+mzwVqwsOx2k3
 otWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780471835; x=1781076635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjazypgeQLq3yHGTdpZl3axpvIb/t81rsyb+MITFR+Y=;
 b=J/SynG8toDHULb+0JmfkcFUzv3kmwdK8kwTqVfskib+oNkNgkTR/3ZT38qPHJfyu8X
 VX1n6vkMHbB4Ug1y1UqQojjiq37UcyJi86uGpKscOU2OFARQ+IDd0BCcXx5odu2zdfK+
 y3T2CxYldFXkmxHDnm2+ghFT/dlyzQSzbaaMnzhh4Yw45If9hCOfABoKvO1oUPgRiFUp
 zu8qnqaMGXueK7GlcSKuh063JQW6ak/GEugMStLRg6A+9NTqiLI/aADal2roxjzPYFyz
 w6ODmL7ql5eyU3RxE24ZkyY7iwRnjGFm6mgG9LAX6y5jfWz0RWxSRz/MpVlidWvCXXIa
 76hw==
X-Gm-Message-State: AOJu0Ywo3fttkZFjCQgWZWDTN+MnH7L9Y+ionE1eGV4qAAdLWqtdh9Vy
 lWURnKxZQkX04os+5HU6gN7eZwYP+pr7NoExDgOEwP49j0MmEr1c0jyUMQaCko1ntrv0jDCQDsm
 IQeYYVIE71W5pHBYprwvvxiQQuBN6/Xo=
X-Gm-Gg: Acq92OHtn1TPmRKBO7TAVDFH10mS0BRj/Nux2spwsi/6FlDbaEttdXDMfuD8pzktaX7
 TTILdnBQ/+Lpm4RQdiCKTXhvsfCPl4KZysVrGPWj/fdZBxDxQ+V/GYPoodb3C1uJ/RXpI4iDSal
 0WpJCis+SbE0R44bNU3F3KjB2QoOReG+cLgj5DWjWxyt9b6vsoOTDzP6dXgxGLUQQ6i2pAM0hlC
 IqNgPKp2hlAX7VrLIMO8WbN98IhFWffGN7em9Bcw3s03vsx9qNSoC1CkeDHGMSJtOpo9l/PKGT1
 bErGcVTn+R5MWOLR30IXaV5xIgfZRVvJOGizyTsagd+hJ64e
X-Received: by 2002:a05:690e:b83:b0:660:ea2f:61e with SMTP id
 956f58d0204a3-660ea2f085amr41639d50.6.1780471834772; Wed, 03 Jun 2026
 00:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-13-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-13-armbru@redhat.com>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Wed, 3 Jun 2026 09:30:25 +0200
X-Gm-Features: AVHnY4K-cwk-Y6XYRnjIIYf3ZNxVkU3GsKcseZnk2SQx3ZohR1SCvE_VbUrnngM
Message-ID: <CABtshVSpdP4jvNi0wey8t5b9piBoFUsTw4GfwsiM3Vppbbxfvg@mail.gmail.com>
Subject: Re: [PATCH v2 12/38] MAINTAINERS: Fix F: in "Allwinner-a10"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003e871406535467f8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003e871406535467f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>


On Wed, Jun 3, 2026, 8:40=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> We neglected to update MAINTAINERS when we renamed axp209.c to
> axp22x.c.  Update it now.
>
> Fixes: a954543092 (hw/misc: Rename axp209 to axp22x and add support AXP22=
1
> PMU, 2023-06-06)
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c80c868526..b1dcd3a596 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -727,7 +727,7 @@ F: hw/ide/ahci-allwinner.c
>  F: include/hw/*/allwinner*
>  F: hw/arm/cubieboard.c
>  F: docs/system/arm/cubieboard.rst
> -F: hw/misc/axp209.c
> +F: hw/misc/axp2xx.c
>  F: tests/functional/arm/test_cubieboard.py
>
>  Allwinner-h3
> --
> 2.54.0
>
>

--0000000000003e871406535467f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Thanks!<div dir=3D"auto"><br></div><div dir=3D"auto"=
>Reviewed-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.jankovic=
@gmail.com">strahinja.p.jankovic@gmail.com</a>&gt;</div><br><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, 2026,=
 8:40=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">We neglected to update MAINTAINERS when=
 we renamed axp209.c to<br>
axp22x.c.=C2=A0 Update it now.<br>
<br>
Fixes: a954543092 (hw/misc: Rename axp209 to axp22x and add support AXP221 =
PMU, 2023-06-06)<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" rel=3D"no=
referrer noreferrer" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
Cc: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.jankovic@gmail.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">strahinja.p.jankovic@gmai=
l.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-arm@nongnu.org" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">qemu-arm@nongnu.org</a><br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" r=
el=3D"noreferrer noreferrer" target=3D"_blank">armbru@redhat.com</a>&gt;<br=
>
---<br>
=C2=A0MAINTAINERS | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index c80c868526..b1dcd3a596 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -727,7 +727,7 @@ F: hw/ide/ahci-allwinner.c<br>
=C2=A0F: include/hw/*/allwinner*<br>
=C2=A0F: hw/arm/cubieboard.c<br>
=C2=A0F: docs/system/arm/cubieboard.rst<br>
-F: hw/misc/axp209.c<br>
+F: hw/misc/axp2xx.c<br>
=C2=A0F: tests/functional/arm/test_cubieboard.py<br>
<br>
=C2=A0Allwinner-h3<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div>
</div></div>

--0000000000003e871406535467f8--

