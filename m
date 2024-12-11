Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29059E7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLCWS-0001QM-8a; Tue, 10 Dec 2024 21:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLCWN-0001Q8-Px
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:32:15 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLCWL-0003eo-Iw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733884333; x=1765420333;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qo3WvSNNEiH5rlzR0eOyduxBtXFY8hdFTDsVEJzvgUo=;
 b=OOy2PFjWXicTLhjLeKZ0Y43fZ1JkJHxEnddN2xWRVfFU22CSvzfI1sHT
 1ZyUTWBOhx6uL5U+jhO1h1stH2o/4mERMgRI2Z2lU+pF6iV1v+NuQ4oQK
 XdY/BlEWFKKBMstgsTSOlQbRZig5xN+hnSu4Gpp1ClJYlITg9sf2Xz7g9
 qn6+PXaCZvfg+ESJs2zsE03d1L65ZlqXmAC5roqGs3dswuV2YYm9lZW0G
 KUbO5Ld+7516S7DAe4s3CWEKbSxim41P0MePixw3zi0YydSdxBpJA6fam
 /tZ7ML0FTcCRPKvUxsqp9P+6zX3ypO7veewhmbyf5zRoHH5yBJZ9RB0P2 g==;
X-CSE-ConnectionGUID: 6OIgTggYQwivzMDib+X9oQ==
X-CSE-MsgGUID: jFPzX6yBTg+yWrBB9X0XKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56730283"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="56730283"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 18:32:09 -0800
X-CSE-ConnectionGUID: DEQ99AOTSHyVL6JflpY4GA==
X-CSE-MsgGUID: iEQ2RCzQRPq22m8odfE4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="100672187"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 10 Dec 2024 18:32:06 -0800
Date: Wed, 11 Dec 2024 10:50:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
Message-ID: <Z1j97K+xpgIp6sYc@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-4-xiaoyao.li@intel.com>
 <20241210174338.0fb05ecf@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210174338.0fb05ecf@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Tue, Dec 10, 2024 at 05:43:38PM +0100, Igor Mammedov wrote:
> Date: Tue, 10 Dec 2024 17:43:38 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
> 
> On Thu,  5 Dec 2024 09:57:15 -0500
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
> > x86 is the only user of CPUState::nr_cores.
> > 
> > Define cores_per_module in CPUX86State, which can serve as the
> > substitute of CPUState::nr_cores. After x86 switches to use
> > CPUX86State::cores_per_module, CPUState::nr_cores will lose the only
> > user and QEMU can drop it.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >  hw/i386/x86-common.c | 2 ++
> >  target/i386/cpu.c    | 2 +-
> >  target/i386/cpu.h    | 9 +++++++--
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > index dc031af66217..f7a20c1da30c 100644
> > --- a/hw/i386/x86-common.c
> > +++ b/hw/i386/x86-common.c
> > @@ -271,6 +271,8 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >  
> >      init_topo_info(&topo_info, x86ms);
> >  
> > +    env->nr_cores = ms->smp.cores;
> this doesn't look like the same as in qemu_init_vcpu(),
> which uses machine_topo_get_cores_per_socket()
> Can you clarify the change?

I think Xiaoyao is correct here. CPUState.nr_cores means number of cores
in socket, and current CPUX86State.nr_cores means number of cores per
module (or parent container) ...though they have same name. (It's better
to mention the such difference in commit message.)

However, I also think that names like nr_cores or nr_* are prone to
errors. Names like cores_per_module are clearer, similar to the naming
in X86CPUTopoInfo. This might be an opportunity to clean up the current
nr_* naming convention.

And further, we can directly cache two additional items in CPUX86State:
threads_per_pkg and cores_per_pkg, as these are the most common
calculations and can help avoid missing any topology levels.

I think both of these changes can be made on top of the current series.

@xiaoyao, do you agree?

Regards,
Zhao


