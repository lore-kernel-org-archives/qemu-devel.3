Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B41BC54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjkG-0006BE-0B; Tue, 19 Mar 2024 20:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmjkE-0006Aq-Bu
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:23:50 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmjkC-0003iK-1p
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710894229; x=1742430229;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Wdws2eTP+posE92UU5Qg7xQy3oQMNWl87P2iBnvm4p4=;
 b=UYN8xbsWFK1AKE5E7v1QsntsqC5STwhovdU1h/PAUBo4QqBCq8LDPSOh
 wJV99c/vJZCbc9YkJMTUASxEw1zx0FXgshv/7IInmkTQaMudu6msmgzbP
 AAazA4Ijs9DVeEM60720l0+ELuZ3+6mWM2QhhiU5N+b98/7kZ80jveUkk
 FnBQAi0jFO9fhmK605rXyCZQroKu7MfmrK0bvACpEtpindZf+mWRGqcRv
 F9XV+GmcdjeHJVxBXaRjq8bNNz8f5wps6c7k8BAJL+IT/2e+zgPI45Rud
 gZfGPjnps8eFpkkArhxsD+oP7bQ0Etg21k2DYHMbiZjRPilKYWE2D4xIO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16942224"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="16942224"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 17:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; d="scan'208";a="13886603"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 17:23:42 -0700
Message-ID: <1f06acaf-c63e-42b3-b355-3024ded1fd8e@intel.com>
Date: Wed, 20 Mar 2024 08:23:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Export RFDS bit to guests
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chao Gao <chao.gao@intel.com>, antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
References: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
 <7de64137-d11f-4029-b296-3b8a8be35178@intel.com>
 <20240319150851.kllaqhbfysfkqcey@desk>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240319150851.kllaqhbfysfkqcey@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/19/2024 11:08 PM, Pawan Gupta wrote:
> On Tue, Mar 19, 2024 at 12:22:08PM +0800, Xiaoyao Li wrote:
>> On 3/13/2024 10:53 PM, Pawan Gupta wrote:
>>> Register File Data Sampling (RFDS) is a CPU side-channel vulnerability
>>> that may expose stale register value. CPUs that set RFDS_NO bit in MSR
>>> IA32_ARCH_CAPABILITIES indicate that they are not vulnerable to RFDS.
>>> Similarly, RFDS_CLEAR indicates that CPU is affected by RFDS, and has
>>> the microcode to help mitigate RFDS.
>>>
>>> Make RFDS_CLEAR and RFDS_NO bits available to guests.
>>
>> What's the status of KVM part?
> 
> KVM part is already upstreamed and backported:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.8.1&id=50d33b98b1e23d1cd8743b3cac7a0ae5718b8b00

I see. It was not sent to kvm maillist and not merged through KVM tree.

With KVM part in palce,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

