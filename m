Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58854C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 07:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHtb-0007BK-FH; Fri, 09 May 2025 03:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDHtW-00079w-B4; Fri, 09 May 2025 03:11:43 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDHtT-0002UI-RY; Fri, 09 May 2025 03:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746774700; x=1778310700;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=2C5nET5W0bcIefwZbA8VGGLLv3FN4P08bT/uTlqla4U=;
 b=X4jd3BH0CDz1bkctTH4SFJNqS7mLi783drkRpEvj1VhrBIn/5xVZxWsS
 815JgA+cc503DFP+3qaEYeG5G3O/AS5swBEidcOaGHSxQY4RJVQcmgz1H
 kUty3Tl+E0OD3FConAIUhByrstfcACi3K/6ozqsbTv+M84P1FAg4CXe5n
 ZXnQ4MTTo6rXlB9pmYF3I3R+jGEjTOu45Vlr1+WtKnRy6W7APMoPbzGIP
 4uhV8rVPTRMKNHc3KJtPqvP4phR6o0/U631zv9z1BvR8DH8SX4ayMg1pR
 +RcOkBkOjNwjpxI4Iq6BtKtAiKGXdHQRU3zHESX8Lo6uWm6ME7S32DBtC g==;
X-CSE-ConnectionGUID: /gksMlF2Q6uX3X3EmaF4ug==
X-CSE-MsgGUID: giyLz8jKT8eDuqW/+rq6BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48505798"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48505798"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 00:11:35 -0700
X-CSE-ConnectionGUID: n9zxyQjGRH+MShzMygYUyA==
X-CSE-MsgGUID: 8Fjt0m4zT2CGbDnrIJiefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141311969"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 09 May 2025 00:11:28 -0700
Date: Fri, 9 May 2025 15:32:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 12/27] target/i386/cpu: Remove
 CPUX86State::enable_cpuid_0xb field
Message-ID: <aB2vjuT07EuO6JSQ@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Fri, May 09, 2025 at 02:49:27PM +0800, Xiaoyao Li wrote:
> Date: Fri, 9 May 2025 14:49:27 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v4 12/27] target/i386/cpu: Remove
>  CPUX86State::enable_cpuid_0xb field
> 
> On 5/8/2025 9:35 PM, Philippe Mathieu-Daudé wrote:
> > The CPUX86State::enable_cpuid_0xb boolean was only disabled
> > for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> > removed. Being now always %true, we can remove it and simplify
> > cpu_x86_cpuid().
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >   target/i386/cpu.h | 3 ---
> >   target/i386/cpu.c | 6 ------
> >   2 files changed, 9 deletions(-)
> > 
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 0db70a70439..06817a31cf9 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2241,9 +2241,6 @@ struct ArchCPU {
> >        */
> >       bool legacy_multi_node;
> > -    /* Compatibility bits for old machine types: */
> > -    bool enable_cpuid_0xb;
> > -
> >       /* Enable auto level-increase for all CPUID leaves */
> >       bool full_cpuid_auto_level;
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 49179f35812..6fe37f71b1e 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6982,11 +6982,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           break;
> >       case 0xB:
> >           /* Extended Topology Enumeration Leaf */
> > -        if (!cpu->enable_cpuid_0xb) {
> > -                *eax = *ebx = *ecx = *edx = 0;
> > -                break;
> > -        }
> > -
> >           *ecx = count & 0xff;
> >           *edx = cpu->apic_id;
> > @@ -8828,7 +8823,6 @@ static const Property x86_cpu_properties[] = {
> >       DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
> >       DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
> >       DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
> > -    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> 
> It's deprecating the "cpuid-0xb" property.
> 
> I think we need go with the standard process to deprecate it.

Thanks! I got your point.

Though this property is introduced for compatibility, as its comment
said "Compatibility bits for old machine types", it is also useful for 
somer users.

Fo example, in the early development stages of TDX, when there was no
full support for CPU topology, Intel had disable this property for
testing and found this bug:

https://lore.kernel.org/qemu-devel/20250227062523.124601-3-zhao1.liu@intel.com/

So, I think there may be other similar use cases as well.

And, if someone wants to emulate ancient x86 CPUs (though I can't
currently confirm from which generation of CPUs 0xb support started), he
may want to consider disable this property as well.

The main problem here is that the "property" mechanism doesn't
distinguish between internal use/public use, and although it was originally
intended for internal QEMU use, it also leaks to the user, creating some
external use cases.

@Philippe, thank you for cleaning up this case! I think we can keep this
property, and if you don't mind, I can modify its comment later to
indicate that it's used to adjust the topology support for the CPU.

Thanks,
Zhao


