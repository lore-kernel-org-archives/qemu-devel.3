Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15375606A330
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TY/aHd0F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zw-00049q-I1; Thu, 05 Nov 2026 17:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zg-00047i-O5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:44 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5ze-0002Kl-GO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:39 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86657600C8;
 Thu,  5 Nov 2026 22:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345BF1F0089F;
 Thu,  5 Nov 2026 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917896;
 bh=St5TWIps6jtHT42c51SgksB+Ii4MZSThaJt2gmB1zhg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TY/aHd0FqALwNzjT22aOxAceBpmJ8nEi+dy2QR9QfdgXFmC9oRj0lsyWEB4D7NW9E
 G3wfJIchSCistb6yiacRZiNW+rkI7hZrQBsp0FfzP89tGfdpOmlEn3KNolGiTBZpxj
 gTF8nn8znh6CoTrdk40PLquNQWB7D1ZHkGzLJVmVxsPndDGMe7MDrF1lVBkdkjSRgt
 p1ku0HktXAW3GobGNtXSwfFzdIWitg8qGpBfwSy+0Vlimg8JSFNeX86MdEryN+ramD
 0xQcRa5Uiao0ZFmMpdg1B9JMRsmqWSm6eDZLibvy3usKq7MJVPt/bGSazRL7WFG0f0
 k6j/7xQN8IZAQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 7/8] i82596: Fix source address inserting
Date: Thu,  5 Nov 2026 23:31:21 +0100
Message-ID: <20261105223122.8729-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Insert the source address after the destination instead of overwriting
bytes 6-11.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 6bcae73815..19e1bf47db 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -631,8 +631,14 @@ static int i82596_tx_process_frame(I82596State *s)
         return 0;
     }
 
-    if (I596_NO_SRC_ADD_IN == 0 && total_len >= ETH_ALEN * 2) {
+    if (I596_NO_SRC_ADD_IN == 0 && total_len >= ETH_ALEN) {
+        if (total_len + ETH_ALEN > sizeof(s->tx_buffer)) {
+            return 0;
+        }
+        memmove(&s->tx_buffer[ETH_ALEN * 2], &s->tx_buffer[ETH_ALEN],
+                total_len - ETH_ALEN);
         memcpy(&s->tx_buffer[ETH_ALEN], s->conf.macaddr.a, ETH_ALEN);
+        total_len += ETH_ALEN;
     }
 
     if (I596_PADDING && total_len < I596_MIN_FRAME_LEN) {
-- 
2.54.0


