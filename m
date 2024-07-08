Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63581C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqUJ-00074v-5c; Mon, 08 Jul 2024 11:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQqUH-00074O-Ba
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQqUD-0002Kq-6w
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720453263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3+9aaAFaB6xxLJOR1xgNBChTSVK8wG/HZ5uaHWJbPJ0=;
 b=ECVeyOP2tu6DmMi77T7ccUfG8aYZ27NudVeXYMp6LqnZUD/7Nwa2atT433AQSztZAsWTj8
 VBrDsdwhgCzPNr085gHC1MKlZ1uSpVBjWsxRG/HwY6e4tGaM5H9wRbGVMY0SCTEG5RESsT
 LXlaXDjzed34mT435H9H/kn8NYqpHM4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-u19V9gl8Ot-I8DwrtawQ4w-1; Mon, 08 Jul 2024 11:40:54 -0400
X-MC-Unique: u19V9gl8Ot-I8DwrtawQ4w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee8e904f01so52815551fa.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453252; x=1721058052;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+9aaAFaB6xxLJOR1xgNBChTSVK8wG/HZ5uaHWJbPJ0=;
 b=QN6iktaVO43MU0f/TVyhQ8mVBNe0GgVIFYqWh+D1fQuCdFc250isVio+LAqj8RwdyB
 pf4slK3vZMFXAoY6Ui7j+efB38y88lKKOKiXtGVAoHDK5tuj1qSdzlsKVyK/6rOIfjfp
 bwbeyBRF4I8oVmoq6zmE6yMQH2H6KzuuRplefUCEMC/WalCQsRyNiXImsNJDpY9OTKbK
 yATc+LLKudOMwjRWdY4wWGUJ/huLm3RueC4Q2wQxytge/h8CBC9TnoyB4Xb7cUcfRkLR
 xjEJOPFfWI2SZYh5NMrDjl5h6RsZbzNIHJOr1KkNazde9WVRI3lQMIAKuWETc0yvF7ct
 m+BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEA7kNIULeBHVsl5e5HL7aIRXa9AE9BDjGuC0KwuXnemMD8cg2aJ1RWGS8s/f0RSfYBkdEhXaxsLYgRG+6v1sJTpDq54w=
X-Gm-Message-State: AOJu0YybiYD3+sKvKB62hERCyqCaiZok2+Fm9xvtRG6ICKQCmlH9TvbM
 5PjdIays06++EyK96a+LNBKq92BeYj/czt/pYJDOFKcqeza5FrsHQ2w+PkbtU0QVlRrWR2E0AY8
 0bJqBOX2aBAKPh85guYxbL+qS0DsMFLrcfXS6fV8W/etDTI+saVr7
X-Received: by 2002:a2e:9bd5:0:b0:2ee:5969:e454 with SMTP id
 38308e7fff4ca-2eeb30bba80mr671891fa.1.1720453252502; 
 Mon, 08 Jul 2024 08:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2b5QkGIcOjTTFlu2YYwAlVZOrhpWWVuXXSf49mwFSUc2LTp+5F38RlZX4GNsq26aEdaEbQQ==
X-Received: by 2002:a2e:9bd5:0:b0:2ee:5969:e454 with SMTP id
 38308e7fff4ca-2eeb30bba80mr671731fa.1.1720453251987; 
 Mon, 08 Jul 2024 08:40:51 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4266d0185d9sm26721455e9.3.2024.07.08.08.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 08:40:51 -0700 (PDT)
Message-ID: <791966e8-adc9-4ec7-88da-da0b3f261ef7@redhat.com>
Date: Mon, 8 Jul 2024 17:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/7] rust: add crate to expose bindings and
 interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <eea3fbaeb15e10ee082d38aee19e55ea1d3a607c.1720094395.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <eea3fbaeb15e10ee082d38aee19e55ea1d3a607c.1720094395.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/4/24 14:15, Manos Pitsidianakis wrote:
> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS                       |   7 ++
>   rust/.cargo/config.toml           |   2 +
>   rust/qemu-api/.gitignore          |   2 +
>   rust/qemu-api/Cargo.lock          |   7 ++
>   rust/qemu-api/Cargo.toml          |  59 ++++++++++++++
>   rust/qemu-api/README.md           |  17 ++++
>   rust/qemu-api/build.rs            |  48 +++++++++++
>   rust/qemu-api/deny.toml           |  57 +++++++++++++
>   rust/qemu-api/meson.build         |   0
>   rust/qemu-api/rustfmt.toml        |   1 +
>   rust/qemu-api/src/bindings.rs     |   8 ++
>   rust/qemu-api/src/definitions.rs  | 112 +++++++++++++++++++++++++
>   rust/qemu-api/src/device_class.rs | 131 ++++++++++++++++++++++++++++++

I'd rather put the various definitions in directories that roughly 
correspond to the C files, so rust/qemu-api/src/{util,qom,hw/core/}.
> +correctness = { level = "deny", priority = -1 }
> +suspicious = { level = "deny", priority = -1 }
> +complexity = { level = "deny", priority = -1 }
> +perf = { level = "deny", priority = -1 }
> +cargo = { level = "deny", priority = -1 }
> +nursery = { level = "deny", priority = -1 }
> +style = { level = "deny", priority = -1 }

Groups are problematic because they can (and will) cause breakage when 
new failures are added.  I think we should have a non-fatal job to test 
with groups, but by default we can add a large number of lints and 
"allow" the groups.

> +cast_ptr_alignment = "allow"

Why?

> +missing_safety_doc = "allow"

Please add it to individual files at the top.

> diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
> new file mode 100644
> index 0000000000..f16a1a929d
> --- /dev/null
> +++ b/rust/qemu-api/README.md
> @@ -0,0 +1,17 @@
> +# QEMU bindings and API wrappers
> +
> +This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
> +
> +The C bindings can be generated with `bindgen`, using this build target:
> +
> +```console
> +$ ninja bindings-aarch64-softmmu.rs
> +```
> +
> +## Generate Rust documentation
> +
> +To generate docs for this crate, including private items:
> +
> +```sh
> +cargo doc --no-deps --document-private-items
> +```
> diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
> new file mode 100644
> index 0000000000..13164f8371
> --- /dev/null
> +++ b/rust/qemu-api/build.rs
> @@ -0,0 +1,48 @@
> +// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
> +
> +use std::{env, path::Path};
> +
> +fn main() {
> +    println!("cargo:rerun-if-env-changed=MESON_BUILD_ROOT");
> +    println!("cargo:rerun-if-changed=src/bindings.rs.inc");
> +
> +    let out_dir = env::var_os("OUT_DIR").unwrap();
> +
> +    if let Some(build_dir) = std::env::var_os("MESON_BUILD_ROOT") {
> +        let mut build_dir = Path::new(&build_dir).to_path_buf();
> +        let mut out_dir = Path::new(&out_dir).to_path_buf();
> +        assert!(
> +            build_dir.exists(),
> +            "MESON_BUILD_ROOT value does not exist on filesystem: {}",
> +            build_dir.display()
> +        );
> +        assert!(
> +            build_dir.is_dir(),
> +            "MESON_BUILD_ROOT value is not actually a directory: {}",
> +            build_dir.display()
> +        );
> +        // TODO: add logic for other guest target architectures.
> +        build_dir.push("bindings-aarch64-softmmu.rs");
> +        let bindings_rs = build_dir;
> +        assert!(
> +            bindings_rs.exists(),
> +            "MESON_BUILD_ROOT/bindings-aarch64-softmmu.rs does not exist on filesystem: {}",
> +            bindings_rs.display()
> +        );
> +        assert!(
> +            bindings_rs.is_file(),
> +            "MESON_BUILD_ROOT/bindings-aarch64-softmmu.rs is not a file: {}",
> +            bindings_rs.display()
> +        );
> +        out_dir.push("bindings.rs");
> +        std::fs::copy(bindings_rs, out_dir).unwrap();
> +        println!("cargo:rustc-cfg=MESON_BINDINGS_RS");
> +    } else if !Path::new("src/bindings.rs.inc").exists() {
> +        panic!(
> +            "No generated C bindings found! Either build them manually with bindgen or with meson \
> +             (`ninja bindings-aarch64-softmmu.rs`) and copy them to src/bindings.rs.inc, or build \
> +             through meson."
> +        );
> +    }
> +}
> diff --git a/rust/qemu-api/deny.toml b/rust/qemu-api/deny.toml
> new file mode 100644
> index 0000000000..3992380509
> --- /dev/null
> +++ b/rust/qemu-api/deny.toml
> @@ -0,0 +1,57 @@
> +# cargo-deny configuration file
> +
> +[graph]
> +targets = [
> +    "aarch64-unknown-linux-gnu",
> +    "x86_64-unknown-linux-gnu",
> +    "x86_64-apple-darwin",
> +    "aarch64-apple-darwin",
> +    "x86_64-pc-windows-gnu",
> +    "aarch64-pc-windows-gnullvm",

Do we actually support LLVM Windows targets?

> +unsafe impl Sync for TypeInfo {}
> +unsafe impl Sync for VMStateDescription {}
> +
> +#[macro_export]
> +macro_rules! module_init {
> +    ($func:expr, $type:expr) => {
> +        #[used]
> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]

I'd rather use the ctor crate.  Also, this should be src/util/module.rs 
so that it's easy to find the matching C source.

> +        pub static LOAD_MODULE: extern "C" fn() = {
> +            assert!($type < $crate::bindings::module_init_type_MODULE_INIT_MAX);
> +
> +            extern "C" fn __load() {
> +                // ::std::panic::set_hook(::std::boxed::Box::new(|_| {}));
> +
> +                unsafe {
> +                    $crate::bindings::register_module_init(Some($func), $type);
> +                }
> +            }
> +
> +            __load
> +        };
> +    };
> +    (qom: $func:ident => $body:block) => {
> +        // NOTE: To have custom identifiers for the ctor func we need to either supply
> +        // them directly as a macro argument or create them with a proc macro.
> +        #[used]
> +        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
> +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
> +        pub static LOAD_MODULE: extern "C" fn() = {
> +            extern "C" fn __load() {
> +                // ::std::panic::set_hook(::std::boxed::Box::new(|_| {}));
> +                #[no_mangle]
> +                unsafe extern "C" fn $func() {
> +                    $body
> +                }
> +
> +                unsafe {
> +                    $crate::bindings::register_module_init(
> +                        Some($func),
> +                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
> +                    );
> +                }
> +            }
> +
> +            __load
> +        };
> +    };
> +}
> +
> +#[macro_export]
> +macro_rules! type_info {
> +    ($(#[$outer:meta])*
> +     $name:ident: $t:ty,
> +     $(name: $tname:expr,)*
> +     $(parent: $pname:expr,)*
> +     $(instance_init: $ii_fn:expr,)*
> +     $(instance_post_init: $ipi_fn:expr,)*
> +     $(instance_finalize: $if_fn:expr,)*
> +     $(abstract_: $a_val:expr,)*
> +     $(class_init: $ci_fn:expr,)*
> +     $(class_base_init: $cbi_fn:expr,)*
> +    ) => {
> +        #[used]
> +        $(#[$outer])*
> +        pub static $name: $crate::bindings::TypeInfo = $crate::bindings::TypeInfo {
> +                $(name: {
> +                #[used]
> +                static TYPE_NAME: &::core::ffi::CStr = $tname;
> +                $tname.as_ptr()
> +            },)*

Please use the cstr crate.  Even better, add a trait

pub unsafe trait ObjectType: Sized {
     const TYPE_NAME: &'static CStr;
}

and then just <$t as ObjectType>::TYPE_NAME

Likewise, the parent could be mandatory like

+     $name:ident: $t:ty($p:ty)

and use <$p as ObjectType>::TYPE_NAME.

> +            ..unsafe { MaybeUninit::<$crate::bindings::TypeInfo>::zeroed().assume_init() }

I suggest something like the Zeroed trait I had in my experiment:

==========
#![allow(clippy::undocumented_unsafe_blocks)]

use std::mem::MaybeUninit;

/// Trait providing an easy way to obtain an all-zero
/// value for a struct
///
/// # Safety
///
/// Only add this to a type if `MaybeUninit::zeroed().assume_init()`
/// is valid for that type.

pub unsafe trait Zeroed: Sized {
     fn zeroed() -> Self {
         // SAFETY: If this weren't safe, just do not add the
         // trait to a type.
         unsafe { MaybeUninit::zeroed().assume_init() }
     }
}

// Put here all the impls that you need for the bindgen-provided types.
unsafe impl Zeroed for crate::bindings::TypeInfo {}
=========

So that you can simply write Zeroed::zeroed(); there are other 
occurrences of this for Property, VMStateDescription, MemoryRegionOps.

> +use std::sync::OnceLock;

OnceLock is not needed, initialization is single-threaded and executed 
once only.  You can just make declare_properties return a fn() and

$crate::bindings::device_class_set_props(dc.as_mut(), $props());

> +            dc.as_mut().realize = $realize_fn;
> +            dc.as_mut().reset = $reset_fn;

Nice.  Might also add the same trick as type_info!, for example 
$(realize: $realize_fn:expr,)*, to remove the "Some()".


> +#[macro_export]
> +macro_rules! define_property {
> +    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
> +        $crate::bindings::Property {
> +            name: {
> +                #[used]
> +                static _TEMP: &::core::ffi::CStr = $name;
> +                _TEMP.as_ptr()
> +            },

Also please use cstr!() here.

> +            bitnr: 0,
> +            bitmask: 0,
> +            set_default: true,
> +            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
> +            arrayoffset: 0,
> +            arrayinfo: ::core::ptr::null(),
> +            arrayfieldsize: 0,
> +            link_type: ::core::ptr::null(),
> +        }
> +    };

I think you can just use "..Zeroed::zeroed()" instead of listing all the 
fields one by one.

> +#[repr(C)]
> +pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn() -> [Property; N]);
> +
> +impl<const N: usize> Properties<N> {
> +    pub unsafe fn as_mut_ptr(&mut self) -> *mut Property {
> +        _ = self.0.get_or_init(self.1);
> +        self.0.get_mut().unwrap().as_mut_ptr()
> +    }
> + > +        #[no_mangle]
> +        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
> +    };
> +}
> +
> +#[macro_export]
> +macro_rules! vm_state_description {
> +    ($(#[$outer:meta])*
> +     $name:ident,
> +     $(name: $vname:expr,)*
> +     $(unmigratable: $um_val:expr,)*
> +    ) => {
> +        #[used]
> +        $(#[$outer])*
> +        pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
> +            $(name: {
> +                #[used]
> +                static VMSTATE_NAME: &::core::ffi::CStr = $vname;
> +                $vname.as_ptr()
> +            },)*
> +            unmigratable: true,
> +            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
> +        };
> +    }
> +}
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> new file mode 100644
> index 0000000000..74825c84e7
> --- /dev/null
> +++ b/rust/qemu-api/src/lib.rs
> @@ -0,0 +1,29 @@
> +// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
> +
> +#![doc = include_str!("../README.md")]
> +
> +// FIXME: remove improper_ctypes
> +#[allow(
> +    improper_ctypes_definitions,
> +    improper_ctypes,
> +    non_camel_case_types,
> +    non_snake_case,
> +    non_upper_case_globals
> +)]
> +#[allow(
> +    clippy::missing_const_for_fn,
> +    clippy::useless_transmute,

This one definitely shouldn't be there.

Paolo

> +    clippy::too_many_arguments,
> +    clippy::approx_constant,
> +    clippy::use_self,
> +    clippy::cast_lossless,
> +)]
> +#[rustfmt::skip]
> +pub mod bindings;
> +
> +pub mod definitions;
> +pub mod device_class;
> +
> +#[cfg(test)]
> +mod tests;
> diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
> new file mode 100644
> index 0000000000..88c26308ee
> --- /dev/null
> +++ b/rust/qemu-api/src/tests.rs
> @@ -0,0 +1,48 @@
> +// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
> +
> +use crate::{
> +    bindings::*, declare_properties, define_property, device_class_init, vm_state_description,
> +};
> +
> +#[test]
> +fn test_device_decl_macros() {
> +    // Test that macros can compile.
> +    vm_state_description! {
> +        VMSTATE,
> +        name: c"name",
> +        unmigratable: true,
> +    }
> +
> +    #[repr(C)]
> +    pub struct DummyState {
> +        pub char_backend: CharBackend,
> +        pub migrate_clock: bool,
> +    }
> +
> +    declare_properties! {
> +        DUMMY_PROPERTIES,
> +            define_property!(
> +                c"chardev",
> +                DummyState,
> +                char_backend,
> +                unsafe { &qdev_prop_chr },
> +                CharBackend
> +            ),
> +            define_property!(
> +                c"migrate-clk",
> +                DummyState,
> +                migrate_clock,
> +                unsafe { &qdev_prop_bool },
> +                bool
> +            ),
> +    }
> +
> +    device_class_init! {
> +        dummy_class_init,
> +        props => DUMMY_PROPERTIES,
> +        realize_fn => None,
> +        reset_fn => None,
> +        vmsd => VMSTATE,
> +    }
> +}


