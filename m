Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DAC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taw83-0000hg-Se; Thu, 23 Jan 2025 07:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taw7z-0000h7-Un
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:16:09 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taw7t-0004Um-Td
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737634562; x=1769170562;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=A2aDYVUQqHAaAe3UaECybRTVcaS8f/aCgOyW4U8w0CQ=;
 b=GzxgGc1hQ0snL4yVPgGhWLTrSkNQYctt8Nagb7in23HaH/cYKzld7VCi
 L6DWBYpruV1L92DdiX2rLKMp9KVDCYfu3YgMqrEISkEeDSYlFcCgiIkPu
 ySnwZm8/4vJz+I3SJRxni6XWKwP2qyFJMYOMgp0W+ARvLDHYiUrbQECGO
 LYLfKubjikvvISJKBAXwRTUWpnSuVJd3byhUJaQjxnxNA8QKebSKhCGvu
 i63e+PJCkl4g01cjL60ol1MG8eR8Xn39HPlf4HimGQOwE3ttrsO6/EARk
 Na8Y15PHNHyzbNPF+4kGi3YL1QeY75vP/gB+LidAhm90WJH5jo6oo6HRO A==;
X-CSE-ConnectionGUID: 4OxnoJRIQR299OHGVa0zbQ==
X-CSE-MsgGUID: YXayvzwmQOqmzQD+SFrEWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49118966"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="49118966"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 04:15:57 -0800
X-CSE-ConnectionGUID: nI9My7QIQiawHnT9FZ5iSg==
X-CSE-MsgGUID: 7oBx1iAcRhWsrIDEuU+mWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107288706"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 23 Jan 2025 04:15:55 -0800
Date: Thu, 23 Jan 2025 20:35:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <Z5I3hkmDtb6thaK3@intel.com>
References: <20250123115613.1537173-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123115613.1537173-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

>  hw/i386/microvm.c     |  3 +-
>  hw/i386/pc.c          | 14 +++++++++
>  hw/i386/pc_piix.c     |  6 ++--
>  hw/i386/pc_q35.c      |  6 ++--
>  hw/i386/x86-common.c  |  4 +--
>  include/hw/i386/pc.h  |  7 +++--
>  include/hw/i386/x86.h |  2 +-
>  target/i386/cpu.c     | 69 ++++++++++++++++++++++---------------------
>  target/i386/cpu.h     | 21 +++----------
>  9 files changed, 67 insertions(+), 65 deletions(-)
> 
> changelog:
> v2: explain in commit log why use of CPU_VERSION_LATEST for machines
> is problematic.
> v3: fix a bug that broke the pipeline
> https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
> when cpu versions are explicitly specified in the command line,
> respect that and do not enforce legacy (unversioned) cpu logic.
> The pipeline is green now with the fix:
> https://gitlab.com/anisinha/qemu/-/pipelines/1626783632
> v4: made changes as per Zhao's suggestions.
> Pipeline passes https://gitlab.com/anisinha/qemu/-/pipelines/1635829877
> v5: adjustment of pc_init_cpus() declaration as per Zhao's suggestion. This
> simplifies things and also passes compilation.
> CI still passes https://gitlab.com/anisinha/qemu/-/pipelines/1637657451

v5 is fine for me, so

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Let's see if anyone else has comments.


