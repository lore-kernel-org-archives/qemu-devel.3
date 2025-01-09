Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873A7E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBgA-00047k-Cp; Fri, 10 Jan 2025 04:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tWBg8-00047Z-M6
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:51:44 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tWBg6-0002ls-PD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736502702; x=1768038702;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dlRCjbceXiOhOjqzagMQ1Mu3ZftwOVkJg5fOlUkDJqE=;
 b=UqE61tNcbfXkvsakmOj8evuGEy9XEMN0K2FEolScWwnhPpLE3E2FNyDJ
 69tjkpUmV/Q5GqApsKhsWXJEFkwTO/oPWs8kGqMU4E2GwVCGPQ4O3vLHh
 VGEa6BYvsfY7j/9jF33P/7IX6errOpmcWLZbrdNUuyYCMT0Pb/+Kz6qY3
 2H0GOxfUG4eubAVK16CKHclJeczMbCZvYHX6A9tv+Um4r9SsbTsKqiu3n
 Rl7i/Mp1P42vSR55XNZlOwQKes4ZvePzv3vNvkF2SpkoEDusEJ+aosYhU
 ZyVi9U6pyS4jUFIb4le6UPbJykC/Gymuji3xX2Pq6gA9gCyBD49+Qwt4o g==;
X-CSE-ConnectionGUID: PDy6L8/uT7mC4r6QE50RRg==
X-CSE-MsgGUID: wuGqFcjZQwmlXspu3Zf+8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47458148"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="47458148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 01:51:40 -0800
X-CSE-ConnectionGUID: sfEaav1hRwedm1aEQy2Pzg==
X-CSE-MsgGUID: +GZZj3wXT8K8qCwrRmn3Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="104245902"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by fmviesa009.fm.intel.com with ESMTP; 10 Jan 2025 01:51:37 -0800
Date: Fri, 10 Jan 2025 05:50:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z4BEqnzkfN2yQg63@yilunxu-OptiPlex-7050>
References: <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <219a4a7a-7c96-4746-9aba-ed06a1a00f3e@amd.com>
 <58b96b74-bf9c-45d3-8c2e-459ec2206fc8@intel.com>
 <8c8e024d-03dc-4201-8038-9e9e60467fad@amd.com>
 <ca9bc239-d59b-4c53-9f14-aa212d543db9@intel.com>
 <4d22d3ce-a5a1-49f2-a578-8e0fe7d26893@amd.com>
 <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <Z4A45glfrJtq2zS2@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4A45glfrJtq2zS2@yilunxu-OptiPlex-7050>
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=yilun.xu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.436, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 10, 2025 at 05:00:22AM +0800, Xu Yilun wrote:
> > > 
> > > https://github.com/aik/qemu/commit/3663f889883d4aebbeb0e4422f7be5e357e2ee46
> > > 
> > > but I am not sure if this ever saw the light of the day, did not it?
> > > (ironically I am using it as a base for encrypted DMA :) )
> > 
> > Yeah, we are doing the same work. I saw a solution from Michael long
> > time ago (when there was still
> > a dedicated hostmem-memfd-private backend for restrictedmem/gmem)
> > (https://github.com/AMDESE/qemu/commit/3bf5255fc48d648724d66410485081ace41d8ee6)
> > 
> > For your patch, it only implement the interface for
> > HostMemoryBackendMemfd. Maybe it is more appropriate to implement it for
> > the parent object HostMemoryBackend, because besides the
> > MEMORY_BACKEND_MEMFD, other backend types like MEMORY_BACKEND_RAM and
> > MEMORY_BACKEND_FILE can also be guest_memfd-backed.
> > 
> > Think more about where to implement this interface. It is still
> > uncertain to me. As I mentioned in another mail, maybe ram device memory
> > region would be backed by guest_memfd if we support TEE IO iommufd MMIO
> 
> It is unlikely an assigned MMIO region would be backed by guest_memfd or be
> implemented as part of HostMemoryBackend. Nowadays assigned MMIO resource is
> owned by VFIO types, and I assume it is still true for private MMIO.
> 
> But I think with TIO, MMIO regions also need conversion. So I support an
> object, but maybe not guest_memfd_manager.

Sorry, I mean the name only covers private memory, but not private MMIO.

> 
> Thanks,
> Yilun
> 
> > in future. Then a specific object is more appropriate. What's your opinion?
> > 
> 

