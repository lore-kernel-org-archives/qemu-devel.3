Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD321CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 10:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkcM-0003Rj-4R; Mon, 07 Oct 2024 06:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxkcJ-0003RB-MY; Mon, 07 Oct 2024 06:05:28 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxkcG-0007hD-Jc; Mon, 07 Oct 2024 06:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728295525; x=1759831525;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AnOcALsZJg/wxyrcnpW+cGt1cV5NfTexgZo0XTBcLLw=;
 b=cn/Dypl5g3XxaTJsowQRA46wHK0Mvj+ndpx+BYpkOU2DYtg8bFTHXwqO
 DXgRUffbUhn9wBC0UfF0+t8D/l7xNwTb2lazCN1YspFB3UzFbDrgnS/IJ
 8zWL4vas7yk6k/F3lZWQn3gNpFVW6DxFRyq59NenrsNsHw3nZaOri2hlO
 ay9K6lb8htyS8NO70GqL98ROae/WodMoKJGsHrR3M9QjlJVVkov4gIPmD
 3jRwde0NB/bahzT4HoCWqGWtbrGbcz32+GHARecx+JuYtsB829kI3/TQV
 Spp1rbsny+AfZv5uAFLsF++oYz3H8LX0dsMFeOhs5l9KSvvkSLiJ6dr8d A==;
X-CSE-ConnectionGUID: W/gsPrPySUW6uC/UpZ0fNQ==
X-CSE-MsgGUID: uudJT6i4ThWkSsE+hNOGpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27319853"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="27319853"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 03:05:19 -0700
X-CSE-ConnectionGUID: 7gJQIEZzT8mpzKFWqrHFdQ==
X-CSE-MsgGUID: ogeD7LVYT4KOliHP51MW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="75258677"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 07 Oct 2024 03:05:13 -0700
Date: Mon, 7 Oct 2024 18:21:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 6/7] i386/cpu: Update cache topology with machine's
 configuration
Message-ID: <ZwO2JIMJ+lX0N61h@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20240908125920.1160236-7-zhao1.liu@intel.com>
 <20240911110028.00001d3d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911110028.00001d3d@huawei.com>
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

Hi Ali,

[snip]

> > +
> > +    /*
> > +     * TODO: Add a SMPCompatProps.has_caches flag to avoid useless
> > Updates
> > +     * if user didn't set smp_cache.
> > +     */
> Hi Zhao,
> 
> Thanks for sending this patchset so quickly. I really appreciate the
> TODO already :)

Welcome! And I'm also sorry for a long silence. Now I'm back from the
vacation and will keep pushing this series forward.

> It also helps me avoid going through every single
> layer, especially when I want to avoid matching system registers in
> ARM, particularly when there's no description in the command line.

Great! I also noticed your patch for this "TODO" and will help you
review it soon.

Regards,
Zhao

> > +    x86_cpu_update_smp_cache_topo(ms, cpu);
> > +
> >      qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
> >  
> >      if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus >
> > 1) {
> 


