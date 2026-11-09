Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B646606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=nXpRvGJ2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzZ-00072q-Fa; Mon, 09 Nov 2026 00:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u5-58; Mon, 09 Nov 2026 00:32:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006HP-M2; Mon, 09 Nov 2026 00:32:01 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtX046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hgsLZVIzqN1s0ptlMlimjKPYT6F6BOVi3Flo+YBsffY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202296; v=1;
 b=nXpRvGJ2EHeBP32BpdycoWcqvn8EgaVtQ9ZuHON0Yiy0N7FSdIO9a5ryi9vdOg4k
 MGyoaH6ibwLzV3h/Rw8foxsjRkS0wX1TpKjmOGqiZDOOH4+lTu5UUYt7FZRupXJt
 vc2+EJaIo1RP7jyosmxyqUOTzrlgjjch/oE4yGv3EoFFwmV+kRrkjVEumcLyZSem
 nVqWM7F/BrvVouIcX2xltFCdsuM+DpfEB3DhF858LI/lH974FbAcJhHEGS1Bu4E7
 pGYWeAlz2M3xzUDdGZYQ1KYGUgBmWhmVGg//yXkhSIkT52nN270IvzKevEWZndIx
 QU6stbry6t5pjPQVbKSZ2A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:54 +0900
Subject: [PATCH v2 09/14] net/eth.c: Tighten size checks in eth_get_l3_proto()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-9-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=XaT4vcW7ec9yi3UiWa06GbFMZOjuqjipeNY2z1NjG8w=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqKXvqjPu2YfGJD83OuD++EHYhSViCm+WCE64Jb3j9
 dueF9K7O0pZGMS4GGTFFFlSinZza0TXfipMiG+BmcPKBDKEgYtTACYSW8TIMElb5P28a38unooK
 rbv1dgnnx5z+c4YnnzLYtfmJ3yzedJCRYbWCl9q59Pavv1cYslq++NFxoaJ0Q2PA4nUiL8/+tEr
 M4QYA
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
---
 net/eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 749866094fa1..c8ecf6d6dc73 100644
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
2.56.0


