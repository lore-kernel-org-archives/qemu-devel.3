Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0638C3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyhc-0002qA-Tl; Mon, 08 Jul 2024 20:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQyhb-0002oT-8g
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:27:27 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQyhZ-00056B-5m
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:27:27 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70367667576so851062a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720484844; x=1721089644;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55JEYeYHqCAtRP6aBKpZUGS7RpkDu6fd1ymJ5gv2dHI=;
 b=gVFraG+EJ1qFslGuKyQ8fMuQALcohbdRG+UoaZn6Yf3Fw/oNnBJcsajUwUqoi8oEay
 YaatQn+VQGw1RBtgpYo5grbX3fTnc4gcKMQHZJl0ndQ5XqGSZrTgy5lPxZWjOeQNSXAQ
 ZtTfCcj+0Q90wrTsnUa4vVqkJb/qydxiggoVMzpnduwlwuDeXr0oTJV7yqKzR6K91y6L
 PN5c5Gp0j+yCM5KwCJ6/9aZ8lOQvOKE/umXDoB573iCX+WwsnQTKdflY2LyGXk0Rw2MU
 /2rmfiqeSRZYT8sOJZQW9ADDZQx9cVeSLhxIYDH9wyEwT/FXUCCljPTRWZBFzVtKW+Ke
 A3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720484844; x=1721089644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55JEYeYHqCAtRP6aBKpZUGS7RpkDu6fd1ymJ5gv2dHI=;
 b=UYqs+kf8fB1QkycdS8kzzUjFsCjxfhDOdN9rxR0zNbsTQ7mxFeuPeJm8akwJALCPxJ
 iui04trfnsF7blsZDAfCX+FstH8YAknX1P7CF3ent7fNrvhJ7PwwlP49L1WyXgCO/3IY
 /oQrDqD+y4GtV5rnstMovwTAD5B9aDS5evTYsHvatverCcOjOy8OVCWgCLNlcPcGdKoa
 yn+2aQgnfzMkURIasUJ44xUVNB2mdK+h3qNulsPVPf2eWE3AjMqQZL1Kijl+diOimiB/
 Ni6nifnh4onlm6/rJ5E1teDxzyxdPJDmQKGAMRLYjObIosN6gTEtDnaqlfy9ClZ0IBii
 19Ow==
X-Gm-Message-State: AOJu0YxBjqLyn+DA0qg8B6jpum6fexYQo5zTv79wdK85A9Zjld0uTYOV
 l3JXcCsVbSfH15SIfZnxxWPnpCw1LCF5+Yl9iihIDkpPEYUeVTTK0N90sa3Z6nDqlWMWXNbr1an
 OXeUVAg==
X-Google-Smtp-Source: AGHT+IGsiVK9XgPM6qx9jr9NRB4YNCId3ZnLDwdqQrM4NYf8QsgsXxEkFXFO47CNnrOZQQOiiurIxQ==
X-Received: by 2002:a05:6870:b52c:b0:25e:bb5:3216 with SMTP id
 586e51a60fabf-25eaec6e945mr721981fac.52.1720484843089; 
 Mon, 08 Jul 2024 17:27:23 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.207])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d5edcdeb6sm421447a12.17.2024.07.08.17.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:27:22 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	yong.huang@smartx.com
Subject: [PATCH v1 1/1] e1000: Fix the overrun check of the receive ring buffer
Date: Tue,  9 Jul 2024 08:27:14 +0800
Message-Id: <7bba25e24e3fa6608a0d0d8c9b246c98c29e7218.1720458470.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1720458470.git.yong.huang@smartx.com>
References: <cover.1720458470.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x330.google.com
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
put packets into the descriptior of the receive ring buffer,
RDT should not point to that descriptior since it is in the range
of "hardware" handles. While when implementing the emulation of
the e1000 interface, QEMU evaluates thta the receive ring buffer
is full once the RDT equals the RDH.

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

The last few logs of information before the network shuts down:

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

This revert commit e5b8b0d4ba29fe1268ba049519a1b0cf8552a21a
in fact but in a kind of different way.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/net/e1000.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 5012b96464..c2a627ab1a 100644
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
@@ -832,7 +838,7 @@ static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
     int bufs;
     /* Fast-path short packets */
     if (total_size <= s->rxbuf_size) {
-        return s->mac_reg[RDH] != s->mac_reg[RDT];
+        return s->mac_reg[RDH] != s->mac_reg[RDT] || !s->last_overrun;
     }
     if (s->mac_reg[RDH] < s->mac_reg[RDT]) {
         bufs = s->mac_reg[RDT] - s->mac_reg[RDH];
@@ -840,7 +846,7 @@ static bool e1000_has_rxbufs(E1000State *s, size_t total_size)
         bufs = s->mac_reg[RDLEN] /  sizeof(struct e1000_rx_desc) +
             s->mac_reg[RDT] - s->mac_reg[RDH];
     } else {
-        return false;
+        return !s->last_overrun;
     }
     return total_size <= bufs * s->rxbuf_size;
 }
@@ -998,6 +1004,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     } while (desc_offset < total_size);
 
     e1000x_update_rx_total_stats(s->mac_reg, pkt_type, size, total_size);
+    s->last_overrun = s->mac_reg[RDH] == s->mac_reg[RDT];
 
     n = E1000_ICS_RXT0;
     if ((rdt = s->mac_reg[RDT]) < s->mac_reg[RDH])
-- 
2.39.1


