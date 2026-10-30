Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96D60A2609
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=fIARnCLS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwa-0000a2-7n; Fri, 30 Oct 2026 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns0-0006jc-6D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:19 -0400
Received: from va-2-43.ptr.blmpb.com ([209.127.231.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrx-0005V8-Da
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371568; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EClvhrEbzf0In10VM4N9Y6OtRYRuIL/MB2ZN6pf3w70=;
 b=fIARnCLSYUcTdKom4mPZAiffzjeUL7FPphHOzgfbvpq6y7MiRwqvAyTbXOIk+88BbzenX/
 4rot/XeqOLeAGzUo0NhTVbgq7Eze/wSzLTj3cnYOFPn0agCQyBmTcgI3iE6z42VzwzMooJ
 9HZFyHsXi5vj4QzQCLFl3LL47+ZKe9quUDLLfVo/OTevLSQ2dZNRP4BZny8ZcJkuAeDbN+
 CmCACu7aGiNgctpf3pegfJ8jbc9dl+Wd54kFT/Beihv8rkv+/G1meSbReoR8A/tR3Abrpx
 RNCxJ5vIn86Kag1IZfoNkItrCmPcHK9ASbPDXO/FnFVBnc1fksS83Nw8DbGNsw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4adb0+7d6144+nongnu.org+lbyxiaolizi@x6z.top>
Subject: [PATCH 5/9] hw/hyperv/vmbus: check rx_queue head and size in post_load
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Message-Id: <7291dd89682cd9d64dac5ffde6265e74128c6226.1793370600.git.lbyxiaolizi@x6z.top>
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Date: Fri, 30 Oct 2026 22:45:43 +0800
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:07 +0000
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.231.43; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-43.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:50 -0400
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
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VMBus.rx_queue has HV_MSG_QUEUE_LEN (16) entries, and vmbus_post_load()
schedules process_message(), which indexes
vmbus->rx_queue[vmbus->rx_queue_head] directly.

vmstate_rx_queue loads rx_queue_head and rx_queue_size as uint8_t
values without bounds checking. Add a post_load hook to reject
rx_queue_head >= HV_MSG_QUEUE_LEN or rx_queue_size > HV_MSG_QUEUE_LEN.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4776
Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/hyperv/vmbus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 3973ca8..a542a3b 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2607,11 +2607,23 @@ static bool vmbus_rx_queue_needed(void *opaque)
     return vmbus->rx_queue_size;
 }
 
+static int vmbus_rx_queue_post_load(void *opaque, int version_id)
+{
+    VMBus *vmbus = VMBUS(opaque);
+
+    if (vmbus->rx_queue_head >= HV_MSG_QUEUE_LEN ||
+        vmbus->rx_queue_size > HV_MSG_QUEUE_LEN) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_rx_queue = {
     .name = "vmbus/rx_queue",
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = vmbus_rx_queue_needed,
+    .post_load = vmbus_rx_queue_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(rx_queue_head, VMBus),
         VMSTATE_UINT8(rx_queue_size, VMBus),

