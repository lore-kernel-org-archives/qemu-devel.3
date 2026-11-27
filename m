Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00119606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Gw/ks73H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp0j-0001aJ-4w; Fri, 27 Nov 2026 01:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0J-0001JJ-Eq; Fri, 27 Nov 2026 01:00:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0G-00064j-Pt; Fri, 27 Nov 2026 01:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758880; bh=uMWSR77riw2IlGo5c+3lFMiGCFuQybT4gEkqJOIcp0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Gw/ks73HM9NWbShPCepZFUpkwGV1aC/ODFv4jozW46DsjGM5S2ObD4BWsVgEfwsMN
 Ta3RsIMw1WyQOB/2WV2Ilp0x7e5zpW/FpouPMSDMwJ2t6WDH+iS6oC6bX7joIeX5VQ
 zIzwWzYXmu46YibCuaK2W0YDktrk0Qu5+WNr5CkX15WUVR5naXLPJf0A2r085ZTu6n
 Bnd7xQKYrFQa++a5DBCQDoe4KvEDzf+7tux9LxsLDaqEmVxBcE/MBSOZfpwLtX/fRE
 eYgN8Sk4pUCunkteZMQPRxqmSEYxxg3+IUcAfb3ggjxSzcmInwJPmtUbRYIyUNXlC+
 C5FiOInIRy48w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 803261EA302;
 Fri, 27 Nov 2026 08:54:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7DB9246993C;
 Fri, 27 Nov 2026 08:54:40 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 77D85CF284; Fri, 27 Nov 2026 08:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 119/140] net/checksum.c: Correct handling of IP
 header length
Date: Fri, 27 Nov 2026 08:53:45 +0300
Message-ID: <20261127055421.39015-60-mjt@tls.msk.ru>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In net_checksum_calculate() we are careless about handling of the IP
header length, in a way which can allow it to become negative for a
suitably crafted packet.  This bypasses the attempt to check that
it's big enough, because in comparisons like
  if (ip_len < sizeof(tcp_header))
ip_len is converted to size_t and we do this as an unsigned
comparison, so negative values of ip_len pass the check.

This results in net_checksum_tcpudp() attempting to checksum nearly
64K of memory (because it takes the length as a uint16_t), which will
typically be a read off the end of a buffer resulting in a segfault.
If the attacker is able to set up a situation where the read doesn't
fault, it's possible for some callers that the 2-byte store of the
updated checksum is an out-of-bounds write.

This code is used by at least xen-nic, virtio-net, and the COLOj
filter-rewriter, all of which are in QEMU's security "virtualization
use case", though the write is probably only exploitable for the
filter-rewriter; otherwise it's just a theoretical "information leak
to guest" of a 2-byte checksum of 64K of host RAM.

Improve the checking of lengths in this function:
 * make the input length size_t as it is a buffer length
 * use unsigned int for internal always-positive lengths, so
   comparisons are always unsigned-vs-unsigned
 * check length before subtracting various header sizes,
   rather than afterwards
 * check that the packet's IHL field reports a valid header
   length that's not larger than the packet itself
 * check that the packet's total length field doesn't claim
   to be smaller than the header

All the callsites are already passing an unsigned value to this
function, with the exception of those in ftgmac100.c and imx_fec.c.
Those two pass an "int" value which can't ever be negative.

Cc: qemu-stable@nongnu.org
Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
Fixes: CVE-2026-127233
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4720
Reported-by: Xiang Chen <https://gitlab.com/x14ngch3n>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261114132350.1456994-2-peter.maydell@linaro.org
(cherry picked from commit 434b0d52dc8c8515f3129aa1bf1b5b3d8cb8184c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 188e4cca0b7..6c565f2e0ab 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -30,7 +30,7 @@ uint32_t net_checksum_add_cont(int len, uint8_t *buf, int seq);
 uint16_t net_checksum_finish(uint32_t sum);
 uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
                              uint8_t *addrs, uint8_t *buf);
-void net_checksum_calculate(void *data, int length, int csum_flag);
+void net_checksum_calculate(void *data, size_t length, int csum_flag);
 
 static inline uint32_t
 net_checksum_add(int len, uint8_t *buf)
diff --git a/net/checksum.c b/net/checksum.c
index 537457d89d0..9e4ba1bc910 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -57,9 +57,9 @@ uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
     return net_checksum_finish(sum);
 }
 
-void net_checksum_calculate(void *data, int length, int csum_flag)
+void net_checksum_calculate(void *data, size_t length, int csum_flag)
 {
-    int mac_hdr_len, ip_len;
+    unsigned int mac_hdr_len, ip_len, ip_hdr_len;
     struct ip_header *ip;
     uint16_t csum;
 
@@ -94,23 +94,33 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
         break;
     }
 
-    length -= mac_hdr_len;
-
     /* Now check we have an IP header (with an optional VLAN header) */
-    if (length < sizeof(struct ip_header)) {
+    if (length < mac_hdr_len + sizeof(struct ip_header)) {
         return;
     }
 
+    length -= mac_hdr_len;
+
     ip = (struct ip_header *)((uint8_t *)data + mac_hdr_len);
 
     if (IP_HEADER_VERSION(ip) != IP_HEADER_VERSION_4) {
         return; /* not IPv4 */
     }
 
+    ip_hdr_len = IP_HDR_GET_LEN(ip);
+
+    if (ip_hdr_len < sizeof(struct ip_header) || ip_hdr_len > length) {
+        /*
+         * Ignore packet with an invalidly short IHL, or which claims the
+         * IP header is larger than the buffer
+         */
+        return;
+    }
+
     /* Calculate IP checksum */
     if (csum_flag & CSUM_IP) {
         stw_he_p(&ip->ip_sum, 0);
-        csum = net_raw_checksum((uint8_t *)ip, IP_HDR_GET_LEN(ip));
+        csum = net_raw_checksum((uint8_t *)ip, ip_hdr_len);
         stw_be_p(&ip->ip_sum, csum);
     }
 
@@ -120,12 +130,16 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
 
     ip_len = lduw_be_p(&ip->ip_len);
 
-    /* Last, check that we have enough data for the all IP frame */
-    if (length < ip_len) {
+    /*
+     * Last, check that the packet's total length field doesn't
+     * imply a negative amount of data given the header length,
+     * and that it's not larger than the data buffer we have.
+     */
+    if (ip_len < ip_hdr_len || length < ip_len) {
         return;
     }
 
-    ip_len -= IP_HDR_GET_LEN(ip);
+    ip_len -= ip_hdr_len;
 
     switch (ip->ip_p) {
     case IP_PROTO_TCP:
-- 
2.47.3


