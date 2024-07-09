Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E98C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 10:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR8U1-0004RG-Fa; Tue, 09 Jul 2024 06:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sR8Tz-0004Q1-8U
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:54:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sR8Tx-00036a-Cg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:54:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so338804a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720522439; x=1721127239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5DkS5FgBCVdJbSShS0HkAJ6uHwxZfOeE/1Zzq2hfWe4=;
 b=FqT9A4CyMfMVk7W6NRg5cGAYhfTCtXwlsJPuto47vjiocCbMDzpArFlVITR4LyLmSX
 Aw2tsKsrOlYoD/iO3JgiuxoMNdGig06/GJGFVy/YpXtUK+hoGpwI5KTPSWxL8MWM0kP3
 VMbsT2d24P24nWKB3SEa+ZW9rfXgFDSmuE09smeC0yb2nnKPFJLP1l8Qc6USfN0cJbMw
 ULdumYCh5o2h92RoN13CbHK47s00HRIArs3qAOTy77RFQE3UlHXTM4Ef6y818Zfb9edZ
 F1HPc2I3I+4VvTBeST+IMG82lM1v7UpgPampMO8zStD0nx3+Qr09syDTor17DL4uMOxg
 L5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720522439; x=1721127239;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DkS5FgBCVdJbSShS0HkAJ6uHwxZfOeE/1Zzq2hfWe4=;
 b=eA11440AeQEIy8EYIduApSLVvAwy6k80bTAzMS7vApdeC9+MUjslLn2Hbw1F309Z7L
 gv9Ap5PIToRQR/348n+ssSLC5G1pXlsEHUliROLMYNGK38orQSqAJAWAewZSAMEEfeL7
 QP9d+beILJ0dE/bpIZZPpPvjpa7s8C2GRSgjzNY/P8si/qNE/gMmROmMW/KsYeZgwtI/
 6nZdT8JNyt9VyVp+OImQM5WgtYHG4sQ+YOZZPJ8fZfGkPVgDNtOZemD1yZm49k7vN2Z2
 xd2QsS2TixcWv1O9lHEoLfmprAVluwhHVUxtpykkAWU2tSL5yxHwkEwvGrFkbguFXjKP
 1AWQ==
X-Gm-Message-State: AOJu0YxC65hofqmJE8gQ68mUjpYktaNiXghUCfudhxoLl4VxQlUL+Ppf
 n37ZBaI7+SbqeGxE12O4vWt2vU8wBqweDM3OIWv87naHM53JdWCqmH16YJ6Jfcs=
X-Google-Smtp-Source: AGHT+IFxSfb9cJiOO8hharo962cWHYopKgALspjXQxh97OMM/GOwgDoHEUCyuEtCWgAMtXUjmprd2Q==
X-Received: by 2002:a05:6402:2690:b0:585:2d39:5eb2 with SMTP id
 4fb4d7f45d1cf-594baa8bcf7mr1511370a12.8.1720522438841; 
 Tue, 09 Jul 2024 03:53:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bbe2cc76sm918237a12.21.2024.07.09.03.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 03:53:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 549985F8D7;
 Tue,  9 Jul 2024 11:53:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  rowan.hart@intel.com,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
In-Reply-To: <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Thu, 4 Jul 2024 15:15:38 +0300")
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
Date: Tue, 09 Jul 2024 11:53:57 +0100
Message-ID: <87msmqsunu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

> Add mechanism to generate rust hw targets that depend on a custom
> bindgen target for rust bindings to C.
>
> This way bindings will be created before the rust crate is compiled.
>
> The bindings will end up in BUILDDIR/{target}-generated.rs and have the s=
ame name
> as a target:
>
> ninja aarch64-softmmu-generated.rs
>
> The way the bindings are generated is:
>
> 1. All required C headers are included in a single file, in our case
>    rust/wrapper.h for convenience. Otherwise we'd have to provide a list
>    of headers every time to the bindgen tool.
>
> 2. Meson creates a generated_rs target that runs bindgen making sure
>    the architecture etc header dependencies are present.
>
> 3. The generated_rs target takes a list of files, type symbols,
>    function symbols to block from being generated. This is not necessary
>    for the bindings to work, but saves us time and space.
>
> 4. Meson creates rust hardware target dependencies from the rust_targets
>    dictionary defined in rust/meson.build.
>
>    Since we cannot declare a dependency on generated_rs before it is
>    declared in meson.build, the rust crate targets must be defined after
>    the generated_rs target for each target architecture is defined. This
>    way meson sets up the dependency tree properly.
>
> 5. After compiling each rust crate with the cargo_wrapper.py script,
>    its static library artifact is linked as a `whole-archive` with the
>    final binary.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
<snip>
> +
> +msrv =3D {
> +  'rustc': '1.77.2',
> +  'cargo': '1.77.2',
> +  'bindgen': '0.69.4',
> +}

This is still pretty bleeding edge (it even tripped up on the
.cargo/bin/cargo I have installed). This needs to be set to the
baseline which from:

  https://wiki.qemu.org/RustInQemu/2022

Looks to be 1.24.0 for rustc and I guess even lower for cargo (Debian
says 0.66.0). While it might make sense to delay merging if we are
waiting for one distro to produce a new LTS we shouldn't be needing
rustup by default.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

