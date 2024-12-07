Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC96E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 15:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJwRz-0000Oa-Ko; Sat, 07 Dec 2024 10:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwRx-0000O2-Lu; Sat, 07 Dec 2024 10:10:29 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJwRu-0007Zh-KU; Sat, 07 Dec 2024 10:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733584227; x=1765120227;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hEOMO+s5ITh0FXxHeRtqOuIFYoHEToLGubNZISpkVQo=;
 b=aOKShgldaZXTZQ4Nqu58FsOE6kgUYJP9HVhbyevZ+/8MBDYnuaMqewNC
 zcejCmLH4eU+ezF//6rc7pRy7uovhkpOkDecqMBTMoYx6hhD3XuRuk+0L
 xHlczAurBaYYMfb1ZCEHz3zAYER/f3AhbDc25T4zFnqxmxs7y/e4ZnT0k
 8x94UGSE0sZZkbnu9UN6JTZEIYwbMHVLkgVGEvkfgy7v0V6AJeIsRi2Xr
 /hx4BBVpyUQuteE6Sjb6YLKrEtAdQDmo+/Nhb4MwLLEKMEbcN9fuC0gPB
 60pxRrWf8I+l3P09TUg0dAtYhxoF/8cLawhj2KuJ9R03GSe5JDtGz+kFk g==;
X-CSE-ConnectionGUID: 8iaiRFYcQGKcACe9Y3eipQ==
X-CSE-MsgGUID: uS1YRyIMTxWpfwlfiuj/SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34167033"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="34167033"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2024 07:10:22 -0800
X-CSE-ConnectionGUID: 8Q/XD6z0RSqdCJfOSyokUw==
X-CSE-MsgGUID: 4akUnClOTOyA99YnQ+lUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; d="scan'208";a="125574284"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 07 Dec 2024 07:10:19 -0800
Date: Sat, 7 Dec 2024 23:28:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
Message-ID: <Z1RpoNPgL3PCXAWB@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <1da970e8-1708-48ef-87c4-1099d23e8909@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da970e8-1708-48ef-87c4-1099d23e8909@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

Hi Paolo,

Sorry for late reply,

On Thu, Dec 05, 2024 at 04:30:15PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 16:30:15 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > HPET device needs to access and update hpet_cfg variable, but now it is
> > defined in hw/i386/fw_cfg.c and Rust code can't access it.
> > 
> > Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
> > allows Rust HPET device implements its own global hpet_fw_cfg variable,
> > and will further reduce the use of unsafe C code access and calls in the
> > Rust HPET implementation.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/i386/fw_cfg.c        |  4 +---
> >   hw/timer/hpet.c         | 16 +++++++++-------
> >   include/hw/timer/hpet.h |  2 +-
> >   3 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > index 0e4494627c21..965e6306838a 100644
> > --- a/hw/i386/fw_cfg.c
> > +++ b/hw/i386/fw_cfg.c
> > @@ -26,8 +26,6 @@
> >   #include CONFIG_DEVICES
> >   #include "target/i386/cpu.h"
> > -struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
> 
> This breaks if you disable HPET, which is why fw_cfg.c defines it.

Thanks! I did miss this case.

> You can do something like
> 
> diff --git a/include/hw/timer/hpet-fw-cfg.h b/include/hw/timer/hpet-fw-cfg.h
> new file mode 100644
> index 00000000000..234a49fc92e
> --- /dev/null
> +++ b/include/hw/timer/hpet-fw-cfg.h
> @@ -0,0 +1,16 @@
> +struct hpet_fw_entry
> +{
> +    uint32_t event_timer_block_id;
> +    uint64_t address;
> +    uint16_t min_tick;
> +    uint8_t page_prot;
> +} QEMU_PACKED;
> +
> +struct hpet_fw_config
> +{
> +    uint8_t count;
> +    struct hpet_fw_entry hpet[8];
> +} QEMU_PACKED;
> +
> +extern struct hpet_fw_config hpet_fw_cfg;
> +
> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> index d17a8d43199..6f7fcbc3c60 100644
> --- a/include/hw/timer/hpet.h
> +++ b/include/hw/timer/hpet.h
> @@ -60,26 +60,12 @@
>  #define HPET_TN_INT_ROUTE_CAP_SHIFT 32
>  #define HPET_TN_CFG_BITS_READONLY_OR_RESERVED 0xffff80b1U
> -struct hpet_fw_entry
> -{
> -    uint32_t event_timer_block_id;
> -    uint64_t address;
> -    uint16_t min_tick;
> -    uint8_t page_prot;
> -} QEMU_PACKED;
> -
> -struct hpet_fw_config
> -{
> -    uint8_t count;
> -    struct hpet_fw_entry hpet[8];
> -} QEMU_PACKED;
> -
> -extern struct hpet_fw_config hpet_cfg;
> -
>  #define TYPE_HPET "hpet"
>  #define HPET_INTCAP "hpet-intcap"
> +#include "hw/timer/hpet-fw-cfg.h"
> +
>  static inline bool hpet_find(void)
>  {
>      return object_resolve_path_type("", TYPE_HPET, NULL);
> diff --git a/rust/wrapper.h b/rust/wrapper.h
> index 285d0eb6ad0..82381e43472 100644
> --- a/rust/wrapper.h
> +++ b/rust/wrapper.h
> @@ -62,3 +62,4 @@ typedef enum memory_order {
>  #include "qapi/error.h"
>  #include "migration/vmstate.h"
>  #include "chardev/char-serial.h"
> +#include "hw/timer/hpet-fw-cfg.h"
> 

Thank you very much for this example!

> but you will have to use unsafe to access it since it's a "static mut".

I also noticed Philippe's version. And I prefer Phillippe's version,
although his version requires more changes to the rust version, it
provides an opportunity to add more field to the QOM class, so I feel
it's good to check current rust qom class support.

Regrads,
Zhao


