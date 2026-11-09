Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF775606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=X7kUQ7IB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzc-00073o-Jx; Mon, 09 Nov 2026 00:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u3-4I; Mon, 09 Nov 2026 00:32:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006Ha-Nw; Mon, 09 Nov 2026 00:32:02 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtS046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1PWPfSpTpsQUoLM2IbhyYtO/CHho/MAxAEO2lE99/uU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202295; v=1;
 b=X7kUQ7IBw0FRm3QZjW0CvRrp+oqiR4bHgD0+5f1Pzf0B9A3DNOD8C52iJBpyCR6n
 wKG/tG23DDoqb//tE5eTE64TWzAwmDFOPey3v2rkT4dk3hKWQiyHWiqqqN33u7/R
 na3LqeAJ18PMlnMNbt9b4McqMCvXBLhZmYArCG+IxJtKOEqdlMSZS0laN0BJHmX6
 XdN1Josw8ZEvlj9Kcrsa21voJ99P5ydoAtSHJMu0MmLnvwi3vylUMpzGKyQd7uId
 wTi7RD4m/Jq7ItYZStgS/q7mJLm7c0lEIG4qGcA2z5GKOuqj4UGlKzd9PRwDGSmP
 kzDuaZRw0VtIQCtZPzF7hg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:49 +0900
Subject: [PATCH v2 04/14] net/eth.c: In eth_get_protocols(), don't report
 TCP data offset off end of packet
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-4-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=xBUF+wGLcCflMruqyziIwNETSXIzU8t31Fp6gufY6wo=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqPlL62xaV08Jc/5fIt9jp3gl4Rf7DcveHyW/gvZxi
 ztNbVvbUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCcJNdGBl655gv/l6x5YRvOfPO
 CZts7iWYrnse279DT/d8Def1k0JbGf6XdZyfe0eZ93f+2zunlAqfhNuYnb7H3FT57Ai7/bYFRRO
 YAQ==
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

eth_get_protocols() already rejects some out-of-bounds offsets found in
packets. Add a missing check for TCP data offset.

Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 net/eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/eth.c b/net/eth.c
index 038f7d889c33..a444377fd0ae 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -197,7 +197,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         if (_eth_copy_chunk(input_size,
                             iov, iovcnt,
                             *l4hdr_off, sizeof(l4hdr_info->hdr.tcp),
-                            &l4hdr_info->hdr.tcp)) {
+                            &l4hdr_info->hdr.tcp) &&
+            input_size - *l4hdr_off >= TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp)) {
             l4hdr_info->proto = ETH_L4_HDR_PROTO_TCP;
             *l5hdr_off = *l4hdr_off +
                 TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp);

-- 
2.56.0


