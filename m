Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44950606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=gX3n5wMb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwZ-0000Zc-3H; Fri, 30 Oct 2026 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrz-0006jN-3X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:15 -0400
Received: from va-2-44.ptr.blmpb.com ([209.127.231.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrv-0005UY-Lw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371562; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=X1nMYVoyRxNOFXLn2YAORhpwscR4ljectrCcBrHi0WY=;
 b=gX3n5wMbWHY5K4Gt4RfKAhQCcErp1LTt/U15YbKgU8IkruGac1s8YQV0jM5n9vlWXzllZt
 VEHxT3tHsreHfw1u0krmCgp48qEzCTi2tRYz/igc0rz/q3DlOxIU+DKfY3+t0BRi9ckGoP
 JAYrHivPxhPz5t8CAV0ivjRFM6X3e6U13A2K7oJXF8BFqhCFFP9YR40wn0RW5zOkg3HNUh
 +s/8baJqf4GqjFjXPfBmU9d6/SVrRxRu9fCaHs4FmVMlWCXBaM0mNM3IZyC42sAgDch4bS
 5hZ0UTuPeGRjRisi6oTRAV9+e1AejsIrywI8BjjW3NYgZAaE0ooffrLjWkUIcA==
Subject: [PATCH 1/9] util/fifo8: check head and num bounds in post_load
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
X-Mailer: git-send-email 2.56.0
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Content-Transfer-Encoding: 7bit
To: <qemu-devel@nongnu.org>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, "Peter Xu" <peterx@redhat.com>, 
 "Fabiano Rosas" <farosas@suse.de>
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:01 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 22:45:39 +0800
Message-Id: <c48aa68f58f3b320f7979b465d9e330313b25adf.1793370600.git.lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4ada9+b2ffcc+nongnu.org+lbyxiaolizi@x6z.top>
Received-SPF: pass client-ip=209.127.231.44; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-44.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:46 -0400
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fifo8_pop() and fifo8_peek() index fifo->data[fifo->head] before
wrapping modulo capacity, and fifo8_push() asserts that
fifo->num < fifo->capacity.

vmstate_fifo8 restores head and num as raw uint32_t values without
checking them against fifo->capacity. Add a post_load hook to reject
streams where head >= capacity or num > capacity.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4772
Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 util/fifo8.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/util/fifo8.c b/util/fifo8.c
index cc4f590..5dda26b 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
 #include "qemu/fifo8.h"
+#include "qemu/error-report.h"
 
 void fifo8_reset(Fifo8 *fifo)
 {
@@ -177,10 +178,24 @@ uint32_t fifo8_num_used(const Fifo8 *fifo)
     return fifo->num;
 }
 
+static int fifo8_post_load(void *opaque, int version_id)
+{
+    Fifo8 *fifo = opaque;
+
+    if (fifo->head >= fifo->capacity || fifo->num > fifo->capacity) {
+        error_report("fifo8: invalid state from migration stream "
+                     "(head=%u num=%u capacity=%u)",
+                     fifo->head, fifo->num, fifo->capacity);
+        return -EINVAL;
+    }
+    return 0;
+}
+
 const VMStateDescription vmstate_fifo8 = {
     .name = "Fifo8",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = fifo8_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(data, Fifo8, 1, NULL, capacity),
         VMSTATE_UINT32(head, Fifo8),

