Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPDnC-0005kv-Oe; Thu, 04 Jul 2024 00:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sPDnA-0005kP-Tl
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:09:56 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sPDn8-0000yO-Ol
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720066195; x=1751602195;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vPfv98N33pPnna36PiJA/F9cC9nEMA5OavXDbU2b7Iw=;
 b=XlFZlr0JzkfYf2rbKGMlB66G9Ro9/al2YjGb60Xs6HwPHBHwfPh93Bqq
 gqNm8yAR3mFn6zrqnGgYwd4vg1pUBcq/n/0l/QRV0sfuFpqU8THym87h6
 veweYagmyq9JW4r6O2kRDJ+qmOSRwODwOcD7DMWcY3MrCr3KskU0IbmLX
 XDE0eX05+FwAxWtlwL/EtfqWDl61ZPLrcc0vo+Llh2b0ADGAoJKG8F3j+
 UdO4sMlMFoQXL76enu8o2ogLyDOnN8UlfiFOeC9970JnWLV7fQslgRjAG
 8WT4tvpDatousvID1xW9svE6ntW0sjaO3x7IFFnz2tsPiVfV7o57IV8t2 A==;
X-CSE-ConnectionGUID: AmpwQdXRRb+ALz+5B27r6A==
X-CSE-MsgGUID: 984pOd8UT1Sv+5lgNlECRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21195172"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="21195172"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 21:09:52 -0700
X-CSE-ConnectionGUID: geRWiIKuQAehZqJYaC3G0g==
X-CSE-MsgGUID: 8gcTW4u+SQK0aH2QY11Lqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="84008243"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 21:09:49 -0700
Message-ID: <213b9762-205e-4d48-b7f7-1948d0f3b0d9@intel.com>
Date: Thu, 4 Jul 2024 12:09:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/31] i386/sev: Add support for SNP CPUID validation
To: Michael Roth <michael.roth@amd.com>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com,
 pbonzini@redhat.com, thomas.lendacky@amd.com, isaku.yamahata@intel.com,
 berrange@redhat.com, kvm@vger.kernel.org, anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-21-pankaj.gupta@amd.com>
 <ce80850a-fbd1-4e14-8107-47c7423fa204@intel.com>
 <20240704003406.6tduun5n25kgtojf@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240704003406.6tduun5n25kgtojf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
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

On 7/4/2024 8:34 AM, Michael Roth wrote:
> On Tue, Jul 02, 2024 at 11:07:18AM +0800, Xiaoyao Li wrote:
>> On 5/30/2024 7:16 PM, Pankaj Gupta wrote:
>>> From: Michael Roth <michael.roth@amd.com>
>>>
>>> SEV-SNP firmware allows a special guest page to be populated with a
>>> table of guest CPUID values so that they can be validated through
>>> firmware before being loaded into encrypted guest memory where they can
>>> be used in place of hypervisor-provided values[1].
>>>
>>> As part of SEV-SNP guest initialization, use this interface to validate
>>> the CPUID entries reported by KVM_GET_CPUID2 prior to initial guest
>>> start and populate the CPUID page reserved by OVMF with the resulting
>>> encrypted data.
>>
>> How is KVM CPUIDs (leaf 0x40000001) validated?
>>
>> I suppose not all KVM_FEATURE_XXX are supported for SNP guest. And SNP
>> firmware doesn't validate such CPUID range. So how does them get validated?
> 
> This rules for CPUID enforcement are documented in the PPR for each AMD
> CPU model in Chapter 2, section "CPUID Policy Enforcement". For the
> situation you mentioned, it's stated there that:
> 
>    The PSP enforces the following policy:
>    - If the CPUID function is not in the standard range (Fn00000000 through
>      Fn0000FFFF) or the extended range
>      (Fn8000_0000 through Fn8000_FFFF), the function output check is
>      UnChecked.
>    - If the CPUID function is in the standard or extended range and the
>      function is not listed in SEV-SNP CPUID
>      Policy table, then the output check is Strict and required to be 0. Note
>      that if the CPUID function does not depend
>      on ECX and/or XCR0, then the PSP policy ignores those inputs,
>      respectively.
>    - Otherwise, the check is defined according to the values listed in
>      SEV-SNP CPUID Policy table.
> 
> So there are specific ranges that are checked, mainly ones where there
> is potential for guests to misbehave if they are being lied to. But
> hypervisor-ranges are paravirtual in a sense so there's no assumptions
> being made about what the underlying hardware is doing, so the checks
> are needed as much in those cases.

I'm a little confused. Per your reference above, hypervisor-ranges is 
unchecked because it's not in the standard range nor the extended range.

And your last sentence said "so the checks are needed as much in those 
cases". So how does hypervisor-ranges get checked?

> -Mike
> 
>>
>>> [1] SEV SNP Firmware ABI Specification, Rev. 0.8, 8.13.2.6
>>>
>>


