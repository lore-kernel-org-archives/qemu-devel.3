Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC5DC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWhZ-0006DJ-0O; Fri, 20 Jun 2025 04:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uSWhV-0006Cu-UR
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:02:17 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uSWhT-0004f4-2G
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750406535; x=1781942535;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gez4jc1Pqtj/19h5AmOqkWcjdHu1z/7Jm9X0HIrndD4=;
 b=RcueuZvNgEBMQq+GV5OOdh5CjcgF6EtxS+AQsityZBdeB9ZMrZvEbQuF
 HJnUmAfQijcWbwvrcoyEmI7CiaxDgxBOYvrU3yDyTtFrE7vOJ/zipnk7q
 tF/wg8jq9UdrB/Y0hHY+BcrKsltyEm8FG5vVLZkUMfeziMbh/1oeWYBwE
 iGbFtF/VMOfsrxGNgPQbtmd7rCdL4EhpBGlX9hxbjb0/fHbmnZbr1A1Vg
 YaoOsxb+EGrvrDJldjfpfTIYAF8xswS+Z7Rz7FDnODRwCu1Sfqaa3JwV/
 CVi4QBsJfghLjVIk3HXg+OVn2cWbT5YZzPVwHK2P++pO7w9Z6VLxVg6oU Q==;
X-CSE-ConnectionGUID: aGw88KcIT6GMXXZkM7eR7w==
X-CSE-MsgGUID: Von9EPoQSnqli/vVzy6gnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52806638"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="52806638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 01:02:09 -0700
X-CSE-ConnectionGUID: 98QcIBt1QcapZ9zprn+EhA==
X-CSE-MsgGUID: 37Rwabg9RZ+4/pRZ9GOClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="151145829"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 01:02:07 -0700
Message-ID: <c7489032-d1bc-4ce0-9509-fae53d0a8bd8@intel.com>
Date: Fri, 20 Jun 2025 16:02:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20250619203351.393786-1-pbonzini@redhat.com>
 <20250619203351.393786-4-pbonzini@redhat.com>
 <c60001b3-12d2-4261-8b6b-a7bfaf4e71ff@intel.com>
 <CABgObfYpkWDLtiJ3gAb8ouExON2q9BmB1NNMj6jyQ4Wh17rGKw@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfYpkWDLtiJ3gAb8ouExON2q9BmB1NNMj6jyQ4Wh17rGKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On 6/20/2025 3:47 PM, Paolo Bonzini wrote:
> On Fri, Jun 20, 2025 at 8:47 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>> +void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)
>>
>> The previous version of mine, defined the return type as int, because it
>> wants to stop the QEMU when it hits the failure of
>> address_space_read/write. However, this patch returns
>> TDG_VP_VMCALL_INVALID_OPERAND to TD guest for such cases.
>>
>> Shouldn't the failure of address_space_read/write be treated as QEMU
>> internal error?
> 
> The operands are provided by the guest, therefore I think it's an
> invalid operand error.

So address_space_read/write() itself won't fail when the address is 
good, e.g., a valid memory address?

If so, I'm OK with it.

> Paolo
> 


