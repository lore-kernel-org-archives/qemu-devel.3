Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12577C3ABCA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2qQ-0006YA-Bu; Thu, 08 May 2025 11:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qN-0006GQ-2f
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:27 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qK-0007RF-GJ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716844; x=1778252844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=htgMoepnRRm85RzXkxzGm9FC+zja4crME7UX1m1yuW8=;
 b=mP49qYVYiuceEigq3ZU6SbB/jerwcXl0k8/GpbZJUXQxhtWrrpniAVhM
 mkpUUptROh/ap2x222mjyzyZ4fQdQaQdxaRbtGw0ARj+jt3BsWRaemsO0
 CGfxpCIoabTa/nNfpLFcPbTwPSgOztFIzBD+SThZC4NRFLuvGRm/7wO/E
 w0EXA1smf4k1LHjpaNmtXyLIYN+XM3x+ELJ8MolrckqgVyfeuW+Tu4uPR
 Qxhj30wvVRaOQ+FVmmgyCX5QrjSU9HXz3rIhy6RGkWtFR+lbf1IIkYmgp
 +Nzg+OijB4tHUCkHZ7DuFFF9PvLkWdcW49O2NdoXOHEeu9S2NaYArHjeO w==;
X-CSE-ConnectionGUID: K/eMv0nnTz2WvDZ0RcZdDA==
X-CSE-MsgGUID: ooC7bHRAQKGwJEvcm/Zd6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888302"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888302"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:40 -0700
X-CSE-ConnectionGUID: 5OblsYRgSraDVToUvnhg2g==
X-CSE-MsgGUID: +N9koNTJRmmdJG7hi/emMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440204"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:37 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 34/55] i386/tdx: Force exposing CPUID 0x1f
Date: Thu,  8 May 2025 10:59:40 -0400
Message-ID: <20250508150002.689633-35-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

TDX uses CPUID 0x1f to configure TD guest's CPU topology. So set
enable_cpuid_0x1f for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/tdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0d6342b51dbc..32c8f0ba968d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -407,7 +407,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
 
 static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
 {
+    X86CPU *x86cpu = X86_CPU(cpu);
+
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
+
+    x86cpu->enable_cpuid_0x1f = true;
 }
 
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
-- 
2.43.0


