Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2B8CA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGAI-00057k-7O; Tue, 20 Jan 2026 13:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1viGAF-00056I-Lr
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:09:15 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1viGAD-0001AY-PM
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768932554; x=1800468554;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KBTrGAOG3GHU/Gh2kayZjePQbGcEh734b6U31OPXquI=;
 b=nHflk7aqhk7Ot5eJU5e4OQV7NRKobtgEKse28VjFEj7kdZTHDgkCKHuh
 6g3Jz19n1nZBSwOLuuHMRHGCsTiYb+Xa18Asdu4d7+bvJImPIdUEsxbnE
 xuh5Oe1hq71VWsb+kMx1NTK/6ruZaqQwAaLf+xT0g6XbVeeUweKQk/MWt
 Xv10T6ejsj3PmFBExslBTaYTYRHkM+hO2qQf6emj4fw88sB8w/GUZRKQX
 tOOX6M4msfCpP/M3NydnS0AoxPGmTqjoh7wXvEP9Cj7wG/xVaxSEI3xSs
 OTNB5fEw8x9FKpjY2TewQDTfjiLFFUzJ39ONI2I9Urlvq/xPbEE8CNSEU Q==;
X-CSE-ConnectionGUID: 8JNmYk7iQPC8ECvPk1odLg==
X-CSE-MsgGUID: hxNJwIFTRcuT9nyX5GW2VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80454738"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="80454738"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 10:09:09 -0800
X-CSE-ConnectionGUID: 1DZXw2idSMaL80mK8mZe4g==
X-CSE-MsgGUID: 0KkiTAtjRmauPNmX3UZ3Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; d="scan'208";a="237444273"
Received: from unknown (HELO [10.241.241.232]) ([10.241.241.232])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 10:09:06 -0800
Message-ID: <8e73265d-378e-4257-9171-ca67a103da14@intel.com>
Date: Tue, 20 Jan 2026 10:09:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] target/i386: Disable unsupported BTS for guest
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260117011053.80723-1-zide.chen@intel.com>
 <20260117011053.80723-2-zide.chen@intel.com>
 <d3be3cd0-5dce-4410-b2f8-e137562a678c@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <d3be3cd0-5dce-4410-b2f8-e137562a678c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/18/2026 5:47 PM, Mi, Dapeng wrote:
> 
> On 1/17/2026 9:10 AM, Zide Chen wrote:
>> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
>> (bit 11), is deprecated and has been superseded by LBR and Intel PT.
>>
>> KVM yields control of the above mentioned bit to userspace since KVM
>> commit 9fc222967a39 ("KVM: x86: Give host userspace full control of
>> MSR_IA32_MISC_ENABLES").
>>
>> However, QEMU does not set this bit, which allows guests to write the
>> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
>> this may lead to unexpected MSR access errors.
>>
>> Setting this bit does not introduce migration compatibility issues, so
>> the VMState version_id is not bumped.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  target/i386/cpu.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 2bbc977d9088..f2b79a8bf1dc 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -474,7 +474,10 @@ typedef enum X86Seg {
>>  
>>  #define MSR_IA32_MISC_ENABLE            0x1a0
>>  /* Indicates good rep/movs microcode on some processors: */
>> -#define MSR_IA32_MISC_ENABLE_DEFAULT    1
>> +#define MSR_IA32_MISC_ENABLE_FASTSTRING    1
> 
> To keep the same code style and make users clearly know the macro is a
> bitmask, better define MSR_IA32_MISC_ENABLE_FASTSTRING like below.
> 
> #define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)

Yes. Thanks.

> 
>> +#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
>> +#define MSR_IA32_MISC_ENABLE_DEFAULT       (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
>> +                                            MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
> 
> Better move the macro "MSR_IA32_MISC_ENABLE_DEFAULT" after
> "MSR_IA32_MISC_ENABLE_MWAIT".
> 

Thanks. Will do.

>>  #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
>>  
>>  #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))


