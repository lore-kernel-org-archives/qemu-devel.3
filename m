Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED55C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8E-0004nN-LT; Thu, 01 May 2025 23:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh83-0004iY-To
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh81-0001J4-Qo
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso1785700b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156716; x=1746761516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAv+aGTQCrwaNulgDta+PXng9GQbHKS2fnPZhRa5POQ=;
 b=CKwqF6oO2KoabzBGbCf54PTh5ECr8ommNlby9g7F65ltU8mq8ZUZTvMA95yAeSNj6G
 XtVCc51ZqDwX0C8zoBmOUYqbYw/+Zng9odIwWS8MLjQK0rwZn1e6d28+rxMlbl5JuvFu
 kzWjqLX8mPQhzo4D7xR41ku3nI4UXMk45NgPGBQhnlp8Fmhk3XQVx3sp2VEyjAryqRV4
 To39cF7TPa3szkq35gLyb2VPdLfp8WUCxToWJhpT/BrX2wA4UNcTUXNxK4KPoTnCMIM+
 VMQYyuy0Rurc1j2Yx1F0OXKFl5UZMqfnG3flxZ+rrby+RioENzXIr8L9u38mSK1aEzHo
 tngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156716; x=1746761516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAv+aGTQCrwaNulgDta+PXng9GQbHKS2fnPZhRa5POQ=;
 b=Iy4Xnub17ZPlZ3qdER6glvVtJ0YXdOtzTFZQo9bJT4lN425x7No9aBeCJh3/7KbzMh
 i3uAtrPQRdddCrm6RKzrZ2eqxvNv3mILjZsCIEn37EnBFSeK9BSo51KfSsQigfVXmh1f
 2KJvxc71fdx4CUAkxsRiXVHqTeVIVJUdxZHzucWBPeJvt2PhVioP8YXMZQePXtzDiUOK
 ZXXrRjWrqSE83c7j+GyhW1akPRPkH0bBxeUT5jHYPGhhOinw6VGesxcUYakC2nwc93ss
 TNUmR7bUayzW+1mbH3uyaCtw30qr+K0TPlqyJdH7ZtA94d1vdDX2AsJ5rai5CU5Ozcgk
 TCMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoGmwEvzJYz7Ayqv9fAYPu6ps/MRXLxPR/DtDD/FlQjeK6nSHbQI+Zlw6FjFbJaU6TrD2ciadVgKuR@nongnu.org
X-Gm-Message-State: AOJu0Yz66cwhYrZfV/pxOukvXgFwjEjzoc/EJNCezop6ilr9meSceDKF
 qhf3GV8CZ+uzehiRxHjMKvvN70aEi7qbE2zwfcpXvphj9a5eGaKIDulnCQ==
X-Gm-Gg: ASbGncvlxYUOB9JZw42pYHU5HE4uqvlanOJH5XvbT7zESr3Zu/ivqHngAabvviPjB7L
 S60/hzybQrFwF2GL/hYisAtmRfGauR9f6zWjlLsF+Q7v2xQPAO1HoszTJiY9v5GdS0G/iQBzFIb
 I3wsBWuf0c4+slBgWa4eikzR89b6K1xM252fQobjKe8TdsgSmgWILk+wiq4W4lLMKM68a57cXbo
 71lJaZ6ttYRYNy0PdUnc9x50ZlVOsjpudoSxh6bR25tUVOHqSFWj+0AGKbZHxYpDNh3B3TKtWKn
 mJTs6CxB1bsA+5Pei2u3RFqv5Qn66vzHFhd7lnMyyfYb
X-Google-Smtp-Source: AGHT+IG7m47e5cg0h0QDZNsDHVQXSy7hw2KvLmbz4m/WCnlu63U+kMK7d/FXqJMiCpzqAn8rUT9QAg==
X-Received: by 2002:a05:6a00:e8f:b0:740:6f6:7338 with SMTP id
 d2e1a72fcca58-7404917149cmr8072520b3a.3.1746156715737; 
 Thu, 01 May 2025 20:31:55 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:55 -0700 (PDT)
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
Subject: [PATCH v4 11/22] usb/msd: Split in and out packet handling
Date: Fri,  2 May 2025 13:30:35 +1000
Message-ID: <20250502033047.102465-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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
index b13fe345c45..394fb8e1ec0 100644
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


