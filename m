Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3708CED253
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxzki-0008Il-4x; Mon, 07 Oct 2024 22:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxzkf-0008Hx-PY; Mon, 07 Oct 2024 22:15:05 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxzkd-0005Se-1K; Mon, 07 Oct 2024 22:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728353703; x=1759889703;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=sNPYvNV2hJOmrCapEgKBtRGpAH013u3VVTSG+qxeO4I=;
 b=OsOl1PeOppdXl0r/BRtz9xFU2lgwnBvscMZ54uVFoqX6CzyO68biA1J/
 7q22O5LuhQa7mL3HlOmlD6N6p2LzYunJCaBmNCvtfCBvjhXc4Umg7/H3m
 KtT8vyDBQ1Vx9TSE5V+cV2/PTF6YEe0CetzuaZbtv2VdJQdueyof+blZg
 MSiA0JkbSMjhyc/ByriLi0RlG7jpCnu29Sad8KZTuwPhUE5XKGZ4z4F1q
 3eMaha2zsp4IMR2da+h5lew9Q8p12E6DkdFtfZgxK8RvbiLM/CUuAchPO
 qFpceFJquRihFg9yCEY4fqnofpGZBCeLwiy/55HKkF3uQ7jSHtsuXWmv2 Q==;
X-CSE-ConnectionGUID: Hggym/E7Qf2mkVc+TvgrfA==
X-CSE-MsgGUID: PuQQQQ6ASfK6nnyqsmROGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38655308"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; d="scan'208";a="38655308"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 19:14:59 -0700
X-CSE-ConnectionGUID: TD9i3HMbT5C/ff4ORqL0ig==
X-CSE-MsgGUID: nrvI1naMTrCTEEn1l5VvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; d="scan'208";a="80501660"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2024 19:14:57 -0700
Date: Tue, 8 Oct 2024 10:31:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v4] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZwSZbJYedDV0hBYj@intel.com>
References: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
 <20241007143339.5e4c512e@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007143339.5e4c512e@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Mon, Oct 07, 2024 at 02:33:39PM +0200, Igor Mammedov wrote:
> Date: Mon, 7 Oct 2024 14:33:39 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v4] i386/cpu: fixup number of addressable IDs for
>  logical processors in the physical package
> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
> 
> On Mon,  7 Oct 2024 16:13:44 +0800
> Chuang Xu <xuchuangxclwt@bytedance.com> wrote:
> 
> > When QEMU is started with:
> > -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> > -smp 180,sockets=2,dies=1,cores=45,threads=2
> > 
> > Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
> > CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
> > execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
> > CPUID.04H.EAX[31:26] as expected.
> > 
> > As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> > we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> > integer too. Otherwise we may encounter unexpected results in guest.
> > 
> > For example, when QEMU is started with CLI above and xtopology is disabled,
> > guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> > calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> > as the result, even though theads-per-core should actually be 2.
> > 
> > So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> > to solve the unexpected result.
> > 
> > In addition, we introduce max_thread_number_in_package() instead of
> > using pow2ceil() to be compatible with smp and hybrid.
> 
> though I'm still worried that we can't use pow2ceil() to match spec closer.
> Probably we are doing something wrong if bit shift works while pow2ceil()
> as described in spec doesn't.

The addressable ID is the (whole or partial) initial APIC ID, so the bit
shift operation on APIC ID is mathematically equivalent to the pow2ceil()
on the addressable ID as well. I¡¯ll keep a close eye on this. :-) 
 
> Acked-by: Igor Mammedov <imammedo@redhat.com>

