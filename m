Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F23C3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsM-0005In-8z; Tue, 01 Apr 2025 09:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsD-0005E8-LT
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:53 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsC-0006XQ-2o
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514908; x=1775050908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EQ8+EUoubeI/k4cXZyQ//CK2PPPO+mUjqXHGVbQMaYA=;
 b=VYSKvLjb3pjnUGwMOI6e/6m2/NosH32aDkIfFs/gqqx1X28x4JFMLq18
 ZI4itug1+czG+nQFdq5+841Ua54TPo98sf8zSkOYBLw75BCU/sEATr0wY
 DSGHiSNqyzJV3HVPrv1vBZlvlgoJUxSNBvlFAlur9bT1gd4GZOKQGL9/W
 54b5Dv1FhqOH8ilAiX/ANjJ7/AcLiOk5ddQd2V1h+iCyplqId3zjuNXHz
 mlgjOWJj7W9G2i5zO77Bw1rl58IJVvS5b5bvJSU5O6j3NTufn+/VBXBbA
 FnCKRhQyEy9FpqSjjdH8zNhuF4sFHZUeCfGHH/r5vHZJYfV8hry8ux8f5 w==;
X-CSE-ConnectionGUID: x5WcT87QSkWlYGDPvPH32Q==
X-CSE-MsgGUID: ABVT/9DjT6m3BrLxlXNI/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433215"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433215"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:41:37 -0700
X-CSE-ConnectionGUID: 00kVKO/1T/aN9Rw2xWFB1Q==
X-CSE-MsgGUID: n7JHB5q8RMCBGVdzC0zeUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126639952"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:34 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 10/55] i386/tdx: Make sept_ve_disable set by default
Date: Tue,  1 Apr 2025 09:01:20 -0400
Message-Id: <20250401130205.2198253-11-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

For TDX KVM use case, Linux guest is the most major one.  It requires
sept_ve_disable set.  Make it default for the main use case.  For other use
case, it can be enabled/disabled via qemu command line.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 081094ae29db..592fb9cbbf0b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -288,7 +288,7 @@ static void tdx_guest_init(Object *obj)
     qemu_mutex_init(&tdx->lock);
 
     cgs->require_guest_memfd = true;
-    tdx->attributes = 0;
+    tdx->attributes = TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
 
     object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
                                    OBJ_PROP_FLAG_READWRITE);
-- 
2.34.1


