Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197AEC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduZD-0001Fo-Tj; Tue, 13 Aug 2024 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sduZ5-0001EP-LH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:40:13 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sduZ3-0007qG-LL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723567206; x=1755103206;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=Lnxq35VvZsWfmZi7iauTP0H4EyqOn3yOccL8mcgkVmM=;
 b=TtOY9i2//bwrbWXza82ie20qCC1nWHWwumNWgFv8CrvT+OyY6s961Su3
 5zh7Z6Sv7oAfsNuJskoEUPVEkqjFix+xdbmEumxqvWetU+qUs2Mfavvr3
 11aE85toQFJPECGwWXqvyVrJd0+W50XF9FBkZnMksXFdr5idGfTOPY0dm
 om8M5MqBcb5wd7RgwyZMRtdOADgYMwCLfESDtf/LU+RXobywlwjOGohby
 m4bFD7FcqgujOlC/2mOzLehtr01fPWtkwQmX6Uo+a+Zd8+6iqCNPIupdJ
 Bi9H50Y9Nh/+tIyYl7AIIiTPXOZj03mIjOL770Wk2edzVf/3KDRvuCQJK g==;
X-CSE-ConnectionGUID: lkpC9G+JTTWdfLO5S9AYog==
X-CSE-MsgGUID: eeCCRFVkQJ+/4mrIAkvJfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21714573"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; d="scan'208";a="21714573"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 09:40:03 -0700
X-CSE-ConnectionGUID: gZzRXnkNQ8mSVXBmgADFOA==
X-CSE-MsgGUID: EuJiIVnbQ6m9p59U8qPgzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; d="scan'208";a="62871955"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.228.22])
 ([10.124.228.22])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 09:40:00 -0700
Message-ID: <985da2cc-5281-4986-b1bb-0334179ece6d@intel.com>
Date: Wed, 14 Aug 2024 00:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, zhao1.liu@intel.com,
 John Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>
References: <20240813033145.279307-1-xiaoyao.li@intel.com>
 <20240813112734.6b2394b9@imammedo.users.ipa.redhat.com>
 <13ab0652-8223-4c04-be63-09a7a81467af@intel.com>
Content-Language: en-US
In-Reply-To: <13ab0652-8223-4c04-be63-09a7a81467af@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/13/2024 10:51 PM, Xiaoyao Li wrote:
> On 8/13/2024 5:27 PM, Igor Mammedov wrote:
>> On Mon, 12 Aug 2024 23:31:45 -0400
>> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>>> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
>>> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
>>> module level, are configured for the guest, e.g., -smp xx,dies=2.
>>>
>>> However, 1) TDX architecture forces to require CPUID 0x1f to 
>>> configure CPU
>>> topology. and 2) There is a bug in Windows that Windows 10/11 expects 
>>> valid
>>> 0x1f leafs when the maximum basic leaf > 0x1f[1].
>>   1. will it boot if you use older cpu model?
> 
> It can boot with any cpu model that has .level < 0x1f.

I realize just now that we don't need to introduce "x-cpuid-1f" as the 
workaround for buggy windows. We can always workaround it by limiting 
the maximum basic CPUID leaf to less than 0x1f, i.e., -cpu xxx,level=0x1e

I think we can ignore this patch for now. I will re-submit it with TDX 
enabling series, and with "x-cpuid-1f" interface removed.

>>   2. how user would know that this option would be needed?
> 
> Honestly, I don't have an answer for it.
> 
> I'm not sure if it is the duty of QEMU to identify this case and print 
> some hint to user. It's the bug of Windows, maybe Mircosoft should put 
> something in their known bugs list for users?
> 


