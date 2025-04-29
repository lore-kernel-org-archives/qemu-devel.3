Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67890C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hak-0005rb-Bn; Tue, 29 Apr 2025 05:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hai-0005rH-96
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:49:28 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hag-0000lt-H6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920166; x=1777456166;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oZpTia+6XVj/h1OeoJNYOvffFVIEw3X2QsDQsE0c8CA=;
 b=XRYApE4Dv2fVVOHZSANp9zgSa/UrNHNfpmt1s2zlsqd41Wa8kwTBgX27
 pg3FUkxITsD28rL1q3IP4jrI3TJsrfrhIARQTdXi6k+lYD36Tk8wSwgWo
 xYuXeCJA1ji200FBSszfzRHd4Q4uA/ZHWPJHlM9SoQQ5M62Y0vCayry+M
 gOgtUHJund/9aXfTXmIC5QJ1LFVjdaSTw86y6mozh7/R35xGaOYxDxevy
 lf78DmwQMuub932TnmF5jDn9hbLbkVimD6oCfLZ3hTtX1x2c/5PD9yyea
 XGhJjL9x2JDM99bYtGSqXvU+FfVmchsDUnbVirWzbj3V3d0a84ZdJBbVO g==;
X-CSE-ConnectionGUID: Fth703dsTX+rELEgv/MjrQ==
X-CSE-MsgGUID: gvboBmWtTzKMRYIsAnykFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="46652498"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="46652498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 02:49:24 -0700
X-CSE-ConnectionGUID: LFG5Ey7PQqagNe0Zmm0vwQ==
X-CSE-MsgGUID: tV0vLvAUQyOvHYaD4/jxGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133677679"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 29 Apr 2025 02:49:21 -0700
Date: Tue, 29 Apr 2025 18:10:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 33/55] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <aBClilnva6J+WjkT@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-34-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-34-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:43AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:43 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 33/55] i386/cpu: Introduce enable_cpuid_0x1f to force
>  exposing CPUID 0x1f
> X-Mailer: git-send-email 2.34.1
> 
> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> module level, are configured for the guest, e.g., -smp xx,dies=2.
> 
> However, TDX architecture forces to require CPUID 0x1f to configure CPU
> topology.
> 
> Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
> requires CPUID leaf 0x1f to be exposed to guest.
> 
> Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of

s/warpper/wrapper/

(found by "scripts/checkpatch.pl --codespell *" :-))

> cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
> to enable cpuid leaf 0x1f for the guest.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c     | 4 ++--
>  target/i386/cpu.h     | 9 +++++++++
>  target/i386/kvm/kvm.c | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


