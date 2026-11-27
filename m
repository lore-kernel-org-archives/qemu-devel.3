Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B0606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=j8aG9Mt2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWov0-0002t7-DW; Fri, 27 Nov 2026 00:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWouy-0002sg-IX; Fri, 27 Nov 2026 00:54:44 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWouw-0007UU-SG; Fri, 27 Nov 2026 00:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=MiqwqMwh8Pv9IWrz77W4PGAnT/CPY9qUNdqfHaLk9nY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j8aG9Mt2d9nKhFtB+4glOxRu5+h6Q3+na+tuhFrloLA9BgZrE+8YpX6aw3D8kxors
 AFoRAA5z5C7DUNVqcnu2ZSBJFNn64MPKVzyZMx5LD27fj25UHLKTxqfH7ComyCsPVf
 wjILPLOTGphq7pAN0/CvZ8MOmSTJdH3OoSqtk7NFm0lep0wFIfEpNoZPNdf+odiR94
 HdDUgTuKJwnvWCcPQisAJ5jdO5d8nr6kA93ZWABoaFp0gmOFEWJWKHP8pML8IH4Flp
 LUkyqjccV4M2t0isBkWCc52nz40BghOzwqr042pJ5lQjYLVITT3X/GbVTcmPVJk3WX
 PNeqw38/OT+fw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA1601EA2C5;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6187469903;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 99C18CF212; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 062/140] net/eth.c: Check for undersized L2
 headers in eth_get_protocols()
Date: Fri, 27 Nov 2026 08:52:48 +0300
Message-ID: <20261127055421.39015-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

We already have some header bounds checks. Add a missing check for
L2 headers.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-2-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit ba4bf520243875e0dac9218a508d4756c490b76a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index 3f680cc033a..6315ab90cf8 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -139,21 +139,28 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
     bool fragment = false;
     size_t input_size = iov_size(iov, iovcnt);
     size_t copied;
+    uint32_t hdr_size;
     uint8_t ip_p;
 
     *hasip4 = *hasip6 = false;
-    *l3hdr_off = iovoff + eth_get_l2_hdr_length_iov(iov, iovcnt, iovoff);
     l4hdr_info->proto = ETH_L4_HDR_PROTO_INVALID;
 
+    if (input_size < iovoff) {
+        return;
+    }
+
+    hdr_size = eth_get_l2_hdr_length_iov(iov, iovcnt, iovoff);
+    if (input_size - iovoff < hdr_size) {
+        return;
+    }
+
+    *l3hdr_off = iovoff + hdr_size;
+
     proto = eth_get_l3_proto(iov, iovcnt, *l3hdr_off);
 
     if (proto == ETH_P_IP) {
         struct ip_header *iphdr = &ip4hdr_info->ip4_hdr;
 
-        if (input_size < *l3hdr_off) {
-            return;
-        }
-
         copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
             IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
-- 
2.47.3


