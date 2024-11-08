Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C665D4335C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 02:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9EW9-0006sS-JK; Thu, 07 Nov 2024 21:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t9EW5-0006sH-Hr
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 21:14:29 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t9EW3-0007Ll-1x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 21:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731032067; x=1762568067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wrPKQ+gKJ4UWg0JoASdk8oJV1qGe96BO6ocY9KOW9Ew=;
 b=fl8mi41PMuhN/nnmIkzqojkHWtmiZoM+iOASdjICfVtM/RpFL+wuFnxD
 ah+zONgE1qJwh9+M61KhR7GyIxVPM3dbUV8mAG8gay6BeuvxtJ8CooccZ
 tuBGpDMEGL4sey3XXKr0mXOEL6oFXQhFLz+C4JFQiIYVh6mueZ1O7Hjx5
 HJGJ8SDXNSA6G++EetDGsteORu7WdkJU7BcQKFYA6/3LhVxcShIeZi15y
 m78JxZ2oR4N865W+S/mNSC23zQQnB5y9U4U8s9kdZjyev6+k5GU4gqeBu
 BSlTYplD7FzCyuFRy9UmzSP7groCeGKlU4z5rBJvRy51b7LJllGw/Bz6n g==;
X-CSE-ConnectionGUID: +oNI//ISRKmLdENuJJvpeA==
X-CSE-MsgGUID: 9tU2zna4SZmJ4Suk19UYRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="18533088"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; d="scan'208";a="18533088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 18:14:24 -0800
X-CSE-ConnectionGUID: HMIoyGIBTOGnYXw5b6XWLQ==
X-CSE-MsgGUID: 6glL6PAMT46/P50Op3Uq+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; d="scan'208";a="85324973"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 07 Nov 2024 18:14:19 -0800
Date: Fri, 8 Nov 2024 10:32:16 +0800
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
Message-ID: <Zy14MDBuiFuyj0YS@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-3-dongli.zhang@oracle.com>
 <ZyxxygVaufOntpZJ@intel.com>
 <57b4b74d-67d2-4fcf-aa59-c788afc93619@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b4b74d-67d2-4fcf-aa59-c788afc93619@oracle.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

> I will wait for a day or maybe the weekend. I am going to switch to the previous
> solution in v2 if there isn't any further objection with a more valid reason.
> 
> Thank you very much for the feedback!
> 

Welcome. It's now v9.2 soft frozen. I'm also continuing to review your
remaining patches.

Regards,
Zhao


