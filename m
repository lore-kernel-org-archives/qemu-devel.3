Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED08C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 08:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwebA-0003Gi-JX; Tue, 16 Apr 2024 04:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rweb7-0003GK-Te
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:55:25 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rweb2-0003Lz-3K
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 04:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713257720; x=1744793720;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JNmyC1gaMXRjSeOW03drSIWO0UeKKffJRrs68BBM2K0=;
 b=GjRtCLROqIhu79PxRbps1avyQ3oNoG2pOQzNWmumaPaxZijqkmgk8H8w
 4rnijp/Z3n7zKKWBtSF1Bw7Pj+Wa//B0CZ+628fAQPkIToVG9ZOovrGkc
 JUYwWWw4iRSZx6NgleIqs0XxyZErLx94flEi5U2GQaLhSyLubvDriDeVw
 iodpqYOrJflMD1nLt6dfrfPka/Y9/xcF473ccndSVpfxNV/da9806FWfP
 R522y4OyMpXK4VI2BDO5AfzspYONRQkzF6h4/RKRSQfFN4Oi35SCIx1W/
 BbhgTnjEz+e66/NSADtkh63P9n92mk4JQ2nFijx1KDK6/s5x6j5cbgqgZ A==;
X-CSE-ConnectionGUID: cJBHO7+FTPmNu/LnNGWahg==
X-CSE-MsgGUID: VNH8gUAATce+OaM8Dr9yBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8793406"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8793406"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 01:55:16 -0700
X-CSE-ConnectionGUID: SGWtP5HzRpW7C+Gccm07GA==
X-CSE-MsgGUID: KzWTuc6RQuGNdzf/H5sfpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="26848349"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 01:55:10 -0700
Message-ID: <74b0fe93-fd73-4443-b8c6-9a535891948a@intel.com>
Date: Tue, 16 Apr 2024 16:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/65] i386/tdx: Disable pmu for TD guest
To: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata <isaku.yamahata@gmail.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-29-xiaoyao.li@intel.com>
 <b89211ee-6ac8-4efe-a9e0-16ae3bec4127@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <b89211ee-6ac8-4efe-a9e0-16ae3bec4127@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/16/2024 4:32 PM, Chenyi Qiang wrote:
> 
> 
> On 2/29/2024 2:36 PM, Xiaoyao Li wrote:
>> Current KVM doesn't support PMU for TD guest. It returns error if TD is
>> created with PMU bit being set in attributes.
>>
>> Disable PMU for TD guest on QEMU side.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/kvm/tdx.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 262e86fd2c67..1c12cda002b8 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -496,6 +496,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>>       int r = 0;
>>   
>> +    object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
> 
> Is it necessary to output some prompt if the user wants to enable pmu by
> "-cpu host,pmu=on"? As in patch 27, it mentions PMU is configured by
> x86cpu->enable_pmu, but PMU is actually not support in this series and
> will be disabled silently.

We do this in QEMU is mainly for KVM, because KVM will fail to init TD 
if ATTRIBUTE.PERFMON is set.

It's expected that KVM reports PERFMON in attributes.fixed0 when KVM 
cannot provide support of it. Then QEMU will print error message 
automatically when validate the attributes.

For QEMU part, next version is going to set the default value of "pmu" 
to false in kvm_cpu_max_instance_init(), so that "-cpu host" will not 
enable pmu for TDX VMs by default.

I suppose both the KVM and QEMU change will show up in the next version.

>> +
>>       QEMU_LOCK_GUARD(&tdx_guest->lock);
>>       if (tdx_guest->initialized) {
>>           return r;


