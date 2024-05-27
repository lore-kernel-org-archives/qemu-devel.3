Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC18C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBX3N-00060a-Qt; Mon, 27 May 2024 05:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBX3B-0005rW-SR; Mon, 27 May 2024 05:53:55 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBX39-0008M5-Lk; Mon, 27 May 2024 05:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716803632; x=1748339632;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BUIk9Rus9L/HpaU1BXvE1EmkaCoph9S57b23c7qT2EM=;
 b=jhOX/UTAd/vb8s1dmjVruF/7uXcDU/eIc1CqC19yylJ5YXwqd99KrgDc
 mxDLVu0wUuQtyid5uQYwRemTWdGMUjZQieJk9mBu7zC1D+MpGK4qEREsZ
 Jvh2NH7F4FnMI6m5Ox1QryZk0rrhztfvHKb0Iq74doNBhbIr+z799iRd0
 h4swj88P26Qdkj7Kgc+hKp2b0L8NUAtuyc7OE7ueIpJ/NZei8rH6VNJhI
 olrdEHNyKWdjzz5aZFhjVRVm1njV3V2+ceN0CXydFm/m/uTPf4PrMYpeJ
 28kmkNR5U6QNL6Vhw3bi/92UoJ2tr5o5lWPwZ6dW+/muLROKmeWUlygjn g==;
X-CSE-ConnectionGUID: +w/orFDdRrun7Lgx2pjgNQ==
X-CSE-MsgGUID: L3wCq9BVQFmeavewJLCpRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13286027"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="13286027"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 02:53:47 -0700
X-CSE-ConnectionGUID: yeS/vLVGS96D9Qsre28CeA==
X-CSE-MsgGUID: /G/k4l2NS/uO0McdkEG5Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="57904338"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 27 May 2024 02:53:38 -0700
Date: Mon, 27 May 2024 18:09:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH V11 1/8] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Message-ID: <ZlRbvdTEcqgoEmuo@intel.com>
References: <20240522211111.232114-1-salil.mehta@huawei.com>
 <20240522211111.232114-2-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522211111.232114-2-salil.mehta@huawei.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Wed, May 22, 2024 at 10:11:04PM +0100, Salil Mehta via wrote:
> Date: Wed, 22 May 2024 22:11:04 +0100
> From: Salil Mehta via <qemu-devel@nongnu.org>
> Subject: [PATCH V11 1/8] accel/kvm: Extract common KVM vCPU {creation,
>  parking} code
> X-Mailer: git-send-email 2.34.1
> 
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
> is spawned. This is common to all the architectures as of now.
> 
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
> support vCPU removal. Therefore, its representative KVM vCPU object/context in
> Qemu is parked.
> 
> Refactor architecture common logic so that some APIs could be reused by vCPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
> with trace events. No functional change is intended here.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++--------------
>  accel/kvm/kvm-cpus.h   | 23 ++++++++++
>  accel/kvm/trace-events |  5 ++-
>  3 files changed, 90 insertions(+), 33 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


