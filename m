Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4FFD4920C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzR5-0002cB-9u; Mon, 18 Nov 2024 05:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCzR2-0002bg-Ct
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:56:48 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCzR0-0004rn-Ox
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:56:48 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa1f73966a5so396842766b.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731927405; x=1732532205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgbpPqyJ37eXI4U9cjLKsKq9PUDJgdylzUDJzUHlhPc=;
 b=HH7RI9iCk58QuAtY1Oj1lfoaZZL3OteRSD+qCm1x3N2eWivWmlmMMjARRljkiXoqxw
 /dd8306M2/TI/znzUSCU9FcY+U4eSq+z3936WalckhGI4OBrAS+7FCIDQ59YMUy7yDS1
 ns7uCf0yIOC3aaM3eI0Cy9VS9yWw54E4hBN5YJL3mv6bpDVBVnvY/asAkx36+I4gdPUb
 mADruXpcnfPzi4w8ZW/7iD5bEOcN6+gFxnm47u1O/W4gGhcKQczwkXCOR8no/BUg9vlk
 ygEjg1bqfmfGEUjT2Yx6JV2JtCo0A7EHAMk4TDdQmRJg8hSSTjJSeKzdKsHrpoH0j2U4
 ryDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731927405; x=1732532205;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wgbpPqyJ37eXI4U9cjLKsKq9PUDJgdylzUDJzUHlhPc=;
 b=hh/RJ15GCJtsTrOBEXMYeRfCZKkkKeRxgOoACCVxCtpzMGxU1d2Gn9sxL+qscl+fRI
 49gp+YtcrAB4tXKaIF//BGfLmZjSGV/wPUICM4+IIEh8uRDi8egDhchzKzfV55eE4R3e
 mb7h6Qv6B+lddhcMoOIHOwGxIGypUlHRIF+vnkVsenNJLRavmg/HDP/E3OGauo2ZmIBg
 cduVQgMDgDRfe2LdkvnmF/9hHDNCbuMojnE29It7FpicN1/uC6X/4KuoGWh30nkgYrt8
 8m/1vxF7jx1jajUr81kLRFv7HZqQKwbWjQOh+12wFtLzZEwmHZomRrgJF1UYNw2l8v4b
 kKuA==
X-Gm-Message-State: AOJu0YzXhECbc0drQbyGmjb2WzjUyNosi3ZY+VQKO8Sep8XZoCTAka5W
 rEp6pJgftkjnLD44SplaHn60NGetkNYGXrriehytKU2xzeeoyVugxCSMLwKlj5M=
X-Google-Smtp-Source: AGHT+IG/TA3UOkLU2Qn3B+5GvnJEn9ylZ1RfrQ3TvHoJoJirrxv2E71PadeXF6RZcQ/WRbsXzexbYw==
X-Received: by 2002:a17:907:6ea4:b0:a99:762f:b298 with SMTP id
 a640c23a62f3a-aa483525e24mr996157766b.41.1731927404802; 
 Mon, 18 Nov 2024 02:56:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df50cfesm534435766b.66.2024.11.18.02.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 02:56:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7BB15F7C6;
 Mon, 18 Nov 2024 10:56:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: CC rust/ patches to qemu-rust list
In-Reply-To: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
 (Manos Pitsidianakis's message of "Sat, 09 Nov 2024 21:29:36 +0200")
References: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 18 Nov 2024 10:56:42 +0000
Message-ID: <87h684u7x1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> As of CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com
> we have a new topical mailing list like qemu-block, qemu-arm, qemu-ppc
> etc but for Rust related patches. Add a new MAINTAINERS entry to touch
> all files under rust/ subdirectory and additionally add it to previous
> rust related entries.

Queued to maintainer/for-9.2 with tweak suggested by PMD to commit
message.

>
> See also:
> https://lore.kernel.org/qemu-devel/CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix=
45Yw6gVHXozRQ@mail.gmail.com/
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 095420f8b0..373176e445 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3338,6 +3338,10 @@ F: rust/qemu-api
>  F: rust/qemu-api-macros
>  F: rust/rustfmt.toml
>=20=20
> +Rust-related patches CC here
> +L: qemu-rust@nongnu.org
> +F: rust/
> +
>  SLIRP
>  M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
> @@ -4241,6 +4245,7 @@ F: docs/devel/docs.rst
>=20=20
>  Rust build system integration
>  M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +L: qemu-rust@nongnu.org
>  S: Maintained
>  F: scripts/rust/
>  F: rust/.gitignore
>
> ---
> base-commit: 134b443512825bed401b6e141447b8cdc22d2efe
> change-id: 20241109-update-maintainers-file-rust-5cbd97b7b11a

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

