Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D288C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTz8Y-0005Hk-UP; Tue, 24 Jun 2025 04:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTz8V-0005HV-QC
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:36:11 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uTz8Q-0006pW-FO
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750754166; x=1782290166;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2p03nju186D2pcoSuj3B2zzww3XAybxwZM5HBLWRFbA=;
 b=fA2P/oT/KfADuaaRI1rz0vlQ6eMNqo5Z0kl33KJtfve88nM9Zb9Fk9kv
 0sxThK6B1Qd8lubtrSKywQ7UjJTZIjt9lwl6pcUx1QLfVUQpZjELZdes9
 eC/D/u92GtRYwUl5XpLk0ot/IWm6NbWNQto34c0ftKIAENNUQ1sg9NzTT
 tDHXwsAiTiPSfNq7oy0tlANGDY0P/owbfWJVNqVo7ilo2Y0+g+8SxaPEo
 Tt6LboI6KK2HSI6QqZ9zJnF6Qr1i2a9nDcgD/wIb9LvOCK4bRnFhdu6dd
 ysgvYPcG2zhC9FnTfLJOAmzR6rT3X1cn4YzlvF+ktc4dglA2leHTUG9s1 Q==;
X-CSE-ConnectionGUID: vts4EPuxQre0JiKEZGmnhg==
X-CSE-MsgGUID: oWQtJfVFRouHLmSSuqSZ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53076092"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="53076092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 01:36:01 -0700
X-CSE-ConnectionGUID: JPT+e1x1QbaZbEsyNo/yoQ==
X-CSE-MsgGUID: 8pDkwIYeSEWAakCOQ9D1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="155879562"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2025 01:36:00 -0700
Date: Tue, 24 Jun 2025 16:57:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
Message-ID: <aFpocfTpBLB34N3l@intel.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 23, 2025 at 09:56:14AM -0700, Dongli Zhang wrote:
> Date: Mon, 23 Jun 2025 09:56:14 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [Regression] Re: [PULL 35/35] qom: reverse order of
>  instance_post_init calls
> 
> This commit may broken the "vendor=" configuration.
> 
> For instance, the hypervisor CPU vendor is AMD.
> 
> I am going to use "-cpu Skylake-Server,vendor=GenuineIntel".
> 
> 
> Because of the commit, the vendor is still AMD.
> 
> [root@vm ~]# cpuid -1 -l 0x0
> CPU:
>    vendor_id = "AuthenticAMD"
> 
> 
> If I revert this patch, the vendor because the expected Intel.
> 
> [root@vm ~]# cpuid -1 -l 0x0
> CPU:
>    vendor_id = "GenuineIntel"
> 
> 
> Thank you very much!

Thank you Dongli!

(+Like)

While testing my cache model series, I also noticed the similar behavior
for KVM. Additionally, Like Xu reported to me that this commit caused
a failure in a KVM unit test case. Your report helped me connect these
two issues I met (though due to my environment issues, I haven't
confirmed yet).

The "vendor" property from cli is registered as the global property in
x86_cpu_parse_featurestr(), and is applied to x86 CPUs in
device_post_init().

With this commit, now KVM will override the "vendor" in
host_cpu_instance_init() (called in x86_cpu_post_initfn()) after
device_post_init(), regardless the previous global "vendor" property.

Back to this commit, I think current order of post_init  makes sense.
Instead, the place of host_cpu_instance_init() doesn't seem quite
right. So, I think this commit might have exposed some drawbacks in the
previous x86 CPU initialization order:

f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
5b8978d80426 ("i386: do not call cpudef-only models functions for max, host, base")



