Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE001C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEPd-00022X-Da; Thu, 03 Jul 2025 03:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXEPc-00022O-DH
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:31:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXEPZ-0006M7-Ms
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751527874; x=1783063874;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=umhNYtMq0xc0JruKddyKpbWr9UG6Y0MImL389MvdeJA=;
 b=RP5Y0u4zHqh1Pazyv9TWipgDwhnmLxHNd3QMiCaq0nKkomgiMBebaFzc
 Uc7/ygH6ADtQMvnDSKKOhziUE7PUOBYlrq7zaiIWY6v95loWNkSNqez7P
 SMumZnvDP7voW8g3BFkPYG3D+uZjl9IbHdip/gH3BEDF3isvvS6jbY+Ec
 2BL3RY5z+w62+anjxr7WQLzg2t57D2B4qYM8HuRTGmZ6FtFK3CeseEFNr
 1CCGwQ9mNxQcfhg/fhDOTwbNE4/9omPWFNtuk8hSkltTLOsKNIFpAZIgh
 wVH4FhQbyGbVDGHypxh+Rg/G+LHuJAkEjrmy3SJnCIpHPDBnsiF43OsyV g==;
X-CSE-ConnectionGUID: L69C+rcdTAS1QxfBwOFJFw==
X-CSE-MsgGUID: d1haSGi8TvKbtvAkwg6NUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65189365"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="65189365"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:31:11 -0700
X-CSE-ConnectionGUID: duyQJDzBSf2hK3L8jDImjw==
X-CSE-MsgGUID: WZlE00q1THa5jVLuCDVe6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="159800370"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2025 00:31:07 -0700
Date: Thu, 3 Jul 2025 15:52:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 08/16] i386/cpu: Fix CPUID[0x80000006] for Intel CPU
Message-ID: <aGY2wfQJWeigUhm+@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-9-zhao1.liu@intel.com>
 <bd979e2d-e036-4a1a-bf8a-0098eadb4821@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd979e2d-e036-4a1a-bf8a-0098eadb4821@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

> >  static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
> >                                         CPUCacheInfo *l3,
> > -                                       uint32_t *ecx, uint32_t *edx)
> > +                                       uint32_t *ecx, uint32_t *edx,
> > +                                       bool lines_per_tag_supported)
> >  {
> >      assert(l2->size % 1024 == 0);
> >      assert(l2->associativity > 0);
> > -    assert(l2->lines_per_tag > 0);
> > -    assert(l2->line_size > 0);
> 
> why remove the assert for l2->line_size?

Good catch! My bad...

> > +    assert(lines_per_tag_supported ?
> > +           l2->lines_per_tag > 0 : l2->lines_per_tag == 0);
> >      *ecx = ((l2->size / 1024) << 16) |
> > -           (AMD_ENC_ASSOC(l2->associativity) << 12) |
> > +           (X86_ENC_ASSOC(l2->associativity) << 12) |
> >             (l2->lines_per_tag << 8) | (l2->line_size);
> >  

