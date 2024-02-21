Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74CDC54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzl-0003eq-9i; Wed, 21 Feb 2024 16:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzX-0001yR-WB
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzV-0001H1-4s
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4127706e48cso7725705e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550335; x=1709155135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAdVq5rUcil5gs4UnSlEI8gmsHzEwxxSsfugjfa7R48=;
 b=RGEBAiIsuiz5p+2U+o/EKQahdwdWlOmALej/ZeqRHMqk5+MnSIFdKcvPxU7+6xWAEO
 FJwgxNqjZlfF1A398qoYJJlPz9ppb4aj9vi2ODHmWxLo+OpPnLTt45bokIcKENP1h2n1
 JEX7SgfY0lHEhLvtrZH9oxBzf3xqShU65/ftyhSEOJbASsalkDhZjdVrS1FDzj5dBF2o
 TiqDz1Tk+Ev1XyN0dcXrPyfYy36Hfr8tqEaTpTKh9d2cdHYcSWzIvyWbFuOU3f2Oqqwi
 lXlcI8EUV7J3ZtzcFNzyhzzfKUj3qIi5BEDYn4z1YMgslw8gmMChLqwxC9sFSkkrMmCy
 iokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550335; x=1709155135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAdVq5rUcil5gs4UnSlEI8gmsHzEwxxSsfugjfa7R48=;
 b=xOXCJ2UcJF0A4V0eRV/CLxVuAaRn15lRuQjyoGP2cxkWZemVYQRQDW6uEjYytrxZXl
 MDbJM+UMkxshZBXMdidKiMOgMrKm2hvxXeB+U9xjAsSI3bfeBwVkuzTrf2df3vi+eSnJ
 B4zNK8QSkUYwgR2lnUm+vDdHeYF8CHeAu3cGOHuFNSkEzyFfjpnjIPT/Itp+Qs/9msZg
 bh3iHaZiYHBNKP3JO11zM1lsDEJ72TPAmlxJnA0YbEp6ENEwHQGNRaNRF93FJ4Okph0t
 m+fi6xr646QcyxRhkEv8Ok5U+piJQ4Ln1rDvOy9DNNMEMufnzY1TBavwoZNBUfgHftmf
 gjzg==
X-Gm-Message-State: AOJu0YyTUMYUSgCdppWuer5iZhN3fQ/xbtwb3Bdsntrgxoqd51Yz8SBf
 CJlHGEZb5IYk5syKsFfG8ToZYqS12x2dyBZUfBUAEMsCOb306bSc02GZaeJcGm9j3DjLMgGVbkx
 UbP0=
X-Google-Smtp-Source: AGHT+IHJchHfvCjeL2F82+lnM+IGqgqCsHthdrr+bFCleDy1AxxAqLjiDRdFPVWNzPnQGD1Lr5hGZg==
X-Received: by 2002:a05:600c:46ce:b0:40e:f693:94f6 with SMTP id
 q14-20020a05600c46ce00b0040ef69394f6mr14433886wmo.35.1708550335180; 
 Wed, 21 Feb 2024 13:18:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c44c900b00411e3cc0e0asm18723489wmo.44.2024.02.21.13.18.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 20/25] hw/ide: Move IDE DMA related definitions to a separate
 header ide-dma.h
Date: Wed, 21 Feb 2024 22:16:20 +0100
Message-ID: <20240221211626.48190-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

These definitions are required outside of the hw/ide/ code, too,
so lets's move them from internal.h to a new header called ide-dma.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240220085505.30255-4-thuth@redhat.com>
[PMD: Use IDEDMAOps typedef in struct IDEDMA]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ide-dma.h  | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/ide/internal.h | 29 +----------------------------
 2 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100644 include/hw/ide/ide-dma.h

diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
new file mode 100644
index 0000000000..d0b19ac9c5
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
+    const IDEDMAOps *ops;
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
2.41.0


