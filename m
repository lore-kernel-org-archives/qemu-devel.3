Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7E606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=cMpzZBeY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8u-0000uD-6H; Fri, 27 Nov 2026 01:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7n-0006ag-Rt; Fri, 27 Nov 2026 01:08:06 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7j-0006Mn-Qm; Fri, 27 Nov 2026 01:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=5HwSi+FLpK6mk14uWAx654F15zMRVgUumXct+AxS31I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cMpzZBeYTnxHZW411QS/cx6CrgjeIqkmNruuVeSkpefT3qcyH1+eyLAAXJ6AWxSD9
 AImoL5wa6WEliFgIrdrz3cBHOfKA3yZ4ZCkRBbmvFHRwgDf9ef7Z9CI94gOIUF4aRb
 RhlbAiKKuuDRC2yb+vtYNxAMuHBajjRq1IlFB9GoCyTcHO3DOlN/jMlYW2xefvVClK
 ouXafpQiivw68BHSi1ls44I2mQUTWybagAS5vDyV8dbPwgC4O3KixXYBWQQidr8t5v
 Rs7iJC/zYC/WgH/jje8LM9/DoeQBCamcpgWCs7MP20U5IjGG2WIHzZUsv387YsAcK+
 E+lyG+X7MEcfw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2645B1EA368;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 22609469993;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 086F1CF31E; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 118/152] nbd: Refactor structured payload
 interpretation
Date: Fri, 27 Nov 2026 08:54:16 +0300
Message-ID: <20261127055709.39630-55-mjt@tls.msk.ru>
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

From: Eric Blake <eblake@redhat.com>

An upcoming patch wants to reuse the payload of a structured reply
chunk in further code for additional safety checks on the server's
response.  It will be easiest if the initial parse converts the
payload from network order into host order along the way, so that I
don't introduce subtle endian-specific bugs in that upcoming code. A
quick audit shows that none of the current callers of
payload_advance*() were reading a memory location within the payload
after its initial parse.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261113223742.2546619-7-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 369852b536ed817824d757c4f132f71bcc6d74e1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nbd.c b/block/nbd.c
index e5e16722ba2..052469b3547 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -578,24 +578,36 @@ err:
     return rc;
 }
 
+/* Consume a field of payload, while swapping it in place to host-endian. */
 static inline uint16_t payload_advance16(uint8_t **payload)
 {
+    uint16_t value = lduw_be_p(*payload);
+    stw_he_p(*payload, value);
     *payload += 2;
-    return lduw_be_p(*payload - 2);
+    return value;
 }
 
 static inline uint32_t payload_advance32(uint8_t **payload)
 {
+    uint32_t value = ldl_be_p(*payload);
+    stl_he_p(*payload, value);
     *payload += 4;
-    return ldl_be_p(*payload - 4);
+    return value;
 }
 
 static inline uint64_t payload_advance64(uint8_t **payload)
 {
+    uint64_t value = ldq_be_p(*payload);
+    stq_he_p(*payload, value);
     *payload += 8;
-    return ldq_be_p(*payload - 8);
+    return value;
 }
 
+/*
+ * nbd_parse_offset_hole_payload:
+ * Parse a chunk for NBD_REPLY_TYPE_OFFSET_HOLE, updating payload in
+ * place to a host-endian description of the region described.
+ */
 static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_offset,
-- 
2.47.3


