Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CBDC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua8zu-000123-QZ; Fri, 11 Jul 2025 04:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua8vN-0001x1-78
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:16:08 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua8vL-0003Cl-J0
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752221763; x=1783757763;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=cFvtLmQoWdQaH4+C34V10oThfsMInecgZrRSwd6iRoo=;
 b=KAk9Mpl+uGD2CKovXhtyyEFpqIKzgJTb9G/Rv85/I++BkKws93LxFrFT
 njcXGYUxa2jWv9qLyle5YOZlO9hYjPj21lJMQ1ixbc6+2xTOIPcxFdW3d
 nVp4LJqbfmV+HhE2RhuGoykkxRkxVYQEtStuUs/62jK1MvAdgrWEValV3
 D/pL+yyhroXAzz2jsdTPqpI6wHrvUeKIo337d3li5NjmbYA9NxaNaFkz2
 jDY3k3hHSGV5rsQNKQ8hd/LeMSN+IwiK4kT06KyOtri5Qf/BlPHPmiiRU
 QKd8LnhWlfPlku2IYiEMK68B/jPWT3KvKWRRJlIoYCvI0bDOPcKqILxUg Q==;
X-CSE-ConnectionGUID: nPPeWO3rTXyW8TVIYuD+Jw==
X-CSE-MsgGUID: j52SWmioTCaYti6NSHBBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="53734971"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="53734971"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 01:16:01 -0700
X-CSE-ConnectionGUID: rfL7etUrRyaERt2RdF9Q0A==
X-CSE-MsgGUID: 1YS5FWZxRcaVDM1U96UoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="180014156"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 01:16:00 -0700
Message-ID: <c5d96f80-31c0-44dc-8f7a-557367a1abc9@intel.com>
Date: Fri, 11 Jul 2025 16:15:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: merge host_cpu_instance_init() and
 host_cpu_max_instance_init()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250711075507.451540-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250711075507.451540-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/11/2025 3:55 PM, Paolo Bonzini wrote:
> Simplify the accelerators' cpu_instance_init callbacks by doing all
> host-cpu setup in a single function.

btw, it changes the behavior for "-cpu base" with accelerator.

I think it should be OK considering "-cpu base" seems only for 
experiment case.

