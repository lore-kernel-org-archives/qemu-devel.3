Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48229CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 06:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFKB-0005m3-K6; Tue, 18 Nov 2025 01:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFJz-0005ih-PZ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:13 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFJu-0007CC-Nf
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763447767; x=1794983767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WaEyNbjG4OMiMqlQkn69ko2nv922dzbUojBAYOjs2ao=;
 b=XCjeqI15cDQqH3HAjxc5cYj4KM4NJKzG/i+sp2ExVEnwCTpHZ8LmLYng
 NcEUndrGps3+zWB4VBriq/vW3NLXEJ1rk1eZfAg078pK9uBhR3xo13uy/
 54WpDtws1ulNEl0cNDtwwwozNkqUQs8NsOWmofWW1XrhjkIiw65ozSdRA
 WuFpn+pnnMx6ZPLAYw/GCyXDXPFN2fh3Ei1X5w5kUXn9+cexJq4pd9wPw
 AtAkuatwduTZA/16M4sBUsE1I5zTiBQc+SiavJhQSVTYjhBQ8c5vSXkIU
 5E7QPwlNTnX5ewlRsHgcjO1/kCEy29uG5/z/kMweO3o8DhnigDEUUqyzJ A==;
X-CSE-ConnectionGUID: BnBDa2ZMTrOzAjyddnfD1Q==
X-CSE-MsgGUID: asroEjDMRFyBeqPYPo3Shw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82850949"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="82850949"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 22:36:05 -0800
X-CSE-ConnectionGUID: pN+XznNrRACiBN2jjwKSWw==
X-CSE-MsgGUID: Y89YPDNUSVScQRjE6UELnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="189962651"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Nov 2025 22:36:03 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/5] i386/cpu: Cache EGPRs in CPUX86State
Date: Tue, 18 Nov 2025 14:58:14 +0800
Message-Id: <20251118065817.835017-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118065817.835017-1-zhao1.liu@intel.com>
References: <20251118065817.835017-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zide Chen <zide.chen@intel.com>

Cache EGPR[16] in CPUX86State to store APX's EGPR value.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h          |  1 +
 target/i386/xsave_helper.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bc7e16d6e6c1..48d4d7fcbb9c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1969,6 +1969,7 @@ typedef struct CPUArchState {
 #ifdef TARGET_X86_64
     uint8_t xtilecfg[64];
     uint8_t xtiledata[8192];
+    uint64_t egprs[EGPR_NUM];
 #endif
 
     /* sysenter registers */
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef5..2e9265045520 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -140,6 +140,13 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 
         memcpy(tiledata, &env->xtiledata, sizeof(env->xtiledata));
     }
+
+    e = &x86_ext_save_areas[XSTATE_APX_BIT];
+    if (e->size && e->offset && buflen) {
+        XSaveAPX *apx = buf + e->offset;
+
+        memcpy(apx, &env->egprs, sizeof(env->egprs));
+    }
 #endif
 }
 
@@ -275,5 +282,12 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
 
         memcpy(&env->xtiledata, tiledata, sizeof(env->xtiledata));
     }
+
+    e = &x86_ext_save_areas[XSTATE_APX_BIT];
+    if (e->size && e->offset) {
+        const XSaveAPX *apx = buf + e->offset;
+
+        memcpy(&env->egprs, apx, sizeof(env->egprs));
+    }
 #endif
 }
-- 
2.34.1


