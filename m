Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E731C47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 03:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTCpd-0000Nk-Eo; Thu, 25 Jan 2024 22:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rTCpb-0000NW-6L
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:24:39 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rTCpY-0006yL-TX
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 22:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706239478; x=1737775478;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FF75bfzHwsPefUZfv9jfTBzifIdfovWTQJGE4vE3df8=;
 b=gSt2Y2rRF7G10fMCCpxI+y/YatfPiUVAzRZSJ6/h8a8r7ntTNfGVhnPu
 KiEulLXu1YNO9ddz92ljP/dphOCXqZ1VOXweYZO9/+QES2sAxJesuTyij
 ax+mD+wie3cyopNu0IDN+fpgdExV0Krd1/5Z5IST03lYgAaIZkb/IMC+V
 pL6VYwMwM7DriKDxW+5gmF4p+o8a9EvjatNDZydL0Wg6YC9SKgkcU5Jmm
 tf0gH3LEpU8xuVBXloLxjZYMgWJzsPRNAYLQ4yDAkPXV5WIyHAtskONh6
 /e5Npw4zij3UphoremRpuFN83YNwnZROY7hAN//JLstPjX9oIV/hauox6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2268278"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2268278"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2024 19:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857292062"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="857292062"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2024 19:24:24 -0800
Date: Fri, 26 Jan 2024 11:37:27 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v7 10/16] i386/cpu: Introduce cluster-id to X86CPU
Message-ID: <ZbMo92iW9KL3M6et@intel.com>
References: <ZaTJyea4KMMk6x/m@intel.com>
 <1c58dd98-d4f6-4226-9a17-8b89c3ed632e@intel.com>
 <ZaVMq3v6yPoFARsF@intel.com>
 <f9f675c2-9e53-4673-a232-89b72150f092@intel.com>
 <Zaor6d1Vl/RLbqMk@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zaor6d1Vl/RLbqMk@intel.com>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

Hi Xiaoyao,

> > > > generic cluster just means the cluster of processors, i.e, a group of
> > > > cpus/lps. It is just a middle level between die and core.
> > > 
> > > Not sure if you mean the "cluster" device for TCG GDB? "cluster" device
> > > is different with "cluster" option in -smp.
> > 
> > No, I just mean the word 'cluster'. And I thought what you called "generic
> > cluster" means "a cluster of logical processors"
> > 
> > Below I quote the description of Yanan's commit 864c3b5c32f0:
> > 
> >     A cluster generally means a group of CPU cores which share L2 cache
> >     or other mid-level resources, and it is the shared resources that
> >     is used to improve scheduler's behavior. From the point of view of
> >     the size range, it's between CPU die and CPU core. For example, on
> >     some ARM64 Kunpeng servers, we have 6 clusters in each NUMA node,
> >     and 4 CPU cores in each cluster. The 4 CPU cores share a separate
> >     L2 cache and a L3 cache tag, which brings cache affinity advantage.
> > 
> > What I get from it, is, cluster is just a middle level between CPU die and
> > CPU core.
> 
> Here the words "a group of CPU" is not the software concept, but a hardware
> topology.

When I found this material:

https://www.kernel.org/doc/Documentation/devicetree/bindings/cpu/cpu-topology.txt

I realized the most essential difference between cluster and module is
that cluster supports nesting, i.e. it can have nesting clusters as a
layer of CPU topology.

Even though QEMU's description of cluster looked similar to module when
it was introduced, it is impossible to envision whether ARM/RISCV and
other device tree-based arches will continue to introduce nesting
clusters in the future.

To avoid potential conflicts, it would be better to introduce modules
for x86 to differentiate them from clusters.

Thanks,
Zhao


