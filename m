Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DF1CDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZKx-0002BC-Vg; Wed, 24 Jun 2026 21:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wcZKv-0002Av-N3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:57:02 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wcZKt-0001zo-Ua
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:57:01 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-139b5e604b9so2014354c88.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782352618; cv=none;
 d=google.com; s=arc-20260327;
 b=VqcBV6O+M/eHajmYEGmm9aoM8IvkZ48XMPZPh14ocEi1/uTV/fX/FUTFyagNXCHOao
 WGOWUEf0Quy0buVroavV7tSIq+xnsXtx1xsu61obaoNQWFRQ0Q2yAX/6dfNJ+LHRBwBM
 3ypX9F+og8V5BR0yzLmrl7AGZQ/3yn1qahLiThkuuH5oXqfhqUySPMok+OdGbHGWDbmq
 iM+t4dOt2bUmidETCyTJBk7e0/Xkm1BsQQaSQnxQyetf3t6CvhrZp1taUxGyG+z67x31
 cX8WeRBMx0smmMr91Xob8xNVFZBAFJHobxtPzjYmlqfWlYOSvS2OaVkN5Ws2ip1OsMsy
 8STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/KB+qLlXn1GslR4NMS+f31JvlgPP6/7Kylq6LSioabo=;
 fh=823Hw6oV7htarHWd/UhMdsGREkWUx6l/vn/cwWB6wXg=;
 b=rfI0MtPFOYx23CYqz46TNyW/4HiIizQ8pVuuTcYo6eccJaAQnVLEG7hgjD1ua4t9hL
 L5GgbK5whkvQdojrOzf9GQT+g+Pc7mgym0DtCiPFG1Yx6QzA+McGBC96On0hdJ0m0WI/
 Tyho2/YS0KznglWcabXrX6pmTGuxfXwwUmzdf6BjUMd0kY25LUpmETCfC/xkT+Khx4Nn
 0/0NGd4mUnoVY67gN5AhrOrgTOrytUDWs9ufGNOmg9me9beD0tS0Rb/rHOnBIXr6Ptlk
 f9KrXwflcD/ooEwqtLgnAEq/anSP7TDSqkZCcvXM5lCHOACAzerX0KTStjUQSus20OaV
 yP3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782352618; x=1782957418; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/KB+qLlXn1GslR4NMS+f31JvlgPP6/7Kylq6LSioabo=;
 b=OtUSpJ2dahqZMXaaMnNYF/9lx7EDvLuT7tDbduAFqdkMoQc4wBt/nGPSwYmGUIVxKb
 Ktp4JLEHAuB6Ditl1mIeNFLkp3m1qlsiD9aeNIHLgVcSnPTa/rmui7l8xU575PqGgiUw
 ss18ohTVG3jXmF2DzsNuwyeE/Bo/qY5Nox+oahCTAW7c7KiHwXQSxvTRacefgE5my0cd
 tdj/XqaB2JlZ8mtrMsB8rt2mc1w6pzUiI+Cc1If4GfqZYxO0I0x2Q5I59e8qT8FMMM0E
 W9L8DoHQKS8Z2KrYgsBQKGMPeNi2+AdnkrdRjRtVjlRNoxTLW8ofeAe+uDLylXwQaRUC
 Nt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352618; x=1782957418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KB+qLlXn1GslR4NMS+f31JvlgPP6/7Kylq6LSioabo=;
 b=XpqSdmee+UK5Bp2pZhhqDn9h2PNTYKa4+HLdH6tFzKLZgfdBwWhXqMSBDzNT4ZJeiE
 +cXBMkaJzGDZ4lgBuqqKFvfyb3S+g7I3lEkY2hLTLZcCNe5MUGKswlqXromy+Y/eOEsY
 JCFz3Ut0QsK6Czlsm6ZKIAFfXHVyFDkCpp3M1FGFlQc7gSQUKT/Fv+MMimEOsr2DaZQl
 f3yS/K3lAiW96EEXgeAB7s6w770tVUpLuWZrCG1WCmxhaSp1HXcpJLQqKPiCyuoq7Jxg
 2aoE010zTgrOIXMBW9ibHvHQNv56eAaRBx9vtj5cvqMUbXDjZH5GW7Er1zM7fGRVRdi2
 by2g==
X-Gm-Message-State: AOJu0YxjZUDDA4K91rLNfyuq/YsalEdodp/cVhlX3hzHgdQILrvAX9V7
 K6BMeJ6BdecGC+Xu2yMWbpMglQEgnJpJqd6owvGhzxW+RfA9MkOEiij0SBGDhHz1OILuoQ8ZtJ0
 NXdTPOf3GAjpcwPRgquQW243S08q4i0FsORE7
X-Gm-Gg: AfdE7clesFWL5IpJ8W6kyVUpbIx9luJ6fP5dwX4yT+gkqFXWC0xAgGxcqtz8blGKbGF
 PMYu10DgE+RtFR1DZrTxEnLKn7LA+o8q7ySfc8OADUkrz543FkxBDNWsWeNYATSNYkef6PuDLt9
 bAOedl2PXwj1alxbtU7LR1C58CwkzUTyiDWRnHOOKyX8K/IJyBvn4HrewbhKsHSdEUU1r9dkAra
 08hkhWlYE9JOGZn6koL5fUcZLwde0nD9dzoAZVJK1Kg45xrUPT4rFPI4KLJfkXYbTXdeRdfG2rk
 Lbf79jd6pkaji+e39y9JjD9t8Ks=
X-Received: by 2002:a05:7022:318:b0:137:f875:c1e8 with SMTP id
 a92af1059eb24-139dbac326bmr445595c88.19.1782352617788; Wed, 24 Jun 2026
 18:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
 <53dcdeeb-997c-4ab1-a17a-2a28b507790b@oss.qualcomm.com>
In-Reply-To: <53dcdeeb-997c-4ab1-a17a-2a28b507790b@oss.qualcomm.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 25 Jun 2026 10:56:45 +0900
X-Gm-Features: AVVi8Cfwsg5E9vfJAO2In-O3H4sTfrgX5xI0yFZvzQN-Vn-mBEpgQ4FPcL5u7aI
Message-ID: <CAEDrbUYxvHr8dOdFNBLxOt+czrQZ-wzTgNsxHi9=3WynSo+SLg@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
To: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, stefanha@gmail.com
Content-Type: multipart/alternative; boundary="000000000000a5d8e506550a4e77"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1229.google.com
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

--000000000000a5d8e506550a4e77
Content-Type: text/plain; charset="UTF-8"

> The hexagon idef-parser requires flex and bison as host build
> tools.  Add them to the emsdk-wasm64-cross container image so that
> wasm64 builds including hexagon-softmmu can find them.
>
> Link:
https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index 8a924816f92..5debbc77d08 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -19,7 +19,9 @@ ENV CXXFLAGS="$CFLAGS"
>  ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
>  RUN apt-get update && apt-get install -y \
>      autoconf \
> +    bison \
>      build-essential \
> +    flex \
>      libglib2.0-dev \
>      libtool \
>      pkgconf \

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--000000000000a5d8e506550a4e77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; The hexagon idef-parser requires fle=
x and bison as host build<br>&gt; tools.=C2=A0 Add them to the emsdk-wasm64=
-cross container image so that<br>&gt; wasm64 builds including hexagon-soft=
mmu can find them.<br>&gt; <br>&gt; Link: <a href=3D"https://lore.kernel.or=
g/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=3Dz3w@mail.gma=
il.com/">https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKi=
bQfD4Mk-44-RQo0k=3Dz3w@mail.gmail.com/</a><br>&gt; Signed-off-by: Brian Cai=
n &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcom=
m.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0tests/docker/dockerfiles/emsdk-wasm=
64-cross.docker | 2 ++<br>&gt; =C2=A01 file changed, 2 insertions(+)<br>&gt=
; <br>&gt; diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker =
b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker<br>&gt; index 8a924816=
f92..5debbc77d08 100644<br>&gt; --- a/tests/docker/dockerfiles/emsdk-wasm64=
-cross.docker<br>&gt; +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.doc=
ker<br>&gt; @@ -19,7 +19,9 @@ ENV CXXFLAGS=3D&quot;$CFLAGS&quot;<br>&gt; =
=C2=A0ENV LDFLAGS=3D&quot;-sWASM_BIGINT -sASYNCIFY=3D1 -L$TARGET/lib&quot;<=
br>&gt; =C2=A0RUN apt-get update &amp;&amp; apt-get install -y \<br>&gt; =
=C2=A0 =C2=A0 =C2=A0autoconf \<br>&gt; + =C2=A0 =C2=A0bison \<br>&gt; =C2=
=A0 =C2=A0 =C2=A0build-essential \<br>&gt; + =C2=A0 =C2=A0flex \<br>&gt; =
=C2=A0 =C2=A0 =C2=A0libglib2.0-dev \<br>&gt; =C2=A0 =C2=A0 =C2=A0libtool \<=
br>&gt; =C2=A0 =C2=A0 =C2=A0pkgconf \<br><br>Reviewed-by: Kohei Tokunaga &l=
t;<a href=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&=
gt;</div></div>

--000000000000a5d8e506550a4e77--

