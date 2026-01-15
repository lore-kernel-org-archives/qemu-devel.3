Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13669D3CCB5
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 06:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgHA9-00079S-Ro; Thu, 15 Jan 2026 01:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vgHA7-00078J-Tb
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:48:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vgHA4-0006H0-JD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:48:55 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxHMPSjWhpABQJAA--.29040S3;
 Thu, 15 Jan 2026 14:48:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAx38LQjWhpSuoeAA--.63444S2;
 Thu, 15 Jan 2026 14:48:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Yao Zi <me@ziyao.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] hw/loongarch/virt: Don't abort on access to unimplemented
 IOCSR
Date: Thu, 15 Jan 2026 14:48:40 +0800
Message-Id: <20260115064840.219920-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260115064840.219920-1-maobibo@loongson.cn>
References: <20260115064840.219920-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38LQjWhpSuoeAA--.63444S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Yao Zi <me@ziyao.cc>

Since commit f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface
for misc ops") which adds a call to g_assert_not_reached() in the path
of handling unimplemented IOCSRs, QEMU would abort when the guest
accesses unimplemented IOCSRs.

This is too serious since there's nothing fatal happening in QEMU
itself, and the guest could probably continue running if we give zero as
result for these reads, which also matches the behavior observed on
3A5000M real machine.

Replace the assertion with qemu_log_mask(LOG_UNIMP, ...), it's still
possible to examine unimplemented IOCSR access through "-d unimp"
command line arguments.

Fixes: f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface for misc ops")
Signed-off-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 7c13881885..a75968e4c9 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -47,6 +47,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "kvm/kvm_loongarch.h"
 
 static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
@@ -754,8 +755,15 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
                              EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
                              features, attrs, NULL);
         break;
+    case VERSION_REG:
+    case FEATURE_REG:
+    case VENDOR_REG:
+    case CPUNAME_REG:
+        break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
     }
 
     return MEMTX_OK;
@@ -813,7 +821,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         }
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented IOCSR 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
     }
 
     *data = ret;
-- 
2.52.0


