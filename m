Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D318C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS1y-0007ZO-Ro; Fri, 07 Mar 2025 02:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqS1q-0007Xz-Se
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:21:56 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqS1o-0001TV-Bg
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741332112; x=1772868112;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=z5G5631nTIRqDdY+F3KY6G3vbEul2mSHrm5r6NEZZy4=;
 b=SIWO73+LJZa9P//2j+STzxSwJfARR533h22ok60/rBNTG72GsA5S+LZf
 fBdwo1sJqWnbFaJ8Kct1cajPTdL2jgOPcG9LII9mlvFMTl1N2fIeQfaBz
 MM65vh04Ed8LAerP0absOM+BJImTrtSncCVSthiSPuoiPZzhqP9afwiDb
 S5sNgTe336Gcg8iog3W1N9C4b3XmDBhV8MPc1xxhf+kejTvpGesbc3A1R
 32DUIgtE/avZO/tRGPgty8ACy9qh9DY6g6YgLTptQq1TnFCsBVmONg1C5
 QxaAZfnuUxEiuVWpYaXYQ8x0cPvd7C/hWnkHKO+lXR8FBsOxvhWKnh1pq Q==;
X-CSE-ConnectionGUID: 75XWXciPRziesVhc+sttjQ==
X-CSE-MsgGUID: n8aMxxMQSy+EUfMDUjqYjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46027354"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="46027354"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 23:21:49 -0800
X-CSE-ConnectionGUID: 3vpmoA5NTg6eXzieuSHKhA==
X-CSE-MsgGUID: nI9mrnhdTuOqLaOEpmJRUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="124172995"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 06 Mar 2025 23:21:44 -0800
Date: Fri, 7 Mar 2025 15:41:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 02/10] target/i386: disable PERFCORE when "-pmu" is
 configured
Message-ID: <Z8qjQVem/vqcSjhw@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-3-dongli.zhang@oracle.com>
 <Z8nSPf4bUPICgf3g@intel.com>
 <483c5783-6fb3-4793-9727-2cd4263dd92b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483c5783-6fb3-4793-9727-2cd4263dd92b@oracle.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> 1. Remove "kvm_enabled() && IS_AMD_CPU(env)" since the bit is reserved by
> Intel.
> 
> 2. Add your Reviewed-by.

Yes, this is exactly what I mean!

Regards,
Zhao


