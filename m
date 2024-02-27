Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131F9C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retQS-0007fp-Hi; Tue, 27 Feb 2024 04:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1retQP-0007e8-OC; Tue, 27 Feb 2024 04:06:57 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1retQM-0007kA-4H; Tue, 27 Feb 2024 04:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709024815; x=1740560815;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/tjKuEbL0I0vIZe6oBP5MOkBmS0O+e/IjNu+fKHM/go=;
 b=T7u15EuSNvYKwuSjEG/HEVAM5I5QaM3WdqBU2rhSM9usfBqHDGi12YVG
 EqCFVptgew4hgsBu68GPn9QvrxAD6kggt1Vkb/is+RPcCLSzmUaDSG1on
 H/Ud51Kr1irUWj99YgMh1GMI3S6KwRZuz4kNI7jmdvrCjD6dGcMqFze5L
 jSnzT/nfDZBx9easrzNLYls7hNMsKl3JPrXJh3q/OPyjTh1EhZrGeQxV5
 xQEPVo1F+7fdBgnLB4HAWVJSUwU0ACfgiewKKEp8ggGtiK/UP+/eti6DG
 ACWVTx7uQpW/dhWUIsFi2LVOFt26nHgvC8yqlbae+hY0ggUsXVRpBhqWf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25818613"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="25818613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 01:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6839753"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 27 Feb 2024 01:06:42 -0800
Date: Tue, 27 Feb 2024 17:20:25 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <Zd2pWVH4/eo3HM8j@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <20240226153947.00006fd6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226153947.00006fd6@Huawei.com>
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Jonathan,

> Hi Zhao Liu
> 
> I like the scheme.  Strikes a good balance between complexity of description
> and systems that actually exist. Sure there are systems with more cache
> levels etc but they are rare and support can be easily added later
> if people want to model them.

Thanks for your support!

[snip]

> > +static int smp_cache_string_to_topology(MachineState *ms,
> 
> Not a good name for a function that does rather more than that.

What about "smp_cache_get_valid_topology()"?

> 
> > +                                        char *topo_str,
> > +                                        CPUTopoLevel *topo,
> > +                                        Error **errp)
> > +{
> > +    *topo = string_to_cpu_topo(topo_str);
> > +
> > +    if (*topo == CPU_TOPO_LEVEL_MAX || *topo == CPU_TOPO_LEVEL_INVALID) {
> > +        error_setg(errp, "Invalid cache topology level: %s. The cache "
> > +                   "topology should match the CPU topology level", topo_str);
> > +        return -1;
> > +    }
> > +
> > +    if (!machine_check_topo_support(ms, *topo)) {
> > +        error_setg(errp, "Invalid cache topology level: %s. The topology "
> > +                   "level is not supported by this machine", topo_str);
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void machine_parse_smp_cache_config(MachineState *ms,
> > +                                           const SMPConfiguration *config,
> > +                                           Error **errp)
> > +{
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +
> > +    if (config->l1d_cache) {
> > +        if (!mc->smp_props.l1_separated_cache_supported) {
> > +            error_setg(errp, "L1 D-cache topology not "
> > +                       "supported by this machine");
> > +            return;
> > +        }
> > +
> > +        if (smp_cache_string_to_topology(ms, config->l1d_cache,
> > +            &ms->smp_cache.l1d, errp)) {
> 
> Indent is to wrong opening bracket.
> Same for other cases.

Could you please educate me about the correct style here?
I'm unsure if it should be indented by 4 spaces.

Thanks,
Zhao


