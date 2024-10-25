Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BC4D0C5EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Fv6-0002my-J5; Fri, 25 Oct 2024 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4Fv4-0002me-9F
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:43:42 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4Fv1-00053D-Ai
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729845819; x=1761381819;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ou4Ii8w02hSPQQ2PFVQUT6v1B6OA+VGwlbsG8MffFVM=;
 b=POS7slrJML3jZtk1IVIhfUv39SzXRm0FiCY6h1bSMfvcAbCGfCt5K5Ue
 A1j1QYJRXtp0YN/K3IB7XaN1tVLqBouiOkDfBZep3eJ072oqPpbxXC/RL
 RjwT624YNQcUT1WmNECDi02jGx+v5xEZN/BhS0gKjFAHB7E6FFpYKzo1p
 sU3zl/NrfjTa8qproEpvIcwRZG+ba9RxMDrd4xTAaKjGrpu3Y+RYuXqMg
 anka5NcL5LkQoB4fKZViD4gzEBW4VxpBZIP/3ICChA6eIvgmShe5aB3KE
 +yD6vgIWyTzU2+79+QzJUImj00ByyE9ay4fCIROeN+F9wQ139yJDumwzO Q==;
X-CSE-ConnectionGUID: j6cfqbpzTreWcqjmAJt5Vg==
X-CSE-MsgGUID: oBotW9DgQv6izN4k8fWDKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33420224"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="33420224"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2024 01:43:36 -0700
X-CSE-ConnectionGUID: IG9TuvdnQSuou7YbQr5vOw==
X-CSE-MsgGUID: YECBHtIuSS+BW/MnbG+1Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="80513338"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 25 Oct 2024 01:43:27 -0700
Date: Fri, 25 Oct 2024 16:59:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!, use it from
 #[derive(Object)]
Message-ID: <ZxteAWr98He5Zedc@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 21, 2024 at 06:35:33PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:33 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 08/13] rust: cleanup module_init!, use it from
>  #[derive(Object)]
> X-Mailer: git-send-email 2.46.2
> 
> Remove the duplicate code by using the module_init! macro; at the same time,
> simplify how module_init! is used, by taking inspiration from the implementation
> of #[derive(Object)].
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs  | 33 +++-------------
>  rust/qemu-api/src/definitions.rs | 66 ++++++++++++++------------------
>  2 files changed, 33 insertions(+), 66 deletions(-)

LGTM (with some questions related type_init usage inline)

Reviewed-by: Zhao Liu <zhao1.liu@intel>

> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
> index 70e3f920460..a4bc5d01ee8 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -3,43 +3,20 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  #[proc_macro_derive(Object)]
>  pub fn derive_object(input: TokenStream) -> TokenStream {

[snip]

> +            MODULE_INIT_QOM => unsafe {
> +                ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
>              }

I want to see how general this macro could be, so I checked current
type_init() cases for TypeInfo. In most cases, only type_register_static()
is called directly in the init_fn() callback.

There are only two exceptions:

1. Some init_fn callbacks contain more complex validation or register
logic.

  For example, in backends/hostmem-epc.c, sgx_epc_backed_info involves
  extra check before type_register_static().

  static void register_types(void)
  {
      int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
      if (fd >= 0) {
          close(fd);

          type_register_static(&sgx_epc_backed_info);
      }
  }


  And in hw/audio/intel-hda.c, there's extra pci_register_soundhw afer
  type_register_static():

  static void intel_hda_register_types(void)
  {
      type_register_static(&hda_codec_bus_info);
      type_register_static(&intel_hda_info);
      type_register_static(&intel_hda_info_ich6);
      type_register_static(&intel_hda_info_ich9);
      type_register_static(&hda_codec_device_type_info);
      pci_register_soundhw("hda", "Intel HD Audio", intel_hda_and_codec_init);
  }

  The device can define a custom init_fn() for TypeInfo based on
  module_init!, but I wonder if the examples above are valid. Is it
  allowed to include other logic in init_fn()?


2. Some init_fn callbacks use type_register() instead of
type_register_static().

  TypeImpl *type_register_static(const TypeInfo *info)
  {
      return type_register(info);
  }

  It seems that type_register() and type_register_static() are the same.
  I guess I could clean up one of them, right? (type_register() was added
  by your earlie commit 049cb3cfdac1 :-) ).

Thanks,
Zhao


