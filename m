Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D50E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tObSX-0000V9-4W; Fri, 20 Dec 2024 06:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tObSV-0000Um-Bg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:46:19 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tObSR-00029d-4y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:46:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21670dce0a7so20906155ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 03:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1734695172; x=1735299972;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkP3yiY4nMNxXYe3V1NVfrEoFquMoeVZbLXkfzSz/yA=;
 b=AX4ybVIvXTLOM/b6nTl8RYaMs5W4BEjYB+U0Ic5nzQ1hOge2W+6IavGCw+ZljNRYUS
 B8YNqOCdxz8LuMKN/Nszg3mbsChyHFBWc+kvhGffUkROmA9WusO7Gu5PNH37EstZ5g+L
 CWvWh15KKBwTZ0hz9WadAkyVYU+Ph8pPV2w29C6i1zm0yv0d3r3ib1QP7H2lBfuJbiwv
 YOux46NrtyoGniX/MIwZJawlzRFJCRBX4tXAxLxU+j+GokEBLwjURr9lfXDsVOxUXs2t
 fVwEBDBZbLF+ISDwz2NmUw6RLP/gBUnDAz3YuV75iHtaKtuBtvv1kHGXVVNHufvA5eWg
 mNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734695172; x=1735299972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkP3yiY4nMNxXYe3V1NVfrEoFquMoeVZbLXkfzSz/yA=;
 b=U9QSrVz/Xv3QckRbF4ZSlaUBDSEK/SUKnzP7wiDrWhAmiUCRMHXHDRTxfZSkkLUHVZ
 7b++j6MiT8mu3Zh2XpBX98rpmT7NK8ZOi3xitJSQsHMjoQlAWrOzazIZ/5B+zHw9bZ+L
 PCMMJ1vZylIlPbCZjJKiIMr66bW4NA9cShs3eWBtRivbfa5uWiASQCPNKsY4pVWj4WnP
 QAAIAWgnXdPCjR3YbFfWT13wvfZBw1HdHM0jgXPU850S/aPEH+0w60Ny0O7rjl0/cFmz
 ia7YtD0DhuoWsEpVhPjwt/eW7raR5FZpRt2BnntUIe//FwQb3nkzYJPTHyDaP7w9fJ9e
 SKGw==
X-Gm-Message-State: AOJu0YzeLjqxVBlsArbpwtrOmD60zO48wOIsxCt9RfZe310ntkhw9cNc
 y7ftOTy1rkrAjL/HHogQORjSji1IO4Zmi72qrZEnrMFqAbpacl+sjehv7OIf8Z4DKenMeQ5sgOe
 zcc0=
X-Gm-Gg: ASbGncsXE9fCejvP10EWKcghDOnj5y8V2Ld1LixCP+cnQq4495fc8vDoKVe3CM1tO8B
 hmc0/NMtRirnnQ5cRSfzDqMtqqMeI46iGQePLZ4xQo60G1zfG2rhtl8fdHb7OzkVLYXfU9xfyEn
 anB1Tgz19SdFmtsUKxrV3tloLrSpjmlEknWg2ar5cUdefshj2j5c5JgJIl7ERjctLXaC/+dS6bq
 NumLVzzo7fkQ6c3lZV42TDj0y+Hb5Lql5xUzt6E3bI6mHCDZW9/kmP7/UtveXtaeERGR3Y=
X-Google-Smtp-Source: AGHT+IEcAFXW7GZy3x0OqEmMZy8Ryrc8lSpHdM9v8cyFpY90aNapyOG7cd6mbAv8eT8sRVyzaO6Ypw==
X-Received: by 2002:a17:902:d488:b0:212:4ac2:4919 with SMTP id
 d9443c01a7336-219e6e9f9aemr26529555ad.17.1734695171188; 
 Fri, 20 Dec 2024 03:46:11 -0800 (PST)
Received: from localhost.localdomain ([125.71.92.133])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cde7esm27162215ad.152.2024.12.20.03.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 03:46:10 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 2/2] qxl: Fix race on accessing cursor in struct
 SimpleSpiceDisplay
Date: Fri, 20 Dec 2024 19:46:00 +0800
Message-Id: <f5d20cd31c44281a5ec29f8b263ba8c8624b2445.1734695085.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <155c8974fd72403b9b32d3e2827850b7f08937f3.1734695085.git.yong.huang@smartx.com>
References: <155c8974fd72403b9b32d3e2827850b7f08937f3.1734695085.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Both the spice server and the qemu (iothread/main loop) context
can access the cursor field in struct SimpleSpiceDisplay.

Add the mutex lock before accessing cursor in
qxl_spice_reset_cursor().

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/display/qxl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ae2d983299..07e171cb5d 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -28,6 +28,7 @@
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/lockable.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/runstate.h"
 #include "migration/vmstate.h"
@@ -298,10 +299,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
     qemu_mutex_lock(&qxl->track_lock);
     qxl->guest_cursor = 0;
     qemu_mutex_unlock(&qxl->track_lock);
-    if (qxl->ssd.cursor) {
-        cursor_unref(qxl->ssd.cursor);
+    WITH_QEMU_LOCK_GUARD(&qxl->ssd.lock) {
+        if (qxl->ssd.cursor) {
+            cursor_unref(qxl->ssd.cursor);
+        }
+        qxl->ssd.cursor = cursor_builtin_hidden();
     }
-    qxl->ssd.cursor = cursor_builtin_hidden();
 }
 
 static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
-- 
2.39.1


