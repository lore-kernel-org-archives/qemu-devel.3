Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4E606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=MhK4+G5P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp5r-00016R-EQ; Fri, 27 Nov 2026 01:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3T-0005TH-Ni; Fri, 27 Nov 2026 01:03:32 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3R-0003Wb-RF; Fri, 27 Nov 2026 01:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=69UwI0MvYU5oUzUZs9X7GQeVMZXOAbbMBpj0ZRhqG3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MhK4+G5PRimSXVbvaWa7c1Bw5Gi3AoYTaBn+dvCbLKaGyroqLGqNYg0Xlb6tNPX33
 IY86RMxxfC09CT0EsRIdvlgvOo662nThfaniKHPMWQoTgpArK6gPjf2b4BTQ6NlXz+
 0Uk96B8SSHsjxtJeuzeEvb6Fr9V+/gdAUwXrNKVDSjFad4rUCt5veoMeT+Wb/qm9D6
 14t0T/wuL9b2SZhaDeTZFZJErnyOWuVU8C7LtnMOfWQQmybrSQalhK8m08BuZCFRmL
 BIfNMpF9+4TmR+iCJa+69lmdLlGBM/MOy28eU/09EsZpRhqAYM0LaYwXI8bpzfxmxA
 zZq1zo23/7wEQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 885461EA33B;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8636F469967;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6AFD1CF2C6; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 074/152] net/eth.c: Tighten size checks in
 eth_get_l3_proto()
Date: Fri, 27 Nov 2026 08:53:32 +0300
Message-ID: <20261127055709.39630-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently eth_get_l3_proto() has a check that the offset of the
protocol field is not off the end of the iovec; this is actually
unnecessary because iov_to_buf() guarantees to return 0 for offsets
off the end of the iovec.  On the other hand, it assumes that the
l2hdr_len it is passed is not so small that the protocol offset
calculation underflows and it doesn't check that the packet is
actually big enough for the l2hdr_len. This shouldn't matter
if other parts of the code are checking, but for defence in
depth we tighten this check.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-9-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2dd4094cfb255b17839a28990eb9145b9b4fe8ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index 74a705a2679..33b61cac414 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -75,11 +75,13 @@ eth_get_l3_proto(const struct iovec *l2hdr_iov, int iovcnt, size_t l2hdr_len)
     uint16_t proto;
     size_t copied;
     size_t size = iov_size(l2hdr_iov, iovcnt);
-    size_t proto_offset = l2hdr_len - sizeof(proto);
+    size_t proto_offset;
 
-    if (size < proto_offset) {
+    if (l2hdr_len < sizeof(struct eth_header) || size < l2hdr_len) {
+        /* We don't have a complete ethernet header */
         return ETH_P_UNKNOWN;
     }
+    proto_offset = l2hdr_len - sizeof(proto);
 
     copied = iov_to_buf(l2hdr_iov, iovcnt, proto_offset,
                         &proto, sizeof(proto));
-- 
2.47.3


