Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9925FC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Na-0001pa-Kp; Fri, 11 Apr 2025 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39NU-0001p9-Cr
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39NS-0004gI-3d
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224341bbc1dso16194265ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358681; x=1744963481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WKAS2lW3F9cGbzI+GOHbYGkJMNKj458fWBIwWUCpIs=;
 b=fs8tF9Om8mIb3RS7k1fTSwZPPGJPr6wh6dY79UD9MlS/bdZ/qbr/VHJcEEDVad1Gkj
 WlHIpdZU2i/wDxcnooXXG5u4iXso3d7ykAu8g6lAzU1W3KdtTH0bKMMsixvkFU1lLDsn
 IWloro35pyKqahXu2fnYiRkjFFbrx2Ct+Cv5pvKq9eUopBLXpd1C2D/FC3gmaLJQi6yj
 +yY+jEi/Kt/ftv+2OVXazik8SShXpmyO07lqEm6OtmDdmWRqxDv3gSZPTdumydvAnezS
 lnjYwLw3DoQpZS+7v6MwYaVFyqJX6eARqDCDTdIJki6CJ7v1JMFZ3lQDhGNjkhzF4IJW
 JaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358681; x=1744963481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WKAS2lW3F9cGbzI+GOHbYGkJMNKj458fWBIwWUCpIs=;
 b=pCYz4HZCeLKct2N15ogPbJ2c8UAlncw4YFF+kfsfd0JyuzLKljZ9gpAJFPlCiP54NX
 BUYfBO9gyQZGor45/DIZd+mDenxMk8USCEOtGHaVnFO1xWMKpLDxPcNKshOAx6uYuccO
 zwilGJelWbtiCdZSzj4dcpvkvOcxzCsne1hxY1awEkxY3rY1F/uwHNcmyiz295Ec7V0j
 syDOEL6zPPOYrKmoOLgjUH1HqKdArblxUuIUDVBKXeRp9k2RnXQ41ZTrXGAallCRRWKY
 4QTXLSg6M58dxXmqXFxStBE+sriJqJ6fGTD4rcWhx9W6fcDBIVBu5ooWUDuvrwmIGldh
 TRlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaukBHMtaqyH0Ype5t1HK/qsLrkwPtr0Yr9q3tEhU41rM/70wX3c8+9Gabv1xK5YNbPxmEwWon/ydv@nongnu.org
X-Gm-Message-State: AOJu0YzvGrpWV3aTjbHoVil2hjqSSUD05oQytTLkzHG4QQBIfqxsv53R
 waZGwDJEL0dxrRARUzr+LPLj1E1HaH/clYWlooR2bUQ1UaNgr5xYocauaw==
X-Gm-Gg: ASbGncu1EqOHRouTMr40iwVMnCf0yyrzTfI3TJEi7mcDjA0g9CSFKKu8yS5xQxTKYpB
 YxLcfXeF5cQ8iZVZVmz5pIUFadA7DbYoyZ4DBknl0Io0MuHvPlL2tVPP+PEy9eybi2eUNzFSAKp
 wIJ2kDaHUJR6GG0ghuJwuPpskkmnrjzduVAGA4k83JDh1TtW+c5pQCnL2N48W6ieN1W4VDbWz+O
 U8velhFQdFXr+RvkeVFECYGxcpKchzX8C6HVTiIdufaUY4zfNZ4AVw6W3L6hC3hGh5TLEpY5O2k
 0qHjf+RFw3iY1SEDB+HwqaeScSzskszB3WLJXO//HSz9
X-Google-Smtp-Source: AGHT+IHWyZqUhg0vdL+1tKkfn9IHvpu8o+3ecO+WfpidO+FfwXLXbRUB6J+3w0kl60RLqjcLunm5gw==
X-Received: by 2002:a17:902:ef12:b0:223:fb3a:8647 with SMTP id
 d9443c01a7336-22bea4f2773mr31303755ad.41.1744358680704; 
 Fri, 11 Apr 2025 01:04:40 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 01/10] usb/msd: Split in and out packet handling
Date: Fri, 11 Apr 2025 18:04:22 +1000
Message-ID: <20250411080431.207579-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

Split in and out packet handling int otheir own functions, to make
them a bit more managable.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 266 +++++++++++++++++++++++--------------------
 1 file changed, 145 insertions(+), 121 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 4f1e8b7f6cb..2d7306b0572 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -395,158 +395,182 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
+static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = (MSDState *)dev;
     uint32_t tag;
     struct usb_msd_cbw cbw;
-    uint8_t devep = p->ep->nr;
     SCSIDevice *scsi_dev;
     int len;
 
-    if (s->needs_reset) {
-        p->status = USB_RET_STALL;
-        return;
-    }
+    switch (s->mode) {
+    case USB_MSDM_CBW:
+        if (p->iov.size != 31) {
+            error_report("usb-msd: Bad CBW size");
+            goto fail;
+        }
+        usb_packet_copy(p, &cbw, 31);
+        if (le32_to_cpu(cbw.sig) != 0x43425355) {
+            error_report("usb-msd: Bad signature %08x",
+                         le32_to_cpu(cbw.sig));
+            goto fail;
+        }
+        scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
+        if (scsi_dev == NULL) {
+            error_report("usb-msd: Bad LUN %d", cbw.lun);
+            goto fail;
+        }
+        tag = le32_to_cpu(cbw.tag);
+        s->data_len = le32_to_cpu(cbw.data_len);
+        if (s->data_len == 0) {
+            s->mode = USB_MSDM_CSW;
+        } else if (cbw.flags & 0x80) {
+            s->mode = USB_MSDM_DATAIN;
+        } else {
+            s->mode = USB_MSDM_DATAOUT;
+        }
+        trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
+                                 cbw.cmd_len, s->data_len);
+        assert(le32_to_cpu(s->csw.residue) == 0);
+        s->scsi_len = 0;
+        s->req = scsi_req_new(scsi_dev, tag, cbw.lun,
+                              cbw.cmd, cbw.cmd_len, NULL);
+        if (s->commandlog) {
+            scsi_req_print(s->req);
+        }
+        len = scsi_req_enqueue(s->req);
+        if (len) {
+            scsi_req_continue(s->req);
+        }
+        break;
 
-    switch (p->pid) {
-    case USB_TOKEN_OUT:
-        if (devep != 2)
+    case USB_MSDM_DATAOUT:
+        trace_usb_msd_data_out(p->iov.size, s->data_len);
+        if (p->iov.size > s->data_len) {
             goto fail;
+        }
 
-        switch (s->mode) {
-        case USB_MSDM_CBW:
-            if (p->iov.size != 31) {
-                error_report("usb-msd: Bad CBW size");
-                goto fail;
-            }
-            usb_packet_copy(p, &cbw, 31);
-            if (le32_to_cpu(cbw.sig) != 0x43425355) {
-                error_report("usb-msd: Bad signature %08x",
-                             le32_to_cpu(cbw.sig));
-                goto fail;
-            }
-            scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
-            if (scsi_dev == NULL) {
-                error_report("usb-msd: Bad LUN %d", cbw.lun);
-                goto fail;
-            }
-            tag = le32_to_cpu(cbw.tag);
-            s->data_len = le32_to_cpu(cbw.data_len);
-            if (s->data_len == 0) {
-                s->mode = USB_MSDM_CSW;
-            } else if (cbw.flags & 0x80) {
-                s->mode = USB_MSDM_DATAIN;
-            } else {
-                s->mode = USB_MSDM_DATAOUT;
-            }
-            trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
-                                     cbw.cmd_len, s->data_len);
-            assert(le32_to_cpu(s->csw.residue) == 0);
-            s->scsi_len = 0;
-            s->req = scsi_req_new(scsi_dev, tag, cbw.lun, cbw.cmd, cbw.cmd_len, NULL);
-            if (s->commandlog) {
-                scsi_req_print(s->req);
-            }
-            len = scsi_req_enqueue(s->req);
+        if (s->scsi_len) {
+            usb_msd_copy_data(s, p);
+        }
+        if (le32_to_cpu(s->csw.residue)) {
+            len = p->iov.size - p->actual_length;
             if (len) {
-                scsi_req_continue(s->req);
+                usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
+                }
+                s->data_len -= len;
+                if (s->data_len == 0) {
+                    s->mode = USB_MSDM_CSW;
+                }
             }
-            break;
+        }
+        if (p->actual_length < p->iov.size) {
+            trace_usb_msd_packet_async();
+            s->packet = p;
+            p->status = USB_RET_ASYNC;
+        }
+        break;
 
-        case USB_MSDM_DATAOUT:
-            trace_usb_msd_data_out(p->iov.size, s->data_len);
-            if (p->iov.size > s->data_len) {
-                goto fail;
-            }
+    default:
+        goto fail;
+    }
+    return;
 
-            if (s->scsi_len) {
-                usb_msd_copy_data(s, p);
-            }
-            if (le32_to_cpu(s->csw.residue)) {
-                len = p->iov.size - p->actual_length;
-                if (len) {
-                    usb_packet_skip(p, len);
-                    if (len > s->data_len) {
-                        len = s->data_len;
-                    }
-                    s->data_len -= len;
-                    if (s->data_len == 0) {
-                        s->mode = USB_MSDM_CSW;
-                    }
-                }
-            }
-            if (p->actual_length < p->iov.size) {
-                trace_usb_msd_packet_async();
-                s->packet = p;
-                p->status = USB_RET_ASYNC;
-            }
-            break;
+fail:
+    p->status = USB_RET_STALL;
+}
 
-        default:
+static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
+{
+    MSDState *s = (MSDState *)dev;
+    int len;
+
+    switch (s->mode) {
+    case USB_MSDM_DATAOUT:
+        if (s->data_len != 0 || p->iov.size < 13) {
             goto fail;
         }
+        /* Waiting for SCSI write to complete.  */
+        trace_usb_msd_packet_async();
+        s->packet = p;
+        p->status = USB_RET_ASYNC;
         break;
 
-    case USB_TOKEN_IN:
-        if (devep != 1)
+    case USB_MSDM_CSW:
+        if (p->iov.size < 13) {
             goto fail;
+        }
 
-        switch (s->mode) {
-        case USB_MSDM_DATAOUT:
-            if (s->data_len != 0 || p->iov.size < 13) {
-                goto fail;
-            }
-            /* Waiting for SCSI write to complete.  */
+        if (s->req) {
+            /* still in flight */
             trace_usb_msd_packet_async();
             s->packet = p;
             p->status = USB_RET_ASYNC;
-            break;
+        } else {
+            usb_msd_send_status(s, p);
+            s->mode = USB_MSDM_CBW;
+        }
+        break;
 
-        case USB_MSDM_CSW:
-            if (p->iov.size < 13) {
-                goto fail;
+    case USB_MSDM_DATAIN:
+        trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
+        if (s->scsi_len) {
+            usb_msd_copy_data(s, p);
+        }
+        if (le32_to_cpu(s->csw.residue)) {
+            len = p->iov.size - p->actual_length;
+            if (len) {
+                usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
+                }
+                s->data_len -= len;
+                if (s->data_len == 0) {
+                    s->mode = USB_MSDM_CSW;
+                }
             }
+        }
+        if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
+            trace_usb_msd_packet_async();
+            s->packet = p;
+            p->status = USB_RET_ASYNC;
+        }
+        break;
 
-            if (s->req) {
-                /* still in flight */
-                trace_usb_msd_packet_async();
-                s->packet = p;
-                p->status = USB_RET_ASYNC;
-            } else {
-                usb_msd_send_status(s, p);
-                s->mode = USB_MSDM_CBW;
-            }
-            break;
+    default:
+        goto fail;
+    }
+    return;
 
-        case USB_MSDM_DATAIN:
-            trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
-            if (s->scsi_len) {
-                usb_msd_copy_data(s, p);
-            }
-            if (le32_to_cpu(s->csw.residue)) {
-                len = p->iov.size - p->actual_length;
-                if (len) {
-                    usb_packet_skip(p, len);
-                    if (len > s->data_len) {
-                        len = s->data_len;
-                    }
-                    s->data_len -= len;
-                    if (s->data_len == 0) {
-                        s->mode = USB_MSDM_CSW;
-                    }
-                }
-            }
-            if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
-                trace_usb_msd_packet_async();
-                s->packet = p;
-                p->status = USB_RET_ASYNC;
-            }
-            break;
+fail:
+    p->status = USB_RET_STALL;
+}
+
+static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
+{
+    MSDState *s = (MSDState *)dev;
+    uint8_t devep = p->ep->nr;
 
-        default:
+    if (s->needs_reset) {
+        p->status = USB_RET_STALL;
+        return;
+    }
+
+    switch (p->pid) {
+    case USB_TOKEN_OUT:
+        if (devep != 2) {
+            goto fail;
+        }
+        usb_msd_handle_data_out(dev, p);
+        break;
+
+    case USB_TOKEN_IN:
+        if (devep != 1) {
             goto fail;
         }
+        usb_msd_handle_data_in(dev, p);
         break;
 
     default:
-- 
2.47.1


