Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614B0D12D5F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 13:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQmuA-0004DL-Jt; Wed, 03 Dec 2025 08:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQmu8-0004BV-Qn
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:28:25 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQmu7-0004Hx-Ap
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:28:24 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so65994895e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 05:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764768501; x=1765373301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LMjN+FSFiJIUJWtHAecKlsIaVKv4r6zvwFKIfYquUg=;
 b=bif1KnE2SJC2demI2dVkiS4pM2kX0lIMFBcpA6VGclUYzEyiHmCqep/rfRIYXbmq4i
 5VSN+xBhMVLgjbMsog44iybTFbJgjXmOnDzrppClgUZH7FmLmMr+PORE7vLu0JEMQV2P
 6flYENwJp2fjTtkx0ufbc5g3CVBAHY08eRdMH3KZWeRfUBTtlgWIaajDwh4cM4r3cCmO
 NBXkIGjVS84+UMYcXc5vjo46prDo7rAQjckrDKcMc5uCGFVInKP/0J0uMXJ+Cnty/zwO
 /3bxb8PimKBaoH3BD3sWPemly3FiQknb3Dvt0E7ftXW9dS7+teqID8lHBrFIrsEusYI4
 7qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764768501; x=1765373301;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6LMjN+FSFiJIUJWtHAecKlsIaVKv4r6zvwFKIfYquUg=;
 b=s6X5OxMnRsSJf0YRmOI0XTrERniJeW4mBIptacnJd1n4hwZCIad87zWZMKgZjSS8gN
 vjaFpOGRF1r+DYy/+V4+F7K0q+cCBALGy2TyILEaGehK1GVTnnDDRWznoC+QuMk0KELU
 3H/6ZagbSuGTsgPZZv1lIbxikoB2JRe1InamLsL45fbhMPJpBbsX2qY+3Hir+LVLr0wj
 7r2Kcf3Z/T3sEDPz7QTHDmVfg0IvHyeEgGyEYfKp8968VqvZZxt94jQrUZEV2up2TyPK
 5UDvroJeoLV/12/CqU+jiYGcTgDoHLQMSghauu4yVyPmb6nLlEbvj3TjFRW31CJzxyJT
 AZKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCjJs6Ob56XfaLRlFgWtYaRtJkjuXkVBEXlSZsipGh7+/xZ3k0onD9/qIaRU6WgkJwShELNL8FzSTW@nongnu.org
X-Gm-Message-State: AOJu0Yz9iIkeoQfVnI5g2thAoVH9v8pSZVsMZ6LyN2F6kOOKbuXZwH2l
 zS7olGLdbph4zXlrlN/wk5laqqa+vR+SyhfoEKF5Fp1RGBUezBXVuCNx2BoM0DRxT9U=
X-Gm-Gg: ASbGnctuSlm8lCBB28kxmwYh04BvRVetToEUimykpEXyytBNAH/Hjs2q+CQcUMUJ4T3
 MtJ4lNwcy4BufzFVGYIxsQSx7ybmTYXvux0AomOTA0dB08m3ssUU4RxKdzkXQtdE7R0BcsrposI
 meq0V4JY4LOxmTEskHSXQ4HXhEMpIFkrowdEO8H5kMOG4BO9/KjZGOUw1fmtNe+etzy7olVHIz0
 MJIIY76t5EIIMwQR6umfARDGtTL+4sq5eGWF4VZRovZqEHPhsKPNOideralKZ5Zie3fN+8hL0Yt
 4F9KccU5G5u8mwtIGS17y1djR8AU1+rkK1nwEnagDfEB+XYv0F5qvLyIDOLp0oLTwMBGaq90Sxr
 /n+Pb7cEXgT9H+/UWmZD9qQoT2Ib7y+MqPmCFB5KktqSXX8KBnIYeFpkk8+uUNKMon1fNtEwGhQ
 Xof2xCB/gDBU0=
X-Google-Smtp-Source: AGHT+IHeroVIsRDWizOZ/beLgpVo4DYkOjwZCyhAOL/yKEfCoL7PIshPfm1A8Y45x0nLxJCZUtMsHA==
X-Received: by 2002:a05:6000:2dca:b0:429:8bfe:d842 with SMTP id
 ffacd0b85a97d-42f731678d3mr2422250f8f.4.1764768500747; 
 Wed, 03 Dec 2025 05:28:20 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3041sm36671063f8f.6.2025.12.03.05.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 05:28:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C0EA5F7B3;
 Wed, 03 Dec 2025 13:28:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: dave@treblig.org
Cc: qemu-trivial@nongnu.org,  mjt@tls.msk.ru,  laurent@vivier.eu,
 thuth@redhat.com,  pbonzini@redhat.com,  jak@jak-linux.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
In-Reply-To: <20251203131511.153460-1-dave@treblig.org> (dave@treblig.org's
 message of "Wed, 3 Dec 2025 13:15:11 +0000")
References: <20251203131511.153460-1-dave@treblig.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 03 Dec 2025 13:28:19 +0000
Message-ID: <87a4zzu230.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> -M is used heavily in documentation and scripts, but isn't actually
> documented anywhere.
> Document it as equivalent to -machine.
>
> Reported-by: Julian Andres Klode <jak@jak-linux.org>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  qemu-options.hx | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fca2b7bc74..ec92723f10 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>  #endif
>      "                memory-backend=3D'backend-id' specifies explicitly =
provided backend for main RAM (default=3Dnone)\n"
>      "                cxl-fmw.0.targets.0=3Dfirsttarget,cxl-fmw.0.targets=
.1=3Dsecondtarget,cxl-fmw.0.size=3Dsize[,cxl-fmw.0.interleave-granularity=
=3Dgranularity]\n"
> +    "                sgx-epc.0.memdev=3Dmemid,sgx-epc.0.node=3Dnumaid\n"
>      "                smp-cache.0.cache=3Dcachename,smp-cache.0.topology=
=3Dtopologylevel\n",
>      QEMU_ARCH_ALL)
>  SRST
> @@ -179,6 +180,9 @@ SRST
>=20=20
>              -machine cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dc=
xl.1,cxl-fmw.0.size=3D128G,cxl-fmw.0.interleave-granularity=3D512
>=20=20
> +    ``sgx-epc.0.memdev=3D@var{memid},sgx-epc.0.node=3D@var{numaid}``
> +        Define an SGX EPC section.
> +

This seems unrelated.

>      ``smp-cache.0.cache=3Dcachename,smp-cache.0.topology=3Dtopologylevel=
``
>          Define cache properties for SMP system.
>=20=20
> @@ -208,12 +212,10 @@ SRST
>  ERST
>=20=20
>  DEF("M", HAS_ARG, QEMU_OPTION_M,
> -    "                sgx-epc.0.memdev=3Dmemid,sgx-epc.0.node=3Dnumaid\n",
> -    QEMU_ARCH_ALL)
> -
> +    "-M              as -machine\n", QEMU_ARCH_ALL)
>  SRST
> -``sgx-epc.0.memdev=3D@var{memid},sgx-epc.0.node=3D@var{numaid}``
> -    Define an SGX EPC section.
> +``-M``
> +    as -machine.

Did we have a merge conflict at some point that messed things up?

>  ERST
>=20=20
>  DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

