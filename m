Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB563C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpD-0004qY-OL; Sat, 11 Jul 2026 18:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifp0-0004Uj-QQ; Sat, 11 Jul 2026 18:05:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoz-0000bP-3a; Sat, 11 Jul 2026 18:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=7HMKc60spAKEu7etDQ7jsCDcdQ3mD5HIQYRCuhKKk/o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fy2F2nTyQYpouQt0sVBVMPk6cZJSkR2L2o4ZzQcdijZqW1q9eT2d4d0uB8wuKbNTK
 sTqvHMucul+vGwOKyyvAOCrIAhrHSKorUaQmBGeKx1F/8NHdMkfwU8soh9cy2SNLia
 Tg+DuqoxyFDfBMxH8pokGmpDoAX0++G25itLMx2q8JicJffIYcdovHIbvRPw0rosiw
 PdzkXELCmtYZ82wPLwB2Nfzaz059Oh32xBW8VFaxckiEK5V042dWMlytbw4PpB0zlH
 EPxsy3ardp81wStcq/xJKhuTCECXEwwMVKnOo+KziTf1M1PuChp7oDsgP/VTXENi17
 O+DUnnOhPsMuQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A6BD1C0AC7;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 304313EAF52;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C7A701335B; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 60/81] hw/net: fix e1000e/igb ip_len inflation by
 Ethernet minimum-frame padding
Date: Sun, 12 Jul 2026 00:58:38 +0300
Message-ID: <20260711215904.3757-60-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>

When a guest transmits a short Ethernet frame, iov_size() returns the
padded wire length including any bytes added to reach the Ethernet
minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
this inflated size as payload_len.  net_tx_pkt_update_ip_hdr_checksum()
then overwrites the IPv4 Total Length field with payload_len +
l3_hdr_len, inflating it by the padding.  The receiver interprets
Ethernet padding as IP payload, producing a malformed packet.

Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksum()
so it only recomputes the checksum, and moving the ip_len assignment
into net_tx_pkt_update_ip_checksums() where it is only performed for
TSO (where ip_len must be derived from payload_len since the guest sets
ip_len=0 per Intel 82574 datasheet §7.3.4 for super-packets the host
will segment).

Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()
from their IXSM paths, so both are corrected by this single common-
layer change.

Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
Reivewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 9e41b5d22aeb942ad6ecc3174504ff645a10da6a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 903238dca24..b134348fe80 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -93,9 +93,6 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPkt *pkt)
     uint16_t csum;
     assert(pkt);
 
-    pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
-        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
-
     pkt->l3_hdr.ip.ip_sum = 0;
     csum = net_raw_checksum(pkt->l3_hdr.octets,
         pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
@@ -117,7 +114,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt *pkt)
 
     if (gso_type == VIRTIO_NET_HDR_GSO_TCPV4 ||
         gso_type == VIRTIO_NET_HDR_GSO_UDP) {
-        /* Calculate IP header checksum */
+        /* Set ip_len and calculate IP header checksum */
+        pkt->l3_hdr.ip.ip_len = cpu_to_be16(pkt->payload_len +
+            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
         net_tx_pkt_update_ip_hdr_checksum(pkt);
 
         /* Calculate IP pseudo header checksum */
-- 
2.47.3


