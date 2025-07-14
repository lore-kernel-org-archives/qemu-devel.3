Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630CAC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEiq-00040g-H3; Mon, 14 Jul 2025 04:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubELV-0003jF-QB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:15:34 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubELS-00058b-GD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752480931; x=1784016931;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CkrOH5WmIorEhedu7EvGplbP5qCcCDENvb6dbjIFTDw=;
 b=FOwgOr/NseDvggNipAPb9+JtETxbqbpMsKKxKgAAWppiZv9UyYbyXPpb
 bz0yPoYb266fe2kksK3/BiLg/VDWIw14ih6vcOuKN1UWGDyLqbhHPHndl
 +Hd/6KxCd4dLC13xcz59jtVKlouo5LE8Q34KC1VYMlE4i4lcPSiTIBHEX
 OiMGaWDT9V/jMeC+Z8jA/WNBMNcZNITzDd7f3uQUYdwRO+d/YKA/3Ekxm
 xrZ0KauwdmZRB9oqGeGhY/d2b/xOUhDoKwaNgdgrlRRrG/8SFvGj47/VW
 tdu2Nqx3F/D7VM9fqn346IemUHXDH4QaYuO7CtBeH3zBCMFq+YwRRFCSB g==;
X-CSE-ConnectionGUID: Dj69+ZAjQu+kt4ROAhMmkQ==
X-CSE-MsgGUID: pSB8C1+1S0qxktFs5gc13Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54634991"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="54634991"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 01:15:25 -0700
X-CSE-ConnectionGUID: yNxGCtcVQAe76cP43cZfXQ==
X-CSE-MsgGUID: GJcd3eHwRF6inqzJq3w+WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="194077557"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 01:15:22 -0700
Message-ID: <d76d8316-cb7a-444c-bcac-ea134ce07bf1@intel.com>
Date: Mon, 14 Jul 2025 16:15:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000
 leaf as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, Tao Su <tao1.su@linux.intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-2-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250714080859.1960104-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/14/2025 4:08 PM, Zhao Liu wrote:
> Per SDM,
> 
> 80000000H EAX Maximum Input Value for Extended Function CPUID Information.
>            EBX Reserved.
>            ECX Reserved.
>            EDX Reserved.
> 
> EBX/ECX/EDX in CPUID 0x80000000 leaf are reserved. Intel and Zhaoxin are
> already using 0x0 leaf to encode vendor.
> 
> Reviewed-by: Tao Su <tao1.su@linux.intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


