Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uENry-0002Ui-Ls; Mon, 12 May 2025 03:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uENru-0002UM-AU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:46:35 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uENrq-00058g-AT
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747035990; x=1778571990;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iBK0lK8aZNneNniNfW/LpU9WpjK3D8Ahrjop4/GkZK0=;
 b=YExqLdH53RJIiO7iqkEnPi8uDz9bxEOTrlqYDL2+UnhcwfP9skcAPJ/F
 7KCy+3K3iQf1eIXiIpr6U0W27kki6FNUsnS7YRifoVab+sg1uFGiDFYs7
 S0HvPzZ3cuaQnyJvE5HpLjv9w03xR/TTqi5EqpvVFMTOOwlZEbu2+8r5a
 vxUC52McTQcwdRiQFuUj7t70nnD9Ow2JFSopzoynXH9GLSuAf5DiJ0Ml+
 FzjKo0CCuY0iLsC5x31qD7cW3hHAKzBeJcGzFgEhGKm+Ue2oBr0fNFIey
 7VLNMHcs5tPxm0viHEYN8bSbNgftujZP6/qu4hH7i8Alo+8HkyIQSs7Vd g==;
X-CSE-ConnectionGUID: 73zVbQZhQBGfQeUMmTJ93Q==
X-CSE-MsgGUID: XKe78MF0S9+v5y+Z3yZa5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48744429"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="48744429"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 00:46:27 -0700
X-CSE-ConnectionGUID: j59mCUCoTHuhaqL6Sbi2vg==
X-CSE-MsgGUID: EHcgkk8oR/SiWI3IT1I5ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="142250312"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2025 00:46:23 -0700
Date: Mon, 12 May 2025 16:07:26 +0800
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
Subject: Re: [PATCH v4 07/13] ram-block-attribute: Introduce
 RamBlockAttribute to manage RAMBLock with guest_memfd
Message-ID: <aCGsPh/A3sh0dDlI@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-8-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407074939.18657-8-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

[snip]

> ---
>  include/exec/ramblock.h      |  24 +++
>  system/meson.build           |   1 +
>  system/ram-block-attribute.c | 282 +++++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 system/ram-block-attribute.c

checkpatch.pl complains a lot about code line length:

total: 5 errors, 34 warnings, 324 lines checked

> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 0babd105c0..b8b5469db9 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -23,6 +23,10 @@
>  #include "cpu-common.h"
>  #include "qemu/rcu.h"
>  #include "exec/ramlist.h"
> +#include "system/hostmem.h"
> +
> +#define TYPE_RAM_BLOCK_ATTRIBUTE "ram-block-attribute"
> +OBJECT_DECLARE_TYPE(RamBlockAttribute, RamBlockAttributeClass, RAM_BLOCK_ATTRIBUTE)

Could we use "OBJECT_DECLARE_SIMPLE_TYPE" here? Since I find class
doesn't have any virtual method.

>  struct RAMBlock {
>      struct rcu_head rcu;
> @@ -90,5 +94,25 @@ struct RAMBlock {
>       */
>      ram_addr_t postcopy_length;
>  };
> +
> +struct RamBlockAttribute {
> +    Object parent;
> +
> +    MemoryRegion *mr;
> +
> +    /* 1-setting of the bit represents the memory is populated (shared) */
> +    unsigned shared_bitmap_size;
> +    unsigned long *shared_bitmap;
> +
> +    QLIST_HEAD(, PrivateSharedListener) psl_list;
> +};
> +
> +struct RamBlockAttributeClass {
> +    ObjectClass parent_class;
> +};

With OBJECT_DECLARE_SIMPLE_TYPE, this class definition is not needed.

> +int ram_block_attribute_realize(RamBlockAttribute *attr, MemoryRegion *mr);
> +void ram_block_attribute_unrealize(RamBlockAttribute *attr);
> +
>  #endif
>  #endif
> diff --git a/system/meson.build b/system/meson.build
> index 4952f4b2c7..50a5a64f1c 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -15,6 +15,7 @@ system_ss.add(files(
>    'dirtylimit.c',
>    'dma-helpers.c',
>    'globals.c',
> +  'ram-block-attribute.c',

This new file is missing a MAINTAINERS entry.

>    'memory_mapping.c',
>    'qdev-monitor.c',
>    'qtest.c',

[snip]

> +static size_t ram_block_attribute_get_block_size(const RamBlockAttribute *attr)
> +{
> +    /*
> +     * Because page conversion could be manipulated in the size of at least 4K or 4K aligned,
> +     * Use the host page size as the granularity to track the memory attribute.
> +     */
> +    g_assert(attr && attr->mr && attr->mr->ram_block);
> +    g_assert(attr->mr->ram_block->page_size == qemu_real_host_page_size());
> +    return attr->mr->ram_block->page_size;

What about using qemu_ram_pagesize() instead of accessing
ram_block->page_size directly?

Additionally, maybe we can add a simple helper to get page size from
RamBlockAttribute.

> +}
> +

[snip]

> +static void ram_block_attribute_psm_register_listener(GenericStateManager *gsm,
> +                                                      StateChangeListener *scl,
> +                                                      MemoryRegionSection *section)
> +{
> +    RamBlockAttribute *attr = RAM_BLOCK_ATTRIBUTE(gsm);
> +    PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
> +    int ret;
> +
> +    g_assert(section->mr == attr->mr);
> +    scl->section = memory_region_section_new_copy(section);
> +
> +    QLIST_INSERT_HEAD(&attr->psl_list, psl, next);
> +
> +    ret = ram_block_attribute_for_each_shared_section(attr, section, scl,
> +                                                      ram_block_attribute_notify_shared_cb);
> +    if (ret) {
> +        error_report("%s: Failed to register RAM discard listener: %s", __func__,
> +                     strerror(-ret));

There will be 2 error messages: one is the above, and another is from
ram_block_attribute_for_each_shared_section().

Could we just exit to handle this error?

> +    }
> +}
> +
> +static void ram_block_attribute_psm_unregister_listener(GenericStateManager *gsm,
> +                                                        StateChangeListener *scl)
> +{
> +    RamBlockAttribute *attr = RAM_BLOCK_ATTRIBUTE(gsm);
> +    PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
> +    int ret;
> +
> +    g_assert(scl->section);
> +    g_assert(scl->section->mr == attr->mr);
> +
> +    ret = ram_block_attribute_for_each_shared_section(attr, scl->section, scl,
> +                                                      ram_block_attribute_notify_private_cb);
> +    if (ret) {
> +        error_report("%s: Failed to unregister RAM discard listener: %s", __func__,
> +                     strerror(-ret));

Ditto.

> +    }
> +
> +    memory_region_section_free_copy(scl->section);
> +    scl->section = NULL;
> +    QLIST_REMOVE(psl, next);
> +}
> +

