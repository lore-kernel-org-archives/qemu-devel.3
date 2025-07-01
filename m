Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56432C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYv6-0004v1-5k; Tue, 01 Jul 2025 07:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWYv3-0004uQ-CT; Tue, 01 Jul 2025 07:12:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWYv0-0000yC-1z; Tue, 01 Jul 2025 07:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751368374; x=1782904374;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xFhPSyGkeq1HsapYZVzfhrWmcZVtRpfUOIl6ai+xeUs=;
 b=hqGco2vA3DmcY1X/YyeHHijJGeciDzG7S+9bjJjAz7ANjVBWv0QMlVUb
 gO1oV5uzikfCgsn+CSxfSnIZXO0Cs5H/UW9r/Zg4EyyoFomcrm0MK4uSG
 z58Qu9MeFAVxGjxQna5gb6u/MUvjaYPAumPaRlEddLQ5+3b3vo690hsuT
 Ra1JOLJAfT0wWIwmKzB9b3PGUL8k4nqUP4AtGm4DX36my+rLZAUNSQPR5
 rdcy0FYh++EUZRFIEu17AEYV4A/y92/FVWu4yMvhuFdF44+EXZ+ee0t2/
 OCjCCrOTNXN8ULKFa4+jk0+MEdScYLmA3NTJ9ugJ8iJ03UcWwRLKgdoXi w==;
X-CSE-ConnectionGUID: 4mm6hMxUR3yJVyoaZRK49g==
X-CSE-MsgGUID: vHuB8ZF/S5Ox2E8U9Iw7Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53350493"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="53350493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 04:12:49 -0700
X-CSE-ConnectionGUID: 98BTe/sSTTyiYlmlyG8Eyg==
X-CSE-MsgGUID: 0C+mcSFoTUu017pGnoEkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="153906309"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 04:12:47 -0700
Message-ID: <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
Date: Tue, 1 Jul 2025 19:12:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aGO3vOfHUfjgvBQ9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
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

On 7/1/2025 6:26 PM, Zhao Liu wrote:
>> unless it was explicitly requested by the user.
> But this could still break Windows, just like issue #3001, which enables
> arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
> turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
> value would even break something.
> 
> So even for named CPUs, arch-capabilities=on doesn't reflect the fact
> that it is purely emulated, and is (maybe?) harmful.

It is because Windows adds wrong code. So it breaks itself and it's just 
the regression of Windows.

KVM and QEMU are not supposed to be blamed.

