Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B321E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 07:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW96W-00077K-AV; Fri, 10 Jan 2025 02:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tW96S-00076l-G1
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:06:44 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tW96P-0007OU-3K
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736492802; x=1768028802;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Icfp8ADMH22lY9/TECTYujLjL4kAtLZFXlPwp+iKNWM=;
 b=lGpgihRGJZuh/dZbUhQCw3ebfgibLTlyT1c7pq4TCHikaOgSPaOc8LtW
 8o1Z3pOw/5dwTOkjsGzbSNKpwlfZU+fh0BpPIwIsUCGAmw0jjwNrRhrv7
 jK09E3ti1nGPyHJwltWCUVdWlxuRPImPUymhZNj0BHXx71HlUBM3VFlY4
 +UkcHQm+Z6EtdpuZFeU6dRdX5GO6yQS4suOtqr08pK+WOjdPSu+TcBG3K
 IfUhWJ9KwrrBtr7i6Tu7e8g/LWQCfrfCCB9TU66QqkqiSPaXno0MTjnjp
 3WxArhQIQZ1gMdhoATjALqwFVowYOKToGajFCTs8GvthvjvwhT1e38zZy Q==;
X-CSE-ConnectionGUID: gKsq8Q4NQeuzC5NBlQDmrg==
X-CSE-MsgGUID: q/XJmuiBRFWlc13uFJSNoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36939434"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="36939434"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2025 23:06:36 -0800
X-CSE-ConnectionGUID: e+pImn6jSuK83VHtw1pMoA==
X-CSE-MsgGUID: I+za7lgbSUii4CBnw7HmIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="104200387"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 09 Jan 2025 23:06:33 -0800
Date: Fri, 10 Jan 2025 15:25:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7 1/5] hw/core/machine: Reject thread level cache
Message-ID: <Z4DLYf6kfWptN5IK@intel.com>
References: <20250108150150.1258529-1-zhao1.liu@intel.com>
 <20250108150150.1258529-2-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108150150.1258529-2-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jonathon,

Thanks for more explaination!

Based on your clarification, I think the commit message for Patch 1
needs to be updated since I used the same wrods as the cover letter...

What about the following change?

On Wed, Jan 08, 2025 at 11:01:46PM +0800, Zhao Liu wrote:
> Date: Wed, 8 Jan 2025 23:01:46 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH v7 1/5] hw/core/machine: Reject thread level cache
> X-Mailer: git-send-email 2.34.1
> 
> Currently, neither i386 nor ARM have real hardware support for per-
> thread cache, and there is no clear demand for this specific cache
> topology.
> 
> Additionally, since supporting this special cache topology on ARM
> requires extra effort [1], it is unnecessary to support it at this
> moment, even though per-thread cache might have potential scheduling
> benefits for VMs without CPU affinity.

Additionally, since ARM even can't support this special cache topology
in device tree, it is unnecessary to support it at this moment, even
though per-thread cache might have potential scheduling benefits for
VMs without CPU affinity.

If it's fine for u, I'll resend this series quickly.

Thanks,
Zhao

> Therefore, disable thread-level cache topology in the general machine
> part. At present, i386 has not enabled SMP cache, so disabling the
> thread parameter does not pose compatibility issues.
> 
> In the future, if there is a clear demand for this feature, the correct
> approach would be to add a new control field in MachineClass.smp_props
> and enable it only for the machines that require it.
> 
> [1]: https://lore.kernel.org/qemu-devel/Z3efFsigJ6SxhqMf@intel.com/#t
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


