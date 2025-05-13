Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B5BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeLi-0002Vo-4q; Mon, 12 May 2025 21:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uEeLf-0002Va-KY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:22:23 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uEeLc-0000Zx-CL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1747099340; x=1778635340;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=i0gAwfI6LZc22O+zB2O4psvlYSss7nYLq9ss9uF5tJw=;
 b=iTn7hIIftXvRmnmWHIi0/rccsknqUpnZpWoP7vjqkkgce+qUwsPwSuVm
 dFDAwIpz8tMdzkYYMUegO5V8GNtMbdJJgBLP/OgQ/+Y37MbjBG/fJh+Ri
 iiZ6YtJP6/oABf7hfutgG5f5LJhcxHmHwFtFx1zRSazylUeQvGR6cpf0w
 wXUWm5eoVqEJxrSCKf1wbsnoi5opKmKPB4Vp94XS2G0OUsHscgqm24kUZ
 Ks8jhRmmlGi6fXjrODR3C9hU54kzNi1gvvMTSRTa8sW7+8qqtmDMRExRb
 8WxP5k5H3HubZQ6ko8oNwJc15k9m5/nAGixMXjIBFGPcTw6PznX0Ox1+U Q==;
X-CSE-ConnectionGUID: DOak+Z1aSuarjIYSGev2tw==
X-CSE-MsgGUID: 1Ft4qMiKQZ+Lmd5yMWzt2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="187191852"
X-IronPort-AV: E=Sophos;i="6.15,283,1739804400"; d="scan'208";a="187191852"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 10:22:15 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C5597C68A5
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:22:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 87089D5071
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:22:13 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3CF611A0078;
 Tue, 13 May 2025 09:22:12 +0800 (CST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCH v4] qtest/migration/rdma: Add test for rdma migration with ipv6
Date: Tue, 13 May 2025 09:22:07 +0800
Message-ID: <20250513012207.2867069-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Recently, we removed ipv6 restriction[0] from RDMA migration, add a
test for it.

[0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@ionos.com/

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yu Zhang <yu.zhang@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4:
  adjust the address format per its ipv6 address type
V3:
  - skip unsupported rxe interfaces: lo, tun, tap
  - setup/reuse both ipv4 and ipv4 in one setup shot
V2:
  - Collect Reviewed-by
  - quoate the whole string to adapt to the newer bash # Fedora40+
---
 scripts/rdma-migration-helper.sh      | 55 ++++++++++++++++++++++-----
 tests/qtest/migration/precopy-tests.c | 21 ++++++++--
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
index a39f2fb0e5..88b161bcec 100755
--- a/scripts/rdma-migration-helper.sh
+++ b/scripts/rdma-migration-helper.sh
@@ -8,23 +8,44 @@ get_ipv4_addr()
         head -1 | tr -d '\n'
 }
 
+get_ipv6_addr() {
+    ipv6=$(ip -6 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        head -1 | tr -d '\n')
+
+    [ $? -eq 0 ] || return
+
+    if [[ "$ipv6" =~ ^fe80: ]]; then
+        echo -n "[$ipv6%$1]"
+    else
+        echo -n "[$ipv6]"
+    fi
+}
+
 # existing rdma interfaces
 rdma_interfaces()
 {
-    rdma link show | sed -nE 's/^link .* netdev ([^ ]+).*$/\1 /p'
+    rdma link show | sed -nE 's/^link .* netdev ([^ ]+).*$/\1 /p' |
+    grep -Ev '^(lo|tun|tap)'
 }
 
 # existing valid ipv4 interfaces
 ipv4_interfaces()
 {
-    ip -o addr show | awk '/inet / {print $2}' | grep -v -w lo
+    ip -o addr show | awk '/inet / {print $2}' | grep -Ev '^(lo|tun|tap)'
+}
+
+ipv6_interfaces()
+{
+    ip -o addr show | awk '/inet6 / {print $2}' | grep -Ev '^(lo|tun|tap)'
 }
 
 rdma_rxe_detect()
 {
+    family=$1
     for r in $(rdma_interfaces)
     do
-        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
+        "$family"_interfaces | grep -qw $r && get_"$family"_addr $r && return
     done
 
     return 1
@@ -32,16 +53,21 @@ rdma_rxe_detect()
 
 rdma_rxe_setup()
 {
-    for i in $(ipv4_interfaces)
+    family=$1
+    for i in $("$family"_interfaces)
     do
-        rdma_interfaces | grep -qw $i && continue
+        if rdma_interfaces | grep -qw $i; then
+            echo "$family: Reuse the existing rdma/rxe ${i}_rxe for $i with $(get_"$family"_addr $i)"
+            return
+        fi
+
         rdma link add "${i}_rxe" type rxe netdev "$i" && {
-            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
+            echo "$family: Setup new rdma/rxe ${i}_rxe for $i with $(get_"$family"_addr $i)"
             return
         }
     done
 
-    echo "Failed to setup any new rdma/rxe link" >&2
+    echo "$family: Failed to setup any new rdma/rxe link" >&2
     return 1
 }
 
@@ -50,6 +76,12 @@ rdma_rxe_clean()
     modprobe -r rdma_rxe
 }
 
+IP_FAMILY=${IP_FAMILY:-ipv4}
+if [ "$IP_FAMILY" != "ipv6" ] && [ "$IP_FAMILY" != "ipv4" ]; then
+    echo "Unknown ip family '$IP_FAMILY', only ipv4 or ipv6 is supported." >&2
+    exit 1
+fi
+
 operation=${1:-detect}
 
 command -v rdma >/dev/null || {
@@ -62,9 +94,14 @@ if [ "$operation" == "setup" ] || [ "$operation" == "clean" ]; then
         echo "Root privilege is required to setup/clean a rdma/rxe link" >&2
         exit 1
     }
-    rdma_rxe_"$operation"
+    if [ "$operation" == "setup" ]; then
+        rdma_rxe_setup ipv4
+        rdma_rxe_setup ipv6
+    else
+        rdma_rxe_clean
+    fi
 elif [ "$operation" == "detect" ]; then
-    rdma_rxe_detect
+    rdma_rxe_detect "$IP_FAMILY"
 else
     echo "Usage: $0 [setup | detect | clean]"
 fi
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 4e32e61053..16cede23aa 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -131,12 +131,13 @@ static bool mlock_check(void)
 }
 
 #define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
-static int new_rdma_link(char *buffer)
+static int new_rdma_link(char *buffer, bool ipv6)
 {
     char cmd[256];
     bool verbose = g_getenv("QTEST_LOG");
 
-    snprintf(cmd, sizeof(cmd), "%s detect %s", RDMA_MIGRATION_HELPER,
+    snprintf(cmd, sizeof(cmd), "IP_FAMILY=%s %s detect %s",
+             ipv6 ? "ipv6" : "ipv4", RDMA_MIGRATION_HELPER,
              verbose ? "" : "2>/dev/null");
 
     FILE *pipe = popen(cmd, "r");
@@ -161,7 +162,7 @@ static int new_rdma_link(char *buffer)
     return -1;
 }
 
-static void test_precopy_rdma_plain(void)
+static void __test_precopy_rdma_plain(bool ipv6)
 {
     char buffer[128] = {};
 
@@ -170,7 +171,7 @@ static void test_precopy_rdma_plain(void)
         return;
     }
 
-    if (new_rdma_link(buffer)) {
+    if (new_rdma_link(buffer, ipv6)) {
         g_test_skip("No rdma link available\n"
                     "# To enable the test:\n"
                     "# Run \'" RDMA_MIGRATION_HELPER " setup\' with root to "
@@ -193,6 +194,16 @@ static void test_precopy_rdma_plain(void)
 
     test_precopy_common(&args);
 }
+
+static void test_precopy_rdma_plain(void)
+{
+    __test_precopy_rdma_plain(false);
+}
+
+static void test_precopy_rdma_plain_ipv6(void)
+{
+    __test_precopy_rdma_plain(true);
+}
 #endif
 
 static void test_precopy_tcp_plain(void)
@@ -1226,6 +1237,8 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
 #ifdef CONFIG_RDMA
     migration_test_add("/migration/precopy/rdma/plain",
                        test_precopy_rdma_plain);
+    migration_test_add("/migration/precopy/rdma/plain/ipv6",
+                       test_precopy_rdma_plain_ipv6);
 #endif
 }
 
-- 
2.41.0


