Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D5ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rvq-0001nk-Vw; Sun, 05 Oct 2025 12:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rvo-0001lq-Vv; Sun, 05 Oct 2025 12:49:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rvm-00078K-SY; Sun, 05 Oct 2025 12:49:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1029A15AA3F;
 Sun, 05 Oct 2025 19:49:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 154EC2996F7;
 Sun,  5 Oct 2025 19:49:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 78/81] include/system/memory.h: Clarify
 address_space_destroy() behaviour
Date: Sun,  5 Oct 2025 19:47:58 +0300
Message-ID: <20251005164822.442861-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

address_space_destroy() doesn't actually immediately destroy the AS;
it queues it to be destroyed via RCU. This means you can't g_free()
the memory the AS struct is in until that has happened.

Clarify this in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-2-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 9e7bfda4909cc688dd0327e17985019f08a78d5d)
(Mjt: this is just a comment fix, but it makes subsequent changes to apply c
leanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed126..30888daaeb 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2715,9 +2715,14 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
 /**
  * address_space_destroy: destroy an address space
  *
- * Releases all resources associated with an address space.  After an address space
- * is destroyed, its root memory region (given by address_space_init()) may be destroyed
- * as well.
+ * Releases all resources associated with an address space.  After an
+ * address space is destroyed, the reference the AddressSpace had to
+ * its root memory region is dropped, which may result in the
+ * destruction of that memory region as well.
+ *
+ * Note that destruction of the AddressSpace is done via RCU;
+ * it is therefore not valid to free the memory the AddressSpace
+ * struct is in until after that RCU callback has completed.
  *
  * @as: address space to be destroyed
  */
-- 
2.47.3


