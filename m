Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E329AD1CA3C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DEG-0001sq-Np; Tue, 05 Nov 2024 01:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDb-0000h6-J1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:39:13 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDX-0001w0-Ui
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788748; x=1762324748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dyUD9Nwe8FsbgpcTWs2XG6l6cCFEI7AD/O96ORbLEfg=;
 b=GXH/sVX8slH4+OeZVtuRzAlf8pznZM169wkwciChuV3m+T5ZcnIXN8wo
 LuR5izjfqWDrBErPt2yLHLeoWrs7qBC+9EDZIjnIN+hYdMX/2eMkKexDO
 XKGbR92pSJDRMLeCosgDbRLJyZMrRUPHn+sedG5atvwNTE1HM0xdkalj4
 +fQgJfPvdnuJTidzgH4mwy9eawdAS4OBdlCDCI4YNtcJi4RVSR87966Qn
 MCD9X+d3r0PhuyZHjG83POKBAN84GuwQwzmVnW11YX7ikxcRflIKzQeCl
 q45VuFHn+zYtAjgh7ZjsOgp3+JbMwdFhxmImlYUMYwI2pZ/qhZcHwQNHn g==;
X-CSE-ConnectionGUID: YKxOqXRWQuOmj9kmVtoltA==
X-CSE-MsgGUID: bHKqoQt7SKKg+sYdiwEucQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689718"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689718"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:38:57 -0800
X-CSE-ConnectionGUID: nBw1klSbQS65rq8tQKhmxQ==
X-CSE-MsgGUID: 0zbx6/jETtKRuCVPbc4Ycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989408"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:38:53 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 36/60] i386/tdx: Force exposing CPUID 0x1f
Date: Tue,  5 Nov 2024 01:23:44 -0500
Message-Id: <20241105062408.3533704-37-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 target/i386/kvm/tdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 289722a129ce..19ce90df4143 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -388,7 +388,11 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
 
 static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
 {
+    X86CPU *x86cpu = X86_CPU(cpu);
+
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
+
+    x86cpu->enable_cpuid_0x1f = true;
 }
 
 static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
-- 
2.34.1


