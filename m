Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D2E674AB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 07:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6m6N-0006P7-Qs; Fri, 01 Nov 2024 03:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6m6L-0006MR-85; Fri, 01 Nov 2024 03:29:45 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6m6I-0002yc-1H; Fri, 01 Nov 2024 03:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730446182; x=1761982182;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zCzp/PIGXKybGMdD7zEqjUO7m3TWYTbL84DThcBzMAc=;
 b=bCF1G8TaC7n4/At53HoDp6uE9x+sbSTMNBHSbgkykPlmjA5HsPRxCeS4
 m+FQqUUpRE/jdhWAl5m7+OPSZggiJ+CnXHxqMUVcyCHSFk13kWjal3bK3
 9EU6WBhdqTxVnJExst0KAL26xJ59I36wO4bHcBaY2uZDYwkBYZn8UCqQZ
 r6udOYGFiXyLsyTFtoJB83nkJ2OTAAMoaa4p9ActGgf48GGxrBmVpXEEq
 aRq23gJfAZ8zO4m1hOgCNYphtZ0gUuxIhhn7XaFdgrU1uZlnkYZelPIxN
 yb+g+8T4Y2dPpf3HYbTW1ghuY67TAgBNO+vB2R8KhUKtL86K1lMdNSrDz w==;
X-CSE-ConnectionGUID: 4DYfb12JSamvQlT5Mm3H8Q==
X-CSE-MsgGUID: WMCyA9lITEycukF2UR2A2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41310660"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41310660"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2024 00:29:38 -0700
X-CSE-ConnectionGUID: ZWPcl3ReTdugymNGnBrg4Q==
X-CSE-MsgGUID: XL2yI9d/Rymo5iSQ9iMIIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; d="scan'208";a="82777507"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 01 Nov 2024 00:29:33 -0700
Date: Fri, 1 Nov 2024 15:47:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 2/9] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZySHimCbA3qqmjCB@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
 <20241022135151.2052198-3-zhao1.liu@intel.com>
 <31e8dc51-f70f-44eb-a768-61cfa50eed5b@linaro.org>
 <ZyQ/QJnTPvo9wO+H@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyQ/QJnTPvo9wO+H@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, Nov 01, 2024 at 10:38:56AM +0800, Zhao Liu wrote:
> Date: Fri, 1 Nov 2024 10:38:56 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH v4 2/9] hw/core: Make CPU topology enumeration
>  arch-agnostic
> 
> Hi Phil,
> 
> > > -static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
> > > +static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
> > >   {
> > >       switch (topo_level) {
> > > -    case CPU_TOPO_LEVEL_INVALID:
> > > +    case CPU_TOPOLOGY_LEVEL_INVALID:
> > 
> > Since we use an enum, I'd rather directly use CPU_TOPOLOGY_LEVEL__MAX.
> >
> > Or maybe in this case ...
> > 
> > >           return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
> > > -    case CPU_TOPO_LEVEL_SMT:
> > > +    case CPU_TOPOLOGY_LEVEL_THREAD:
> > >           return CPUID_1F_ECX_TOPO_LEVEL_SMT;
> > > -    case CPU_TOPO_LEVEL_CORE:
> > > +    case CPU_TOPOLOGY_LEVEL_CORE:
> > >           return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> > > -    case CPU_TOPO_LEVEL_MODULE:
> > > +    case CPU_TOPOLOGY_LEVEL_MODULE:
> > >           return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
> > > -    case CPU_TOPO_LEVEL_DIE:
> > > +    case CPU_TOPOLOGY_LEVEL_DIE:
> > >           return CPUID_1F_ECX_TOPO_LEVEL_DIE;
> > >       default:
> >            /* Other types are not supported in QEMU. */
> >            g_assert_not_reached();
> > 
> > ... return CPUID_1F_ECX_TOPO_LEVEL_INVALID as default.
> 
> I prefer the first way you mentioned since I want "default" to keep
> to detact unimplemented levels.
> 
 
Ah, when I started working on it, I realized that clearing
CPU_TOPOLOGY_LEVEL_INVALID would reduce the readability of the
encode_topo_cpuid1f(). The encoding rules for the 0x1f leaf are somewhat
complex, so I want the topology (and names) in encode_topo_cpuid1f() to
be as consistent with the spec as possible. Therefore, I will keep this
name! :)


