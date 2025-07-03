Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F47C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 06:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDXl-0003AG-0m; Thu, 03 Jul 2025 02:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXDXg-00037m-65
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:35:32 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXDXY-0008Tp-Cw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751524524; x=1783060524;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=OdJzAna8v+rUfA43nyyDrr5qCU2flgEqubUC0YWkb/8=;
 b=BGHxYvMm1IHYZWIhUmFMr9T0ve92M59Ef6DF4Mf/xDxAEJ+fayciJmuk
 zDpWYvpgxfMwebU9OgR7HpNApjAvH+QUq9qNTOv+Yd2wHp8dcbIJhBqDZ
 TYaS/7ZJkK5KrdGRuG0ZGkMGRXUEC7fgMY3Muzj/qGasMn5OIX1qcEgAt
 uQDS21kIUQwVj806d+Yx/AaeeOo3RvFfOELCC7PrjH/jA0TcOj+nyRFSl
 KdjUHsvDK91rdkZmiAef/nIXH1cVNVT9sJVj5LTo+up+HeufegNWmLfLO
 WPUlCFiE6ZE1yvFWS6pnUwXK56K33g1OOpUotsbm2WY0FdigUPLzVQB6e Q==;
X-CSE-ConnectionGUID: 8FwwVsc3SbaRFNuLHGpcdA==
X-CSE-MsgGUID: opH0XXFkSEuIFtR1suS/CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53950467"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53950467"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 23:35:20 -0700
X-CSE-ConnectionGUID: ilCt6u6gQhqoSkSMYIkYkA==
X-CSE-MsgGUID: +Y0GrvsNTOqF1Mflp+f1nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158560167"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 23:35:15 -0700
Message-ID: <8bf6f5d9-a669-4b62-a808-a77133c9ad67@linux.intel.com>
Date: Thu, 3 Jul 2025 14:35:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] i386/cpu: Present same cache model in CPUID 0x2 &
 0x4
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Alexander Graf <agraf@csgraf.de>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-5-zhao1.liu@intel.com>
 <bb437e9d-c0af-4fb6-9c47-d495781ba29d@linux.intel.com>
Content-Language: en-US
In-Reply-To: <bb437e9d-c0af-4fb6-9c47-d495781ba29d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 7/3/2025 12:14 PM, Mi, Dapeng wrote:
> On 6/20/2025 5:27 PM, Zhao Liu wrote:
>> For a long time, the default cache models used in CPUID 0x2 and
>> 0x4 were inconsistent and had a FIXME note from Eduardo at commit
>> 5e891bf8fd50 ("target-i386: Use #defines instead of magic numbers for
>> CPUID cache info"):
>>
>> "/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */".
>>
>> This difference is wrong, in principle, both 0x2 and 0x4 are used for
>> Intel's cache description. 0x2 leaf is used for ancient machines while
>> 0x4 leaf is a subsequent addition, and both should be based on the same
>> cache model. Furthermore, on real hardware, 0x4 leaf should be used in
>> preference to 0x2 when it is available.
>>
>> Revisiting the git history, that difference occurred much earlier.
>>
>> Current legacy_l2_cache_cpuid2 (hardcode: "0x2c307d"), which is used for
>> CPUID 0x2 leaf, is introduced in commit d8134d91d9b7 ("Intel cache info,
>> by Filip Navara."). Its commit message didn't said anything, but its
>> patch [1] mentioned the cache model chosen is "closest to the ones
>> reported in the AMD registers". Now it is not possible to check which
>> AMD generation this cache model is based on (unfortunately, AMD does not
>> use 0x2 leaf), but at least it is close to the Pentium 4.
>>
>> In fact, the patch description of commit d8134d91d9b7 is also a bit
>> wrong, the original cache model in leaf 2 is from Pentium Pro, and its
>> cache descriptor had specified the cache line size ad 32 byte by default,
>> while the updated cache model in commit d8134d91d9b7 has 64 byte line
>> size. But after so many years, such judgments are no longer meaningful.
>>
>> On the other hand, for legacy_l2_cache, which is used in CPUID 0x4 leaf,
>> is based on Intel Core Duo (patch [2]) and Core2 Duo (commit e737b32a3688
>> ("Core 2 Duo specification (Alexander Graf).")
>>
>> The patches of Core Duo and Core 2 Duo add the cache model for CPUID
>> 0x4, but did not update CPUID 0x2 encoding. This is the reason that
>> Intel Guests use two cache models in 0x2 and 0x4 all the time.
>>
>> Of course, while no Core Duo or Core 2 Duo machines have been found for
>> double checking, this still makes no sense to encode different cache
>> models on a single machine.
>>
>> Referring to the SDM and the real hardware available, 0x2 leaf can be
>> directly encoded 0xFF to instruct software to go to 0x4 leaf to get the
>> cache information, when 0x4 is available.
>>
>> Therefore, it's time to clean up Intel's default cache models. As the
>> first step, add "x-consistent-cache" compat option to allow newer
>> machines (v10.1 and newer) to have the consistent cache model in CPUID
>> 0x2 and 0x4 leaves.
>>
>> This doesn't affect the CPU models with CPUID level < 4 ("486",
>> "pentium", "pentium2" and "pentium3"), because they have already had the
>> special default cache model - legacy_intel_cpuid2_cache_info.
>>
>> [1]: https://lore.kernel.org/qemu-devel/5b31733c0709081227w3e5f1036odbc649edfdc8c79b@mail.gmail.com/
>> [2]: https://lore.kernel.org/qemu-devel/478B65C8.2080602@csgraf.de/
>>
>> Cc: Alexander Graf <agraf@csgraf.de>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>  hw/i386/pc.c      | 4 +++-
>>  target/i386/cpu.c | 7 ++++++-
>>  target/i386/cpu.h | 7 +++++++
>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index b2116335752d..ad2d6495ebde 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -81,7 +81,9 @@
>>      { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>>      { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>>  
>> -GlobalProperty pc_compat_10_0[] = {};
>> +GlobalProperty pc_compat_10_0[] = {
>> +    { TYPE_X86_CPU, "x-consistent-cache", "false" },
>> +};
>>  const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
>>  
>>  GlobalProperty pc_compat_9_2[] = {};
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 0a2c32214cc3..2f895bf13523 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -8931,7 +8931,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>          /* Build legacy cache information */
>>          env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
>>          env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
>> -        env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
>> +        if (!cpu->consistent_cache) {
>> +            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
>> +        } else {
>> +            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache;
>> +        }
> This would encode the valid L1 and L3 cache descriptors and "0xff"
> descriptor into CPUID leaf 0x2 when there is CPUID leaf 0x4. It seems a
> little bit of ambiguous to mix "0xff" descriptor with other valid
> descriptors and it isn't identical with real HW. Do we consider to make it
> identical with real HW? Thanks.

Just found the subsequent patch 05/16 has addressed this concern. Please
ignore this comment.


>
>
>>          env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
>>  
>>          env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
>> @@ -9457,6 +9461,7 @@ static const Property x86_cpu_properties[] = {
>>       * own cache information (see x86_cpu_load_def()).
>>       */
>>      DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
>> +    DEFINE_PROP_BOOL("x-consistent-cache", X86CPU, consistent_cache, true),
>>      DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
>>      DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
>>  
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 5910dcf74d42..3c7e59ffb12a 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -2259,6 +2259,13 @@ struct ArchCPU {
>>       */
>>      bool legacy_cache;
>>  
>> +    /*
>> +     * Compatibility bits for old machine types.
>> +     * If true, use the same cache model in CPUID leaf 0x2
>> +     * and 0x4.
>> +     */
>> +    bool consistent_cache;
>> +
>>      /* Compatibility bits for old machine types.
>>       * If true decode the CPUID Function 0x8000001E_ECX to support multiple
>>       * nodes per processor

