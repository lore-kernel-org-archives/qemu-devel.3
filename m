Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4C1E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa2n-00086O-HH; Tue, 17 Dec 2024 11:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa1q-0007IW-AV; Tue, 17 Dec 2024 11:02:35 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa1j-0002KI-Su; Tue, 17 Dec 2024 11:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734451348; x=1765987348;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=snrT2Ns6e36l2ymjYWcaUa+kTGd+p3goxe68uIQLrSY=;
 b=n8JH8dXdyQHTKs4CO+5n3teDu2vPsWR7yAQyPWi8BH9ypBt3kDTPbaSv
 uSK5Ua3Vh6aZRNkoRMUqkJ3oNMC3r05m4SIbyuNTEyTV1vPmSNfAtugSE
 F2sTWeVhXupljat/XF8d8OUXupGGWkovXXYExunvCpx424LbqUAYqxRqp
 RXR1iNHzKACCZelsw4avSJINKp77lpbpeePkFYIeZvbgaRjd9teuooFQV
 vuSkA5LXqfFByFiQj3cvGOb9CHKS0B9bOOlo23D5MGPiiAXG+/pSkjNco
 UqMNuncvqEh5vLy/QkvuJiYSn8xb0xQCzeJgOurHn3BlxVfLWrV+dQz8Z A==;
X-CSE-ConnectionGUID: gXjJiKz8QOSk6C1D/0z5Pg==
X-CSE-MsgGUID: nSEXtR+wRsOA9psU3eqo2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34174196"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="34174196"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 08:02:19 -0800
X-CSE-ConnectionGUID: FpTVphQ0QCe50Aevqj3iLw==
X-CSE-MsgGUID: YSqaj35bR1275uo0MM1xOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="98018723"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 17 Dec 2024 08:02:14 -0800
Date: Wed, 18 Dec 2024 00:20:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v2 0/7] Introduce SMP Cache Topology
Message-ID: <Z2Gk5Ta43HJ9ChAT@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20241217142342.00007d96@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217142342.00007d96@huawei.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> Hi Zhao,
> 
> I wonder if this patch-set requires rebase for the new cycle?
>

Hi Alireza,

Yes, as some general patches are merged.

(Pls refer the v5: https://lore.kernel.org/qemu-devel/20241101083331.340178-1-zhao1.liu@intel.com/)

I'll send a new version this week, to include the remaining patches
(i386 path and your has_caches flag):

i386/cpu: Support thread and module level cache topology
i386/cpu: Update cache topology with machine's configuration
i386/pc: Support cache topology in -machine for PC machine
i386/cpu: add has_caches flag to check smp_cache configuration

Regards,
Zhao


