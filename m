Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE28BD462DA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBGgC-0001Wj-8t; Wed, 13 Nov 2024 11:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tBGg7-0001WM-H9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:57:17 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tBGg5-0001Uv-MF
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731517034; x=1763053034;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iRTp/lPSHCLfmoyHvRh98VAdS2hyyRbRRx8oSbHwnpU=;
 b=ktK5k5tu9XHy39MuZ0zyifz0vyMOvXoqBtdbnFhjHKnhYR5RtAATKTcX
 vXUeAAohJCVolT/MEgkEdtbkmpzkPmOByMhbPbzlhcQcHawu3i+rI5xEf
 PjF64hzOLHI4OFOk+dgB9XJukZjepGuA1Jve4BnTAGwp4B3wlofeN20zu
 Ll1rdcRUbO7bDZjTtZy2bGmhTPWGiG8uhYttsQWB/1qAPj1FFCswR+jcO
 1XqZhKvHCxi9JGt9f5tlGICyfen53FCJMpj9AZAb7zBCfuGqZAQyZFXXf
 iKMJjKdhB4/IYJp8Jtygq7v1er3yj3NqDTem/sYvLfX9kjQXrihhrJXXm Q==;
X-CSE-ConnectionGUID: lgAZZS5mQnagJar2A7JkYg==
X-CSE-MsgGUID: FBBS0cBJSrqrQj8Fy/4Mww==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31187227"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31187227"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 08:57:10 -0800
X-CSE-ConnectionGUID: 04/TR45hTWmiV+HKmFEs7g==
X-CSE-MsgGUID: rr/gpLk1QsyTNIvP79nLAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; d="scan'208";a="118742745"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 08:57:06 -0800
Date: Thu, 14 Nov 2024 01:15:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, lyan@digitalocean.com,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, joe.jin@oracle.com, davydov-max@yandex-team.ru,
 dapeng1.mi@linux.intel.com, zide.chen@intel.com
Subject: Re: [PATCH 2/7] target/i386/kvm: introduce 'pmu-cap-disabled' to set
 KVM_PMU_CAP_DISABLE
Message-ID: <ZzTenX8KOOGxZCou@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-3-dongli.zhang@oracle.com>
 <ZyxxygVaufOntpZJ@intel.com>
 <57b4b74d-67d2-4fcf-aa59-c788afc93619@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b4b74d-67d2-4fcf-aa59-c788afc93619@oracle.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
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

> > Further, considering that this is currently the only case that needs to
> > to set the VM level's capability in the CPU context, there is no need to
> > introduce a new kvm interface (in your previous patch), which can instead
> > be set in kvm_cpu_realizefn(), like:
> >

Now your case is not the only user of kvm_arch_pre_create_vcpu(), and
TDX also needs this [*]. So, this is the support for bringing back your
previous solution (preferably with comments, as I suggested earlier,
explaining why it's necessary to handle VM-level cap in the CPU
context). :-)

[*]: https://lore.kernel.org/qemu-devel/20241105062408.3533704-8-xiaoyao.li@intel.com/


