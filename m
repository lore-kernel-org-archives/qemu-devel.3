Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5223BC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPNU-0000vW-1Q; Tue, 04 Jun 2024 04:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPNP-0000tU-4I; Tue, 04 Jun 2024 04:18:39 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPNL-00052X-S4; Tue, 04 Jun 2024 04:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717489115; x=1749025115;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T6qZEH63FFuFYtelDyLGAv9Vpeeu3+M490fJp4SljgU=;
 b=Sd1gEadi/uqTkSbNqvbRA2dwAX1TVE37S5g+ZoB/3oWjwpUBHLxgZJsQ
 vB0SB6rXwMlxotSSvTG9w9KWcc15I2TsYMtQkH9RHDzqpUYnnxzAc4KRq
 b4tw3XmySCQxNkyAaxBw8qH7Bv7kKG7zP6kuH8Th4TuSTmB8a7Gwkie9B
 ZHv3zgRGr4DtbO1rqjv1+LgaSGOK06+y1W0w3T+mU2lZtwezQWFP7yaGh
 z/7akQv2s4X/apu6RiNAEg3s5vjvKnAStCUDLW9/nIam6n8OsKUsQrdfX
 rmDO47y0/dar93lvV6XeVL5+DmKD60S1aa2DiLD4qe4AU/9tsl5SR/k4G Q==;
X-CSE-ConnectionGUID: E3/hs+3PSP2+a0XmXaLrRQ==
X-CSE-MsgGUID: uC8B2BYsSAC4jeBG0dhSQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31518826"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="31518826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:18:27 -0700
X-CSE-ConnectionGUID: ZLkK9vr3Qi6T22a7gQdEpw==
X-CSE-MsgGUID: WIUIwbV2QBChE1vi6Mj3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37027956"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 01:18:22 -0700
Date: Tue, 4 Jun 2024 16:33:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
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
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 1/7] hw/core: Make CPU topology enumeration arch-agnostic
Message-ID: <Zl7RbLrYUN0cg+t4@intel.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-2-zhao1.liu@intel.com>
 <87plsyfc1r.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plsyfc1r.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Markus,

On Mon, Jun 03, 2024 at 02:25:36PM +0200, Markus Armbruster wrote:
> Date: Mon, 03 Jun 2024 14:25:36 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [RFC v2 1/7] hw/core: Make CPU topology enumeration
>  arch-agnostic
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Cache topology needs to be defined based on CPU topology levels. Thus,
> > define CPU topology enumeration in qapi/machine.json to make it generic
> > for all architectures.
> >
> > To match the general topology naming style, rename CPU_TOPO_LEVEL_SMT
> > and CPU_TOPO_LEVEL_PACKAGE to CPU_TOPO_LEVEL_THREAD and
> > CPU_TOPO_LEVEL_SOCKET.
> >
> > Also, enumerate additional topology levels for non-i386 arches, and add
> > helpers for topology enumeration and string conversion.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> [...]
> 
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index bce6e1bbc412..7ac5a05bb9c9 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1667,6 +1667,46 @@
> >       '*reboot-timeout': 'int',
> >       '*strict': 'bool' } }
> >  
> > +##
> > +# @CPUTopoLevel:
> 
> I understand you're moving existing enum CPUTopoLevel into the QAPI
> schema.  I think the idiomatic QAPI name would be CpuTopologyLevel.
> Would you be willing to rename it, or would that be too much churn?

Sure, I'll rename it as you suggested.

> > +#
> > +# An enumeration of CPU topology levels.
> > +#
> > +# @invalid: Invalid topology level, used as a placeholder.
> > +#
> > +# @thread: thread level, which would also be called SMT level or logical
> > +#     processor level. The @threads option in -smp is used to configure
> > +#     the topology of this level.
> > +#
> > +# @core: core level. The @cores option in -smp is used to configure the
> > +#     topology of this level.
> > +#
> > +# @module: module level. The @modules option in -smp is used to
> > +#     configure the topology of this level.
> > +#
> > +# @cluster: cluster level. The @clusters option in -smp is used to
> > +#     configure the topology of this level.
> > +#
> > +# @die: die level. The @dies option in -smp is used to configure the
> > +#     topology of this level.
> > +#
> > +# @socket: socket level, which would also be called package level. The
> > +#     @sockets option in -smp is used to configure the topology of this
> > +#     level.
> > +#
> > +# @book: book level. The @books option in -smp is used to configure the
> > +#     topology of this level.
> > +#
> > +# @drawer: drawer level. The @drawers option in -smp is used to
> > +#     configure the topology of this level.
> 
> docs/devel/qapi-code-gen.rst section Documentation markup:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.

Thank you for pointing this.

About separating sentences, is this what I should be doing?

# @drawer: drawer level. The @drawers option in -smp is used to
#  configure the topology of this level.


Thanks,
Zhao


