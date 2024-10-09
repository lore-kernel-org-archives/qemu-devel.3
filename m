Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B42CF043C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 04:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNxF-0000jI-SJ; Wed, 09 Oct 2024 00:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syNxC-0000ix-Ab; Wed, 09 Oct 2024 00:05:38 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syNx9-00018W-OE; Wed, 09 Oct 2024 00:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728446736; x=1759982736;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LW5YGQwvem/2wNoyiBnj3kJYa9aUyDjyTctsM2wWJuo=;
 b=V5FbF12uvQ56EPET+NCyNVaXM1rv39/O7agdHy6ModizuQ7NwSARNX7w
 oa8uYbXSEAjDa5n5jreluuR4uurP/6SUR+LtEsWDrh26O7yqRROjde/fD
 tvNICk8W3ppL8Cz+FGtTjn9oh8ZySNhoOhLB7kCWkGKebHwu/aoyNxHpH
 72y8nyDVkV5ezGbggG1IL3kF9qbNR5q144JShIx0AVTaKynGlwM5K5/Si
 d9uZOaZ70GIqVu8L3HLy/Nkp50yL9DSpaQYPK2RFZggD1/dWWcpinbDnH
 /TtRc/0lFhdL+4Rb/r7MtL/Oc+Sjb9kM55QqxqNYk2n2gDTZq/5mUfVa9 Q==;
X-CSE-ConnectionGUID: 2g0+szYXQqmBSM7Ylp6yVQ==
X-CSE-MsgGUID: RVLbwty1RHSw/nIyhI1rrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27881556"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="27881556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2024 21:05:32 -0700
X-CSE-ConnectionGUID: t9vla2jgTQeVYeAYP6gEUg==
X-CSE-MsgGUID: kyAwWjQeTMuqF4OlnRYDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="106948334"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 08 Oct 2024 21:05:30 -0700
Date: Wed, 9 Oct 2024 12:21:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZwYE1XODTVjQ5YGO@intel.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Wed, Oct 09, 2024 at 11:56:38AM +0800, Chuang Xu wrote:
> Date: Wed,  9 Oct 2024 11:56:38 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
>  processors in the physical package
> X-Mailer: git-send-email 2.39.3 (Apple Git-146)
> 
> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> On Intel platform:
> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
> logical processors in the physical package".
> 
> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> CPUID.04H.EAX[31:26], which matches the expected result.
> 
> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though threads-per-core should actually be 2.
> 
> And on AMD platform:
> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
> result meets our expectation.
> 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> only for Intel platform to solve the unexpected result.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

This version is fine for me, thanks.

-Zhao


