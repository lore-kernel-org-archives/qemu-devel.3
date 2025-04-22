Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A211BC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Eh5-0004N9-5H; Tue, 22 Apr 2025 10:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Eh3-0004Mv-K5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:33:49 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Eh0-0002NT-Pl
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745332426; x=1776868426;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=p7s1My4NKygGrdOUrBRFtw5eXLITEiMGyiUbmIhV8Gk=;
 b=SUwVrrUoFOR8i1WhvNAcWyJGj73HoB/ATv3m95ABRQlUYozcpy/AglS8
 6j1S8r5d7YkK7svoJgioGzWVgjt341cr6sqOIUhorcbPHjE5jIX3Tnfte
 KfStmhC/ilWQRVLq/ggzulaGhGnlzI3iAhuXSqaNUIhj8o6GhHZ/Qt99l
 OQ5XAmgh+sWVDkhlMPQVTUkH/EWOnisWCQXcxGU8GoPUG/63sObAvSjAv
 njFsgr9fyD9iAzpBTQv7kNuCLB4QAoPFj2/SA14QmALRfmKD5dcY66hMx
 W/LyV4p93A0heIyL1P8ayiDhsM+SVzeMNTMpNNHBYVlRwx4NjiOxSnRQT w==;
X-CSE-ConnectionGUID: /ozmmTNJRGC6Yn1hQDj3cQ==
X-CSE-MsgGUID: QSq5uY4vQYSxWy44akugBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57083890"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="57083890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:33:43 -0700
X-CSE-ConnectionGUID: P0yWJhoASN+PklBJIKvyDA==
X-CSE-MsgGUID: xfSBkJY9TeaKK9Ngwj4qVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="131873962"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 22 Apr 2025 07:33:40 -0700
Date: Tue, 22 Apr 2025 22:54:35 +0800
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
Subject: Re: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <aAetq2ZgqaRHmdPm@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-9-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-9-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On Tue, Apr 01, 2025 at 09:01:18AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:18 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
> X-Mailer: git-send-email 2.34.1
> 
> Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
> KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
> CPUID config, and must be executed prior to creating vCPUs.
> 
> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
> 
> Note, this doesn't address the fact that QEMU may change the CPUID
> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
> provide a stable CPUID config prior to kvm_arch_init().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes in v8:
> - Drop the code that initializes cpu->kvm_state before
>   kvm_arch_pre_create_vcpu() because it's not needed anymore.
> 
> Changes in v7:
> - Add comments to explain why KVM_TDX_INIT_VM should retry on -EAGAIN;
> - Add retry limit of 10000 times for -EAGAIN on KVM_TDX_INIT_VM;
> 
> Changes in v6:
> - setup xfam explicitly to fit with new uapi;
> - use tdx_caps->cpuid to filter the input of cpuids because now KVM only
>   allows the leafs that reported via KVM_TDX_GET_CAPABILITIES;
> 
> Changes in v4:
> - mark init_vm with g_autofree() and use QEMU_LOCK_GUARD() to eliminate
>   the goto labels; (Daniel)
> Changes in v3:
> - Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
> ---
>  target/i386/kvm/kvm.c       |  16 +++---
>  target/i386/kvm/kvm_i386.h  |   5 ++
>  target/i386/kvm/meson.build |   2 +-
>  target/i386/kvm/tdx-stub.c  |  10 ++++
>  target/i386/kvm/tdx.c       | 105 ++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h       |   6 +++
>  6 files changed, 137 insertions(+), 7 deletions(-)
>  create mode 100644 target/i386/kvm/tdx-stub.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


