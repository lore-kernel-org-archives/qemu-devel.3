Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DE2C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyuS-0005m4-GW; Tue, 12 Mar 2024 05:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjyuQ-0005jJ-VG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:58:58 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjyuP-0000TT-2L
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710237537; x=1741773537;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Y6VdP9faqh72Mn6LhmNnwRXRt34XCvhHGJdaTZngvro=;
 b=YWeULdGXQS4BDGFDsCIqd+Ez+gFu0km5J2WhmtsjUH2NGyICvAlYG2oX
 VKRidzGuvw/nW0JBWt+/jdCTAvZc756OVny0+eL1UVnGd2mdBJ7/Vz4f3
 Wr0W/aIA3jzEX7sZ3vfzGytO9TSZ8EYK/ckioeXxyh1T08914Miaqa6/A
 X0SzET2Gsz3yw4em4Qed1dSjtVmV3VDZrvZrSIJgJzE5dDFGAWqobDwOV
 u1fjwEDxAuSM48c6ImrEJw9yVrgabPIQDYPAjvwIQr/4UaYsosybJsZ8j
 KG4p8o99xEAMyJp66KHar1O0oVDyGn8kGq7Fp0V+Pwpt3iA7dEopDmxWC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5109253"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5109253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 02:58:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11560026"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 12 Mar 2024 02:58:48 -0700
Date: Tue, 12 Mar 2024 18:12:38 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 02/21] hw/core/machine: Support modules in -smp
Message-ID: <ZfAqltds4Bcr2Ruj@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-3-zhao1.liu@linux.intel.com>
 <e730da3c-42be-45d0-aa11-279ee47bb933@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e730da3c-42be-45d0-aa11-279ee47bb933@linux.intel.com>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> > @@ -51,6 +51,10 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
> >           g_string_append_printf(s, " * clusters (%u)", ms->smp.clusters);
> >       }
> > +    if (mc->smp_props.modules_supported) {
> > +        g_string_append_printf(s, " * modules (%u)", ms->smp.clusters);
> > +    }
> 
> smp.clusters -> smp.modules?
>

Good catch! Thanks!

-Zhao


