Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08C7C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezwA-0004yt-Vm; Tue, 27 Feb 2024 11:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rezw5-0004xN-VL; Tue, 27 Feb 2024 11:04:06 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rezw2-0002nH-1v; Tue, 27 Feb 2024 11:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709049842; x=1740585842;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=a4uC/JTyOpAvVrmW4y1AlyaBbiESaUUtpRpbAEFnTQE=;
 b=mFfgtmMM874wTXweIcoq28/xjPwPpeDs8m2H5V6NltzwgIpVZyZL95jB
 6ZDyCqSiga95kt6dxqoczPB022DmhVQBmW/UCoQWtiuZHRYGKTPB0HGyc
 8Z4KqpEL8YfSoTpJKzOPaZPrmR9Vc4KZLJX0C/366fxv/rwUC4jSSAYb8
 U7dG0oQE5DK3aTDUGuWGzCZzZz5w6tbNDLDTlaCnRp3Teqbet34LQ9qFZ
 tBAeVZEJBUxtPXSCWUOd2c7bU6YyyjCI+BfWViA/xDjxRGA22QGzSjpiZ
 AjnGKz465HWXIA5gDFNWSSkESqV4ysIRHK+JHokAKmPr19MdCitT1PZ/2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3561334"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3561334"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 08:03:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7049055"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 27 Feb 2024 08:03:44 -0800
Date: Wed, 28 Feb 2024 00:17:26 +0800
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
Subject: Re: [RFC 8/8] qemu-options: Add the cache topology description of -smp
Message-ID: <Zd4LFoegPx6EDfNy@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-9-zhao1.liu@linux.intel.com>
 <20240226154734.00000d6e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226154734.00000d6e@Huawei.com>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Mon, Feb 26, 2024 at 03:47:34PM +0000, Jonathan Cameron wrote:
> Date: Mon, 26 Feb 2024 15:47:34 +0000
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [RFC 8/8] qemu-options: Add the cache topology description of
>  -smp
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Tue, 20 Feb 2024 17:25:04 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi,
> 
> A trivial comment, but also a possibly more significant one about
> whether the defaults are correctly verified.
> 
> Jonathan
> > ---
> >  qemu-options.hx | 54 ++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 47 insertions(+), 7 deletions(-)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 70eaf3256685..85c78c99a3b0 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -281,7 +281,9 @@ ERST
> >  
> >  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> >      "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
> > -    "               [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
> > +    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
> > +    "               [,threads=threads][,l1d-cache=level][,l1i-cache=level][,l2-cache=level]\n"
> burns more characters but I'd go with
> l1d->cache=topo_level
> 
> As level for a cache has a totally different meaning!

Yes, good catch! Thanks.

> 
> > +    "               [,l3-cache=level]\n"
> >      "                set the number of initial CPUs to 'n' [default=1]\n"
> >      "                maxcpus= maximum number of total CPUs, including\n"
> >      "                offline CPUs for hotplug, etc\n"
> > @@ -290,9 +292,14 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> >      "                sockets= number of sockets in one book\n"
> >      "                dies= number of dies in one socket\n"
> >      "                clusters= number of clusters in one die\n"
> > -    "                cores= number of cores in one cluster\n"
> > +    "                modules= number of modules in one cluster\n"
> > +    "                cores= number of cores in one module\n"
> >      "                threads= number of threads in one core\n"
> > -    "Note: Different machines may have different subsets of the CPU topology\n"
> > +    "                l1d-cache= topology level of L1 D-cache\n"
> > +    "                l1i-cache= topology level of L1 I-cache\n"
> > +    "                l2-cache= topology level of L2 cache\n"
> > +    "                l3-cache= topology level of L3 cache\n"
> > +    "Note: Different machines may have different subsets of the CPU and cache topology\n"
> 
> >  
> >          -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32
> >  
> > +    The following sub-option defines a CPU topology hierarchy (2 sockets
> > +    totally on the machine, 2 dies per socket, 2 modules per die, 2 cores per
> > +    module, 2 threads per core) with 3-level cache topology hierarchy (L1
> > +    D-cache per core, L1 I-cache per core, L2 cache per core and L3 cache per
> > +    die) for PC machines which support sockets/dies/modules/cores/threads.
> > +    Some members of the CPU topology option can be omitted but their values
> > +    will be automatically computed. Some members of the cache topology
> > +    option can also be omitted and target CPU will use the default topology.:
> 
> Given the default could be inconsistent I wonder if we should 'push' levels
> up.  So if L2 not defined it is set either to default of equal to max of
> l1i and l1d level. L3 either default or same level as l2.

HMM, IIUC, I think there may be the case:

User sets L2 cache as per core and omits L3 cache. In this case, if L3
is per core (as L2) by default, how could we identify if that per core
L3 is the default or from user? We need to identify this becase x86's L3
is shared at die by default and L2 is shared at core level for current
CPU models.

To resolve this issue, we can add the status field in SMPCompatProps,
e.g., has_l3_cache, just like current SMPCompatProps.has_clusters, to
explicitly indicate that the L3 cache topo is set by user.

Then other caches also need the similar fields...It doesn't look as
simple as the current default invalid topology level.
 
> Won't always correspond to a sensible system so maybe just rejecting
> cases where default isn't possible is the best plan.  However I don't
> see that verification as the checks on higher levels are gated on them
> being specified.
> 
> > +
> > +    ::
> > +
> > +        -smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
> > +             l1d-cache=core,l1i-cache=core,l2-cache=core,l3-cache=die
> > +
> >      The following sub-option defines a CPU topology hierarchy (2 sockets
> >      totally on the machine, 2 clusters per socket, 2 cores per cluster,
> >      2 threads per core) for ARM virt machines which support sockets/clusters
> 

