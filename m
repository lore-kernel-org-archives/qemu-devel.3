Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6606DC3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJSJ-0003aS-Ag; Sun, 11 May 2025 23:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEJSG-0003aF-Gd
 for qemu-devel@nongnu.org; Sun, 11 May 2025 23:03:48 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEJSD-0005wL-Sh
 for qemu-devel@nongnu.org; Sun, 11 May 2025 23:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747019026; x=1778555026;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Bj/tH68dQzsGdHRJBEGcFc/YadVXSQUdHnDga7hlP4w=;
 b=RaBHF8Lf0zY6lcMdGCyZMXxDT0FsKtemVb9m3RgAWybCfnJNVARLZVzQ
 2SYpzBMKx5mqhINHPBgfxBECJNZv/J/+Qey1hsC7dIQQnTXbNesbYloB9
 ov8zGupYzRdmVEvgkVDP3I9RdjagwvXwayGvbh2NKhgj/U5IZSkA0G5SR
 +l200a0tWrZRvNTLZziz2sVHwVBhlThOmKvKwNgaKKy6WTj8abijIvVQy
 VsBXBUP7N4Sh3HT3WJlyGezcUU3AVYwGod2nXkFwOJNrompxT0vjpOfVN
 A+NLYLSND8FV39iT2pmkTQLIoApVLW4ZWUBXdZq0BLeEWyoJ8MFxNawKW A==;
X-CSE-ConnectionGUID: TK7G+TzkT1O48HJzKEeuOw==
X-CSE-MsgGUID: OLR702/3SdeRlfcdzWTDcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48046374"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="48046374"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2025 20:03:42 -0700
X-CSE-ConnectionGUID: aPnosXKGSIyf29dDBkqrjA==
X-CSE-MsgGUID: 5W4UljGCQ/amyVe+XVUeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="137717132"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 11 May 2025 20:03:39 -0700
Date: Mon, 12 May 2025 11:24:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 01/13] memory: Export a helper to get intersection of
 a MemoryRegionSection with a given range
Message-ID: <aCFp+oLcypJEh71X@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-2-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407074939.18657-2-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Apr 07, 2025 at 03:49:21PM +0800, Chenyi Qiang wrote:
> Date: Mon,  7 Apr 2025 15:49:21 +0800
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> Subject: [PATCH v4 01/13] memory: Export a helper to get intersection of a
>  MemoryRegionSection with a given range
> X-Mailer: git-send-email 2.43.5
> 
> Rename the helper to memory_region_section_intersect_range() to make it
> more generic. Meanwhile, define the @end as Int128 and replace the
> related operations with Int128_* format since the helper is exported as
> a wider API.
> 
> Suggested-by: Alexey Kardashevskiy <aik@amd.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v4:
>     - No change.
> 
> Changes in v3:
>     - No change
> 
> Changes in v2:
>     - Make memory_region_section_intersect_range() an inline function.
>     - Add Reviewed-by from David
>     - Define the @end as Int128 and use the related Int128_* ops as a wilder
>       API (Alexey)
> ---
>  hw/virtio/virtio-mem.c | 32 +++++---------------------------
>  include/exec/memory.h  | 27 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 27 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


