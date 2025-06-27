Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F39C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 08:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV4KE-0006hY-Hz; Fri, 27 Jun 2025 04:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uV4KB-0006h3-NJ
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:20:43 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uV4KA-00019L-0c
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 04:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751012442; x=1782548442;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JyE/yLf4DE3qc+N+050QL38zwb48BICA6MLmRQiLpL8=;
 b=kSWDLpZGS3Ke1UINiFSWqCrdWSKKt05X1q+dH2WKckniiwZuOMByF+Im
 qMyP6M/Z/p28UQGxuKSrnDKuee+9R2zIqOga0QiW6Wiv5v0vW/wVIq54R
 K/R8H84L1GG11BLf2FP+FHz42hK792KnHQQwq2ZQvDm8QWM8O0O5ek2/8
 HUKsxQBv1iCLpcCRrbsFOP1K6n4UDRysRFdlYQPbzAp6hLL9EK2qgDU1T
 /TKRky3kfHMX5jrdTiD/j08puFABiDodMco4po1xJg0bLoq0HONG1Ou81
 mE4VEdPu7kNIEdE5tC92zXFc+JDKo/8iG1u8L1OImdNeikepws6GitHp+ A==;
X-CSE-ConnectionGUID: 175GsTYASP+pVPqQcPIyrQ==
X-CSE-MsgGUID: RKzssHx5QsekvOf0aK72zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="63920519"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="63920519"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:20:39 -0700
X-CSE-ConnectionGUID: XzaErk13SRyQTUFFUMY97A==
X-CSE-MsgGUID: 62KEuEPqSTivOf1Wuzrulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="158480883"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 27 Jun 2025 01:20:38 -0700
Date: Fri, 27 Jun 2025 16:42:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/tdx: Remove task->watch only when it's valid
Message-ID: <aF5ZWUZvls6l2RDI@intel.com>
References: <20250625035505.2770580-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625035505.2770580-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 25, 2025 at 11:55:05AM +0800, Xiaoyao Li wrote:
> Date: Wed, 25 Jun 2025 11:55:05 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH] i386/tdx: Remove task->watch only when it's valid
> X-Mailer: git-send-email 2.43.0
> 
> In some case (e.g., failed to connect to QGS socket),
> tdx_generate_quote_cleanup() is called with task->watch invalid. It
> triggers assertion of
> 
>   qemu-system-x86_64: GLib: g_source_remove: assertion 'tag > 0' failed
> 
> Fix it by checking task->watch.
> 
> Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx-quote-generator.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


