Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DCCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weF4X-0000RP-RR; Mon, 29 Jun 2026 12:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weF4O-0000PY-9K
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:42:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weF4M-0004jL-Es
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:42:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so1090926f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782751369; x=1783356169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/5iESuASLycsAoZotgaQvHLlAkwq24s+d8w0Yh0hvY=;
 b=PaCCpSst2digO3EJMGXd6WpsSepiMNVlmsPFMW0ZK+9Bn/1IVnUV7FWgMsxkDFlrlY
 +r6cHFIMuCNkJyJYMf0326wTGOvCUhKRFqmyprwAwexSSG6D9QIt+C8MPmA6rDgpxkCx
 8bNKs4ZWSt0f9g2yWdW8UVeeIEqv990LfRgiRHB4ssSVdWFr7RWsmIcJpr81w+K4Dp1B
 nLzegPOTY3N80EUEgg4s6eF6o6Uz5M0Pgcqp2TaniUx45X8s+Zc6ktk+pLwN72rRSUzE
 PvWS861BIz2xQmaEgkRt6l0M5fjROyn3iY8NE8aWrsDbL/3sMPhVm2pUw2MaUds9dt3A
 JU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782751369; x=1783356169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/5iESuASLycsAoZotgaQvHLlAkwq24s+d8w0Yh0hvY=;
 b=mKOC19amPXS5myskXsPh7Tz85OW8ChnBJ0L5HEgQ9BN5GOWIVvBh5gHbYkRbrZR8fr
 UrJ+yjxIo4CSba2/dvzI66wUNIaA6gd/b3uUzzZ3uOpcblGpSSSpLJXDEkcSbI/kggGL
 0tvW3t0VTLFwAd0sjtPWYgJKKpbb3WTa8wiwrtvCMWdicyd18MjLuPKNgWnntKdtT1Kn
 RjiXyHCk3tXw62pSqRcvavtk5/N9UBHZdbiULIs92vXhljGel5fOScoFtdOhcKVicxm+
 GcUv3BtMOOblrcKlB6vpUqTaCD2ErUjTpr8jE0w5TDVwm89RtE9/XZEly+w9kmYmKUaB
 nmLA==
X-Gm-Message-State: AOJu0Ywr1LwZjw+LRAlEP4ygPTUVAmNenbT8E5+EQI20k5zwn1VN8YlF
 UDIY1UD81XxGdt+/ZEkNp3dnIT+WBqTnu0FcDZt8imxtomNUl8oCfQ+LWIi+U4hxgvBVLRxB0kk
 txASA
X-Gm-Gg: AfdE7cmKz+4K/Nadr64JbDZbFDaQl8R2vZ3UNrl9WR7hE6EMp3O8y1kyjsJJkE1EMp2
 Jr1tp7QFG47UCb7E1hDPeMZdRShee8CvQgtZ0yhlP0LoapX5Jk2o4a6XWjd2CpfrUHgsspruxEW
 uVeh8Zj1isEx8cW6Dfju65S8D5bXfM5bVZNzPMix6sVI7MXXZD4LyUMip9jkkq1HtuUmTzT7bkK
 qth/wpH4f0KrsqfUD6iw9WKa/JZT6xDYqRKLLajsN1tqZIsRyIy+FGHnyqo8MojsLAoEifZz3US
 Q6h6JWoJBVRxZchuBTotQ3v0CgCnjBNh9zzHnNRvv6awl3+PW8njlNtrW3pQKoaSTGcWAPjPyN6
 Qz/xfoKt99qlfqOo336wYgxnvpZvYRiYmUyoki8Ty9T3SWoxOcFOtQj+nZvEB6Pi48wEuEQWYNN
 2U6ZUUOQuXc3t6GK3c6DHAyFlW5DI8Fw2CbP9cwWRkZJrR8dP9+XKKzduXp68dNPt2hpiaHS/Mi
 5qEt2e9KaC2b2R0hgTV0Aujs2YuU9lk
X-Received: by 2002:a05:6000:2284:b0:471:92b:1683 with SMTP id
 ffacd0b85a97d-471092b1810mr15674764f8f.13.1782751368684; 
 Mon, 29 Jun 2026 09:42:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm53582443f8f.9.2026.06.29.09.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 09:42:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH] net: Correct padding check in qemu_receive_packet()
Date: Mon, 29 Jun 2026 17:42:46 +0100
Message-ID: <20260629164246.2028947-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
---
 include/net/net.h | 23 +++++++++++++++++++++++
 net/net.c         |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86..9edfacf827 100644
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
index 2892f1730d..93fe2ed1c3 100644
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
2.43.0


