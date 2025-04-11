Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D997C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Ng-0001sC-I3; Fri, 11 Apr 2025 04:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nd-0001qb-78
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Na-0004hW-K3
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22622ddcc35so21874295ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358689; x=1744963489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pVVryayk6KcWQSaSD5Yx1gPCZpLa+a+1UqcEFcEJ0I=;
 b=QXaImOvj3b51voNOJlyqzg1opc0Sogtf+qwAiRcODvGwfLE+JH+LlQ8etNVGkUTSye
 LF0o5lFcReyU0fym12NkksBrNRrMMck0kucDFvgyCfVaCwlTmUgBTf0WD5S9u8AiW4xc
 Bo0VAV2+kzzyj+SoPv5aDpsC9dy2Z3Y6N0qfm6ao+knYOLP6RcPt9e2mIJjbFxaIPVcH
 n1q6Shte+7PDRI9NmjeG9obVKUUR6BV0xW3vUhHVc3+OJ4Y1Wc/WvrAQnuj/IVNDanhQ
 MGOuK4QL3SGLig5rrZtm1SF8R20IFfhI5p5MeugP3FGtjJvF/6mub/C/TgA9JUKJ3mVD
 WvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358689; x=1744963489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pVVryayk6KcWQSaSD5Yx1gPCZpLa+a+1UqcEFcEJ0I=;
 b=DAbPOOXUCyMjZ2zlLjn7MMJFiDu20xmbIWUAX8lflTgK7nog6FOk5SLZA8h975h/vm
 dLMTZ9G923rY4ZvHGNc/+wAWU832UHHsOyQCc/XbiUMlXBPaFir1VtT+NYhI4UW7CCHe
 sGFWguHd8oV1C/HDycGZlt4ppmr+qKOAWVjiclMYnNXigDSyYGGev4reiLRqqrmc8ef/
 O2PtgL5Hke61uw3yM5sI/B3bsDsP7V+CSRqcjx9+tsE++pEVemNabGFhW9Hww/3O/O26
 T5JfQ8rtH4G4ADNlrM2K5Sfw94SpKD8v4rTFxeZVgEtRCwI8dKiIJvWh+cNTANL2vVz2
 CGDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8fA5vFlyePruZbER1Ls2o+opggtgRXD8zuVYiASkx3ErE+FpZsI3faHWgHpa+0SRy/HQbSnZjwNuJ@nongnu.org
X-Gm-Message-State: AOJu0YzlitvjSNDPfHFD/JCc/LJA0hE1JNjslMKkC08lMOOE7KpoMqso
 qvYEm94euAMxQiNGabmre8lxY7NF5XiEr3B82U9V1ys1oN5thaWTr3eTZQ==
X-Gm-Gg: ASbGnctm20zpJF0AmV2q62dDLgfLQEoH/UwsWOsL0JdnYWaPdz0OFfAJrv2UN1yqMQj
 vrShgXCJDzTX3AboqE8tyiLD5x2HMD+CVO4kNhKcqb7mSzeT0FZcJ0jCz0MMDvcjW8KWdjgRQaP
 MoOmXnVIkcl9t6/XT+obFz1PbRE2Y8Dcy6ecei0897GBoBpytJaQ5TrAT7DrfVuJ8WVlyZh1SPy
 cmx8GPBV1XYrrHi5c1Z9uK6g7fOUN+gZ+PR3DI2+KTUTPY8W6Mi1GwaaK6eQrdz6qARX/b1Ravo
 j/CFzfw+U8WpIl9MEoV12xb1gHs3akym3CKXMXvbRLHyemXvMsU0hO8=
X-Google-Smtp-Source: AGHT+IF877CSCG+jQAXpGbA5GvZXltn3M01SV+46b4XjfDeSy16W307R80U6LNcOBVHrSGtXr35A7A==
X-Received: by 2002:a17:903:1b0b:b0:224:910:23f0 with SMTP id
 d9443c01a7336-22bea4fcc31mr31282805ad.49.1744358689006; 
 Fri, 11 Apr 2025 01:04:49 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 04/10] usb/msd: Improve packet validation error logging
Date: Fri, 11 Apr 2025 18:04:25 +1000
Message-ID: <20250411080431.207579-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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
index c7c36ac80fa..6668114ea74 100644
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
@@ -395,6 +396,36 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
     }
 }
 
+static bool try_get_valid_cbw(USBPacket *p, struct usb_msd_cbw *cbw)
+{
+    uint32_t sig;
+
+    if (p->iov.size != 31) {
+        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW size %zu\n",
+                                       p->iov.size);
+        return false;
+    }
+    usb_packet_copy(p, cbw, 31);
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
+    if (p->iov.size < 13) {
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
@@ -405,19 +436,13 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 
     switch (s->mode) {
     case USB_MSDM_CBW:
-        if (p->iov.size != 31) {
-            error_report("usb-msd: Bad CBW size");
-            goto fail;
-        }
-        usb_packet_copy(p, &cbw, 31);
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
@@ -489,9 +514,15 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
     switch (s->mode) {
     case USB_MSDM_DATAOUT:
-        if (s->data_len != 0 || p->iov.size < 13) {
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
@@ -499,7 +530,7 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSDM_CSW:
-        if (p->iov.size < 13) {
+        if (!check_valid_csw(p)) {
             goto fail;
         }
 
-- 
2.47.1


