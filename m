Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E1C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlt3-0007pw-UZ; Tue, 13 Aug 2024 03:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdlt2-0007p1-54
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:24:08 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdlsy-0005DL-IJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723533845; x=1755069845;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7siAXfH4vGMl9r7bsM+nUcgReCSpYam1MbKp9VHaf3Y=;
 b=YZ0FDzGHUdx5mDRD+M08hPBKB8YEh6NVu3QnqPFWapb5KBR7ghAtxhU5
 K8beu3Vm6FxAEN2u3klcZ3kFKL/zdPaF2nndLt+HgGStl4cigNdItkWul
 zkeOMK85qDlPTtEA66JcyLJui+39Ru2ccW+aWt0qmR4GPSwzFILM/1ZXC
 0LDCSktRk4fXer/iW8tG3ufFWvb004BkZe8hSRvakOC7u6sxcoxJFKHZN
 IDo/YVNcngYDk1/9VLCd00Ks8XGoycLUq0unEgrB0jQtqupxfwad6uSuT
 XM7NSm99W/tHmzFVEFHoPJtGWb5wY9tHbWLaHNV3CaDxOIXXg7KTPpaF7 Q==;
X-CSE-ConnectionGUID: 3yJHQS6iSTiasxYT6bd2FQ==
X-CSE-MsgGUID: Umo9T3D6T9COsW3kNL1EfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32355914"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="32355914"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:23:56 -0700
X-CSE-ConnectionGUID: Ko+71QNHTqWUFj2+plLDzg==
X-CSE-MsgGUID: PJdHNFfdT9mMJu7tLaf7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="59141910"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 00:23:54 -0700
Date: Tue, 13 Aug 2024 15:39:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 John Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>
Subject: Re: [PATCH v2] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <ZrsNwS+OEZaKrlcX@intel.com>
References: <20240813033145.279307-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813033145.279307-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 11:31:45PM -0400, Xiaoyao Li wrote:
> Date: Mon, 12 Aug 2024 23:31:45 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
>  CPUID 0x1f
> X-Mailer: git-send-email 2.34.1
> 
> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> module level, are configured for the guest, e.g., -smp xx,dies=2.
> 
> However, 1) TDX architecture forces to require CPUID 0x1f to configure CPU
> topology. and 2) There is a bug in Windows that Windows 10/11 expects valid
> 0x1f leafs when the maximum basic leaf > 0x1f[1].
> 
> Introduce a bool flag, enable_cpuid_0x1f, in CPU for the cases that
> require CPUID leaf 0x1f to be exposed to guest. For case 2), introduce
> a user settable property, "x-cpuid-0x1f" ,as well, which provides an opt-in
> interface for people to run the buggy Windows as a workaround. The default
> value of the property is set to false, thus making no effect on existing
> setup.
> 
> Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
> cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
> to enable cpuid leaf 0x1f for the guest.
> 
> [1] https://lore.kernel.org/qemu-devel/20240724075226.212882-1-manish.mishra@nutanix.com/
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> changes in v2:
>  - Add more details in commit message;
>  - introduce a separate function x86_has_cpuid_0x1f() instead of
>    modifying x86_has_extended_topo();
> ---
>  target/i386/cpu.c     | 5 +++--
>  target/i386/cpu.h     | 9 +++++++++
>  target/i386/kvm/kvm.c | 2 +-
>  3 files changed, 13 insertions(+), 3 deletions(-)

This wrapper x86_has_cpuid_0x1f() looks good for me.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


