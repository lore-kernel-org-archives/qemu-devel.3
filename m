Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83779C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 04:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Agi-0007B7-6V; Fri, 25 Apr 2025 00:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8AgZ-0007A3-DE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 00:29:13 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8AgV-00078l-8Q
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 00:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745555347; x=1777091347;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=R7n/3Di1zXKjZIwDzZmk5EF32q42iAaIuYBGa/R6KWI=;
 b=Ka8zhqdDONSYBeOFZDegT7Itaxz68fC1DxVR+KpPgrp0nmVCx+RmbVqM
 QxqPRBIPE/3ZMyBhtj4dr5xR4RW/3BGvItMGvvo2EPHmkVwvsCxLm+Yvl
 7aGq4aGefJv+MhKAOrspVKBbUWNlat0yItofpz+dc7msNueHmD/AwuLLt
 a2OK9XtTWq1Zi/wuBA8qkZslO1hidf5PjWIKWP1zBIDVo9RJE5TsCek8M
 ZC3J7VxppGmRYJLGpWiFoZvtXMxu1vAbppkcxuBITd1by9DMkiqzIltVR
 kMkYOU0wYXvaFCVApzLWww9zGMtjqIAC/LzHZFinYiz4rZvoUDqVArKSf w==;
X-CSE-ConnectionGUID: BQk4/pKWSvqd/397yVwUug==
X-CSE-MsgGUID: J41ikpxZTyCc3jEbhw9ZUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47225997"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="47225997"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 21:29:02 -0700
X-CSE-ConnectionGUID: 1uM6VkHgR2mdDmH6uJFpfA==
X-CSE-MsgGUID: //qaNZYIS12NOHxlZFiAGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="137644280"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 24 Apr 2025 21:29:00 -0700
Date: Fri, 25 Apr 2025 12:49:55 +0800
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
Subject: Re: [PATCH v8 21/55] i386/tdx: Track RAM entries for TDX VM
Message-ID: <aAsUcy0dIDmx2xya@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-22-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-22-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:31AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:31 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 21/55] i386/tdx: Track RAM entries for TDX VM
> X-Mailer: git-send-email 2.34.1
> 
> The RAM of TDX VM can be classified into two types:
> 
>  - TDX_RAM_UNACCEPTED: default type of TDX memory, which needs to be
>    accepted by TDX guest before it can be used and will be all-zeros
>    after being accepted.
> 
>  - TDX_RAM_ADDED: the RAM that is ADD'ed to TD guest before running, and
>    can be used directly. E.g., TD HOB and TEMP MEM that needed by TDVF.
> 
> Maintain TdxRamEntries[] which grabs the initial RAM info from e820 table
> and mark each RAM range as default type TDX_RAM_UNACCEPTED.
> 
> Then turn the range of TD HOB and TEMP MEM to TDX_RAM_ADDED since these
> ranges will be ADD'ed before TD runs and no need to be accepted runtime.
> 
> The TdxRamEntries[] are later used to setup the memory TD resource HOB
> that passes memory info from QEMU to TDVF.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

[snip]

>  static void tdx_finalize_vm(Notifier *notifier, void *unused)
>  {
>      TdxFirmware *tdvf = &tdx_guest->tdvf;
>      TdxFirmwareEntry *entry;
>  
> +    tdx_init_ram_entries();
> +
>      for_each_tdx_fw_entry(tdvf, entry) {
>          switch (entry->type) {
>          case TDVF_SECTION_TYPE_BFV:
> @@ -166,12 +273,16 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
>                               entry->type);
>                  exit(1);
>              }
> +            tdx_accept_ram_range(entry->address, entry->size);

It's better to catch & report the failure case here.

>              break;

Others LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



