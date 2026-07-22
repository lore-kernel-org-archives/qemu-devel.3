Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390B8C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWu-0007vS-C1; Wed, 22 Jul 2026 08:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU1-0001Ut-0M; Wed, 22 Jul 2026 08:55:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTy-0003Ln-M3; Wed, 22 Jul 2026 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=7sJDU3ne1UmK05/NHpD0EoX8IlcMyqyado09dvHbjts=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i/9OBmmEa0IHjDMGXP89v4Z8mGIjSGkhDw+RAoE4iVuH4X2F7JLTvgmeWcd2oph4S
 5CItcH3FvE0lUeB6JofQdXE71bm0QfoMCJFMEam6+LNxtPsXCF8qCmdz822Gr46tLS
 IqY0lHxY5hEfXNB736dKSy+EzcDsGhtBvdImRI7CUBDT3C1R81/IP18wvj0F41ZQHr
 REQXayf51DPRHLzpXulHkl8Vle1UstHHzJGXdS6E6qqpZ6hNfc77wDsC5cX2nnPCWr
 iLCNGSHdf1wP+waG/ScAya2FwByUpLoVGmpYiaOeALLGQTtUQEun2AavjuZFNkhDSW
 6GhHPQGp5qm2Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5FFA01C3B57;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A90663F37A7;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F354317F83; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 122/127] net: Correct padding check in
 qemu_receive_packet()
Date: Wed, 22 Jul 2026 15:48:47 +0300
Message-ID: <20260722124859.32371-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In qemu_receive_packet() we check to see if we should pad a short
packet.  This is doing the wrong test: because this function is used
when the device adds a packet to its own incoming queue (i.e.  for
loopback), we should be checking the NetClientState's own do_not_pad
flag, not that for its peer.

We didn't notice this earlier, because at the moment all the real
peers of a network device (i.e.  the network backends) do not set
do_not_pad, so net_peer_needs_padding() always returns true except in
the corner case where the network device has no peer at all.

The effect of this is that if a network device has no peer (e.g.
because QEMU was started with -net none or with -nodefaults) then we
can still let through the kind of "guest misprograms the network
device to loopback-transmit a short packet and then we mishandle it
in the receive path" bug like #3043 which commit a01344d9d78 was
trying to fix.

Since the distinction between "we should check nc->do_not_pad"
and "we should check nc->peer->do_not_pad" is a bit subtle, add
enough documentation commentary to make it more obvious.

Cc: qemu-stable@nongnu.org
Fixes: a01344d9d78 ("net: pad packets to minimum length in qemu_receive_packet()")
Suggested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260629164246.2028947-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit b1e73b2ddbb2850e394b9c47cfcb14dba8048a71)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86b..9edfacf827c 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -349,9 +349,32 @@ uint32_t net_crc32_le(const uint8_t *p, int len);
     .offset     = vmstate_offset_macaddr(_state, _field),            \
 }
 
+/**
+ * net_peer_needs_padding: Should we pad as we send out packets?
+ * @nc: NetClientState
+ *
+ * Return true if the peer of this NetClientState (i.e. the
+ * destination that qemu_send_packet() etc send to) requires us to pad
+ * out packets that are shorter than the minimum ethernet frame
+ * length.
+ */
 static inline bool net_peer_needs_padding(NetClientState *nc)
 {
   return nc->peer && !nc->peer->do_not_pad;
 }
 
+/**
+ * net_client_needs_padding: Should we pad as we queue packets to ourselves?
+ * @nc: NetClientState
+ *
+ * Return true if this NetClientState requires us to pad out packets
+ * that are shorter than the minimum ethernet frame length.  This is
+ * the check to make in qemu_receive_packet() when we are queuing a
+ * packet back into ourselves (i.e. loopback).
+ */
+static inline bool net_client_needs_padding(NetClientState *nc)
+{
+    return !nc->do_not_pad;
+}
+
 #endif
diff --git a/net/net.c b/net/net.c
index 4ccc8763465..5977fe4cfbd 100644
--- a/net/net.c
+++ b/net/net.c
@@ -783,7 +783,7 @@ ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
         return 0;
     }
 
-    if (net_peer_needs_padding(nc)) {
+    if (net_client_needs_padding(nc)) {
         if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
             buf = min_pkt;
             size = min_pktsz;
-- 
2.47.3


