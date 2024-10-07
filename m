Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA607CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 10:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxl2H-0001H7-UG; Mon, 07 Oct 2024 06:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxl2A-0001DS-4W; Mon, 07 Oct 2024 06:32:11 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxl27-0002G4-GZ; Mon, 07 Oct 2024 06:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728297127; x=1759833127;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jhJUK+AWFll4gfSxpcVeHGVJ440uyTmTNkzlK2H16Kk=;
 b=N7SXfege0Wes4ly/Gd3A9xQO711B8hnOWG3ZuLqhG/aySauWUAARX7uy
 JcPKyqUzMGBxRNMxycFL+YmUUb013ZuyDVC/lV5r0qOIzz+Dni7IwIKIX
 /yKcgStu/XOYA2ueQVjQw/vR4cuS8MrrFti3EU5sxXJLnZlNaPNKS72Yu
 WbjBrRpUBk82uo+zm9sp+H0xomhKEZYUB4wU9Es1+0CUiDb7OqKRyvqqV
 g/uG/jhIQA7BubqqjRuCwFQiMErnrQtwR6Vw4+6NW0/9PZEV7O6EjdX1+
 ClSZdzuMS6Y5XtqRF3gukqJNGBqTZVepY9S45iRzO03qlWhfBNJnkKpeX g==;
X-CSE-ConnectionGUID: C8JhfIWuQAWIYLtHYy3j4A==
X-CSE-MsgGUID: ZSWHk0pCSBa+paBmVjEFUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38044285"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="38044285"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 03:32:02 -0700
X-CSE-ConnectionGUID: o2wxnFLcQ8aCs2GXkI/Wpg==
X-CSE-MsgGUID: 9taj1YQOS2OUtO3z+NOWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="80401926"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 07 Oct 2024 03:31:56 -0700
Date: Mon, 7 Oct 2024 18:48:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 2/7] qapi/qom: Define cache enumeration and properties
Message-ID: <ZwO8Z6pABtp2Zfi3@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20240908125920.1160236-3-zhao1.liu@intel.com>
 <20240917095126.000036f1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917095126.000036f1@Huawei.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Hi Jonathan,

Thanks for your review and feedback!

[snip]

> > Note, define cache topology based on CPU topology level with two
> > reasons:
> > 
> >  1. In practice, a cache will always be bound to the CPU container
> >     (either private in the CPU container or shared among multiple
> >     containers), and CPU container is often expressed in terms of CPU
> >     topology level.
> >  2. The x86's cache-related CPUIDs encode cache topology based on APIC
> >     ID's CPU topology layout. And the ACPI PPTT table that ARM/RISCV
> >     relies on also requires CPU containers to help indicate the private
> 
> Really trivial but CPU Containers are a different ACPI concept.
> For PPTT they are referred to as Processor Groups. Wonderfully they
> 'might match a Processor Container in the namespace' which rather implies
> they might not.  In QEMU they always will because the next bit of the
> spec matters. "In that case this entry will match the value of the _UID
> method of the associated processor container. Where there is a match it must
> be represented."
> 
> So having said all that, CPU container is probably fine as a description.

Thanks for the explanation!

> >     shared hierarchy of the cache. Therefore, for SMP systems, it is
> >     natural to use the CPU topology hierarchy directly in QEMU to define
> >     the cache topology.
> > 
> > Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>
> Seems fine but my gut would be to combine this and next patch so we can
> see how it is used (assuming no one asked for it to be separate!)

No problem. I intended to make it easier to review the QAPI part, but
these two patches were simple enough that I was happy to combine them.

> Version numbers need an update I guess.

Ah, yes!

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> > +##
> > +# @SmpCachePropertiesWrapper:
> > +#
> > +# List wrapper of SmpCacheProperties.
> > +#
> > +# @caches: the list of SmpCacheProperties.
> > +#
> > +# Since 9.1
> 
> Needs updating to 9.2 I guess.

Yes, I think so, too.

Thanks,
Zhao

> > +##
> > +{ 'struct': 'SmpCachePropertiesWrapper',
> > +  'data': { 'caches': ['SmpCacheProperties'] } }
> 

