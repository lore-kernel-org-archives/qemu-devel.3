Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D29E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3lX-0002wn-It; Tue, 07 Jan 2025 02:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV3lO-0002tf-UU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:12:31 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tV3lI-0006Rm-O8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736233944; x=1767769944;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/ck5PjpSuPEiIJZgIZRQfk6ou0VR5i78Pp/rPHABhKA=;
 b=cYEmjwA3EqM2iAzv3ZMb02CEaM1MJxbPkWCQksNJadyvK1Oc31LyOsjN
 4aiI+ZtFWZagY78S8JKFNNiUBGlA/nPHrX+Z1Q42x08hNmfbzHaj30JqG
 pT5lnl7kr53XDDg0FUS2BK8n1XHD4ZeRBC+SsIBJO3qEUXqGmCNRccjsQ
 K+nXXh9eqZULzBoqwlhZI0ma5bHDR1ya+lAHEXw+LJ0ysBqJNi/u/T189
 L9AMWHKMxco5g8aqIxEIr3jgvabRbzej8cxJOq0P9TvQdNy9Kl2GDMgq5
 lcyFLsyCLERu5gl3pyfX0lA5u0RiXndD1TSvknSDJ+4fREvwpUzImv2W4 Q==;
X-CSE-ConnectionGUID: yyW7+7IVQgyRHH7Zunt1Dw==
X-CSE-MsgGUID: vnhF6DLvTISp7X8rdhILRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46982002"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; d="scan'208";a="46982002"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:12:21 -0800
X-CSE-ConnectionGUID: WHZRm96zQpivs03NZqVMzQ==
X-CSE-MsgGUID: QzQ5rnvVRlyGELc/hFBpcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="107735702"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:12:19 -0800
Message-ID: <49b6cf3f-21a2-4e2b-b2cf-a57e76c9b89e@intel.com>
Date: Tue, 7 Jan 2025 15:12:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] i386/topology: Introduce helpers for various
 topology info of different level
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-6-xiaoyao.li@intel.com> <Z25cmxkmzQ9cXash@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z25cmxkmzQ9cXash@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/27/2024 3:51 PM, Zhao Liu wrote:
>> +static inline unsigned x86_module_per_pkg(X86CPUTopoInfo *topo_info)
>> +{
>> +    return topo_info->modules_per_die * topo_info->dies_per_pkg;
>> +}
>> +
>> +static inline unsigned x86_cores_per_pkg(X86CPUTopoInfo *topo_info)
>> +{
>> +    return topo_info->cores_per_module * x86_module_per_pkg(topo_info);
>> +}
> 
> The above helpers can be ignored this time until someone wants them...

x86_cores_per_pkg() will be used in next patch (06).

So the only one without a real user is x86_module_per_pkg(). We can drop 
it, and implement x86_cores_per_pkg() as

	return  topo_info->cores_per_module * topo_info->modules_per_die
		* topo_info->dies_per_pkg;

However, I don't see no real user as a big concern and I think current 
implementation looks more consistent and complete.

>> +static inline unsigned x86_threads_per_pkg(X86CPUTopoInfo *topo_info)
>> +{
>> +    return topo_info->threads_per_core * x86_cores_per_pkg(topo_info);
>> +}
> 
> ...then this can be x86_threads_per_die(topo_info) * topo_info->dies_per_package
> 
>> +static inline unsigned x86_threads_per_module(X86CPUTopoInfo *topo_info)
>> +{
>> +    return topo_info->threads_per_core * topo_info->cores_per_module;
>> +}
>> +
>> +static inline unsigned x86_threads_per_die(X86CPUTopoInfo *topo_info)
>> +{
>> +    return x86_threads_per_module(topo_info) * topo_info->modules_per_die;
>> +}
>> +
>>


