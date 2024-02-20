Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA8EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLuo-0007RP-Kq; Tue, 20 Feb 2024 03:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuK-0005yv-Sf
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuI-0000EN-NV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4kUNW1DhMYoldIAgxSL7iyjT88ERZ+ZFBlNVrBBPR0=;
 b=if/iOwDnv8D0UEGYyJMu4ik+FNAuei0acxZiCvq1kZNmvNYpRX4iM1mvNY9tyg+bTjyH36
 IMIqMOgv8ZVw173crHeREiCUB6EOsY/kdXTipEWOmQpsv3Wwo2PvpgSfkqA6dC+VLV8MWF
 K5Rbx744vmpmpf4nu6cSfj0CJcNneaw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-5iI9mR0iOfSUgyD86NFN0Q-1; Tue,
 20 Feb 2024 03:55:15 -0500
X-MC-Unique: 5iI9mR0iOfSUgyD86NFN0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 915FA28B6AA0;
 Tue, 20 Feb 2024 08:55:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D08E7492BE3;
 Tue, 20 Feb 2024 08:55:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v2 3/7] hw/ide: Move IDE DMA related definitions to a separate
 header ide-dma.h
Date: Tue, 20 Feb 2024 09:55:01 +0100
Message-ID: <20240220085505.30255-4-thuth@redhat.com>
In-Reply-To: <20240220085505.30255-1-thuth@redhat.com>
References: <20240220085505.30255-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/hw/ide/ide-dma.h  | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/ide/internal.h | 29 +----------------------------
 2 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100644 include/hw/ide/ide-dma.h

diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
new file mode 100644
index 0000000000..3ac4c3c9fa
--- /dev/null
+++ b/include/hw/ide/ide-dma.h
@@ -0,0 +1,37 @@
+#ifndef HW_IDE_DMA_H
+#define HW_IDE_DMA_H
+
+#include "block/aio.h"
+#include "qemu/iov.h"
+
+typedef struct IDEState IDEState;
+typedef struct IDEDMAOps IDEDMAOps;
+typedef struct IDEDMA IDEDMA;
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
index 3bdcc75597..a3a6702eec 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -11,6 +11,7 @@
 #include "sysemu/dma.h"
 #include "hw/block/block.h"
 #include "exec/ioport.h"
+#include "hw/ide/ide-dma.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
@@ -18,8 +19,6 @@
 
 typedef struct IDEDevice IDEDevice;
 typedef struct IDEState IDEState;
-typedef struct IDEDMA IDEDMA;
-typedef struct IDEDMAOps IDEDMAOps;
 
 #define TYPE_IDE_BUS "IDE"
 OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
@@ -332,13 +331,6 @@ typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
 
 typedef void EndTransferFunc(IDEState *);
 
-typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
-typedef void DMAVoidFunc(const IDEDMA *);
-typedef int DMAIntFunc(const IDEDMA *, bool);
-typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
-typedef void DMAu32Func(const IDEDMA *, uint32_t);
-typedef void DMAStopFunc(const IDEDMA *, bool);
-
 struct unreported_events {
     bool eject_request;
     bool new_media;
@@ -460,25 +452,6 @@ struct IDEState {
     int ncq_queues;
 };
 
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
 struct IDEBus {
     BusState qbus;
     IDEDevice *master;
-- 
2.43.2


