Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A139C3ABC5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 01:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDCkx-0001y3-4g; Thu, 08 May 2025 21:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uDCkv-0001xn-KL
 for qemu-devel@nongnu.org; Thu, 08 May 2025 21:42:29 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uDCkt-00078l-5r
 for qemu-devel@nongnu.org; Thu, 08 May 2025 21:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1746754947; x=1778290947;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sdrZ0mUKvHAvZsRduHwt/IzipovVmLLchmaylnrr30E=;
 b=WfYI2SO+lCzw8lFK1qu732dX8rVQZsXw+pBILm++YB0Jqx8Q99U4RJZi
 GwGNE0OY3Fa3iOAY/bSBXSALQHRNzABfBs5UoD7p5HpJjn3dOmB+eYDnf
 iaTNw+tY0+KRwf3H0Zpc5iAioeZTlTVXEZpKdfwAC5WR4dZcLp2i7Z/Qx
 xrWrIoPjxV5Q5HJmlEf5N9YDMkEoSCwCg5yx5XS/pR7nI7ty++8DqGS6J
 Vq180WwQ/2mjkPCrH6/U8JXXI3AhOBSc+ZQaYhjPb3VYqHu4HF4RRsdZT
 ObNBs0WyyRTcxMZh+PZ9zxLn71NW/hKUo8jfooyDLrJZlI4I8JK0sY/fx w==;
X-CSE-ConnectionGUID: T/M8gcaqQdynxAXWRfuGPQ==
X-CSE-MsgGUID: qsxAiqHsQ9WyhtnyzHt+wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="201744022"
X-IronPort-AV: E=Sophos;i="6.15,273,1739804400"; d="scan'208";a="201744022"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 10:42:20 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A268E8521
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 10:42:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 27451D9732
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 10:42:18 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 083EC1A009A;
 Fri,  9 May 2025 09:42:16 +0800 (CST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 1/2] qtest/migration/rdma: Enforce RLIMIT_MEMLOCK >= 128MB
 requirement
Date: Fri,  9 May 2025 09:42:10 +0800
Message-ID: <20250509014211.1272640-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=lizhijian@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ensure successful migration over RDMA by verifying that RLIMIT_MEMLOCK is
set to at least 128MB. This allocation is necessary due to the requirement
to pin significant portions of guest memory, typically exceeding 100MB
in this test, while the remainder is transmitted as compressed zero pages.

Otherwise, it will fail with:
stderr:
qemu-system-x86_64: cannot get rkey
qemu-system-x86_64: error while loading state section id 2(ram)
qemu-system-x86_64: load of migration failed: Operation not permitted
qemu-system-x86_64: rdma migration: recv polling control error!
qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
qemu-system-x86_64: failed to save SaveStateEntry with id(name): 2(ram): -1
qemu-system-x86_64: Channel error: Operation not permitted

Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/qtest/migration/precopy-tests.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 02465c20ae..4e32e61053 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -101,6 +101,35 @@ static void test_precopy_unix_dirty_ring(void)
 
 #ifdef CONFIG_RDMA
 
+#include <sys/resource.h>
+
+/*
+ * During migration over RDMA, it will try to pin portions of guest memory,
+ * typically exceeding 100MB in this test, while the remainder will be
+ * transmitted as compressed zero pages.
+ *
+ * REQUIRED_MEMLOCK_SZ indicates the minimal mlock size in the current context.
+ */
+#define REQUIRED_MEMLOCK_SZ (128 << 20) /* 128MB */
+
+/* check 'ulimit -l' */
+static bool mlock_check(void)
+{
+    uid_t uid;
+    struct rlimit rlim;
+
+    uid = getuid();
+    if (uid == 0) {
+        return true;
+    }
+
+    if (getrlimit(RLIMIT_MEMLOCK, &rlim) != 0) {
+        return false;
+    }
+
+    return rlim.rlim_cur >= REQUIRED_MEMLOCK_SZ;
+}
+
 #define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
 static int new_rdma_link(char *buffer)
 {
@@ -136,6 +165,11 @@ static void test_precopy_rdma_plain(void)
 {
     char buffer[128] = {};
 
+    if (!mlock_check()) {
+        g_test_skip("'ulimit -l' is too small, require >=128M");
+        return;
+    }
+
     if (new_rdma_link(buffer)) {
         g_test_skip("No rdma link available\n"
                     "# To enable the test:\n"
-- 
2.41.0


