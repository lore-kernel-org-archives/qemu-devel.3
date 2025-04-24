Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1494AC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rLs-0000dw-0q; Thu, 24 Apr 2025 03:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7rLk-0000ck-1B
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:50:27 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7rLZ-0006az-US
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745481014; x=1777017014;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/wJmc8AjbuE6ou/U1a6O64LXmKqy6snLfB0tLkyO/vA=;
 b=hFPEndZLCW4vQ3VfEmriu6MfHJJ6j8o74Jz6oN2hq6CbSJolrIWL4UUg
 BstSkKFUEnXvlO0YahZsWH2sU6NNDL+ZSOTe0MRXSis3wkPF/DUx0VDd3
 9WW19zMZmhQ5CBr3UMi4jCFFQOE1UzqCquZcoqIc5txAmz9tHJOrpSp1N
 We70HzfClu5QWkmXOH67cJcpKejMUB1/cM73ph30ob2sMWgxuemS76p9+
 6ZXsDR+vFVDRt+NFQ8ZVD81tu0jfDwMiAN8u3DGpbxGLg3N/9EvAFJsef
 M9YxgZYXIN3qP8nNtCns+KkZGwRiAXSZIoIyogmHrNprrl9pkt7/zX8mA A==;
X-CSE-ConnectionGUID: x1AZPJjdRxqWzSIih+Eg/w==
X-CSE-MsgGUID: 0kzYpBF5Tn++0OWPowDiXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57748618"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="57748618"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 00:50:10 -0700
X-CSE-ConnectionGUID: M4+XoCQSS2es3Kui4xiBsA==
X-CSE-MsgGUID: uK43kwevRpOOP2kLtziJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="163517092"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 24 Apr 2025 00:50:08 -0700
Date: Thu, 24 Apr 2025 16:11:03 +0800
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
Subject: Re: [PATCH v8 17/55] i386/tdvf: Introduce function to parse TDVF
 metadata
Message-ID: <aAnyF40pFLz9vY0y@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-18-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-18-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:27AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:27 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 17/55] i386/tdvf: Introduce function to parse TDVF
>  metadata
> X-Mailer: git-send-email 2.34.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDX VM needs to boot with its specialized firmware, Trusted Domain
> Virtual Firmware (TDVF). QEMU needs to parse TDVF and map it in TD
> guest memory prior to running the TDX VM.
> 
> A TDVF Metadata in TDVF image describes the structure of firmware.
> QEMU refers to it to setup memory for TDVF. Introduce function
> tdvf_parse_metadata() to parse the metadata from TDVF image and store
> the info of each TDVF section.
> 
> TDX metadata is located by a TDX metadata offset block, which is a
> GUID-ed structure. The data portion of the GUID structure contains
> only an 4-byte field that is the offset of TDX metadata to the end
> of firmware file.
> 
> Select X86_FW_OVMF when TDX is enable to leverage existing functions
> to parse and search OVMF's GUID-ed structures.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v8:
>  - Drop the failure handling of memcpy() since it cannot fail;
> 
> Changes in v7:
>  - Update license info to only use SPDX tag;
>  - use g_autofree to avoid manually free;
> 
> Changes in v6:
>  - Drop the the data endianness change for metadata->Length;
> 
> Changes in v1:
>  - rename tdvf_parse_section_entry() to
>    tdvf_parse_and_check_section_entry()
> 
> Changes in RFC v4:
>  - rename TDX_METADATA_GUID to TDX_METADATA_OFFSET_GUID
> ---
>  hw/i386/Kconfig        |   1 +
>  hw/i386/meson.build    |   1 +
>  hw/i386/tdvf.c         | 183 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/tdvf.h |  38 +++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 hw/i386/tdvf.c
>  create mode 100644 include/hw/i386/tdvf.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


