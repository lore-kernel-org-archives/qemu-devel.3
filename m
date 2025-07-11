Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1407FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAws-0000JJ-VO; Fri, 11 Jul 2025 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAwG-0008DX-Nc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:25:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAw9-0003HM-S8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752229502; x=1783765502;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ap8zvZO5z+/80DTYVSm+1mfgstbSCOBY4FaHeUUS1Y=;
 b=U7gRUad1fE1JLyQGJk3u0E884iBtvxlETSML2g8XdGxI2EpodwJAjn3k
 Cb0DptN1wnk3uClujOEG0zMkijtV44zq0LBrdmki1fKWTB/e1MjqFgljq
 FEcux0eA2OSG8pNNDYIcmDBWD2fnIqrW9EnWgQwybMpB7G/lypre7wUmq
 bbUecgU244zBlwRrfUYtVF6LhyqmQ71h/YrMvTmn3wqm/0UkXrv4NoNCX
 9DKNQTsHDD1GYLLFxcjEzm4bMYlVJ+Tc0NpfD40h9vrBI+q2oRZ38tjWS
 OzvNeEGzm64bfakU2l89cxVXU1Gzq5x5WnAG+3hUZSBzTDMZ+wcpvk/h/ g==;
X-CSE-ConnectionGUID: N4a3gMf4SI2l3Uw4u1a10A==
X-CSE-MsgGUID: FOZn7dcjSn2/xe6eVWX6RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65875724"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="65875724"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:25:00 -0700
X-CSE-ConnectionGUID: dlZAN31cS/an2evuITFD1A==
X-CSE-MsgGUID: ActYxfrtS0OdUP0UNmAd8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="156894404"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 11 Jul 2025 03:24:57 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 6/9] i386/cpu: Enable 0x1f leaf for SierraForest by default
Date: Fri, 11 Jul 2025 18:46:00 +0800
Message-Id: <20250711104603.1634832-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711104603.1634832-1-zhao1.liu@intel.com>
References: <20250711104603.1634832-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

Host SierraForest CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Rename the property to "x-force-cpuid-0x1f". (Igor)
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d27eeb1cb718..2f19726a9397 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5387,8 +5387,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with srf-sp cache model",
+                .note = "with srf-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_srf_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ },
         },
-- 
2.34.1


