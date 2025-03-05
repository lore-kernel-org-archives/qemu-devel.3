Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D60C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiDx-0002Ix-Km; Wed, 05 Mar 2025 01:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDg-0002Eb-BV
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:04 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDd-0007eu-W0
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741156022; x=1772692022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tDscS2j+O+Z0q86HAll9GMNNktJSP/0M29iwN+Knsv4=;
 b=gT6fwKDGzPOQjiYwZACazFU3HHE0Z98eJsI2FzVS/zncA9FNxMQeUU53
 l2xQrfIe+7UT5HwrModB0k0YfbiaubJdQeoh9kIjbSsua4YbJdSc8mjPx
 XTuA4Aprs+K18Z4xgsOxmbFqo9fRIZ2prGa7jwZz1FjhJgKS/jYlfPEaI
 ajwUD+cpaU30BqzXKL6npx/2Pr2SxnvkZdhRaDHzGqWmSrlqE2muck2Wm
 oLelfaTsEVmnJFVwBqnxNg6/ol8fZ6cUvMgetMMZI/pjTNVd2kEDFfbCC
 4rq5BDcdyjEMAFZmFYnndKjxnnEJDcZ1Cl6DnJEJgHm4LB4JD1wEoYI3k A==;
X-CSE-ConnectionGUID: 3LS0HFDkQPihESYWbd36aQ==
X-CSE-MsgGUID: xSkw5YyPQS6rNEfS0WBYNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="179366766"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; d="scan'208";a="179366766"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 15:26:56 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E7EC0106F5
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AA0ADE6475
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:53 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 057DE1A0078;
 Wed,  5 Mar 2025 14:26:52 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v5 6/6] migration: Add qtest for migration over RDMA
Date: Wed,  5 Mar 2025 14:28:25 +0800
Message-ID: <20250305062825.772629-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250305062825.772629-1-lizhijian@fujitsu.com>
References: <20250305062825.772629-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
scripts/rdma-migration-helper.sh to
- setup a new Soft-RoCE(aka RXE) if it's root
- detect existing RoCE link

Test will be skipped if there is no available RoCE link.
 # Start of rdma tests
 # Running /x86_64/migration/precopy/rdma/plain
 Command 'rdma' is not available, please install it first.
 # To enable the test:
 # (1) Run 'scripts/rdma-migration-helper.sh setup' with root and rerun the test
 # or
 # (2) Run the test with root privilege
 #
 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link available
 # End of rdma tests

Note: Remove the newly added RXE link by executing 'modprobe -r rdma_rxe'
or by specifying 'clean' within this script.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5:
  check command 'rdma' in script
  Add clean option for the script
  report details only if QTEST_LOG=1
---
 MAINTAINERS                           |  1 +
 scripts/rdma-migration-helper.sh      | 48 +++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 67 +++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100755 scripts/rdma-migration-helper.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38d..15360fcdc4b 100644
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
index 00000000000..08e29a52eb8
--- /dev/null
+++ b/scripts/rdma-migration-helper.sh
@@ -0,0 +1,48 @@
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
+has_soft_rdma()
+{
+    rdma link | grep -q " netdev $1[[:blank:]]*\$"
+}
+
+rdma_rxe_setup_detect()
+{
+    (
+        cd /sys/class/net &&
+            for i in *; do
+                [ -e "$i" ] || continue
+                [ "$i" = "lo" ] && continue
+                [ "$(<"$i/addr_len")" = 6 ] || continue
+                [ "$(<"$i/carrier")" = 1 ] || continue
+
+                has_soft_rdma "$i" && break
+                [ "$operation" = "setup" ] &&
+                    rdma link add "${i}_rxe" type rxe netdev "$i" && break
+            done
+        has_soft_rdma "$i" || return
+        get_ipv4_addr "$i"
+    )
+}
+
+operation=${1:-setup}
+
+command -v rdma >/dev/null || {
+    echo "Command 'rdma' is not available, please install it first." >&2
+    exit 1
+}
+
+if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
+    rdma_rxe_setup_detect
+elif [ "$operation" == "clean" ]; then
+    modprobe -r rdma_rxe
+else
+    echo "Usage: $0 [setup | detect | clean]"
+fi
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9a..9a4638481b4 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -99,6 +99,69 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+#ifdef CONFIG_RDMA
+
+#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
+static int new_rdma_link(char *buffer, bool verbose)
+{
+    const char *argument = (geteuid() == 0) ? "setup" : "detect";
+    char cmd[1024];
+
+    snprintf(cmd, sizeof(cmd), "%s %s %s", RDMA_MIGRATION_HELPER, argument,
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
+    bool verbose = g_getenv("QTEST_LOG");
+
+    if (new_rdma_link(buffer, verbose)) {
+        g_test_skip("No rdma link available");
+        if (verbose) {
+            g_test_message("To enable the test:\n"
+                           "(1) Run \'" RDMA_MIGRATION_HELPER " setup\' with root and rerun the test\n"
+                           "or\n(2) Run the test with root privilege\n");
+        }
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
@@ -1124,6 +1187,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
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
2.44.0


