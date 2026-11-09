Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A86606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=mxqFRY0z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzR-0006xN-GM; Mon, 09 Nov 2026 00:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u1-3Z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:32:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006HU-B4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:32:01 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtQ046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=U56RFa7x+IaqujX2yXhRp/iTyAE2XXP/zdsjk8V6gXs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202294; v=1;
 b=mxqFRY0zX/inaoi9+gdTi+f0RM+MY9NMNzKNz7pT6jt22pphoAuy/+D9dCpSPUj9
 ZgW//ohPLOmXXIY1uQKObnrS6fcnujw8fzAgfAnIDARdbRsCIBDEumLThYfETZP0
 XzE0HIyzEbOEkG3wz7CfZGtlg81ro/EdbUJRiUyIJqU0eqSWdyb6y4QtPEuou+mi
 Y+wOyYV5IxYSKAlK34X4o4c8xJH6cQhdwN3JOFC85yUSDM9wJkqKZ7dQl3qFMVTT
 mye7pw+tJ+wBEGbV764PSdh6PwdLyJh8aPInKP7TToGCMTyZ4pWCg9Hv6SI49ioz
 IeQOa+I26R+qcRA0WkbEIA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:47 +0900
Subject: [PATCH v2 02/14] net/eth.c: Check for undersized L2 headers in
 eth_get_protocols()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-2-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=czsctkVOkFfXgtnSRXWt556uIZ6EbzX2ykTov13/Gfk=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqLlTF55bphTEUtj3+dtF3hNH96Q5q0nuaTvUopywt
 CRFSe94RykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwER+tjD8L7FsL+otlw/TEjw1
 xzN8rxp/x5eZFu8KuA3f7v7bdGzDVYbfbEFP9wjOPeZxV2NSOH+TW8BrQ7u9r05PFGNqsuktCjr
 CDwA=
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

We already have some header bounds checks. Add a missing check for
L2 headers.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 net/eth.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 12ec316e240e..59b278b887c1 100644
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
2.56.0


