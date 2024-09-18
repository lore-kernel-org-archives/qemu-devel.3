Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E81CDD55D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 22:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr3WM-0000B0-CT; Wed, 18 Sep 2024 18:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr3WI-0000AM-Vv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 18:51:35 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr3WH-00046S-0L
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 18:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=ja/NVMKEyuPEIdo2aDb0QZEL3wsLl8tmjcMsOMa2oQc=; b=dYSKfoVMtjcqs2UR
 RaSkLzTHorGyDAZM63y1tGupa8CeaKSD94EuWL6mqoZ5hCCvhWByFB0iV0GSlqG7yHXYeYktkINET
 /4Ny4w5W8LFdfHdabyoqe56vyd9nb/Lzf9ndurcZBnC415IreX0VQiKbFxsJDZ9uFMv54eGwWAt3s
 ypvQh+NEBY37VmgxeNY7mhVudI7SJ5/g65lEdkp3i+9GI2B/om3s8Zgu+xQ/AvpOtBmX47i2Paa4A
 Fu7cWjF658r3WUeNECoLZBM0QVeHJ1lZi/dKNsWST19xFbU4OQDSMHgKkG4D+N31eBDUKEWcYfUok
 MqueWTczWb2mfxExXw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr3WC-006Lgj-2s;
 Wed, 18 Sep 2024 22:51:28 +0000
From: dave@treblig.org
To: dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hw/net/net_rx_pkt: Remove deadcode
Date: Wed, 18 Sep 2024 23:51:28 +0100
Message-ID: <20240918225128.455043-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

net_rx_pkt_get_l3_hdr_offset and net_rx_pkt_get_iovec_len haven't
been used since they were added.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/net/net_rx_pkt.c | 13 -------------
 hw/net/net_rx_pkt.h |  9 ---------
 2 files changed, 22 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 32e5f3f9cf..cec1d0523d 100644
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
@@ -427,13 +421,6 @@ struct iovec *net_rx_pkt_get_iovec(struct NetRxPkt *pkt)
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
index 55ec67a1a7..e8df9cfd52 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -267,15 +267,6 @@ net_rx_pkt_attach_data(struct NetRxPkt *pkt, const void *data,
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
2.46.0


