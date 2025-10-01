Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45590CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yDc-00067n-UE; Wed, 01 Oct 2025 10:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yDV-00066w-Lo
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:54:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yD4-0006d1-SH
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:54:05 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CqKY8031421;
 Wed, 1 Oct 2025 14:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=Khk28l7c
 jRmP5C995+3BN9z9jXNr8NcwC59kJp6lkSw=; b=RJ59UFlwgwCtdUubiuSTuvz5
 8lDR2iddAPOL0djtOaO+n+U+bjd09VAETS5aZlHqipXm8JlQshcW6MTLRGbhONDj
 DRUea1qulRWrdFrCI5CZy9iQn8eQtuDTbEohNrftgsxUgMDo3x1phMG4UItrbN9i
 6+WTMMxC64YqC9SLeCFncX1UN9rY1htVzeJeWVbrLdIcBLfKRxoyezMHcbBqmnXV
 AAKOd3vF40ttal8gnc+daqStHfmktpOaKQHMx/y8PIvzPEPJ3madZMEMgNZNJvvh
 K5qEyfkGrgmwAMKVM137F1RgfJjAsicQiF+XsSfJq438IY/V4x2QwtPrNGt70w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmf1sknj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 14:53:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591Eklxk023225; Wed, 1 Oct 2025 14:53:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6ca98rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 14:53:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591ErO68019141;
 Wed, 1 Oct 2025 14:53:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6ca98q3-1; Wed, 01 Oct 2025 14:53:24 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] migration-test: test cpr-exec
Date: Wed,  1 Oct 2025 07:53:22 -0700
Message-Id: <1759330402-370183-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NyBTYWx0ZWRfX0caFFmj1Yvev
 L35C60cWkt8/I38euomdnLshMIUFTwFvGM5MuY4L3Z1/VihlK2Kq3VNiWtiGkRORXb4tyMJZjrZ
 DXgyZV1d40PwULBcT4wTgbYbqGXKa9v0fnGOFTT7R4gHfSidTYYYfVG/ZWSS4IBfJV0hvsO73Og
 62uWmSnzjPmntdDkesrkwZ7Gwz4ciiVcaCY8eZzGb3bjVvPK1/oX025RLvqZjZH3nxA+mZXTalk
 4BMPsZxjniXz2jdrl0d8QBmB/+imUw/B/DCCU1Cy0qCrdjailVrzJoGFZu8yIeqUn/Ox9Z0t2K0
 STuajczcJPRKDhTgEghjtVOrS7G1QgeCi8R5CdH//Y+L7IvtgmO6EwKquzfihLfqn8skXqeKME1
 AXEXhtfTyqoNDM968ViklfcMEWpeZQ==
X-Authority-Analysis: v=2.4 cv=K/cv3iWI c=1 sm=1 tr=0 ts=68dd4066 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=MmjJHHjzQzRmE1GRFR0A:9
X-Proofpoint-GUID: 1uSkQGk1XWpzVdfH-cRlnI03x66nTTWp
X-Proofpoint-ORIG-GUID: 1uSkQGk1XWpzVdfH-cRlnI03x66nTTWp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a test for the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/cpr-tests.c | 133 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5e764a6..e22bc3b 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -110,6 +110,138 @@ static void test_mode_transfer_defer(void)
     test_mode_transfer_common(true);
 }
 
+static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
+{
+    g_autofree char *qtest_from_args = NULL;
+    g_autofree char *from_args = NULL;
+    g_autofree char *to_args = NULL;
+    g_autofree char *exec_args = NULL;
+    g_auto(GStrv) argv = NULL;
+    char *from_str, *src, *dst;
+    int ret;
+
+    /*
+     * hide_stderr appends "2>/dev/null" to the command line, but cpr-exec
+     * passes the command-line words to execv, not to the shell, so suppress it
+     * here.  fd 2 was already bound in the source VM, and execv preserves it.
+     */
+    g_assert(args->start.hide_stderr == false);
+
+    ret = migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
+    g_assert(!ret);
+    qtest_from_args = qtest_qemu_args(from_args);
+
+    /*
+     * The generated args may have been formatted using "%s %s" with empty
+     * strings, which can produce consecutive spaces, which g_strsplit would
+     * convert into empty strings.  Ditto for leading and trailing space.
+     * De-dup spaces to avoid that.
+     */
+
+    from_str = src = dst = g_strstrip(qtest_from_args);
+    do {
+        if (*src != ' ' || src[-1] != ' ') {
+            *dst++ = *src;
+        }
+    } while (*src++);
+
+    exec_args = g_strconcat(qtest_qemu_binary(migration_get_env()->qemu_dst),
+                            " -incoming defer ", from_str, NULL);
+    argv = g_strsplit(exec_args, " ", -1);
+    migrate_set_parameter_strv(who, "cpr-exec-command", argv);
+}
+
+static void wait_for_migration_event(QTestState *who, const char *waitfor)
+{
+    QDict *rsp, *data;
+    char *status;
+    bool done = false;
+
+    while (!done) {
+        rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
+        g_assert(qdict_haskey(rsp, "data"));
+        data = qdict_get_qdict(rsp, "data");
+        g_assert(qdict_haskey(data, "status"));
+        status = g_strdup(qdict_get_str(data, "status"));
+        g_assert(strcmp(status, "failed"));
+        done = !strcmp(status, waitfor);
+        qobject_unref(rsp);
+    }
+}
+
+static void test_cpr_exec(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    void *data_hook = NULL;
+    g_autofree char *connect_uri = g_strdup(args->connect_uri);
+    g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
+                                                FILE_TEST_FILENAME);
+
+    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Source and dest never run concurrently */
+    g_assert_false(args->live);
+
+    if (args->start_hook) {
+        data_hook = args->start_hook(from, NULL);
+    }
+
+    wait_for_serial("src_serial");
+    set_cpr_exec_args(from, args);
+    migrate_set_capability(from, "events", true);
+    migrate_qmp(from, NULL, connect_uri, NULL, "{}");
+    wait_for_migration_event(from, "completed");
+
+    to = qtest_init_after_exec(from);
+
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { "
+                             "      'channels': [ { 'channel-type': 'main',"
+                             "      'addr': { 'transport': 'file',"
+                             "                'filename': %s,"
+                             "                'offset': 0  } } ] } }",
+                             filename);
+    wait_for_migration_complete(to);
+
+    wait_for_resume(to, get_dst());
+    /* Device on target is still named src_serial because args do not change */
+    wait_for_serial("src_serial");
+
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
+    }
+
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+}
+
+static void *test_mode_exec_start(QTestState *from, QTestState *to)
+{
+    assert(!to);
+    migrate_set_parameter_str(from, "mode", "cpr-exec");
+    return NULL;
+}
+
+static void test_mode_exec(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    g_autofree char *listen_uri = g_strdup_printf("defer");
+
+    MigrateCommon args = {
+        .start.only_source = true,
+        .start.opts_source = "-machine aux-ram-share=on -nodefaults",
+        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
+                                " -machine memory-backend=pc.ram",
+        .connect_uri = uri,
+        .listen_uri = listen_uri,
+        .start_hook = test_mode_exec_start,
+    };
+
+    test_cpr_exec(&args);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -132,5 +264,6 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         migration_test_add("/migration/mode/transfer", test_mode_transfer);
         migration_test_add("/migration/mode/transfer/defer",
                            test_mode_transfer_defer);
+        migration_test_add("/migration/mode/exec", test_mode_exec);
     }
 }
-- 
1.8.3.1


