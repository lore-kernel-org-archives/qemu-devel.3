Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604CFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVtc-0005Hr-EX; Tue, 04 Jun 2024 11:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEVtR-0005BM-Em; Tue, 04 Jun 2024 11:16:10 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEVtJ-0003VX-Tu; Tue, 04 Jun 2024 11:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717514162; x=1749050162;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=qXPxwp4Krxnak53hDhODVhsVAD6HPOWoEFdGvkvs9S0=;
 b=ITCDR9R/kixH+XcT0vbniTdIRW8kFDmoWFLKsSuYIS60lPmyPxmjhC5g
 jTbuyQzfos245Qqw1l/4P3WSLCrAKY+ml/TCCbSnfjy/HSLLCjTCmUeDC
 gQg7I+eM5+qtYtwdgTZu6giNRrwkdFfN9YzCsFvHlYt7SL9ghZlJYUd+j
 Gu1MR6Tgl0U+xzNsPwyKz39ZLHOmqhJaX/NMvJV3ZLQZuaOIgIg/sNm+9
 vx1H9+N6ktt9BCdUVgw+6YN4oe9w3XGtwDo79r+WdF4aY2jaWDrHHaRs2
 VaNzHMvQMYBDwmtDazuTP9sm3u68drMeZjW3ZsRWitaysNF0hBz5vvIEv w==;
X-CSE-ConnectionGUID: S50ujfx8Si+QFaaQmX2AGg==
X-CSE-MsgGUID: Ag4eX3cqTk6URpCssrFP2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25468255"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="25468255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 08:15:50 -0700
X-CSE-ConnectionGUID: zIy4auewSF6TmnhNZjiSLg==
X-CSE-MsgGUID: rDc0TgSUTsGt7J+8QTX8CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="42379247"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 04 Jun 2024 08:15:45 -0700
Date: Tue, 4 Jun 2024 23:31:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 0/7] Introduce SMP Cache Topology
Message-ID: <Zl8zP4pXjRmVs3VP@intel.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <Zl7ea2o2aaxXMj9X@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl7ea2o2aaxXMj9X@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Tue, Jun 04, 2024 at 10:29:15AM +0100, Daniel P. Berrang¨¦ wrote:
> Date: Tue, 4 Jun 2024 10:29:15 +0100
> From: "Daniel P. Berrang¨¦" <berrange@redhat.com>
> Subject: Re: [RFC v2 0/7] Introduce SMP Cache Topology
> 
> On Thu, May 30, 2024 at 06:15:32PM +0800, Zhao Liu wrote:
> > Hi,
> > 
> > Now that the i386 cache model has been able to define the topology
> > clearly, it's time to move on to discussing/advancing this feature about
> > configuring the cache topology with -smp as the following example:
> > 
> > -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
> >      l1d-cache=core,l1i-cache=core,l2-cache=core,l3-cache=die
> > 
> > With the new cache topology options ("l1d-cache", "l1i-cache",
> > "l2-cache" and "l3-cache"), we could adjust the cache topology via -smp.
> 
> Switching to QAPI for a second, your proposal is effectively
> 
>     { 'enum': 'SMPCacheTopo',
>       'data': [ 'default','socket','die','cluster','module','core','thread'] }
> 
>    { 'struct': 'SMPConfiguration',
>      'data': {
>        '*cpus': 'int',
>        '*drawers': 'int',
>        '*books': 'int',
>        '*sockets': 'int',
>        '*dies': 'int',
>        '*clusters': 'int',
>        '*modules': 'int',
>        '*cores': 'int',
>        '*threads': 'int',
>        '*maxcpus': 'int',
>        '*l1d-cache': 'SMPCacheTopo',
>        '*l1i-cache': 'SMPCacheTopo',
>        '*l2-cache': 'SMPCacheTopo',
>        '*l3-cache': 'SMPCacheTopo',
>      } }
> 
> I think that would be more natural to express as an array of structs
> thus:
> 
>     { 'enum': 'SMPCacheTopo',
>       'data': [ 'default','socket','die','cluster','module','core','thread'] }
> 
>     { 'enum': 'SMPCacheType',
>       'data': [ 'l1d', 'l1i', 'l2', 'l3' ] }
>      
>     { 'struct': 'SMPCache',
>       'data': {
>         'type': 'SMPCacheType',
>         'topo': 'SMPCacheTopo',
>       } }
> 
>    { 'struct': 'SMPConfiguration',
>      'data': {
>        '*cpus': 'int',
>        '*drawers': 'int',
>        '*books': 'int',
>        '*sockets': 'int',
>        '*dies': 'int',
>        '*clusters': 'int',
>        '*modules': 'int',
>        '*cores': 'int',
>        '*threads': 'int',
>        '*maxcpus': 'int',
>        'caches': [ 'SMPCache' ]
>      } }
> 
> Giving an example in (hypothetical) JSON cli syntax of:
> 
>   -smp  "{'cpus':32,'sockets':2,'dies':2,'modules':2,
>           'cores':2,'threads':2,'maxcpus':32,'caches': [
> 	    {'type':'l1d','topo':'core' },
> 	    {'type':'l1i','topo':'core' },
> 	    {'type':'l2','topo':'core' },
> 	    {'type':'l3','topo':'die' },
> 	  ]}"
 
Thanks! Looks clean to me and I think it is ok.

Just one further question, for this case where it must be expressed in a
raw JSON string, is there any requirement in QEMU that a simple
command-line friendly variant must be provided that corresponds to it?

> > Open about How to Handle the Default Options
> > ============================================
> > 
> > (For the detailed description of this series, pls skip this "long"
> > section and review the subsequent content.)
> > 
> > 
> > Background of OPEN
> > ------------------
> > 
> > Daniel and I discussed initial thoughts on cache topology, and there was
> > an idea that the default *cache_topo is on the CORE level [3]:
> > 
> > > simply preferring "cores" for everything is a reasonable
> > > default long term plan for everything, unless the specific
> > > architecture target has no concept of "cores".
> 
> FYI, when I wrote that I wasn't specifically thinking about cache
> mappings. I just meant that when exposing SMP topology to guests,
> 'cores' is a good default, compared to 'sockets', or 'threads',etc.
> 
> Defaults for cache <-> topology  mappings should be whatever makes
> most sense to the architecture target/cpu.

Thank you for the additional clarification!

> > Problem with this OPEN
> > ----------------------
> > 
> > Some arches have their own arch-specific cache topology, such as l1 per
> > core/l2 per core/l3 per die for i386. And as Jeehang proposed for
> > RISC-V, the cache topologies are like: l1/l2 per core and l3 per
> > cluster. 
> > 
> > Taking L3 as an example, logically there is a difference between the two
> > starting points of user-specified core level and with the default core
> > level.
> > 
> > For example,
> > 
> > "(user-specified) l3-cache-topo=core" should override i386's default l3
> > per core, but i386's default l3 per core should also override
> > "(default) l3-cache-topo=core" because this default value is like a
> > placeholder that specifies nothing.
> > 
> > However, from a command line parsing perspective, it's impossible to
> > tell what the ¡°l3-cache-topo=core¡± setting is for...
> 
> Yes, we need to explicitly distinguish built-in defaults from
> user specified data, otherwise we risk too many mistakes.
> 
> > Options to solve OPEN
> > ---------------------
> > 
> > So, I think we have the following options:
> > 
> > 
> > 1. Can we avoid such default parameters?
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This would reduce the pain in QEMU, but I'm not sure if it's possible to
> > make libvirt happy?
> 
> I think having an explicit "defualt" value is inevitable, not simply
> because of libvirt. Long experiance with QEMU shows that we need to
> be able to reliably distinguish direct user input from  built-in
> defaults in cases like this.

Thanks, that gives me an answer to that question!

> > 
> > It is also possible to expose Cache topology information as the CPU
> > properties in ¡°query-cpu-model-expansion type=full¡±, but that adds
> > arch-specific work.
> > 
> > If omitted, I think it's just like omitting ¡°cores¡±/¡°sockets¡±,
> > leaving it up to the machine to decide based on the specific CPU model
> > (and now the cache topology is indeed determined by the CPU model as
> > well).
> > 
> > 
> > 2. If default is required, can we use a specific abstract word?
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > That is, is it possible to use a specific word like ¡°auto¡±/¡°invalid¡±
> > /¡°default¡± and avoid a specific topology level?
> 
> "invalid" feels a bit wierd, but 'auto' or 'default' are fine,
> and possibly "unspecified"

I prefer the "default" like you listed in your QAPI example. :)

> > Like setting ¡°l3-cache-topo=invalid¡± (since I've only added the invalid
> > hierarchy so far ;-) ).
> > 
> > I found the cache topology of arches varies so much that I'm sorry to
> > say it's hard to have a uniform default cache topology.
> > 
> > 
> > I apologize for the very lengthy note and appreciate you reviewing it
> > here as well as your time!

Thanks,
Zhao


