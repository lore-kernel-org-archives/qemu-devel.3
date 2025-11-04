Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DD9CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDYT-0002fI-Hp; Tue, 04 Nov 2025 04:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1vGDYR-0002eo-Dh
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:42:19 -0500
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1vGDYO-0004X5-1l
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:42:19 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=iPpYtZ/lTtwmH62GzLLo/whDCVzM7t2N22oAv2IRjMg=;
 b=VdTmKM5Jax/X2DIEOCGcTzJdbNDSPW5JRSis4KxkEY94FtUjvSEzyUlKalylfkmoei6mhayJF
 bNtL4xcG/MZkr74D4raE63JH3UBQNpsXnVe1hnFTCf5+OuZi9I7PvsN28SXUpXQfcR8SvAfe29x
 J80Wpu4lCBmeFssg/VkwnBw=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d13N70XN3zLlSN;
 Tue,  4 Nov 2025 17:40:23 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
 by mail.maildlp.com (Postfix) with ESMTPS id 54110140230;
 Tue,  4 Nov 2025 17:41:57 +0800 (CST)
Received: from huawei.com (10.175.104.170) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 17:41:56 +0800
From: zoudongjie <zoudongjie@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <alex.chen@huawei.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <chenjianfei3@huawei.com>, <eric.fangyi@huawei.com>, <renxuming@huawei.com>,
 <suxiaodong1@huawei.com>, <wangjian161@huawei.com>,
 <liuxiangdong5@huawei.com>, <zoudongjie@huawei.com>
Subject: [PATCH] hw/usb/host-libusb: cancel the processing of inflight packets
 correctly
Date: Tue, 4 Nov 2025 17:41:51 +0800
Message-ID: <20251104094151.2218252-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)
Received-SPF: pass client-ip=113.46.200.222;
 envelope-from=zoudongjie@huawei.com; helo=canpmsgout07.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The EHCI controller in QEMU seems to cause a UAF (Use-After-Free) issue when
handling packets from abnormal USB devices. Specifically, when the USB device's
firmware behaves abnormally and causes some initialization requests to block
and time out, passing that USB device through to QEMU's EHCI controller appears
to make the do-while loop in ehci_advance_state repeatedly submit multiple
requests to handle the same packet (this do-while loop is quite complex;
I confirmed the issue by adding logs in usb_host_cancel_packet).

When the virtual machine restarts, QEMU receives the IADD instruction issued
by the VM's kernel and will clean up in-flight packets in ehci_advance_async_state:
ehci_advance_async_state
└── ehci_queues_rip_unseen
    └── ehci_free_queue
        └── ehci_cancel_queue
            └── ehci_free_packet
                └── usb_cancel_packet
                    └── usb_device_cancel_packet
                        └── usb_host_cancel_packet

The cleanup actions in usb_host_cancel_packet mainly include:
1. Finding the first request in the device corresponding to the packet
2. Setting r->p of that request to NULL
3. Calling libusb_cancel_transfer for asynchronous cleanup

In the callback function usb_host_req_complete_ctrl registered to r->xfer, r->p
is checked, and if r->p is NULL, the corresponding handling is skipped. However,
since usb_host_cancel_packet only cleans up the first request handling the
corresponding packet, when there are multiple requests handling the same packet,
after the packet is cleared, other requests triggering the callback will cause
a UAF problem and trigger various QEMU cores.

We've verified that canceling all related requests when canceling a packet can
avoid this issue, but we haven't figured out why QEMU submits multiple requests
to handle the same packet. Do you have any suggestions? Thank you.

Reported by: yefenzheng1@h-partners.com

Signed-off-by: zoudongjie <zoudongjie@huawei.com>
---
 hw/usb/host-libusb.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b74670ae25..b5aab12aee 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -406,18 +406,6 @@ static void usb_host_req_free(USBHostRequest *r)
     g_free(r);
 }
 
-static USBHostRequest *usb_host_req_find(USBHostDevice *s, USBPacket *p)
-{
-    USBHostRequest *r;
-
-    QTAILQ_FOREACH(r, &s->requests, next) {
-        if (r->p == p) {
-            return r;
-        }
-    }
-    return NULL;
-}
-
 static void LIBUSB_CALL usb_host_req_complete_ctrl(struct libusb_transfer *xfer)
 {
     USBHostRequest *r = xfer->user_data;
@@ -1276,7 +1264,7 @@ static void usb_host_unrealize(USBDevice *udev)
 static void usb_host_cancel_packet(USBDevice *udev, USBPacket *p)
 {
     USBHostDevice *s = USB_HOST_DEVICE(udev);
-    USBHostRequest *r;
+    USBHostRequest *r, *next_entry;
 
     if (p->combined) {
         usb_combined_packet_cancel(udev, p);
@@ -1285,10 +1273,17 @@ static void usb_host_cancel_packet(USBDevice *udev, USBPacket *p)
 
     trace_usb_host_req_canceled(s->bus_num, s->addr, p);
 
-    r = usb_host_req_find(s, p);
-    if (r && r->p) {
-        r->p = NULL; /* mark as dead */
-        libusb_cancel_transfer(r->xfer);
+    QTAILQ_FOREACH_SAFE(r, &s->requests, next, next_entry) {
+        if (r->p == p) {
+            if (unlikely(r && r->fake_in_flight)) {
+                usb_host_req_free(r);
+                continue;
+            }
+            if (r && r->p) {
+                r->p = NULL; /* mark as dead */
+                libusb_cancel_transfer(r->xfer);
+            }
+        }
     }
 }
 
-- 
2.33.0


