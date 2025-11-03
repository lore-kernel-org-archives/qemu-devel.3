Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AC6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFypd-0004DI-Vm; Mon, 03 Nov 2025 12:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypc-0004CS-62
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypX-0005pI-EH
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so25442795e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 09:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762192735; x=1762797535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOziFvei/g07QpuUcHg/XdNOdDOG39Ux4/XNM8GNFZM=;
 b=fQdxX9lBRt2IobjIc60fJ5rhqShmoeb136vhfANWh6vuLHHja590gRrme3VnVz645z
 e2s3n3A8f5yZyDPadmkb7QKwtUeHlrR3HRib3ZafCWEoXUBRGEV8x0WVVXrdwDkO7v5X
 Wdg+PnBq8MZaFX/yFFe71ZFWLwaNz3sTiOl++pBliNglFg7VqKHrFk7kwxIhWxTAVJQ9
 xsMCgFqDfhxzzR+ich8+bmV0lhW3xhotpUJ3c+0mFKc0yhha5hquynj4O3evYf7Y+COx
 w/flYVUtfJqLupI0LyyyJY8nIsiCeKbnIHfmg6TQS7eBbjfypNXsQeYOcPxV/E/HQxxH
 ucxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762192735; x=1762797535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOziFvei/g07QpuUcHg/XdNOdDOG39Ux4/XNM8GNFZM=;
 b=EWqQj+Q5WkgaGmHCp1XiKUuNLqsH7E1SmmYF+7VvtP1yRlHvBgRHGxX8jD5lPvBQ+K
 NmUzIreDUpYq55VjJA/sdxhMQEa/rzLu7RCBvRUTe64V6XTetAnBYIlKsoql7/d4Yorf
 tnNLRG1mMeiYyqq3Gxu6dWdbAwj97mdTQaq6QTH/yWLb2Khe03uxQok3p9SVHJ/vY/ar
 HEI5ijeFUcp0LWylo8ETRXmLgk4edm0nT/OupGil1m5kUsKLfmtR3LM0gm2lwU9vysNK
 ORgxrBwRA8R81TEXCahfOsGqrSYD6HrPFHjp3lY3Lu9bP4A7Fd6IPGsusUlAlysHzCqV
 lJRw==
X-Gm-Message-State: AOJu0Yzk95+5Chiols02t8nkdaOOALmTRxGRuCFqDsphp6AzcztoKzoZ
 IipIjdtfRxAcULBAyNcjgExY/BKLhJ1LxPCBHJJMtBhaxrIcqk6rOxTBH1rjprctILVR9+PfCHr
 4wLwj
X-Gm-Gg: ASbGncuNJldwKqjU6RnYSud9ndeoRLy29MOuGCe8kdMXouQfP1LowdTbGESSb2r9EcX
 q8j5ry3qnn7PeVuXUKNNMJ/JVv/Tpd8j37RG6/h2mmlKFvLxn5urjCpxzBt9lEfKtKeK/lu8V6i
 B0NSg5LRpaPAS8a1HiQq20bzlpdBPu9EtY2ZiIaCvB17hCQeKeLeSniQyQfUhFHCqwxxcM98Muj
 f50OqNIShsyoPYokiHJTnDHtFuX7sAPJuxzlfIfhbU6k/jzdvDBlEmYb1bLu3GZBx+jpa4BI26K
 N7pq4V9k2HMV8JuMdYwdyqnD1g82a8KBSr7Tapk49jnP89VVlH6bU7MAXMEzV1XiM+S6HAQZMGo
 CJixA6WTLVgOC4LGQm8Or1i2t6eLvFIsPl5VXO5RRpaUKmLqhjXAtmVebQJcs5Q3p9IZ1ngkxzf
 E9mMfFveV1NjcyOu/1
X-Google-Smtp-Source: AGHT+IE4AKcZ9iG3HU9UqOepJtiBttWpmKkxGVeUm5SGFSLhkBki63IMeT+BtoQKqkwxdMyoqMT2Rw==
X-Received: by 2002:a05:600c:3b0f:b0:477:10c4:b4e with SMTP id
 5b1f17b1804b1-477308b22d2mr117432365e9.41.1762192735161; 
 Mon, 03 Nov 2025 09:58:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c569390sm165120595e9.16.2025.11.03.09.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 09:58:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/3] hw/net/e1000e_core: Correct rx oversize packet checks
Date: Mon,  3 Nov 2025 17:58:50 +0000
Message-ID: <20251103175851.428816-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103175851.428816-1-peter.maydell@linaro.org>
References: <20251103175851.428816-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In e1000e_write_packet_to_guest() we attempt to ensure that we don't
write more of a packet to a descriptor than will fit in the guest
configured receive buffers.  However, this code does not allow for
the "packet split" feature.  When packet splitting is enabled, the
first of up to 4 buffers in the descriptor is used for the packet
header only, with the payload going into buffers 2, 3 and 4.  Our
length check only checks against the total sizes of all 4 buffers,
which meant that if an incoming packet was large enough to fit in (1
+ 2 + 3 + 4) but not into (2 + 3 + 4) and packet splitting was
enabled, we would run into the assertion in
e1000e_write_hdr_frag_to_rx_buffers() that we had enough buffers for
the data:

qemu-system-i386: ../../hw/net/e1000e_core.c:1418: void e1000e_write_payload_frag_to_rx_buffers(E1000ECore *, hwaddr *, E1000EBAState *, const char *, dma_addr_t): Assertion `bastate->cur_idx < MAX_PS_BUFFERS' failed.

A malicious guest could provoke this assertion by configuring the
device into loopback mode, and then sending itself a suitably sized
packet into a suitably arrange rx descriptor.

The code also fails to deal with the possibility that the descriptor
buffers are sized such that the trailing checksum word does not fit
into the last descriptor which has actual data, which might also
trigger this assertion.

Rework the length handling to use two variables:
 * desc_size is the total amount of data DMA'd to the guest
   for the descriptor being processed in this iteration of the loop
 * rx_desc_buf_size is the total amount of space left in it

As we copy data to the guest (packet header, payload, checksum),
update these two variables.  (Previously we attempted to calculate
desc_size once at the top of the loop, but this is too difficult to
do correctly.) Then we can use the variables to ensure that we clamp
the amount of copied payload data to the remaining space in the
descriptor's buffers, even if we've used one of the buffers up in the
packet-split code, and we can tell whether we have enough space for
the full checksum word in this descriptor or whether we're going to
need to split that to the following descriptor.

I have included comments that hopefully help to make the loop
logic a little clearer.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/537
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/e1000e_core.c | 61 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index ba77cb6011f..471c3ed20b8 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1495,6 +1495,13 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     rxi = rxr->i;
 
     do {
+        /*
+         * Loop processing descriptors while we have packet data to
+         * DMA to the guest.  desc_offset tracks how much data we have
+         * sent to the guest in total over all descriptors, and goes
+         * from 0 up to total_size (the size of everything to send to
+         * the guest including possible trailing 4 bytes of CRC data).
+         */
         hwaddr ba[MAX_PS_BUFFERS];
         E1000EBAState bastate = { { 0 } };
         bool is_last = false;
@@ -1512,23 +1519,27 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         e1000e_read_rx_descr(core, &desc, ba);
 
         if (ba[0]) {
-            size_t desc_size = total_size - desc_offset;
-
-            if (desc_size > core->rx_desc_buf_size) {
-                desc_size = core->rx_desc_buf_size;
-            }
+            /* Total amount of data DMA'd to the guest in this iteration */
+            size_t desc_size = 0;
+            /*
+             * Total space available in this descriptor (we will update
+             * this as we use it up)
+             */
+            size_t rx_desc_buf_size = core->rx_desc_buf_size;
 
             if (desc_offset < size) {
-                static const uint32_t fcs_pad;
                 size_t iov_copy;
+                /* Amount of data to copy from the incoming packet */
                 size_t copy_size = size - desc_offset;
-                if (copy_size > core->rx_desc_buf_size) {
-                    copy_size = core->rx_desc_buf_size;
-                }
 
                 /* For PS mode copy the packet header first */
                 if (do_ps) {
                     if (is_first) {
+                        /*
+                         * e1000e_do_ps() guarantees that buffer 0 has enough
+                         * space for the header; otherwise we will not split
+                         * the packet (i.e. do_ps is false).
+                         */
                         size_t ps_hdr_copied = 0;
                         do {
                             iov_copy = MIN(ps_hdr_len - ps_hdr_copied,
@@ -1550,14 +1561,26 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                         } while (ps_hdr_copied < ps_hdr_len);
 
                         is_first = false;
+                        desc_size += ps_hdr_len;
                     } else {
                         /* Leave buffer 0 of each descriptor except first */
                         /* empty as per spec 7.1.5.1                      */
                         e1000e_write_hdr_frag_to_rx_buffers(core, ba, &bastate,
                                                             NULL, 0);
                     }
+                    rx_desc_buf_size -= core->rxbuf_sizes[0];
                 }
 
+                /*
+                 * Clamp the amount of packet data we copy into what will fit
+                 * into the remaining buffers in the descriptor.
+                 */
+                if (copy_size > rx_desc_buf_size) {
+                    copy_size = rx_desc_buf_size;
+                }
+                desc_size += copy_size;
+                rx_desc_buf_size -= copy_size;
+
                 /* Copy packet payload */
                 while (copy_size) {
                     iov_copy = MIN(copy_size, iov->iov_len - iov_ofs);
@@ -1574,12 +1597,22 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                         iov_ofs = 0;
                     }
                 }
+            }
 
-                if (desc_offset + desc_size >= total_size) {
-                    /* Simulate FCS checksum presence in the last descriptor */
-                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
-                          (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
-                }
+            if (rx_desc_buf_size &&
+                desc_offset >= size && desc_offset < total_size) {
+                /*
+                 * We are in the last 4 bytes corresponding to the FCS checksum.
+                 * We only ever write zeroes here (unlike the hardware).
+                 */
+                static const uint32_t fcs_pad;
+                /* Amount of space for the trailing checksum */
+                size_t fcs_len = MIN(rx_desc_buf_size,
+                                     total_size - desc_offset);
+                e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
+                                                        (const char *)&fcs_pad,
+                                                        fcs_len);
+                desc_size += fcs_len;
             }
             desc_offset += desc_size;
             if (desc_offset >= total_size) {
-- 
2.43.0


