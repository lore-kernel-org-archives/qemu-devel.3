Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA69EE67495
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 02:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6hHr-0000fr-St; Thu, 31 Oct 2024 22:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6hHp-0000fH-DT; Thu, 31 Oct 2024 22:21:17 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6hHm-0004sb-3a; Thu, 31 Oct 2024 22:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730427674; x=1761963674;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=f5edtnaWl0000c3Tv65SjcYIpMNCaJtIb4m9wYByLX8=;
 b=ePV5flvjCVnmkS5CcblCdBZU+Rbp11OEMBej53fJ8Jh5yzzOhYE60vd2
 Q3cZALcAK2yc8Xto3RylZAFVHkqxRpRMZxIhHccc/2/RzkrhcF61HKTo4
 L4PCPlntf+LiuEnvPdjB6PfEL2w+lvO1QnUMIsXrcNQKya9ijxVo9lDCw
 akTgdzuYlNi8nX5A6OYjVyrH6eX0frp9iSikHtMzckX5D5CbskCZZquCI
 1mHHI4l28OR/1uPQGyRpmih4OgZ/TT53z0PSx/QP6ZZ2HZxVHNjgXOy1t
 a5S5ZcqMwQPoDMS2ABIazq35n5u0Ni0hnkAMe9y+6qbBaZt3Uv7olblE3 A==;
X-CSE-ConnectionGUID: CyK4vJ7aQoO5b/Ntpo0tdg==
X-CSE-MsgGUID: EwCUIV4yQRS0DbGqPs8UWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30082694"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="30082694"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 19:21:11 -0700
X-CSE-ConnectionGUID: FmrdQIZqQ9a0t/TsjpyEKg==
X-CSE-MsgGUID: nzCFyinlQqu3gqOKIYVunQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; d="scan'208";a="82502436"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 31 Oct 2024 19:21:05 -0700
Date: Fri, 1 Nov 2024 10:38:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v4 2/9] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZyQ/QJnTPvo9wO+H@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
 <20241022135151.2052198-3-zhao1.liu@intel.com>
 <31e8dc51-f70f-44eb-a768-61cfa50eed5b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e8dc51-f70f-44eb-a768-61cfa50eed5b@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Phil,

> > -static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
> > +static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
> >   {
> >       switch (topo_level) {
> > -    case CPU_TOPO_LEVEL_INVALID:
> > +    case CPU_TOPOLOGY_LEVEL_INVALID:
> 
> Since we use an enum, I'd rather directly use CPU_TOPOLOGY_LEVEL__MAX.
>
> Or maybe in this case ...
> 
> >           return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
> > -    case CPU_TOPO_LEVEL_SMT:
> > +    case CPU_TOPOLOGY_LEVEL_THREAD:
> >           return CPUID_1F_ECX_TOPO_LEVEL_SMT;
> > -    case CPU_TOPO_LEVEL_CORE:
> > +    case CPU_TOPOLOGY_LEVEL_CORE:
> >           return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> > -    case CPU_TOPO_LEVEL_MODULE:
> > +    case CPU_TOPOLOGY_LEVEL_MODULE:
> >           return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
> > -    case CPU_TOPO_LEVEL_DIE:
> > +    case CPU_TOPOLOGY_LEVEL_DIE:
> >           return CPUID_1F_ECX_TOPO_LEVEL_DIE;
> >       default:
>            /* Other types are not supported in QEMU. */
>            g_assert_not_reached();
> 
> ... return CPUID_1F_ECX_TOPO_LEVEL_INVALID as default.

I prefer the first way you mentioned since I want "default" to keep
to detact unimplemented levels.

> Can be cleaned on top, so:

Yes, I'll rebase (now there's the conflict) with this fixed.

> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

Regards,
Zhao


