Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5427AC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZs65-00075n-0u; Thu, 10 Jul 2025 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZrun-0006Qi-1W
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:06:30 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZruk-0003gC-5I
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752156378; x=1783692378;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=y8wqlS8C6h0OKoPJjIl8JuQ8x6IxXnImpI/Cnt0Jyys=;
 b=aZ95D1AXi70XJjiZHxBXUNVFrRd1rdoLSJFz4lNH7n9Y1papzaiK6MRi
 XgZ3XR6rkRPOIgEtQ0qajlKXQCaFNOuKLXe1xChao9yU4DNP3NttcuFJx
 HAGwKUHalI28Hb3PKS4Mn6xGQZ2sfhiwLr2IbT0lQQbDlFEYk3BoUEtJo
 RG4E7TmyLUDwvn9fqy0U7e9zqsIxYwhQHQKfn71UJcdC08//EmO/7RQxY
 RU4C7esyz4OCb57Al+R6oY9n/pS7de+qJLswerBv7JCjJoAeAw10KoYPX
 qkWdmkwQZQVHVcgI5yKbl0oQp03ss7FRd0H1TFl0D3+dgpMDcvY/28R60 A==;
X-CSE-ConnectionGUID: QgOPLovlTGCJs8vZZrRaQA==
X-CSE-MsgGUID: veBecdUNRyy8+0V6ne3VAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54371444"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="54371444"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 07:06:15 -0700
X-CSE-ConnectionGUID: rnYcxlFvQwSVUk7QvBHNEA==
X-CSE-MsgGUID: UDLhU9cjRyaTQFAYqOHefw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="187095763"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 07:06:14 -0700
Message-ID: <efbbe5f4-6f0c-4470-9968-c389cb206088@intel.com>
Date: Thu, 10 Jul 2025 22:06:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tdx: Fix the report of gpa in QAPI
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, chao.p.peng@intel.com
References: <20250710035538.303136-1-zhenzhong.duan@intel.com>
 <3b6c0344-0694-4a56-99dd-c7d437e43428@intel.com>
Content-Language: en-US
In-Reply-To: <3b6c0344-0694-4a56-99dd-c7d437e43428@intel.com>
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

On 7/10/2025 7:40 PM, Xiaoyao Li wrote:
> On 7/10/2025 11:55 AM, Zhenzhong Duan wrote:
>> Gpa is defined in QAPI but never reported to monitor because has_gpa is
>> never set to ture.
>>
>> Fix it by setting has_gpa to ture when TDX_REPORT_FATAL_ERROR_GPA_VALID
>> is set in error_code.
> 
> Hi Zhenzhong,
> 
> I would like to understand what the problem is without panic_info- 
>  >u.tdx.has_gpa being set?

Never mind, I figure it out.

qapi_event_send_guest_panicked() in qemu_system_guest_panicked will send 
the event and data. Libvirt tries to parse the data, but find the 
.has_data field is not set correctly.

My original patch used (gpa == -1) as the indicator for whether gpa is 
valid, this needs to be cleaned up. I will send the cleanup patch.

