Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F51C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 14:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7xsX-0005IO-VJ; Thu, 24 Apr 2025 10:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7xsV-0005I7-Un
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:48:40 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7xsT-00054D-0z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745506117; x=1777042117;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/iFBV0oZPpeakmRrY7zKBM2B1+WV4Ixfsnzftghnm7I=;
 b=Fyfwhoc2TZ+rQ9FcYNjCr1A8TalTwN1lU2o/yeE/HgnnzhHm/9nUadu0
 K9meaKAUMLtHMcpF4iNp36R9uhvhS+RftgJ9RPXZSXvQiztKBtSk5zG3k
 Pxzw5xhhFllKxpusGZHe/ABtgAfnBDFdtBDG0DeATVzBHFYGAHfgZSheA
 BsGuoBL6XZ98bbQDZU2pbEr/zD4narJpdMewPHreXhdOLqm0ZdJFKBQSx
 T6Y2F4Ij8vQTxnvNjhoQjd9SBL0aW527PG2zz8ui0IayAYPWaHCOVw0Yj
 oeFxVujWBL69vavKRZI9MY17psRRcpHhq5L1L87JikPJN7QVUvG606v2p A==;
X-CSE-ConnectionGUID: N9UO0VX8SsCzlqU/UtAKbw==
X-CSE-MsgGUID: gxuCk+1UQXG98Hl0MZFKhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="69632151"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="69632151"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 07:48:33 -0700
X-CSE-ConnectionGUID: ChmlyuCWRCu6fjVR6EO/4g==
X-CSE-MsgGUID: VU8cssADSeqvisc42fb64A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="155867711"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 24 Apr 2025 07:48:30 -0700
Date: Thu, 24 Apr 2025 23:09:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 20/55] i386/tdx: Track mem_ptr for each firmware entry
 of TDVF
Message-ID: <aApUJahseohnXdp2@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-21-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-21-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Tue, Apr 01, 2025 at 09:01:30AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:30 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 20/55] i386/tdx: Track mem_ptr for each firmware entry
>  of TDVF
> X-Mailer: git-send-email 2.34.1
> 
> For each TDVF sections, QEMU needs to copy the content to guest
> private memory via KVM API (KVM_TDX_INIT_MEM_REGION).
> 
> Introduce a field @mem_ptr for TdxFirmwareEntry to track the memory
> pointer of each TDVF sections. So that QEMU can add/copy them to guest
> private memory later.
> 
> TDVF sections can be classified into two groups:
>  - Firmware itself, e.g., TDVF BFV and CFV, that located separately from
>    guest RAM. Its memory pointer is the bios pointer.
> 
>  - Sections located at guest RAM, e.g., TEMP_MEM and TD_HOB.
>    mmap a new memory range for them.
> 
> Register a machine_init_done callback to do the stuff.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v8:
> - Remove the duplicated header include;
> - Add error handling for qemu_ram_mmap() failure;
> ---
>  hw/i386/tdvf.c         |  1 +
>  include/hw/i386/tdvf.h |  7 +++++++
>  target/i386/kvm/tdx.c  | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


