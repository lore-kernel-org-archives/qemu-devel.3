Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9947C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKGxx-0007oS-UK; Thu, 20 Jun 2024 08:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKGxv-0007o4-I3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 08:32:35 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKGxt-0000x6-EX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 08:32:35 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6e43dad8ecso143988466b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718886751; x=1719491551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a6yXOJ/5b/Z61VC4KaIYdjg7ikhl6TmgTec8VwwDpAY=;
 b=pPC3BaB0o0ZAX+xlzb8PMHhR7mp7bWlNuaQxu9LrDri8yV1pWLLJiGjyPnW3P9EGCW
 XmX5JyUWBwSgnhjNztuDGbTZ4Lgkx0Q1DEgTR3hJ3/TnYU/atDvGART3oQP5tGhGIEgN
 Qr6cNBVuGbt+4No0Iw9pEJvBpirFsKc2kUTSGIF5+KL6AKiruLZbHc9/Ix42VxCPEBIZ
 k7QGnmypCLLT86irR82eKo3s67vEQCUZeCr8Ir2NqLA2XVHjGmc8xcaNbUIuZo6iktC2
 iSpv8uWytYbEJewvQ35ZxbqVBOV2wpm9E5EKyiNJRKfLAI3sqUGcEyTI/932KF+lijox
 Lalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718886751; x=1719491551;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6yXOJ/5b/Z61VC4KaIYdjg7ikhl6TmgTec8VwwDpAY=;
 b=oBuHwOGE03F6xLVz9oPJ/e4Oa5y7VQudIoe/Tkz6YoOwr2b06CnsYiHY0TC2Du3pF6
 aUoN0VDAOUFCSTXHRqar6EBKbTZm2GRNyx+5DYGxBAbbF4MLfsQMXU1LqK5SVQbCWsht
 SYmByo5eOB4om1tTPLiTAH0IWnZtS/k/kjB3HOOE/4Tkz/yrpCKm3BvzlYaOh4MmIcKd
 v7iBh/9SdJACyVy9IAqGTXMx0y0/+8O9RVxh2AKTeA6/kIi+4qO8TCCYwh2bSf7r4fqM
 WwbQgSte9oYULsFRtToAcRqwtLScBTVOWQ6B4qoTHEmZ8nOtqPliUnxe/24WVMDv7YhR
 7szQ==
X-Gm-Message-State: AOJu0YxwSZwP4maYXUeKRtVcmGbw/KC8cyHq25cuqSi9cC3ESb+oU2p9
 mbA7DrvSxXc1KVzeGq8P+moNkdkR/xIQs42K8SEwOYHYiCxBe0pW/cTPhsP62oc=
X-Google-Smtp-Source: AGHT+IFfakSddYwLbilQrqFPwKRWVXfoNwELYTL/E6kS87anN9uHHhAIUenScCFXGgUk/xK5yxBp2A==
X-Received: by 2002:a17:906:33db:b0:a6f:6364:4168 with SMTP id
 a640c23a62f3a-a6f9506f6ffmr529634466b.30.1718886750692; 
 Thu, 20 Jun 2024 05:32:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa67ecsm753372866b.215.2024.06.20.05.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 05:32:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FDC85F7B1;
 Thu, 20 Jun 2024 13:32:25 +0100 (BST)
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
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
In-Reply-To: <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Wed, 19 Jun 2024 23:13:59 +0300")
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
Date: Thu, 20 Jun 2024 13:32:25 +0100
Message-ID: <8734p7dcbq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
<snip>
> +
> +
> +rust_targets =3D {}
> +
> +cargo_wrapper =3D [
> +  find_program(meson.global_source_root() / 'scripts/cargo_wrapper.py'),
> +  '--config-headers', meson.project_build_root() / 'config-host.h',
> +  '--meson-build-root', meson.project_build_root(),
> +  '--meson-build-dir', meson.current_build_dir(),
> +  '--meson-source-dir', meson.current_source_dir(),
> +]

I'm unclear what the difference between meson-build-root and
meson-build-dir is?

We also end up defining crate-dir and outdir. Aren't these all
derivable from whatever module we are building?

> +
> +if get_option('b_colorout') !=3D 'never'
> +  cargo_wrapper +=3D ['--color', 'always']
> +endif
> +
> +if get_option('optimization') in ['0', '1', 'g']
> +  rs_build_type =3D 'debug'
> +else
> +  rs_build_type =3D 'release'
> +endif
> +
> +# Collect metadata for each (crate,qemu-target,compiler-target) combinat=
ion.
> +# Rust meson targets cannot be defined a priori because they depend on b=
indgen
> +# generation that is created for each emulation target separately. Thus =
Rust
> +# meson targets will be defined for each target after the target-specific
> +# bindgen dependency is declared.
> +rust_hw_target_list =3D {}
> +
> +foreach rust_hw_target, rust_hws: rust_hw_target_list
> +  foreach rust_hw_dev: rust_hws
> +    output =3D meson.current_build_dir() / rust_target_triple / rs_build=
_type / rust_hw_dev['output']
> +    crate_metadata =3D {
> +      'name': rust_hw_dev['name'],
> +      'output': [rust_hw_dev['output']],
> +      'output-path': output,
> +      'command': [cargo_wrapper,
> +        '--crate-dir', meson.current_source_dir() / rust_hw_dev['dirname=
'],
> +        '--profile', rs_build_type,
> +        '--target-triple', rust_target_triple,
> +        '--outdir', '@OUTDIR@',
> +        'build-lib'
> +        ]
> +      }
> +    rust_targets +=3D { rust_hw_target: [crate_metadata] }
> +  endforeach
> +endforeach
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> new file mode 100644
> index 0000000000..bcf808c8d7
> --- /dev/null
> +++ b/rust/wrapper.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2020 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu-io.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/sysbus.h"
> +#include "exec/memory.h"
> +#include "chardev/char-fe.h"
> +#include "hw/clock.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/irq.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "chardev/char-serial.h"
> diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
> index 927336f80e..833e0e55f8 100644
> --- a/scripts/cargo_wrapper.py
> +++ b/scripts/cargo_wrapper.py
> @@ -111,6 +111,8 @@ def get_cargo_rustc(args: argparse.Namespace) -> tupl=
e[Dict[str, Any], List[str]
>=20=20
>      env =3D os.environ
>      env["CARGO_ENCODED_RUSTFLAGS"] =3D cfg
> +    env["MESON_BUILD_DIR"] =3D str(target_dir)
> +    env["MESON_BUILD_ROOT"] =3D str(args.meson_build_root)
>=20=20
>      return (env, cargo_cmd)
>=20=20
> @@ -234,6 +236,14 @@ def main() -> None:
>          required=3DTrue,
>      )
>      parser.add_argument(
> +        "--meson-build-root",
> +        metavar=3D"BUILD_ROOT",
> +        help=3D"meson.project_build_root()",
> +        type=3DPath,
> +        dest=3D"meson_build_root",
> +        required=3DTrue,
> +    )
> +    parser.add_argument(
>          "--meson-source-dir",
>          metavar=3D"SOURCE_DIR",
>          help=3D"meson.current_source_dir()",

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

