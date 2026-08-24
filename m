Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A9C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNQU-0000OG-JO; Mon, 24 Aug 2026 01:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNQS-0000Nz-Dv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:40:52 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wyNQQ-0000HR-SE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787550051; x=1819086051;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2wurZ0LMMZVTeMFjDnaTknvyiVroSys9HuDkS66ihfg=;
 b=Uqu3M9/Wun/zgvwDXKptMW4c42T3wJP5+v/naOJsbg8MmBClgOYhoSMP
 H2usjVWlmE0lC47eqK6MVjGwpcEp88HYeWVkrfc7EvRPDA67T5WU7GR+E
 Xl3qYgCGXjd1TI2Y6/IqVUmrQT/whuVD6HK3f65S36DbcWwJWV8kfR+xe
 E7tlBUFDd+wKZwFMYMn01e7tiZOEvTbFasmDK331hd9EICHDiUeGi6rUP
 Qjv6l/OADHrKh8/ffuqP3W5YE/gXLk0v+8PPWWmkFyNGXPlQygqTDoxFO
 0k6Y/kru6+XMIrwpoinPN32zxcunz/HAhwlxuY7jsrOan3CzGvceKRTY4 g==;
X-CSE-ConnectionGUID: IwoMlyJTSkW/cK9eUjBXqA==
X-CSE-MsgGUID: XI8RF+EaS5K3K4BrwvFNrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98582246"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="98582246"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 22:40:49 -0700
X-CSE-ConnectionGUID: hDnCE9y2Q2C+HmtvHQtjUw==
X-CSE-MsgGUID: 4n02n5I0RKC/+IY0rv/OgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="267473279"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa009.jf.intel.com with ESMTP; 23 Aug 2026 22:40:47 -0700
Date: Mon, 24 Aug 2026 13:40:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v3 08/10] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
Message-ID: <aovZXpnT+Qc2MFtn@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-9-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-9-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 24, 2026 at 12:53:12PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:12 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 08/10] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> pc_memory_init() avoids the AMD IOMMU HyperTransport range below 1 TiB
> only for AMD vCPUs.  Dhyana therefore allows RAM, hotplug address space,
> or 64-bit PCI MMIO to overlap 0xfd00000000-0xffffffffff.
> 
> Linux supports Dhyana platforms in the AMD IOMMU driver.  The driver
> reports this range as reserved unless the IOMMU advertises
> FEATURE_HT_RANGE_IGNORE.  A VFIO device cannot DMA to guest addresses
> that QEMU places in the reserved range: VFIO_DMA_MAP may fail with
> -EINVAL, or the IOMMU may report an INVALID_DEVICE_REQUEST fault.
> 
> Apply the AMD IOMMU HT GPA layout to Hygon vCPUs.  When the possible
> address space reaches the reserved range, move RAM above 4 GiB to 1 TiB;
> also expose the range as reserved in E820 when the vCPU can address it.
> 
> Changing the GPA layout affects migration, so enable the Hygon behavior
> through x-hygon-vendor-abi-fixes.  pc-11.1 and older machine types retain
> their previous Hygon layout.  The existing enforce_amd_1tb_hole setting
> continues to preserve the AMD layout of pc/q35 machine types through 7.0.
> 
> Add functional tests for Dhyana with pc-q35-11.2 and with pc-q35-11.1
> compatibility.
> 
> Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  hw/i386/pc.c                                  | 26 ++++++++++----
>  .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


