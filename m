Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F57AC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFa-0002fE-Nw; Fri, 31 Jul 2026 01:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM9-0005uu-5R; Thu, 30 Jul 2026 23:56:22 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM2-0002Ii-Dc; Thu, 30 Jul 2026 23:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470169; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=YaMOXhMK+4204mX9njUvyFccbt16zqb7oJOy5G7LF9Y=;
 b=XfVGqfWh1GLmCOQm/3gK3QtXrtgJ9GohamDVTj0bZiXRLuIrF3C+MZXD/7yM40F0M7l3ty82Yb/sNYnNlibnZXDdlXs6NntI7UA28iGb0qDNS4QNdn+BDGEn5CHR4/vQ1tmC7QX57rVEvBes8W9rij9x7Uh8YxurqvQQpLP/Q3M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwTx_1785469855; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwTx_1785469855 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:55 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 09/17] hw/intc/riscv_aplic: emulate the APLIC for a
 CoVE guest
Date: Fri, 31 Jul 2026 11:50:03 +0800
Message-Id: <20260731035011.4178103-10-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=blduan@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

KVM does not implement an APLIC for a TEE VM, so emulate it in QEMU
while still using the in-kernel IMSIC, exactly like in split irqchip
mode.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/intc/riscv_aplic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 84606e9f3d..897147c2d5 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -36,6 +36,7 @@
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "hw/riscv/cove.h"
 
 #define APLIC_MAX_IDC                  (1UL << 14)
 #define APLIC_MAX_SOURCE               1024
@@ -172,6 +173,14 @@ bool riscv_use_emulated_aplic(bool msimode)
         return true;
     }
 
+    /*
+     * KVM does not implement an APLIC for a CoVE guest, so emulate it in
+     * QEMU while still using the in-kernel IMSIC, like in split mode.
+     */
+    if (riscv_cove_vm_active()) {
+        return true;
+    }
+
     if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
         return true;
     }
-- 
2.34.1


