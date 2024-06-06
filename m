Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274F3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDaM-0006rb-8x; Thu, 06 Jun 2024 09:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sFDaK-0006rF-DL
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:55:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sFDaH-0001Pz-RB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717682118; x=1749218118;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IBg0Ns3W9VaAlxUWs+bPYbr8HRMVIneN0n9G9aLpJLM=;
 b=nVKtdrQzyNRVpCZ7NMORPQAOR/dVFQ2Xff9O4ftUcuZFf+TMpnl7V0rv
 jIypLwqhH/qSdCVFNKhPX2Nxlo4+cagsPk2sLxnRQG7IpHG8F0zjVbxNR
 wrakV+IvnqIVL3Et4UWeIgg5GCZSkWIKbFS7LbtyLVypAchq5H3eYfz0M
 W72ID+uV4qFCNdw6c8SV0t8DYWJP8M9na8aL7qzNfX1cF48t9JW4U5fAn
 sTu3VdROfruDrGn02lYcFgLTlZhcxVt+7h1/O7c4GB2gh+EZqGFB220ji
 8zblSR67nfHIIwNvBV9oKYeqturaTYqgwGQ3Un9KB0ZKSzzuCMyk/CA7C Q==;
X-CSE-ConnectionGUID: 0ngAdNWqRii1myLFw8enCQ==
X-CSE-MsgGUID: h/5uqyM0Qt2PmMrkHzuGCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14155887"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="14155887"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 06:55:15 -0700
X-CSE-ConnectionGUID: 1Kb6lmq6Ty62cHPRqZsKSg==
X-CSE-MsgGUID: ICwogqF5SYe8Fjey/kMC2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="38051648"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 06 Jun 2024 06:55:12 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] i386/apic: Add hint on boot failure because of disabling
 x2APIC
Date: Thu,  6 Jun 2024 22:08:58 +0800
Message-Id: <20240606140858.2157106-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently, the Q35 supports up to 4096 vCPUs (since v9.0), but for TCG
cases, if x2APIC is not actively enabled to boot more than 255 vCPUs (
e.g., qemu-system-i386 -M pc-q35-9.0 -smp 666), the following error is
reported:

Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:449:
qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
Aborted (core dumped)

This error can be resolved by setting x2apic=on in -cpu. In order to
better help users deal with this scenario, add the error hint to
instruct users on how to enable the x2apic feature. Then, the error
report becomes the following:

Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:448:
qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
Try x2apic=on in -cpu.
Aborted (core dumped)

Note since @errp is &error_abort, error_append_hint() can't be applied
on @errp. And in order to separate the exact error message from the
(perhaps effectively) hint, adding a hint via error_append_hint() is
also necessary. Therefore, introduce @local_error in
apic_common_set_id() to handle both the error message and the error
hint.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/intc/apic_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d8fc1e2815fe..c13cdd79943d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -433,6 +433,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
     APICCommonState *s = APIC_COMMON(obj);
     DeviceState *dev = DEVICE(obj);
     uint32_t value;
+    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -444,7 +445,11 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
     }
 
     if (value >= 255 && !cpu_has_x2apic_feature(&s->cpu->env)) {
-        error_setg(errp, "APIC ID %d requires x2APIC feature in CPU", value);
+        error_setg(&local_err,
+                   "APIC ID %d requires x2APIC feature in CPU",
+                   value);
+        error_append_hint(&local_err, "Try x2apic=on in -cpu.\n");
+        error_propagate(errp, local_err);
         return;
     }
 
-- 
2.34.1


