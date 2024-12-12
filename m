Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D9BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGX-0003Xa-MN; Thu, 12 Dec 2024 04:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGU-0003TF-LQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:46 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGP-0008PC-MG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:46 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fcf59a41ddso220385a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994820; x=1734599620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/F55ObCsESGa2ajDHpDHF4jP1HDevLQyTNQkvDxryZY=;
 b=nXoKkm+2nOdmfFP//7wId9Yg5Uym5UVJZKBWkApECe4RyArGJXF1k5jfysigZTAAQ7
 eYcyWWIZ0UJnKOD+JAHHeJa8Xgr5TBMxqeItMYJDXMw2D2IV3g8UQXif2rGqHAYa/dSy
 vpvGqrW8fzhoxKOfPLHLlDWV/MTBy193pZ9Jx5TLeZoKd+k4/doW0izjh/v4gWXqhSCV
 q15Bs12xGBbWlrvp8TD756wiblcw4JJspFnUySMgPWY9Wdm09Hhbj3vinss6Gn9vn8Io
 6WFmN6tIGht670U7ugXB2KS+o5AanxtceOeJrWQlBXA0U1pUQFWbHnH1UqgEnM9zm1Kj
 VROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994820; x=1734599620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/F55ObCsESGa2ajDHpDHF4jP1HDevLQyTNQkvDxryZY=;
 b=bP0vbLbj0b489AiYuBH3GCB97lfO/ACTz+mpoFWll7haSSwh4JxiIn+3BkQDR1W2C7
 W1oQZkeI7Nbx0RmFBuVXSqVos1eRLCvJ54pUFsd6h+9ozfEO2muAtFp3tg35fFujvTMy
 ACa5b9RNz0ft7Q1p5ueJoIuQBN7Aa7L4i9mYsHN/iTR38alTqhujoMHgUYvVvQ1YdRQE
 dY9PWhs6nc4nWi3EpvwD8Sv6zcjtmhb0qBbdE4DCwOzs12YXnArypY/2ute6cUHWTitt
 N5R9sxn2tscbHbhD8fTNFebxm5u441Qq/b3zMwDux7W4SKjItAI8TccTNJouZ2C7Yb4Y
 653A==
X-Gm-Message-State: AOJu0YxsLfwrH3l8LkWT0kaW+BY2thAaJL3TIDac9cqQOHd45kbuZGLp
 +2x+0xRS/bv3eUPWTWUts+A9E9q9WF+5DjVc7zJSW5GjTzNdftdgZHq/7Q==
X-Gm-Gg: ASbGncs8YOnCNdoWA7dIcF2zOdE+/+zbVm0pvZ5cjF8xT2SchMeGHuBcg6Yeznbh8SV
 UcWVPJDtT7kWFqUdWGdWjl3dODdMVhdRg70ASRdyNtZ6q3+gVOYnsZrVF0z4gq9bZSybNP/SWSM
 eyXQbw/qS24/c6CX4yiZtXKoAwG0Br0fZ9zhHiS2azvVeXC5emi5KicF6Laz13+g/nQh/MizqIf
 /ZVKLjvZL2gpscMjYh3EBEOkZ/A7SisVM23+sAcKRY3t+boDk1F1bODVfA=
X-Google-Smtp-Source: AGHT+IGFDtjgOHUxo8g3ghYCgKiRSfX9nQvz+vDR5ly2F/IqbpKwvi3OGVUcH4kDcbFVdCS4nPwHwQ==
X-Received: by 2002:a17:90b:2790:b0:2ee:f80c:688d with SMTP id
 98e67ed59e1d1-2f12802a503mr8811041a91.25.1733994820087; 
 Thu, 12 Dec 2024 01:13:40 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 02/11] usb/msd: Split in and out packet handling
Date: Thu, 12 Dec 2024 19:13:13 +1000
Message-ID: <20241212091323.1442995-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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
2.45.2


