Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FAECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDedx-0005PD-LW; Tue, 28 Oct 2025 04:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDedg-0005IB-G5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:01:10 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDedc-0000ge-SR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761638465; x=1793174465;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mcvEmhn/P4spbjgCX+JlikJJscb2AAuVknhLRFXGybU=;
 b=ZKz3oCoxs8eRHmJa2+gC3/FKBN5QehSlgax7m14T/J1za84SxHfIqd4e
 nGR98/PsacC3nrKxsLOCQAsaiX0kObLe48b87bzOGZ1xfLlzy2WM+Q7FY
 5TmpZ3fvzsHZbpfY5Ln0ppk+m7MVqIj05ibfnBhPzRMQiMx0E1O0pCrsk
 OSb+/z/6H56qTN7uk7D1EsKL+iY4vvB5jfRTl2wjOODhDWHZQwXAZoHDM
 c4xmej6Roch3buLmeJukMXbQo9dqo0wxzWfgelKx7ReHd961Ebtwt9XbP
 g23XbQbNe7DfzyuZFwlgtqO9UhUv5ywnYDDPhZzA7FwWRxuIfPrxqxTpt A==;
X-CSE-ConnectionGUID: cWpBGZo4RCmgrWRwLZQeWw==
X-CSE-MsgGUID: ExBSmYyZReOJdzNKhZatog==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74332903"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="74332903"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:00:54 -0700
X-CSE-ConnectionGUID: B/68hYG5QZiIHd3AJpjCNA==
X-CSE-MsgGUID: XsKYzkRSS0iy40nLviEy1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="189333690"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:00:50 -0700
Message-ID: <d6ef9ff0-ba22-4cbc-8fef-2c4378dc32af@intel.com>
Date: Tue, 28 Oct 2025 16:00:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] i386/cpu: Enable xsave support for CET states
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-12-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-12-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> From: Yang Weijiang <weijiang.yang@intel.com>
> 
> Add CET_U/S bits in xstate area and report support in xstate
> feature mask.
> MSR_XSS[bit 11] corresponds to CET user mode states.
> MSR_XSS[bit 12] corresponds to CET supervisor mode states.
> 
> CET Shadow Stack(SHSTK) and Indirect Branch Tracking(IBT) features
> are enumerated via CPUID.(EAX=07H,ECX=0H):ECX[7] and EDX[20]
> respectively, two features share the same state bits in XSS, so
> if either of the features is enabled, set CET_U and CET_S bits
> together.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Co-developed-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


