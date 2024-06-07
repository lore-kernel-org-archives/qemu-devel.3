Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C871C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 07:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFUJe-0000Oh-6V; Fri, 07 Jun 2024 03:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sFUJc-0000OA-1o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 03:47:12 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sFUJZ-0005zL-5k
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 03:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717746429; x=1749282429;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jsWKQoF+JLIOWUJi2YAMpVKUmb611AxyTxN8GzKdVb0=;
 b=gJxn/WOevjM2X4JC8ivxCfOfiyjWdAwwFc8o6tCKZPjuzWUSj00FQKgY
 YFvFZo8+CWgDnV5OvOuHZWBtdVi9fWJDtSRvVjOrDy3fnjsejVbCPDx4y
 zEpwbsNI6iv3JoeN2UTXWP8YOxGZQbXeuKW535H75RbW7Pbl9hJaT+cvm
 2/qmer1TjpNrtX1iw6or+rHQSjKQUl8yVrlDk/LvOi81bLsMio5EDq/e5
 67Y5znuOwrxCX8m8pyHllSpw2XM8tReH3WMuy3U58jw8RvRA+qcIj+OVF
 9otn7tNHbm3HzbOsZFMs+FGmq+C9V6396BKhLi/gZ2WVmx2A+xI9Pmsbt Q==;
X-CSE-ConnectionGUID: HNnZCA68TxyUG3tQ1MQ7Iw==
X-CSE-MsgGUID: qcb2DSj4RYGr5yy2naSOhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14298502"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; d="scan'208";a="14298502"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2024 00:47:06 -0700
X-CSE-ConnectionGUID: QQfXfkynR9KzneFK6xg0Hw==
X-CSE-MsgGUID: vGwb8Lo7Swm3N5jioEKiHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; d="scan'208";a="69406982"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.247.52])
 ([10.125.247.52])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2024 00:47:03 -0700
Message-ID: <cfeb1a82-62b6-4fe9-a30d-a49e8209caf8@intel.com>
Date: Fri, 7 Jun 2024 15:47:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/apic: Add hint on boot failure because of disabling
 x2APIC
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org
References: <20240606140858.2157106-1-zhao1.liu@intel.com>
 <58ea1275-b71c-4098-b7e6-cde428a2eabb@linaro.org>
 <ZmK6xuhlR7K4CXCP@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZmK6xuhlR7K4CXCP@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.172, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/7/2024 3:46 PM, Zhao Liu wrote:
> Hi Philippe,
> 
> On Fri, Jun 07, 2024 at 08:17:36AM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Fri, 7 Jun 2024 08:17:36 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH] i386/apic: Add hint on boot failure because of
>>   disabling x2APIC
>>
>> On 6/6/24 16:08, Zhao Liu wrote:
>>> Currently, the Q35 supports up to 4096 vCPUs (since v9.0), but for TCG
>>> cases, if x2APIC is not actively enabled to boot more than 255 vCPUs (

why bother mentioning TCG case?

you below example is not for TCG. And the issue is not caused by TCG but 
default cpu model doesn't have X2APIC enabled.

>>> e.g., qemu-system-i386 -M pc-q35-9.0 -smp 666), the following error is
>>> reported:
>>>
>>> Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:449:
>>> qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
>>> Aborted (core dumped)
>>>
>>> This error can be resolved by setting x2apic=on in -cpu. In order to
>>> better help users deal with this scenario, add the error hint to
>>> instruct users on how to enable the x2apic feature.
>>
>> Why not automatically set x2apic=on in this case instead?
> 
> The default CPU model is qemu64 without x2APIC. I think it might be
> necessary to update the version to add x2APIC in qemu64, and I'd like to
> look into it again for any other potential issues.
> 
> In addition to adding x2APIC directly to the qemu64, this hint can also
> help some users who want a large number of vCPUs based on other older
> CPU models. Though, it's not very common but this hint would be helpful.
> 
>>> Then, the error
>>> report becomes the following:
>>>
>>> Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:448:
>>> qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
>>> Try x2apic=on in -cpu.
>>> Aborted (core dumped)
>>>
>>> Note since @errp is &error_abort, error_append_hint() can't be applied
>>> on @errp. And in order to separate the exact error message from the
>>> (perhaps effectively) hint, adding a hint via error_append_hint() is
>>> also necessary. Therefore, introduce @local_error in
>>> apic_common_set_id() to handle both the error message and the error
>>> hint.
>>>
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>    hw/intc/apic_common.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks!
> 
> 


