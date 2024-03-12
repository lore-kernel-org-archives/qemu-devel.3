Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C293C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjytQ-0004nn-9f; Tue, 12 Mar 2024 05:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjytG-0004n4-QS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:57:47 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjytD-0000Ch-9c
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710237462; x=1741773462;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=m4NiaKsQ27utBVnDv39yTWwqiXt/Umj7/8ZxBQI5cT4=;
 b=hA1kWqqy3bswrTw+YE+xxLt5si8Pn6au2IhFhBV5PrP+8st4LTBSCYYF
 K7I2Ub5jeDMqeQK3MWB9TOZ+cWnyWGAwHEZ1fLe0KgN0eq8bY3BxNZ0Q2
 dtA624VKu0tqFzX2jm95t65M9g/eMJ0/6rCJhF0ti3Ya+lqmO9l9znoyd
 lnb1duWYZ50Cc/O/aX9QhDwZEpqToCdn6SE+r0wBRnO29qrxl7OYP+1uA
 hEZHO/YpbM/YbOICyIQ964X9j2bni6wMRp10VYHYamAPXKA54om53fdiz
 YJpQjVimlU83a32UrFU60I78/Iol5yRhjQVbVvKJRx313IYArnTme2mQ2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4808984"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4808984"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 02:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11550428"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 12 Mar 2024 02:57:36 -0700
Date: Tue, 12 Mar 2024 18:11:24 +0800
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
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 11/21] i386/cpu: Decouple CPUID[0x1F] subleaf with
 specific topology level
Message-ID: <ZfAqTEN8pvvgZ8IO@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-12-zhao1.liu@linux.intel.com>
 <005c1649-43d3-494f-951a-166e7200ffd5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005c1649-43d3-494f-951a-166e7200ffd5@intel.com>
Received-SPF: none client-ip=198.175.65.20;
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

On Mon, Mar 11, 2024 at 04:45:41PM +0800, Xiaoyao Li wrote:
> Date: Mon, 11 Mar 2024 16:45:41 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v9 11/21] i386/cpu: Decouple CPUID[0x1F] subleaf with
>  specific topology level
> 
> On 2/27/2024 6:32 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > At present, the subleaf 0x02 of CPUID[0x1F] is bound to the "die" level.
> > 
> > In fact, the specific topology level exposed in 0x1F depends on the
> > platform's support for extension levels (module, tile and die).
> > 
> > To help expose "module" level in 0x1F, decouple CPUID[0x1F] subleaf
> > with specific topology level.
> > 
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

> Besides, some nits below.
>

[snip]

> > +static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
> > +                                X86CPUTopoInfo *topo_info,
> > +                                uint32_t *eax, uint32_t *ebx,
> > +                                uint32_t *ecx, uint32_t *edx)
> > +{
> > +    X86CPU *cpu = env_archcpu(env);
> > +    unsigned long level;
> > +    uint32_t num_threads_next_level, offset_next_level;
> > +
> > +    assert(count + 1 < CPU_TOPO_LEVEL_MAX);
> > +
> > +    /*
> > +     * Find the No.count topology levels in avail_cpu_topo bitmap.
> > +     * Start from bit 0 (CPU_TOPO_LEVEL_INVALID).
> 
> AFAICS, it starts from bit 1 (CPU_TOPO_LEVEL_SMT). Because the initial value
> of level is CPU_TOPO_LEVEL_INVALID, but the first round of the loop is to
> find the valid bit starting from (level + 1).

Yes, this description is much clearer.

> > +     */
> > +    level = CPU_TOPO_LEVEL_INVALID;
> > +    for (int i = 0; i <= count; i++) {
> > +        level = find_next_bit(env->avail_cpu_topo,
> > +                              CPU_TOPO_LEVEL_PACKAGE,
> > +                              level + 1);
> > +
> > +        /*
> > +         * CPUID[0x1f] doesn't explicitly encode the package level,
> > +         * and it just encode the invalid level (all fields are 0)
> > +         * into the last subleaf of 0x1f.
> > +         */
> 
> QEMU will never set bit CPU_TOPO_LEVEL_PACKAGE in env->avail_cpu_topo.

In the patch 9 [1], I set the CPU_TOPO_LEVEL_PACKAGE in bitmap. This
level is a basic topology level in general, so it's worth being set.

Only in Intel's 0x1F, it doesn't have a corresponding type, and where
I use it as a termination condition for 0x1F encoding (not an error case).

[1]: https://lore.kernel.org/qemu-devel/20240227103231.1556302-10-zhao1.liu@linux.intel.com/

> So I think we should assert() it instead of fixing it silently.
> 
> > +        if (level == CPU_TOPO_LEVEL_PACKAGE) {
> > +            level = CPU_TOPO_LEVEL_INVALID;
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (level == CPU_TOPO_LEVEL_INVALID) {
> > +        num_threads_next_level = 0;
> > +        offset_next_level = 0;
> > +    } else {
> > +        unsigned long next_level;
> 
> please define it at the beginning of the function. e.g.,

Okay, I'll put the declaration of "next_level" at the beginning of this
function with a current variable "level".

> 
> > +        next_level = find_next_bit(env->avail_cpu_topo,
> > +                                   CPU_TOPO_LEVEL_PACKAGE,
> > +                                   level + 1);
> > +        num_threads_next_level = num_threads_by_topo_level(topo_info,
> > +                                                           next_level);
> > +        offset_next_level = apicid_offset_by_topo_level(topo_info,
> > +                                                        next_level);
> > +    }
> > +
> > +    *eax = offset_next_level;
> > +    *ebx = num_threads_next_level;
> > +    *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> 
> we can combine them together. e.g.,
> 
> *ebx = num_threads_next_level & 0xffff; /* ... */
> 
> > +    *ecx = count & 0xff;
> > +    *ecx |= cpuid1f_topo_type(level) << 8;
> 
> Ditto,
> 
> *ecx = count & 0xff | cpuid1f_topo_type(level) << 8;

OK, will combine these.

> > +    *edx = cpu->apic_id;
> > +
> > +    assert(!(*eax & ~0x1f));
> > +}
> > +

