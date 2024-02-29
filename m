Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E2C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaH5-0002MR-Iz; Thu, 29 Feb 2024 01:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfaG7-00021C-5O; Thu, 29 Feb 2024 01:51:19 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfaG4-0006st-B5; Thu, 29 Feb 2024 01:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709189468; x=1740725468;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GS2K/1elXcA90zDdKMXQSx9HqJcMQIF3eoynkMWLosE=;
 b=Teh29f6mSrRGK1M1EhG9Yu/b+qRBZkCLwDp3QulrnYTIOWs6Ir8Co3qn
 h3VOJ3vx8Rwqw8QB7xLymaoI3/E4BCibgKeFfboa65e75MB4O3WZELb1u
 6BLJYFgYHn2cLtUxW9ZNRXdjBHSD8rNN1WKmYCMhqfpOqPcOj0orVZo+U
 33g0/tt3Ic+HMKmNKNhz0RXKhG7dSQ9tGLnAwWIch6UL3rfDm8Jvm05j6
 M5Unt+b6beFQGH8PhmyODbRXqhmpHDp7CeiIKUPkqNlsA5QrcowHxrDxf
 MODxMV9HZ4iB+GvIWH54ji1s6xGGPLs0tJqsPaZtETEQDisTB4SzBPExS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3755274"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3755274"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:51:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7638819"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 28 Feb 2024 22:50:58 -0800
Date: Thu, 29 Feb 2024 15:04:42 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <ZeAsijVdx6DO+1pP@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <BJSPR01MB05618A7D409C2DE3E408345C9C58A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BJSPR01MB05618A7D409C2DE3E408345C9C58A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

Hi JeeHeng,

> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 426f71770a84..cb5173927b0d 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -886,6 +886,10 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
> >          .has_cores = true, .cores = ms->smp.cores,
> >          .has_threads = true, .threads = ms->smp.threads,
> >          .has_maxcpus = true, .maxcpus = ms->smp.max_cpus,
> > +        .l1d_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l1d)),
> > +        .l1i_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l1i)),
> > +        .l2_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l2)),
> > +        .l3_cache = g_strdup(cpu_topo_to_string(ms->smp_cache.l3)),
>
> Let's standardize the code by adding the 'has_' prefix.

SMPConfiguration is automatically generated in the compilation, and its
prototype is defined in qapi/machine.json like the following code:


> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index d0e7f1f615f3..0a923ac38803 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1650,6 +1650,14 @@
> >  #
> >  # @threads: number of threads per core
> >  #
> > +# @l1d-cache: topology hierarchy of L1 data cache (since 9.0)
> > +#
> > +# @l1i-cache: topology hierarchy of L1 instruction cache (since 9.0)
> > +#
> > +# @l2-cache: topology hierarchy of L2 unified cache (since 9.0)
> > +#
> > +# @l3-cache: topology hierarchy of L3 unified cache (since 9.0)
> > +#
> >  # Since: 6.1
> >  ##
> >  { 'struct': 'SMPConfiguration', 'data': {
> > @@ -1662,7 +1670,11 @@
> >       '*modules': 'int',
> >       '*cores': 'int',
> >       '*threads': 'int',
> > -     '*maxcpus': 'int' } }
> > +     '*maxcpus': 'int',
> > +     '*l1d-cache': 'str',
> > +     '*l1i-cache': 'str',
> > +     '*l2-cache': 'str',
> > +     '*l3-cache': 'str' } }
> >

The gnerated complete structure is (will in build/qapi/qapi-types-machine.h):

struct SMPConfiguration {
    bool has_cpus;
    int64_t cpus;
    bool has_drawers;
    int64_t drawers;
    bool has_books;
    int64_t books;
    bool has_sockets;
    int64_t sockets;
    bool has_dies;
    int64_t dies;
    bool has_clusters;
    int64_t clusters;
    bool has_modules;
    int64_t modules;
    bool has_cores;
    int64_t cores;
    bool has_threads;
    int64_t threads;
    bool has_maxcpus;
    int64_t maxcpus;
    char *l1d_cache;
    char *l1i_cache;
    char *l2_cache;
    char *l3_cache;
};

The int member defined in qapi/machine.json will get their corresponding
status fields as has_* to indicate if user sets those int fields.

For str type, the status field is not needed since NULL is enough to
indicate no user sets that.

Thanks,
Zhao


