Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47591E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQHOY-0003KX-PW; Tue, 24 Dec 2024 21:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQHOW-0003Jp-R4
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:45:09 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQHOU-0001EI-3A
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735094706; x=1766630706;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5g8PCM2Z3gR7kKn4nqZKcBYpI8Dq7vpqMSZn8azuTKk=;
 b=FeO7Eta4DyFFWvMoCA3m5tB9z/rK5EZp9umpkc9wWOoQ7rigdsRDIAMM
 55AcIOUZ0zCtFArfv8FyMpS6YJtj/SHlFwQRYkiqwQ1S3ax/w9CfYHUSp
 3u6U/Ks0ntuxYyjwrvspAwgyIGOD9TXJ2JODhzZIvUNAkAmF2xVz8qb+K
 WgEU2K+fuhOG/ZD91RQl9FgB6C3Iwzwm3Q1kBlAIDZE/GJjnjo97mt6+f
 vAuta8FU6pkirAf/JMwY2CRaSF1GswfDu0flVBZnLHFt3yz/bkqjmp/oC
 XPf08M5LsauGuUM7b7f7l4fcbE87jhHhG1vHn7suUnYqcC1AuXqCqBmG4 Q==;
X-CSE-ConnectionGUID: 9SGJYVNIS3SlDT5WLvet7w==
X-CSE-MsgGUID: bWhmpTN9TbGex4fkuOOXuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="52958760"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; d="scan'208";a="52958760"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 18:45:03 -0800
X-CSE-ConnectionGUID: KURgmDzqSqq9HQYiFviMKA==
X-CSE-MsgGUID: uJFQ+NROSbyRcG0TWq0/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="104700387"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 24 Dec 2024 18:45:00 -0800
Date: Wed, 25 Dec 2024 11:03:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
Message-ID: <Z2t2DuMBYb2mioB0@intel.com>
References: <20241219083237.265419-1-zhao1.liu@intel.com>
 <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > About smp-cache
> > ===============
> > 
> > The API design has been discussed heavily in [3].
> > 
> > Now, smp-cache is implemented as a array integrated in -machine. Though
> > -machine currently can't support JSON format, this is the one of the
> > directions of future.
> > 
> > An example is as follows:
> > 
> > smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die
> > 
> > "cache" specifies the cache that the properties will be applied on. This
> > field is the combination of cache level and cache type. Now it supports
> > "l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
> > cache) and "l3" (L3 unified cache).
> > 
> > "topology" field accepts CPU topology levels including "thread", "core",
> > "module", "cluster", "die", "socket", "book", "drawer" and a special
> > value "default".
> 
> Looks good; just one thing, does "thread" make sense?  I think that it's
> almost by definition that threads within a core share all caches, but maybe
> I'm missing some hardware configurations.

Hi Paolo, merry Christmas. Yes, AFAIK, there's no hardware has thread
level cache.

I considered the thread case is that it could be used for vCPU
scheduling optimization (although I haven't rigorously tested the actual
impact). Without CPU affinity, tasks in Linux are generally distributed
evenly across different cores (for example, vCPU0 on Core 0, vCPU1 on
Core 1). In this case, the thread-level cache settings are closer to the
actual situation, with vCPU0 occupying the L1/L2 of Host core0 and vCPU1
occupying the L1/L2 of Host core1.


  ©°©¤©¤©¤©´        ©°©¤©¤©¤©´
  vCPU0        vCPU1
  ©¦   ©¦        ©¦   ©¦
  ©¸©¤©¤©¤©¼        ©¸©¤©¤©¤©¼
 ©°©°©¤©¤©¤©´©°©¤©¤©¤©´©´ ©°©°©¤©¤©¤©´©°©¤©¤©¤©´©´
 ©¦©¦T0 ©¦©¦T1 ©¦©¦ ©¦©¦T2 ©¦©¦T3 ©¦©¦
 ©¦©¸©¤©¤©¤©¼©¸©¤©¤©¤©¼©¦ ©¦©¸©¤©¤©¤©¼©¸©¤©¤©¤©¼©¦
 ©¸©¤©¤©¤©¤C0©¤©¤©¤©¤©¼ ©¸©¤©¤©¤©¤C1©¤©¤©¤©¤©¼


The L2 cache topology affects performance, and cluster-aware scheduling
feature in the Linux kernel will try to schedule tasks on the same L2
cache. So, in cases like the figure above, setting the L2 cache to be
per thread should, in principle, be better.

Thanks,
Zhao


