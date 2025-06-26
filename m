Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC278C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhgg-0002E1-Bg; Thu, 26 Jun 2025 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhge-0002DU-KG
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:24 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUhgb-0006eP-HS
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750925421; x=1782461421;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C0a6tqpkzpJUuOzvfvUQv/qlyuviRct/mBcEnu+0pwg=;
 b=DZiJKHrfgkkUylFaeLz816WEhlW5BUIK2Tr0TNfR9w94iOhntc2N6WWB
 0sROAo0eqSxTVEMhKE6xxIjsavOwD66dWl17A5L6qqJe5nAACapMfYYqx
 YLhAusUcHGLtxYNSE/zlEGxG5uBXWSvQ8Db+qMR0myHPc7LibXDu3z5L+
 MTqN8F+DJWIQGfOKhV0f2v70bhM1UuyMZyKOSY0OBzLvSmJ7hyOq752km
 NXyPu+XSiOezPkQ4ywYFWcD0THuh2RVlVq+krsKLgOszDxiJajWEdpz0I
 nnj6bRqStsbs4aQgkHykmUw2ygc4QBQohNWrRTJMzRXhg9d4I3hwXGhSZ g==;
X-CSE-ConnectionGUID: apn4QYGfTC6J5pX35/+w4Q==
X-CSE-MsgGUID: UwC9/M6QSDONL851X2JCGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="63902150"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="63902150"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:10:19 -0700
X-CSE-ConnectionGUID: HXD0UqQfQHKiUrlCQzsr7Q==
X-CSE-MsgGUID: /ht8Eg/3Q7ifDlkDjtyzBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152950038"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 26 Jun 2025 01:10:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 7/8] i386/cpu: Enable 0x1f leaf for GraniteRapids by default
Date: Thu, 26 Jun 2025 16:31:04 +0800
Message-Id: <20250626083105.2581859-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626083105.2581859-1-zhao1.liu@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

Host GraniteRapids CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Rename the property to "x-force-cpuid-0x1f". (Igor)
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70f8fc37f8e0..acf7e0de184d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5242,8 +5242,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with gnr-sp cache model",
+                .note = "with gnr-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_gnr_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ },
         },
-- 
2.34.1


