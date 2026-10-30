Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A849606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=u+NgReSM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwa-0000a3-8E; Fri, 30 Oct 2026 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns4-0006lJ-Ki
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:21 -0400
Received: from va-2-60.ptr.blmpb.com ([209.127.231.60])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns3-0005WK-7n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371574; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=S373b6INcUskvZiANkuk47aA7ugPOpLUtMs7W+bwOJg=;
 b=u+NgReSMbdVgOi61L/p1Ug5yhqct0rCBZFFKg0J4hFeO6LYGjOw3b160awjdjMP5Etw/ey
 7e3mlQDLHw/vSukYAX5OskxRm8Snyh183jX3xsSU8aj2lNClbKXjaaIqbXgWj4eNfGs/VA
 ViQLbDv2Gdv1oYmiEB6ErPUlpbeIEEdgh8CiP+C7rijYwLKHW7cLu6OM++6+bYtCBTQZku
 IPi6MKle3UK6NoBy/gyynwrdCbzhGqk+8oarb4O/TPECkRVJNdh4KAyS09LA3NAbuTG8bT
 CQUeL84ViTfAmmzD/HDAV7lykohKWcRYiKIwoTvLZvN3jQEvn8+tE0lu5i6Gdw==
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Date: Fri, 30 Oct 2026 22:45:46 +0800
Message-Id: <d4c2e0235980af1c30ce80f7ff32b398ccb0e4d5.1793370600.git.lbyxiaolizi@x6z.top>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26ae4adb5+1b9d53+nongnu.org+lbyxiaolizi@x6z.top>
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:13 +0000
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, "Alberto Garcia" <berto@igalia.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
To: <qemu-devel@nongnu.org>
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Subject: [PATCH 8/9] hw/char/ipoctal232: check channel FIFO indices in
 post_load
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.231.60; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-60.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:47 -0400
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
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS,
	T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SCC2698Channel has mr[2] and rhr[RX_FIFO_SIZE] (3 bytes), indexed by
mr_idx and rhr_idx during register reads and writes.

vmstate_scc2698_channel restores mr_idx, rhr_idx and rx_pending as raw
uint8_t values. Add a post_load check to ensure mr_idx < ARRAY_SIZE(mr),
rhr_idx < RX_FIFO_SIZE, and rx_pending <= RX_FIFO_SIZE.

Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/char/ipoctal232.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index b66c20f..c2f4f6c 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -125,10 +125,23 @@ struct IPOctalState {
     uint8_t irq_vector;
 };
 
+static int scc2698_channel_post_load(void *opaque, int version_id)
+{
+    SCC2698Channel *ch = opaque;
+
+    if (ch->mr_idx >= ARRAY_SIZE(ch->mr) ||
+        ch->rhr_idx >= RX_FIFO_SIZE ||
+        ch->rx_pending > RX_FIFO_SIZE) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_scc2698_channel = {
     .name = "scc2698_channel",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = scc2698_channel_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rx_enabled, SCC2698Channel),
         VMSTATE_UINT8_ARRAY(mr, SCC2698Channel, 2),

