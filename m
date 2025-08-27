Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC3BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 06:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur9j1-0005Tc-Kc; Wed, 27 Aug 2025 02:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ur9iy-0005Sv-Jz; Wed, 27 Aug 2025 02:33:36 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ur9iu-0006Gf-RN; Wed, 27 Aug 2025 02:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756276413; x=1787812413;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1awMoRt/9bEJOAxlg7Rue9aCbtQiImxN+y6fkTrBK3Q=;
 b=eelm5O1iJujHeyVs+oYAfCeA29Rxfn1F9RMhEHVTEjd/YIbgi1a4BG5l
 OoUAE6zwrblFb4HyGZOOZhc2ADoaB43bUDsZxz1PRZEa98F5FMrRKNFrf
 bR/jOYArV0gou4CHPASTWRvfZTvCXvhufM406B32nrU7dtYkxXHsPal6j
 8OknLrbTzTuyjNHR0yKtVDyZ5459sePdm9UdCzf5gbxJTxx8oaW0fXDu6
 olRm4/ptH1R1W168CXcPzHuGH2KSRElbDxTpNF8yhDQpgPjk7Hg8u9k6w
 y4L9tGsqtDYgytn9K+l4kei0mBsq960BbOpaLNddOq2hpN3T0YmANYUHU A==;
X-CSE-ConnectionGUID: oyAIWLd7Q8GN+7uoqY66AA==
X-CSE-MsgGUID: ZgaUcK4fTuSVBovzqFMx5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="83928421"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="83928421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 23:33:28 -0700
X-CSE-ConnectionGUID: nlJSvG1kTUayAA6vGwvn4Q==
X-CSE-MsgGUID: S/rQD60jSz+knFCzj4+jrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169712908"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2025 23:33:26 -0700
Date: Wed, 27 Aug 2025 14:55:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-rust@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [RFC 10/18] rust: split "qom" crate
Message-ID: <aK6r0AytZGSOkWYF@intel.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <20250826140449.4190022-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826140449.4190022-11-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 7cffb894a8..a3bcd1297a 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -21,10 +21,13 @@
>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
>      prelude::*,
>      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
> -    qom::{ObjectImpl, Owned, ParentField, ParentInit},
>      sysbus::{SysBusDevice, SysBusDeviceImpl},
>      vmstate_clock,
>  };
> +use qom::{
> +    qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods, ObjectType,
> +    Owned, ParentField, ParentInit,
> +};

These QOM parts are frequently used and very common. at least for qom,
I think prelude would help a lot.

A qom prelude could help reduce the changes in other parts (pl011/
hpet/memory...).

> diff --git a/rust/qom/meson.build b/rust/qom/meson.build
> new file mode 100644
> index 0000000000..6e95d75fa0
> --- /dev/null
> +++ b/rust/qom/meson.build
> @@ -0,0 +1,61 @@
> +_qom_cfg = run_command(rustc_args,
> +  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
> +  capture: true, check: true).stdout().strip().splitlines()
> +
> +# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
> +#
> +# Rust bindings generation with `bindgen` might fail in some cases where the
> +# detected `libclang` does not match the expected `clang` version/target. In
> +# this case you must pass the path to `clang` and `libclang` to your build
> +# command invocation using the environment variables CLANG_PATH and
> +# LIBCLANG_PATH
> +_qom_bindings_inc_rs = rust.bindgen(
> +  input: 'wrapper.h',
> +  dependencies: common_ss.all_dependencies(),
> +  output: 'bindings.inc.rs',

There're many binding files with the same name. What about adding a prefix
like "qom-bindings" to distinguish it? This can help search and locate
specific binding file.

> +  include_directories: bindings_incdir,
> +  bindgen_version: ['>=0.60.0'],
> +  args: bindgen_args_common,
> +)

...

> diff --git a/rust/qom/tests/tests.rs b/rust/qom/tests/tests.rs
> new file mode 100644
> index 0000000000..49f1cbecf5
> --- /dev/null
> +++ b/rust/qom/tests/tests.rs
> @@ -0,0 +1,47 @@
> +use std::{ffi::CStr, sync::LazyLock};

LazyLock is useful, but it became stable since v1.80. So if Paolo
decide pick this series after v1.83 support, it's fine.

> +use qom::{qom_isa, Object, ObjectClassMethods, ObjectImpl, ObjectType, ParentField};
> +use util::bindings::{module_call_init, module_init_type};

...

> +fn init_qom() {
> +    static ONCE: LazyLock<()> = LazyLock::new(|| unsafe {
> +        module_call_init(module_init_type::MODULE_INIT_QOM);
> +    });

But for now, we can still use a static BqlCell<bool> as the workaround,
just like rust/hwcore/tests/tests.rs did, to decouple with MSRV
dependency.

And it seems rust/hwcore/tests/tests.rs has already covered this test
case, do we still need this test?

If so, then it's better to add this new test in a seperate patch, which
makes current patch focus on the splitting :-).

> +    bql::start_test();
> +    LazyLock::force(&ONCE);
> +}
> +

Otherwise, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


