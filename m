Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD35AD3E799
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaQx-0001qa-JN; Thu, 11 Dec 2025 01:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQP-0001iM-FI
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:18 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQN-00065P-DS
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435516; x=1796971516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3LMmQ+qXdaBeNuD7ppu1lZ8wt0GZHeCMjJGChKX52uI=;
 b=F18NIbO+L1wEhto45UVXp+R0oJ+Cy4WnpExW2D+BrsFHwdLraVg3d/Ra
 /J2Iwibui4kD5NlduxSnejffcbpKZRZrp6UUPv0FuVg/OrnI0FctqEm9A
 RwWBOKVf3cHCgg4Ti/EB+jAb3Vw84q8GuuALhgAgg2N0I0jDz/3CPuPrC
 y8uGeFSCB+tB79/4mh/jUg8ZSH95WdQLyoMPyn42qN74MdudbtR0QzhgZ
 dPc8NvmbQoKmMXsjOY/Tgnnu5yfDM/2qK69Gtzck32Xn/Xro4+6fSetgJ
 qNInVVBfYBrLULEUeMqQf2joTxCgnr1t4XezdBgHPwkrPqilYtsM0CW1Q w==;
X-CSE-ConnectionGUID: DxOYtmHJShuvG8A8F4Yvog==
X-CSE-MsgGUID: SzC+5bJRSjG39N6cXJl+Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584429"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584429"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:15 -0800
X-CSE-ConnectionGUID: JzHfmoiFT3GsHnb+rR5rnQ==
X-CSE-MsgGUID: ih5q40xQRais0FNChce/QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196494942"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:12 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 2/9] i386/machine: Use VMSTATE_UINTTL_SUB_ARRAY for vmstate
 of CPUX86State.regs
Date: Thu, 11 Dec 2025 15:09:35 +0800
Message-Id: <20251211070942.3612547-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211070942.3612547-1-zhao1.liu@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

Before expanding the number of elements in the CPUX86State.regs array,
first use VMSTATE_UINTTL_SUB_ARRAY for the regs' vmstate to avoid the
type_check_array failure.

VMSTATE_UINTTL_SUB_ARRAY will also be used for subsequently added elements
in regs array.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New patch.
---
 include/migration/cpu.h | 4 ++++
 target/i386/machine.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index ca7cc0479e79..1335abe22301 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -21,6 +21,8 @@
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
     VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
@@ -40,6 +42,8 @@
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
+#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
+    VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
 #define VMSTATE_UINTTL_2DARRAY_V(_f, _s, _n1, _n2, _v)                \
     VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, _v)
 #define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 57a968c30db3..0882dc3eb09e 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1748,7 +1748,7 @@ const VMStateDescription vmstate_x86_cpu = {
     .pre_save = cpu_pre_save,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.regs, X86CPU, CPU_NB_REGS),
+        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
         VMSTATE_UINTTL(env.eip, X86CPU),
         VMSTATE_UINTTL(env.eflags, X86CPU),
         VMSTATE_UINT32(env.hflags, X86CPU),
-- 
2.34.1


