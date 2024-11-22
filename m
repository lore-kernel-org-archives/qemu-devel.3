Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AA7E65D10
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 02:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEJbX-0006XZ-KP; Thu, 21 Nov 2024 21:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tEJb9-0006Wt-Ki
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:40:46 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tEJb4-0002nE-NS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732243239; x=1763779239;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aJHLSM9OD2qtKnNfR3xlGElizbHqIvSOjb3+ZTo++js=;
 b=KhWdbbtKC7o1VuZk/41+G4fD9Na6T4MvRqSoS9z4MaxDXppZcK2Sbgk/
 9WFPPNUDgV3b2FirPQ4LpJdCQLXJVSH/wSIS4R2ls9Jpzj+8ChR2gfCqi
 zW/sN5rdO0ZHu4QbyWOE7KcW8A1xuEeDMsm69gpn0ztEPEGLrbiQB1Moi
 pMG/FSEnfrCarMHYyke2Rshvr6iBRReOAFSF7EOiysmAPbsdGYqRSqybU
 bJIuvX1KyVBzlBu9stzXIyHRMAHiqX1SQXAd+z8jltiF+EmAdmejOphXA
 TN0kDmpQ5sGDvePkKWE6WLRXBeWDBoQk+UlNL4SyxZOETi7lFupBIlBsp Q==;
X-CSE-ConnectionGUID: pOQJedOBSOG7Pb7tVUAvzA==
X-CSE-MsgGUID: 5uWGw+lcTratO8hxnEqLXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43780562"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; d="scan'208";a="43780562"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2024 18:40:34 -0800
X-CSE-ConnectionGUID: WSQXXcSDSh+UjycY+ILa8Q==
X-CSE-MsgGUID: EwGexZaDT7mMFai4j6D4NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="95486860"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2024 18:40:30 -0800
Message-ID: <db7f2f59-6cfe-4e90-ae63-1faeb870726b@intel.com>
Date: Fri, 22 Nov 2024 10:40:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
 <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
 <af349a3a-8a15-4263-9a93-180320daaca7@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <af349a3a-8a15-4263-9a93-180320daaca7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.669, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/22/2024 2:52 AM, Paolo Bonzini wrote:
> On 11/21/24 17:24, Xiaoyao Li wrote:
>>> Could it go into cpu_common_initfn()?
>>
>> It can, I think.
>>
>> I'll move them into cpu_common_initfn() in v2 to avoid touching all 
>> the ARCHes.
> 
> It does look better than the alternative of duplicating code.
> 
> On the other hand qemu_init_vcpu is already duplicated and I'm not sure 
> I like relying on qdev_get_machine() inside the instance_init function...

I had the same concern.

But it seems all the ARCHes should create MACHINE before VCPUs. So it 
seems OK to qdev_get_machine() inside the instance_init function. But 
I'm not sure if there is any case to create VCPU standalone.

I think we can check if qdev_get_machine() gets a valid result. If not, 
fall back to assign nr_cores and nr_threads to 1.

Anyway, please let me know your preference, this series or a v2 to 
implement it inside cpu_common_initfn().

> Paolo
> 


