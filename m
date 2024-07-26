Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344F2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 08:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXGMi-0007CT-Ga; Fri, 26 Jul 2024 04:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sXGMf-0007BG-RU; Fri, 26 Jul 2024 04:31:49 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sXGMc-0006cH-88; Fri, 26 Jul 2024 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721982706; x=1753518706;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=e1TTAQgqV5Lsq/BVcPUOuVC2qkQBDtpIDqrvlF3oUl8=;
 b=XihyBbiVRjk//qvmLwTZ0PeM392iqsLDjG7gMO5lclBn1R80a+ng2OEZ
 wLkvvv7QlPhZ8ztnrNWI1saVhyr1V6OYn2vdBNyfgb0doYqhAI8tXbSzw
 nTfALsmUaFghAWPvMbOU7WG37fwFq7PKe/H+ISCGI5Ut538uHKnQPlTPq
 wZLB9PXSGG3QgpF0BH9z+5Z/tbSgW15QHGKLr6jVksFQo5oKDyWx9+h7r
 /5KxjqEU9g4l0HX4tecceoq569o58tOs9h3d5fvhpatap4tEewBklSCvF
 nDeneMV7QM/CvpU01wpNbtwBG3MjZGFDvlFSzlGtDPRcZrudXOi0za/+7 g==;
X-CSE-ConnectionGUID: K4MMKXKDRA2t8YUwPYLMMQ==
X-CSE-MsgGUID: XhNWKyXtQP661RxeMpKlwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19904920"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; d="scan'208";a="19904920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2024 01:31:42 -0700
X-CSE-ConnectionGUID: xq+6sqHzQy6JDuZ6Q7lrGg==
X-CSE-MsgGUID: 1xN54sKzRsK8w62sthl36w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; d="scan'208";a="83835655"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 26 Jul 2024 01:31:34 -0700
Date: Fri, 26 Jul 2024 16:47:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 peter.maydell@linaro.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com
Subject: Re: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU
 unpark logic
Message-ID: <ZqNil8XHVGf9XAPW@intel.com>
References: <20240725145132.99355-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725145132.99355-1-salil.mehta@huawei.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 25, 2024 at 03:51:32PM +0100, Salil Mehta via wrote:
> Date: Thu, 25 Jul 2024 15:51:32 +0100
> From: Salil Mehta via <qemu-devel@nongnu.org>
> Subject: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU unpark
>  logic
> X-Mailer: git-send-email 2.34.1
> 
> Loop should exit prematurely on successfully finding out the parked vCPU (struct
> KVMParkedVcpu) in the 'struct KVMState' maintained 'kvm_parked_vcpus' list of
> parked vCPUs.
> 
> Fixes: Coverity CID 1558552
> Fixes: 08c3286822 ("accel/kvm: Extract common KVM vCPU {creation,parking} code")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  accel/kvm/kvm-all.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


