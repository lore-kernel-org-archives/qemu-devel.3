Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E812C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1DU-00042B-Ue; Mon, 19 Feb 2024 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DG-0003uA-Pw
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DF-00018M-77
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708339768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4hgN8u5AfvKHOm7gKyk98vXq08LrzvUSx2gRkPZ6vE=;
 b=Lau1fhzzSPLRUXiljN6RkD9TLmMvsdBkzS29ypFE9zTdLDlk9T3bwnKSQ8ize4YhN0ZQjt
 A1p3RmYRrcGZLz0f6LXUQ06RHqwnIBlnr8+omvgnI5ugLRpUV5Rirf5bSludPthPrYsb5u
 Mp4zp5oTWDlzMDKMh+sToK1y6+OttpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-kklzypBpOAiWfL-4mTUKgA-1; Mon, 19 Feb 2024 05:49:25 -0500
X-MC-Unique: kklzypBpOAiWfL-4mTUKgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1630885A588;
 Mon, 19 Feb 2024 10:49:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64F371C060B3;
 Mon, 19 Feb 2024 10:49:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH 5/7] hw/ide: Move IDE DMA related definitions to a separate
 header ide-dma.h
Date: Mon, 19 Feb 2024 11:49:10 +0100
Message-ID: <20240219104912.378211-6-thuth@redhat.com>
In-Reply-To: <20240219104912.378211-1-thuth@redhat.com>
References: <20240219104912.378211-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These definitions are required outside of the hw/ide/ code, too,
so lets's move them from internal.h to a new header called ide-dma.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ide/ide-dma.h  | 30 ++++++++++++++++++++++++++++++
 include/hw/ide/internal.h | 27 +--------------------------
 2 files changed, 31 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/ide/ide-dma.h

diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
new file mode 100644
index 0000000000..fb82966bdd
--- /dev/null
+++ b/include/hw/ide/ide-dma.h
@@ -0,0 +1,30 @@
+#ifndef HW_IDE_DMA_H
+#define HW_IDE_DMA_H
+
+typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
+typedef void DMAVoidFunc(const IDEDMA *);
+typedef int DMAIntFunc(const IDEDMA *, bool);
+typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
+typedef void DMAu32Func(const IDEDMA *, uint32_t);
+typedef void DMAStopFunc(const IDEDMA *, bool);
+
+struct IDEDMAOps {
+    DMAStartFunc *start_dma;
+    DMAVoidFunc *pio_transfer;
+    DMAInt32Func *prepare_buf;
+    DMAu32Func *commit_buf;
+    DMAIntFunc *rw_buf;
+    DMAVoidFunc *restart;
+    DMAVoidFunc *restart_dma;
+    DMAStopFunc *set_inactive;
+    DMAVoidFunc *cmd_done;
+    DMAVoidFunc *reset;
+};
+
+struct IDEDMA {
+    const struct IDEDMAOps *ops;
+    QEMUIOVector qiov;
+    BlockAIOCB *aiocb;
+};
+
+#endif
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 642bd1a979..d1d3fcd23a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -9,6 +9,7 @@
 
 #include "hw/ide.h"
 #include "hw/ide/ide-bus.h"
+#include "hw/ide/ide-dma.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
@@ -316,13 +317,6 @@
 #define SMART_DISABLE         0xd9
 #define SMART_STATUS          0xda
 
-typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
-typedef void DMAVoidFunc(const IDEDMA *);
-typedef int DMAIntFunc(const IDEDMA *, bool);
-typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
-typedef void DMAu32Func(const IDEDMA *, uint32_t);
-typedef void DMAStopFunc(const IDEDMA *, bool);
-
 extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
 
 extern const MemoryRegionPortio ide_portio_list[];
@@ -340,25 +334,6 @@ typedef struct IDEBufferedRequest {
     bool orphaned;
 } IDEBufferedRequest;
 
-struct IDEDMAOps {
-    DMAStartFunc *start_dma;
-    DMAVoidFunc *pio_transfer;
-    DMAInt32Func *prepare_buf;
-    DMAu32Func *commit_buf;
-    DMAIntFunc *rw_buf;
-    DMAVoidFunc *restart;
-    DMAVoidFunc *restart_dma;
-    DMAStopFunc *set_inactive;
-    DMAVoidFunc *cmd_done;
-    DMAVoidFunc *reset;
-};
-
-struct IDEDMA {
-    const struct IDEDMAOps *ops;
-    QEMUIOVector qiov;
-    BlockAIOCB *aiocb;
-};
-
 /* These are used for the error_status field of IDEBus */
 #define IDE_RETRY_MASK 0xf8
 #define IDE_RETRY_DMA  0x08
-- 
2.43.2


