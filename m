Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB111C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 04:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucGEP-0008Ho-0b; Thu, 17 Jul 2025 00:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucGE7-0008B8-Hw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 00:28:24 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucGE1-0007Ok-Dk
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 00:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752726485; x=1784262485;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=en8IHVTjfuu1p+XP6v9L/AgrHW2SdSgddmgwM6JUNOY=;
 b=HVFDRTVqWxwsyqbRgxE64rs+tsBuhDI+Ms0zh6SrU7brPEYSC9S+5A9j
 398Cdbg3ZycUbTef/FQ4+LhN5QznG/Gqqe3nAnbjjlV6wBwOuN5myyCQ1
 5jTV60fZC5g1pTNWoNVBxEarQds+wp03Sn7BpW6UdhEl42AsnXGHpzSDa
 AWzubrKs8IvSmvwkNopqIZwh9d5LbB/E5J4jq+5k9cqT4ud0iJe+PKtTr
 ECCSbHJp6i8BP9Ah+yVfbAc5GWZr3PBcwvVNkVu0be3+q/OJ5fldY0ON0
 jgzLHbOuq7A1wCbt/wbMIVa5am+STl8I3uju8ijPlla9mJUEEzd1SCjYh g==;
X-CSE-ConnectionGUID: yfib2oUzQ2GLuFR8v7UT0g==
X-CSE-MsgGUID: FjMQDMOoSzqIhi57Pk9x8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="57597295"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="57597295"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 21:28:00 -0700
X-CSE-ConnectionGUID: 7JScEx12QKSMM/f17RUq3Q==
X-CSE-MsgGUID: rBe1rjo+QwmpJ82Fj3dYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="157083344"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 21:27:59 -0700
Message-ID: <9f355c30-de53-4db4-9ef0-f3f8c0fc5960@intel.com>
Date: Thu, 17 Jul 2025 12:27:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for v10.1] i386/cpu: Move x86_ext_save_areas[]
 initialization to .instance_init
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Abeni <pabeni@redhat.com>
References: <20250717023933.2502109-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250717023933.2502109-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/17/2025 10:39 AM, Zhao Liu wrote:
> In x86_cpu_post_initfn(), the initialization of x86_ext_save_areas[]
> marks the unsupported xsave areas based on Host support.
> 
> This step must be done before accel_cpu_instance_init(), otherwise,
> KVM's assertion on host xsave support would fail:
> 
> qemu-system-x86_64: ../target/i386/kvm/kvm-cpu.c:149:
> kvm_cpu_xsave_init: Assertion `esa->size == eax' failed.
> 
> (on AMD EPYC 7302 16-Core Processor)
> 
> Move x86_ext_save_areas[] initialization to .instance_init and place it
> before accel_cpu_instance_init().
> 
> Fixes: commit 5f158abef44c ("target/i386: move accel_cpu_instance_init to .instance_init")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

