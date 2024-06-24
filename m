Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB79C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgRm-00088e-IP; Mon, 24 Jun 2024 05:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sLgRl-00088W-N9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:57:13 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sLgRi-0003f7-NC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719223031; x=1750759031;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=U3MKvYKPY9cKIDjPveZIAD2vfvbdA4D86j1HHMdvXZA=;
 b=Cu257xmO7nFjKPRlTR89gQyF5PkkhY4wlnIKJs0JTUUxB57Ragb5nv/C
 zsXf8nLPIASEHx9AlWENnOgsrd3tRBcjc83+8IXAcllm9I0HDIqY1CyZr
 l22FbDdGQwthdPX1azsrZY8JsPfV3GXjklCc5nVnyLQ/kJu8S+FD8J4AX
 r1/WeB+PyqjzzQyBEmMhkzAG0jcMWmU6/NRXYka/JxO9aNQiF8ZWyX5rL
 TLWmAq/Kr8F9YOvCJC3LMt+oIh2QY4xIC1wlazOR+41yAYfuL1AxFMyPw
 s8UcXg7XmaTJCg5IVX4+uWyCxhjd8n4q9b9/tRqwyNmXJ4+1NmCyNzvh7 g==;
X-CSE-ConnectionGUID: XAmEVPnCREaQGAcrY/OhDA==
X-CSE-MsgGUID: /Lhs932GT32GOXoh0XakKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16152208"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; d="scan'208";a="16152208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 02:57:08 -0700
X-CSE-ConnectionGUID: BxYjMK0TS5OwJOn6VXqNOQ==
X-CSE-MsgGUID: b7odZ++vTwWoDaVRznpRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; d="scan'208";a="48414036"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 24 Jun 2024 02:57:03 -0700
Date: Mon, 24 Jun 2024 18:12:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
Message-ID: <ZnlGlOGORQkOsoO5@intel.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Manos,

Thanks for your patch. I have a few comments below:

> diff --git a/meson.build b/meson.build
> index 3533889852..2b305e745a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3876,6 +3876,62 @@ foreach target : target_dirs
>      lib_deps += dep.partial_dependency(compile_args: true, includes: true)
>    endforeach
>  
> +  if with_rust and target_type == 'system'
> +       # FIXME:

Just nit, FIXME looks a bit ambiguous, is it intended to fix the
following warning? It could be a bit more specific.

> +       # > WARNING: Project specifies a minimum meson_version '>=0.63.0' but
> +       # > uses features which were added in newer versions:
> +       # > * 0.64.0: {'fs.copyfile'}
> +       # > * 1.0.0: {'dependencies arg in rust.bindgen', 'module rust as stable module'}
> +      rust_bindgen = import('rust')
> +
> +      # We need one generated_rs target per target, so give them
> +      # target-specific names.
> +      copy = fs.copyfile('rust/wrapper.h',
> +                         target + '_wrapper.h')
> +      generated_rs = rust_bindgen.bindgen(
> +        input: copy,
> +        dependencies: arch_deps + lib_deps,
> +        output: target + '-generated.rs',
> +        include_directories: include_directories('.', 'include'),
> +        args: [
> +          '--ctypes-prefix', 'core::ffi',
> +          '--formatter', 'rustfmt',
> +          '--generate-block',
> +          '--generate-cstr',
> +          '--impl-debug',
> +          '--merge-extern-blocks',
> +          '--no-doc-comments',
> +          '--no-include-path-detection',
> +          '--use-core',
> +          '--with-derive-default',
> +          '--allowlist-file', meson.project_source_root() + '/include/.*',
> +          '--allowlist-file', meson.project_source_root() + '/.*',
> +          '--allowlist-file', meson.project_build_root() + '/.*'
> +        ],
> +      )
> +
> +      if target in rust_targets
> +        rust_hw = ss.source_set()
> +        foreach t: rust_targets[target]
> +          rust_device_cargo = custom_target(t['name'],
> +                                       output: t['output'],
> +                                       depends: [generated_rs],
> +                                       build_always_stale: true,
> +                                       command: t['command'])
> +          rust_dep = declare_dependency(link_args: [
> +                                          '-Wl,--whole-archive',
> +                                          t['output-path'],
> +                                          '-Wl,--no-whole-archive'
> +                                          ],
> +                                          sources: [rust_device_cargo])
> +          rust_hw.add(rust_dep)
> +        endforeach
> +        rust_hw_config = rust_hw.apply(config_target, strict: false)
> +        arch_srcs += rust_hw_config.sources()
> +        arch_deps += rust_hw_config.dependencies()
> +      endif
> +  endif
> +
>    lib = static_library('qemu-' + target,
>                   sources: arch_srcs + genh,
>                   dependencies: lib_deps,
> diff --git a/rust/.gitignore b/rust/.gitignore
> new file mode 100644
> index 0000000000..1bf71b1f68
> --- /dev/null
> +++ b/rust/.gitignore
> @@ -0,0 +1,3 @@
> +# Ignore any cargo development build artifacts; for qemu-wide builds, all build
> +# artifacts will go to the meson build directory.
> +target
> diff --git a/rust/meson.build b/rust/meson.build
> new file mode 100644
> index 0000000000..435abd3e1c
> --- /dev/null
> +++ b/rust/meson.build
> @@ -0,0 +1,129 @@
> +# Supported hosts
> +rust_supported_oses = {
> +  'linux': '-unknown-linux-gnu',
> +  'darwin': '-apple-darwin',
> +  'windows': '-pc-windows-gnu'
> +}

Does the current test cover windows and apple? If not, I think we can
add these two platforms later on.

> +rust_supported_cpus = ['x86_64', 'aarch64']

Similarly, here I have another question, x-pl011-rust in arm virt machine
I understand should only run on ARM platform, right? So compiling to
x86_64 doesn't seem necessary at the moment?

> +# Future-proof the above definitions against any change in the root meson.build file:
> +foreach rust_os: rust_supported_oses.keys()
> +  if not supported_oses.contains(rust_os)
> +    message()
> +    warning('UNSUPPORTED OS VALUES IN ' + meson.current_source_dir() + '/meson.build')
> +    message()
> +    message('This meson.build file claims OS `+' + rust_os + '` is supported but')
> +    message('it is not included in the global supported OSes list in')
> +    message(meson.global_source_root() + '/meson.build.')
> +  endif
> +endforeach
> +foreach rust_cpu: rust_supported_cpus
> +  if not supported_cpus.contains(rust_cpu)
> +    message()
> +    warning('UNSUPPORTED CPU VALUES IN ' + meson.current_source_dir() + '/meson.build')
> +    message()
> +    message('This meson.build file claims CPU `+' + rust_cpu + '` is supported but')
> +    message('it is not included in the global supported CPUs list in')
> +    message(meson.global_source_root() + '/meson.build.')
> +  endif
> +endforeach
> +
> +# FIXME: retrieve target triple from meson and construct rust_target_triple
> +if meson.is_cross_build()
> +  message()
> +  error('QEMU does not support cross compiling with Rust enabled.')
> +endif

Is the check here to avoid inconsistencies between cross-build's target
and rust_target_triple?

If target consistency is not guaranteed, then it seems custom rust_target_triple
is useless, right? please educate me if I am wrong ;-)

> +# FIXME: These are the latest stable versions, refine to actual minimum ones.
> +msrv = {
> +  'rustc': '1.79.0',
> +  'cargo': '1.79.0',
> +  'bindgen': '0.69.4',
> +}
> +
> +# rustup = find_program('rustup', required: false)
> +foreach bin_dep: msrv.keys()
> +  bin = find_program(bin_dep, required: true)
> +  if bin.version() < msrv[bin_dep]
> +    if bin_dep == 'bindgen' and get_option('wrap_mode') != 'nodownload'

What about adding a download info here?

It took a long time for my bindgen-cli to update quietly, and for a
moment I thought it was stuck here...

e.g., message('Installing bindgen-cli...')

Or can we just report the error and let users install bindgen-cli
themselves?

> +      run_command(cargo, 'install', 'bindgen-cli', capture: true, check: true)
> +      bin = find_program(bin_dep, required: true)
> +      if bin.version() >= msrv[bin_dep]
> +        continue
> +      endif
> +    endif
> +    message()
> +    error(bin_dep + ' version ' + bin.version() + ' is unsupported: Please upgrade to at least ' + msrv[bin_dep])
> +  endif
> +endforeach
> +
> +rust_target_triple = get_option('with_rust_target_triple')
> +
> +if rust_target_triple == ''
> +  if not supported_oses.contains(host_os)
> +    message()
> +    error('QEMU does not support `' + host_os +'` as a Rust platform.')
> +  elif not supported_cpus.contains(host_arch)
> +    message()
> +    error('QEMU does not support `' + host_arch +'` as a Rust architecture.')
> +  endif
> +  rust_target_triple = host_arch + rust_supported_oses[host_os]
> +  if host_os == 'windows' and host_arch == 'aarch64'
> +    rust_target_triple += 'llvm'
> +  endif
> +else
> +  # verify rust_target_triple if given as an option
> +  rustc = find_program('rustc', required: true)
> +  rustc_targets = run_command(rustc, '--print', 'target-list', capture: true, check: true).stdout().strip().split()
> +  if not rustc_targets.contains(rust_target_triple)
> +    message()
> +    error('Given rust_target_triple ' + rust_target_triple + ' is not listed in rustc --print target-list output')
> +  endif

It seems rust_target_triple missed support check, we should use rust_supported_cpus
+ rust_supported_oses to check rust_target_triple, right? ;-)

> +endif
> +
> +

An extra blank line :-)

> +rust_targets = {}
> +
> +cargo_wrapper = [
> +  find_program(meson.global_source_root() / 'scripts/cargo_wrapper.py'),
> +  '--config-headers', meson.project_build_root() / 'config-host.h',
> +  '--meson-build-root', meson.project_build_root(),
> +  '--meson-build-dir', meson.current_build_dir(),
> +  '--meson-source-dir', meson.current_source_dir(),
> +]
> +
> +if get_option('b_colorout') != 'never'
> +  cargo_wrapper += ['--color', 'always']
> +endif
> +
> +if get_option('optimization') in ['0', '1', 'g']
> +  rs_build_type = 'debug'
> +else
> +  rs_build_type = 'release'
> +endif

Could we decouple 'optimization' with cargo's opt-level (maybe in the future)?

Or we could add new option to specify custom rust opt-level, which will
set the environment varialbe CARGO_PROFILE_<profile_name>_OPT_LEVEL and
override the default opt-level in Cargo.toml.

> +# Collect metadata for each (crate,qemu-target,compiler-target) combination.
> +# Rust meson targets cannot be defined a priori because they depend on bindgen
> +# generation that is created for each emulation target separately. Thus Rust
> +# meson targets will be defined for each target after the target-specific
> +# bindgen dependency is declared.
> +rust_hw_target_list = {}
> +
> +foreach rust_hw_target, rust_hws: rust_hw_target_list
> +  foreach rust_hw_dev: rust_hws
> +    output = meson.current_build_dir() / rust_target_triple / rs_build_type / rust_hw_dev['output']
> +    crate_metadata = {
> +      'name': rust_hw_dev['name'],
> +      'output': [rust_hw_dev['output']],
> +      'output-path': output,
> +      'command': [cargo_wrapper,
> +        '--crate-dir', meson.current_source_dir() / rust_hw_dev['dirname'],
> +        '--profile', rs_build_type,
> +        '--target-triple', rust_target_triple,
> +        '--outdir', '@OUTDIR@',
> +        'build-lib'
> +        ]
> +      }
> +    rust_targets += { rust_hw_target: [crate_metadata] }
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

Here should the author be yourself?

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

Thanks,
Zhao


