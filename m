Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7921DCCF9EA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 04:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEKIz-0000BC-Sl; Thu, 30 Oct 2025 00:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vEKIv-0000Ai-AA
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 00:30:30 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vEKIf-0006Jr-Qt
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 00:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761798614; x=1793334614;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=u7PuITfx4IeFAa8s+tPsssN46kIRp4aS74VUU7N6W48=;
 b=T5/ZlM6/ezxEcZkUo2J/gn42aZ1fklWDPMJ78H+QlZt66yXwJ043/x+U
 5qpfTNuqKLiKUSZkc6JscTzO4dXhRvHMNE6V9Rod13x28NFTpQByoge3+
 LXTrIzaVBu4S58S9Il9E3yjtUH02fse/yUgAY3zxWZfhWC+AvRNTImunn
 EG61pnhOeN0LNEbPC45Z5b06XHGIiYmDGMFcepsJr1q4QM7xGNrpRcekw
 1qyu0uN0SXywR91i9rnPRpKbKvCpDrao/BCdDeYOa7Lr3v3WBYWrXU7IQ
 xU3VVBufuqYdezH9FWTvWXG4fk6vyXViwdLskCoElpCPUlJjWWAgPG2Mv A==;
X-CSE-ConnectionGUID: 6YWXlYrLTuqnTxiJhFhXEw==
X-CSE-MsgGUID: ST04GxN0TzCgQDGOLKuN4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74531267"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="74531267"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 21:30:00 -0700
X-CSE-ConnectionGUID: iS6zRn3IRu2hIWFWiaXczw==
X-CSE-MsgGUID: 0JqmzqhuRoihmN4bC/MmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="191018131"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 21:29:57 -0700
Message-ID: <4806bc74-e4c2-4aa1-b003-e72895a11f11@intel.com>
Date: Thu, 30 Oct 2025 12:29:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] i386/cpu: Enable xsave support for CET states
To: Chao Gao <chao.gao@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Yang Weijiang <weijiang.yang@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-12-zhao1.liu@intel.com> <aQGe66NsIm7AglKb@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aQGe66NsIm7AglKb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.576, HK_RANDOM_FROM=0.999,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/29/2025 12:58 PM, Chao Gao wrote:
> On Fri, Oct 24, 2025 at 02:56:23PM +0800, Zhao Liu wrote:
>> From: Yang Weijiang <weijiang.yang@intel.com>
>>
>> Add CET_U/S bits in xstate area and report support in xstate
>> feature mask.
>> MSR_XSS[bit 11] corresponds to CET user mode states.
>> MSR_XSS[bit 12] corresponds to CET supervisor mode states.
>>
>> CET Shadow Stack(SHSTK) and Indirect Branch Tracking(IBT) features
>> are enumerated via CPUID.(EAX=07H,ECX=0H):ECX[7] and EDX[20]
>> respectively, two features share the same state bits in XSS, so
>> if either of the features is enabled, set CET_U and CET_S bits
>> together.
>>
>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
>> Co-developed-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> It just occurred to me that KVM_GET/SET_XSAVE don't save/restore supervisor
> states. Supervisor states need to be saved/restored via MSR APIs. So, there
> is no need to add supervisor states (including ARCH_LBR states) to
> x86_ext_save_areas[].

x86_ext_save_areas[] is not used only for xsave state, it's also used 
for the setup of xsave features, i.e., CPUID leaf 0xD.

And you did catch the missing part of this series, it lacks the 
save/restore of CET XSAVE state in 
x86_cpu_xsave_all_areas()/x86_cpu_xrstor_all_areas()

