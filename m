Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjajm-0007Jn-Bu; Mon, 11 Mar 2024 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjajl-0007JF-8D
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:10:21 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjajj-0004HT-9K
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710144619; x=1741680619;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T0YVqkROoTZT7ZXF1wX65oUz/qiMr4QFmWDX6GaS7gw=;
 b=Rl+guP6dVDApzaVS86rTT3Q5nEmBvkPLQczxabB4IAGJwyEf35JgqQsy
 abSWoyxANzkLzASA451IKQtjO/STkU5zsUhTUSFgPkC4MbPVWKk05IdkN
 ODqEr97KQkO80qeg8YfOLt4ATjYrmRac/svPm449rSZ8MseWoAT2KA3oV
 lDY9QKq+Dhvybs2ROyIQRPGEvriY3e00C07To2pbpOJTN4/R2yVTwvcBO
 9KxpDCBfAUcOkfTAS7dA6hNlEMT3OkZl3e0irmQIzgyBJ6qPmqsmNsvxM
 KGZeeBzUqC1f8g/z78/kdUA5CaYeByx413w9I1TTzKf8QGMwwmMyUQaLt w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4957969"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4957969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 01:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="42017291"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2024 01:10:08 -0700
Date: Mon, 11 Mar 2024 16:23:57 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v9 06/21] i386/cpu: Use APIC ID info to encode cache topo
 in CPUID[4]
Message-ID: <Ze6/naoIIXj/DfTv@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-7-zhao1.liu@linux.intel.com>
 <c88ee253-f212-4aa7-9db9-e90a99a9a1e3@intel.com>
 <Ze23y7UzGxnsyo6O@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze23y7UzGxnsyo6O@intel.com>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
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

Hi Xiaoyao,

Did the following reason convince you? Could I take your r/b tag with
current code? ;-)

Thanks,
Zhao

On Sun, Mar 10, 2024 at 09:38:19PM +0800, Zhao Liu wrote:
> Date: Sun, 10 Mar 2024 21:38:19 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: Re: [PATCH v9 06/21] i386/cpu: Use APIC ID info to encode cache
>  topo in CPUID[4]
> 
> Hi Xiaoyao,
> 
> > >               case 3: /* L3 cache info */
> > > -                die_offset = apicid_die_offset(&topo_info);
> > >                   if (cpu->enable_l3_cache) {
> > > +                    addressable_threads_width = apicid_die_offset(&topo_info);
> > 
> > Please get rid of the local variable @addressable_threads_width.
> > 
> > It is truly confusing.
> 
> There're several reasons for this:
> 
> 1. This commit is trying to use APIC ID topology layout to decode 2
> cache topology fields in CPUID[4], CPUID.04H:EAX[bits 25:14] and
> CPUID.04H:EAX[bits 31:26]. When there's a addressable_cores_width to map
> to CPUID.04H:EAX[bits 31:26], it's more clear to also map
> CPUID.04H:EAX[bits 25:14] to another variable.
> 
> 2. All these 2 variables are temporary in this commit, and they will be
> replaed by 2 helpers in follow-up cleanup of this series.
> 
> 3. Similarly, to make it easier to clean up later with the helper and
> for more people to review, it's neater to explicitly indicate the
> CPUID.04H:EAX[bits 25:14] with a variable here.
> 
> 4. I call this field as addressable_threads_width since it's "Maximum
> number of addressable IDs for logical processors sharing this cache".
> 
> Its own name is long, but given the length, only individual words could
> be selected as names.
> 
> TBH, "addressable" deserves more emphasis than "sharing". The former
> emphasizes the fact that the number of threads chosen here is based on
> the APIC ID layout and does not necessarily correspond to actual threads.
> 
> Therefore, this variable is needed here.
> 
> Thanks,
> Zhao
> 

