Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DBAC27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPTC-0003u1-FD; Tue, 04 Jun 2024 04:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPTA-0003tN-JJ; Tue, 04 Jun 2024 04:24:36 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPT8-0007QM-DL; Tue, 04 Jun 2024 04:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717489475; x=1749025475;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=atOfj9kWdFuVI1HtcdHLArsthwrM8mfXmtw15855REQ=;
 b=kwMkh8Pzvk52J48JIs5cx4g3m+1WYQUGypPbUgcHQ314XwzSibxIRjeW
 aF9BQxVZdNmKzJFLKJdmhxiU6G6tpdzNMHIMdcKNN26Nz6Te6kLqxpMEb
 lBT5mNcogk71Npo5CsIs68At3Wn4oEFkRzQIwBshC6qr3gvay22+5ft1A
 vKI4M3vgkfuCsd8brkYgfW29ERhlyC5RRVWKBfw5ZAarBXEWwVLeqKC1w
 g8f/XlAjgDWBlzHHCd8nEFrr6P3A2N3r+nuKl30rfx5kYK2VI6j1PEBnb
 8JHgCvM6nA9SKmCZyeeatxZY9uTd0nFo5ddyxPOVaV5sEH+4IW5hiiEy0 Q==;
X-CSE-ConnectionGUID: XyfVJNAZRmOSkgLQ1H+mbA==
X-CSE-MsgGUID: a3+ME09QS3SFWrYHNd9KsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24644300"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24644300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:24:24 -0700
X-CSE-ConnectionGUID: zjJrKqpcS86f3Y2Vz9QwYA==
X-CSE-MsgGUID: jwlQwP8FTJCMn3VANeHNmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37152758"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 04 Jun 2024 01:24:19 -0700
Date: Tue, 4 Jun 2024 16:39:44 +0800
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
Message-ID: <Zl7S0IOlLvnua319@intel.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-2-zhao1.liu@intel.com>
 <87y17mfccp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y17mfccp.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

[snip]

> > +CPUTopoInfo cpu_topo_descriptors[] = {
> > +    [CPU_TOPO_LEVEL_INVALID] = { .name = "invalid", },
> > +    [CPU_TOPO_LEVEL_THREAD]  = { .name = "thread",  },
> > +    [CPU_TOPO_LEVEL_CORE]    = { .name = "core",    },
> > +    [CPU_TOPO_LEVEL_MODULE]  = { .name = "module",  },
> > +    [CPU_TOPO_LEVEL_CLUSTER] = { .name = "cluster", },
> > +    [CPU_TOPO_LEVEL_DIE]     = { .name = "die",     },
> > +    [CPU_TOPO_LEVEL_SOCKET]  = { .name = "socket",  },
> > +    [CPU_TOPO_LEVEL_BOOK]    = { .name = "book",    },
> > +    [CPU_TOPO_LEVEL_DRAWER]  = { .name = "drawer",  },
> > +    [CPU_TOPO_LEVEL__MAX]    = { .name = NULL,      },
> > +};
> 
> This looks redundant with generated
> 
>     const QEnumLookup CPUTopoLevel_lookup = {
>         .array = (const char *const[]) {
>             [CPU_TOPO_LEVEL_INVALID] = "invalid",
>             [CPU_TOPO_LEVEL_THREAD] = "thread",
>             [CPU_TOPO_LEVEL_CORE] = "core",
>             [CPU_TOPO_LEVEL_MODULE] = "module",
>             [CPU_TOPO_LEVEL_CLUSTER] = "cluster",
>             [CPU_TOPO_LEVEL_DIE] = "die",
>             [CPU_TOPO_LEVEL_SOCKET] = "socket",
>             [CPU_TOPO_LEVEL_BOOK] = "book",
>             [CPU_TOPO_LEVEL_DRAWER] = "drawer",
>         },
>         .size = CPU_TOPO_LEVEL__MAX
>     };
> 
> > +
> > +const char *cpu_topo_to_string(CPUTopoLevel topo)
> > +{
> > +    return cpu_topo_descriptors[topo].name;
> > +}
> 
> And this with generated CPUTopoLevel_str().

Thanks! I missed these generated helpers.

[snip]

> > +##
> > +# @CPUTopoLevel:
> > +#
> > +# An enumeration of CPU topology levels.
> > +#
> > +# @invalid: Invalid topology level, used as a placeholder.
> 
> Placeholder for what?

I was trying to express that when no specific topology level is
specified, it will be initialized to this value by default.

Or what about just deleting this placeholder related words and just
saying it's "Invalid topology level"?

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
> As far as I can tell, -smp is sugar for machine property "smp" of QAPI
> type SMPConfiguration.  Should we refer to SMPConfiguration instead of
> -smp?

Yes, SMPConfiguration is better.

Thanks,
Zhao


