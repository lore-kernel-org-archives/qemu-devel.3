Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11EEC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 03:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOTrm-0007be-Po; Mon, 01 Jul 2024 23:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sOTrk-0007bH-Hl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 23:07:36 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sOTrh-0003xA-F6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 23:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719889654; x=1751425654;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m1TOvZROTBz/LcdC1Wgh7F6ey+p+v19zzSHQdL7htbE=;
 b=EjiTI5YP1WAbeP0C5dTIdsKvT0DuH936rhCn19aatYjJwolDc1lGVGPk
 sYrYJO5fEU2LM+I3VUWtT8oQhP/sXUMhWYV9wNSWbHMim2WOfY4L3gyCj
 Lp4gYdwirEO3xlTstzJhOGb1gJDrqcIqJ8eSrkxq36u/GamJfExGoI0N0
 IrTXpbz7a6/4qXb8PPVYruLlNbyLtSUTqNovrVU4L5dFZsBwzM3iDZgsj
 INn8pqvyW6inBaKAsJ6H4W/FBXe5OunRbWhLqfWCS2AZ4WIH3sTsw6hF6
 xoqhbeS+v9v/Q4rJdyb+w/ViL3M6ID8ry6kzBJJTLCgqMzxDFEV+IEksq A==;
X-CSE-ConnectionGUID: E62KktTnSDa+td6qwFWunw==
X-CSE-MsgGUID: iKiq8xw9TN+Zon5QhOHEEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17182585"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="17182585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 20:07:25 -0700
X-CSE-ConnectionGUID: qGt3Wjr4STqlbzg6bBTehA==
X-CSE-MsgGUID: rutYRsDMRH6/Xxlkw3KM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="45708043"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 20:07:21 -0700
Message-ID: <ce80850a-fbd1-4e14-8107-47c7423fa204@intel.com>
Date: Tue, 2 Jul 2024 11:07:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/31] i386/sev: Add support for SNP CPUID validation
To: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com,
 michael.roth@amd.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 isaku.yamahata@intel.com, berrange@redhat.com, kvm@vger.kernel.org,
 anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-21-pankaj.gupta@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240530111643.1091816-21-pankaj.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/30/2024 7:16 PM, Pankaj Gupta wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> SEV-SNP firmware allows a special guest page to be populated with a
> table of guest CPUID values so that they can be validated through
> firmware before being loaded into encrypted guest memory where they can
> be used in place of hypervisor-provided values[1].
> 
> As part of SEV-SNP guest initialization, use this interface to validate
> the CPUID entries reported by KVM_GET_CPUID2 prior to initial guest
> start and populate the CPUID page reserved by OVMF with the resulting
> encrypted data.

How is KVM CPUIDs (leaf 0x40000001) validated?

I suppose not all KVM_FEATURE_XXX are supported for SNP guest. And SNP 
firmware doesn't validate such CPUID range. So how does them get validated?

> [1] SEV SNP Firmware ABI Specification, Rev. 0.8, 8.13.2.6
> 


