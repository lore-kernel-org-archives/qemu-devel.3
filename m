Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD91C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rni1G-000123-SX; Fri, 22 Mar 2024 12:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rni0x-00010m-6s
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:45:08 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rni0u-0006LP-JZ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711125905; x=1742661905;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5T3vRFLrxDs6mfXZV+eFAe6MkvHfg6ceUvaIIyI1lYQ=;
 b=MDG+1vZF9GdcNkGihNgM/lKHi0JUQew3XJs2QLmhjik1QWs8aCd7xHD1
 j5NlJY7f4cAhTWqtzXz4WzU8CtZI4Py8rhMqIRumzZKRo6Cj8OcIM2prI
 L1KFLVH3xlTW5Clpkh/I/I0pX/u8yiDHMO4iDLjQ9XigaLTepCI3D6b5Y
 OUOXzlRIOqzT/MvqMXx8jXybyMbIFhUF0oZXjAhhLuXskxmq1MfPiHhYk
 6XTIBJ0o7tRORklO7fxiHoXOJFdjGoceBMxEsLla74uTgKNFJc9vFgyHM
 EuW1oGFTQ4redwoMK8CEJZ59uTIcJkPrK7ND0qq3izzMjs37cRSmSodH2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6013228"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6013228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 09:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; d="scan'208";a="46091921"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 09:45:01 -0700
Message-ID: <c08f6cea-0035-416c-8b96-5ac547b2af09@intel.com>
Date: Sat, 23 Mar 2024 00:44:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] KVM: track whether guest state is encrypted
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-4-pbonzini@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240319140000.1014247-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/19/2024 9:59 PM, Paolo Bonzini wrote:
> So far, KVM has allowed KVM_GET/SET_* ioctls to execute even if the
> guest state is encrypted, in which case they do nothing.  For the new
> API using VM types, instead, the ioctls will fail which is a safer and
> more robust approach.
> 
> The new API will be the only one available for SEV-SNP and TDX, but it
> is also usable for SEV and SEV-ES.  In preparation for that, require
> architecture-specific KVM code to communicate the point at which guest
> state is protected (which must be after kvm_cpu_synchronize_post_init(),
> though that might change in the future in order to suppor migration).
>  From that point, skip reading registers so that cpu->vcpu_dirty is
> never true: if it ever becomes true, kvm_arch_put_registers() will
> fail miserably.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


