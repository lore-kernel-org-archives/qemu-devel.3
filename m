Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE33606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=akvnyCuK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzS-0006zB-OE; Mon, 09 Nov 2026 00:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u6-5F; Mon, 09 Nov 2026 00:32:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006HT-L9; Mon, 09 Nov 2026 00:32:01 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtP046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=cLiz4iKSk0iO00Jbp4tO8M/i0jukd0yN2q4d79rROSk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202294; v=1;
 b=akvnyCuKxOwgDvcAqXDANdK8WvBy19OiZJpJIVMwGy//1+VI4lVmEYYDawOBFH7N
 js37ESlDVF+kqn8Cmc3HCno08kfOE7nRyJpEuLNTeHIdzKmhUj8htjcMKsdiYywW
 fRzKJT7vlpKmb5FjgrCa78AnA3IYdJeDMW41OdHhEEjhuk2qmd63dICW8jAWkx0P
 rdIXvMse4yuqa5G9J6QBannfinHfPjSl27OygyonlFZmFhzP5pEwwwnrva0XLuI1
 qJcJSOAnPvj+SKZJNbY7qdo3/v0p0ZcewdSK6RHUi0OmWwMcJ/rygoRz8TUxen/K
 qaIrZNYyQLjE3Yf9ZG7KhA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:46 +0900
Subject: [PATCH v2 01/14] hw/net/net_rx_pkt: Handle bogus l4hdr_off when
 validating SCTP checksum
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-1-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=6AOMtftVXVnBrguVzdDQMUbU5LQT8baBDLpMNBZR74E=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqLnpndfXrHndr3KjyHmK30XWF2eyTrc77To+7ZpTo
 LNz+9GKjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIlodTP8d5Uo1PdUk7/S6C9h
 ZSJ1+2JLh+/8k5vzRTYt/RlxZ+7hDEaGJwJOvq/PmPxY9ynT7oz0SeF13WXJZ2enHTfZmn137ak
 cNgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
---
 hw/net/net_rx_pkt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index f87b6f046ccf..03a35f03154d 100644
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
2.56.0


