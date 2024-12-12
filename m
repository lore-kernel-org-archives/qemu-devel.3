Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD11E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGd-0003u3-Be; Thu, 12 Dec 2024 04:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGc-0003lY-2N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:54 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGa-0008Qc-Cj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:53 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so295345a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994830; x=1734599630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+NlZz6w0HTcOx1pynFp4oSUBV7Ez0wh9zENi+SUzMQ=;
 b=MuCx3Li1skKvNbfT3Bh2Nv4wrur+rlN8OjgUh2/FltfET9S1TFMjgtuQWmPis37b4G
 3NhbGrRBYWYTgzJKBwW/OrgQEek5i+vo7LLDN8YE616mmztZyeP1QulRFxRf6erpjPuM
 qDLX8H8ac0Ia6qUH+WaRklq/DXhenMmV3UxM6CyhGU97fn9DnhuxAkLAGovSvihOr+1I
 JLgcou7DY88L778Hj58up5v3zez4AHDlYyci5Puu0WJp+tAMGSStKjO3QYeeolqo5ljZ
 otmQZpcX5RT8OJorBqDx6VVYF8wgaBTFdtanSBHF216tbvTCiXD7/0hH6WRetjUO7UtL
 WLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994830; x=1734599630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+NlZz6w0HTcOx1pynFp4oSUBV7Ez0wh9zENi+SUzMQ=;
 b=qbqyHgjPlhcXicZSK1BXuhMT1jakRCRTB2gNJeeCyN59CtZ7aWDAowF+OBNeKgRckW
 nUWCZnQ2UkYrxK9Nab0HjfI3oTJ2mZU9SJCkQ8LaziZEtlguEuWBNP08PY12NEyjo2+V
 tAOHJbPLCb2o+xBtitbNX4Dy5IBa1vsTe4b2F9PANNFT7LnwloIkq7RXWDJkvx7/vsNB
 x4lWXom6Aqxax5pUGwYijqR+nmUtdn2zqv0nh8NCThe7CeTdqTqM3pi3NmXOw/Y/g6+9
 RoVM55OE/NkV4Xtgnp+EDu8GjgxJefyGx60m/crWcJpesCpplcbNn56EfH2+30iYjluH
 ZoPA==
X-Gm-Message-State: AOJu0YzgnIuFRL2kd7coujcbnLvwc8eSBdbq7krmby2D6cpw3zjIKjC/
 9H12955gDROfk3pgOEJqlbE8bgZEy7eGNKg8HukfcEjHv8tR89Kk0tysgw==
X-Gm-Gg: ASbGnct/B+rP6DdCvtRzbzTZ2LWi+Hne5xs8CZ9wiVs5wOJfAnw7nLDNcTPZSzv/3/S
 JHCsIna677Lv2SraVSvlU5HK2omw2+bLe65+sfrUzQnE7a99WNIGzzqSC4nsAOrFKvwiLiooDZR
 Jt7PW1xYLQFnn+fN6RzJzIc67wQ2MGAQ0GsI/kmp5eWaFbMXCeLAG5YNPorqp3Nx2vKDA2ERsdK
 g6UJnn4pyS/pxXCWqJJJZjGqi257Hxx+5Tq3NIcLPKuxlds+bJGHA8szdw=
X-Google-Smtp-Source: AGHT+IGuk9aHNaAMxQs0+9YnGihF7yHZjUJAUFmZR2GOuOhig8j5D6vh6crKXOOaNdCXCAVdyLwYBw==
X-Received: by 2002:a17:90b:3e89:b0:2ee:c059:7de3 with SMTP id
 98e67ed59e1d1-2f127fe770cmr9084884a91.18.1733994830268; 
 Thu, 12 Dec 2024 01:13:50 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 05/11] usb/msd: Improve packet validation error logging
Date: Thu, 12 Dec 2024 19:13:16 +1000
Message-ID: <20241212091323.1442995-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
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
index c7c36ac80fa..af9eb7ea8a5 100644
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
+        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW size %ld\n",
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
+        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CSW size %ld\n",
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
2.45.2


