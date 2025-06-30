Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C4C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWG13-000243-Cn; Mon, 30 Jun 2025 11:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWG0n-00021W-WD
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:01:43 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWG0k-00059b-AO
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751295694; x=1782831694;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8wGalKdVuYUNEhhfVz3VISsqj82RsNcy4Yl45QObEzM=;
 b=k4ZlQWrzE224pyxFP9FPvcCt8uXSrcrq7NhoBSYdhxjwvOj4u5qBbedh
 8j81twNLOKh6p9I19rHZhPEa2PpKuf1yh99qy88dclfh7pq6KmWDHNlA4
 3DcNCCy2HrqZcGVZxbOFHbGHu7LGDPDcOH9PD71isqw7nuzZ5CD5NXu61
 6aGdCqqEu3q2H7eadKj5fbZ4ivx8FXBGVVyXyqH77S6BEVlEVK+67nuQw
 lLPt00IfUOGWVI+bbK8WlGXT+awjD6WE82p2A5QLRXbgLX8ePw3pr6ZF5
 J1N2k5HftX7bG/PpJN77vLo+odLkTXYzzsLpLZvX5jjRHF8UjXn/zgXi6 g==;
X-CSE-ConnectionGUID: dnMSnQg/Tp+HeyKSzbP60g==
X-CSE-MsgGUID: jfoXDQg3QLuVdEgZopmrbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53399942"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="53399942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:01:30 -0700
X-CSE-ConnectionGUID: nEv33Z5xQb2kDxoGpiNcKg==
X-CSE-MsgGUID: 7VTbZlsQT82W2ORq/pxqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="158989912"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2025 08:01:24 -0700
Date: Mon, 30 Jun 2025 23:22:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
Message-ID: <aGKryLSGlFTMSKHv@intel.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFpocfTpBLB34N3l@intel.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

(cc Thomas for bug reporting on kvm-unit-test...)

On Tue, Jun 24, 2025 at 04:57:21PM +0800, Zhao Liu wrote:
> Date: Tue, 24 Jun 2025 16:57:21 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
>  instance_post_init calls
> 
> On Mon, Jun 23, 2025 at 09:56:14AM -0700, Dongli Zhang wrote:
> > Date: Mon, 23 Jun 2025 09:56:14 -0700
> > From: Dongli Zhang <dongli.zhang@oracle.com>
> > Subject: [Regression] Re: [PULL 35/35] qom: reverse order of
> >  instance_post_init calls
> > 
> > This commit may broken the "vendor=" configuration.
> > 
> > For instance, the hypervisor CPU vendor is AMD.
> > 
> > I am going to use "-cpu Skylake-Server,vendor=GenuineIntel".
> > 
> > 
> > Because of the commit, the vendor is still AMD.
> > 
> > [root@vm ~]# cpuid -1 -l 0x0
> > CPU:
> >    vendor_id = "AuthenticAMD"
> > 
> > 
> > If I revert this patch, the vendor because the expected Intel.
> > 
> > [root@vm ~]# cpuid -1 -l 0x0
> > CPU:
> >    vendor_id = "GenuineIntel"
> > 
> > 
> > Thank you very much!
> 
> Thank you Dongli!
> 
> (+Like)
> 
> While testing my cache model series, I also noticed the similar behavior
> for KVM. Additionally, Like Xu reported to me that this commit caused
> a failure in a KVM unit test case. Your report helped me connect these
> two issues I met (though due to my environment issues, I haven't
> confirmed yet).

Ok, now I can confirm this commit cause KUT failure:
 * On AMD platform, the "msr.flat" case fails since this case requires
   vendor=GenuineIntel (tested by Like).
 * On Intel platform, the "syscall.flat" case fails because it requires
   vendor=AuthenticAMD (tested by myself).

> The "vendor" property from cli is registered as the global property in
> x86_cpu_parse_featurestr(), and is applied to x86 CPUs in
> device_post_init().
> 
> With this commit, now KVM will override the "vendor" in
> host_cpu_instance_init() (called in x86_cpu_post_initfn()) after
> device_post_init(), regardless the previous global "vendor" property.

This is the root cause for the above failure.

> Back to this commit, I think current order of post_init  makes sense.
> Instead, the place of host_cpu_instance_init() doesn't seem quite
> right. So, I think this commit might have exposed some drawbacks in the
> previous x86 CPU initialization order:
> 
> f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
> 5b8978d80426 ("i386: do not call cpudef-only models functions for max, host, base")

To fix this issue, we need to initialize "vendor" property in the initfn
of max/host/named CPUs instead of current post_initfn.

This will need to split the cpu_instance_init() of x86 kvm (and maybe hvf/tcg)
into 2 hooks:
 * AccelCPUClass.cpu_instance_init() - called in x86 CPUs' initfn.
 * AccelCPUClass.cpu_instance_post_init() - called in x86 CPUs'
   post_initfn.

I just did a POC and this solution works in principle.

But there are very many more details here, including considering more
properties/considering hvf and tcg and so on. It still need to take more
time for me figuring everything out. Once that's done, I'll post a series
to fix this issue.

Thanks,
Zhao


