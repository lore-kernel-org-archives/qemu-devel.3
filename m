Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ECAC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 08:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRT6v-0007EO-Ds; Wed, 10 Jul 2024 04:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRT6r-00079Q-OF
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:55:34 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRT6q-0003HA-5Z
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:55:33 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso59639911fa.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720601728; x=1721206528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DjdmeDF7aDD3ajIkpCajmXUDcfC4dgyxB0ZY77skzhk=;
 b=RyOPBsS6EcbNtWZWFjeF735soCC49iT7z7NFJqJsQ4vdvDxNSB2ckuwpSxMqSzQ9G8
 rUovpL4HtPoVT0Hh1KcA1yXu5uuMC+JybcggXBlGC78IVdE1tJCD+o3OzM2jhfPzh8eS
 7BFtQEISn4fyfkC1ig6UKsaS0I+bIDMIzCHm5/qNYMBJlRD/unB3AdBruZbkoNoLfYYZ
 zThwvp4HyTxeGFg8RyrN/uugwn2u+e+aVBCuWpwQ0M7wCAk0s/+t7ScLD0GzsGF1dKdR
 Yp1dtAuC4VDShDFw1GRIIb2NqKjm8/Mnq4uJyUoTCKJeFJMdbXz+gP1WLcYmkfUHj2Y9
 i6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720601728; x=1721206528;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjdmeDF7aDD3ajIkpCajmXUDcfC4dgyxB0ZY77skzhk=;
 b=qDTaZtWNBfYciemlxhYSmsoHPndaA3c38sD+4RRdqJnTGUt9MliBR9cArgULzXV7io
 tMItXjC5P6wCMm3y9zkLkWiLFri6sf91NfYoDOpg/rX12IZgSG6JFuZ/D9ys+C2+4PHu
 7U25qU19jwmOVUfRv3yD93Nn7QWi0VM2BvP2VF6vfaCq+P4zb0uj6g6lEV1FbSqzGAVW
 fjvnkYOOdu4DURGcBhjRhn8u8dyzLZbtxMsoOKhHT/yOMRN6UqI7OcrlbWQvjQZFf2/e
 OXLXuOtJAsIia8fedM/fb/Tsig6gxsAqWO6W1dVJuN5Y3z3UwIgz0cETyf8s+7nIh9IO
 SHZg==
X-Gm-Message-State: AOJu0YwA4ElEP3d5aw9dUw+68we3hL/lfwyXARiFLN6PoKXziwB6x35e
 /YraYz5t0DrqMaHwPhkL6IRbt72406tbNyoVeBXupb9b7xvM8EKmxTWvb55lQbw=
X-Google-Smtp-Source: AGHT+IH+dcb24zpu1bjBGcyWLXJ67D0R+IqTbxkZ47XaRSjkxgPqJDkdxnORrP5IVooB4MoifeE6fw==
X-Received: by 2002:a2e:2ac3:0:b0:2ec:1708:4db2 with SMTP id
 38308e7fff4ca-2eeb3197a75mr29122731fa.47.1720601728339; 
 Wed, 10 Jul 2024 01:55:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bd459de5sm1978506a12.70.2024.07.10.01.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:55:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DAD795F881;
 Wed, 10 Jul 2024 09:55:26 +0100 (BST)
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
Date: Wed, 10 Jul 2024 09:55:26 +0100
Message-ID: <87ttgxr5hd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
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
<snip>
> +      # We need one bindings_rs build target per arch target, so give th=
em
> +      # arch-specific names.
> +      copy =3D fs.copyfile('rust/wrapper.h',
> +                         target + '_wrapper.h')
> +      bindings_rs =3D rust_bindgen.bindgen(
> +        input: copy,
> +        dependencies: arch_deps + lib_deps,
> +        output: 'bindings-' + target + '.rs',
> +        include_directories: include_directories('.', 'include'),
> +        args: [
> +          '--ctypes-prefix', 'core::ffi',
> +          '--formatter', 'rustfmt',

I guess we also need to detect rustfmt, although it seems to be
non-fatal:

  15:59:27 [alex@debian-arm64:~/l/q/b/rust] review/rust-pl011-v4 + ninja
  [831/3041] Generating bindings for Rust rustmod-bindgen-aarch64-softmmu_w=
rapper.h
  Failed to run rustfmt: cannot find binary path (non-fatal, continuing)
  [3041/3041] Linking target tests/qtest/qos-test

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

