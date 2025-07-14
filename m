Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9367DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEz9-0000AZ-NN; Mon, 14 Jul 2025 04:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubEYp-0007U3-9Y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:29:19 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubEYm-00081l-Sj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752481757; x=1784017757;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cq/C9VCzD/tKIV2Oog5RSseyAu2LNEh6e9pImor808I=;
 b=dFDXzbxl7bwjLBeuJR5IqCjTgqEprEkis0xQGwetFqfEpG5hr/mi6/Eb
 pqYgkRDpx2vzvDaYp/OVI+L2Bm9tXyGMvm2iBN8JcqYO31xjeP3PodnXR
 bgjSUM+X2SPB4cCwIfr5WWFdHOl9iSCeceqH2DZrnn3BbFPg5jGi/dW2N
 bmD2JRcw8ygIlTxEnHd9p+Ahet2t0+entRq6nv7XwbyyyvoVAn/LrZKgT
 dnGJRCegj+exhbRY1fJ+OINfsUQZKrSNUbtgctKOzf5xZj5CmjHZXPyjr
 VNgt5NLqayn0mX1yc1TLZI/q6KxbxRdffmcPPDIblan08QDEi1H9DWcg9 g==;
X-CSE-ConnectionGUID: Y77N57qLQcS8PigzaozmyA==
X-CSE-MsgGUID: NF9yOcYcSeSzaddnzLz/SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54636594"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="54636594"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 01:29:15 -0700
X-CSE-ConnectionGUID: fEu5Krt4ShuIKgUI/DDRjQ==
X-CSE-MsgGUID: SG2ioqUxTLqtOijSZxZk5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="194078662"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 01:29:12 -0700
Message-ID: <2cc840fb-53b4-44b9-a05c-3edace80abb5@intel.com>
Date: Mon, 14 Jul 2025 16:29:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-5-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250714080859.1960104-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
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

On 7/14/2025 4:08 PM, Zhao Liu wrote:
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> 
> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> On Intel platform:
> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
> logical processors in the physical package".
> 
> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> CPUID.04H.EAX[31:26], which matches the expected result.
> 
> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> it's necessary to round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise there would be unexpected results in guest with
> older kernel.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though threads-per-core should actually be 2.
> 
> And on AMD platform:
> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
> result meets our expectation.
> 
> So round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer only
> for Intel platform to solve the unexpected result.
> 
> Use the "x-vendor-cpuid-only-v2" compat option to fix this issue.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

