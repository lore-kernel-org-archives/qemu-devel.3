Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E68D4A5FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 05:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcE5-0005Oc-Da; Fri, 16 Jan 2026 00:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vgcE3-0005OO-QN
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:18:23 -0500
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vgcE1-00031g-Ly
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:18:23 -0500
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-123320591a4so1715342c88.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 21:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768540699; x=1769145499; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P4l9aEHLmbUtt5yHPL2qxyxINvUTyjwiJa2fMR+2Qf0=;
 b=nqCLNuIexR5VZqfZL5tu/XaMu+WOxxUZasi+pGT/BhGTzq1dVny2MVSdUJq4Oo0eZg
 pFvaF3U9hXPahTqvze7SSrgH+4huXFw1jwyQS9vcsIVPUjOKgFIoAZDpe8pmZR3RX4TR
 cDlNL35Agulfrckzh268WZWe0X+ZFjUxgqTOyJXW17OJCM0fCNLwKoBCPlRTY7kk7pnR
 a0DLRQpWELMAzLwm88HKEYafq3xLvTcDrSB9tS1O/KPWNsWiGHYyV9UHkMHF0hX2QkCZ
 XWTfJV03PKQRbL0dE4CIwLwy7fw7osP3a845kytSBEJUbRpxfBkOT3LCPU2dBGqjZZKN
 OEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768540699; x=1769145499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4l9aEHLmbUtt5yHPL2qxyxINvUTyjwiJa2fMR+2Qf0=;
 b=ovFdmQVkANV/ZN6P55kIfHJUCBQKPNLxPJKMhETqBJkslCGy69Pf0brXxeWzAnnYfo
 5Yu5gnspqiFA/AIu76cpSGWslL1/zAZrNG42X1G/Rd/i8d/GB03drPPVf0gUmBY9KTT5
 6e/WA708hyXOaEN3Y39hzfzmTW/N9LglRjdMRHSpXgK6sT10pP/obo49lh9MPSGokCxR
 +lt0baUJsXvVvBRsoNaFXF2aX0cgyDrfSEHv/ubsO9e9vO3vd360/1js9fHjsAZigy0u
 o0c9nhorazsX98pd8xc4XtSXOFiswCxP/FXSHoS5uuAji8SXIYsv2HTmcVK4x+te7wuC
 wCfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+awdZZIgDZhsYShQbdzlbiuMihbfdcdrNRe+gC9lK5q/l9kEKITbt3L/pWJnU9kBf5T3DnxuvGms3@nongnu.org
X-Gm-Message-State: AOJu0YzYhQy073JKH1kARqDXsPaE2GmN21Q+5Yb592hpPb/BDaMMIMEz
 mB8BtV41ZQdBc8ulfb0WapmQE6TnSwa65zVlu5iHTx0WxIsEWEyd7/0U5aiKGMGMqiFBpSN88Gw
 8zQDnuGExnkK6PEc2Wm84m9TIwM4xNpc=
X-Gm-Gg: AY/fxX6yUBcx89tHWVtbCyTLrV1DjGh3AwgfKBwzL2jIOlMWAqRT3U4nMeiKtfaKKNP
 nW4HLjxpHrXMj93KbMbv5A4IjGeOibqE1PGX7Bqy8ELmrH0KWBWp4zzqJ4BQh8tc5bT1/LPNsnt
 rppVTktDqsnLU/MpYc61i2of8NO+uSSkVZz1G4LV2Y5/anfg8RK6coW+ZOgKeixReo5UXAjhyYY
 4RXEEHZ6FjCVDiBNtPQT4+ukysqV+MsfbibGEgTZOmH9qChzfI9eqdBxUoeNBwdipKO9okiD1Z5
 pyVT8QX+HOUOxdJM9HSuHInfew==
X-Received: by 2002:a05:7022:e1d:b0:122:2f4:b251 with SMTP id
 a92af1059eb24-1244a734a66mr2627900c88.21.1768540699119; Thu, 15 Jan 2026
 21:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-6-richard.henderson@linaro.org>
In-Reply-To: <20260116033305.51162-6-richard.henderson@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 16 Jan 2026 14:18:06 +0900
X-Gm-Features: AZwV_QhAfryvsryGCOJ5OxFsgDYqpjRW4ASCqLou1XA95gyEAOoG9A4KVtnIJfA
Message-ID: <CAEDrbUakb-SCJBoxJPJJtMW8+1BdCP=mbx1GYXtarj8keRw-yQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/58] gitlab-ci: Drop build-wasm32-32bit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, pierrick.bouvier@linaro.org, thuth@redhat.com, 
 pbonzini@redhat.com, philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000002452fd06487a78f3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x122e.google.com
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

--0000000000002452fd06487a78f3
Content-Type: text/plain; charset="UTF-8"

> Drop the wasm32 build and container jobs.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .gitlab-ci.d/buildtest.yml       | 9 ---------
>  .gitlab-ci.d/container-cross.yml | 7 -------
>  .gitlab-ci.d/containers.yml      | 1 -
>  3 files changed, 17 deletions(-)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index ea0f5bb057..e9b5b05e6e 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -785,15 +785,6 @@ coverity:
>      # Always manual on forks even if $QEMU_CI == "2"
>      - when: manual
>
> -build-wasm32-32bit:
> -  extends: .wasm_build_job_template
> -  timeout: 2h
> -  needs:
> -    - job: wasm32-emsdk-cross-container
> -  variables:
> -    IMAGE: emsdk-wasm32-cross
> -    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug
--enable-tcg-interpreter
> -
>  build-wasm64-64bit:
>    extends: .wasm_build_job_template
>    timeout: 2h
> diff --git a/.gitlab-ci.d/container-cross.yml
b/.gitlab-ci.d/container-cross.yml
> index 7022015e95..6bdd482b80 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -86,13 +86,6 @@ win64-fedora-cross-container:
>    variables:
>      NAME: fedora-win64-cross
>
> -wasm32-emsdk-cross-container:
> -  extends: .container_job_template
> -  variables:
> -    NAME: emsdk-wasm32-cross
> -    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
> -    DOCKERFILE: emsdk-wasm-cross
> -
>  wasm64-emsdk-cross-container:
>    extends: .container_job_template
>    variables:
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index dde9a3f840..9b6d33ac13 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -58,7 +58,6 @@ weekly-container-builds:
>      - tricore-debian-cross-container
>      - xtensa-debian-cross-container
>      - win64-fedora-cross-container
> -    - wasm32-emsdk-cross-container
>      - wasm64-emsdk-cross-container
>      # containers
>      - amd64-alpine-container

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--0000000000002452fd06487a78f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; Drop the wasm32 build and container =
jobs.<br>&gt; <br>&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>&g=
t; ---<br>&gt; =C2=A0.gitlab-ci.d/buildtest.yml =C2=A0 =C2=A0 =C2=A0 | 9 --=
-------<br>&gt; =C2=A0.gitlab-ci.d/container-cross.yml | 7 -------<br>&gt; =
=C2=A0.gitlab-ci.d/containers.yml =C2=A0 =C2=A0 =C2=A0| 1 -<br>&gt; =C2=A03=
 files changed, 17 deletions(-)<br>&gt; <br>&gt; diff --git a/.gitlab-ci.d/=
buildtest.yml b/.gitlab-ci.d/buildtest.yml<br>&gt; index ea0f5bb057..e9b5b0=
5e6e 100644<br>&gt; --- a/.gitlab-ci.d/buildtest.yml<br>&gt; +++ b/.gitlab-=
ci.d/buildtest.yml<br>&gt; @@ -785,15 +785,6 @@ coverity:<br>&gt; =C2=A0 =
=C2=A0 =C2=A0# Always manual on forks even if $QEMU_CI =3D=3D &quot;2&quot;=
<br>&gt; =C2=A0 =C2=A0 =C2=A0- when: manual<br>&gt; <br>&gt; -build-wasm32-=
32bit:<br>&gt; - =C2=A0extends: .wasm_build_job_template<br>&gt; - =C2=A0ti=
meout: 2h<br>&gt; - =C2=A0needs:<br>&gt; - =C2=A0 =C2=A0- job: wasm32-emsdk=
-cross-container<br>&gt; - =C2=A0variables:<br>&gt; - =C2=A0 =C2=A0IMAGE: e=
msdk-wasm32-cross<br>&gt; - =C2=A0 =C2=A0CONFIGURE_ARGS: --static --cpu=3Dw=
asm32 --disable-tools --enable-debug --enable-tcg-interpreter<br>&gt; -<br>=
&gt; =C2=A0build-wasm64-64bit:<br>&gt; =C2=A0 =C2=A0extends: .wasm_build_jo=
b_template<br>&gt; =C2=A0 =C2=A0timeout: 2h<br>&gt; diff --git a/.gitlab-ci=
.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml<br>&gt; index 702=
2015e95..6bdd482b80 100644<br>&gt; --- a/.gitlab-ci.d/container-cross.yml<b=
r>&gt; +++ b/.gitlab-ci.d/container-cross.yml<br>&gt; @@ -86,13 +86,6 @@ wi=
n64-fedora-cross-container:<br>&gt; =C2=A0 =C2=A0variables:<br>&gt; =C2=A0 =
=C2=A0 =C2=A0NAME: fedora-win64-cross<br>&gt; <br>&gt; -wasm32-emsdk-cross-=
container:<br>&gt; - =C2=A0extends: .container_job_template<br>&gt; - =C2=
=A0variables:<br>&gt; - =C2=A0 =C2=A0NAME: emsdk-wasm32-cross<br>&gt; - =C2=
=A0 =C2=A0BUILD_ARGS: --build-arg TARGET_CPU=3Dwasm32<br>&gt; - =C2=A0 =C2=
=A0DOCKERFILE: emsdk-wasm-cross<br>&gt; -<br>&gt; =C2=A0wasm64-emsdk-cross-=
container:<br>&gt; =C2=A0 =C2=A0extends: .container_job_template<br>&gt; =
=C2=A0 =C2=A0variables:<br>&gt; diff --git a/.gitlab-ci.d/containers.yml b/=
.gitlab-ci.d/containers.yml<br>&gt; index dde9a3f840..9b6d33ac13 100644<br>=
&gt; --- a/.gitlab-ci.d/containers.yml<br>&gt; +++ b/.gitlab-ci.d/container=
s.yml<br>&gt; @@ -58,7 +58,6 @@ weekly-container-builds:<br>&gt; =C2=A0 =C2=
=A0 =C2=A0- tricore-debian-cross-container<br>&gt; =C2=A0 =C2=A0 =C2=A0- xt=
ensa-debian-cross-container<br>&gt; =C2=A0 =C2=A0 =C2=A0- win64-fedora-cros=
s-container<br>&gt; - =C2=A0 =C2=A0- wasm32-emsdk-cross-container<br>&gt; =
=C2=A0 =C2=A0 =C2=A0- wasm64-emsdk-cross-container<br>&gt; =C2=A0 =C2=A0 =
=C2=A0# containers<br>&gt; =C2=A0 =C2=A0 =C2=A0- amd64-alpine-container<br>=
<br>Reviewed-by: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.=
com">ktokunaga.mail@gmail.com</a>&gt;</div></div>

--0000000000002452fd06487a78f3--

