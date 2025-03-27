Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9390CC36008
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 02:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txck6-0008A9-4m; Wed, 26 Mar 2025 22:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1txck4-00089w-Rg
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:13:12 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1txck2-0001le-DP
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1743041591; x=1774577591;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ThFB4JJpj5BNlLiAZGjU5GQkGR+67ntJM6+5DR3CXSE=;
 b=XO88uVaNqz1EuouMoZwiktUlTFiXgmdHTEA7azSi93MfZ7A5HbyX0Du3
 Efpx2/fQITqb77sDbFS58VQGYPzjKLE6OGxq1gD+l+ynE0OH5ZTWtSVJX
 agaBlpoJAQdMsmMxcqJ77Uhqs3PYRSfsQfBLx6PwBBPKIRbq4r5U7YdIP
 JiNzHDyOhHdTHmoBjEwqX12EM5Y8Fr7z/uHI/L9944uPQI7iRE850rr1B
 LoZVsZHPP7O3tv3O2EchnmJ9g8r//g5BlR2pPnKODKPi8YE+gxqCPEh1H
 N/EEjQMF/W/GXjRizIF83TvCjlNcnC6N3wNu/z+jTAMuNgm3CoaQi/la/ g==;
X-CSE-ConnectionGUID: sOpfBHedTP+eeVuX31l0RQ==
X-CSE-MsgGUID: bWQO9YJdQzit02OTcdeGsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="194583587"
X-IronPort-AV: E=Sophos;i="6.14,279,1736780400"; d="scan'208";a="194583587"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 11:13:06 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C3482D6EB1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 11:13:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 85A4DEA0EB
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 11:13:02 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1DE0F1A0071;
 Thu, 27 Mar 2025 10:13:00 +0800 (CST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCH] qtest/migration/rdma: Add test for rdma migration with ipv6
Date: Thu, 27 Mar 2025 10:12:34 +0800
Message-ID: <20250327021234.264161-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.48; envelope-from=lizhijian@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
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
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

This test is added based on [1]

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/rdma-migration-helper.sh      | 26 +++++++++++++++++++++++---
 tests/qtest/migration/precopy-tests.c | 21 +++++++++++++++++----
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
index 019b9ad932..c358392b72 100755
--- a/scripts/rdma-migration-helper.sh
+++ b/scripts/rdma-migration-helper.sh
@@ -8,6 +8,15 @@ get_ipv4_addr()
         head -1 | tr -d '\n'
 }
 
+get_ipv6_addr() {
+    ipv6=$(ip -6 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        head -1 | tr -d '\n')
+
+    [ $? -eq 0 ] || return
+    echo -n ["$ipv6"%$1]
+}
+
 # existing rdma interfaces
 rdma_interfaces()
 {
@@ -20,11 +29,16 @@ ipv4_interfaces()
     ip -o addr show | awk '/inet / {print $2}' | sort -u | grep -v -w lo
 }
 
+ipv6_interfaces()
+{
+    ip -o addr show | awk '/inet6 / {print $2}' | sort -u | grep -v -w lo
+}
+
 rdma_rxe_detect()
 {
     for r in $(rdma_interfaces)
     do
-        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
+        "$IP_FAMILY"_interfaces | grep -qw $r && get_"$IP_FAMILY"_addr $r && return
     done
 
     return 1
@@ -32,11 +46,11 @@ rdma_rxe_detect()
 
 rdma_rxe_setup()
 {
-    for i in $(ipv4_interfaces)
+    for i in $("$IP_FAMILY"_interfaces)
     do
         rdma_interfaces | grep -qw $i && continue
         rdma link add "${i}_rxe" type rxe netdev "$i" && {
-            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
+            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_"$IP_FAMILY"_addr $i)"
             return
         }
     done
@@ -50,6 +64,12 @@ rdma_rxe_clean()
     modprobe -r rdma_rxe
 }
 
+IP_FAMILY=${IP_FAMILY:-ipv4}
+if [ "$IP_FAMILY" != "ipv6" ] && [ "$IP_FAMILY" != "ipv4" ]; then
+    echo "Unknown ip family '$IP_FAMILY', only ipv4 or ipv6 is supported," >&2
+    exit 1
+fi
+
 operation=${1:-detect}
 
 command -v rdma >/dev/null || {
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a137ea9f2c..9f7236dc59 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -102,12 +102,13 @@ static void test_precopy_unix_dirty_ring(void)
 #ifdef CONFIG_RDMA
 
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
@@ -132,11 +133,11 @@ static int new_rdma_link(char *buffer)
     return -1;
 }
 
-static void test_precopy_rdma_plain(void)
+static void test_precopy_rdma_plain_ip(bool ipv6)
 {
     char buffer[128] = {};
 
-    if (new_rdma_link(buffer)) {
+    if (new_rdma_link(buffer, ipv6)) {
         g_test_skip("No rdma link available\n"
                     "# To enable the test:\n"
                     "# Run \'" RDMA_MIGRATION_HELPER " setup\' with root to setup"
@@ -159,6 +160,16 @@ static void test_precopy_rdma_plain(void)
 
     test_precopy_common(&args);
 }
+
+static void test_precopy_rdma_plain(void)
+{
+    test_precopy_rdma_plain_ip(0);
+}
+
+static void test_precopy_rdma_plain_ipv6(void)
+{
+    test_precopy_rdma_plain_ip(1);
+}
 #endif
 
 static void test_precopy_tcp_plain(void)
@@ -1189,6 +1200,8 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
 #ifdef CONFIG_RDMA
     migration_test_add("/migration/precopy/rdma/plain",
                        test_precopy_rdma_plain);
+    migration_test_add("/migration/precopy/rdma/plain/ipv6",
+                       test_precopy_rdma_plain_ipv6);
 #endif
 }
 
-- 
2.41.0


