Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2A7CF0444
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 05:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syPVu-000632-Bb; Wed, 09 Oct 2024 01:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syPVs-00062Y-Ll; Wed, 09 Oct 2024 01:45:32 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syPVp-0004TX-GL; Wed, 09 Oct 2024 01:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728452729; x=1759988729;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9pYDTK3HR96Un6CzOse/eSqGpHwAG/V7ph9HU0V5qWk=;
 b=OVgakQmADg4JKE/q8C2LgU4xfhuYq9wXCNtjlDr23FoaVLraY4Fo4LD2
 vFoQhYL/lH7QYxagh4YcwqTEcF3ham1uTudrvdGjJacvoZ/0vx4s55l0W
 Q/0Z1MeFZmFU2sPXAoxa4PCYtlt5+LfVAke5gj4ULJGsJM8KfapOQD9t5
 5fohdWaESLC6ElyRmlVYgUJB9jCeahlMXL4fAVBdAy/md+c7Yt67ZT9pY
 j6Db7ZY1oli+/7/RgN2b2EmS/u+2xKMuv8hIHH9EJBX/9bn5eFnkpduQ5
 d4rjIk36tHnAx75CojlNMLBDgZEyXtd6cqDfhTV0f+H/KfMWh+CSbd46x g==;
X-CSE-ConnectionGUID: 5ZmeBXKWRzGLDYb5WPtX0w==
X-CSE-MsgGUID: 3Z1djtM+RLeVJ2O2idWxvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27545684"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="27545684"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2024 22:45:24 -0700
X-CSE-ConnectionGUID: 3vUy2zWBQcSZlfFJZ2+OXQ==
X-CSE-MsgGUID: Vhs2SIyzQkyn0HaVgqI5jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="76446635"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 08 Oct 2024 22:45:18 -0700
Date: Wed, 9 Oct 2024 14:01:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC v2 00/12] Introduce Hybrid CPU Topology via Custom Topology
 Tree
Message-ID: <ZwYcOuZAt7qX5ci3@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
 <20241008113038.00007ee4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008113038.00007ee4@Huawei.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Hi Jonathan,

Thank you for looking at here!

On Tue, Oct 08, 2024 at 11:30:38AM +0100, Jonathan Cameron wrote:
> Date: Tue, 8 Oct 2024 11:30:38 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [RFC v2 00/12] Introduce Hybrid CPU Topology via Custom
>  Topology Tree
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Thu, 19 Sep 2024 14:11:16 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> 
> > -smp maxsockets=1,maxdies=1,maxmodules=2,maxcores=2,maxthreads=2
> > -machine pc,custom-topo=on \
> > -device cpu-socket,id=sock0 \
> > -device cpu-die,id=die0,bus=sock0 \
> > -device cpu-module,id=mod0,bus=die0 \
> > -device cpu-module,id=mod1,bus=die0 \
> > -device x86-intel-core,id=core0,bus=mod0 \
> > -device x86-intel-atom,id=core1,bus=mod1 \
> > -device x86-intel-atom,id=core2,bus=mod1 \
> > -device host-x86_64-cpu,id=cpu0,socket-id=0,die-id=0,module-id=0,core-id=0,thread-id=0 \
> > -device host-x86_64-cpu,id=cpu1,socket-id=0,die-id=0,module-id=0,core-id=0,thread-id=1 \
> > -device host-x86_64-cpu,id=cpu2,socket-id=0,die-id=0,module-id=1,core-id=0,thread-id=0 \
> > -device host-x86_64-cpu,id=cpu3,socket-id=0,die-id=0,module-id=1,core-id=1,thread-id=0
> 
> I quite like this as a way of doing the configuration but that needs
> some review from others.

Thanks!

> Peter, Alex, do you think this scheme is flexible enough to ultimately
> allow us to support this for arm? 

I was also hoping that being generic enough would benefit ARM.

> > 
> > This does not accommodate hybrid topologies. Therefore, we introduce
> > max* parameters: maxthreads/maxcores/maxmodules/maxdies/maxsockets
> > (for x86), to predefine the topology framework for the machine. These
> > parameters also constrain subsequent custom topologies, ensuring the
> > number of child devices under each parent device does not exceed the
> > specified max limits.
> 
> To my thinking this seems like a good solution even though it's a
> bunch more smp parameters.
> 
> What does this actually mean for hotplug of CPUs?  What cases work
> with this setup?

My solution for this does not change the current CPU hotplug, because the
current cpu hotplug only needs to consider smp.cpus and smp.maxcpus.

But when a cpu is plugged in, machine needs to make sure that plugging
into the core doesn't break the maxthreads limit. Similarly, if one wants
to support hotplugging at the socket/die/core granularity, he will need
to make sure that the new topology meets the limits set by the max
parameters, which are the equivalent of preemptively leaving some empty
holes that can be utilized by hotplug.

> > Therefore, once user wants to customize topology by "-machine
> > custom-topo=on", the machine, that supports custom topology, will skip
> > the default topology creation as well as the default CPU creation.
> 
> Seems sensible to me.

Thank you! Glad to have your support.

Regards,
Zhao


