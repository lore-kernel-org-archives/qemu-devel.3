Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E646C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLUZ-000843-E7; Fri, 07 Feb 2025 05:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgLUX-00082T-VD; Fri, 07 Feb 2025 05:21:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgLUU-0006JZ-BD; Fri, 07 Feb 2025 05:21:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F2C7E737A;
 Fri, 07 Feb 2025 13:20:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1A6F81B0A6C;
 Fri,  7 Feb 2025 13:21:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1030C52D89; Fri, 07 Feb 2025 13:21:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hongren Zheng <i@zenithal.me>,
 Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 47/51] hw/usb/canokey: Fix buffer overflow for OUT
 packet
Date: Fri,  7 Feb 2025 13:21:28 +0300
Message-Id: <20250207102136.2239826-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.9-20250207102509@cover.tls.msk.ru>
References: <qemu-stable-8.2.9-20250207102509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hongren Zheng <i@zenithal.me>

When USBPacket in OUT direction has larger payload
than the ep_out_buffer (of size 512), a buffer overflow
would occur.

It could be fixed by limiting the size of usb_packet_copy
to be at most buffer size. Further optimization gets rid
of the ep_out_buffer and directly uses ep_out as the target
buffer.

This is reported by a security researcher who artificially
constructed an OUT packet of size 2047. The report has gone
through the QEMU security process, and as this device is for
testing purpose and no deployment of it in virtualization
environment is observed, it is triaged not to be a security bug.

Cc: qemu-stable@nongnu.org
Fixes: d7d34918551dc48 ("hw/usb: Add CanoKey Implementation")
Reported-by: Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Signed-off-by: Hongren Zheng <i@zenithal.me>
Message-id: Z4TfMOrZz6IQYl_h@Sun
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 664280abddcb3cacc9c6204706bb739fcc1316f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index b306eeb20e..9af9d4da6e 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -197,8 +197,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
     switch (p->pid) {
     case USB_TOKEN_OUT:
         trace_canokey_handle_data_out(ep_out, p->iov.size);
-        usb_packet_copy(p, key->ep_out_buffer[ep_out], p->iov.size);
         out_pos = 0;
+        /* segment packet into (possibly multiple) ep_out */
         while (out_pos != p->iov.size) {
             /*
              * key->ep_out[ep_out] set by prepare_receive
@@ -207,8 +207,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
              * to be the buffer length
              */
             out_len = MIN(p->iov.size - out_pos, key->ep_out_size[ep_out]);
-            memcpy(key->ep_out[ep_out],
-                    key->ep_out_buffer[ep_out] + out_pos, out_len);
+            /* usb_packet_copy would update the pos offset internally */
+            usb_packet_copy(p, key->ep_out[ep_out], out_len);
             out_pos += out_len;
             /* update ep_out_size to actual len */
             key->ep_out_size[ep_out] = out_len;
diff --git a/hw/usb/canokey.h b/hw/usb/canokey.h
index e528889d33..1b60d73485 100644
--- a/hw/usb/canokey.h
+++ b/hw/usb/canokey.h
@@ -24,8 +24,6 @@
 #define CANOKEY_EP_NUM 3
 /* BULK/INTR IN can be up to 1352 bytes, e.g. get key info */
 #define CANOKEY_EP_IN_BUFFER_SIZE 2048
-/* BULK OUT can be up to 270 bytes, e.g. PIV import cert */
-#define CANOKEY_EP_OUT_BUFFER_SIZE 512
 
 typedef enum {
     CANOKEY_EP_IN_WAIT,
@@ -59,8 +57,6 @@ typedef struct CanoKeyState {
     /* OUT pointer to canokey recv buffer */
     uint8_t *ep_out[CANOKEY_EP_NUM];
     uint32_t ep_out_size[CANOKEY_EP_NUM];
-    /* For large BULK OUT, multiple write to ep_out is needed */
-    uint8_t ep_out_buffer[CANOKEY_EP_NUM][CANOKEY_EP_OUT_BUFFER_SIZE];
 
     /* Properties */
     char *file; /* canokey-file */
-- 
2.39.5


