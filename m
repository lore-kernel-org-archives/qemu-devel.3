Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CDCC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 08:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEkiJ-0006gR-Hs; Tue, 13 May 2025 04:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEkiH-0006fD-7Q
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:10:09 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEkiE-0003iz-5q
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747123807; x=1778659807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ToqcWH2DwjjzvKTkbb1scAhC6W2tO35kLWOPSwlRmpE=;
 b=desnd5IWaEAVUqOCgWE9nn/cPNdPpgquKLOZe2PqM9pJY57DVKvo4fat
 9/4Zi1F8g/oSak2WK+t0JXzsbmpujtTqtqjm4AzWzxeZK7Owka20tyro3
 8PHftIIkntAd8G+32QXhn/65EDMN6EO1i8R+wCtEEwMVuBavsqPpgvyxH
 ak2PX+rOnq1ySMDUsRYGoQDk7aRn7b7gBlsOtYFjlwZJaLSeiFTzmp3fm
 i3d8LbiwL6nMKhHuSVQ6TmbCJGaGDcVq+zQcl2c9w5pjpvEo8hJEG3PSv
 lEOwbHHAkQRiiRnMM5sAnP3v7wJm1YOLvoc6xctJVPl9I3ywYmhDKU1D6 w==;
X-CSE-ConnectionGUID: /1W1zyvQQbuXtQshQdQ7BQ==
X-CSE-MsgGUID: +XIkKmJ5QIuHKfCm/CX7Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49034919"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="49034919"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 01:10:03 -0700
X-CSE-ConnectionGUID: MUpUFQM5THe9jefW5Bax/A==
X-CSE-MsgGUID: VbGTNf04T8mj1oFR5jCDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="160900961"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 13 May 2025 01:09:58 -0700
Date: Tue, 13 May 2025 16:31:02 +0800
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
Message-ID: <aCMDRoHcoV2PM34W@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-8-chenyi.qiang@intel.com>
 <aCGsPh/A3sh0dDlI@intel.com>
 <3c4405f4-8d2a-48aa-b92a-f8fee223f1cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4405f4-8d2a-48aa-b92a-f8fee223f1cb@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

> >> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> >> index 0babd105c0..b8b5469db9 100644
> >> --- a/include/exec/ramblock.h
> >> +++ b/include/exec/ramblock.h
> >> @@ -23,6 +23,10 @@
> >>  #include "cpu-common.h"
> >>  #include "qemu/rcu.h"
> >>  #include "exec/ramlist.h"
> >> +#include "system/hostmem.h"
> >> +
> >> +#define TYPE_RAM_BLOCK_ATTRIBUTE "ram-block-attribute"
> >> +OBJECT_DECLARE_TYPE(RamBlockAttribute, RamBlockAttributeClass, RAM_BLOCK_ATTRIBUTE)
> > 
> > Could we use "OBJECT_DECLARE_SIMPLE_TYPE" here? Since I find class
> > doesn't have any virtual method.
> 
> Yes, we can. Previously, I defined the state_change() method for the
> class (MemoryAttributeManagerClass) [1] instead of parent
> PrivateSharedManagerClass. And leave it unchanged in this version.
> 
> In next version, I will drop PrivateShareManager and revert to use
> RamDiscardManager. Then, maybe I should also use
> OBJECT_DECLARE_SIMPLE_TYPE and make state_change() an exported function
> instead of a virtual method since no derived class for RamBlockAttribute.

Thank you! I see. I don't have an opinion on whether to add virtual
method or not, if you feel it's appropriate then adding class is fine.
(My comment may be outdated, it's just for the fact that there is no
need to add class in this patch.) Looking forward to your next version.

> [1]
> https://lore.kernel.org/qemu-devel/20250310081837.13123-6-chenyi.qiang@intel.com/
> 
> > 
> >>  struct RAMBlock {
> >>      struct rcu_head rcu;
> >> @@ -90,5 +94,25 @@ struct RAMBlock {
> >>       */
> >>      ram_addr_t postcopy_length;
> >>  };
> >> +

[snip]

> >> +static size_t ram_block_attribute_get_block_size(const RamBlockAttribute *attr)
> >> +{
> >> +    /*
> >> +     * Because page conversion could be manipulated in the size of at least 4K or 4K aligned,
> >> +     * Use the host page size as the granularity to track the memory attribute.
> >> +     */
> >> +    g_assert(attr && attr->mr && attr->mr->ram_block);
> >> +    g_assert(attr->mr->ram_block->page_size == qemu_real_host_page_size());
> >> +    return attr->mr->ram_block->page_size;
> > 
> > What about using qemu_ram_pagesize() instead of accessing
> > ram_block->page_size directly?
> 
> Make sense!
> 
> > 
> > Additionally, maybe we can add a simple helper to get page size from
> > RamBlockAttribute.
> 
> Do you mean introduce a new field page_size and related helper? That was
> my first version and but suggested with current implementation
> (https://lore.kernel.org/qemu-devel/b55047fd-7b73-4669-b6d2-31653064f27f@intel.com/)

Yes, that's exactly my point. It's up to you if it's really necessary :-).

> > 
> >> +}
> >> +
> > 
> > [snip]
> > 
> >> +static void ram_block_attribute_psm_register_listener(GenericStateManager *gsm,
> >> +                                                      StateChangeListener *scl,
> >> +                                                      MemoryRegionSection *section)
> >> +{
> >> +    RamBlockAttribute *attr = RAM_BLOCK_ATTRIBUTE(gsm);
> >> +    PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
> >> +    int ret;
> >> +
> >> +    g_assert(section->mr == attr->mr);
> >> +    scl->section = memory_region_section_new_copy(section);
> >> +
> >> +    QLIST_INSERT_HEAD(&attr->psl_list, psl, next);
> >> +
> >> +    ret = ram_block_attribute_for_each_shared_section(attr, section, scl,
> >> +                                                      ram_block_attribute_notify_shared_cb);
> >> +    if (ret) {
> >> +        error_report("%s: Failed to register RAM discard listener: %s", __func__,
> >> +                     strerror(-ret));
> > 
> > There will be 2 error messages: one is the above, and another is from
> > ram_block_attribute_for_each_shared_section().
> > 
> > Could we just exit to handle this error?
> 
> Sure, will remove this message as well as the below one.

   if (ret) {
       error_report("%s: Failed to register RAM discard listener: %s", __func__,
                    strerror(-ret);
       exit(1);
   }

I mean adding a exit() here. When there's the error, if we expect it not to
break the QEMU, then perhaps warning is better. Otherwise, it's better to
handle this error. Direct exit() feels like an option.

Thanks,
Zhao

> > 
> >> +    }
> >> +}
> >> +

