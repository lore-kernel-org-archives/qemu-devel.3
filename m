Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23832C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfahA-00087Z-Rr; Thu, 29 Feb 2024 02:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfah7-00086N-6J
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:19:06 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfagv-0005kH-HU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709191134; x=1740727134;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FksyTE5xE6utTs6Z84kouzUz1HB+0g/sw29I3SdVZBo=;
 b=dO+owLmoTeYTo5yangEtsuGaZYy/7CFI4KhZRtq45id/gNrRtI2/qJPR
 QyZIgnKWgiNAD14/GDGhvNbFbZUgee1Qf3c3/pLH7h7/hKgLjrbPlus7M
 lYzIZ0r+M+vDsfVCMDRFqFb6/MOM1QM4xlMMq/4uUoOqaKZPAR/ppHf45
 uvRtIJ0gml3JYNJMamzSgp9bRojQLaws/04+4FbAIOWMUYHkgfiQKzKmI
 RLUAwGYDXovd5s5ULkdnd3Ww1XM0w9qcJWOJjET/cVD+2cefaeAZbizRL
 /ryoXl7w1juLWBTJQ35TLAKm/4U+dnsT8KjcSh4WTyXVcdcguTteskfM3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3765930"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3765930"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 23:18:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="12422234"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 28 Feb 2024 23:18:40 -0800
Date: Thu, 29 Feb 2024 15:32:23 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
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
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 18/21] hw/i386/pc: Support smp.modules for x86 PC
 machine
Message-ID: <ZeAzB/ISM+g/XGa3@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-19-zhao1.liu@linux.intel.com>
 <3ab53ea9-be77-4ee7-9247-d89c0ec62346@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab53ea9-be77-4ee7-9247-d89c0ec62346@amd.com>
Received-SPF: none client-ip=198.175.65.18;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Babu,

> >  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> >      "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"

Here the "drawers" and "books" are listed...

> > -    "               [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
> > +    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
> > +    "               [,threads=threads]\n"
> >      "                set the number of initial CPUs to 'n' [default=1]\n"
> >      "                maxcpus= maximum number of total CPUs, including\n"
> >      "                offline CPUs for hotplug, etc\n"
> > @@ -290,7 +291,8 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> >      "                sockets= number of sockets in one book\n"
> >      "                dies= number of dies in one socket\n"
> >      "                clusters= number of clusters in one die\n"
> > -    "                cores= number of cores in one cluster\n"
> > +    "                modules= number of modules in one cluster\n"
> > +    "                cores= number of cores in one module\n"
> >      "                threads= number of threads in one core\n"
> >      "Note: Different machines may have different subsets of the CPU topology\n"
> >      "      parameters supported, so the actual meaning of the supported parameters\n"
> > @@ -306,7 +308,7 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> >      "      must be set as 1 in the purpose of correct parsing.\n",
> >      QEMU_ARCH_ALL)
> >  SRST
> > -``-smp [[cpus=]n][,maxcpus=maxcpus][,sockets=sockets][,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]``
> > +``-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
> 
> You have added drawers, books here. Were they missing before?
> 

...so yes, I think those 2 parameters are missed at this place.

Thank you for reviewing this.

Regards,
Zhao


