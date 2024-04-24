Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CA3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzY7u-0004Mv-L1; Wed, 24 Apr 2024 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzY7p-0004Mb-55
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:37:09 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rzY7m-0001i8-Co
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713947826; x=1745483826;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=HwhNyYjts/KO/U4osuBsr+iWfhazRKyuTN+3Rsb4SgU=;
 b=D4ONc+oMpa69v3NXekn4xxseAdGQrkADzwtikhAZwrc8bUJedDoaA978
 3WFenhfdYUsKHP/tp/1udYEctlJ50hTpbW1qot53J8a8kFOr9knN5YPSu
 qbVZ1zT3WdBQuoWPzfOEqUQXCXMsx9xAwl5ofEX6QF74QUGV4KUj6FKSk
 MY8ukNO9AZOYEqJ4XLasEnXgzU+6TT6lsQucBTraMd6x/zZUMlswIdzeM
 GI/+i2cjMDzy15iVkQc9LW/W3eLupvc5czHHqXFvmvZgUmb1MVfFD/dMR
 HrCmbDjoacHYSV9CJt/fC2NXMFzZvDLCH+LIKKM75Xo+hFW8IZk+4lc/m g==;
X-CSE-ConnectionGUID: yaS9v3RORemKn/9CQCs2fg==
X-CSE-MsgGUID: EpCE1JGKS/y9QJs1qo0/LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27081046"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="27081046"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 01:37:04 -0700
X-CSE-ConnectionGUID: 33AUFDLhTeOFjZNBeH3W/g==
X-CSE-MsgGUID: cQ28aOZtSKK2Dk5ZxOTzfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="29120440"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 01:37:02 -0700
Message-ID: <2815f0f1-9e20-4985-849c-d74c6cdc94ae@intel.com>
Date: Wed, 24 Apr 2024 16:36:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 43/63] target/i386: Implement mc->kvm_type() to get VM type
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-44-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240423150951.41600-44-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/23/2024 11:09 PM, Paolo Bonzini wrote:
> +
> +/**
> + * x86_confidential_guest_kvm_type:
> + *
> + * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.

the comment needs to be updated:

Calls #X86ConfidentialGuestClass.kvm_type() callback

> + */
> +static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
> +{
> +    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
> +
> +    if (klass->kvm_type) {
> +        return klass->kvm_type(cg);
> +    } else {
> +        return 0;
> +    }
> +}


