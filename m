Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC9EC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 03:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6iwz-0004HI-2c; Mon, 13 May 2024 23:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6iwx-0004Gz-5G
 for qemu-devel@nongnu.org; Mon, 13 May 2024 23:35:35 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6iwu-00052i-As
 for qemu-devel@nongnu.org; Mon, 13 May 2024 23:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715657733; x=1747193733;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=V98KEBMDOvT70rQXiLzqpbs0p+Ri6YYSaNBO5yPAS/E=;
 b=KEtvW81xi22dwJgbIomfdY9Dfa9gd/vZf/+Scwc/3piyiYbapPtBSRtk
 sFv4HOy1wxZQNzcOFCTQAtWtBbPapX8fZ9pys9pHrTeDJh1Sxzm3H+crW
 JSAwbElwvpt6LPFH7iPt24rWwoA9fw4Z7Wriq3iqRJLHZyCOMJXRGirAn
 LvYPl8w873sXgfC49elg79d6twDLdJVfy3manW4EkCnipE5rYEh/EGYoJ
 JuKPBpnoZR5EQi10UrnpnauMmf5Cq9jUs+xUUFx5zHp/4knNed1Xk6wTz
 Ti/8I5XbQLahslTRvXJ7QSfT7yIArhK4ZmVM9k5y3vw92G5yEuQS+1ihK A==;
X-CSE-ConnectionGUID: LPJPf3dkSRiW7ZCMypnGAQ==
X-CSE-MsgGUID: eVUo4kkDRam3wzHRBC8UxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11742023"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11742023"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 20:35:28 -0700
X-CSE-ConnectionGUID: VMjzXCr5QYSIdjloKW8Hkg==
X-CSE-MsgGUID: T5F7s2mdTAa02LzXUnRgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="30663911"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 13 May 2024 20:35:25 -0700
Date: Tue, 14 May 2024 11:49:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
 machine
Message-ID: <ZkLfVB/1arSlAptC@intel.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-2-berrange@redhat.com>
 <ZkIiHgw9rQActD2i@intel.com> <ZkImOkl-HtsFMaAz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkImOkl-HtsFMaAz@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> I'm failing to see what real world technical problems QEMU faces
> with a parameter being set to '1' by a mgmt app, when QEMU itself
> treats all omitted values as being '1' anyway.
> 
> If we're trying to faithfully model the real world, then restricting
> the topology against machine types though still looks inherantly wrong.
> The valid topology ought to be constrained based on the named CPU model.
> eg it doesn't make sense to allow 'dies=4' with a Skylake CPU model,
> only an EPYC CPU model, especially if we want to model cache info in
> a way that matches the real world silicon better.

Thanks for figuring out this. This issue is related with Intel CPU
cache model: currently Intel code defaults L3 shared at die level.
This could be resolved by defining the accurate default cache topology
level for CPU model and make Intel CPU models share L3 at package level
except only Cascadelake.

Then user could define any other topology levels (die/module) for
Icelake and this won't change the cache topology, unless the user adds
more sockets or further customizes the cache topology in another way [1].
Do you agree with this solution?

[1]: https://lore.kernel.org/qemu-devel/20240220092504.726064-1-zhao1.liu@linux.intel.com/

[snip]

> As above, I think that restrictions based on machine type, while nice and
> simple, are incorrect long term. If we did impose restrictions based on
> CPU model, then we could trivially expose this info to mgmt apps via the
> existing mechanism for querying supported CPU models. Limiting based on
> CPU model, however, has potentially greater back compat issues, though
> it would be strictly more faithful to hardware.

I think as long as the default cache topology model is clearly defined,
users can further customize the CPU topology and adjust the cache
topology based on it. After all, topology is architectural, not CPU
model-specific (linux support for topology does not take into account
specific CPU models).

For example, x86, for simplicity, can we assume that all x86 CPU models
support all x86 topology levels (thread/core/module/die/package) without
making distinctions based on specific CPU models?

That way as long as the user doesn't change the default topology, then
Guest's cache and other topology information won't be "corrupted".

And there's one more question, does this rollback mean that smp's
parameters must have compatible default values for all architectures?

This is related with my SMP cache proposal above [1], should I provide
default entries (e.g. default) to be compatible with all architectures,
even if they don't support custom cache topology? Like the following:

-smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
     l1d-cache=default,l1i-cache=default,l2-cache=default,l3-cache=default

Thanks,
Zhao


