Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70053C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 20:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPpZj-0003RA-Oj; Fri, 05 Jul 2024 16:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sPpZh-0003Qt-EF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 16:30:33 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sPpZZ-0003Lh-OT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 16:30:33 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70b0e9ee7bcso758427b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720211417; x=1720816217;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzSeRnqQsFkn+txwV9nFx2mIiow8+UQRdPUIhdl501k=;
 b=KCE561WQCm7afe7AI1e6MOrONeT4ightEiJOEXvd2qz4+jLHyRz2bvzzXjSZ/0rn/Y
 cfSs0Ry6gWzgnpqueZl34a6ffRYkOSKFGPLcmyiqJ8/SbKZ/FCXZyO6q0wZqTA57Lqii
 EUKqwr9ULC5imAFqCnsbPdWuLJr5hoPhITCO+98eb99xtCHFWk8HTsGQr99D0AAOlZZf
 k9GccskBTd326W6jORe5gv54FpLUMcK0Jd+0H8mTO0S09SDF2sWGAV6k04RGuYz+NQ7u
 2LKrZiCwHsQn4LNnTIUrOWf/fULKKsS8kVMHItKH8iTj+AmZRMzw0yIENxODYu6F8oCP
 PXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720211417; x=1720816217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzSeRnqQsFkn+txwV9nFx2mIiow8+UQRdPUIhdl501k=;
 b=LICl4/5ZfMOgr0hCUgZJz1vLfOnvjn0yiljjSv8f/pzwg9qOauK9wHMDVKJCJUnq9Q
 lkOsyG0qzia9Pmq443GFxtNBMkMWa1udVQmGLxfFw6cApyrUnUvkLz3q5maD7/U8YRX0
 gRyd/QzoNnl32F/+dR/RbtZdVakWk+gmV0NDDRaYyouMgI1yRqsdQgwKdANFs9VQdp3L
 D3m9gC2ZjwdsgLGcl2hW4bUgu9yG2c8rlKBN2qv7WnxcTx67lSly+MYnBnKpcnbNVsG+
 +4wMfsdGfs+9El5YMV/WHG7OUkryjzy7boRdwfX1y833OdNan+3iNSUO7/YW7XY05jZQ
 lWwA==
X-Gm-Message-State: AOJu0YziOpTnfPhW7fLVdr/81oGCQjw7+q+csosTYyNZv+yOXaCpEhop
 q50rW+cLS3ox0PdUWED6CBa3rx5mZih2H5eU5x291hg68dHYbJe+ZNfzjWbCI2Dbok1cH8XKj6q
 IHurfFA==
X-Google-Smtp-Source: AGHT+IHowJkbCYxtb9qC6KbSzmZlePrP6c2bML0li83Mo0oPIdjsl1qTDRAugQeqpPq4xqi5Dhv5nw==
X-Received: by 2002:a05:6a20:8426:b0:1bd:709:e4cc with SMTP id
 adf61e73a8af0-1c0cc8f677fmr7360354637.38.1720211416203; 
 Fri, 05 Jul 2024 13:30:16 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.207])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a970ce6sm3855487a91.18.2024.07.05.13.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 13:30:15 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	yong.huang@smartx.com
Subject: [PATCH] e1000: Fix the unexpected assumption that the receive buffer
 is full
Date: Sat,  6 Jul 2024 04:30:09 +0800
Message-Id: <c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Unexpected work by certain Windows guests equipped with the e1000
interface can cause the network to go down and never come back up
again unless the guest's interface is reset.

To reproduce the failure:
1. Set up two guests with a Windows 2016 or 2019 server operating
   system.
2. Set up the e1000 interface for the guests.
3. Pressurize the network slightly between two guests using the iPerf tool.

The network goes down after a few days (2-5days), and the issue
is the result of not adhering to the e1000 specification. Refer
to the details of the specification at the following link:
https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf

Chapter 3.2.6 describe the Receive Descriptor Tail register(RDT)
as following:
This register holds a value that is an offset from the base, and
identifies the location beyond the last descriptor hardware can
process. Note that tail should still point to an area in the
descriptor ring (somewhere between RDBA and RDBA + RDLEN).
This is because tail points to the location where software writes
the first new descriptor.

This means that if the provider—in this case, QEMU—has not yet
loaded the packet, RDT should never point to that place. When
implementing the emulation of the e1000 interface, QEMU evaluates
if the receive ring buffer is full once the RDT equals the RDH,
based on the assumption that guest drivers adhere to this
criterion strictly.

We applied the following log patch to assist in analyzing the
issue and eventually obtained the unexpected information.

Log patch:
-----------------------------------------------------------------
|--- a/hw/net/e1000.c
|+++ b/hw/net/e1000.c
|@@ -836,6 +836,9 @@ e1000_set_link_status(NetClientState *nc)
| static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
| {
|     int bufs;
|+    DBGOUT(RX, "rxbuf_size = %u, s->mac_reg[RDLEN] = %u, s->mac_reg[RDH] = %u, s->mac_reg[RDT] = %u\n",
|+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->mac_reg[RDT]);
|+
|     /* Fast-path short packets */
|     if (total_size <= s->rxbuf_size) {
|         if (s->mac_reg[RDH] == s->mac_reg[RDT] && s->last_overrun)
|@@ -1022,6 +1025,9 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
|         s->rxbuf_min_shift)
|         n |= E1000_ICS_RXDMT0;
|
|+    DBGOUT(RX, "rxbuf_size = %u, s->mac_reg[RDLEN] = %u, s->mac_reg[RDH] = %u, s->mac_reg[RDT] = %u\n",
|+           s->rxbuf_size, s->mac_reg[RDLEN], s->mac_reg[RDH], s->mac_reg[RDT]);
|+
-----------------------------------------------------------------

The last few logs of information when the network is down:

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 897, s->mac_reg[RDT] = 885
<- the receive ring buffer is checked for fullness in the
e1000_has_rxbufs function, not full.

e1000: total_size = 64, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 898, s->mac_reg[RDT] = 885
<- RDT stays the same, RDH updates to 898, and 1 descriptor
utilized after putting the packet to ring buffer.

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 898, s->mac_reg[RDT] = 885
<- the receive ring buffer is checked for fullness in the
e1000_has_rxbufs function, not full.

e1000: total_size = 64, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 899, s->mac_reg[RDT] = 885
<- RDT stays the same, RDH updates to 899, and 1 descriptor
utilized after putting the packet to ring buffer.

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 899, s->mac_reg[RDT] = 885
<- the receive ring buffer is checked for fullness in the
e1000_has_rxbufs function, not full.

e1000: total_size = 64, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 900, s->mac_reg[RDT] = 885
<- RDT stays the same, RDH updates to 900 , and 1 descriptor
utilized after putting the packet to ring buffer.

e1000: total_size = 1, rxbuf_size = 2048, s->mac_reg[RDLEN] = 16384, s->mac_reg[RDH] = 900, s->mac_reg[RDT] = 900
<- The ring is full, according to e1000_has_rxbufs, because
of the RDT update to 900 and equals RDH ! But in reality,
the state of the ring buffer is empty because the producer
only used one descriptor the last time, and the ring buffer
was not full after that.

To sum up, QEMU claims that the receive ring buffer is full
in the aforementioned scenario, placing the packet in the
self-maintained queue and unregistering the tap device's
readable fd handler and then waiting for the guest to consume
the receive ring buffer. This brings down the network since
guests have nothing to consume and never update the RDT
location.

In the above scenario, QEMU assert that the ring is full,
put the packet on the queue, unregister the readable fd
handler of the tap device, waiting the guest to consume
the receive ring. While, guest have nothing to consume
on the receive ring and never update the RDT location,
this makes the network down.

To get around this issue, just mark the overrun if RDH
equals RDT at the end of placing the packet on the ring
buffer for the producer.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/net/e1000.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 5012b96464..f80cb70283 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -126,6 +126,12 @@ struct E1000State_st {
 
     QEMUTimer *flush_queue_timer;
 
+    /*
+     * Indicate that the receive circular buffer queue overrun
+     * the last time hardware produced packets.
+     */
+    bool last_overrun;
+
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
 #define E1000_FLAG_MAC_BIT 2
 #define E1000_FLAG_TSO_BIT 3
@@ -832,7 +838,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
     int bufs;
     /* Fast-path short packets */
     if (total_size <= s->rxbuf_size) {
-        return s->mac_reg[RDH] != s->mac_reg[RDT];
+        if (s->mac_reg[RDH] == s->mac_reg[RDT] && s->last_overrun) {
+            return false;
+        }
+
+        DBGOUT(RX, "Receive ring buffer is not full unexpectedly!\n");
+        return true;
     }
     if (s->mac_reg[RDH] < s->mac_reg[RDT]) {
         bufs = s->mac_reg[RDT] - s->mac_reg[RDH];
@@ -840,7 +851,12 @@ static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
         bufs = s->mac_reg[RDLEN] /  sizeof(struct e1000_rx_desc) +
             s->mac_reg[RDT] - s->mac_reg[RDH];
     } else {
-        return false;
+        if (s->last_overrun) {
+            return false;
+        }
+
+        DBGOUT(RX, "Receive ring buffer is not full unexpectedly!\n");
+        return true;
     }
     return total_size <= bufs * s->rxbuf_size;
 }
@@ -999,6 +1015,8 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
 
     e1000x_update_rx_total_stats(s->mac_reg, pkt_type, size, total_size);
 
+    s->last_overrun = (s->mac_reg[RDH] == s->mac_reg[RDT]) ? true : false;
+
     n = E1000_ICS_RXT0;
     if ((rdt = s->mac_reg[RDT]) < s->mac_reg[RDH])
         rdt += s->mac_reg[RDLEN] / sizeof(desc);
-- 
2.39.1


