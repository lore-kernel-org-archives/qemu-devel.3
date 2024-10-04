Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B4BCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkn3-0001yu-Qn; Fri, 04 Oct 2024 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmz-0001w0-VJ; Fri, 04 Oct 2024 12:04:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmy-0001Zt-GD; Fri, 04 Oct 2024 12:04:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3AB339556D;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 74C8B14D97B;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282527 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 08/23] hw/net/net_rx_pkt: Remove deadcode
Date: Fri,  4 Oct 2024 19:03:16 +0300
Message-Id: <20241004160331.1282441-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

net_rx_pkt_get_l3_hdr_offset and net_rx_pkt_get_iovec_len haven't
been used since they were added.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: also removed net_rx_pkt_get_l3_hdr_offset prototype from hw/net/net_rx_pkt.h as suggested by Akihiko Odaki)
---
 hw/net/net_rx_pkt.c | 13 -------------
 hw/net/net_rx_pkt.h | 17 -----------------
 2 files changed, 30 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 0ea8734474..f87b6f046c 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -209,12 +209,6 @@ void net_rx_pkt_get_protocols(struct NetRxPkt *pkt,
     *l4hdr_proto = pkt->l4hdr_info.proto;
 }
 
-size_t net_rx_pkt_get_l3_hdr_offset(struct NetRxPkt *pkt)
-{
-    assert(pkt);
-    return pkt->l3hdr_off;
-}
-
 size_t net_rx_pkt_get_l4_hdr_offset(struct NetRxPkt *pkt)
 {
     assert(pkt);
@@ -426,13 +420,6 @@ struct iovec *net_rx_pkt_get_iovec(struct NetRxPkt *pkt)
     return pkt->vec;
 }
 
-uint16_t net_rx_pkt_get_iovec_len(struct NetRxPkt *pkt)
-{
-    assert(pkt);
-
-    return pkt->vec_len;
-}
-
 void net_rx_pkt_set_vhdr(struct NetRxPkt *pkt,
                             struct virtio_net_hdr *vhdr)
 {
diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index 55ec67a1a7..ea077f5fdb 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -77,14 +77,6 @@ void net_rx_pkt_get_protocols(struct NetRxPkt *pkt,
                                  bool *hasip4, bool *hasip6,
                                  EthL4HdrProto *l4hdr_proto);
 
-/**
-* fetches L3 header offset
-*
-* @pkt:            packet
-*
-*/
-size_t net_rx_pkt_get_l3_hdr_offset(struct NetRxPkt *pkt);
-
 /**
 * fetches L4 header offset
 *
@@ -267,15 +259,6 @@ net_rx_pkt_attach_data(struct NetRxPkt *pkt, const void *data,
  */
 struct iovec *net_rx_pkt_get_iovec(struct NetRxPkt *pkt);
 
-/**
-* returns io vector length that holds the attached data
-*
-* @pkt:            packet
-* @ret:            IOVec length
-*
-*/
-uint16_t net_rx_pkt_get_iovec_len(struct NetRxPkt *pkt);
-
 /**
  * prints rx packet data if debug is enabled
  *
-- 
2.39.5


