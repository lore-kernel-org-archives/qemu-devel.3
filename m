Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00145E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGy-0004Kk-MV; Thu, 12 Dec 2024 04:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGu-0004IV-11
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:14 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGs-0000R6-7e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:11 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7fd49d85f82so342207a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994848; x=1734599648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF0Ruicy6t+7yxWOo7B7ymUvW6MQmJKs109VjhgmsiI=;
 b=N92xlc8lxE14M+ayc1hHdCAc6XndBhacamMScETlsYCZfTGvPbI8aUX81VadUYPBF4
 goS3YDg6p67twZGImT21qcTG74lUkzNcogLsQf2tqIghWS3xyt7HqLiVjXw9cqmGonWH
 sTK/yRz9aydrsXahN6frNL85He21ckzOdkhSqk2OOM8h4H5Gj2T9mZzqDXJHAUB9rh/C
 PO+LRGf9J4JDtMZyF1vLOC8nnQPmd+oHjNU/XY8Tl9McdpLRor1/wl/uQO9YPY/uUGXO
 W9aKLmLSwGzVxFEO4zVDlx5lCP/hSnSHU61i33TbxSm3E5wswrDpW6EeJvHp+TIH0jTp
 ShqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994848; x=1734599648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF0Ruicy6t+7yxWOo7B7ymUvW6MQmJKs109VjhgmsiI=;
 b=u4U98PPdooDFQD+4BqswSmrpBDiR6fTriO49pCXDaG8uXBcr7PLsTkx0dkpE1Srpon
 +ulmjGWbJWun5/U4e3uXUngSGumYhZ/m/ZXSbJ23nL/DzV2ZiqgPHsW2dGxWv/5zRi6Z
 Jxwx/GN2eV/stjdHxAbQlJJbxQqFswO74DPe1FtxxVk5ur+IKpJkN3MwVY61UQqv9geS
 amiGU4E6hCQCliHDq0CUp6Ik38SHqFpSHuWyj048uOEJ3AvrRE0d2YOqDOhWjenrASmi
 jRa6IMRVZZ03Rwelxm1mQjFYmrEdWnLE+b5Ahby4USfKdbp6NyIACtL5PRRUSIk5MwFj
 9Xxg==
X-Gm-Message-State: AOJu0YwVx2LhTlhz6C4e/fF+N+Qi5NCZZVLTbUIMVINDsvqFb8hR9Rnv
 Urex2RVFF+sGeyQ1VxTGU8Z88tJq3QTIgzGmWQbUxxi+YymK5LTJGcsxtw==
X-Gm-Gg: ASbGncu4q4XLPrGCXE5NgB6OpSlM883Rllq67eeJg3Upae3kN6r6mJwYl2WrSWMGORY
 lzbaHo6wHsNiEYsMzlkNK8zSXI5I4TcRV0iDaar6UF7U0vykYpHmqYPMynUSJMXf0swCknlCy7e
 UHm+qP0wUamKtoT/rCWxjwEVvVSd1fVeuztTeImkrsvXSi35bG1u+y8BJMOC0O2p+XOadzh17qy
 8B5jJ1qURQlEb+uijMdTopizNjPI87qRdM0J+0mhTo/6lLdg7ZF8sUgqDo=
X-Google-Smtp-Source: AGHT+IFkq1YqooqeTkMOPvAahcbQq8356HxnuTmwNCMg9oc1tm93g8RRSI7RsPbEIYEup+RtlVDYrg==
X-Received: by 2002:a17:90b:3ecd:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-2f1280e0a7fmr9149770a91.32.1733994848453; 
 Thu, 12 Dec 2024 01:14:08 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:14:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 10/11] usb/msd: Permit a DATA-IN or CSW packet before CBW
 packet
Date: Thu, 12 Dec 2024 19:13:21 +1000
Message-ID: <20241212091323.1442995-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

The USB MSD protocol has 3 packets that make up a command, and only one
command may be active at any time.

- CBW to start a command (that contains a SCSI request).
- DATA (IN or OUT) to request data transfer between host and SCSI layer.
- CSW to return status and complete the command.

DATA is omitted if the request has no data.

The QEMU MSD model requires these packets to arrive in this order, CBW,
DATA, CSW. This is the way the state machine is generally described in
the MSD spec, and this must be how most USB stacks operate. Except AIX.

Universal Serial Bus Mass Storage Class Bulk-Only Transport 1.0 contains
one word in one sentence that permits the relaxed ordering:

  3.3 Host/Device Packet Transfer Order
  The host shall send the CBW before the associated Data-Out, and the
  device shall send Data-In after the associated CBW and before the
  associated CSW. The host may request Data-In or CSW before sending the
  associated CBW.

Complicating matters, DATA-IN and CSW are both input packets that arrive
in the same manner, so before a CBW it is impossible to determine if an
IN packet is for data or CSW.

So permit "unusually-ordered" packets by tracking them as an "unknown"
packet until the CBW arrives, then they are categorized into a DATA or
CSW packet.

It is not clear whether the spec permits multiple such packets before
the CBW. This implementation permits only one, which seems to be enough
for AIX.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/usb/msd.h |  1 +
 hw/usb/dev-storage.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index c109544f632..2ed3664b31d 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -37,6 +37,7 @@ struct MSDState {
     /* For async completion.  */
     USBPacket *data_packet;
     USBPacket *csw_in_packet;
+    USBPacket *unknown_in_packet;
 
     /* usb-storage only */
     BlockConf conf;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 801a5d0c680..bc7e007e4fa 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -436,6 +436,8 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
         }
     } else if (p == s->csw_in_packet) {
         s->csw_in_packet = NULL;
+    } else if (p == s->unknown_in_packet) {
+        s->unknown_in_packet = NULL;
     } else {
         g_assert_not_reached();
     }
@@ -499,6 +501,19 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         } else {
             s->cbw_state = USB_MSD_CBW_DATAOUT;
         }
+        if (s->unknown_in_packet) {
+            if (s->cbw_state == USB_MSD_CBW_DATAIN) {
+                /* Must be a DATAIN packet */
+                s->data_packet = s->unknown_in_packet;
+            } else {
+                /* Must be the CSW packet */
+                if (!check_valid_csw(s->unknown_in_packet)) {
+                    goto fail;
+                }
+                s->csw_in_packet = s->unknown_in_packet;
+            }
+            s->unknown_in_packet = NULL;
+        }
         trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
                                  cbw.cmd_len, s->data_len);
         assert(le32_to_cpu(s->csw.residue) == 0);
@@ -516,6 +531,11 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 
     case USB_MSD_CBW_DATAOUT:
         trace_usb_msd_data_out(p->iov.size, s->data_len);
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: unknown_in_packet in DATAOUT state");
+            goto fail;
+        }
+
         if (p->iov.size > s->data_len) {
             goto fail;
         }
@@ -558,7 +578,22 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
     int len;
 
     switch (s->cbw_state) {
+    case USB_MSD_CBW_NONE:
+        if (s->unknown_in_packet) {
+            qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: second IN packet was"
+                                           "received before CBW\n");
+            goto fail;
+        }
+        trace_usb_msd_packet_async();
+        s->unknown_in_packet = p;
+        p->status = USB_RET_ASYNC;
+        break;
+
     case USB_MSD_CBW_DATAOUT:
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: unknown_in_packet in DATAOUT state");
+            goto fail;
+        }
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -575,6 +610,10 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSD_CBW_CSW:
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: unknown_in_packet in DATAOUT state");
+            goto fail;
+        }
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -592,6 +631,10 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
     case USB_MSD_CBW_DATAIN:
         trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: unknown_in_packet in DATAIN state");
+            goto fail;
+        }
         if (s->scsi_len) {
             usb_msd_copy_data(s, p);
         }
-- 
2.45.2


