Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0FCD33992
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5R2t-0000WY-Jr; Mon, 28 Oct 2024 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5R2p-0000WJ-C4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:48:36 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5R2l-0005gE-KR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730126912; x=1761662912;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DJL8wQQzsb0xYiPOXsVHauDQKrxuOxW7vpHL52cjzF0=;
 b=ek2mb8RpviM/w+6OjfgDlLcX3mzV/av9m41jnPOLo5uOPpBxnqtQFk0j
 JU9P/2A6Z/eCSea9O8qLpKz3QRKPL5ybyNRuHnipAmBq2/7aCi1TiPb+S
 tdgRr2tGJBrBJq7VgLjwFuoRrE6E3Bz/ujM3VXD0frWjYgNRkQMr7rm+1
 myWhZGl8Pm0uKwbufsM307ZpHB/xZeBjOMWd5GPc/7+V4dZUmk2xhOHEm
 2pI7ItuTKAy3iQpGoMef5nPrrh7lfeiHrpfqOWV3e70QDN6HR9NWqoqhF
 g0tFknJTc4C01FZhFDsQuNs2f3k1n4KxN3jCr1kPbS8sLWe4NxllfD2B1 A==;
X-CSE-ConnectionGUID: XMafktynRZy+IfyxbECVgQ==
X-CSE-MsgGUID: zpH0lCecSOCI24A7RW9f5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40302148"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="40302148"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 07:48:27 -0700
X-CSE-ConnectionGUID: kCjLcRMXRUy5TpZ0I4KHzg==
X-CSE-MsgGUID: /zlekO4FRO+jtqRyvMx0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="82066902"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.172])
 ([10.124.227.172])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 07:48:24 -0700
Message-ID: <14c432e8-5049-4051-ba1f-303f76bfbe19@intel.com>
Date: Mon, 28 Oct 2024 22:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
To: Paolo Bonzini <pbonzini@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
 <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
 <Zx9hPncYMxsF3Hkh@linux.bj.intel.com>
 <340b5b33-8b77-43ab-b0dc-c6e9f610b4a2@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <340b5b33-8b77-43ab-b0dc-c6e9f610b4a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.782, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/28/2024 6:45 PM, Paolo Bonzini wrote:
> On 10/28/24 11:02, Tao Su wrote:
>> On Mon, Oct 28, 2024 at 09:45:39AM +0100, Paolo Bonzini wrote:
>>> On 10/28/24 03:45, Tao Su wrote:
>>>> Since the highest supported vector length for a processor implies that
>>>> all lesser vector lengths are also supported, add the dependencies of
>>>> the supported vector lengths. If all vector lengths aren't supported,
>>>> clear AVX10 enable bit as well.
>>>>
>>>> Note that the order of AVX10 related dependencies should be kept as:
>>>>           CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
>>>>           CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
>>>>           CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
>>>
>>> I think you need to add a set of dependencies so that avx10 cannot be 
>>> set,
>>> unless all the older AVX features that it's composed of are 
>>> available.  From
>>> the manual these are
>>>
>>> AVX512F, AVX512CD, AVX512VW, AVX512DQ, AVX512_VBMI, AVX512_IFMA,
>>> AVX512_VNNI, AVX512_BF16, AVX512_VPOPCNTDQ, AVX512_VBMI2, VAES, GFNI,
>>> VPCLMULQDQ, AVX512_BITALG, AVX512_FP16.
>>
>> Thanks for such a quick review!!
>>
>> AVX10.1 spec said:
>> Intel AVX-512 will continue to be supported on P-core-only processors for
>> the foreseeable future to support legacy applications. However, new 
>> vector
>> ISA features will only be added to the Intel AVX10 ISA moving forward.
>> While Intel AVX10/512 includes all Intel AVX-512 instructions, it
>> important to note that applications compiled to Intel AVX-512 with vector
>> length limited to 256 bits are not guaranteed to be compatible on an 
>> Intel
>> AVX10/256 processor.
>>
>> I.e. AVX10/256 processors will support old AVX-512 instructions
>> (limited to 256 bits and enumerated by AVX10) but not set AVX-512 related
>> CPUIDs. So, I think we can't add these dependencies…
> 
> Of course you're right about AVX10 in general, you still need to add the 
> dependency but only for CPUID_24_0_EBX_AVX10_512.

What if future E-core processor starts to support AVX10/512 but not 
enumerating any individual AVX512 bit? (AVX10.1 spec only states the 
compatibility behavior for P-core-only processors)

> Paolo
> 


