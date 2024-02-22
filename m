Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834C4C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 02:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcydk-00041G-Mv; Wed, 21 Feb 2024 21:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rcydi-00040z-4u
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:16:46 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rcyda-0005Nm-O4
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708568198; x=1740104198;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GVVlhEg+VUhDJj60uKfZHvT0dykSv132W4akNvfxTVs=;
 b=l3hMBt0GkwDDkw1kKLliBm4WfMg3HWLz4es0smXYLuVMba3nQ1bZBCA7
 /BvHeUsG4CSvg9k/g07jJZkJ1Qz+eQ6jDYl/aCy51SUoItuTcj0iyHCZE
 0PzSU7M8gDRHoj9e62tviVhASdhjngjGZS7M91UvyRL2FxVpK+g9yVXpR
 9AvqfT5Yaeu9zXJ7ojlzPdlgmA08y3dXi2w1LN+4ctGrQSubhzAe1f0+d
 BCnaGx3O+8IX1FQ97F5vS5u3mxlJwHnrndpj4FfyFiv5aSVPdjPckrWgQ
 XAC9Kj8QYKPtOE6Jcu5BA4uIx6+/xf9L4ltGreaafltimDR/oNXDehkOu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14182076"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="14182076"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 18:16:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="9915880"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.18.46])
 ([10.93.18.46])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 18:16:32 -0800
Message-ID: <4a88cf43-dd29-4b57-8a9e-f76451b9af1f@linux.intel.com>
Date: Thu, 22 Feb 2024 10:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add support for LAM in QEMU
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 chao.gao@intel.com, robert.hu@linux.intel.com
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
 <d424a315-1b20-47bf-a88e-394f576c3cc1@linux.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <d424a315-1b20-47bf-a88e-394f576c3cc1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Ping...

Hi Paolo,
do you have time to have a look at this patchset?


On 1/22/2024 4:55 PM, Binbin Wu wrote:
> Gentle ping...
> Please help to review and consider applying the patch series. (The KVM
> part has been merged).
>
>
> On 1/12/2024 2:00 PM, Binbin Wu wrote:
>> Linear-address masking (LAM) [1], modifies the checking that is 
>> applied to
>> *64-bit* linear addresses, allowing software to use of the untranslated
>> address bits for metadata and masks the metadata bits before using 
>> them as
>> linear addresses to access memory.
>>
>> When the feature is virtualized and exposed to guest, it can be used for
>> efficient
>> address sanitizers (ASAN) implementation and for optimizations in 
>> JITs and
>> virtual machines.
>>
>> The KVM patch series can be found in [2].
>>
>> [1] Intel ISE https://cdrdv2.intel.com/v1/dl/getContent/671368
>>      Chapter Linear Address Masking (LAM)
>> [2] 
>> https://lore.kernel.org/kvm/20230913124227.12574-1-binbin.wu@linux.intel.com
>>
>> ---
>> Changelog
>> v4:
>> - Add a reviewed-by from Xiaoyao for patch 1.
>> - Mask out LAM bit on CR4 if vcpu doesn't support LAM in 
>> cpu_x86_update_cr4() (Xiaoyao)
>>
>> v3:
>> - https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04160.html
>>
>> Binbin Wu (1):
>>    target/i386: add control bits support for LAM
>>
>> Robert Hoo (1):
>>    target/i386: add support for LAM in CPUID enumeration
>>
>>   target/i386/cpu.c    | 2 +-
>>   target/i386/cpu.h    | 9 ++++++++-
>>   target/i386/helper.c | 4 ++++
>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: f614acb7450282a119d85d759f27eae190476058
>


