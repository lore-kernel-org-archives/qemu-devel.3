Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FA2C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 01:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDCky-0001yi-T7; Thu, 08 May 2025 21:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uDCkv-0001xk-EH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 21:42:29 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uDCkt-00078m-2L
 for qemu-devel@nongnu.org; Thu, 08 May 2025 21:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1746754947; x=1778290947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y3Vay5sXVxLqXgUeJJgi/wKw9KPbouS29umb+xuCRzA=;
 b=breK11eV/45FvRQ1KwhgPjzonFgfhYfZtKC8l2XUOSfpraJkcEdByIGr
 0r9p50rG6leVOruY9PUSMkZqIwLm+IAmnfZ6Arh7u/5OhOYRD2StYISMv
 EEwVRFwl4xgpXWCnoxe63Nl/tjrOI/sJzU3J6Vol3tSlF4xJb7fs/+5sw
 hQ1je9C3X/OPL120gnE+RddDLwDOGHQGv0iVy/OWaiQzyzhl/NnRBVDaP
 cdZeSR1XLBiQzvEylDc/v5tQIYfss/aZpeBY6uQ5nv1Dleh8FYnYBkh/w
 IQKur41wDeAJAGfdsOc+dxJDd6RQeXVcLNPHIpWoCiEq4ZcFahLS39jdJ Q==;
X-CSE-ConnectionGUID: AUFNV99cSlex90yPIRXXFw==
X-CSE-MsgGUID: iL33WoPXTSG8y1UcUGNhuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="186191737"
X-IronPort-AV: E=Sophos;i="6.15,273,1739804400"; d="scan'208";a="186191737"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 10:42:21 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 26D4696742
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 10:42:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D879FC8BF9
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 10:42:18 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id CF6341A00A1;
 Fri,  9 May 2025 09:42:17 +0800 (CST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCH v2 2/2] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Date: Fri,  9 May 2025 09:42:11 +0800
Message-ID: <20250509014211.1272640-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250509014211.1272640-1-lizhijian@fujitsu.com>
References: <20250509014211.1272640-1-lizhijian@fujitsu.com>
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

V2:
  - Collect Reviewed-by
  - quoate the whole string to adapt to the newer bash # Fedora40+
---
 scripts/rdma-migration-helper.sh      | 26 +++++++++++++++++++++++---
 tests/qtest/migration/precopy-tests.c | 21 +++++++++++++++++----
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
index a39f2fb0e5..9fb7a12274 100755
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
+    echo -n "[$ipv6%$1]"
+}
+
 # existing rdma interfaces
 rdma_interfaces()
 {
@@ -20,11 +29,16 @@ ipv4_interfaces()
     ip -o addr show | awk '/inet / {print $2}' | grep -v -w lo
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
+    echo "Unknown ip family '$IP_FAMILY', only ipv4 or ipv6 is supported." >&2
+    exit 1
+fi
+
 operation=${1:-detect}
 
 command -v rdma >/dev/null || {
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 4e32e61053..fb80c83967 100644
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
+    __test_precopy_rdma_plain(0);
+}
+
+static void test_precopy_rdma_plain_ipv6(void)
+{
+    __test_precopy_rdma_plain(1);
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


