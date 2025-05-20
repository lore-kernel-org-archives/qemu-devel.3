Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C48EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRr-00007u-0q; Tue, 20 May 2025 13:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRi-0008Rw-9D
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRg-000165-9F
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qY1AUIA6ijEBYZA6sdiasVuRJE305+tULljHJYN/mSM=;
 b=UbLfwEpVtXXc9fI3h0BxjRhPKrDHyfabbWcsPoMSK208RUkj3VDsvCN7ryQhwhRwoxmlXm
 BzPdcfSDmOOKt2Rn40KL3RpS96unGNz38BeSDSgYzAO4wIIOMYXwQ1ES0RjOAD0qjcTC/u
 u6IeSlwCHUvugnMW2UDTZI15DIChZfA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-A1DGnXsxOyyznupgk-R9wA-1; Tue, 20 May 2025 13:08:00 -0400
X-MC-Unique: A1DGnXsxOyyznupgk-R9wA-1
X-Mimecast-MFC-AGG-ID: A1DGnXsxOyyznupgk-R9wA_1747760880
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5b9333642so679833885a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760879; x=1748365679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qY1AUIA6ijEBYZA6sdiasVuRJE305+tULljHJYN/mSM=;
 b=DNgJ8sygAQnWqwU1XTOblaEj3eW9RHtDISRTuqn6AuGu2RkIMFgRmzBlUwTqv2eek7
 yk8oajeV3B/R79i+3SNmdAxFy0x67EoUe94DGHgIoQVVCOEBYWQYRu4LMG/oiKP1IY6l
 MEPbZGggEwSE6TdtpJrTTkKwkgQPtFeGYwyIKLBQcTOyxp75e3UQRMYR2Bo2J5eMslnQ
 zW1L48dYv6Wns584sAlpw3t/hZgDTLWUjdfKoaEAIn52c9s9BtRAWiEQUnBsTOjFtuSC
 8tHPw0mbtdQEt8NmFejxILW4VmLSd6zahi8XYs5Srrof157C5oaNZH1TDTy321Q4lpgh
 B4Ug==
X-Gm-Message-State: AOJu0Yz47MnbjaEIRFuX8d8ocyDUdjlvIbWsls/0P+glEnJmBvrwFlkf
 VsBL2pXaWtso6d/yVZHeZXXQn4wRz+E9d7d1ud69NJQXzriOEImNIohdHxeAfTr3IJA5PhkCVvm
 zrCjcQA12fak1lo8+Chqw/ujKFvD0M39Dk7MJMJ9HWPd26W6/t5PeGC+YD0gKA71H7rWTTLUSfZ
 SJnxgL3g29JSLDXdUL5BfaphHPd8CbRHLAakzHbg==
X-Gm-Gg: ASbGncsmHCHd41PtNU7spz4t2Ms4qY28bIuK1QKWY2nDS2JNZtjK8HOrap4DH3XPPuK
 WTTzEqFgFVa7cbN0oWkjxP9DBj5m/Ye0yVALhBUNQ+1nTvAzJjLR09YpEyikRCuPMQRB+aDkaSJ
 iFGrv4FNxkdWXSsG4HnQI3mP8qn6DCPSFWHzGbM5VI3o0g58M0C7Qiyrkx1HErWGyOfF7l2f+Pa
 Glf3TSDPPmDDYpEkDQyclxPwOySUXVI/VL1ahmTPsssGjkWdiQmja6FDKTs0PU6nnK1NY/dKvKj
X-Received: by 2002:a05:620a:370a:b0:7c5:5e5b:2fdb with SMTP id
 af79cd13be357-7cd4677d69cmr2912243185a.41.1747760879303; 
 Tue, 20 May 2025 10:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAOBQaU2XywMsAhySyQMLL1//jg8KqIle/kmQfUg/MKeKythcQ7TrQy2L7nfiQUJsjotsAsw==
X-Received: by 2002:a05:620a:370a:b0:7c5:5e5b:2fdb with SMTP id
 af79cd13be357-7cd4677d69cmr2912235685a.41.1747760878670; 
 Tue, 20 May 2025 10:07:58 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:07:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 "Michael R. Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: [PULL 03/12] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Date: Tue, 20 May 2025 13:07:42 -0400
Message-ID: <20250520170751.786787-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Recently, we removed ipv6 restriction[0] from RDMA migration, add a
test for it.

[0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@ionos.com/

Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yu Zhang <yu.zhang@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/20250513012207.2867069-1-lizhijian@fujitsu.com
[peterx: Fix over long lines]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 21 ++++++++--
 scripts/rdma-migration-helper.sh      | 57 ++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 5be1cd5742..a62d3c5378 100644
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
 
diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
index a39f2fb0e5..d784d1566a 100755
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
@@ -32,16 +53,23 @@ rdma_rxe_detect()
 
 rdma_rxe_setup()
 {
-    for i in $(ipv4_interfaces)
+    family=$1
+    for i in $("$family"_interfaces)
     do
-        rdma_interfaces | grep -qw $i && continue
+        if rdma_interfaces | grep -qw $i; then
+            echo "$family: Reuse the existing rdma/rxe ${i}_rxe" \
+                 "for $i with $(get_"$family"_addr $i)"
+            return
+        fi
+
         rdma link add "${i}_rxe" type rxe netdev "$i" && {
-            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
+            echo "$family: Setup new rdma/rxe ${i}_rxe" \
+                 "for $i with $(get_"$family"_addr $i)"
             return
         }
     done
 
-    echo "Failed to setup any new rdma/rxe link" >&2
+    echo "$family: Failed to setup any new rdma/rxe link" >&2
     return 1
 }
 
@@ -50,6 +78,12 @@ rdma_rxe_clean()
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
@@ -62,9 +96,14 @@ if [ "$operation" == "setup" ] || [ "$operation" == "clean" ]; then
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
-- 
2.49.0


