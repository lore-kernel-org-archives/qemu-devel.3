Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D20FCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRUC-0001zt-Jk; Mon, 25 Aug 2025 03:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRU7-0001vO-Bg
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:19:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRU0-0001Fe-M6
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:19:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61c26f3cf6fso4984540a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756106345; x=1756711145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLp0m6ea3e0c8briQDkIXqwEqMhnxGpwcwjVUt8zo2o=;
 b=mADE4QS2p/gkXfpYtzPzSx7DO58gff+DBBPPYRRi+iR25vG4rjNFekf9Ufam2pskRv
 Ty36LCBxxpUa/Vcw83XOmBOgECmtPEpZBKZP7FoA7ZIWcSO1UKxUBqiSOQcq7PSWxpTT
 UOXmUYCupHE8aJ5wmOwsA5Jwis05dqLtCY9AiNVjb5wdHqr8MOcG+BtNmGhkF7QNgoX6
 GvXYaVbX4LqqUVBHUrqT2GwXr8+EsYWLbjDY20Lot/nJhL9lOTu7ABZQ+8+zSwKQRGS+
 JwHsDwD047iMpnPbTxtTw8QxOCjBEZq/TgGZQtSzmQ78LR8JMtlZYlTLG+2yGxd08IAh
 hDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756106345; x=1756711145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLp0m6ea3e0c8briQDkIXqwEqMhnxGpwcwjVUt8zo2o=;
 b=M0dQ4rSSI00YLcZyz+HcQqTqV6MI3BKOwOsk/cVk1xu6yjM3sjZZloc3nHZqZe9Ybw
 a2B+wWxdW7yL9+Kx0kS+Jbs8jKU3ZbEkGfx4Z24UwRBbezVJikBAKfttNwMMXmaz38Ta
 ZydvEosDBMdGt5E8i0InY1rpaWj528pM4cdVPk2zk5AEjgA4d0yb1Kxo+/zB7NSR6hz+
 XJmaT8dL2uxB9DzcM0YYMAD7zZo7vWty+FwmqUFXv/l1U1xTLtfvNBFXPhAhEl2ZtTxK
 QEJTEbqbt9jMRimIqEPR58hvlbYJpzSe3tcPF+lbDQLQmeFHqw8FOnu7DEtYCfuzRSf6
 XsXg==
X-Gm-Message-State: AOJu0YxTZ++gCJilSYxFDZPDmz0ogvy7JHspvZPVJL18G8nqldNnNfk3
 wc6RbWf2wUc8VHjZBSG46xcjxTsYgzKLjRpaudy9gSUQml7sNT42k5biuAhJVX8FhHqBvGcwuOH
 ShXphRTWZ6VSUQcte1yYzqxJVPzoiq5jZc1yF1+c4hA==
X-Gm-Gg: ASbGncsZyLYv8TwnsTdxcG00i7m2myexjuHWYxtSOOFrAeE9mDWxP9nWHayJ7yYgTAu
 dQEHbwQwk7O7820HqnVvhWSb9vLEenRofo0RT178JcqrWfHv9M1L+J4i3A3t+Q7diWu2fsF96uA
 Pi+gikE2NOFJY+vgKISjkkygzk3UjuumjhjQ3sDRPOcy+ly9CzJe4Uelq5hys6zmUQJroFXGD5F
 algbxVMIN3z5m2SKqo=
X-Google-Smtp-Source: AGHT+IHRsdMluH6nib53zjbAiU518qjJS5gb13PWfGa+if9uZWQ4Jr899Cxki16ktGjDZOE6MBxCnXxhBFDN4RIEyL4=
X-Received: by 2002:a05:6402:5247:b0:617:f5e7:fe22 with SMTP id
 4fb4d7f45d1cf-61c1b41150cmr9729547a12.16.1756106344704; Mon, 25 Aug 2025
 00:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-8-pbonzini@redhat.com>
In-Reply-To: <20250822122655.1353197-8-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:18:38 +0300
X-Gm-Features: Ac12FXylF-Toqg-S474evmdHWp6oP4wKQuaXVBxmY9waS673R8g7ygp_i36Xat8
Message-ID: <CAAjaMXYEp+c3gn7Gyp9_YS0iOmCP9FhRXTMEw9+dZbXaha2JzQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] rust: add trace crate
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, Aug 22, 2025 at 3:30=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Tanish Desai <tanishdesai37@gmail.com>
>
> The trace crate is a minimal container for dependencies of tracepoints
> (so that they do not have to be imported in all the crates that use
> tracepoints); it also contains a macro called "include_trace!" that is
> able to find the right include file from the trace/ directory.
>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> [Write commit message. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock        |  4 ++++
>  rust/Cargo.toml        |  1 +
>  rust/meson.build       |  2 +-
>  rust/trace/Cargo.toml  | 16 ++++++++++++++++
>  rust/trace/meson.build | 19 +++++++++++++++++++
>  rust/trace/src/lib.rs  | 23 +++++++++++++++++++++++
>  trace/meson.build      |  8 +++++++-
>  7 files changed, 71 insertions(+), 2 deletions(-)
>  create mode 100644 rust/trace/Cargo.toml
>  create mode 100644 rust/trace/meson.build
>  create mode 100644 rust/trace/src/lib.rs
>
> diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> index b785c718f31..aa13ab2a99a 100644
> --- a/rust/Cargo.lock
> +++ b/rust/Cargo.lock
> @@ -164,6 +164,10 @@ dependencies =3D [
>   "unicode-ident",
>  ]
>
> +[[package]]
> +name =3D "trace"
> +version =3D "0.1.0"
> +
>  [[package]]
>  name =3D "unicode-ident"
>  version =3D "1.0.12"
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 99c275f2d9f..2be9f886113 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -4,6 +4,7 @@ members =3D [
>      "bits",
>      "qemu-api-macros",
>      "qemu-api",
> +    "trace",
>      "hw/char/pl011",
>      "hw/timer/hpet",
>  ]
> diff --git a/rust/meson.build b/rust/meson.build
> index 45936a0a731..2878bd8bc8d 100644
> --- a/rust/meson.build
> +++ b/rust/meson.build
> @@ -23,7 +23,7 @@ genrs =3D []
>  subdir('qemu-api-macros')
>  subdir('bits')
>  subdir('qemu-api')
> -
> +subdir('trace')
>  subdir('hw')
>
>  cargo =3D find_program('cargo', required: false)
> diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
> new file mode 100644
> index 00000000000..913010e9787
> --- /dev/null
> +++ b/rust/trace/Cargo.toml
> @@ -0,0 +1,16 @@
> +[package]
> +name =3D "trace"
> +version =3D "0.1.0"
> +authors =3D ["Tanish Desai<tanishdesai37@gmail.com>"]

Missing space between name and angle bracket

> +description =3D "rust trace library"

Suggestion:

> +description =3D "QEMU tracing infrastructure support"

> +resolver =3D "2"
> +publish =3D false
> +
> +edition.workspace =3D true
> +homepage.workspace =3D true
> +license.workspace =3D true
> +repository.workspace =3D true
> +rust-version.workspace =3D true
> +
> +[lints]
> +workspace =3D true
> diff --git a/rust/trace/meson.build b/rust/trace/meson.build
> new file mode 100644
> index 00000000000..adca57e5507
> --- /dev/null
> +++ b/rust/trace/meson.build
> @@ -0,0 +1,19 @@
> +rust =3D import('rust')
> +
> +lib_rs =3D configure_file(
> +  input: 'src/lib.rs',
> +  output: 'lib.rs',
> +  configuration: {
> +    'MESON_BUILD_ROOT': meson.project_build_root(),
> +  })
> +
> +_trace_rs =3D static_library(
> +  'trace',             # Library name,
> +  lib_rs,
> +  trace_rs_targets,         # List of generated `.rs` custom targets
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  dependencies: [libc_rs],
> +  rust_abi: 'rust',
> +)
> +
> +trace_rs =3D declare_dependency(link_with: _trace_rs)
> diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
> new file mode 100644
> index 00000000000..9b931ddf1de
> --- /dev/null
> +++ b/rust/trace/src/lib.rs
> @@ -0,0 +1,23 @@
> +//! This crate provides macros that aid in using QEMU's tracepoint
> +//! functionality.

Missing SPDX headers

> +
> +#[macro_export]
> +/// Define the trace-points from the named directory (which should have =
slashes

Pedantic: s/trace-points/tracepoints

> +/// replaced by underscore characters) as functions in a module called `=
trace`.
> +///
> +/// ```ignore
> +/// ::trace::include_trace!("hw_char");
> +/// // ...
> +/// trace::trace_pl011_read_fifo_rx_full();
> +/// ```
> +macro_rules! include_trace {
> +    ($name:literal) =3D> {
> +        mod trace {
> +            #[cfg(not(MESON))]
> +            include!(concat!(env!("MESON_BUILD_ROOT"), "/trace/", $name,=
 ".rs"));
> +
> +            #[cfg(MESON)]
> +            include!(concat!("@MESON_BUILD_ROOT@/trace/", $name, ".rs"))=
;
> +        }
> +    };
> +}
> diff --git a/trace/meson.build b/trace/meson.build
> index 9c42a57a053..d89a0db82a1 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -1,5 +1,5 @@
>  system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
> -
> +trace_rs_targets =3D []
>  trace_events_files =3D []
>  foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
>    if item in qapi_trace_events
> @@ -24,6 +24,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_t=
race_events
>                            input: trace_events_file,
>                            command: [ tracetool, group, '--format=3Dc', '=
@INPUT@', '@OUTPUT@' ],
>                            depend_files: tracetool_depends)
> +  trace_rs =3D custom_target(fmt.format('trace', 'rs'),
> +                          output: fmt.format('trace', 'rs'),
> +                          input: trace_events_file,
> +                          command: [ tracetool, group, '--format=3Drs', =
'@INPUT@', '@OUTPUT@' ],
> +                          depend_files: tracetool_depends)
>    if 'ust' in get_option('trace_backends')
>      trace_ust_h =3D custom_target(fmt.format('trace-ust', 'h'),
>                                  output: fmt.format('trace-ust', 'h'),
> @@ -34,6 +39,7 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_tr=
ace_events
>      genh +=3D trace_ust_h
>    endif
>    trace_ss.add(trace_h, trace_c)
> +  trace_rs_targets +=3D trace_rs
>    if 'dtrace' in get_option('trace_backends')
>      trace_dtrace =3D custom_target(fmt.format('trace-dtrace', 'dtrace'),
>                                   output: fmt.format('trace-dtrace', 'dtr=
ace'),
> --
> 2.50.1
>
>

