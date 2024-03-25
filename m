Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC63C47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 00:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roYJ1-0003Ui-4n; Sun, 24 Mar 2024 20:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1roYIz-0003UT-Fs
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 20:35:13 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1roYIw-0002gz-Ul
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 20:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711326911; x=1742862911;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=X+Z2kZZS93Y5BQ6xU/B3LH5TiW4Vb5piaiw2nSuDHVQ=;
 b=ZppYENcaDq0V6bbGx2mLTq423IiLGTXdG8j4Hdjt8sUvYeE5aDeYdiBB
 ku8/3B5Ykq7w057BSsdCeoyWUun/t1qWCvDm3v7pBaGIyNuhbxyVQuWH3
 5oRR+UxV5+BVQkBK9xZ43s7aY1vQ+X7fftGpZlnnm6w+yp6puD4RzMY40
 dQXAOUruV7LBL/J2zPcWx8dwUvJ0xymlKMwYxxX+2UIEHTD6rqaz4Q57g
 sKBRsPUbvrC4GgyqUajLu1Walh7IH1LItALtt0X5kJ8E1v8qVrggMTWhM
 PzFUV2tD4ggoIyoHd7IgLk6tHoeolaKAUOqmoAapo+qCTwnxKRmorYRHT g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23762847"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; d="scan'208";a="23762847"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2024 17:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; d="scan'208";a="15410868"
Received: from unknown (HELO [10.238.0.234]) ([10.238.0.234])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2024 17:35:04 -0700
Message-ID: <e60e9ae0-7c29-4936-a530-bae92d47a1dd@linux.intel.com>
Date: Mon, 25 Mar 2024 08:35:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add support for LAM in QEMU
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com
Cc: xiaoyao.li@intel.com, chao.gao@intel.com, robert.hu@linux.intel.com
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
 <d424a315-1b20-47bf-a88e-394f576c3cc1@linux.intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <d424a315-1b20-47bf-a88e-394f576c3cc1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


