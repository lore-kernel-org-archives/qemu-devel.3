Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C275BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri7uy-0006iV-09; Thu, 07 Mar 2024 02:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ri7uv-0006iF-VK
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:11:49 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ri7ut-00056i-FK
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709795507; x=1741331507;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ptKBtLmmCoH+PWXUbrSU9RR50cWuSb+9x8Ct9YMPEHM=;
 b=LGZTwM0jvwcxBBudpZhDy2HUPKBgYUWtU+PjDK+g1H785YUQd5wK4bFI
 GtuzelXuZDf8qBXrn5ek1HgJjdPgbQdiNT0Ss18HXDLvjKWAFyXohnUQr
 hlA9XUOBnACKAYN+oqzvOf0Z3TgB5n2ZnHq5VUSTfthUtOxWOgnXkr39B
 HjFFEOIwp5xC2anwTXaQL1nwZu2gIBPUi3t+VNuQJDBrAc1R0OHwn2aWQ
 5fcEvmvS44kboIBhwGwWFubsKaSs/5xWcgzD1k5x3yWByVyFVmqYemh5f
 ua9EMOFxAEjHaUTTsyyp0rfut0Aeix3M05KqF8Y7A1TvhIckXFkjWdW0R Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15171642"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="15171642"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 23:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="9924109"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 06 Mar 2024 23:11:39 -0800
Date: Thu, 7 Mar 2024 15:25:26 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 00/14] Cleanup on SMP and its test
Message-ID: <Zelr5qrMaP10hU6v@intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <91bf387d-0ca1-4812-a414-591f50151d14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bf387d-0ca1-4812-a414-591f50151d14@linaro.org>
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

Hi Philippe,

> In a previous community call, Zhao asked us how his work will scale
> in the heterogeneous context.
> 
> My first idea is CPUs must belong to a cluster.

Thank you for considering this!

At present, cluster is a arch-specific topology level used by ARM.
So maybe we need call this abstraction as another name not "cluster"?

I guess the cluster you mentioned is the cluster device used in TCG,
right? I also tried to eliminate differences between cluster devices
and the cluster level in CPU topology [1].

My previous proposal introduced a abstract topology device [2]. And all
topology specific levels are derived from the underlying topology
device, including CPU.

I feel like this topology device abstraction seems close to your idea,
am I understanding it correctly? ;-)

> For machines without
> explicit cluster, we could always create the first one. Then -smp
> would become a sugar property of the first cluster. Next -smp could
> also be sugar property of the next cluster.

Could you please explain the above ideas more?

It feels we need to split -smp for each cluster. But I'm not sure if
sugar property means defining smp-like properties for each cluster.

Or is there a command line example? ;-)

[1]: https://lore.kernel.org/qemu-devel/20231130144203.2307629-23-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20231130144203.2307629-9-zhao1.liu@linux.intel.com/

Thanks,
Zhao


