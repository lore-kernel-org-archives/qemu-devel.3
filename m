Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF66C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvdE-0002Ms-If; Wed, 16 Jul 2025 02:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubvd8-0002Ce-Nm
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:28:40 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubvd5-0002v9-Rn
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752647316; x=1784183316;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hKKcDyHx6DNwwChFLkdCBJRnzKlBjlTOVCeNq17uiac=;
 b=nf6wqpXrGABAzED32ICGO03pk8PpBmst1lI/Ua0AWxLKSorCTDCV4p+S
 H24Nk98X1gOJnCdk1HCZrh3kV6+lUpLA6F4jmprDT7DNJzyMMptPzKLk7
 zCrLj3b4HGOKe/JMSp0wpy4nFuQW4aRKSdeuQI2WGiVrfRlBFhcxlhY86
 hZPCmTWMp3yZjlXsE9dQyrLIp8Y354qDVI6KxIwFYGcyzIutskgiDMnJx
 hL2S6fZKs3LouGHSUSK4f2oViSukzuUtvi0VF8WnwygZZpWqdOc3Ef8/j
 WfDqGmqvAPWoYqH0oQ5i9PCz2dXLsdnvRKuala8rt3vO0Iz4OLkTNRKJp A==;
X-CSE-ConnectionGUID: kn2sSbjVSCqpqbXeSf+BxQ==
X-CSE-MsgGUID: +ycEGbKBSvihFKXhg66eag==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54819115"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="54819115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:28:33 -0700
X-CSE-ConnectionGUID: CD8i571HTe+5IMmERv/8xA==
X-CSE-MsgGUID: UcBip278QSC4SC3ckK4zhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="158145109"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:28:30 -0700
Message-ID: <74df57ca-a47e-46d8-b0ee-efb03dd774f3@intel.com>
Date: Wed, 16 Jul 2025 14:28:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/i386: Add TSA feature flag verw-clear
To: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com,
 zhao1.liu@intel.com, bp@alien8.de
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com>
 <e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
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

On 7/11/2025 3:46 AM, Babu Moger wrote:
> Transient Scheduler Attacks (TSA) are new speculative side channel attacks
> related to the execution timing of instructions under specific
> microarchitectural conditions. In some cases, an attacker may be able to
> use this timing information to infer data from other contexts, resulting in
> information leakage
> 
> CPUID Fn8000_0021 EAX[5] (VERW_CLEAR). If this bit is 1, the memory form of
> the VERW instruction may be used to help mitigate TSA.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

