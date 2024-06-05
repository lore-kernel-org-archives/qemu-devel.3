Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C59BC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvS8-0002O4-Kc; Wed, 05 Jun 2024 14:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEvRw-0002ML-PL; Wed, 05 Jun 2024 14:33:28 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEvRu-00056L-B5; Wed, 05 Jun 2024 14:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717612406; x=1749148406;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cWgvgp+a3aqqLD5emQ3+cindb2Y7iuQEEwqEW6VqqE8=;
 b=CB5ADiAjNVUgZUdqgwZSSSibcVrzoUKg/mXKYmSEqOpJ5Vt1fwQmgwnB
 W1ZEPmy57h8aAjjgJ5PYptJyJfSSAK5i2ESsC1ohrCf5wjBw5Dsnuyj7Q
 Q+qfhPiB+T/x7QRwfz+0ExDZV134w2SkZIZt+LjLigFmU43gi+COvk+z5
 +3ZMwJL0YoIRJAK5PhpF1cmpiXM21uqUNi1h3Y5HSmmH/g/59nkV+hMFd
 zX1pWfs+TwaDGB5/AT2EEpZQAiwASMXlAaNYWj2R8x6rEISpizuibQYQs
 E3BC0uVU9aZ132gWqCMgs22Kqk2ivaHgbDhGPJwb68t/RplzZY5/4TvLk w==;
X-CSE-ConnectionGUID: JlLMMRMUTP+poCnFWQODog==
X-CSE-MsgGUID: ikGVgyPOQoaH5npjMhIwjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14363986"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; d="scan'208";a="14363986"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 11:33:23 -0700
X-CSE-ConnectionGUID: tlg/Hyk9Qe2FJLHFP442RA==
X-CSE-MsgGUID: czfL7xH+Sb6U4W+aE7IUCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; d="scan'208";a="68834422"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.59]) ([10.24.10.59])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 11:33:19 -0700
Message-ID: <41133609-3eeb-4c4b-bd43-002381879699@intel.com>
Date: Wed, 5 Jun 2024 11:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/2] improve -overcommit cpu-pm=on|off
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org, seanjc@google.com, zhao1.liu@intel.com
References: <20240604000222.75065-1-zide.chen@intel.com>
 <20240605154908.54c65d26@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240605154908.54c65d26@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/5/2024 6:49 AM, Igor Mammedov wrote:
> On Mon,  3 Jun 2024 17:02:20 -0700
> Zide Chen <zide.chen@intel.com> wrote:
> 
>> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
>> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
>> guest and executing MWAIT/MONITOR on the guest triggers #UD.
>>
>> Typically #UD takes priority over VM-Exit interception checks and
>> KVM doesn't emulate MONITOR/MWAIT. This causes the guest fail to
>> boot.
>>
>> V2:
>> - [PATCH 1]: took Thomas' suggestion for more generic fix
>> - [PATCH 2/3]: no changes
>>
>> V3:
>> - dropped [PATCH 1/3]. Took the simpler approach not to re-order
>>   cpu_exec_realizefn() call.
>> - changed patch title in [PATCH V3 1/2]
>> - don't set CPUID_EXT_MONITOR in kvm_cpu_realizefn() 
> 
> on top of above we should make make
>   -overcommit cpu-pm=on
> to error out if KVM_X86_DISABLE_EXITS_MWAIT is not supported/failed
> 
> if we don't do this user gets false assumption that cpu-pm=on
> works as expected, and instead of effective CPU usage/IPI delivery
> all they get is a storm of mwait exits.
> 

Agree. But seems it's quite complicated. Please refer to the comments on
[PATCH V2 2/3].

We may remove the "-overcommit cpu-pm", and similar to notify-vmexit,
add individual -accel options for flexibility and better cpu-pm control.
But will be over complicated?

KVM_X86_DISABLE_EXITS_MWAIT
KVM_X86_DISABLE_EXITS_HLT
KVM_X86_DISABLE_EXITS_PAUSE
KVM_X86_DISABLE_EXITS_CSTATE


>>
>> Zide Chen (2):
>>   vl: Allow multiple -overcommit commands
>>   target/i386: Advertise MWAIT iff host supports
>>
>>  system/vl.c               |  4 ++--
>>  target/i386/host-cpu.c    | 12 ------------
>>  target/i386/kvm/kvm-cpu.c | 11 +++++++++--
>>  3 files changed, 11 insertions(+), 16 deletions(-)
>>
> 

