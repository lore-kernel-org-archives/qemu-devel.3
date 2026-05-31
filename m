Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3250CD6E51
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXUj-0005c5-Tg; Sun, 31 May 2026 00:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXUg-0005bi-Ez
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:09:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXUc-0005dD-VP
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:09:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so2594055ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780200579; cv=none;
 d=google.com; s=arc-20240605;
 b=HEcgZqRePT8jEiuVq/kvCntC1g56a4YxCKprc5L/X2ZTa1e1tALFBv/ctyML7qZfuh
 7Ejsy5xk3Q6Do7iaCMJG/LBS6fqCFFIy2HAWQO+fk2rKA/Twt24zZvhwjZbrWCS53r16
 I/vInrxSzz3Sbg/kYX8+fJPxApAHAneGm4X0c1Iz/EXmXsdyH1T9HP/CQKmHk1XNdAAt
 4peVS1anPLeCEKOv0oNno8Tmdt6I+kSkPIrioT0QF/S7ozH0g817iCnWO2gEu/yBb4g6
 OguG6P+mX2WKGc7cUXSmg14ViE6ZfLS+EO6Mlp3Kf/zMjEo0nSN/lzRlpySBRIJCyoDz
 n5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m+X9UzW+ndttKFN0RYwOuRaV+k7+o2uUhzwiq3qR8qg=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=MunHf5I2OhMM3Q/TPYAOSrcJECCQSKO6wb+bLHzNN1Y1Dq1Jxi8VQ3XdEzYsgv9I/9
 POlwsVgqdf/Oz1zP/zIQIJohT7oSMK9luFvyXjhZv1DqsNlQl8gkYaAhYhTye3hF9eVs
 jiz6roKlN1Me0GZyZ1tCrdnQBkGAnBKQQWsupn4EEPrYb+CJEWkc3MuVYe3aRIMjf+Um
 b9Lv9VqlAEg/eZTOtbp+d+j7opKhRo17VtT6J4ddOZiZYht9zAceZUWR8va6TksEAtZ2
 qCpY40nlKGshnl3jZy22vrarF1AnK7SSvRqPl7YrHGKhD23KQc8EgV+W5kLOXt3dNJVf
 Ow9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780200579; x=1780805379;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m+X9UzW+ndttKFN0RYwOuRaV+k7+o2uUhzwiq3qR8qg=;
 b=PNq56C19xG1qgCIG4PHOQdQBTulwZZoF5w3+RdKt6YnFzt91WxndjgDVWBLAo6WV8J
 KIqNUyghI0sRjt5NcU8kYkohG5iUFi7Jiaa65uFYupcp5Gi+tnHHSjRuLqIRu15K66IQ
 7z8KPPQug+Hp/yt+qZJ2Cct2Ji5gPAauFJ6xbM8/14ruv8+5H2NxRPcnJYAS+SB3PLJy
 hM3QJjixRg/CfEzBQwSPCIYuik0Qt+hCkFkEf7sJnfiJad8mX8beZkXG+kb5PJXdkyyO
 smZGX4nx2hBUE97ichcshx/0LeWY0tScTXg5OQiuVo7FQ0TzldiF+6m2qEVLkSZvb4Sz
 c2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780200579; x=1780805379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+X9UzW+ndttKFN0RYwOuRaV+k7+o2uUhzwiq3qR8qg=;
 b=IHOutgLhmHvQTJnuZA8lBsBZiFzDxIJwg47P77m5WWzyor3eXzJ1Vt7D+xJVRGqRY0
 ft3zr+iTcIP9dxeGLj13HcEWC9Mi6Hqn7gztoF0HfoJCKYVSMzqGOwlVzMbfpE8duljM
 s9tUTbNx+8rrhzoJSE+tmQScibJuEunNK5IgYxm8pPT+2cqAOjhnzNJy4SATXu65SLhv
 Euf7N9inkAafjAMnGOXHcPkHBzXgnAXrrL0m9vOoyLdmOeu/98yFrwY3VYAx4gsV+srd
 9si06KHHqSmaTE889sl3QJLYyIU6byrrEi6k6f4vuD/37yUHl4ezb9irptbT88KM6QYM
 Cp5A==
X-Gm-Message-State: AOJu0Yyuwc392jpHf7eq6KaX+1fFtYuPEjPygPJtREnWpnKpSJBcSIF/
 vYCUSEO7VoAirGWCdLFo0EeZQu+Rif29IdARNClIP19EASfoSjNT0GuzdLMuAkhmo4RFI7+GwV2
 UaFfLRv0YmfcOyX+KkTEhDxHYdRe+o+pqbXN5mnWhKg==
X-Gm-Gg: Acq92OG53a6E2P7pZsIX+wFojCcCFT6l56N/RdMsKplci26LMREgIXZAtmNEUMCq7hN
 3iIfC+u8eGw58upr/L+IAspbyQNXHxZq82uodABucyS+ghNtYGG8Tir6Qz3P1IoRbQspm1IxWwS
 6uBJaL8EASXNut4iGhsH8bRSMPgqqj/RyNKtZG7I+LaWLi4OZF/QOej38KUVD4DgylCoHYqKrVs
 CMefjT73oc0/6he3SxxDaSTqWRz9OBctTpTyHKRpgQkXg97kEXMU94iDAJ0NN2M4NqMmZI4FGwt
 TRpBvrV3zmuABHbjj4MAaXvTmJ7Igfytq/Ly0mgMSELGdvI=
X-Received: by 2002:a17:903:19ee:b0:2c0:d29b:3502 with SMTP id
 d9443c01a7336-2c0d29b3a6cmr745315ad.38.1780200579478; Sat, 30 May 2026
 21:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-8-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-8-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:09:27 -0600
X-Gm-Features: AVHnY4IoQGQV50R9omLS0b_EcrLxe1Nms1pca-1P8Fec18UaoDGEJKPSEC6gUHY
Message-ID: <CANCZdfrEDhzu7Qnh48Vek2hitc-NDXAUNmx5Em+cdiZSYcFW=g@mail.gmail.com>
Subject: Re: [PATCH 07/13] common-user: Initialize mmap_min_addr for FreeBSD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="0000000000002b42900653153fae"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
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

--0000000000002b42900653153fae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Use sysctl to fetch the vm layout of the current process.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  common-user/mmap-min-addr.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

I hardcoded my version to qemu_real_host_page_size(), but this is better
than what I'd done. It keeps it from being 0, and the FreeBSD kernel won't
map anything between this value and info.kvm_min_user_addr. I do know
that x86 and aarch64 these are two are the same value, and those are the
only hosts I care about at the moment (until I get through the upstreaming
backlog).


> diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c
> index b2b3762386..830c6f66a0 100644
> --- a/common-user/mmap-min-addr.c
> +++ b/common-user/mmap-min-addr.c
> @@ -5,6 +5,10 @@
>
>  #include "qemu/osdep.h"
>  #include "user/mmap-min-addr.h"
> +#ifdef __FreeBSD__
> +#include <sys/sysctl.h>
> +#include <sys/user.h>
> +#endif
>
>  uintptr_t mmap_min_addr;
>
> @@ -31,6 +35,15 @@ static void __attribute__((constructor)) init(void)
>          fclose(fp);
>      }
>      mmap_min_addr =3D min_addr;
> +#elif defined(__FreeBSD__)
> +    int mib[] =3D { CTL_KERN, KERN_PROC, KERN_PROC_VM_LAYOUT, getpid() }=
;
> +    struct kinfo_vm_layout info;
> +    size_t info_len =3D sizeof(info);
> +
> +    mmap_min_addr =3D
> +        (sysctl(mib, ARRAY_SIZE(mib), &info, &info_len, NULL, 0) < 0
> +         ? qemu_real_host_page_size()
> +         : info.kvm_min_user_addr);
>  #else
>  # error
>  #endif
> --
> 2.43.0
>
>

--0000000000002b42900653153fae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Use sysctl to fetch the vm =
layout of the current process.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0common-user/mmap-min-addr.c | 13 +++++++++++++<br>
=C2=A01 file changed, 13 insertions(+<br></blockquote><div><br></div><div>R=
eviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.co=
m</a>&gt;</div><div><br></div><div>I hardcoded my version to qemu_real_host=
_page_size(), but this is better</div><div>than what=C2=A0I&#39;d done. It =
keeps it from being 0, and the FreeBSD kernel won&#39;t</div><div>map anyth=
ing between this value and info.kvm_min_user_addr. I do know</div><div>that=
 x86 and aarch64 these are two are the same value, and those are the</div><=
div>only hosts I care about at the moment (until I get through the upstream=
ing</div><div>backlog).</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c<br>
index b2b3762386..830c6f66a0 100644<br>
--- a/common-user/mmap-min-addr.c<br>
+++ b/common-user/mmap-min-addr.c<br>
@@ -5,6 +5,10 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;user/mmap-min-addr.h&quot;<br>
+#ifdef __FreeBSD__<br>
+#include &lt;sys/sysctl.h&gt;<br>
+#include &lt;sys/user.h&gt;<br>
+#endif<br>
<br>
=C2=A0uintptr_t mmap_min_addr;<br>
<br>
@@ -31,6 +35,15 @@ static void __attribute__((constructor)) init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0mmap_min_addr =3D min_addr;<br>
+#elif defined(__FreeBSD__)<br>
+=C2=A0 =C2=A0 int mib[] =3D { CTL_KERN, KERN_PROC, KERN_PROC_VM_LAYOUT, ge=
tpid() };<br>
+=C2=A0 =C2=A0 struct kinfo_vm_layout info;<br>
+=C2=A0 =C2=A0 size_t info_len =3D sizeof(info);<br>
+<br>
+=C2=A0 =C2=A0 mmap_min_addr =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (sysctl(mib, ARRAY_SIZE(mib), &amp;info, &amp;=
info_len, NULL, 0) &lt; 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? qemu_real_host_page_size()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: info.kvm_min_user_addr);<br>
=C2=A0#else<br>
=C2=A0# error<br>
=C2=A0#endif<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000002b42900653153fae--

