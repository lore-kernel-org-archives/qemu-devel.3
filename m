Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A16CF58C9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 19:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLnzO-0003ly-Ua; Wed, 19 Nov 2025 14:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLnzJ-0003k0-Cl
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLnzF-0007Bb-7M
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763581023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7WF8ImQWZDIpLHMaA0pPvtG3C2qF+ifFTWB2DA+A4c=;
 b=Vq62st0U0qnJ0MOgAGhNBGFYQdDZtNIhxiXdSIqeB+OqKeKd/PJFZCba2pQuMThM9SyOLw
 aIoUcwTk/xSChqwNTbvGJ/54RJzgri+RpYudSWFYjkkrlu05spMrBW66fGnXatm1QXgyi5
 lDNa4Q4xFEW0qoLds9QsBJn8WzOb9JI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-nCmgU_Y9MdibSKMAX70S4A-1; Wed, 19 Nov 2025 14:37:00 -0500
X-MC-Unique: nCmgU_Y9MdibSKMAX70S4A-1
X-Mimecast-MFC-AGG-ID: nCmgU_Y9MdibSKMAX70S4A_1763581020
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so880125e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 11:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763581019; x=1764185819; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S7WF8ImQWZDIpLHMaA0pPvtG3C2qF+ifFTWB2DA+A4c=;
 b=apWThTLYYAaa7mDdycayFd5pzXR0nwMcj2+SMzG5UKrxLL6Jl+c5ih8IX7TP+hYSg0
 oFrMZjmS5tzVoT+yxbT15fwgZqQjAPDQvlbtDJEGsp+nIlX/lq4UkZAFakkDxy1Pbf++
 VEHhni40CWP/jUSEGMJWz5cudagDp4juu1fF+QLEE7MdG+HCSgxU9hG2csedf+GllK+I
 y32M5PiSI8xCY1AeeZxYagz1mEdBD2bc522R0rUyWv2kg9wSSdHLRfLFUsWar4hYyhsC
 nptFxR2PmtXf9ZsHdAKvT3E+CdHrqXNWmY/lYc8Hr9pqtLNBwH1e2m/TUi6yI1c8U3Nq
 1B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763581019; x=1764185819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7WF8ImQWZDIpLHMaA0pPvtG3C2qF+ifFTWB2DA+A4c=;
 b=KRB5KhaC3FbcE7dDtUtMdZKpFeujIsDiXdE8wdxUm6fpHEYNs7z4vCRTaa+r2K229L
 KkISI0w5Kam90eNRF5myVfRk93KOOj9hxqHdq65bMnD3380DKJjKlA470j4FkKbEH6N2
 dB0KgaF0Dtftkp34GA8Sb5x8qmnfbPuap+iJTunRNOo9VI147dRyD7AXd0EITQEpUsPI
 WexIUkN+eIQ+S8fs9O3FCflPR+kDilX0JXqO6dhq9N9JNLxk1n6LipDDr5Fjwk68oZ5q
 FHXqclXfj19LauljYwDwXOgobzXMiPPrLTeTXOcJpl1H8Jw2plye8ukoJ0oRM4TmRhHC
 DidA==
X-Gm-Message-State: AOJu0YwMOa9B25NhD+5bMT6gU04xVIHxHQbLWzaa2FZLpnKVM/Do8r1y
 PFUCjwBNkabMMqf2dkZrZdeDTWp5qKnqruj2ZcTHDPa0O56wqz1hqR9TcZWq3VPzf7tt+szut7G
 QRWDCXsJA8cIexsrQWirkFZdZ3SYkR+zRtfya/ICjdoWoQNP+i/bl14WqhXAXUZ9VDlf2S/RcQ8
 TRWgyABwmCKfj3jqvOPimD6nyWz+1OPwY=
X-Gm-Gg: ASbGnct6nYYXLDfSxNHB1LKDFtYESkW5j8HBVPU9BUZedI1kQ/uz2eDI7674Vp6vae8
 RHa/YimhlPn5+n+z/2Pyib0i5/LMTYFVW3yb5MSxgNU6O4lC8KzIGrO6T+NJtWzAXuypAvm9pHs
 VnQFUU1nI7dp9oeDqdN2lm+ZHj0yIFMLMtwYRQluOsYCh7tb/SplRPO1urJJHXmpKVKs13n6GkI
 lwF60GF++DGPPT+T4uUOsAZo9Vd+lPFeUQrjNxoNv5TQgY6NnJnis7dHEOIJ06j/dhp/oU=
X-Received: by 2002:a05:600c:628f:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-477b8357dd3mr6517205e9.0.1763581019447; 
 Wed, 19 Nov 2025 11:36:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD+bjbxE1xstP/r9p4Q6yU8hTsBEzpaReR7ZByVIRGp4ge7XuRx2PYSWhapA44NnUPOsv/McOH5E/p7vwbBO4=
X-Received: by 2002:a05:600c:628f:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-477b8357dd3mr6516845e9.0.1763581018866; Wed, 19 Nov 2025
 11:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20251119181821.154833-1-stefanha@redhat.com>
 <20251119181821.154833-3-stefanha@redhat.com>
In-Reply-To: <20251119181821.154833-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 20:36:49 +0100
X-Gm-Features: AWmQ_bn21LkPAFOGTgO7m1ZAcV2oGy16UaGh_fUYMIgQPu5y-r9Ghro-peokgPc
Message-ID: <CABgObfbLk7gMsLUk-CGx_eQ7q87JBwSzDkgjH9c71bK_VC+BXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracetool: add Rust DTrace/SystemTap SDT support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mads Ynddal <mads@ynddal.dk>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>,
 Josh Stone <jistone@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002992c50643f7b450"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000002992c50643f7b450
Content-Type: text/plain; charset="UTF-8"

Il mer 19 nov 2025, 19:18 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Implement DTrace/SystemTap SDT by emitting the following:
> - The probe crate's probe!() macro is used to emit a DTrace/SystemTap
>   SDT probe.
> - Every trace event gets a corresponding trace_<name>_enabled() -> bool
>   generated function that Rust code can use to avoid expensive
>   computation when a trace event is disabled. This API works for other
>   trace backends too.
>
> `#[allow(dead_code)]` additions are necessary for QEMU's dstate in
> generated trace-<dir>.rs files since they are unused by the dtrace
> backend. `./configure --enable-trace-backends=` can enable multiple
> backends, so keep it simple and just silence the warning instead of
> trying to detect the condition when generating the dstate code can be
> skipped.
>
> The tracetool tests are updated. Take a look at
> tests/tracetool/dtrace.rs to see what the new generated code looks like.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> I'm not sure if Cargo.toml, Cargo.lock, and meson.build are in
> sync/consistent, but it builds successfully. I find the Rust build
> system integration confusing because I'm not an expert in cargo or
> meson. Please review the build system changes carefully.
>

The only change I'd make, is to re-export probe::probe from the trace
crate, like it already does for libc. This way you don't need the change to
rust/hw/char/pl011/meson.build.

Otherwise it works great, and it's nice that we can reuse the C semaphore
to avoid changes to the probe crate.

Hopefully within a few months all the subprojects will not need anymore the
current boilerplate.

Paolo

---
>  rust/Cargo.lock                     |  6 +++
>  rust/hw/char/pl011/meson.build      |  1 +
>  rust/hw/timer/hpet/meson.build      |  1 +
>  rust/trace/Cargo.toml               |  1 +
>  rust/trace/meson.build              |  2 +-
>  scripts/tracetool/__init__.py       |  1 +
>  scripts/tracetool/backend/dtrace.py | 32 ++++++++++++++
>  scripts/tracetool/format/rs.py      | 27 ++++++++++--
>  tests/tracetool/dtrace.rs           | 65 +++++++++++++++++++++++++++++
>  tests/tracetool/ftrace.rs           | 21 ++++++++++
>  tests/tracetool/log.rs              | 21 ++++++++++
>  tests/tracetool/simple.rs           | 21 ++++++++++
>  tests/tracetool/syslog.rs           | 21 ++++++++++
>  tests/tracetool/tracetool-test.py   |  2 +-
>  14 files changed, 216 insertions(+), 6 deletions(-)
>  create mode 100644 tests/tracetool/dtrace.rs
>
> diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> index 0c1df625df..5bd768cb0d 100644
> --- a/rust/Cargo.lock
> +++ b/rust/Cargo.lock
> @@ -144,6 +144,7 @@ dependencies = [
>   "migration",
>   "qom",
>   "system",
> + "trace",
>   "util",
>  ]
>
> @@ -229,6 +230,10 @@ dependencies = [
>   "util",
>  ]
>
> +[[package]]
> +name = "probe"
> +version = "0.5.2"
> +
>  [[package]]
>  name = "proc-macro-error"
>  version = "1.0.4"
> @@ -429,6 +434,7 @@ name = "trace"
>  version = "0.1.0"
>  dependencies = [
>   "libc",
> + "probe",
>  ]
>
>  [[package]]
> diff --git a/rust/hw/char/pl011/meson.build
> b/rust/hw/char/pl011/meson.build
> index 33b91f2191..5b6ea274a2 100644
> --- a/rust/hw/char/pl011/meson.build
> +++ b/rust/hw/char/pl011/meson.build
> @@ -37,6 +37,7 @@ _libpl011_rs = static_library(
>      util_rs,
>      migration_rs,
>      bql_rs,
> +    probe_rs,
>      qom_rs,
>      chardev_rs,
>      system_rs,
> diff --git a/rust/hw/timer/hpet/meson.build
> b/rust/hw/timer/hpet/meson.build
> index 465995bb5a..4e95754b20 100644
> --- a/rust/hw/timer/hpet/meson.build
> +++ b/rust/hw/timer/hpet/meson.build
> @@ -8,6 +8,7 @@ _libhpet_rs = static_library(
>      util_rs,
>      migration_rs,
>      bql_rs,
> +    probe_rs,
>      qom_rs,
>      system_rs,
>      hwcore_rs,
> diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
> index fc81bce580..11e27f8d28 100644
> --- a/rust/trace/Cargo.toml
> +++ b/rust/trace/Cargo.toml
> @@ -14,6 +14,7 @@ rust-version.workspace = true
>
>  [dependencies]
>  libc = { workspace = true }
> +probe = "0.5"
>
>  [lints]
>  workspace = true
> diff --git a/rust/trace/meson.build b/rust/trace/meson.build
> index adca57e550..cf6b0355a8 100644
> --- a/rust/trace/meson.build
> +++ b/rust/trace/meson.build
> @@ -12,7 +12,7 @@ _trace_rs = static_library(
>    lib_rs,
>    trace_rs_targets,         # List of generated `.rs` custom targets
>    override_options: ['rust_std=2021', 'build.rust_std=2021'],
> -  dependencies: [libc_rs],
> +  dependencies: [libc_rs, probe_rs],
>    rust_abi: 'rust',
>  )
>
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 74062d21a7..61ba6f1ba8 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -461,6 +461,7 @@ def formats(self):
>
>      QEMU_TRACE               = "trace_%(name)s"
>      QEMU_TRACE_TCG           = QEMU_TRACE + "_tcg"
> +    QEMU_RUST_DSTATE         = "trace_%(name)s_enabled"
>      QEMU_DSTATE              = "_TRACE_%(NAME)s_DSTATE"
>      QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
>      QEMU_EVENT               = "_TRACE_%(NAME)s_EVENT"
> diff --git a/scripts/tracetool/backend/dtrace.py
> b/scripts/tracetool/backend/dtrace.py
> index b4af403025..548e228c81 100644
> --- a/scripts/tracetool/backend/dtrace.py
> +++ b/scripts/tracetool/backend/dtrace.py
> @@ -70,3 +70,35 @@ def generate_h(event, group):
>  def generate_h_backend_dstate(event, group):
>      out('    QEMU_%(uppername)s_ENABLED() || \\',
>          uppername=event.name.upper())
> +
> +
> +def generate_rs_begin(events, group):
> +    out('use probe::probe;',
> +        'use std::cell::UnsafeCell;',
> +        '',
> +        'extern "C" {')
> +    # These are the Rust declarations of the .probes section semaphores
> +    # generated by dtrace(1) in its .o file output.
> +    for e in events:
> +        if 'disable' in e.properties:
> +            continue
> +        out('    #[allow(dead_code)]',
> +            f'    static qemu_{e.name}_semaphore: UnsafeCell<u16>;')
> +    out('}',
> +        '')
> +
> +
> +def generate_rs(event, group):
> +    args = event.args.rust_call_extern()
> +    if args:
> +        args = ', ' + args
> +
> +    out(f'    probe!(qemu, {event.name}{args});')
> +
> +
> +def generate_rs_backend_dstate(event, group):
> +    # Rust does not have access to the <provider>_<name>_ENABLED() macro
> from
> +    # the dtrace(1) generated .h file. Use the matching semaphore
> declarations
> +    # generated by generate_rs_begin() instead.
> +    out('    (unsafe {qemu_%(n)s_semaphore.get().read_volatile()}) != 0
> ||',
> +        n=event.name)
> diff --git a/scripts/tracetool/format/rs.py
> b/scripts/tracetool/format/rs.py
> index 32ac4e5977..7d9af7edfe 100644
> --- a/scripts/tracetool/format/rs.py
> +++ b/scripts/tracetool/format/rs.py
> @@ -24,25 +24,43 @@ def generate(events, backend, group):
>          '#[allow(unused_imports)]',
>          'use util::bindings;',
>          '',
> +        '#[allow(dead_code)]',
>          '#[inline(always)]',
>          'fn trace_event_state_is_enabled(dstate: u16) -> bool {',
>          '    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0',
>          '}',
>          '',
>          'extern "C" {',
> +        '    #[allow(dead_code)]',
>          '    static mut trace_events_enabled_count: u32;',
>          '}',)
>
>      out('extern "C" {')
>
>      for e in events:
> -        out('    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
> -    out('}')
> +        out('    #[allow(dead_code)]',
> +            '    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
> +    out('}',
> +        '')
>
>      backend.generate_begin(events, group)
>
>      for e in events:
> -        out('',
> +        out('#[inline(always)]',
> +            '#[allow(dead_code)]',
> +            'pub fn %(api)s() -> bool',
> +            '{',
> +            api=e.api(e.QEMU_RUST_DSTATE))
> +
> +        if "disable" not in e.properties:
> +            backend.generate_backend_dstate(e, group)
> +            if backend.check_trace_event_get_state:
> +                out('    trace_event_state_is_enabled(unsafe {
> _%(event_id)s_DSTATE}) ||',
> +                    event_id = 'TRACE_' + e.name.upper())
> +
> +        out('    false',
> +            '}',
> +            '',
>              '#[inline(always)]',
>              '#[allow(dead_code)]',
>              'pub fn %(api)s(%(args)s)',
> @@ -59,6 +77,7 @@ def generate(events, backend, group):
>                      api=e.api())
>                  backend.generate(e, group,
> check_trace_event_get_state=True)
>                  out('    }')
> -        out('}')
> +        out('}',
> +            '')
>
>      backend.generate_end(events, group)
> diff --git a/tests/tracetool/dtrace.rs b/tests/tracetool/dtrace.rs
> new file mode 100644
> index 0000000000..233c2ef159
> --- /dev/null
> +++ b/tests/tracetool/dtrace.rs
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// This file is @generated by tracetool, do not edit.
> +
> +#[allow(unused_imports)]
> +use std::ffi::c_char;
> +#[allow(unused_imports)]
> +use util::bindings;
> +
> +#[allow(dead_code)]
> +#[inline(always)]
> +fn trace_event_state_is_enabled(dstate: u16) -> bool {
> +    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
> +}
> +
> +extern "C" {
> +    #[allow(dead_code)]
> +    static mut trace_events_enabled_count: u32;
> +}
> +extern "C" {
> +    #[allow(dead_code)]
> +    static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    #[allow(dead_code)]
> +    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
> +}
> +
> +use probe::probe;
> +use std::cell::UnsafeCell;
> +
> +extern "C" {
> +    #[allow(dead_code)]
> +    static qemu_test_blah_semaphore: UnsafeCell<u16>;
> +    #[allow(dead_code)]
> +    static qemu_test_wibble_semaphore: UnsafeCell<u16>;
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah_enabled() -> bool
> +{
> +    (unsafe {qemu_test_blah_semaphore.get().read_volatile()}) != 0 ||
> +    false
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> +{
> +    probe!(qemu, test_blah, _context, _filename.as_ptr());
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble_enabled() -> bool
> +{
> +    (unsafe {qemu_test_wibble_semaphore.get().read_volatile()}) != 0 ||
> +    false
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> +{
> +    probe!(qemu, test_wibble, _context, _value);
> +}
> +
> diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
> index 07b9259cf2..34f6600490 100644
> --- a/tests/tracetool/ftrace.rs
> +++ b/tests/tracetool/ftrace.rs
> @@ -6,19 +6,31 @@
>  #[allow(unused_imports)]
>  use util::bindings;
>
> +#[allow(dead_code)]
>  #[inline(always)]
>  fn trace_event_state_is_enabled(dstate: u16) -> bool {
>      (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
>  }
>
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut trace_events_enabled_count: u32;
>  }
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> @@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename:
> &std::ffi::CStr)
>      }
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> @@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value:
> std::ffi::c_int)
>          unsafe {bindings::ftrace_write(format_string.as_ptr() as *const
> c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
>      }
>  }
> +
> diff --git a/tests/tracetool/log.rs b/tests/tracetool/log.rs
> index c191895c8f..770758611d 100644
> --- a/tests/tracetool/log.rs
> +++ b/tests/tracetool/log.rs
> @@ -6,19 +6,31 @@
>  #[allow(unused_imports)]
>  use util::bindings;
>
> +#[allow(dead_code)]
>  #[inline(always)]
>  fn trace_event_state_is_enabled(dstate: u16) -> bool {
>      (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
>  }
>
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut trace_events_enabled_count: u32;
>  }
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> @@ -31,6 +43,14 @@ pub fn trace_test_blah(_context: *mut (), _filename:
> &std::ffi::CStr)
>      }
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> @@ -42,3 +62,4 @@ pub fn trace_test_wibble(_context: *mut (), _value:
> std::ffi::c_int)
>          }
>      }
>  }
> +
> diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
> index 9ee39495e3..92f896ef17 100644
> --- a/tests/tracetool/simple.rs
> +++ b/tests/tracetool/simple.rs
> @@ -6,19 +6,31 @@
>  #[allow(unused_imports)]
>  use util::bindings;
>
> +#[allow(dead_code)]
>  #[inline(always)]
>  fn trace_event_state_is_enabled(dstate: u16) -> bool {
>      (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
>  }
>
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut trace_events_enabled_count: u32;
>  }
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> @@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename:
> &std::ffi::CStr)
>      }
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> @@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value:
> std::ffi::c_int)
>          unsafe { _simple_trace_test_wibble(_context, _value); }
>      }
>  }
> +
> diff --git a/tests/tracetool/syslog.rs b/tests/tracetool/syslog.rs
> index 9d3675a0b5..378d03d34b 100644
> --- a/tests/tracetool/syslog.rs
> +++ b/tests/tracetool/syslog.rs
> @@ -6,19 +6,31 @@
>  #[allow(unused_imports)]
>  use util::bindings;
>
> +#[allow(dead_code)]
>  #[inline(always)]
>  fn trace_event_state_is_enabled(dstate: u16) -> bool {
>      (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
>  }
>
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut trace_events_enabled_count: u32;
>  }
>  extern "C" {
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    #[allow(dead_code)]
>      static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> @@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename:
> &std::ffi::CStr)
>      }
>  }
>
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble_enabled() -> bool
> +{
> +    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
> +    false
> +}
> +
>  #[inline(always)]
>  #[allow(dead_code)]
>  pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> @@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value:
> std::ffi::c_int)
>          unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr()
> as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int
> */);}
>      }
>  }
> +
> diff --git a/tests/tracetool/tracetool-test.py
> b/tests/tracetool/tracetool-test.py
> index 786083ad7f..30006a9919 100755
> --- a/tests/tracetool/tracetool-test.py
> +++ b/tests/tracetool/tracetool-test.py
> @@ -14,7 +14,7 @@ def get_formats(backend):
>          "c",
>          "h",
>      ]
> -    if backend in {"ftrace", "log", "simple", "syslog"}:
> +    if backend in {"dtrace", "ftrace", "log", "simple", "syslog"}:
>          formats += ["rs"]
>      if backend == "dtrace":
>          formats += [
> --
> 2.51.1
>
>

--0000000000002992c50643f7b450
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 19 nov 2025, 19:18 Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Implement DTrace/SystemTap SDT by emitting the following:<br>
- The probe crate&#39;s probe!() macro is used to emit a DTrace/SystemTap<b=
r>
=C2=A0 SDT probe.<br>
- Every trace event gets a corresponding trace_&lt;name&gt;_enabled() -&gt;=
 bool<br>
=C2=A0 generated function that Rust code can use to avoid expensive<br>
=C2=A0 computation when a trace event is disabled. This API works for other=
<br>
=C2=A0 trace backends too.<br>
<br>
`#[allow(dead_code)]` additions are necessary for QEMU&#39;s dstate in<br>
generated trace-&lt;dir&gt;.rs files since they are unused by the dtrace<br=
>
backend. `./configure --enable-trace-backends=3D` can enable multiple<br>
backends, so keep it simple and just silence the warning instead of<br>
trying to detect the condition when generating the dstate code can be<br>
skipped.<br>
<br>
The tracetool tests are updated. Take a look at<br>
tests/tracetool/<a href=3D"http://dtrace.rs" rel=3D"noreferrer noreferrer" =
target=3D"_blank">dtrace.rs</a> to see what the new generated code looks li=
ke.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
---<br>
I&#39;m not sure if Cargo.toml, Cargo.lock, and meson.build are in<br>
sync/consistent, but it builds successfully. I find the Rust build<br>
system integration confusing because I&#39;m not an expert in cargo or<br>
meson. Please review the build system changes carefully.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The only change I&#=
39;d make, is to re-export probe::probe from the trace crate, like it alrea=
dy does for libc. This way you don&#39;t need the change to rust/hw/char/pl=
011/meson.build.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Otherwi=
se it works great, and it&#39;s nice that we can reuse the C semaphore to a=
void changes to the probe crate.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Hopefully within a few months all the subprojects will not need a=
nymore the current boilerplate.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
---<br>
=C2=A0rust/Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++<br>
=C2=A0rust/hw/char/pl011/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0rust/hw/timer/hpet/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0rust/trace/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 1 +<br>
=C2=A0rust/trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0scripts/tracetool/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<b=
r>
=C2=A0scripts/tracetool/backend/dtrace.py | 32 ++++++++++++++<br>
=C2=A0scripts/tracetool/format/rs.py=C2=A0 =C2=A0 =C2=A0 | 27 ++++++++++--<=
br>
=C2=A0tests/tracetool/<a href=3D"http://dtrace.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">dtrace.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 65 +++++++++++++++++++++++++++++<br>
=C2=A0tests/tracetool/<a href=3D"http://ftrace.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">ftrace.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 21 ++++++++++<br>
=C2=A0tests/tracetool/<a href=3D"http://log.rs" rel=3D"noreferrer noreferre=
r" target=3D"_blank">log.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 21 ++++++++++<br>
=C2=A0tests/tracetool/<a href=3D"http://simple.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">simple.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 21 ++++++++++<br>
=C2=A0tests/tracetool/<a href=3D"http://syslog.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">syslog.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 21 ++++++++++<br>
=C2=A0tests/tracetool/tracetool-test.py=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A014 files changed, 216 insertions(+), 6 deletions(-)<br>
=C2=A0create mode 100644 tests/tracetool/<a href=3D"http://dtrace.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">dtrace.rs</a><br>
<br>
diff --git a/rust/Cargo.lock b/rust/Cargo.lock<br>
index 0c1df625df..5bd768cb0d 100644<br>
--- a/rust/Cargo.lock<br>
+++ b/rust/Cargo.lock<br>
@@ -144,6 +144,7 @@ dependencies =3D [<br>
=C2=A0 &quot;migration&quot;,<br>
=C2=A0 &quot;qom&quot;,<br>
=C2=A0 &quot;system&quot;,<br>
+ &quot;trace&quot;,<br>
=C2=A0 &quot;util&quot;,<br>
=C2=A0]<br>
<br>
@@ -229,6 +230,10 @@ dependencies =3D [<br>
=C2=A0 &quot;util&quot;,<br>
=C2=A0]<br>
<br>
+[[package]]<br>
+name =3D &quot;probe&quot;<br>
+version =3D &quot;0.5.2&quot;<br>
+<br>
=C2=A0[[package]]<br>
=C2=A0name =3D &quot;proc-macro-error&quot;<br>
=C2=A0version =3D &quot;1.0.4&quot;<br>
@@ -429,6 +434,7 @@ name =3D &quot;trace&quot;<br>
=C2=A0version =3D &quot;0.1.0&quot;<br>
=C2=A0dependencies =3D [<br>
=C2=A0 &quot;libc&quot;,<br>
+ &quot;probe&quot;,<br>
=C2=A0]<br>
<br>
=C2=A0[[package]]<br>
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.buil=
d<br>
index 33b91f2191..5b6ea274a2 100644<br>
--- a/rust/hw/char/pl011/meson.build<br>
+++ b/rust/hw/char/pl011/meson.build<br>
@@ -37,6 +37,7 @@ _libpl011_rs =3D static_library(<br>
=C2=A0 =C2=A0 =C2=A0util_rs,<br>
=C2=A0 =C2=A0 =C2=A0migration_rs,<br>
=C2=A0 =C2=A0 =C2=A0bql_rs,<br>
+=C2=A0 =C2=A0 probe_rs,<br>
=C2=A0 =C2=A0 =C2=A0qom_rs,<br>
=C2=A0 =C2=A0 =C2=A0chardev_rs,<br>
=C2=A0 =C2=A0 =C2=A0system_rs,<br>
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.buil=
d<br>
index 465995bb5a..4e95754b20 100644<br>
--- a/rust/hw/timer/hpet/meson.build<br>
+++ b/rust/hw/timer/hpet/meson.build<br>
@@ -8,6 +8,7 @@ _libhpet_rs =3D static_library(<br>
=C2=A0 =C2=A0 =C2=A0util_rs,<br>
=C2=A0 =C2=A0 =C2=A0migration_rs,<br>
=C2=A0 =C2=A0 =C2=A0bql_rs,<br>
+=C2=A0 =C2=A0 probe_rs,<br>
=C2=A0 =C2=A0 =C2=A0qom_rs,<br>
=C2=A0 =C2=A0 =C2=A0system_rs,<br>
=C2=A0 =C2=A0 =C2=A0hwcore_rs,<br>
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml<br>
index fc81bce580..11e27f8d28 100644<br>
--- a/rust/trace/Cargo.toml<br>
+++ b/rust/trace/Cargo.toml<br>
@@ -14,6 +14,7 @@ rust-version.workspace =3D true<br>
<br>
=C2=A0[dependencies]<br>
=C2=A0libc =3D { workspace =3D true }<br>
+probe =3D &quot;0.5&quot;<br>
<br>
=C2=A0[lints]<br>
=C2=A0workspace =3D true<br>
diff --git a/rust/trace/meson.build b/rust/trace/meson.build<br>
index adca57e550..cf6b0355a8 100644<br>
--- a/rust/trace/meson.build<br>
+++ b/rust/trace/meson.build<br>
@@ -12,7 +12,7 @@ _trace_rs =3D static_library(<br>
=C2=A0 =C2=A0lib_rs,<br>
=C2=A0 =C2=A0trace_rs_targets,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# List of g=
enerated `.rs` custom targets<br>
=C2=A0 =C2=A0override_options: [&#39;rust_std=3D2021&#39;, &#39;build.rust_=
std=3D2021&#39;],<br>
-=C2=A0 dependencies: [libc_rs],<br>
+=C2=A0 dependencies: [libc_rs, probe_rs],<br>
=C2=A0 =C2=A0rust_abi: &#39;rust&#39;,<br>
=C2=A0)<br>
<br>
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py<=
br>
index 74062d21a7..61ba6f1ba8 100644<br>
--- a/scripts/tracetool/__init__.py<br>
+++ b/scripts/tracetool/__init__.py<br>
@@ -461,6 +461,7 @@ def formats(self):<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMU_TRACE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D &quot;trace_%(name)s&quot;<br>
=C2=A0 =C2=A0 =C2=A0QEMU_TRACE_TCG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D QEMU_TRACE + &quot;_tcg&quot;<br>
+=C2=A0 =C2=A0 QEMU_RUST_DSTATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;=
trace_%(name)s_enabled&quot;<br>
=C2=A0 =C2=A0 =C2=A0QEMU_DSTATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D &quot;_TRACE_%(NAME)s_DSTATE&quot;<br>
=C2=A0 =C2=A0 =C2=A0QEMU_BACKEND_DSTATE=C2=A0 =C2=A0 =C2=A0 =3D &quot;TRACE=
_%(NAME)s_BACKEND_DSTATE&quot;<br>
=C2=A0 =C2=A0 =C2=A0QEMU_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D &quot;_TRACE_%(NAME)s_EVENT&quot;<br>
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backen=
d/dtrace.py<br>
index b4af403025..548e228c81 100644<br>
--- a/scripts/tracetool/backend/dtrace.py<br>
+++ b/scripts/tracetool/backend/dtrace.py<br>
@@ -70,3 +70,35 @@ def generate_h(event, group):<br>
=C2=A0def generate_h_backend_dstate(event, group):<br>
=C2=A0 =C2=A0 =C2=A0out(&#39;=C2=A0 =C2=A0 QEMU_%(uppername)s_ENABLED() || =
\\&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uppername=3Devent.name.upper())<br>
+<br>
+<br>
+def generate_rs_begin(events, group):<br>
+=C2=A0 =C2=A0 out(&#39;use probe::probe;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;use std::cell::UnsafeCell;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;extern &quot;C&quot; {&#39;)<br>
+=C2=A0 =C2=A0 # These are the Rust declarations of the .probes section sem=
aphores<br>
+=C2=A0 =C2=A0 # generated by dtrace(1) in its .o file output.<br>
+=C2=A0 =C2=A0 for e in events:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;disable&#39; in e.properties:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 #[allow(dead_code)]&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&#39;=C2=A0 =C2=A0 static qemu_=
{<a href=3D"http://e.name" rel=3D"noreferrer noreferrer" target=3D"_blank">=
e.name</a>}_semaphore: UnsafeCell&lt;u16&gt;;&#39;)<br>
+=C2=A0 =C2=A0 out(&#39;}&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;)<br>
+<br>
+<br>
+def generate_rs(event, group):<br>
+=C2=A0 =C2=A0 args =3D event.args.rust_call_extern()<br>
+=C2=A0 =C2=A0 if args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args =3D &#39;, &#39; + args<br>
+<br>
+=C2=A0 =C2=A0 out(f&#39;=C2=A0 =C2=A0 probe!(qemu, {<a href=3D"http://even=
t.name" rel=3D"noreferrer noreferrer" target=3D"_blank">event.name</a>}{arg=
s});&#39;)<br>
+<br>
+<br>
+def generate_rs_backend_dstate(event, group):<br>
+=C2=A0 =C2=A0 # Rust does not have access to the &lt;provider&gt;_&lt;name=
&gt;_ENABLED() macro from<br>
+=C2=A0 =C2=A0 # the dtrace(1) generated .h file. Use the matching semaphor=
e declarations<br>
+=C2=A0 =C2=A0 # generated by generate_rs_begin() instead.<br>
+=C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 (unsafe {qemu_%(n)s_semaphore.get().r=
ead_volatile()}) !=3D 0 ||&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n=3D<a href=3D"http://event.name" rel=3D"noref=
errer noreferrer" target=3D"_blank">event.name</a>)<br>
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.p=
y<br>
index 32ac4e5977..7d9af7edfe 100644<br>
--- a/scripts/tracetool/format/rs.py<br>
+++ b/scripts/tracetool/format/rs.py<br>
@@ -24,25 +24,43 @@ def generate(events, backend, group):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;#[allow(unused_imports)]&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;use util::bindings;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;#[allow(dead_code)]&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;#[inline(always)]&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;fn trace_event_state_is_enabled(dsta=
te: u16) -&gt; bool {&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=C2=A0 =C2=A0 (unsafe { trace_events=
_enabled_count }) !=3D 0 &amp;&amp; dstate !=3D 0&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;}&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;extern &quot;C&quot; {&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 #[allow(dead_code)]&#39;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=C2=A0 =C2=A0 static mut trace_event=
s_enabled_count: u32;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;}&#39;,)<br>
<br>
=C2=A0 =C2=A0 =C2=A0out(&#39;extern &quot;C&quot; {&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for e in events:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 static mut %s: u16;&#39=
; % e.api(e.QEMU_DSTATE))<br>
-=C2=A0 =C2=A0 out(&#39;}&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 #[allow(dead_code)]&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 static mut %s=
: u16;&#39; % e.api(e.QEMU_DSTATE))<br>
+=C2=A0 =C2=A0 out(&#39;}&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend.generate_begin(events, group)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for e in events:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;#[inline(always)]&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;#[allow(dead_code)]&#39;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pub fn %(api)s() -&gt; bool=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;{&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3De.api(e.QEMU_RUST_DSTATE))=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;disable&quot; not in e.properties:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backend.generate_backend_dstate(=
e, group)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if backend.check_trace_event_get=
_state:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =
=C2=A0 trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) ||&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 even=
t_id =3D &#39;TRACE_&#39; + e.name.upper())<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 false&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;}&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;#[inline(always)]&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;#[allow(dead_code)]&#3=
9;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;pub fn %(api)s(%(args)=
s)&#39;,<br>
@@ -59,6 +77,7 @@ def generate(events, backend, group):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0api=3De.api())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend.gener=
ate(e, group, check_trace_event_get_state=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out(&#39;=C2=
=A0 =C2=A0 }&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;}&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;}&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend.generate_end(events, group)<br>
diff --git a/tests/tracetool/<a href=3D"http://dtrace.rs" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">dtrace.rs</a> b/tests/tracetool/<a href=3D"h=
ttp://dtrace.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">dtrace.rs<=
/a><br>
new file mode 100644<br>
index 0000000000..233c2ef159<br>
--- /dev/null<br>
+++ b/tests/tracetool/<a href=3D"http://dtrace.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">dtrace.rs</a><br>
@@ -0,0 +1,65 @@<br>
+// SPDX-License-Identifier: GPL-2.0-or-later<br>
+// This file is @generated by tracetool, do not edit.<br>
+<br>
+#[allow(unused_imports)]<br>
+use std::ffi::c_char;<br>
+#[allow(unused_imports)]<br>
+use util::bindings;<br>
+<br>
+#[allow(dead_code)]<br>
+#[inline(always)]<br>
+fn trace_event_state_is_enabled(dstate: u16) -&gt; bool {<br>
+=C2=A0 =C2=A0 (unsafe { trace_events_enabled_count }) !=3D 0 &amp;&amp; ds=
tate !=3D 0<br>
+}<br>
+<br>
+extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
+=C2=A0 =C2=A0 static mut trace_events_enabled_count: u32;<br>
+}<br>
+extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
+=C2=A0 =C2=A0 static mut _TRACE_TEST_BLAH_DSTATE: u16;<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
+=C2=A0 =C2=A0 static mut _TRACE_TEST_WIBBLE_DSTATE: u16;<br>
+}<br>
+<br>
+use probe::probe;<br>
+use std::cell::UnsafeCell;<br>
+<br>
+extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
+=C2=A0 =C2=A0 static qemu_test_blah_semaphore: UnsafeCell&lt;u16&gt;;<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
+=C2=A0 =C2=A0 static qemu_test_wibble_semaphore: UnsafeCell&lt;u16&gt;;<br=
>
+}<br>
+<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_blah_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 (unsafe {qemu_test_blah_semaphore.get().read_volatile()}) !=
=3D 0 ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_blah(_context: *mut (), _filename: &amp;std::ffi::CStr)<=
br>
+{<br>
+=C2=A0 =C2=A0 probe!(qemu, test_blah, _context, _filename.as_ptr());<br>
+}<br>
+<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_wibble_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 (unsafe {qemu_test_wibble_semaphore.get().read_volatile()}) =
!=3D 0 ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)<br>
+{<br>
+=C2=A0 =C2=A0 probe!(qemu, test_wibble, _context, _value);<br>
+}<br>
+<br>
diff --git a/tests/tracetool/<a href=3D"http://ftrace.rs" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">ftrace.rs</a> b/tests/tracetool/<a href=3D"h=
ttp://ftrace.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">ftrace.rs<=
/a><br>
index 07b9259cf2..34f6600490 100644<br>
--- a/tests/tracetool/<a href=3D"http://ftrace.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">ftrace.rs</a><br>
+++ b/tests/tracetool/<a href=3D"http://ftrace.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">ftrace.rs</a><br>
@@ -6,19 +6,31 @@<br>
=C2=A0#[allow(unused_imports)]<br>
=C2=A0use util::bindings;<br>
<br>
+#[allow(dead_code)]<br>
=C2=A0#[inline(always)]<br>
=C2=A0fn trace_event_state_is_enabled(dstate: u16) -&gt; bool {<br>
=C2=A0 =C2=A0 =C2=A0(unsafe { trace_events_enabled_count }) !=3D 0 &amp;&am=
p; dstate !=3D 0<br>
=C2=A0}<br>
<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut trace_events_enabled_count: u32;<br>
=C2=A0}<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_BLAH_DSTATE: u16;<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_WIBBLE_DSTATE: u16;<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_blah_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTAT=
E}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_blah(_context: *mut (), _filename: &amp;std::ffi::C=
Str)<br>
@@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &am=
p;std::ffi::CStr)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_wibble_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DST=
ATE}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)<=
br>
@@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::=
ffi::c_int)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe {bindings::ftrace_write(format_str=
ing.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std:=
:ffi::c_int */);}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
+<br>
diff --git a/tests/tracetool/<a href=3D"http://log.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">log.rs</a> b/tests/tracetool/<a href=3D"http://=
log.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">log.rs</a><br>
index c191895c8f..770758611d 100644<br>
--- a/tests/tracetool/<a href=3D"http://log.rs" rel=3D"noreferrer noreferre=
r" target=3D"_blank">log.rs</a><br>
+++ b/tests/tracetool/<a href=3D"http://log.rs" rel=3D"noreferrer noreferre=
r" target=3D"_blank">log.rs</a><br>
@@ -6,19 +6,31 @@<br>
=C2=A0#[allow(unused_imports)]<br>
=C2=A0use util::bindings;<br>
<br>
+#[allow(dead_code)]<br>
=C2=A0#[inline(always)]<br>
=C2=A0fn trace_event_state_is_enabled(dstate: u16) -&gt; bool {<br>
=C2=A0 =C2=A0 =C2=A0(unsafe { trace_events_enabled_count }) !=3D 0 &amp;&am=
p; dstate !=3D 0<br>
=C2=A0}<br>
<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut trace_events_enabled_count: u32;<br>
=C2=A0}<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_BLAH_DSTATE: u16;<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_WIBBLE_DSTATE: u16;<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_blah_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTAT=
E}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_blah(_context: *mut (), _filename: &amp;std::ffi::C=
Str)<br>
@@ -31,6 +43,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &am=
p;std::ffi::CStr)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_wibble_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DST=
ATE}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)<=
br>
@@ -42,3 +62,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::=
ffi::c_int)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
+<br>
diff --git a/tests/tracetool/<a href=3D"http://simple.rs" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">simple.rs</a> b/tests/tracetool/<a href=3D"h=
ttp://simple.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">simple.rs<=
/a><br>
index 9ee39495e3..92f896ef17 100644<br>
--- a/tests/tracetool/<a href=3D"http://simple.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">simple.rs</a><br>
+++ b/tests/tracetool/<a href=3D"http://simple.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">simple.rs</a><br>
@@ -6,19 +6,31 @@<br>
=C2=A0#[allow(unused_imports)]<br>
=C2=A0use util::bindings;<br>
<br>
+#[allow(dead_code)]<br>
=C2=A0#[inline(always)]<br>
=C2=A0fn trace_event_state_is_enabled(dstate: u16) -&gt; bool {<br>
=C2=A0 =C2=A0 =C2=A0(unsafe { trace_events_enabled_count }) !=3D 0 &amp;&am=
p; dstate !=3D 0<br>
=C2=A0}<br>
<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut trace_events_enabled_count: u32;<br>
=C2=A0}<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_BLAH_DSTATE: u16;<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_WIBBLE_DSTATE: u16;<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_blah_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTAT=
E}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_blah(_context: *mut (), _filename: &amp;std::ffi::C=
Str)<br>
@@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &am=
p;std::ffi::CStr)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_wibble_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DST=
ATE}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)<=
br>
@@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::=
ffi::c_int)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe { _simple_trace_test_wibble(_conte=
xt, _value); }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
+<br>
diff --git a/tests/tracetool/<a href=3D"http://syslog.rs" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">syslog.rs</a> b/tests/tracetool/<a href=3D"h=
ttp://syslog.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">syslog.rs<=
/a><br>
index 9d3675a0b5..378d03d34b 100644<br>
--- a/tests/tracetool/<a href=3D"http://syslog.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">syslog.rs</a><br>
+++ b/tests/tracetool/<a href=3D"http://syslog.rs" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">syslog.rs</a><br>
@@ -6,19 +6,31 @@<br>
=C2=A0#[allow(unused_imports)]<br>
=C2=A0use util::bindings;<br>
<br>
+#[allow(dead_code)]<br>
=C2=A0#[inline(always)]<br>
=C2=A0fn trace_event_state_is_enabled(dstate: u16) -&gt; bool {<br>
=C2=A0 =C2=A0 =C2=A0(unsafe { trace_events_enabled_count }) !=3D 0 &amp;&am=
p; dstate !=3D 0<br>
=C2=A0}<br>
<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut trace_events_enabled_count: u32;<br>
=C2=A0}<br>
=C2=A0extern &quot;C&quot; {<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_BLAH_DSTATE: u16;<br>
+=C2=A0 =C2=A0 #[allow(dead_code)]<br>
=C2=A0 =C2=A0 =C2=A0static mut _TRACE_TEST_WIBBLE_DSTATE: u16;<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_blah_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTAT=
E}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_blah(_context: *mut (), _filename: &amp;std::ffi::C=
Str)<br>
@@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &am=
p;std::ffi::CStr)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+#[inline(always)]<br>
+#[allow(dead_code)]<br>
+pub fn trace_test_wibble_enabled() -&gt; bool<br>
+{<br>
+=C2=A0 =C2=A0 trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DST=
ATE}) ||<br>
+=C2=A0 =C2=A0 false<br>
+}<br>
+<br>
=C2=A0#[inline(always)]<br>
=C2=A0#[allow(dead_code)]<br>
=C2=A0pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)<=
br>
@@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::=
ffi::c_int)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe {::trace::syslog(::trace::LOG_INFO=
, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _valu=
e /* as std::ffi::c_int */);}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
+<br>
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-=
test.py<br>
index 786083ad7f..30006a9919 100755<br>
--- a/tests/tracetool/tracetool-test.py<br>
+++ b/tests/tracetool/tracetool-test.py<br>
@@ -14,7 +14,7 @@ def get_formats(backend):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;c&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;h&quot;,<br>
=C2=A0 =C2=A0 =C2=A0]<br>
-=C2=A0 =C2=A0 if backend in {&quot;ftrace&quot;, &quot;log&quot;, &quot;si=
mple&quot;, &quot;syslog&quot;}:<br>
+=C2=A0 =C2=A0 if backend in {&quot;dtrace&quot;, &quot;ftrace&quot;, &quot=
;log&quot;, &quot;simple&quot;, &quot;syslog&quot;}:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0formats +=3D [&quot;rs&quot;]<br>
=C2=A0 =C2=A0 =C2=A0if backend =3D=3D &quot;dtrace&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0formats +=3D [<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div></div>

--0000000000002992c50643f7b450--


