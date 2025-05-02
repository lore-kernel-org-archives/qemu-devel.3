Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198FDC3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8O-0005HK-Qx; Thu, 01 May 2025 23:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8K-0004tt-EA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8I-0001KN-0q
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so1507747b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156731; x=1746761531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvZGBCpwgyIhQnVbt40juvV6gQDetZ0AELHdCIOiZlg=;
 b=QIfwgNTSZQad8lLGHkve8W4EghZJflWYmXd90/Z6uPvANXWbpRmZ0qihaBdQuDEDv+
 E3ai8/ikpvxbqxhkh9FpeTPX1imFvYmG6KozomeVCa/fvuWQ85wNZtWHJpmqWaBYYG27
 MYD+RqnA+Ao2nz7BCjQEVeeFcYBXhlhqw6MbbHznWg5ELZL3MB16XBpi45RmYZlCZblI
 Lh+8QX7Sl09xTWJLUYlhjaCXLofcp1ZvDi5zr6+xglXX1zBcb0o5+C+Id8sBSSB6pX2y
 3WyOnlNuopJKm1UV03Wh5dQykudryZNz6Wi0vvcYKCMgaA47Rnlm7ecyeNkvWx8YCHGm
 dIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156731; x=1746761531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvZGBCpwgyIhQnVbt40juvV6gQDetZ0AELHdCIOiZlg=;
 b=KZhn3Tr2TGEm9gmL1/RhVxkGe6aJreNwSGE9+lDfX138mivZdORPCU4zeGRbIjTwk/
 aWbVYcDIVIzvCee4+0TE2KxBA4LV4jr+rLUeTmDR4jHyzO5mpNMeLCuhl35bdEfp3BHm
 hNrru79eAkBEvmYGj2jnXu/9ITBEd7Ov/4eVzocMrmT9gan1uAUsd6ekJIiYM8U1O5Cv
 gIui8L11YYXYP5haMxIUTZUFHfySnf74smht5S5sWgNzMYxWwixid41y0+6pvBQgrbot
 cFrej7eY0lBfy/F4gJdSQhSK1StwJtlf1uKHV9hG08SuyGEuiCLwwY4Rj/CtHhyfXmk3
 SN9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uLzrwPknSsTL5YcUk327Ovcc97QQiQloJvvYY6cpKEEUJxCK8WEdUyqLja2AGvmSLJwvK1HfFqfL@nongnu.org
X-Gm-Message-State: AOJu0YxPf/Wzo6dIDIN7LXXYWmAeYXxD2M+cD0Ss9kOgSwV/iTruKEUV
 V1n84oICIs4CWZgnZmqKVkyWUbSuBN0gWgje004ChZf0KNUiF28M
X-Gm-Gg: ASbGncshy3Qwfxezzc8sktUjFgXypz0ITLcSuZgrhXaAqF+u79PwxOuos6gSLvQHZy2
 fd+cM5XcxDpmFG9hXQ/WHYrM63wQ2brG4KZaLZMZPAFRHpmXs39MoSCW8iE+zfS3x+B/wT2dg/h
 wUPuH94++Cp8tijiGcGntkpuNEGzqaZJBakdlFieX2UhMvc8Zi8lpJ0wJn1aJELajl45t8uzQ6T
 Ml9A3/E2qMaVVZw6Y1W99V68cS5O5pxCUKiin4IpyhZJsVogTPpb6DYf6cLWvslDmgapnvC8Ebq
 CfndcSLmI+IX2lSjuu2yx3LmRCmSHsABzCSrVdEZMjaY
X-Google-Smtp-Source: AGHT+IE1E14jsRF4MO3tuPlO10Mjgz2dV4kZctL+gBHEFTAwF1RzqZu3l58C+jVjMQxhcTqhxmV6PQ==
X-Received: by 2002:a05:6a00:8d86:b0:73c:b86:b47f with SMTP id
 d2e1a72fcca58-740589026cemr1881129b3a.4.1746156731228; 
 Thu, 01 May 2025 20:32:11 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 14/22] usb/msd: Improve packet validation error logging
Date: Fri,  2 May 2025 13:30:38 +1000
Message-ID: <20250502033047.102465-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Errors in incoming USB MSD packet format or context would typically
be guest software errors. Log these under guest errors.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 53 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index fda14271eae..7bc2f7664b2 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -402,6 +403,36 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
     }
 }
 
+static bool try_get_valid_cbw(USBPacket *p, struct usb_msd_cbw *cbw)
+{
+    uint32_t sig;
+
+    if (p->iov.size != CBW_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW size %zu\n",
+                                       p->iov.size);
+        return false;
+    }
+    usb_packet_copy(p, cbw, CBW_SIZE);
+    sig = le32_to_cpu(cbw->sig);
+    if (sig != 0x43425355) {
+        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW signature 0x%08x\n",
+                                       sig);
+        return false;
+    }
+
+    return true;
+}
+
+static bool check_valid_csw(USBPacket *p)
+{
+    if (p->iov.size < CSW_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CSW size %zu\n",
+                      p->iov.size);
+        return false;
+    }
+    return true;
+}
+
 static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = (MSDState *)dev;
@@ -412,19 +443,13 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 
     switch (s->mode) {
     case USB_MSDM_CBW:
-        if (p->iov.size != CBW_SIZE) {
-            error_report("usb-msd: Bad CBW size");
-            goto fail;
-        }
-        usb_packet_copy(p, &cbw, CBW_SIZE);
-        if (le32_to_cpu(cbw.sig) != 0x43425355) {
-            error_report("usb-msd: Bad signature %08x",
-                         le32_to_cpu(cbw.sig));
+        if (!try_get_valid_cbw(p, &cbw)) {
             goto fail;
         }
         scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
         if (scsi_dev == NULL) {
-            error_report("usb-msd: Bad LUN %d", cbw.lun);
+            qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW LUN %d\n",
+                                           cbw.lun);
             goto fail;
         }
         tag = le32_to_cpu(cbw.tag);
@@ -496,9 +521,15 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
     switch (s->mode) {
     case USB_MSDM_DATAOUT:
-        if (s->data_len != 0 || p->iov.size < CSW_SIZE) {
+        if (!check_valid_csw(p)) {
+            goto fail;
+        }
+        if (s->data_len != 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: CSW received before "
+                                           "all data was sent\n");
             goto fail;
         }
+
         /* Waiting for SCSI write to complete.  */
         trace_usb_msd_packet_async();
         s->packet = p;
@@ -506,7 +537,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSDM_CSW:
-        if (p->iov.size < CSW_SIZE) {
+        if (!check_valid_csw(p)) {
             goto fail;
         }
 
-- 
2.47.1


