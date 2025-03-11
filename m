Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31F3C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trpZy-0007wX-QY; Mon, 10 Mar 2025 22:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1trpZw-0007wI-Oq
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:42:48 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1trpZt-0000lR-Si
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741660966; x=1773196966;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RYskoaqq7a1XVbEi6np6bACwLqW5CYbN2q22akBTq58=;
 b=g9ErDfXM+Wwrxko2GgLfrJqHw/wqE4zdwFk85q2GcqoDQgsRkjTSq2+r
 YwFLrvn9HcAELID++XMU2V8L5MVWWaKMLKFYb46YfPUuSno7GPBY9BFcv
 h5EC6d+ll/2RDn8lLAdi37LaY/ZOEY2q7kEMGmWaRTtaWPO7CbdewP/oK
 jZ9PIaM9vRlx6EvQaiLBCULZfDm/SYtPVuo+TjM3LNaNheHSlBvkRAdD2
 LFitYwJ4vXBccnQ7wytvrOlPSVkuA/Dct9tWHl6oFNd/1QiGTnnI297Q9
 xSt0g391rmMn8FExuZPOJmrzLZoPweqXj9KQR/vj3VTXOGOAbkiPDyEPI Q==;
X-CSE-ConnectionGUID: +KonMk+cTBatNbSmvo6bAg==
X-CSE-MsgGUID: h7qfeHYUSquCU6AIpIiR9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="192607688"
X-IronPort-AV: E=Sophos;i="6.14,237,1736780400"; d="scan'208";a="192607688"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 11:42:41 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 50986D4C31
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:42:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1499AD8B00
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:42:38 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B8B211A0078;
 Tue, 11 Mar 2025 10:42:36 +0800 (CST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Subject: [PATCH v6] migration: Add qtest for migration over RDMA
Date: Tue, 11 Mar 2025 10:42:21 +0800
Message-ID: <20250311024221.363421-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.49; envelope-from=lizhijian@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
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

This qtest requires there is a RDMA(RoCE) link in the host.
In order to make the test work smoothly, introduce a
scripts/rdma-migration-helper.sh to detect existing RoCE link before
running the test.

Test will be skipped if there is no available RoCE link.
 # Start of rdma tests
 # Running /x86_64/migration/precopy/rdma/plain
 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link available
 # To enable the test:
 # Run 'scripts/rdma-migration-helper.sh setup' with root to setup a new rdma/rxe link and rerun the test
 # Optional: run 'scripts/rdma-migration-helper.sh clean' to revert the 'setup'

 # End of rdma tests

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

Hi Fabiano,

Please replace this patch in your new PR.
---
V6:
  - make scripts/rdma-migration-helper.sh rubost, including
    1) only setup rdma/rxe on a valid ipv4 interface # resolve gitlab-ci aarch64 runner
    2) split setup and detect operation
    3) check root for setup/clean operation
  - rdma migration test only detect rdma link, local users should 'setup' rdma explicitly # don't dirty the system quietly
  - print skip message in TAP format, starting with #
---
 MAINTAINERS                           |  1 +
 scripts/rdma-migration-helper.sh      | 70 +++++++++++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 66 +++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100755 scripts/rdma-migration-helper.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38..15360fcdc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3480,6 +3480,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
+F: scripts/rdma-migration-helper.sh
 
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
new file mode 100755
index 0000000000..c4382134cd
--- /dev/null
+++ b/scripts/rdma-migration-helper.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+
+# Copied from blktests
+get_ipv4_addr()
+{
+    ip -4 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        tr -d '\n'
+}
+
+# existing rdma interfaces
+rdma_interfaces()
+{
+    rdma link show | sed -nE 's/^link .* netdev ([^ ]+).*$/\1 /p'
+}
+
+# existing valid ipv4 interfaces
+ipv4_interfaces()
+{
+    ip -o addr show | awk '/inet / {print $2}' | grep -v -w lo
+}
+
+rdma_rxe_detect()
+{
+    for r in $(rdma_interfaces)
+    do
+        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
+    done
+
+    return 1
+}
+
+rdma_rxe_setup()
+{
+    for i in $(ipv4_interfaces)
+    do
+        rdma_interfaces | grep -qw $i && continue
+        rdma link add "${i}_rxe" type rxe netdev "$i" && {
+            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
+            return
+        }
+    done
+
+    echo "Failed to setup any new rdma/rxe link" >&2
+    return 1
+}
+
+rdma_rxe_clean()
+{
+    modprobe -r rdma_rxe
+}
+
+operation=${1:-detect}
+
+command -v rdma >/dev/null || {
+    echo "Command 'rdma' is not available, please install it first." >&2
+    exit 1
+}
+
+if [ "$operation" == "setup" ] || [ "$operation" == "clean" ]; then
+    [ "$UID" == 0 ] || {
+        echo "Root privilege is required to setup/clean a rdma/rxe link" >&2
+        exit 1
+    }
+    rdma_rxe_"$operation"
+elif [ "$operation" == "detect" ]; then
+    rdma_rxe_detect
+else
+    echo "Usage: $0 [setup | detect | clean]"
+fi
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9..557b7f3aa7 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -99,6 +99,68 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+#ifdef CONFIG_RDMA
+
+#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
+static int new_rdma_link(char *buffer)
+{
+    char cmd[256];
+    bool verbose = g_getenv("QTEST_LOG");
+
+    snprintf(cmd, sizeof(cmd), "%s detect %s", RDMA_MIGRATION_HELPER,
+             verbose ? "" : "2>/dev/null");
+
+    FILE *pipe = popen(cmd, "r");
+    if (pipe == NULL) {
+        perror("Failed to run script");
+        return -1;
+    }
+
+    int idx = 0;
+    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
+        idx += strlen(buffer);
+    }
+
+    int status = pclose(pipe);
+    if (status == -1) {
+        perror("Error reported by pclose()");
+        return -1;
+    } else if (WIFEXITED(status)) {
+        return WEXITSTATUS(status);
+    }
+
+    return -1;
+}
+
+static void test_precopy_rdma_plain(void)
+{
+    char buffer[128] = {};
+
+    if (new_rdma_link(buffer)) {
+        g_test_skip("No rdma link available\n"
+                    "# To enable the test:\n"
+                    "# Run \'" RDMA_MIGRATION_HELPER " setup\' with root to setup"
+                    " a new rdma/rxe link and rerun the test\n"
+                    "# Optional: run 'scripts/rdma-migration-helper.sh clean' to"
+                    " revert the 'setup'\n");
+        return;
+    }
+
+    /*
+     * TODO: query a free port instead of hard code.
+     * 29200=('R'+'D'+'M'+'A')*100
+     **/
+    g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
+
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    test_precopy_common(&args);
+}
+#endif
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -1124,6 +1186,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+#ifdef CONFIG_RDMA
+    migration_test_add("/migration/precopy/rdma/plain",
+                       test_precopy_rdma_plain);
+#endif
 }
 
 void migration_test_add_precopy(MigrationTestEnv *env)
-- 
2.41.0


