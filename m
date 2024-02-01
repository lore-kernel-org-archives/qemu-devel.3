Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9D0C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZRb-00064g-P7; Thu, 01 Feb 2024 10:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVZRa-00062h-Jh
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:57:38 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVZRY-0005fQ-2v
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706803056; x=1738339056;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=h1q4KvAJn4CIoLG3naX5sp1wYlxPpERj17PvK1eyhmQ=;
 b=NTg1ee7ra+biomx/f7PeZtb4EMyQFswTj1yuq9SvXrILDXVQ9tl6sMeA
 7SuLBoZDOF7hjGkVTwWb7uQPJVGwvWoPUtsZemLwL22T2bPAiRtBMq8qI
 jf1XcFSPfbnVozHGBOHPCCP7+kz9Lbh6XRIUeh3THmn/wmbma0T4nNiB8
 BI2F4SJStR0zyxcJP+wReE7Ok8sPaTxWNCtnGXDBM52MVQuywC+WzBiDj
 fxiwxckUJsVBillhybbRxyF06dX5Js5XkmwD1cU2dCTT57WY0DGjz0XuF
 Ji6jHbYNwHDXxrkZLBRyBnVAoO0J0dSEgmDFov6w/qJjbxOF47YC0+duC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3792440"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3792440"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 07:57:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4440963"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 01 Feb 2024 07:57:28 -0800
Date: Fri, 2 Feb 2024 00:10:58 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 00/21] Introduce smp.modules for x86 in QEMU
Message-ID: <ZbvCktGZFj4v3I/P@intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
 <Zbog2vDrrWFbujrs@redhat.com> <ZbsInI6Z66edm3eH@intel.com>
 <ZbtirK-orqCb5sba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbtirK-orqCb5sba@redhat.com>
Received-SPF: none client-ip=198.175.65.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Thu, Feb 01, 2024 at 09:21:48AM +0000, Daniel P. Berrangé wrote:
> Date: Thu, 1 Feb 2024 09:21:48 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v8 00/21] Introduce smp.modules for x86 in QEMU
> 
> On Thu, Feb 01, 2024 at 10:57:32AM +0800, Zhao Liu wrote:
> > Hi Daniel,
> > 
> > On Wed, Jan 31, 2024 at 10:28:42AM +0000, Daniel P. Berrangé wrote:
> > > Date: Wed, 31 Jan 2024 10:28:42 +0000
> > > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > > Subject: Re: [PATCH v8 00/21] Introduce smp.modules for x86 in QEMU
> > > 
> > > On Wed, Jan 31, 2024 at 06:13:29PM +0800, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > [snip]
> > 
> > > > However, after digging deeper into the description and use cases of
> > > > cluster in the device tree [3], I realized that the essential
> > > > difference between clusters and modules is that cluster is an extremely
> > > > abstract concept:
> > > >   * Cluster supports nesting though currently QEMU doesn't support
> > > >     nested cluster topology. However, modules will not support nesting.
> > > >   * Also due to nesting, there is great flexibility in sharing resources
> > > >     on clusters, rather than narrowing cluster down to sharing L2 (and
> > > >     L3 tags) as the lowest topology level that contains cores.
> > > >   * Flexible nesting of cluster allows it to correspond to any level
> > > >     between the x86 package and core.
> > > > 
> > > > Based on the above considerations, and in order to eliminate the naming
> > > > confusion caused by the mapping between general cluster and x86 module
> > > > in v7, we now formally introduce smp.modules as the new topology level.
> > > 
> > > What is the Linux kernel calling this topology level on x86 ?
> > > It will be pretty unfortunate if Linux and QEMU end up with
> > > different names for the same topology level.
> > > 
> > 
> > Now Intel's engineers in the Linux kernel are starting to use "module"
> > to refer to this layer of topology [4] to avoid confusion, where
> > previously the scheduler developers referred to the share L2 hierarchy
> > collectively as "cluster".
> > 
> > Looking at it this way, it makes more sense for QEMU to use the
> > "module" for x86.
> 
> I was thinking specificially about what Linux calls this topology when
> exposing it in sysfs and /proc/cpuinfo. AFAICT, it looks like it is
> called 'clusters' in this context, and so this is the terminology that
> applications and users are going to expect.

The cluster related topology information under "/sys/devices/system/cpu/
cpu*/topology" indicates the L2 cache topology (CPUID[0x4]), not module
level CPU topology (CPUID[0x1f]).

So far, kernel hasn't exposed module topology related sysfs. But we will
add new "module" related information in sysfs. The relevant patches are
ready internally, but not posted yet.

In the future, we will use "module" in sysfs to indicate module level CPU
topology, and "cluster" will be only used to refer to the l2 cache domain
as it is now.

> 
> I think it would be a bad idea for QEMU to diverge from this and call
> it modules.
>

This patch set mainly tries to configure the module level CPU topology
for Guest, which will be aligned with the future module information in
the sysfs, so that it doesn't violate the kernel x86 arch's definition
or current end users' expectation for x86's cluster.

Thanks,
Zhao


