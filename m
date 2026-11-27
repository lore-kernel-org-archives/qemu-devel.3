Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFF606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=v4WzOBK8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp5W-00083E-Tw; Fri, 27 Nov 2026 01:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2t-0004Wq-I0; Fri, 27 Nov 2026 01:03:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2l-0002Mr-Ey; Fri, 27 Nov 2026 01:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=Usr1oMhwLKtOs8WchfzzOtEEl8dvJ528fmfY2ppgSo0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=v4WzOBK8C2JhmeFJsIhdO6Qh53Vnz9Bo8GUPZmM5pZ++lXuAv73tNcAZVZT6RmgOh
 SXqu3I1TIenMKwwtzJXEKgXHmC6Fc5aGzUwuQyQWpZqxXgl7wQ9wB8jooQjs+L833v
 Q+nDVgkK/5sMt66WvGv5CF32IBj6jTzqCsGsHvlzftp3mh3yiW4zvE2ClfQ4864yDH
 3ZZBSL2kbPjnzqHMNT7Z6l1fH2EenPLYkuvH8pj9g5SMZfO86ngIye9nM4RH4Xt/+w
 3Hmf1n4p0NPfcHGSK5vw1ma/d6V+BSRNgwUENUYhdzgpJ5X11eMYCyCIuntvG+yz+s
 0gaTVpnaFTAlA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62CA41EA333;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FC3F46995F;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5368CCF2B6; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 066/152] hw/net/net_rx_pkt: Handle bogus l4hdr_off
 when validating SCTP checksum
Date: Fri, 27 Nov 2026 08:53:24 +0300
Message-ID: <20261127055709.39630-3-mjt@tls.msk.ru>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In _net_rx_pkt_validate_sctp_sum() we calculate a checksum that
starts at the NetRxPkt::l4hdr_off offset.  If this offset (which
might be guest controlled) is larger than the size of the packet, the
loop that walks through the iovec can walk off the end of it.  The
resulting out-of-bounds read in attempting to convert the iov to a
buffer might cause a segfault.

We also weren't correctly checking the return values of iov_to_buf()
and iov_from_buf() when reading and writing the checksum word: if the
l4hdr_off claims the checksum word is half off the end of the packet
these functions will return the count of how much data they were able
to access, and we should fail if they don't write the entire 4 byte
word.

Return "checksum not valid" if the l4hdr_off is too large or the iov
accesses don't do the full read/write.

Note that this affects only the igb network device; the other user of
this function (e1000e) does its own check on the l4 header and won't
calculate a checksum if it's out of range.

Cc: qemu-stable@nongnu.org
Fixes: 907209e3111dd62 ("igb: Implement Rx SCTP CSO")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4138
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-1-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7149c66149a51495aaa7b6c1487cc564030ec622)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index f87b6f046cc..03a35f03154 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -549,19 +549,23 @@ _net_rx_pkt_validate_sctp_sum(struct NetRxPkt *pkt)
     uint32_t original;
     bool valid;
 
-    for (vec = pkt->vec; vec->iov_len < off; vec++) {
+    for (vec = pkt->vec; vec_len > 0 && vec->iov_len < off; vec++) {
         off -= vec->iov_len;
         vec_len--;
     }
+    if (vec_len == 0) {
+        return false;
+    }
 
     csum_off = off + 8;
 
-    if (!iov_to_buf(vec, vec_len, csum_off, &original, sizeof(original))) {
+    if (iov_to_buf(vec, vec_len, csum_off,
+                   &original, sizeof(original)) != sizeof(original)) {
         return false;
     }
 
-    if (!iov_from_buf(vec, vec_len, csum_off,
-                      &calculated, sizeof(calculated))) {
+    if (iov_from_buf(vec, vec_len, csum_off,
+                     &calculated, sizeof(calculated)) != sizeof(calculated)) {
         return false;
     }
 
-- 
2.47.3


