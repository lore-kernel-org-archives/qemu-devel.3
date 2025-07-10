Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB515C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmyf-0002gG-DC; Thu, 10 Jul 2025 04:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZmyU-0002eB-Jz
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:49:51 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZmyN-0002qv-VM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752137384; x=1783673384;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jjb8EBAPKJaLkqqYjHIuypNxUJcYtoRKwGS4zxKUAOQ=;
 b=L10k9UIK823I1e5bzxVGQdvX00VHq8S5W6I5v94M7HjXctaE3zcpykgz
 /ie9stv94yiiyZtujKZHZIH+g2xX5Qg0x8gYFLyyuikJfEc6QfiUR4g9D
 FyK76hGWjY9GXEDXwKtRlJYthuU6C0cl2Q2bgHhwgype0LoAtd0HXD5b3
 kn16lK2808iYMpYKf5RvbXDm+56m5hnaw3TIzITTRmdfTX6g70mINt+UP
 9hFaCWMRPlXeTy7GjYNoB0PyUGwKFQNk2MQbdaTgTJyekY6Qe1+F3A7KJ
 zLjBn4rwk34j1DfXAzNOtaP8If+0hrZyuQzZlE87Npw6CmE0rPIaGpggn Q==;
X-CSE-ConnectionGUID: e/xjrMSdT3W0kqsP55w0wg==
X-CSE-MsgGUID: oWFjVE8NTlmI0llZesCZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53631582"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="53631582"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 01:49:38 -0700
X-CSE-ConnectionGUID: XLHlrh6JQ4WTrdA2Eh6zDw==
X-CSE-MsgGUID: ZDwlUswFQ5OolKC63qSoHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="193217354"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 10 Jul 2025 01:49:36 -0700
Date: Thu, 10 Jul 2025 17:11:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: babu.moger@amd.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: Add TSA feature flags
Message-ID: <aG+DqDKL57nU00gr@intel.com>
References: <20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local>
 <8ba851bc-e7b3-461b-9bfb-4d7018771f0c@amd.com>
 <de97d1cc-69c9-4fcf-aa7d-3989475549d5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de97d1cc-69c9-4fcf-aa7d-3989475549d5@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 10, 2025 at 10:57:49AM +0800, Xiaoyao Li wrote:
> Date: Thu, 10 Jul 2025 10:57:49 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH] target/i386: Add TSA feature flags
 
[snip]

> > I recommend splitting this into two separate patches:
> > a. One patch to introduce the new bit 0021_EAX_VERW_CLEAR.
> 
> It also needs to be a separate patch to add it to "EPYC-Genoa" as v3, so
> please make it 3 patches.

Babu's v2 (abc92cc8488b) is added after v10.0, so it's still valid
to modify the current v2. But hard freeze is supposed at 7/22, once
v10.1 rc0 is released, then v3 is necessary.

Thanks,
Zhao


