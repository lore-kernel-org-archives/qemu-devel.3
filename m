Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6657AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 13:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzyxY-0001he-8X; Thu, 25 Apr 2024 09:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzyxR-0001bD-OJ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:16:14 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzyxQ-0005u0-2g
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 09:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714050972; x=1745586972;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=A7f0OsES/K/K9v4IClIZ7cqsYibhqcI2JSwwGXJ6xNw=;
 b=lgH/0nNWAIvnjnmnr/8MP+JrkVKXwQNVyCkaG3LpAxIeGQHnH9W4ZJqY
 bA4cpAAIxtJFE6yJcftF8eDipt8OwZAgFAOyRYCTe/yY9mPFVlBhKfNqH
 mFrri7lDc24Q8Bf34+MX8euMSG0P+BJI3KL0yW5YC4mp8xkd6BTLsezGT
 T6zgao1NWt5kRVNq7ZIvLPh9PASBykGuHLwuhzWe16hrSZSXEkqWhHiv3
 LBxCyU0q00PF5MtGfxMJscpb7H0jojH8yOiAjOxItdOrNXflXyYKlgYuu
 lIWQDzXNgJCdup1W4tIQnJMEv+HHexUkvFzsOxlAZO/ad+X1tiwwA1Mtc Q==;
X-CSE-ConnectionGUID: c7jclAOLQeC1qx6rZq/jOQ==
X-CSE-MsgGUID: hh/6w/eASRyfF0yHf0AccQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20348995"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="20348995"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 06:16:09 -0700
X-CSE-ConnectionGUID: fguQEXsaRAWXjkNkDjn9yA==
X-CSE-MsgGUID: OLHVs+TySlWYQflJ8I97Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="25017696"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 25 Apr 2024 06:16:05 -0700
Date: Thu, 25 Apr 2024 21:30:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v11 00/21] i386: Introduce smp.modules and clean up cache
 topology
Message-ID: <Zipa4+Hc3WS51sGB@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
 <a76a987f-3ea2-4c48-bc02-74ab42fd3c01@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a76a987f-3ea2-4c48-bc02-74ab42fd3c01@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

On Thu, Apr 25, 2024 at 10:06:11AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu, 25 Apr 2024 10:06:11 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v11 00/21] i386: Introduce smp.modules and clean up
>  cache topology
> 
> Hi Zhao,
> 
> On 24/4/24 17:49, Zhao Liu wrote:
> 
> > ---
> > Zhao Liu (20):
> >    hw/core/machine: Introduce the module as a CPU topology level
> >    hw/core/machine: Support modules in -smp
> >    hw/core: Introduce module-id as the topology subindex
> >    hw/core: Support module-id in numa configuration
> 
> To reduce this series size, I'm taking these 4 patches to via
> my hw-misc tree.
>

Thanks Philippe! Will add module level test in tests/unit/test-smp-parse.c.

Regards,
Zhao


