Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B57CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 10:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGax1-0003QC-Rs; Wed, 05 Nov 2025 05:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vGax0-0003Pt-Ag
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:41:14 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vGawy-0005PD-PI
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762339272; x=1793875272;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MtaTT7G+w232s+YcuGdOjHmBECOjrYSrE1Pg/WoVVeo=;
 b=f1JQdYRJwRECM18oPkhXBm4o5l34VRDwKGjr7LUnUzquAZ1IT8ZdQh/f
 QMdNYoXJMf+Es/DbY+5OcK+zYScST820YYDUpWU7fIqpm0Ff+Msl6WZoO
 +kf2JJn4KPev1EOJqbN3L23fZ1L4iRpakLg1cc+Ajf8/eA8jzmhGLwvDS
 8ayL2LfGnIwAKLMvTs+u0ZDER06YSoMUE7Cyzvh2rFBF/tYrvYee85ePI
 3XpefuK2Z0qdt1gfT4VjFTQxsUhY8SuB0/fTw45vGz1h28rC49LK0Ihwd
 Rt7FDu558GU37dPJWWDWjZYgQR6xZReI7CUFjGRiU2idhO6KNrklxLTEi A==;
X-CSE-ConnectionGUID: Xl2JMOwWQHefUZWp9YS+ng==
X-CSE-MsgGUID: q2d77AlaQHCw0ZDwSaNsHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64356587"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64356587"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 02:41:11 -0800
X-CSE-ConnectionGUID: IJ+dJT4rRLCDWLd4YAd2SA==
X-CSE-MsgGUID: sAX2I0HSQcmsiZrk85Tqtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="187581204"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.49])
 ([10.124.240.49])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 02:41:06 -0800
Message-ID: <bd53ca4a-7415-48b2-b1da-373957cd4025@intel.com>
Date: Wed, 5 Nov 2025 18:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/20] i386/machine: Add vmstate for cet-ss and cet-ibt
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-16-zhao1.liu@intel.com>
 <445462e9-22e5-4e8b-999e-7be468731752@intel.com> <aQOMjlHnjgwdYfFX@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aQOMjlHnjgwdYfFX@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.773, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/31/2025 12:04 AM, Zhao Liu wrote:
>>> +static const VMStateDescription vmstate_cet = {
>>> +    .name = "cpu/cet",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = cet_needed,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_UINT64(env.u_cet, X86CPU),
>>> +        VMSTATE_UINT64(env.s_cet, X86CPU),
>>> +        VMSTATE_END_OF_LIST()
>>> +    },
>>> +    .subsections = (const VMStateDescription * const []) {
>>> +        &vmstate_ss,
> here:       ^^^^^^^^^^^^^
> 
>>> +        NULL,
>>> +    },
>>> +};
>>> +
>>>    const VMStateDescription vmstate_x86_cpu = {
>>>        .name = "cpu",
>>>        .version_id = 12,
>>> @@ -1817,6 +1869,7 @@ const VMStateDescription vmstate_x86_cpu = {
>>>    #endif
>>>            &vmstate_arch_lbr,
>>>            &vmstate_triple_fault,
>>> +        &vmstate_cet,
>> missing &vmstate_ss
> I made vmstate_ss as a subsection in vmstate_cet

Sorry for missing it.

btw, can we rename vmstate_ss to vmstate_cet_ss?

