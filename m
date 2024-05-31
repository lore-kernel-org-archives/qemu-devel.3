Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C58C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5pS-0000Oy-7W; Fri, 31 May 2024 13:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sD5pQ-0000Ng-IN; Fri, 31 May 2024 13:14:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sD5pN-0002Lm-QZ; Fri, 31 May 2024 13:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717175646; x=1748711646;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fU0HQKU2onaxKI9dL6R8XzwuVZDu00A+kcrXJCOW8os=;
 b=CfCiuDjQPPTlx8LFwLJnF7sWaPn6CzGIBKKyHq93zQoVUkvyUsnjRkJE
 2WisrPkcaZkRlIGSBj5EV55v2Qj7I8m+y5WPYcT0qnY3PYe3If3eon9PX
 Xf2kSgbEDTPIKIEcMqhNtoHlHLMcNGNuY5GbOlHzM82gSjE3JFL4HQo/D
 vib+8PNScEeJkEZaNag+PjnWMHB6BWrh66KZc5KgROyn26b8Q/TANKsB6
 82M+BWq4TVkHBJaezDGOGs8GKR3ar74ijA3nmh2i8Bmp3JneTLYCgYZHQ
 R/TLPVh1ebJ+IXDBXKx72MTcjtNs/vNlt0QwQ+bQJ4Sd77n2RolFoiqrB g==;
X-CSE-ConnectionGUID: XM4HAScgQfKzKfEn3ncMhg==
X-CSE-MsgGUID: LtSxy4BdR/eCujcyYtETZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13897088"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="13897088"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 10:13:49 -0700
X-CSE-ConnectionGUID: O5R0LggnScSwBhe+afEhKA==
X-CSE-MsgGUID: X/do9CGBTkOtxJXWQgvJLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="36215595"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.49]) ([10.24.10.49])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 10:13:48 -0700
Message-ID: <04d3dfd8-93d2-493d-82d1-8fbcad6ecd22@intel.com>
Date: Fri, 31 May 2024 10:13:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-3-zide.chen@intel.com> <ZlluoKXUF6ctecVt@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <ZlluoKXUF6ctecVt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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



On 5/30/2024 11:30 PM, Zhao Liu wrote:
> Hi Zide,
> 
> On Fri, May 24, 2024 at 01:00:16PM -0700, Zide Chen wrote:
>> Date: Fri, 24 May 2024 13:00:16 -0700
>> From: Zide Chen <zide.chen@intel.com>
>> Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
>>  x86_cpu_filter_features
>> X-Mailer: git-send-email 2.34.1
>>
>> cpu_exec_realizefn which calls the accel-specific realizefn may expand
>> features.  e.g., some accel-specific options may require extra features
>> to be enabled, and it's appropriate to expand these features in accel-
>> specific realizefn.
>>
>> One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.
>>
>> Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
>> that it won't expose features not supported by the host.
>>
>> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
>> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  target/i386/cpu.c         | 24 ++++++++++++------------
>>  target/i386/kvm/kvm-cpu.c |  1 -
>>  2 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index bc2dceb647fa..a1c1c785bd2f 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>          }
>>      }
>>  
>> +    /*
>> +     * note: the call to the framework needs to happen after feature expansion,
>> +     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
>> +     * These may be set by the accel-specific code,
>> +     * and the results are subsequently checked / assumed in this function.
>> +     */
>> +    cpu_exec_realizefn(cs, &local_err);
>> +    if (local_err != NULL) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>>      x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
> 
> For your case, which sets cpu-pm=on via overcommit, then
> x86_cpu_filter_features() will complain that mwait is not supported.
> 
> Such warning is not necessary, because the purpose of overcommit (from
> code) is only to support mwait when possible, not to commit to support
> mwait in Guest.
> 
> Additionally, I understand x86_cpu_filter_features() is primarily
> intended to filter features configured by the user, 

Yes, that's why this patches intends to let x86_cpu_filter_features()
filter out the MWAIT bit which is set from the overcommit option.

> and the changes of
> CPUID after x86_cpu_filter_features() should by default be regarded like
> "QEMU knows what it is doing".

Sure, we can add feature bits after x86_cpu_filter_features(), but I
think moving cpu_exec_realizefn() before x86_cpu_filter_features() is
more generic, and actually this is what QEMU did before commit 662175b91ff2.

- Less redundant code. Specifically, no need to call
x86_cpu_get_supported_feature_word() again.
- Potentially there could be other features could be added from the
accel-specific realizefn, kvm_cpu_realizefn() for example.  And these
features need to be checked against the host availability.

> 
> I feel adding a check for the CPUID mwait bit in host_cpu_realizefn()
> is enough, after all, this bit should be present if host supports mwait
> and enable_cpu_pm (in kvm_arch_get_supported_cpuid()).

Besides the above reasons, it seems to me expanding env->features in
host-cpu.c is confusing.

> Thanks,
> Zhao
> 

