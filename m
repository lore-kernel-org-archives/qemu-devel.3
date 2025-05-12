Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E4DC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 02:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEIqj-0003SB-0A; Sun, 11 May 2025 22:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEIqd-0003R6-U9; Sun, 11 May 2025 22:24:56 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEIqb-0002fF-6n; Sun, 11 May 2025 22:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747016693; x=1778552693;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=z7qhnh/wiUvOpKBKk84OgMz6hz8R1PuKuj0Ro9Ok98M=;
 b=Il4RtjogniuZ1Vc47Rt4Z9LOQPhjE66PNjCWylTwcnuwMZ13Up4THUCO
 N4J2UabTWRTP4IUWHf+hcO+J+sg9dteiKfFurjllb3ibVTd9HatngOl+p
 H4MiRfxIdeG7J9lo1wwHcJhtCWdxqH2eK8ZSBA8r83uXKcsiqT8zhwlAT
 XN21uAkOI8PHt2fOh8UR9RNSUtfKmIxhnBdJOsMuigZ6RAoFTHUjgzkPZ
 xmknITFlhIMKga+4ZYMfASP5Zy1uak9rAyhkqfd/jQBeHtC44glUjL3UX
 x9Xgu49SRMsQ7pLifBoIMNetLWQlnYoLWh9TkZDIeZ2WWFXukUQbKjRAI A==;
X-CSE-ConnectionGUID: SBrb44oPSjuOXuV1jV5MCQ==
X-CSE-MsgGUID: 3Tcd+DZISQy1hwd49i0lug==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="60202903"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="60202903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2025 19:24:47 -0700
X-CSE-ConnectionGUID: MOgSV+puRlO3gTTA58Sv+Q==
X-CSE-MsgGUID: nX5TD5wBSsGv9x37LRRe2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="137094374"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 11 May 2025 19:24:40 -0700
Date: Mon, 12 May 2025 10:45:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties (was: Re: [PATCH v4 12/27]
 target/i386/cpu: Remove CPUX86State::enable_cpuid_0xb field)
Message-ID: <aCFg1hr1wpNZIcL3@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com>
 <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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

On Fri, May 09, 2025 at 12:04:19PM +0200, Thomas Huth wrote:
> Date: Fri, 9 May 2025 12:04:19 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: How to mark internal properties (was: Re: [PATCH v4 12/27]
>  target/i386/cpu: Remove CPUX86State::enable_cpuid_0xb field)
> 
> On 09/05/2025 09.32, Zhao Liu wrote:
> > On Fri, May 09, 2025 at 02:49:27PM +0800, Xiaoyao Li wrote:
> > > Date: Fri, 9 May 2025 14:49:27 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v4 12/27] target/i386/cpu: Remove
> > >   CPUX86State::enable_cpuid_0xb field
> > > 
> > > On 5/8/2025 9:35 PM, Philippe Mathieu-Daud¨¦ wrote:
> > > > The CPUX86State::enable_cpuid_0xb boolean was only disabled
> > > > for the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> > > > removed. Being now always %true, we can remove it and simplify
> > > > cpu_x86_cpuid().
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daud¨¦ <philmd@linaro.org>
> > > > ---
> > > >    target/i386/cpu.h | 3 ---
> > > >    target/i386/cpu.c | 6 ------
> > > >    2 files changed, 9 deletions(-)
> > > > 
> > > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > > index 0db70a70439..06817a31cf9 100644
> > > > --- a/target/i386/cpu.h
> > > > +++ b/target/i386/cpu.h
> > > > @@ -2241,9 +2241,6 @@ struct ArchCPU {
> > > >         */
> > > >        bool legacy_multi_node;
> > > > -    /* Compatibility bits for old machine types: */
> > > > -    bool enable_cpuid_0xb;
> > > > -
> > > >        /* Enable auto level-increase for all CPUID leaves */
> > > >        bool full_cpuid_auto_level;
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 49179f35812..6fe37f71b1e 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -6982,11 +6982,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > > >            break;
> > > >        case 0xB:
> > > >            /* Extended Topology Enumeration Leaf */
> > > > -        if (!cpu->enable_cpuid_0xb) {
> > > > -                *eax = *ebx = *ecx = *edx = 0;
> > > > -                break;
> > > > -        }
> > > > -
> > > >            *ecx = count & 0xff;
> > > >            *edx = cpu->apic_id;
> > > > @@ -8828,7 +8823,6 @@ static const Property x86_cpu_properties[] = {
> > > >        DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
> > > >        DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
> > > >        DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
> > > > -    DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> > > 
> > > It's deprecating the "cpuid-0xb" property.
> > > 
> > > I think we need go with the standard process to deprecate it.
> > 
> > Thanks! I got your point.
> > 
> > Though this property is introduced for compatibility, as its comment
> > said "Compatibility bits for old machine types", it is also useful for
> > somer users.
> 
> Thanks for your clarifications, Zhao! But I think this shows again the
> problem that we have hit a couple of times in the past already: Properties
> are currently used for both, config knobs for the users and internal
> switches for configuration of the machine. We lack a proper way to say "this
> property is usable for the user" and "this property is meant for internal
> configuration only".

Hi Thomas, thank you.

AFAIK, there are two ways to configure whether an object/device is
allowed to be created by user or not:

* TYPE_USER_CREATABLE
* DeviceClass: user_creatable

So, it looks like it would be tricky to change the infrastructure around
object_property_add because it's not easy to be compatible with both of the
above user creation ways.

> I wonder whether we could maybe come up with a naming scheme to better
> distinguish the two sets, e.g. by using a prefix similar to the "x-" prefix
> for experimental properties? We could e.g. say that all properties starting
> with a "q-" are meant for QEMU-internal configuration only or something
> similar (and maybe even hide those from the default help output when running
> "-device xyz,help" ?)? Anybody any opinions or better ideas on this?

Therefore, I think the ¡°q-¡± prefix might be a good way, simple and effective.

Let's see if any other maintainers have a better idea.

Regards,
Zhao


