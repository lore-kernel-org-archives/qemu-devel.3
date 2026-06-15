Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8BDCD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2OD-0004pt-AM; Mon, 15 Jun 2026 04:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wZ2O0-0004of-Bm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:09:38 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wZ2Nx-0001Aj-Vc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781510974; x=1813046974;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lWe4ixoATaObjyfJnQ40ef2kOcWKyPLPadIVjRIjKlY=;
 b=eopHVrQCSHbN5vNZzDv25Q+rQpm7flfs/VchlLqimMuItDlKTrOE4eNm
 dhQ5dTPWmqeRMFeplCGlqmczj0L82ZQXldR0ZoG3VEiWyqpz0yIcV/Iil
 COV1+ONotX7sHTBOCllZvRhcK7Jt6GbXmRZEE/Ftmye1A6m3iso6VAMiJ
 KhTs7Kufw6P70rZdAS4JWA+qqN08LZwpCiEDWwATQhSlVf38FgI/EfYf1
 6PF3Nzcjyd6SJRH512f7YNO2Xm2g4ow09rcgR0EPEePB64WAbRDNZpXE5
 kyUK7eK+NJBOzq1SaobKK4LubRnW4nRUd/oqg8TYcv4Y0AqPqvKYZea9j w==;
X-CSE-ConnectionGUID: o8mGG9OBQB6te3wdAOjkPg==
X-CSE-MsgGUID: 97Xd9/A2SNeEW9Y9Uxihpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104916274"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="104916274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:09:24 -0700
X-CSE-ConnectionGUID: hRaP84XNS2230iR3FnhP9Q==
X-CSE-MsgGUID: BDZQ8l5RReW9+WYHIpZrSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="271099842"
Received: from unknown (HELO [10.239.158.65]) ([10.239.158.65])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:09:23 -0700
Message-ID: <d876e145-1c3d-4e64-b312-c306ca6c4a95@intel.com>
Date: Mon, 15 Jun 2026 16:09:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] i386/tdx: TDX cleanup and CPUID fixes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260512082108.621596-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260512082108.621596-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Paolo,

Could you please take a look at it?

I hope we can get them into QEMU 11.1

On 5/12/2026 4:21 PM, Xiaoyao Li wrote:
> Patch 1 is the resend of a cleanup patch that was missed by the
> community[1].
> 
> Patch 2 fixes the warnings when booting TDX guest on the platforms
> (e.g., DMR) that support AMX alias bits.
> 
> Patch 3 allows AVX10 to be exposed/enabled for TDX guest.
> 
> [1] https://lore.kernel.org/qemu-devel/20250710141512.170302-1-xiaoyao.li@intel.com/
> 
> Xiaoyao Li (3):
>    i386/tdx: Use .has_gpa field to check if the gpa is valid
>    i386/tdx: Make AMX alias bits supported
>    i386/tdx: Add CPUID_24_0_EBX_AVX10_VL_MASK as supported
> 
>   system/runstate.c     |  2 +-
>   target/i386/kvm/tdx.c | 28 +++++++++++++++++++++-------
>   2 files changed, 22 insertions(+), 8 deletions(-)
> 


