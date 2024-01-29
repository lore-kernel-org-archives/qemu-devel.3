Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F7CC47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 03:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHwo-00043K-2r; Sun, 28 Jan 2024 22:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwm-0003zO-Ac
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwk-0002b2-Or
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpC3flOEeKNg7RiQbz7rs+mTBSJWZUS3FmJ01r0jr00=;
 b=NW2QZAVIQW9E2xDrAsU6WF70u50OiLZQBjCL7zVMPnTN8swszZ2T6xpLaj/o7+T3XDdCyD
 nekvcWRBL2I51SYYwNGqu4Qagy/lO6GOQBHsEQLT5wtqQChB5OAXnzq1KSr2xq4Qo9K4He
 dyOrTbDgSyBVDUogW6YsdCKlqcUcDvI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-BJhTepR5ObmLnBW0whRbIw-1; Sun, 28 Jan 2024 22:04:28 -0500
X-MC-Unique: BJhTepR5ObmLnBW0whRbIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D78810354C2;
 Mon, 29 Jan 2024 03:04:28 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D632B1121306;
 Mon, 29 Jan 2024 03:04:25 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 05/14] analyze-migration.py: Remove trick on parsing ramblocks
Date: Mon, 29 Jan 2024 11:03:56 +0800
Message-ID: <20240129030405.177100-6-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

RAM_SAVE_FLAG_MEM_SIZE contains the total length of ramblock idstr to know
whether scanning of ramblocks is complete.  Drop the trick.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240117075848.139045-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/analyze-migration.py | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index a39dfb8766..8a254a5b6a 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -151,17 +151,12 @@ def read(self):
             addr &= ~(self.TARGET_PAGE_SIZE - 1)
 
             if flags & self.RAM_SAVE_FLAG_MEM_SIZE:
-                while True:
+                total_length = addr
+                while total_length > 0:
                     namelen = self.file.read8()
-                    # We assume that no RAM chunk is big enough to ever
-                    # hit the first byte of the address, so when we see
-                    # a zero here we know it has to be an address, not the
-                    # length of the next block.
-                    if namelen == 0:
-                        self.file.file.seek(-1, 1)
-                        break
                     self.name = self.file.readstr(len = namelen)
                     len = self.file.read64()
+                    total_length -= len
                     self.sizeinfo[self.name] = '0x%016x' % len
                     if self.write_memory:
                         print(self.name)
-- 
2.43.0


