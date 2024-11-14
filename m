Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48510D68B29
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBae3-0000fc-2m; Thu, 14 Nov 2024 09:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBae1-0000fJ-Qz
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:16:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBadz-0005hA-Qf
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:16:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso8193665e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731593782; x=1732198582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BP3yRitiC3pe96tPWKI8bHmTbvYnrh2UEaDGL8a02GI=;
 b=VnHl4LVZtFWDZOgvoW+E7KErD8Yb2zwFskDPSsA43qAwhp1LDzyXx+aJSiZ4enhy3N
 drY2YpB8hX9fe0WwM7lMEW5faRCuTNs5zzoTNEJl97o37alsyhLKPWN08ad987zRbnu7
 qQKDZlsk2dzgSvDqd7NdPkHol3kaMVQ//i3ykUPy4vPnPqybc4xsJs5XwfBOe1xtccUY
 QKFRNlkB08wyWuFVgw84PYfEhVHypl7autdnQeGxF8lkSwkiMTEn9zfAdkPTUwSSMmSv
 slClb/UHpc69teMAycXVYXiFnbyqJuk0QLFfszrPRTp7puOqYZCw2Z0T5LnM4ZKQ/W8N
 MX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731593782; x=1732198582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BP3yRitiC3pe96tPWKI8bHmTbvYnrh2UEaDGL8a02GI=;
 b=KT6AmNsk0iD7SAltRLhjVlY9gWQv+6pw2CdC5U+o+xJlGzFFM2nDybSG3C4Yxki9FD
 YPBve8DQ+8ZYMEGPLf71UP2y++Dj45uCMOKfeCr53Fl0zKZrY6MvArVlu40NPi7+OBVa
 rQItP92V6mAuhWLbcu0gKup1/2/pnfgWqOHxi1DLtidjBNgWqSjx4Ccb/J4Wzwzgqy/7
 UBwMHLIav39XJ1bwbBSwNb8fRQ3HHnUso2bvl/pjyIDAAPgbfXiRE8RrKKhpsuPt1Oih
 ZOkesP8ygXPHjEn2nXAV/Xkxi+NkXPoFsEdjE0FxbzamedMgj3vKqgMf2YnZ0Fhz1eG+
 Z3LA==
X-Gm-Message-State: AOJu0Yxl0OGg16ZBBSmEwTr52ImwGhJBAVKZKIX4gi6P7FyUTqv3SM5o
 EIUh85pO3H5nQtSxZTtVWpF5d7zjs4BBi78kRUS9HMpl0E9+wlRc7LzRoikKbLGvXHoUIq8DV1H
 x
X-Google-Smtp-Source: AGHT+IHKFGmv3tKZkRgxO6hUXQBd6EUtrwYraHwVPQWZDQJlFxsBtOvmdiHPhS3YOX1unJUKadz4Jg==
X-Received: by 2002:a05:600c:1f89:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-432da77eee9mr26182455e9.13.1731593781807; 
 Thu, 14 Nov 2024 06:16:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244915sm24941655e9.3.2024.11.14.06.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:16:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <ybendito@redhat.com>
Subject: [PATCH v2 1/2] hw/net/virtio-net.c: Don't assume IP length field is
 aligned
Date: Thu, 14 Nov 2024 14:16:18 +0000
Message-Id: <20241114141619.806652-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114141619.806652-1-peter.maydell@linaro.org>
References: <20241114141619.806652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

In virtio-net.c we assume that the IP length field in the packet is
aligned, and we copy its address into a uint16_t* in the
VirtioNetRscUnit struct which we then dereference later.  This isn't
a safe assumption; it will also result in compilation failures if we
mark the ip_header struct as QEMU_PACKED because the compiler will
not let you take the address of an unaligned struct field.

Make the ip_plen field in VirtioNetRscUnit a void*, and make all the
places where we read or write through that pointer instead use some
new accessor functions read_unit_ip_len() and write_unit_ip_len()
which account for the pointer being potentially unaligned and also do
the network-byte-order conversion we were previously using htons() to
perform.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/virtio/virtio-net.h |  2 +-
 hw/net/virtio-net.c            | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 060c23c04d2..b9ea9e824e3 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -102,7 +102,7 @@ typedef struct VirtioNetRscStat {
 /* Rsc unit general info used to checking if can coalescing */
 typedef struct VirtioNetRscUnit {
     void *ip;   /* ip header */
-    uint16_t *ip_plen;      /* data len pointer in ip header field */
+    void *ip_plen; /* pointer to unaligned uint16_t data len in ip header */
     struct tcp_header *tcp; /* tcp header */
     uint16_t tcp_hdrlen;    /* tcp header len */
     uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f2104ed364a..75b4a28fb3a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2049,6 +2049,21 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
     return virtio_net_receive_rcu(nc, buf, size, false);
 }
 
+/*
+ * Accessors to read and write the IP packet data length field. This
+ * is a potentially unaligned network-byte-order 16 bit unsigned integer
+ * pointed to by unit->ip_len.
+ */
+static uint16_t read_unit_ip_len(VirtioNetRscUnit *unit)
+{
+    return lduw_be_p(unit->ip_plen);
+}
+
+static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)
+{
+    stw_be_p(unit->ip_plen, l);
+}
+
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
                                          const uint8_t *buf,
                                          VirtioNetRscUnit *unit)
@@ -2063,7 +2078,7 @@ static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
     unit->ip_plen = &ip->ip_len;
     unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrlen);
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
-    unit->payload = htons(*unit->ip_plen) - ip_hdrlen - unit->tcp_hdrlen;
+    unit->payload = read_unit_ip_len(unit) - ip_hdrlen - unit->tcp_hdrlen;
 }
 
 static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
@@ -2082,7 +2097,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
 
     /* There is a difference between payload length in ipv4 and v6,
        ip header is excluded in ipv6 */
-    unit->payload = htons(*unit->ip_plen) - unit->tcp_hdrlen;
+    unit->payload = read_unit_ip_len(unit) - unit->tcp_hdrlen;
 }
 
 static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,
@@ -2231,7 +2246,7 @@ static int32_t virtio_net_rsc_coalesce_data(VirtioNetRscChain *chain,
     VirtioNetRscUnit *o_unit;
 
     o_unit = &seg->unit;
-    o_ip_len = htons(*o_unit->ip_plen);
+    o_ip_len = read_unit_ip_len(o_unit);
     nseq = htonl(n_unit->tcp->th_seq);
     oseq = htonl(o_unit->tcp->th_seq);
 
@@ -2267,7 +2282,7 @@ coalesce:
         o_unit->payload += n_unit->payload; /* update new data len */
 
         /* update field in ip header */
-        *o_unit->ip_plen = htons(o_ip_len + n_unit->payload);
+        write_unit_ip_len(o_unit, o_ip_len + n_unit->payload);
 
         /* Bring 'PUSH' big, the whql test guide says 'PUSH' can be coalesced
            for windows guest, while this may change the behavior for linux
-- 
2.34.1


