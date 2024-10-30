Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831D5D74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 02:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5y2r-0005zO-0r; Tue, 29 Oct 2024 22:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5y2j-0005yy-3K
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:02:43 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5y2U-0003Iy-9q
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 22:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730253747; x=1761789747;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Qjv+HswENlmONLqlkWunBSVpg0CP2VyAXvqK1Ycy0b4=;
 b=eIhiF5jSsH+xtliHM06p8g4vZRgLpFVTLL3zvTCnmqpQ6b9JY340pLgj
 zqmgEqXGWtGzeOpZ3RWRmQm56NyEMxtYpjMYyAYzLZZc2KPv2umDhgAyw
 A3q4MfF83rgomqK+MK0gkUouVJuxeiBai9eDiaE12zz+DcV0KLkhl2emN
 /+mpKZS4rUYGP7eZXW/Lb5lZ4y8Z9kwVdymNv3sHUKLFqVS8WLpFq6lfV
 TCGO2sI+O3skfbF8bcZPyMCYW2vecv8khfC/RvYjeSW+QWoXCaZZgzfRf
 O6sTqemX23+ENFgq9iuhKLNYRyvPD1vRocLvTB/5Qs6enSXIATZMqa3Oc g==;
X-CSE-ConnectionGUID: BnWOrrlCRJ+7qEojCQaMng==
X-CSE-MsgGUID: Apcl0hdCQqusBodZ1G3GxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30132449"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30132449"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 19:02:22 -0700
X-CSE-ConnectionGUID: Byjy0873QMW1sKBlP24Fag==
X-CSE-MsgGUID: dc0tX8yVT4CNFqENoq+e1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="81792975"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 29 Oct 2024 19:02:20 -0700
Date: Wed, 30 Oct 2024 10:18:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: maobibo <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 4/4] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
Message-ID: <ZyGXf93mWV9GOjue@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-5-maobibo@loongson.cn>
 <ZyDnpk3tmG4KECWc@intel.com>
 <ce111d21-7400-80c0-0984-ee2bc0286f40@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce111d21-7400-80c0-0984-ee2bc0286f40@loongson.cn>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > > @@ -1382,8 +1384,40 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > >        }
> > >       if (cpu->phy_id == UNSET_PHY_ID) {
> > > -        error_setg(&local_err, "CPU hotplug not supported");
> > > -        goto out;
> > > +        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
> > > +            error_setg(&local_err,
> > > +                       "Invalid thread-id %u specified, must be in range 1:%u",
> > > +                       cpu->thread_id, ms->smp.threads - 1);
> > > +            goto out;
> > > +        }
> > > +
> > > +        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
> > > +            error_setg(&local_err,
> > > +                       "Invalid core-id %u specified, must be in range 1:%u",
> > > +                       cpu->core_id, ms->smp.cores - 1);
> > > +            goto out;
> > > +        }
> > > +
> > > +        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
> > > +            error_setg(&local_err,
> > > +                       "Invalid socket-id %u specified, must be in range 1:%u",
> > > +                       cpu->socket_id, ms->smp.sockets - 1);
> > > +            goto out;
> > > +        }
> > > +
> > > +        topo.socket_id = cpu->socket_id;
> > > +        topo.core_id = cpu->core_id;
> > > +        topo.thread_id = cpu->thread_id;
> > > +        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
> > > +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
> > > +        if (CPU(cpu_slot->cpu)) {
> > > +            error_setg(&local_err,
> > > +                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
> > > +                       cs->cpu_index, cpu->socket_id, cpu->core_id,
> > > +                       cpu->thread_id, cpu_slot->arch_id);
> > > +            goto out;
> > > +        }
> > > +        cpu->phy_id = arch_id;
> > >       } else {
> > 
> > Here you allow user to specify topology IDs, but "else" still indicates
> > user could use "phy_id" instead of topology IDs, right?
> "else" for cold-plug CPUs which is created with index from [0 -- smp.cpus)
> 
> > 
> > Is it necessary to expose "phy_id" to user?
> We will remove phy_id property and unexpose it to user.
> 

Thanks! The issue lies with the property itself. Even if you try to
support a hotplug scheme based on topology IDs, users can actually use
phy_id for hotplugging. Removing it seems fine.

Regards,
Zhao


