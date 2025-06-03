Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F7C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 16:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMUFe-0000vi-Cx; Tue, 03 Jun 2025 12:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMUFb-0000ut-D6
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:12:31 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMUFW-0004hI-Oc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748967146; x=1780503146;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WOKLrG800JsNYDuenjSSGG1iYsq0yhwwkhv7Zpy4AB0=;
 b=BsUrqJauYAZzOULur67nSHDm1ICa4m1vLgd3V7SQ3IrW9nhYBBuq2H3Q
 BkBqLiTwfExgPUrC841CcJ1BpkBYyrhnOgs6eBNNyfFRkQ9Gdskh0C/QA
 Cuo5O1/coZqQt1W8cWjCYaCuFAKslAiZLu1jGilJae5Ym2rneAIkMHdVV
 YVsvYllCz01+e/b/+FvgGET0BvPFfT2h4Pm3mwMH55uF/EHyNzOlwFHY9
 d6237qll5ity2Ju4UA+v8G5K/lTKeKspwdDx2H6bCf35KUnYRcYux/X4C
 2U+fOvoSBOhSIpAHCi/BZJRrEImSNlDayaqRi2fs+InDhwJn/aAH1gyc0 w==;
X-CSE-ConnectionGUID: F39jUqFoSlO56Z3IlLvd5g==
X-CSE-MsgGUID: qTVj8UvCT+eIkAqLjH5g8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61677740"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="61677740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:12:22 -0700
X-CSE-ConnectionGUID: 3jX03g1PRp2jMHqq3bZA9w==
X-CSE-MsgGUID: qrbiEWqZQAmxVHi+a8m/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150191559"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:12:20 -0700
Message-ID: <e8a4148d-9e3e-4884-8b3c-e49bb7a4cdf5@intel.com>
Date: Wed, 4 Jun 2025 00:12:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Prefault memory on page state change
To: Paolo Bonzini <pbonzini@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
 <4a757796-11c2-47f1-ae0d-335626e818fd@intel.com>
 <cc2dc418-8e33-4c01-9b8a-beca0a376400@intel.com>
 <d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/3/2025 11:00 PM, Paolo Bonzini wrote:
> I'm applying Tom's patch to get it out of his queue, but will delay sending
> a pull request until the Linux-side fix is accepted.

BTW, for the patch itself.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>

