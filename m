Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3E6D374A1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rau-0000AB-F1; Thu, 17 Oct 2024 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1Rai-0008Tq-M4; Thu, 17 Oct 2024 10:35:06 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1Raf-0004BU-FS; Thu, 17 Oct 2024 10:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729175701; x=1760711701;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CVMfqVFPC1FfKWUvGbQ6UhJ7jsGmHq8fERdx02Rk3c8=;
 b=oLAZ1J22oLqr5UXMnJFRTn4lqBmyAlAX+WZBcsYulh26Yr+lZ21OzEdu
 I8XHZ6lW1uG9DeG70NlIdIN6qoMdsP55yrRF/QN6tEeRB4GowNGa3LQnP
 /LbAcm9tYLuZdojgwfcECyLQORS095USSuFiV4pCTpekGXGrPKt3XtNpm
 PyK2N277sETR32g1VV2doWja5fg3wlVCjV8gBw+DlPG6mKL4R8XpKLMlu
 wfWpwFwcqNyd3qepPRoXWJT9AGZN5+WjZo1ACtQ9msHZcsUe8o40TEovO
 uSNIqbe9UVwodoyeNKU0u49l1nC2PRb4qzhgde/egS70Bqq4gDT7jj8Af Q==;
X-CSE-ConnectionGUID: FGszICFcQrGaNSwWTMhy0w==
X-CSE-MsgGUID: M668NDCxTlOGMLAqmtQ1BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28546006"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="28546006"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 07:34:57 -0700
X-CSE-ConnectionGUID: iFCeQvUHQD6EsOtiz6LP5g==
X-CSE-MsgGUID: RrpgABK9Q/aTX6hvU38pWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="83116369"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 17 Oct 2024 07:34:51 -0700
Date: Thu, 17 Oct 2024 22:51:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin " <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZxEkW84fcf4pCK0w@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-2-zhao1.liu@intel.com>
 <20241017095227.00006d85@Huawei.com>
 <20241017142013.00006c41@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017142013.00006c41@Huawei.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

(Ping Markus)

> > > +
> > > +##
> > > +# @CpuTopologyLevel:
> > > +#
> > > +# An enumeration of CPU topology levels.
> > > +#
> > > +# @invalid: Invalid topology level.  
> > 
> > Really trivial but why a capital I on Invalid here but not the
> > t of thread below?

Oops, thank you! It should be "invalid".

If Markus doesn't veto this version :), I'll standardize the case issues
in this file later. Some cases are uppercase, while others are lowercase.

> > > +#
> > > +# @thread: thread level, which would also be called SMT level or
> > > +#     logical processor level.  The @threads option in
> > > +#     SMPConfiguration is used to configure the topology of this
> > > +#     level.  
> > 
> 

