Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6561ACFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 10:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlPk-0007ej-UN; Mon, 07 Oct 2024 06:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxlPh-0007di-TC; Mon, 07 Oct 2024 06:56:29 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxlPe-0004z3-UC; Mon, 07 Oct 2024 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728298587; x=1759834587;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T1pqoP48M8l988CxvjsXIyPgrv7G7BxcyDze1mpyE/g=;
 b=PSda4WVCxsRP1Fu0p+DgAXv6GsieeyI/FwxIQaIt1XjQEakCNdunGj3R
 d4IlBHNWe+v41AqvjXEjuE506JBHbOnsepoKtN3O8NfUs6km1c/vp5mEn
 Hm1Hp3EOcGaXU2TQgqX+kmUStnvppfUm75ZL81TgFB050hmAEjER6LhDT
 oEd91GhczRWgzt1AjKbzw+g2g4wSIgTZ2jYWeejhISDlAflKpQOysEr2E
 KrNisqF8pk7nQSY5LhVlztdNU+jaHnWe8NWBa1FmbiSlqCOI/WxjXtOGY
 L46kvEyIU/kmiAt9lO1PB7zLJgMIu7ua3ajMdPIsO+DPy9CTgN2JnPZbE Q==;
X-CSE-ConnectionGUID: PGKnFSfKRXiidtcchUfgPQ==
X-CSE-MsgGUID: AlnYhhOMSWa/OzsX6ptFtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27326412"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="27326412"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 03:56:23 -0700
X-CSE-ConnectionGUID: 2Af7pHfOTv2AjgyS9bkogA==
X-CSE-MsgGUID: g1Mh539KQ7ijgVOrKBrE7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="75109678"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 07 Oct 2024 03:56:19 -0700
Date: Mon, 7 Oct 2024 19:12:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 4/7] hw/core: Check smp cache topology support for
 machine
Message-ID: <ZwPCHRRdYD6/S7GN@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20240908125920.1160236-5-zhao1.liu@intel.com>
 <20240917095612.00007b5a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917095612.00007b5a@Huawei.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Sep 17, 2024 at 09:56:12AM +0100, Jonathan Cameron wrote:
> Date: Tue, 17 Sep 2024 09:56:12 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [PATCH v2 4/7] hw/core: Check smp cache topology support for
>  machine
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Sun,  8 Sep 2024 20:59:17 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Add cache_supported flags in SMPCompatProps to allow machines to
> > configure various caches support.
> > 
> > And check the compatibility of the cache properties with the
> > machine support in machine_parse_smp_cache().
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> 
> Just a few trivial comments inline.
> 
> FWIW with or without those changes.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

[snip]

> > +        /*
> > +         * Allow setting "default" topology level even though the cache
> > +         * isn't supported by machine.
> I'd flip the comment as the condition is doing the opposite.

OK, it's more intuitive.

>             * Reject non "default" topology level if the cache isn't
>             * supported by the machine.
> > +         */
> > +        if (props->topology != CPU_TOPOLOGY_LEVEL_DEFAULT &&
> > +            !mc->smp_props.cache_supported[props->cache]) {
> > +            error_setg(errp,
> > +                       "%s cache topology not supported by this machine",
> > +                       CacheLevelAndType_str(node->value->cache));
> > +            return false;
> > +        }
> > +
> > +        if (!machine_check_topo_support(ms, props->topology, errp)) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    if (smp_cache_topo_cmp(&ms->smp_cache,
> > +                           CACHE_LEVEL_AND_TYPE_L1D,
> 
> Short line wrap.  Maybe combine the two lines above and similar
> cases.

Like this?

smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1D,
                   CACHE_LEVEL_AND_TYPE_L2)

> Up to you though, I don't feel that strongly.
> 
> > +                           CACHE_LEVEL_AND_TYPE_L2) ||
> > +        smp_cache_topo_cmp(&ms->smp_cache,
> > +                           CACHE_LEVEL_AND_TYPE_L1I,
> > +                           CACHE_LEVEL_AND_TYPE_L2)) {
> > +        error_setg(errp,
> > +                   "Invalid smp cache topology. "
> > +                   "L2 cache topology level shouldn't be lower than L1 cache");
> > +        return false;
> > +    }
> > +

Regards,
Zhao


