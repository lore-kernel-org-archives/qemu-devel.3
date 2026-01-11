Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B0CD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 10:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vet2F-00032i-8s; Sun, 11 Jan 2026 05:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vet2D-0002wp-SM
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 05:51:01 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vet2B-0002ts-Bn
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 05:51:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1768128641; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZKgrMNFaWi81atPfAh+BjATktKUowe21cfwF5iPINETOnaOSIdv3Df1WEQ0LCctBOArFKFi3NzrognFWKCCU0T9vP78Lm5ocIE/gC3iZcCgKpBDozEk8LOhxqY6EVUNHDaTt5fzNy+0LkbTUHzAFrhq6Q1gUxINc02hFHOnvarA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768128641;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aObT+GlU9PzbtiH8eT7iskVSb+OD8jG0O4h7gHvB30c=; 
 b=issT+lSIIAPtwYRrtGXD9fIOiXfIJYpEii3u1cBwi2bT0Oz+1mpCdKcRqBtxNk9MZIk9V+9EmxiO6o6bmWUt8tQxBey/7ePh8YTNSpENJ0zLVALP2SrDWRuLdJWFCuzKic1p2t12YYluZ6wHX7qnBPpwnlWFyO4WIL//oShS4Io=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768128641; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=aObT+GlU9PzbtiH8eT7iskVSb+OD8jG0O4h7gHvB30c=;
 b=iAttflFXupER1iF0Eitwmkex2O3ktmNvIWynU2BfNhu50Xq2J0npXPmu69VCt8X8
 ad5/TW6oFIo9FTjWpP7QpzP4qq0Hj0ZPAPOvr+AH2Hg0H3PlBN5r9UesNFhfO+kCNuj
 FQ/8z3nsOPQLWgZNoMPS5ctsrQEvwjz0f+9Epujs=
Received: by mx.zohomail.com with SMTPS id 1768128639205339.27514811479784;
 Sun, 11 Jan 2026 02:50:39 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, Yao Zi <me@ziyao.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/loongarch/virt: Don't abort on access to unimplemented
 IOCSR
Date: Sun, 11 Jan 2026 10:50:27 +0000
Message-ID: <20260111105027.8817-1-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@ziyao.cc;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---

Changed from v1
- Reword the commit message to avoid implying reading/writing
  unimplemented IOCSRs is guaranteed to result in zero on LoongArch.
- Don't log writes to read-only {VERSION,FEATURE,VENDOR,CPUNAME}_REG as
  unimplemented.
- Link to v1: https://lore.kernel.org/qemu-devel/20251221122511.56544-2-me@ziyao.cc/

 hw/loongarch/virt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6efa15da4737..97ea1fb46d00 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,6 +46,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "kvm/kvm_loongarch.h"
 
 static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
@@ -621,8 +622,15 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
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
@@ -680,7 +688,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
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


