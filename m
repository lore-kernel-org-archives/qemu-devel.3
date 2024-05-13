Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87725C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WLm-0005VD-Kk; Mon, 13 May 2024 10:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6WLl-0005V5-N2
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:08:21 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6WLf-0006IQ-Md
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715609296; x=1747145296;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WsU0YTZZ6yJOQ7T5hG4osWxzTIYWzDTn0bE+/jzR/ss=;
 b=iB7TXu2lRKhOW4vmPZAktn9z0S9CrJ4X5hjUq/WJPzvTvehKrTWtIg6T
 eZN7WLFNhwVK53ytUTCy+66PSkNlYuoinpEykFgMCrA//Zk6/4SE4nEmT
 1fb3vvnRdKwe9GiCV3cUoWvHAc+bIJypTpHylZlly9K8O4RV0NVQawMwf
 dCCsfzQk17GbfrFgg9ZMFl/HnXZV/789Sbx11LmyW3s6sxsDWabmB7MMR
 6ES2XXgouUqxU4C+eV6n5ervkR9c7cz3oPlJNadej0/k7YMQTopw4JkpF
 Yvddc5lplGcePdGytQA4skdzGJHKTQjj/6UAyHCpGWtNu6fTOztfZ8s8T w==;
X-CSE-ConnectionGUID: dIQF/j2kSP2dDPtPyZ/A2g==
X-CSE-MsgGUID: zraL+047SYK1EPk2vApp4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="22949772"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="22949772"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 07:08:10 -0700
X-CSE-ConnectionGUID: m2XnHfnKSPm6rrgaPm9rew==
X-CSE-MsgGUID: 5kSCVEiiRraP6rafsZNWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="30299320"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 13 May 2024 07:08:07 -0700
Date: Mon, 13 May 2024 22:22:22 +0800
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
Message-ID: <ZkIiHgw9rQActD2i@intel.com>
References: <20240513123358.612355-1-berrange@redhat.com>
 <20240513123358.612355-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513123358.612355-2-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Cc Paolo for x86 topology part

Hi Daniel,

On Mon, May 13, 2024 at 01:33:57PM +0100, Daniel P. Berrangé wrote:
> Date: Mon, 13 May 2024 13:33:57 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH 1/2] hw/core: allow parameter=1 for SMP topology on any
>  machine
> 
> This effectively reverts
> 
>   commit 54c4ea8f3ae614054079395842128a856a73dbf9
>   Author: Zhao Liu <zhao1.liu@intel.com>
>   Date:   Sat Mar 9 00:01:37 2024 +0800
> 
>     hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP configurations
> 
> but is not done as a 'git revert' since the part of the changes to the
> file hw/core/machine-smp.c which add 'has_XXX' checks remain desirable.
> Furthermore, we have to tweak the subsequently added unit test to
> account for differing warning message.
> 
> The rationale for the original deprecation was:
> 
>   "Currently, it was allowed for users to specify the unsupported
>    topology parameter as "1". For example, x86 PC machine doesn't
>    support drawer/book/cluster topology levels, but user could specify
>    "-smp drawers=1,books=1,clusters=1".
> 
>    This is meaningless and confusing, so that the support for this kind
>    of configurations is marked deprecated since 9.0."
> 
> There are varying POVs on the topic of 'unsupported' topology levels.
> 
> It is common to say that on a system without hyperthreading, that there
> is always 1 thread. Likewise when new CPUs introduced a concept of
> multiple "dies', it was reasonable to say that all historical CPUs
> before that implicitly had 1 'die'. Likewise for the more recently
> introduced 'modules' and 'clusters' parameter'. From this POV, it is
> valid to set 'parameter=1' on the -smp command line for any machine,
> only a value > 1 is strictly an error condition.

Currently QEMU has become more and more difficult to maintain a general
topology hierarchy, there are two recent examples:

1. as you mentioned "module" v.s. "cluster", one reason for introducing
"module" is because it is difficult to define what "cluster" is for x86,
the cluster in the device tree can be nested, then it can correspond to
an x86 die, or it can correspond to an x86 module. Therefore, specifying
"clusters=1" for x86 is ambiguous.

2. s390 introduces book and drawer, which are above socket/package
level, but for x86, the level above the package names "cluster" (yeah,
"cluster" again :-(). So if user sets "books=1" or "drawers=1" for x86,
then it's meaningless. Similarly, "clusters=1" is also very confusing for
x86 machine.

I think that only thread/core/socket are architecturally general, the
other topology levels are hard to define across architectures, then
allowing unsupported topology=1 is always confusing...

Moreover, QEMU currently requires a clear topology containment
relationship when defining a topology, after which it will become
increasingly difficult to define a generic topology containment
relationship when new topology levels are introduced in the future...

> It doesn't cause any functional difficulty for QEMU, because internally
> the QEMU code is itself assuming that all "unsupported" parameters
> implicitly have a value of '1'.
> 
> At the libvirt level, we've allowed applications to set 'parameter=1'
> when configuring a guest, and pass that through to QEMU.
> 
> Deprecating this creates extra difficulty for because there's no info
> exposed from QEMU about which machine types "support" which parameters.
> Thus, libvirt can't know whether it is valid to pass 'parameter=1' for
> a given machine type, or whether it will trigger deprecation messages.

I understand that libvirt is having trouble because there is no interface
to expose which topology levels the current machine supports. As a
workaround to eliminate the difficulties at the libvirt level, it's
ok for me.

But I believe deprecating the unsupported topology is necessary, so do
you think it's acceptable to include an interface to expose the supported
topology if it's going to be deprecated again later?

Regards,
Zhao


