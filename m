Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55B2C021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 10:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti9ZB-0004pr-Aq; Wed, 12 Feb 2025 05:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ti9Z8-0004pQ-Oq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ti9Z1-0000vO-Qu
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739354509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CNkIMF/NI3L6xDvayogJor+p/40OSWdQSMO+0UT3Oog=;
 b=K1p5VWy6hlNx+Z5ALAJGPbRrFmjUpLry2wYwX6OOpELZxk2ItbJHCatl4nyrIn95LuedsT
 bMZ6stqHStb/Jaa2yhmcIIbTqru6ldaeDsVspSkNfKeYdQ9eIX1oQ6AS7I8uIrSxLOGEqJ
 UhpRSp23kNYN/5HxyHlWVq6P7ou0b+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5X5tYVOdPXy6hCgUAUOYZQ-1; Wed, 12 Feb 2025 05:01:48 -0500
X-MC-Unique: 5X5tYVOdPXy6hCgUAUOYZQ-1
X-Mimecast-MFC-AGG-ID: 5X5tYVOdPXy6hCgUAUOYZQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4392fc6bceaso22849115e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 02:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739354507; x=1739959307;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNkIMF/NI3L6xDvayogJor+p/40OSWdQSMO+0UT3Oog=;
 b=EVxZX8u6FE5Rd4PrL8B9aygs/yJL2PbHdEnLH8VC6xYd46c6HF0uALLYwxwNti1Tri
 N0ktR1hfYX3aWyCIMHufv4Nfd4kupXzY8Oy/qDw/zx7McD934R64VIBJ3TbuNWn75i+A
 ATMLpuNdrS8fwNBM7nc6q2zwNgUJJ0QeaD1z/4BTBSaKGixM0VZ9yiUqFkwu63rm7f/q
 ieBFtJxcg5CqECSHOqf7QSUodkDtXCEYqn+55p3WcmiGdC97oQViooBFXqfLSmnONQLV
 xNmXGBzvnGbsAulHYRuPNbfzKnOaAnnR/9zPL9LrMOXCDUteS0mw8mFPmwkcUgbhuQ3W
 VMEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5X6/HNE/UrpxmpqMoxvNhPb3fofPt8c5N9db7oCZEAIdesZv3TmdHXmtDnu7DguBsKHYkbUqEKHWg@nongnu.org
X-Gm-Message-State: AOJu0Yx+880JIqvl93VH88sMmI3EKJMRHnGzWCOM/2lowS1s7hCSroxi
 2D4hDXTb2LPGw96rhCDLn1Db9U1iGZyrm3fMXpSvGh2aabcuv64CWhs+q6v53yNVrKP1oU0WehG
 Q4YY2rpiG7XlqeMvqpKxaa3V+Zt3SRZjjR3rpO1TL+vWNrtOqDKBq
X-Gm-Gg: ASbGnctciukM89gV+RlEnhCASI5vWIs9WiJEBM4LufRHJdAeTxnlvT0sH6OQrU2h+MB
 AjLsC9zGwb9j8SG9JDMaIvrK7pnKxZXoXpxnb8URbOJhKfIMjBGmEEA/cHzLpjsKYRJSgtXcKyl
 yOtJoG7Ob4iOe6NtyaVmSOszuKEeZLp86FCxt+xG1bPCzMlFq2ooJdOuIkqawLi5s8/HwJF3iFD
 3CzxWeBUAhMxgsgqt+mCI3M75aibbxgmm/UfrAyZrMzC87Q/+op8JTPa62x2OAwhP4XkEr9MAPO
 NBE/SMA=
X-Received: by 2002:a05:600c:1f11:b0:439:4b7d:72de with SMTP id
 5b1f17b1804b1-4395817d2ecmr24484665e9.15.1739354506708; 
 Wed, 12 Feb 2025 02:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENGqGiIi6OxIhOf3rEZD+OEecvN1GM4r5De1KTPtJQJFTHTQOByn4MVK5OYd8ukQb8HNVRKg==
X-Received: by 2002:a05:600c:1f11:b0:439:4b7d:72de with SMTP id
 5b1f17b1804b1-4395817d2ecmr24484275e9.15.1739354506199; 
 Wed, 12 Feb 2025 02:01:46 -0800 (PST)
Received: from [192.168.10.81] ([151.95.148.6])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4395aef82edsm11500155e9.38.2025.02.12.02.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 02:01:45 -0800 (PST)
Message-ID: <1bcb9de2-5932-4c24-958d-7a86cfcea70e@redhat.com>
Date: Wed, 12 Feb 2025 11:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] rust: Build separate qemu_api_tools and
 qemu_api_system
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, 
 qemu-rust@nongnu.org
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-2-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250211214328.640374-2-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/11/25 22:43, Kevin Wolf wrote:
> The existing qemu_api library can't be linked into tools because it
> contains a few bindings for things that only exist in the system
> emulator.
> 
> This adds a new "system" feature to the qemu_api crate that enables the
> system emulator parts in it, and build the crate twice: qemu_api_tools
> is the core library that can be linked into tools, and qemu_api_system
> is the full one for the system emulator.

As discussed on IRC, the issue here is ClassInitImpl<>, which has to be 
defined in the same crate for qemu_api::qom and qemu_api::qdev.

Right now, the block layer has no use for QOM, but later it will (for 
secret management, for example), so splitting QOM into a separate crate 
does not work long term.

I'll try to figure out an alternative way to do the class_init bindings.

Paolo

> Unfortunately, since library names have to be unique in meson, this
> means that every user of the library now needs to specify a
> rust_dependency_map to make either qemu_api_tools or qemu_api_system
> show up as the qemu_api crate in Rust.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   rust/wrapper-system.h          | 44 +++++++++++++++++++++
>   rust/wrapper.h                 |  9 -----
>   meson.build                    | 11 +++++-
>   rust/hw/char/pl011/meson.build |  3 +-
>   rust/meson.build               | 11 +++---
>   rust/qemu-api/Cargo.toml       |  1 +
>   rust/qemu-api/build.rs         | 10 ++++-
>   rust/qemu-api/meson.build      | 70 ++++++++++++++++++++++------------
>   rust/qemu-api/src/bindings.rs  | 16 ++++++--
>   rust/qemu-api/src/lib.rs       |  4 ++
>   rust/qemu-api/src/prelude.rs   |  2 +
>   rust/qemu-api/src/zeroable.rs  | 10 +++++
>   12 files changed, 143 insertions(+), 48 deletions(-)
>   create mode 100644 rust/wrapper-system.h
> 
> diff --git a/rust/wrapper-system.h b/rust/wrapper-system.h
> new file mode 100644
> index 0000000000..fc6c571e6d
> --- /dev/null
> +++ b/rust/wrapper-system.h
> @@ -0,0 +1,44 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + *
> + * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +
> +/*
> + * This header file is meant to be used as input to the `bindgen` application
> + * in order to generate C FFI compatible Rust bindings.
> + */
> +
> +/* The system emulator has all of the bindings tools have */
> +#include "wrapper.h"
> +
> +#include "system/system.h"
> +#include "hw/sysbus.h"
> +#include "exec/memory.h"
> +#include "hw/clock.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index a9bc67af0d..41be87adcf 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -50,15 +50,6 @@ typedef enum memory_order {
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu-io.h"
> -#include "system/system.h"
> -#include "hw/sysbus.h"
> -#include "exec/memory.h"
>   #include "chardev/char-fe.h"
> -#include "hw/clock.h"
> -#include "hw/qdev-clock.h"
> -#include "hw/qdev-properties.h"
> -#include "hw/qdev-properties-system.h"
> -#include "hw/irq.h"
>   #include "qapi/error.h"
> -#include "migration/vmstate.h"
>   #include "chardev/char-serial.h"
> diff --git a/meson.build b/meson.build
> index 18cf9e2913..1f26801b69 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4094,10 +4094,17 @@ if have_rust
>     # this case you must pass the path to `clang` and `libclang` to your build
>     # command invocation using the environment variables CLANG_PATH and
>     # LIBCLANG_PATH
> -  bindings_rs = rust.bindgen(
> +  bindings_rs_tools = rust.bindgen(
>       input: 'rust/wrapper.h',
> +    output: 'bindings_tools.inc.rs',
> +    include_directories: include_directories('.', 'include'),
> +    bindgen_version: ['>=0.60.0'],
> +    args: bindgen_args,
> +    )
> +  bindings_rs_system = rust.bindgen(
> +    input: 'rust/wrapper-system.h',
>       dependencies: common_ss.all_dependencies(),
> -    output: 'bindings.inc.rs',
> +    output: 'bindings_system.inc.rs',
>       include_directories: include_directories('.', 'include'),
>       bindgen_version: ['>=0.60.0'],
>       args: bindgen_args,
> diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
> index 547cca5a96..d2cfede5dc 100644
> --- a/rust/hw/char/pl011/meson.build
> +++ b/rust/hw/char/pl011/meson.build
> @@ -12,9 +12,10 @@ _libpl011_rs = static_library(
>     dependencies: [
>       bilge_dep,
>       bilge_impl_dep,
> -    qemu_api,
> +    qemu_api_system,
>       qemu_api_macros,
>     ],
> +  rust_dependency_map: {'qemu_api_system': 'qemu_api'},
>   )
>   
>   rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
> diff --git a/rust/meson.build b/rust/meson.build
> index 91e52b8fb8..50eb23b072 100644
> --- a/rust/meson.build
> +++ b/rust/meson.build
> @@ -9,18 +9,19 @@ if cargo.found()
>     run_target('clippy',
>       command: [config_host['MESON'], 'devenv',
>                 '--workdir', '@CURRENT_SOURCE_DIR@',
> -              cargo, 'clippy', '--tests'],
> -    depends: bindings_rs)
> +              cargo, 'clippy', '--tests', '--features', 'system'],
> +    depends: bindings_rs_system)
>   
>     run_target('rustfmt',
>       command: [config_host['MESON'], 'devenv',
>                 '--workdir', '@CURRENT_SOURCE_DIR@',
>                 cargo, 'fmt'],
> -    depends: bindings_rs)
> +    depends: bindings_rs_system)
>   
>     run_target('rustdoc',
>       command: [config_host['MESON'], 'devenv',
>                 '--workdir', '@CURRENT_SOURCE_DIR@',
> -              cargo, 'doc', '--no-deps', '--document-private-items'],
> -    depends: bindings_rs)
> +              cargo, 'doc', '--no-deps', '--document-private-items',
> +              '--features', 'system'],
> +    depends: bindings_rs_system)
>   endif
> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> index a51dd14285..ed7b60bc80 100644
> --- a/rust/qemu-api/Cargo.toml
> +++ b/rust/qemu-api/Cargo.toml
> @@ -24,6 +24,7 @@ version_check = "~0.9"
>   default = ["debug_cell"]
>   allocator = []
>   debug_cell = []
> +system= []
>   
>   [lints]
>   workspace = true
> diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
> index 471e6c633d..b14f9d4e4a 100644
> --- a/rust/qemu-api/build.rs
> +++ b/rust/qemu-api/build.rs
> @@ -16,7 +16,13 @@ fn main() -> Result<()> {
>       let path = env::var("MESON_BUILD_ROOT")
>           .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
>   
> -    let file = format!("{}/bindings.inc.rs", path);
> +    let basename = if cfg!(feature = "system") {
> +        "bindings_system.inc.rs"
> +    } else {
> +        "bindings_tools.inc.rs"
> +    };
> +
> +    let file = format!("{}/{}", path, basename);
>       let file = Path::new(&file);
>       if !Path::new(&file).exists() {
>           panic!(concat!(
> @@ -31,7 +37,7 @@ fn main() -> Result<()> {
>       }
>   
>       let out_dir = env::var("OUT_DIR").unwrap();
> -    let dest_path = format!("{}/bindings.inc.rs", out_dir);
> +    let dest_path = format!("{}/{}", out_dir, basename);
>       let dest_path = Path::new(&dest_path);
>       if dest_path.symlink_metadata().is_ok() {
>           remove_file(dest_path)?;
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 60944a657d..acac384936 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -10,39 +10,58 @@ if get_option('debug_mutex')
>     _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
>   endif
>   
> -_qemu_api_rs = static_library(
> -  'qemu_api',
> +sources_core = [
> +  'src/lib.rs',
> +  'src/assertions.rs',
> +  'src/bindings.rs',
> +  'src/bitops.rs',
> +  'src/callbacks.rs',
> +  'src/cell.rs',
> +  'src/c_str.rs',
> +  'src/module.rs',
> +  'src/offset_of.rs',
> +  'src/prelude.rs',
> +  'src/qom.rs',
> +  'src/zeroable.rs',
> +]
> +sources_system = sources_core + [
> +  'src/irq.rs',
> +  'src/qdev.rs',
> +  'src/sysbus.rs',
> +  'src/vmstate.rs',
> +]
> +
> +
> +_qemu_api_tools_rs = static_library(
> +  'qemu_api_tools',
>     structured_sources(
> -    [
> -      'src/lib.rs',
> -      'src/assertions.rs',
> -      'src/bindings.rs',
> -      'src/bitops.rs',
> -      'src/callbacks.rs',
> -      'src/cell.rs',
> -      'src/c_str.rs',
> -      'src/irq.rs',
> -      'src/module.rs',
> -      'src/offset_of.rs',
> -      'src/prelude.rs',
> -      'src/qdev.rs',
> -      'src/qom.rs',
> -      'src/sysbus.rs',
> -      'src/vmstate.rs',
> -      'src/zeroable.rs',
> -    ],
> -    {'.' : bindings_rs},
> +    sources_core,
> +    {'.' : bindings_rs_tools},
>     ),
>     override_options: ['rust_std=2021', 'build.rust_std=2021'],
>     rust_abi: 'rust',
>     rust_args: _qemu_api_cfg,
>   )
> +_qemu_api_system_rs = static_library(
> +  'qemu_api_system',
> +  structured_sources(
> +    sources_system,
> +    {'.' : bindings_rs_system},
> +  ),
> +  override_options: ['rust_std=2021', 'build.rust_std=2021'],
> +  rust_abi: 'rust',
> +  rust_args: _qemu_api_cfg + ['--cfg', 'feature="system"'],
> +)
>   
> -rust.test('rust-qemu-api-tests', _qemu_api_rs,
> +rust.test('rust-qemu-api-tests', _qemu_api_system_rs,
>             suite: ['unit', 'rust'])
>   
> -qemu_api = declare_dependency(
> -  link_with: _qemu_api_rs,
> +qemu_api_tools = declare_dependency(
> +  link_with: _qemu_api_tools_rs,
> +  dependencies: qemu_api_macros,
> +)
> +qemu_api_system = declare_dependency(
> +  link_with: _qemu_api_system_rs,
>     dependencies: qemu_api_macros,
>   )
>   
> @@ -59,7 +78,8 @@ test('rust-qemu-api-integration',
>           override_options: ['rust_std=2021', 'build.rust_std=2021'],
>           rust_args: ['--test'],
>           install: false,
> -        dependencies: [qemu_api, qemu_api_macros],
> +        dependencies: [qemu_api_system, qemu_api_macros],
> +        rust_dependency_map: {'qemu_api_system': 'qemu_api'},
>           link_whole: [rust_qemu_api_objs, libqemuutil]),
>       args: [
>           '--test', '--test-threads', '1',
> diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
> index 8a9b821bb9..2bf6c13a32 100644
> --- a/rust/qemu-api/src/bindings.rs
> +++ b/rust/qemu-api/src/bindings.rs
> @@ -15,15 +15,23 @@
>       clippy::missing_safety_doc
>   )]
>   
> -#[cfg(MESON)]
> -include!("bindings.inc.rs");
> +#[cfg(all(MESON, not(feature="system")))]
> +include!("bindings_tools.inc.rs");
> +#[cfg(all(MESON, feature="system"))]
> +include!("bindings_system.inc.rs");
>   
> -#[cfg(not(MESON))]
> -include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
> +#[cfg(all(not(MESON), not(feature="system")))]
> +include!(concat!(env!("OUT_DIR"), "/bindings_tools.inc.rs"));
> +#[cfg(all(not(MESON), feature="system"))]
> +include!(concat!(env!("OUT_DIR"), "/bindings_system.inc.rs"));
>   
>   unsafe impl Send for Property {}
>   unsafe impl Sync for Property {}
>   unsafe impl Sync for TypeInfo {}
> +
> +#[cfg(feature="system")]
>   unsafe impl Sync for VMStateDescription {}
> +#[cfg(feature="system")]
>   unsafe impl Sync for VMStateField {}
> +#[cfg(feature="system")]
>   unsafe impl Sync for VMStateInfo {}
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 3cf9371cff..3c6c154f3d 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -18,12 +18,16 @@
>   pub mod c_str;
>   pub mod callbacks;
>   pub mod cell;
> +#[cfg(feature = "system")]
>   pub mod irq;
>   pub mod module;
>   pub mod offset_of;
> +#[cfg(feature = "system")]
>   pub mod qdev;
>   pub mod qom;
> +#[cfg(feature = "system")]
>   pub mod sysbus;
> +#[cfg(feature = "system")]
>   pub mod vmstate;
>   pub mod zeroable;
>   
> diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
> index 2dc86e19b2..1b8d7d319e 100644
> --- a/rust/qemu-api/src/prelude.rs
> +++ b/rust/qemu-api/src/prelude.rs
> @@ -17,6 +17,8 @@
>   
>   pub use crate::qom_isa;
>   
> +#[cfg(feature="system")]
>   pub use crate::sysbus::SysBusDeviceMethods;
>   
> +#[cfg(feature="system")]
>   pub use crate::vmstate::VMState;
> diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
> index 7b04947cb6..b454e9e05e 100644
> --- a/rust/qemu-api/src/zeroable.rs
> +++ b/rust/qemu-api/src/zeroable.rs
> @@ -56,6 +56,7 @@ pub unsafe trait Zeroable: Default {
>   /// ## Differences with `core::mem::zeroed`
>   ///
>   /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
> +#[allow(unused)]
>   macro_rules! const_zero {
>       // This macro to produce a type-generic zero constant is taken from the
>       // const_zero crate (v0.1.1):
> @@ -77,6 +78,7 @@ union TypeAsBytes {
>   }
>   
>   /// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
> +#[allow(unused)]
>   macro_rules! impl_zeroable {
>       ($type:ty) => {
>           unsafe impl Zeroable for $type {
> @@ -86,6 +88,7 @@ unsafe impl Zeroable for $type {
>   }
>   
>   // bindgen does not derive Default here
> +#[cfg(feature = "system")]
>   #[allow(clippy::derivable_impls)]
>   impl Default for crate::bindings::VMStateFlags {
>       fn default() -> Self {
> @@ -93,10 +96,17 @@ fn default() -> Self {
>       }
>   }
>   
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::Property);
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::VMStateFlags);
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::VMStateField);
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::VMStateDescription);
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
> +#[cfg(feature = "system")]
>   impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);


