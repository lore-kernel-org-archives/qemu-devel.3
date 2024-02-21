Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBABC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcobK-0003kQ-7f; Wed, 21 Feb 2024 10:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoYF-0005hy-Ei; Wed, 21 Feb 2024 10:30:27 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rco8T-0000Gw-BX; Wed, 21 Feb 2024 10:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708527829; x=1740063829;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=icf79m790ezLNPPZJLTw/l5EOQt2t+L55q4q0lXCEZI=;
 b=mKfo/Uud4EzOF4JnHaVLJY89PkcnOecrcA/CoatX965BXGTSQK9fsmvJ
 DjdSfUg4IeeQ6jagbnTFFxrlQw+3reHt/7DE9YATnu4CNI1k1b63Hq1lH
 UYUK0ABwsL5SKEPmZOPONfxDCh7EUq8k2PNszaBLsDxRPUONxYe8KPfQE
 FWsU28rMyKs4QoQZlUqHcj+TFVMkYU+ChI4I586AqK66FenLpg96TIZuq
 OEG0gxcaooQP3jbzRcbNzXAA/Z4QzvLGPrljMwkcxEqu7bdZTou2Quvjq
 z/3zbnFwyUdFtq4pVudfgdCUjk7q2bF8B3q5JEtaR+3NLuRt3R94FKJtE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="28131335"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; d="scan'208";a="28131335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 07:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="827362818"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; d="scan'208";a="827362818"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 21 Feb 2024 07:03:31 -0800
Date: Wed, 21 Feb 2024 23:17:11 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <ZdYT94zKGTgG/ipH@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <871q9656jm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q9656jm.fsf@pond.sub.org>
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Wed, Feb 21, 2024 at 01:46:21PM +0100, Markus Armbruster wrote:
> Date: Wed, 21 Feb 2024 13:46:21 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
> 
> Zhao Liu <zhao1.liu@linux.intel.com> writes:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
> > -smp to define the cache topology for SMP system.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> [...]
> 
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
> 
> Too terse, just like my review ;-P

;-) Yes, I'll add more information to improve the readability of the
code and comments.

Thanks,
Zhao

> 
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
> >  ##
> >  # @x-query-irq:
> 
> [...]
> 

