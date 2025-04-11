Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66598C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39OI-0002Kq-5V; Fri, 11 Apr 2025 04:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39Nq-0001vf-Fr
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39No-0004sT-G8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:05:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227c7e57da2so15886185ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358703; x=1744963503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5KxXH0aWmL69s5RoVMR+W0a38WA9YGEEu19DsVGYxk=;
 b=g9d/mW+Js5fO8/dWGPxDAl6FGeirjkVw8lmizsnsC4wzv8CoWeVP4pdNpfk+Qu6nLQ
 nNm0rtXHV8/ITX/gsrRGLxfHfoSzFQmItH45hhVqi9fMuQwlidi8cQ3zC07Z91xL/p6p
 3dWYb4VFS9Jd8x5bpp86nbMRVYryKPV/HwmlZNNwmwFVMIMBbo+U2SldmJO2Lj27xx8R
 KMkm6HuagETjFWb3+StusA06XOTIFoImgmZDk2zf3MZhmZJ7vR3XY1SXzx11ihvK6YY6
 PxlklANpEYjFCik22A3RzSJpymhfW3UKs0PyouegvWNNiMVGSRWZdzb7tp395me1PYbV
 HulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358703; x=1744963503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5KxXH0aWmL69s5RoVMR+W0a38WA9YGEEu19DsVGYxk=;
 b=cUCpCZdpLWkvzMauh4tH5FXb2SjMgVleDAwKt4rPkGUhqabYAZe3FmmsL9TmWaUHCT
 gGIgkQoAfR4LS9BIiQoylUQ/e0qHp5raG4bEqU/cjTbQ+URHMjFxk+9EbRHTH8neC63r
 L7u2ZFJlHMOpufdUt4n+fwbXi9swNUg/8E3U6Q7LiHmXOzNLKY2hX6jOt+Z70JRSCaBH
 vMrVwIFXefAK/8zffxDq9qDdmuGhVxyT8DVBmg7SR6wPHShMiYOsDtLCA75A2W9LfUM8
 +evXkFGLClzG4K005rHBYBi1CpOk7k0ZXCFrymojC+5fdT32ATI9PatQAbMcsvqxa3Xn
 EFZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqqpy5c+FxNCjvMj6b1Zu7IsqTqIbR0Ybn8JMxKJtpomD6T+yRuXonQwZKvtJUiV0qJLAipXbsw5TP@nongnu.org
X-Gm-Message-State: AOJu0YzmAlb52DByQof2rOIG9lPe+2ibvK6QFGnuma1peeO+SkMkdnLa
 K0D1q3+brRGd5LIm9s+KDygvHgRggDSe7+Ll56i6ytfD8GLEE43t
X-Gm-Gg: ASbGnctJFMN2wokl2Jb3ETYrq2qoMewAeFT69WkeNTxll+Gtd1JAxBIKfvtDOmOuzm/
 os24Ar5RaxwnHOKWQcg9W77O/byqMEnhe0LzwW0Upa+HVTbcsYyVBig1BbUZEqehuApEoIaOPHz
 1+URJFDZq5HtD64VUpEAhBrCCKFr3vy2/xD9qWj/od0S7a1LYvfkGAUhCyB6bGcyj/hOaVbAP/i
 6lzwf7gjuvxFDOx1ABmGKOvk761ReatmHVNSHAmDJYX96BGQKd33LbQMy8f2gwxn0s+EHVYhOeu
 gjBDjONDhI/FA1/DSwiuA7KVfb3IC/avC/zrtu+h4MUl
X-Google-Smtp-Source: AGHT+IEX/FmRf3+ZO6sq+btnGS5rQwl0BCUH3yCme49cIkgzVI3YfQAQ50/sggV6fDycEB3Gm3JfgA==
X-Received: by 2002:a17:902:c945:b0:21f:4c8b:c514 with SMTP id
 d9443c01a7336-22bea5027ecmr25382585ad.45.1744358702847; 
 Fri, 11 Apr 2025 01:05:02 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:05:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 09/10] usb/msd: Permit a DATA-IN or CSW packet before CBW
 packet
Date: Fri, 11 Apr 2025 18:04:30 +1000
Message-ID: <20250411080431.207579-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411080431.207579-1-npiggin@gmail.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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
index ed6d9b70b96..654b9071d33 100644
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
2.47.1


