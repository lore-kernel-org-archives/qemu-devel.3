Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3F6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yA6-0003mz-CY; Thu, 25 Sep 2025 22:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1yA5-0003l5-52
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:26:17 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y9n-000615-Af
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853559; x=1790389559;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9p5TFP5IXSL/3hMVqbtrGjD6yrnK8SNBoTLObmipajY=;
 b=mmS/Kp8a0VEHYDTqbkK8LIceu1yWRRZp7ChskCa2FxDCPl8cqi1uTkG/
 q26s/kh4DJtU5Q3HmWcB176+12Vi15mqo5w0PZ0xx3mCaEGP3mYPCoqZ1
 2tJD0iFBv1jmfDnx8dsWyjMbsMWRIVtJuhZ4cnR0PhsPiTcCnb1wOwHtN
 b19A8Z4h/A+6DcvHW8+oAb7DgQ6yExgB7c9fJWTRfuIfDECDTWzf0YUYS
 xuBaJ8lOKZjEPqrNmcPbPn8M7pO7kT10LDk6FCOoU0bRhkr7Gqom2dU1+
 RddP3/84j7nA9vFl/D9nJ2LQAb/cYnE9zE4vCuiWEN7F3raxAR4BF9MpW w==;
X-CSE-ConnectionGUID: OG0l3N9VS8eE5VbO+arsNA==
X-CSE-MsgGUID: janTe1UZTUyfiv2adKMOKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61104656"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="61104656"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:25:50 -0700
X-CSE-ConnectionGUID: h+jEIRWnSsGmC1sYJ7kr4w==
X-CSE-MsgGUID: 7kmMGPipThS5OCRf2YZo/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="177327183"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:25:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon" after
 CPR transfer
Date: Thu, 25 Sep 2025 22:25:40 -0400
Message-ID: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

After CPR transfer, source QEMU close kvm fd and free kvm_state,
"query-balloon" will check kvm_state->sync_mmu and trigger NULL
pointer reference.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9060599cd7..a3e2d11763 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3479,7 +3479,7 @@ int kvm_device_access(int fd, int group, uint64_t attr,
 
 bool kvm_has_sync_mmu(void)
 {
-    return kvm_state->sync_mmu;
+    return kvm_state && kvm_state->sync_mmu;
 }
 
 int kvm_has_vcpu_events(void)
-- 
2.47.1


