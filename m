Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82E5E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14U-0006je-Ma; Mon, 02 Feb 2026 16:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn14S-0006g7-QJ; Mon, 02 Feb 2026 16:02:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn14R-0004h0-7G; Mon, 02 Feb 2026 16:02:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 381261851BA;
 Mon, 02 Feb 2026 23:57:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 002D835B331;
 Mon, 02 Feb 2026 23:58:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yao Zi <me@ziyao.cc>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 46/74] hw/loongarch/virt: Don't abort on access to
 unimplemented IOCSR
Date: Mon,  2 Feb 2026 23:57:57 +0300
Message-ID: <20260202205833.941615-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
(cherry picked from commit 49ee001a5b8378e9a9b3db8cbf61e7eda970ecd2)
(Mjt: trivial context fix for 10.1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b15ada2078..46d7d9c863 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,6 +46,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
@@ -553,8 +554,15 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
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
@@ -605,7 +613,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
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
2.47.3


