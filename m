Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55EEC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8r-0006Vj-0g; Thu, 01 May 2025 23:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8n-0006JH-G8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8l-0001NN-JZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so1561517b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156762; x=1746761562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgXoXzj59TwaPm6vHRzhm06dyz3oz8jlzR9jWrrlQMs=;
 b=NvXcpX9teJZhOMILHHKVUACo8HMupwW0bjrCqVc5z9IV9HyAVi0/O13X3w+/11k2xS
 vqSDSL6Cwd7FhpiPbIz0FEU7VhTZ1SSDEh3JybqiTmV853FVXkarhXgHbz/er4PoPlx+
 3RWeBzHmnyRTkCdUYdncZou/ybq1m2d8gbyZHZ6GDN3opHmAEXB0msTnwZueljrVM61c
 z/QuP7ZEjk1//mUDHJHz9z+kQxqLHJcLWzx/sIrZVZniEHGkUuoeNE1cQq8FlyCen1YE
 wTV4I5j0mPlv3aEtE/0zxzAq9wYxK86+vQEeBV5y2HtzU0EJQ3zTTvxxWCn3NcePegnd
 zfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156762; x=1746761562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgXoXzj59TwaPm6vHRzhm06dyz3oz8jlzR9jWrrlQMs=;
 b=ILgWYyK+9ThcLkc/FIhxGDrznmXd28vtKfiWq7p0/jdw7L6MubJNxh1YvmuumshDSP
 MWs0db4RTCYKzRF0Xgo8oeapA9ORvx+IY4oAgzJdqXGzwfV6DQyncCy94/0ioT+6dnxw
 RwnSaLR+ry4aeWSXp1Wez3l9SHjmTFhJKFkvjvJjvB/ULZdNd9BGdpBUQU8AiFEL66MH
 OOZ4725O6B9T0USosc3gLM9uV30xX6n6Q3X1bw1Sy2tk9khInlHwPFenMfQnul7SAPWH
 dxqDNfX5pjymKdejUq1rE/5F3ZIYM1vfDdIp1hHhRFPAEge8JZHQ3Z/1tYPUnJteh1e4
 V7hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjjIq2h5TqamoXeENtcq2x0/8G2pbdPoNz5R9cg8h8xS0F9NUfguzrrJPXYINVtLEXVzn3AvK9M0YS@nongnu.org
X-Gm-Message-State: AOJu0YzfjNmA/Q6l+UTHaGCoxUfa3lLHo/722nU8ydaZJetST41SDjzb
 DNV+itIVHhBqxzXkLd02GubqFAcafmjI3PRN7KTj1tRJ7FeGf3TF
X-Gm-Gg: ASbGncvwfKHHwv9pFgL42twFaE2nB5uPLhuCeny3seITtiy/qJaFQqadv6KEYY32lrf
 zUskMy74A12a0t04b7KV9MJA8vjGm4EuVZ1aKD5UI6Vsl3OdiiNzM8E2erHDLSC+rcFSccuNmio
 I59vAqoahbw/1llyw04OsM0lY/6rW6jKcrde9JU0L41JPd6Sm42PZVJbc+YxLKgpQB1C/OdEqoa
 RsDail3tGUoGwYz2JCo4ZJx3zWRMfVJCcUVyU9gcBxjGCqCdljg/JkVkT7JUlg35Urs05J0XDcS
 5g48fE7VXjdqPNZdp50zqMmmcvUSwvFKvXGcYCbA+0KQ
X-Google-Smtp-Source: AGHT+IE+2/BvVzof1F56X0mn7RzFWp6KPhNSFiqQLEue2wI/t5R941+LlCAjG1tDnJfeGThz4bzIjA==
X-Received: by 2002:a05:6a21:b8a:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-20cdc1ec1d6mr2004234637.0.1746156762219; 
 Thu, 01 May 2025 20:32:42 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:41 -0700 (PDT)
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
Subject: [PATCH v4 20/22] usb/msd: Permit a DATA-IN or CSW packet before CBW
 packet
Date: Fri,  2 May 2025 13:30:44 +1000
Message-ID: <20250502033047.102465-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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
index 6d741e44160..fb430f87afc 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -38,6 +38,7 @@ struct MSDState {
     /* For async completion.  */
     USBPacket *data_packet;
     USBPacket *csw_in_packet;
+    USBPacket *unknown_in_packet;
 
     /* usb-storage only */
     BlockConf conf;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index a2544d2659f..f421bd1f8dd 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -446,6 +446,8 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
         }
     } else if (p == s->csw_in_packet) {
         s->csw_in_packet = NULL;
+    } else if (p == s->unknown_in_packet) {
+        s->unknown_in_packet = NULL;
     } else {
         g_assert_not_reached();
     }
@@ -509,6 +511,19 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
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
@@ -526,6 +541,11 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 
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
@@ -568,8 +588,23 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
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
     case USB_MSD_CBW_NODATA:
     case USB_MSD_CBW_DATAOUT:
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: unknown_in_packet in DATAOUT state");
+            goto fail;
+        }
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -586,6 +621,10 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
         break;
 
     case USB_MSD_CBW_CSW:
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: unknown_in_packet in CSW state");
+            goto fail;
+        }
         if (!check_valid_csw(p)) {
             goto fail;
         }
@@ -603,6 +642,10 @@ static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
 
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


