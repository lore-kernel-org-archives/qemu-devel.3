Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191D3C43327
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdrWH-0003H7-Oa; Sun, 28 Jun 2026 11:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wdrWF-0003GR-Ar
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 11:34:03 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1wdrWD-0003n6-8K
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 11:34:03 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-30bf132969bso3633710eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782660838; x=1783265638; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TO4OMy13JlcurS/bG9cfFh20FAygOUWwvqQaohzVLBI=;
 b=Ua2rXhCL4xkezaGmg6mtwNqH8uPj88nCtXTFzlFetQEbaydfJpwK8TVL377e8VPpIv
 p5yc0O/YANwB5H9UTAO6g4qVen7zJbG2uuIq+v1kQfIa9wGCdSEcDQH778BJGz6S+rjb
 Pucq/Yhh8we02BIybyJm0Cm0DCSorjkbVxXpOfOCyK1GDafOdTWjznx0DjR+xcsLaXbg
 al22WEj0BMYr6sXMAonFj7REte0NJ/PWtLd5qmpDdHk1TKhUUF/WQ67DzEWagimXIqcD
 /ymXYI/4SwMWrHHJ2Qt3ksZ8TQVpobUv3hVjYXEbTWtGcqwuiHO5ZBTGWV///cLrwCzw
 2CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782660838; x=1783265638;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO4OMy13JlcurS/bG9cfFh20FAygOUWwvqQaohzVLBI=;
 b=n0NavzBnFaknlfUkOesFyu4DLY+1OsNyE8eNMK7ZOQAYko7sJflBa+RAGRweVf3czH
 sIBh+wNmg9inVUNHsppNJHe7ZIEhRQKQU9CpjVDHJZdLHmV4+2YSjzYLvokTTM/z+HOx
 XeNUKlnJgMq6LY0UUBt84ChqxVj6nzUQVGMtovYAeAdly2pQOsgx1bO2jNU21tnerxOb
 xKpGRcdv91/zqQP4UVxUCCUyZkaNFXLmWCNbw0kR2tVFT57jd634/YDhffrY8lIdwU/9
 8wKbmZyFzlc1AKbji0jSfP0NIhwnEy6ivIYLA9blljOUcJmIpU3Gyw3rMmzboCilUtnO
 d2Yw==
X-Gm-Message-State: AOJu0Yydqh1LIlMjnwKrk36zPTfew8K4GJzQK+CBaMekI+8O78YAeDqZ
 d8x02am6qFFrlTh/tE/oDRHnwk3HcUxs2vGeSwxeXcHVJzYLBnhiyvQp
X-Gm-Gg: AfdE7ckZn2OxJJxiGIMQ+R0ZkkwBeGFo37gdm4BEKbNaWFC7eOIOTgRANll9Qgzv17u
 TCBCmVZq0YltiqQ9z4gNWL+GjcmiwZd4Posmex9yO3ERBqRyxgr91m6jn6yLfND9hQpDA8h+2aU
 dW+P/RrPJ50Xcv94288hG3l2GFdcaq7VbqEgkD5VExTEaY5vDIprzgsPcem9A0t6KjGl3NEEAdt
 PdnWxM7cryw9IwcJhWCl9683VRG4Z9YrdM3vtG1t/PzpZhRSuhWN9gjEVUTjje/9JrgPtr5g8Ss
 S9BfxKLsFKTe58m541zIJm+edIZW2axIvqMI0G9xbXZ+fz21BJsvgBoAK3V6G6CZmj9jRpPYG8v
 GtyfMHR5AgS3nOPRuYhvlU9f3klx9F85jeqp9bfL4s0QzKd9qbiBD0mvVA3T/TL7FI9qKhXa/D9
 fdOYnnchZRAfA0agGi9tVf4E1uE8jxTcYyrDc3DDldfXWG0oK5NfilqfH2
X-Received: by 2002:a05:7300:e830:b0:30e:cb91:6598 with SMTP id
 5a478bee46e88-30ecb9168a5mr568519eec.23.1782660838104; 
 Sun, 28 Jun 2026 08:33:58 -0700 (PDT)
Received: from [127.0.0.1] (67-2-23-151.slkc.qwest.net. [67.2.23.151])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ea81b39easm9088934eec.31.2026.06.28.08.33.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 28 Jun 2026 08:33:57 -0700 (PDT)
From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Date: Sun, 28 Jun 2026 09:33:25 -0600
Subject: [PATCH v4] hw/net: fix e1000e ip_len inflation by Ethernet
 minimum-frame padding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260628-net-tx-pkt-ip-length-padding-v4-1-1794063064fa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMU+QWoC/4XQwW6DMBAE0F+JfM5WtjEYcup/VDnYeIFtEoOwg
 1Ih/r2GKhLKoTnOHN5IM7OAI2Fgp8PMRpwoUO9TUMcDqzvjWwRyKTPJZcELWYLHCPEBwyUCDXB
 F38YOBuMc+RaqXKDOG1Npq1gihhEbemz81znljkLsx59tbRJr+4TV//AkQIA2UjZYWYWKf7Y3Q
 9ePur+xFZ7kHsvfYDJhstSOW5NXWItXLNtj+g2WJQzLgjtjU5U1e2z5+yDc7TfWcf2RLcsvIh+
 n1XQBAAA=
X-Change-ID: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>, 
 Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782660837; l=6453;
 i=y.sanjeevreddy@gmail.com; s=20260624-gmail; h=from:subject:message-id;
 bh=XurpwIIi76ZMVaXh1rvRgFxqUn4Xzo4M4BtVMQFml1o=;
 b=RADIOOgcUZGaOfTmvLFAvSkKugC14ac4co1A1YsXHBxz/DpSUtAO4aHDPpMMlHup9XMIoThtb
 iCWi+o15hj9CEolVIrkub0AQbb4HCzZMyUg0ksLWVGFj4OWRdA44ZG9
X-Developer-Key: i=y.sanjeevreddy@gmail.com; a=ed25519;
 pk=3ELbcw0bH36IEv3JvxqzTAgl5rrkOyv/tQHQzhpObAU=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=y.sanjeevreddy@gmail.com; helo=mail-dy1-x1331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When a guest transmits a short Ethernet frame, iov_size() returns the
padded wire length including any bytes added to reach the Ethernet
minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
this inflated size as payload_len.  In the non-TSO IXSM path,
net_tx_pkt_update_ip_hdr_checksum() then overwrites the IPv4 Total
Length field with payload_len + l3_hdr_len, inflating it by the
padding bytes.  The receiver interprets Ethernet padding as IP
payload, producing a malformed packet.

Fix the IXSM path in e1000e by adding a new function,
net_tx_pkt_update_ip_hdr_checksum_only(), that recomputes the IPv4
header checksum without modifying ip_len.  For non-TSO packets the
guest has already set ip_len correctly; only the checksum needs to be
recomputed after the header is reassembled into the linear buffer.
A new common-layer function is needed because struct NetTxPkt is
opaque to device code and the IP header bytes required by
net_raw_checksum() are inaccessible from e1000e_core.c.

The TSO path is unaffected: it continues to call
net_tx_pkt_update_ip_checksums() which correctly writes ip_len from
payload_len (ip_len=0 per Intel 82574 datasheet §7.3.4 for TSO
super-packets that the host must segment).

Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
---
Thank you Akihiko for your review. I agree that device-specific logic
should stay in device code and not in net_tx_pkt_rebuild_payload(). v4
takes a different approach that avoids any changes to the common
parsing path.

Changes in v4:
- Revert all changes to net_tx_pkt_rebuild_payload(); it is unchanged
  from upstream.
- Add net_tx_pkt_update_ip_hdr_checksum_only() to the net_tx_pkt
  common layer: identical to net_tx_pkt_update_ip_hdr_checksum() but
  skips the ip_len write. A new common-layer function is necessary
  because struct NetTxPkt is opaque to device code — the IP header
  bytes needed by net_raw_checksum() are inaccessible from e1000e_core.c.
- Change the IXSM (non-TSO) path in e1000e_setup_tx_offloads() to call
  net_tx_pkt_update_ip_hdr_checksum_only(). The guest has already set
  ip_len correctly; we only need to recompute the checksum.
- The TSO path is unaffected: it continues to call
  net_tx_pkt_update_ip_checksums() which correctly writes ip_len from
  payload_len (ip_len=0 per §7.3.4 for TSO super-packets).
- Link to v3: https://lore.kernel.org/qemu-devel/20260627-net-tx-pkt-ip-length-padding-v3-1-e860dabadd3f@gmail.com

Changes in v3:
- Architectural redesign: three-case fallback logic in
  net_tx_pkt_rebuild_payload() plus net_tx_pkt_set_payload_len() API;
  e1000e pre-sets payload_len from PAYLEN descriptor field.
- Link to v2: https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-ip-length-padding-v2-1-287d0ba59ec1@gmail.com

Changes in v2:
- Fix iov_copy() to use raw_payload_len and net_tx_pkt_get_total_len()
  to use iov_size() to preserve correct wire frame size.
- Link to v1: https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com

On the relationship to the short-packet receive-path discussion
(Peter Maydell):
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/

The linked thread concerns the receive path. This patch addresses only
the transmit path: the IXSM offload path was overwriting a correctly
set guest ip_len with an inflated value that included Ethernet padding.
No changes to padding behaviour or the receive path are made.
---
 hw/net/e1000e_core.c |  8 +++++++-
 hw/net/net_tx_pkt.c  | 17 +++++++++++++++++
 hw/net/net_tx_pkt.h  | 13 +++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 46e156a5dd..3c0347caf8 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -614,7 +614,13 @@ e1000e_setup_tx_offloads(E1000ECore *core, struct e1000e_tx *tx)
     }
 
     if (tx->sum_needed & E1000_TXD_POPTS_IXSM) {
-        net_tx_pkt_update_ip_hdr_checksum(tx->tx_pkt);
+        /*
+         * Guest already set ip_len correctly; only recompute the checksum.
+         * net_tx_pkt_update_ip_hdr_checksum() would overwrite ip_len with
+         * payload_len + l3_hdr_len, inflating it by any Ethernet
+         * minimum-frame padding bytes present in payload_len.
+         */
+        net_tx_pkt_update_ip_hdr_checksum_only(tx->tx_pkt);
     }
 
     return true;
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca2..c2eae2f74b 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -102,6 +102,23 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt)
     pkt->l3_hdr.ip.ip_sum = cpu_to_be16(csum);
 }
 
+void net_tx_pkt_update_ip_hdr_checksum_only(struct NetTxPkt *pkt)
+{
+    uint16_t csum;
+    assert(pkt);
+
+    /*
+     * Recompute the IP header checksum without touching ip_len.
+     * Used for non-TSO packets where the guest already set ip_len
+     * correctly; overwriting it would inflate it by any Ethernet
+     * minimum-frame padding present in payload_len.
+     */
+    pkt->l3_hdr.ip.ip_sum = 0;
+    csum = net_raw_checksum(pkt->l3_hdr.octets,
+        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
+    pkt->l3_hdr.ip.ip_sum = cpu_to_be16(csum);
+}
+
 void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
 {
     uint16_t csum;
diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 0a716e74a5..d2840f38e8 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -133,6 +133,19 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt);
  */
 size_t net_tx_pkt_get_total_len(struct NetTxPkt *pkt);
 
+/**
+ * recompute the IPv4 header checksum without modifying ip_len
+ *
+ * Use for non-TSO packets where the guest already set ip_len correctly.
+ * Calling net_tx_pkt_update_ip_hdr_checksum() instead would overwrite
+ * ip_len with payload_len + l3_hdr_len, inflating it by any Ethernet
+ * minimum-frame padding present in payload_len.
+ *
+ * @pkt:            packet
+ *
+ */
+void net_tx_pkt_update_ip_hdr_checksum_only(struct NetTxPkt *pkt);
+
 /**
  * get packet type
  *

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4

Best regards,
--  
Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>


