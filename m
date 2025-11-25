Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC86CFD374
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 03:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNje4-0005ls-PU; Mon, 24 Nov 2025 22:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNje2-0005eR-MD
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 22:23:10 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNje0-0000S2-3m
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 22:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764040988; x=1795576988;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=swjv2dIStOU/Ubq1bO+NPOfpG3tTacuZ4CVZNTwklFQ=;
 b=XFeo1Gp1HH4D088vqdiZYwdoN5smxcJlSzjcBJJixYEwQjByQskRa9WP
 JSyosleLGFzpmo+Niv/gdhMBKezFb8cquTapmEKfkQDGAHV6cYvpYg6ju
 UPPG5jB0yb3UId1VqhUswgcXSicCDNUFJHwml1Bn+szgfz/WAoOqP4fnR
 rJ//XbPw9XFQrqOrXKhUeAJGXbGPQdao1O2PeldqQjiktI6b4hUoTc5g+
 7iAw3Treq9rfx7pR+XA/N4aF01xtYeDUJjf81UZhaUga5k4pkR2kcVXKH
 eLPn2jWHC5u9uLBzg+PJhxgwRiiqdfCSXWSVtWq9eGvBmh3G1XyT4B5If w==;
X-CSE-ConnectionGUID: eOfcWL3ZQy6Rz0YW51TIsA==
X-CSE-MsgGUID: QMPwx8t1SQqz2bHx4UWTWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77422607"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="77422607"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 19:23:05 -0800
X-CSE-ConnectionGUID: CLPwWsugTx+NOw5BCaXc/Q==
X-CSE-MsgGUID: C7h77fsXQcSZ3DgpKqKj0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="229792287"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 24 Nov 2025 19:23:00 -0800
Date: Tue, 25 Nov 2025 11:47:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
Subject: Re: [PATCH v7 2/9] target/i386: disable PERFCORE when "-pmu" is
 configured
Message-ID: <aSUm22dRG6dczdkp@intel.com>
References: <20251111061532.36702-1-dongli.zhang@oracle.com>
 <20251111061532.36702-3-dongli.zhang@oracle.com>
 <aR2ky5WU8CqH8+lS@intel.com>
 <077866b9-eaa2-4671-bb96-6c6776d0f72b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077866b9-eaa2-4671-bb96-6c6776d0f72b@oracle.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

> Please let me know whether you would like to include Patch 2 on
> "amd_perfmon_always_on" as part of the "compat_prop" patch, or if you'd prefer
> that I re-create Patch 2 with your Suggested-by.
> 
> Either option works for me.

I took some time to revisit the dependency issues with PDCM again, and I
do think the approach mentioned in previous reply should work.

Ok, let me pick your patch 1 & 2. I will rebase these on the CET series
(since I've also modified the dependency for Arch LBR). The entire
dependency fix series may take some time and may need to wait for
several weeks.

However, at least it's decoupled from the rest. :)

At the same time, I'll help go through the remaining patches 3-9 again,
as it's been quite a while since I last reviewed them.

> It seems the Patches 3 - 9 are not impacted by this Live Migration issue.
> Perhaps they may be accepted (or as well as Patch 2 "amd_perfmon_always_on")
> without "compat_prop" patch? They are independent with each other.

Yes, I think so.

> Another concern is Patch 3. Something unexpected may occur when live migrating
> from a KVM host without KVM_PMU_CAP_DISABLE to one that has it enabled. The
> migration will succeed, but the perceived perf/vPMU support could change.
> Can we assume it is the user's responsibility to ensure compatibility between
> KVM hosts when "-pmu" is specified?

Yes, I think so, too. I understand that QEMU needs to ensure vmstate
migration compatibility.

Thanks,
Zhao


