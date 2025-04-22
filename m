Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36743C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Eb1-0001vO-Je; Tue, 22 Apr 2025 10:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7Eaz-0001ut-St
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:27:33 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7Eaw-0001gb-TS
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745332051; x=1776868051;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LiqVpjwC0ESH5Rvz3dOIRZTYTRSBe0WCOoAuiJLG0F8=;
 b=glCuhQnlbR8MZdGND1E+jhvv+58JgC9PDBeYRUUAZEc35wcHr6N/0Q2M
 TL2EJHL8NQOcbY/2fV6pQNpgWji9LaIRnn7NcvijqPpTa85M2IKSC+2qY
 qq6AZ4QSTBJkKAl67XLC6y80OYOjhBvQqsKrI4YKSM+jJzQm++N7WY8KU
 LhDbiPsgsT5kLChZh1GlREVLT5R7CE11Q1OOmUoR4FN93DQ5ZOtfDw9tF
 kKTrdGu0705vKgjxSdLhSp2aBsr2EwvouZWbbx8NPJTo+DVco/xH5N+va
 QrCBnp5llvcqAMB+V949cXU4tTPt1rzspOxCaoGGxyxkU4bJUfT88Y6O0 w==;
X-CSE-ConnectionGUID: lrJzTMaeR+mm9HKsRH6zPA==
X-CSE-MsgGUID: K5esqfgwSjKSGV4ulXok2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46131600"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="46131600"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:27:28 -0700
X-CSE-ConnectionGUID: W+edb3leSSy+UmoKkknyFw==
X-CSE-MsgGUID: A+pJfsxjSGOnF3J0xwRHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="132573423"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:27:24 -0700
Message-ID: <7db8dd10-229a-4fc9-afe0-54b023ce88ac@intel.com>
Date: Tue, 22 Apr 2025 22:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/55] i386/tdx: Introduce is_tdx_vm() helper and cache
 tdx_guest object
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-7-xiaoyao.li@intel.com> <aAIfL0jS0lWSpvZE@intel.com>
 <12ec4e5c-33af-47a0-817f-b1fd0420f8f5@intel.com> <aAelqKOePQ9gplDm@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAelqKOePQ9gplDm@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/22/2025 10:20 PM, Zhao Liu wrote:
>>>> +#ifdef CONFIG_TDX
>>>> +bool is_tdx_vm(void);
>>>> +#else
>>>> +#define is_tdx_vm() 0
>>>> +#endif /* CONFIG_TDX */
>>>> +
>>> a little nit: could we rename it as "tdx_enabled"?
>>>
>>> Then the cases like these would be neater?
>>
>> When sev support was added, it was seen as a feature for the VMs that are
>> created on AMD platform. I think that's why it got called sev_enabled().
>>
>> But for TDX, it is introduced as a different type of VM in contrast to the
>> legacy/normal VMX VMs. We need to pass specific TDX vm type to
>> KVM_CREATE_VM. Based on this, is_tdx_vm() was chosen.
> 
> But isn't AMD's SEV also defined as the VM type?

The initial SEV support that introduced sev_eanbled(), didn't introduce 
the VM type.

The specific type for SEV* was added later.

> static const char *vm_type_name[] = {
>      [KVM_X86_DEFAULT_VM] = "default",
>      [KVM_X86_SEV_VM] = "SEV",
>      [KVM_X86_SEV_ES_VM] = "SEV-ES",
>      [KVM_X86_SNP_VM] = "SEV-SNP",
>      [KVM_X86_TDX_VM] = "TDX",
> };
> 
> Functionally, they are part of the coco functionality provided by
> different vendors, so it's better thatt both could be in the same place
> as much as possible, including file location, naming style. Of course,
> it's not a big deal, and it can be cleaned up after merge if needed.

yes, cleanup can be a separate work if Paolo doesn't dislike.

>> I don't think the different name is a big issue, as nobody mentions it from
>> the initial RFC to current v8 until you.
> 
> The Chinese saying: There are a thousand Hamlets in a thousand people's
> eyes :-).
> 


