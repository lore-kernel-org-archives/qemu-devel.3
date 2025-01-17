Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22B1C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYomV-0002wC-Jw; Fri, 17 Jan 2025 11:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYomT-0002vb-8n
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:01:09 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYomP-00015Z-Vz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:01:09 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so436360066b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737129663; x=1737734463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMX8neI+Vn25vJGZyNf8DZLweO620Hm9MVq3oL/kxE8=;
 b=Rjv1uQJQvCQ5Kf4LmtKd9BtdE+3esTACeouQ1MAxg1oYHP4LeDczKcJ1E9VIWwKceF
 Lv47Nnx/MCM1spO/jLyz3q/5Q9HyFKurZSofhzfeWIv8XfE2+K7suKXvNTiRgcOVk9nb
 91R4EjWl5z6hxmbS5ODiw+Dp4lFHA+QTuMvJnhykFvN2t42dq9uzaQZnN4OSTrpNAUbK
 EYINBvqatgmuG9WEovuUSPto3h/gbalqlCyLJmjfdGF7bD3Tl3iUZuyVgZue3mS+YuOp
 XKXjYSWrBqw8t2A9ZwJC6qY04r5YJv1lOiK7kX5qzI1Rob/1zyOigVw0034eK60uzmKB
 Ehtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737129663; x=1737734463;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMX8neI+Vn25vJGZyNf8DZLweO620Hm9MVq3oL/kxE8=;
 b=kUm1uZTC6R1m6UdnLkmlSxCpt3nNw5plU9AjbMZ5DwCvDsmgivvKeIOwyoxtW6gGsp
 9+BmJ1gV69JTIJp0yvkFdMfpr5Y3LfXn8tAQWoDXGyUKhOAxH5Z8y0DLGV39GjLLGxLV
 Jrlkgn6gVdtCcLwzX2W1RoLCWIazMd0hz8/11DMhiSDWwYMYatbDSCO8ldQvdPVLN4ZG
 jfHZAAtzOa2TEe5kSJWjBGrVSa8V59HMrluKR4Dvl3CPN4F6iewFvre/yMMeyHeyD3UP
 1Iew7abqJ7LR6MnmMyiSBGkzlO9w0mqOvwj+JLSywYAlNkqVcHKc0bZaSj3egIe5DXW8
 hjlQ==
X-Gm-Message-State: AOJu0YzCu36oF17dfMpTXTnICrU+YQN+PW6PyBHyC8tgAsqNXU76h8a7
 CwxTXYbCNsUleXN1/sQSKP92fvyQJ0oM555LfkPDE9Vl2JFqi3h0qAZEhb2U4fkny83unfzau1s
 8SlI=
X-Gm-Gg: ASbGncs0RwjH8XL8kNWuTZZXqZxHZvHu2gsvwuppdN3EF0y34nVfGri1I6q1N0CgDte
 TdASNEOphmjy84Y7nxgKfUGmDCWBJKoTbzfB6o7TD7lP84+HOHx/LgbNbr4hr7R1lgBMUL14uSl
 h8h0sO+1c7jWHQaRyOaKJAvDCuxWYVOnVxDmpi9JvPu4y4a7iwZ710AX3GIMZf0UGONvPZvnZGz
 F4JLS7EaI+Rlq3w7RkAe+/NzDssLsxjgcbziO6snUlBZ5dpA/wRczg=
X-Google-Smtp-Source: AGHT+IGuHusBSOH1pVOXd3ueUWW5ijHJcxIJwlCpT4jbBLBDVgZlv2ajflCu7fFTRByo2FqW0+XgLw==
X-Received: by 2002:a17:907:2d8f:b0:aae:c3c1:1361 with SMTP id
 a640c23a62f3a-ab38b37eb60mr303372566b.44.1737129661118; 
 Fri, 17 Jan 2025 08:01:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5ad7bsm190678766b.36.2025.01.17.08.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:01:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 296136083E;
 Fri, 17 Jan 2025 16:00:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] rust: add --check-cfg test to rustc arguments
In-Reply-To: <20250107155406.53161-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 7 Jan 2025 16:54:05 +0100")
References: <20250107155406.53161-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 16:00:59 +0000
Message-ID: <87plklfn0k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> rustc will check that every reachable #[cfg] matches a list of
> the expected config names and values.  Recent versions of rustc are
> also complaining about #[cfg(test)], even if it is basically a standard
> part of the language.  So, always allow it.

Hmm this breaks the non-project CI builds even further (I as hoping it
would help):

  FAILED: rust/qemu-api/libqemu_api.rlib=20
  /usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc -=
C linker=3Dcc -C link-arg=3D-m64 --color=3Dauto -C debug-assertions=3Dyes -=
C overflow-checks=3Dno --crate-type rlib -D warnings --edition=3D2021 -C op=
t-level=3D2 -g -D unexpected_cfgs -D unsafe_op_in_unsafe_fn -D warnings -D =
unknown_lints --check-cfg test --check-cfg 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLO=
C)' --check-cfg 'cfg(MESON)' --check-cfg 'cfg(has_offset_of)' --cfg MESON -=
C default-linker-libraries --crate-name qemu_api --emit dep-info=3Drust/qem=
u-api/qemu_api.d --emit link=3Drust/qemu-api/libqemu_api.rlib --out-dir rus=
t/qemu-api/libqemu_api.rlib.p -C metadata=3D81e2432@@qemu_api@sta --check-c=
fg 'cfg(feature,values("allocator"))' --check-cfg 'cfg(feature,values("debu=
g_cell"))' --cfg HAVE_GLIB_WITH_ALIGNED_ALLOC --cfg has_offset_of rust/qemu=
-api/libqemu_api.rlib.p/structured/lib.rs
  error: invalid `--check-cfg` argument: `test`
    |
    =3D note: expected `cfg(name, values("value1", "value2", ... "valueN"))`
    =3D note: visit <https://doc.rust-lang.org/nightly/rustc/check-cfg.html=
> for more details
  [778/3165] Generating tests/Test QAPI files with a custom command
  [779/3165] Compiling Rust source ../subprojects/syn-2.0.66/src/lib.rs
  ninja: build stopped: subcommand failed.
  make: *** [Makefile:168: run-ninja] Error 1

See https://gitlab.com/stsquad/qemu/-/jobs/8883566658

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/rust/rustc_args.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
> index 5525b3886fa..d79dc6d81f1 100644
> --- a/scripts/rust/rustc_args.py
> +++ b/scripts/rust/rustc_args.py
> @@ -215,6 +215,8 @@ def main() -> None:
>=20=20
>      if rustc_version >=3D (1, 80):
>          if args.lints:
> +            print("--check-cfg")
> +            print("test")
>              for cfg in sorted(cargo_toml.check_cfg):
>                  print("--check-cfg")
>                  print(cfg)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

