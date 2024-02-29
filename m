Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A8FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 04:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfY6q-0003f1-PQ; Wed, 28 Feb 2024 23:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfY6o-0003eC-0d; Wed, 28 Feb 2024 23:33:26 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfY6l-0003AF-O9; Wed, 28 Feb 2024 23:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709181204; x=1740717204;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=K4P+3be7WkAmiqJGY461bGaJxoGNESikO7CzVS0rHDM=;
 b=gw9XArsMDCztrRoM0I0+bI6hbja+Bf1vlONqpGDY7kuUWcxK9C/YhYgF
 vq70eIqwHapdCibEhFdFu5iNgCDcYTzkCaLipTWM/JeGjkR8nbSVK5VYV
 kavlx5rRvU4AB4pc3S2vuyJNbAwE3Mulc+WTBEtpu2sa2RBg5uZ+hE1yl
 4OzDzNEHqvMzp0Q9ggmISVdYhUXI2s9H/qtRZbFwDO6Ggq8ua3Fxi5zls
 hqC1XXGuyRVzHEHYoXrfZ+2sQbw+DgYGv67DqaeKtqvr7LBXfVh6NxxsS
 YTCEsLvOZZY+W9ub25OEYqiciL5TLGScuovyJTD05JoWgjbyNfdqiMG2a Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14338802"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="14338802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 20:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="38526829"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 28 Feb 2024 20:33:12 -0800
Date: Thu, 29 Feb 2024 12:46:55 +0800
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
Subject: Re: [RFC 2/8] hw/core: Move CPU topology enumeration into
 arch-agnostic file
Message-ID: <ZeAMP7OCwWPMhpeD@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-3-zhao1.liu@linux.intel.com>
 <BJSPR01MB05614B900DA2E93AE9F8E0BE9C58A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BJSPR01MB05614B900DA2E93AE9F8E0BE9C58A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Received-SPF: none client-ip=192.198.163.9;
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

> > +const char *cpu_topo_to_string(CPUTopoLevel topo)
> > +{
> > +    return cpu_topo_descriptors[topo].name;
> > +}
> > +
> > +CPUTopoLevel string_to_cpu_topo(char *str)
>
> Can use const char *str.

Okay, I'll.

> > +{
> > +    for (int i = 0; i < ARRAY_SIZE(cpu_topo_descriptors); i++) {
> > +        CPUTopoInfo *info = &cpu_topo_descriptors[i];
> > +
> > +        if (!strcmp(info->name, str)) {
>
> Suggest to use strncmp instead.

Thanks! I tries "l1i-cache=coree", and it causes Segmentation fault.
Will fix.

> > +            return (CPUTopoLevel)i;
> > +        }
> > +    }
> > +    return CPU_TOPO_LEVEL_MAX;
> > +}

> > @@ -304,7 +304,7 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
> >                                            enum CPUTopoLevel topo_level)
> >  {
> >      switch (topo_level) {
> > -    case CPU_TOPO_LEVEL_SMT:
> > +    case CPU_TOPO_LEVEL_THREAD:
> >          return 1;
> Just wondering why 'return 1' is used directly for the thread, but not
> for the rest?

This helper returens how many threads in one topology domain/container
at this level.

For thread level, it calculates how many threads are in one thread
domain, so it returns 1 directly.

Thanks,
Zhao


