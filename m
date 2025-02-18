Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93780C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIFX-0007Bp-JG; Tue, 18 Feb 2025 02:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkIFU-0007BV-T1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:42:32 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkIFS-0005GW-1y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739864550; x=1771400550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tAeie4Nv1m3JsKfCNSiisBP/iePZGVJoWYKsJih6Pic=;
 b=eiACgXfpY5LljXYEUrzJTRifxDX2NhMyJqGqXQR9EzhXMhmb2D6cebz+
 tOK6HX4oWwQfe08Cm9Ap63svP7YoYBZSc3vzCZjGg7kmSxW1eWjR5Ii1l
 QAkznPRi4S/MwIQFCjITWVYQ40VnnW7bJ/4wVscd7kYb9bPbeKG2WpU1E
 csXp8TlYLyZuJOW2iCWALdPmEbDjOnKk9Vnf87tR/pPb9APPcvRseXyiV
 Cwich5NUGQjMJrJAGWil55lvk4u2Let3cNW1sDu9/rm5j8uIJDqTTxgR9
 CGYkM4W8DQ3n14NpIfyyme+imL/Ls53gOENXKMmN4yqnyLnz7/MIeXoV7 w==;
X-CSE-ConnectionGUID: X5o/V+bkRo+Jmwk3paKJ9Q==
X-CSE-MsgGUID: 0BXhSETDRCmkIKblDekPcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="190374028"
X-IronPort-AV: E=Sophos;i="6.13,295,1732546800"; d="scan'208";a="190374028"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 16:42:24 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F0AC4DBB8C
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 16:42:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B9403D8ADF
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 16:42:21 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 27D321A006C;
 Tue, 18 Feb 2025 15:42:21 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Date: Tue, 18 Feb 2025 15:43:45 +0800
Message-ID: <20250218074345.638203-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250218074345.638203-1-lizhijian@fujitsu.com>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.48; envelope-from=lizhijian@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
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

This qtest requirs there is RXE link in the host.

Here is an example to show how to add this RXE link:
$ ./new-rdma-link.sh
192.168.22.93

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
The RDMA migration was broken again...due to lack of sufficient test/qtest.

It's urgly to add and execute a script to establish an RDMA link in
the C program. If anyone has a better suggestion, please let me know.

$ cat ./new-rdma-link.sh
get_ipv4_addr() {
        ip -4 -o addr show dev "$1" |
                sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
}

has_soft_rdma() {
        rdma link | grep -q " netdev $1[[:blank:]]*\$"
}

start_soft_rdma() {
        local type

        modprobe rdma_rxe || return $?
        type=rxe
        (
                cd /sys/class/net &&
                        for i in *; do
                                [ -e "$i" ] || continue
                                [ "$i" = "lo" ] && continue
                                [ "$(<"$i/addr_len")" = 6 ] || continue
                                [ "$(<"$i/carrier")" = 1 ] || continue
                                has_soft_rdma "$i" && break
                                rdma link add "${i}_$type" type $type netdev "$i" && break
                        done
                has_soft_rdma "$i" && echo $i
        )

}

rxe_link=$(start_soft_rdma)
[[ "$rxe_link" ]] && get_ipv4_addr $rxe_link

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/qtest/migration/new-rdma-link.sh |  34 ++++++++
 tests/qtest/migration/precopy-tests.c  | 103 +++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 tests/qtest/migration/new-rdma-link.sh

diff --git a/tests/qtest/migration/new-rdma-link.sh b/tests/qtest/migration/new-rdma-link.sh
new file mode 100644
index 00000000000..ca20594eaae
--- /dev/null
+++ b/tests/qtest/migration/new-rdma-link.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+
+# Copied from blktests
+get_ipv4_addr() {
+	ip -4 -o addr show dev "$1" |
+		sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
+}
+
+has_soft_rdma() {
+	rdma link | grep -q " netdev $1[[:blank:]]*\$"
+}
+
+start_soft_rdma() {
+	local type
+
+	modprobe rdma_rxe || return $?
+	type=rxe
+	(
+		cd /sys/class/net &&
+			for i in *; do
+				[ -e "$i" ] || continue
+				[ "$i" = "lo" ] && continue
+				[ "$(<"$i/addr_len")" = 6 ] || continue
+				[ "$(<"$i/carrier")" = 1 ] || continue
+				has_soft_rdma "$i" && break
+				rdma link add "${i}_$type" type $type netdev "$i" && break
+			done
+		has_soft_rdma "$i" && echo $i
+	)
+
+}
+
+rxe_link=$(start_soft_rdma)
+[[ "$rxe_link" ]] && get_ipv4_addr $rxe_link
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 162fa695318..d2a1c9c9438 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -98,6 +98,105 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+static int new_rdma_link(char *buffer) {
+    // Copied from blktests
+    const char *script =
+        "#!/bin/bash\n"
+        "\n"
+        "get_ipv4_addr() {\n"
+        "    ip -4 -o addr show dev \"$1\" |\n"
+        "    sed -n 's/.*[[:blank:]]inet[[:blank:]]*\\([^[:blank:]/]*\\).*/\\1/p'\n"
+        "}\n"
+        "\n"
+        "has_soft_rdma() {\n"
+        "    rdma link | grep -q \" netdev $1[[:blank:]]*\\$\"\n"
+        "}\n"
+        "\n"
+        "start_soft_rdma() {\n"
+        "    local type\n"
+        "\n"
+        "    modprobe rdma_rxe || return $?\n"
+        "    type=rxe\n"
+        "    (\n"
+        "        cd /sys/class/net &&\n"
+        "        for i in *; do\n"
+        "            [ -e \"$i\" ] || continue\n"
+        "            [ \"$i\" = \"lo\" ] && continue\n"
+        "            [ \"$(<$i/addr_len)\" = 6 ] || continue\n"
+        "            [ \"$(<$i/carrier)\" = 1 ] || continue\n"
+        "            has_soft_rdma \"$i\" && break\n"
+        "            rdma link add \"${i}_$type\" type $type netdev \"$i\" && break\n"
+        "        done\n"
+        "        has_soft_rdma \"$i\" && echo $i\n"
+        "    )\n"
+        "}\n"
+        "\n"
+        "rxe_link=$(start_soft_rdma)\n"
+        "[[ \"$rxe_link\" ]] && get_ipv4_addr $rxe_link\n";
+
+    char script_filename[] = "/tmp/temp_scriptXXXXXX";
+    int fd = mkstemp(script_filename);
+    if (fd == -1) {
+        perror("Failed to create temporary file");
+        return 1;
+    }
+
+    FILE *fp = fdopen(fd, "w");
+    if (fp == NULL) {
+        perror("Failed to open file stream");
+        close(fd);
+        return 1;
+    }
+    fprintf(fp, "%s", script);
+    fclose(fp);
+
+    if (chmod(script_filename, 0700) == -1) {
+        perror("Failed to set execute permission");
+        return 1;
+    }
+
+    FILE *pipe = popen(script_filename, "r");
+    if (pipe == NULL) {
+        perror("Failed to run script");
+        return 1;
+    }
+
+    int idx = 0;
+    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
+        idx += strlen(buffer);
+    }
+    if (buffer[idx - 1] == '\n')
+        buffer[idx - 1] = 0;
+
+    int status = pclose(pipe);
+    if (status == -1) {
+        perror("Error reported by pclose()");
+    } else if (!WIFEXITED(status)) {
+        printf("Script did not terminate normally\n");
+    }
+
+    remove(script_filename);
+
+    return 0;
+}
+
+static void test_precopy_rdma_plain(void)
+{
+    char buffer[128] = {};
+
+    if (new_rdma_link(buffer))
+        return;
+
+    g_autofree char *uri = g_strdup_printf("rdma:%s:7777", buffer);
+
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    test_precopy_common(&args);
+}
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -968,6 +1067,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
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


