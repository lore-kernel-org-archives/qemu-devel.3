Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66748106B522
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5NQK-0008T4-0E; Wed, 25 Mar 2026 08:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.yicong@picoheart.com>)
 id 1w5JN5-0000js-T7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:13:47 -0400
Received: from va-2-18.ptr.blmpb.com ([209.127.231.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yang.yicong@picoheart.com>)
 id 1w5JN1-00063B-CI
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 04:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1774426410;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=6vj+2ITOA7jN/XQQmNwNxDhcTvSlDUolwOSEZc+CPx4=;
 b=IzA9XWZWUx/fQCkveUtelu+z7lBRujzBDRETrIjHlZIso/Fcw3nu1O7uHGP17V97Z7J3cA
 /ZpxHvzXkXLHeZ18G7MjURo2LQXgaPaiHN7PbM4YQx2f5tP8mLryYbMv4BgyJhGm4BNwAd
 8HqiOrbVNqWuyyCPox9fgoCfHrUB1O0y1yiA93ooMwatVmci0/m7luEiyitRBaFnuZUldK
 hfjVLE4pjrQVtxeKiaXdkJSNmFlGEdUCaAK3eXVKIuTVVqPjbhm5yIja9Mww6my7UNgRmz
 ovhjZy/lWeh/aQa+kPUj80nLeSiHYiFPM1N0j5//ZyKNKjgQzZ/qPZu0phepfg==
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, 
 <geshijian@picoheart.com>, <wangziang.ok@picoheart.com>, 
 "Yicong Yang" <yang.yicong@picoheart.com>
Subject: [PATCH] hw/riscv/virt-acpi-build.c: Use kvm timer frequency when kvm
 enabled
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.110]) by smtp.feishu.cn
 with ESMTPS; Wed, 25 Mar 2026 16:13:27 +0800
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 16:13:14 +0800
Message-Id: <20260325081314.57089-1-yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+269c39928+17ef43+nongnu.org+yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
To: <sunilvl@ventanamicro.com>, <palmer@dabbelt.com>, 
 <alistair.francis@wdc.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.50.1
Received-SPF: pass client-ip=209.127.231.18;
 envelope-from=yang.yicong@picoheart.com; helo=va-2-18.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Mar 2026 08:33:13 -0400
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

The timer frequency is decided by the host(kvm) rather than a fixed
RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ on kvm accelerated VM. So build
RCHT with KVM provided timer frequency if KVM is enabled, just like
how we build the timer node on DT based VM.

Fixes: ebfd39289370 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 hw/riscv/virt-acpi-build.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb68339..fd6ca5dbc4ff 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -35,9 +35,11 @@
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "system/kvm.h"
 #include "system/reset.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -296,7 +298,10 @@ static void build_rhct(GArray *table_data,
 
     /* Time Base Frequency */
     build_append_int_noprefix(table_data,
-                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, 8);
+                              kvm_enabled() ?
+                              kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
+                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                              8);
 
     /* ISA + N hart info */
     num_rhct_nodes = 1 + ms->smp.cpus;
-- 
2.34.1

