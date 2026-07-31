Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85675C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFn-0002lC-QA; Fri, 31 Jul 2026 01:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeMA-0005vj-Ok; Thu, 30 Jul 2026 23:56:22 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM9-0002Jb-8n; Thu, 30 Jul 2026 23:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470176; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=X/93dqUZJ5vqNdc2k7leoueHxTl13Foc1+GDyPYPhhY=;
 b=dj90vlPLGQlvgZ8Fu9ZQXSnmwh7pQknlpmE8Q6UB5cUxY71Gu1zvTrxsJ6Fl7KzxST0naWJGSl4HpPMunachBkICzqLVPtWhmFBaRzcB0hStqc0hEx0ymdrYJ7JZA43mOkr3B4nxYyE3UTMr4NC3jfEVYV+ZTp5oPG96fti+a7s=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwY1_1785469865; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwY1_1785469865 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:51:05 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 17/17] hw/core/machine-qmp-cmds: shut down a CoVE guest
 on reset
Date: Fri, 31 Jul 2026 11:50:11 +0800
Message-Id: <20260731035011.4178103-18-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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

A TEE VM cannot be reset: the TSM destroys it and the host cannot
recreate it with the same measurement, so treat system_reset as a
shutdown request.

Changing the meaning of a QMP command like this is not acceptable as is.
QEMU already has a generic mechanism for guests that cannot be rebuilt,
qemu_system_reset_request() checks cpus_are_resettable() together with
confidential_guest_can_rebuild_state(), and using it would require CoVE
to provide a ConfidentialGuestSupport object.  This patch is included to
document the limitation and to ask whether that is the direction to
take.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/core/machine-qmp-cmds.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e62cb4ec88..74a9274ab3 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
+#include "hw/riscv/cove.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-accelerator.h"
@@ -302,6 +303,15 @@ UuidInfo *qmp_query_uuid(Error **errp)
 
 void qmp_system_reset(Error **errp)
 {
+    /*
+     * Resetting a CoVE guest destroys the TVM, which cannot be recreated
+     * from the host, so shut the guest down instead.
+     */
+    if (riscv_cove_vm_active()) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
+        return;
+    }
+
     qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
 }
 
-- 
2.34.1


