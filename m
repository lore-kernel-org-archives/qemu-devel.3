Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD13EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7r42-0002wO-DQ; Thu, 24 Apr 2025 03:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7r40-0002wA-1V
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:32:04 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7r3y-0004vS-3H
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745479922; x=1777015922;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rAODJRHQ5blDTW4fl3P17Ph9OaV50GCWIt/ZXONfCCw=;
 b=k5pn6z1EzgD0rhdtzxtde/SnPFDOCD7Y5Ca4K8zo2Sglsd+EbDGctPN4
 HSo8L0XfwfyyvWRq22xVJqG6HA3FIYlnCdC6F943GsdoV43+jhaSDuKeE
 0KA9004O59I7DIct12rRcbqnvC0Nt6DHMJbRO6M5xopGpMiAhwdjdQ/bR
 IDCPV2HDghfpbo67/tLPA/PSm4PbVlGX1sQC7uewBb4wyO27fGWO2WvT7
 k7l2r06oREHI+3vtKq8RvhFaLXTXwMik2oSLyT5Dhecrgl/XHYlC5N/nf
 FO+hDv4QxhrheiKVxvKhzWzl50xKPdP5hDCZ2V0ommsQUtin1ikBCete4 g==;
X-CSE-ConnectionGUID: YOJpKd5oTJ2r/v0g3VRqAQ==
X-CSE-MsgGUID: MXdRPDFuTnmf7NLGIjosIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57740464"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="57740464"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 00:31:59 -0700
X-CSE-ConnectionGUID: OxnOi8g9ROOlAyNQJ4qH4Q==
X-CSE-MsgGUID: cS6gdTPHRQCROGbHLgaCfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="132272230"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 24 Apr 2025 00:31:57 -0700
Date: Thu, 24 Apr 2025 15:52:52 +0800
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
Subject: Re: [PATCH v8 16/55] i386/tdx: load TDVF for TD guest
Message-ID: <aAnt1HjQmbdtmsGM@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-17-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-17-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Tue, Apr 01, 2025 at 09:01:26AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:26 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 16/55] i386/tdx: load TDVF for TD guest
> X-Mailer: git-send-email 2.34.1
> 
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> TDVF(OVMF) needs to run at private memory for TD guest. TDX cannot
> support pflash device since it doesn't support read-only private memory.
> Thus load TDVF(OVMF) with -bios option for TDs.
> 
> Use memory_region_init_ram_guest_memfd() to allocate the MemoryRegion
> for TDVF because it needs to be located at private memory.
> 
> Also store the MemoryRegion pointer of TDVF since the shared ramblock of
> it can be discared after it gets copied to private ramblock.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/i386/x86-common.c  | 6 +++++-
>  target/i386/kvm/tdx.c | 6 ++++++
>  target/i386/kvm/tdx.h | 3 +++
>  3 files changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


