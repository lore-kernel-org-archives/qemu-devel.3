Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D4AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwro-0002Tw-RO; Thu, 25 Jul 2024 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWwrh-0001vz-Re; Thu, 25 Jul 2024 07:42:34 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWwrf-0001i4-2w; Thu, 25 Jul 2024 07:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721907751; x=1753443751;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KygXsTO1/7PsKHbHPRlx3mwu6GzCfvzBN5TuN2US15g=;
 b=Ch0utKZ4ilEHD2/h7WNZoi9umqJXXx5djwUrfEVs/KXffFQDrDyJKzbd
 FmIxyTDBwhZJwWF8lPm7pis/ahd8Dn/M1ClzfrtUxlSXXrSM/KcBAX43w
 oksLxH03MrICiVXRzYvPikwv0ziwkBF/Bzp5Qwt/SqwlRyrJ9jfgL50R4
 qufIjnKnXalIspy37M2THYhjYIq2QaAdk/2fjtBBhhTbvSrcYK+QpMZHa
 ZChtzbXMYuc7BHjzP3snrgUgQ6VsmPKCcRbULcSv78ZZz7UtYRJSlp7GB
 2IkMgzV9zySSyJFz1i4YbmXt9sOkMOAh6VC0Umd86jiXT6/Hj29EO0gML A==;
X-CSE-ConnectionGUID: gcZAz1gOSwSvfhSU1LCaIQ==
X-CSE-MsgGUID: nU33LRjFS8qvuNDT8DAEtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19818826"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="19818826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 04:42:28 -0700
X-CSE-ConnectionGUID: 2Wsp4k4PRGSWlLWNJZuuKw==
X-CSE-MsgGUID: utSt5rtmS7CpNGoEk5uI9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="83895660"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 25 Jul 2024 04:42:23 -0700
Date: Thu, 25 Jul 2024 19:58:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin " <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
Message-ID: <ZqI90B1jkfO4N5a5@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
 <87wmld361y.fsf@pond.sub.org> <Zp5tBHBoeXZy44ys@intel.com>
 <87h6cfowei.fsf@pond.sub.org> <ZqEV8uErCn+QkOw8@intel.com>
 <871q3hua56.fsf@pond.sub.org> <20240725115059.000016c5@Huawei.com>
 <20240725115902.000037e4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725115902.000037e4@Huawei.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Thanks Jonathon!

On Thu, Jul 25, 2024 at 11:59:02AM +0100, Jonathan Cameron wrote:

[snip]

> > > I think I understand why you want to configure caches.  My question was
> > > about the connection to SMP.
> > > 
> > > Say we run a guest with a single core, no SMP.  Could configuring caches
> > > still be useful then?  
> > 
> > Probably not useful to configure topology (sizes are a separate question)
> > - any sensible default should be fine.
> >

Yes, I agree.

Regards,
Zhao


