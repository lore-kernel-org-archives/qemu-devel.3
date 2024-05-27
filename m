Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A7FC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXIb-0007zh-2B; Mon, 27 May 2024 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBXIY-0007yc-DB; Mon, 27 May 2024 06:09:46 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBXIW-0002da-Gi; Mon, 27 May 2024 06:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716804585; x=1748340585;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5J8dHaMU3LQO+Etnmc1tE5Tep1M6eKHy+YAZCgxJqxA=;
 b=Nu+ls19eQ5X//popMhbhL8LcOPegYk/QKKUoA79Y5EaI5eZk0p9CptVN
 3zZPd+MKlGjnMSX6hvKhzwMQXXMr+dkNAqOwf5Y4p1f2T1jvwIamTnDBi
 WTOK256MyvOa2GKGHjORueLnYaR1YJN5052XygWVQj279K2seZHlzFYr4
 s5q+VIbYf7IR7U2EMflPMc0WIuOHhWSB64O4cgFp4TtAxXHzG+g533H+5
 gITwFK7AoawyyvH0tWB402uolWzjtjF78XBPd/tXUM9zxcprI0HxK7oW8
 XfWIr6BazaVWhtOCRrwXmbZOOKkWSog3Jg1sAi6xpeXxeYLLXN68RkEiW w==;
X-CSE-ConnectionGUID: uc6Shg51Qpi6ntsAKM3m9w==
X-CSE-MsgGUID: OZmnizrnShOsKzlb5X0lNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="30625311"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="30625311"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 03:09:36 -0700
X-CSE-ConnectionGUID: M48rnGhUScyrvvdsO0jQuA==
X-CSE-MsgGUID: M+HxXaNOQ9KGLkbl3BaYaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="35324709"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 27 May 2024 03:09:21 -0700
Date: Mon, 27 May 2024 18:24:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <ZlRfawZPkuAZCtIy@intel.com>
References: <20240409024940.180107-1-shahuang@redhat.com>
 <Zh1j9b92UGPzr1-a@redhat.com> <Zjyb43JqMZA+bO4r@intel.com>
 <ZjyZ1ZV7BGME_bY9@redhat.com> <ZkG4nlwRnvz9oUXX@intel.com>
 <d3733e25-eb1e-4c19-b77f-d68e871c9f0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3733e25-eb1e-4c19-b77f-d68e871c9f0f@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 02:41:01PM +0800, Shaoqin Huang wrote:
> Date: Mon, 27 May 2024 14:41:01 +0800
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: Re: [PATCH v9] arm/kvm: Enable support for
>  KVM_ARM_VCPU_PMU_V3_FILTER
> 
> Hi Zhao,
> 
> Thanks for your proposed idea. If you are willing to take the PMU Filter
> Enabling work, you can do it. I won't update this series anymore due to the
> QAPI restriction. I really appreciate if you can implement that.
>

Welcome Shaoqin, I'll cc you when I'm done with the first version (it'll
take some time).

There are also some issues that I might take up and revisit, such as
whether to place the kvm-pmu-filter in -cpu or in -kvm.

Anyway, hopefully eventually we can implement this feature for QEMU and
users can benefit from it!

Thanks,
Zhao


