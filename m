Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ABEC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxqT-0004HL-08; Tue, 12 Mar 2024 04:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjxqM-00047F-Gu
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:50:44 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjxqJ-0005n0-NZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710233440; x=1741769440;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tA7oWp+GjC17n46OR1Cu4CFWGzTsKORFW9MJUrRGwSc=;
 b=SKwdfOai2WmSwpkUrsxlT3CMKXELFfDw7M9W8psv3RqRHwKWwmpIU4Vf
 i5CeL3s6hufPaDl0YRE2mXHZnv292ijqcCb0RA/ZLKF/hHEEy+T6EP3yq
 KerZlWVa3pKjHi7aQUoXjZ87jx6wSVyk9Ci0+2z9bJ5SIX3ij2Pqu6HIe
 KAcfU8OxaUbb96qkytaje4mkxxfCc72peDBSiiZpyl05Nuq21JP7r021f
 UkVoQMAhzmFZk4OZlb31J+lV9jOUuGOBhojbcDK8yOMRMWxt8lyd44O0x
 7SNEsfJqiADXEqV9kSUscT4VjYUKYzgEKt7HHm/chimutFVuHLLQUuHsl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27403845"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="27403845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 01:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="16043565"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2024 01:50:31 -0700
Date: Tue, 12 Mar 2024 17:04:21 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v9 06/21] i386/cpu: Use APIC ID info to encode cache topo
 in CPUID[4]
Message-ID: <ZfAalR49aErs2/M1@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-7-zhao1.liu@linux.intel.com>
 <c88ee253-f212-4aa7-9db9-e90a99a9a1e3@intel.com>
 <Ze23y7UzGxnsyo6O@intel.com>
 <164e9fe1-c89d-4354-a7f7-a565c624934e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164e9fe1-c89d-4354-a7f7-a565c624934e@intel.com>
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 11, 2024 at 05:03:02PM +0800, Xiaoyao Li wrote:
> Date: Mon, 11 Mar 2024 17:03:02 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v9 06/21] i386/cpu: Use APIC ID info to encode cache
>  topo in CPUID[4]
> 
> On 3/10/2024 9:38 PM, Zhao Liu wrote:
> > Hi Xiaoyao,
> > 
> > > >                case 3: /* L3 cache info */
> > > > -                die_offset = apicid_die_offset(&topo_info);
> > > >                    if (cpu->enable_l3_cache) {
> > > > +                    addressable_threads_width = apicid_die_offset(&topo_info);
> > > 
> > > Please get rid of the local variable @addressable_threads_width.
> > > 
> > > It is truly confusing.
> > 
> > There're several reasons for this:
> > 
> > 1. This commit is trying to use APIC ID topology layout to decode 2
> > cache topology fields in CPUID[4], CPUID.04H:EAX[bits 25:14] and
> > CPUID.04H:EAX[bits 31:26]. When there's a addressable_cores_width to map
> > to CPUID.04H:EAX[bits 31:26], it's more clear to also map
> > CPUID.04H:EAX[bits 25:14] to another variable.
> 
> I don't dislike using a variable. I dislike the name of that variable since
> it's misleading

Names are hard to choose...

> 
> > 2. All these 2 variables are temporary in this commit, and they will be
> > replaed by 2 helpers in follow-up cleanup of this series.
> 
> you mean patch 20?
> 
> I don't see how removing the local variable @addressable_threads_width
> conflicts with patch 20. As a con, it introduces code churn.

Yes...I prefer to wrap it in variables in advance, then the meaning of
the fields is clearer I think.

> > 3. Similarly, to make it easier to clean up later with the helper and
> > for more people to review, it's neater to explicitly indicate the
> > CPUID.04H:EAX[bits 25:14] with a variable here.
> 
> If you do want keeping the variable. Please add a comment above it to
> explain the meaning.
>

OK, I'll add comments for both 2 variables. Thanks!


