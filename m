Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8DECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrd-00013j-93; Fri, 19 Sep 2025 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbrO-0000dN-Vn
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbr1-0007X5-AY
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:11 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtx9Y017770;
 Fri, 19 Sep 2025 14:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=wXZLS5UtEyfzb4d7ZH/lUrbR16DqyuP19wLDXUNyxLk=; b=
 VqbZmwJnwN1rXp+cWsxcxfbPmgy1HMuyhDn/tTNfVNP6+0qDU/z/k6d06lL8Rq+Z
 5cJO0xmwP1P+jn8lgj/CkrP14uoJeYpQEuWR8AN80iLFRFvgtXXP6DCgtAOF4x8w
 3Cb2+WVtQpW7PRH/kgFe9cnD+FXQPUmd2wS5i3lF9TZ8yM8+3/hkbjIQ8p/DhZ/X
 Qv8iy4UGlfkA3+2y5CfQUm8Efiz9p6ch/a8ErXvpitJDPKJgbunxy4LVywa2rkvF
 rllLJpkYlKc6jDl5tDvypkcAaPiDSC2Ej1xj8VUcI+TNMQqtO2px39LiheZDDCOu
 k0rsYMX8ep31yzYm2p6zJA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9wpqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCbtwr035133; Fri, 19 Sep 2025 14:12:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu982-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXN003357;
 Fri, 19 Sep 2025 14:12:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-12; Fri, 19 Sep 2025 14:12:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 11/11] migration-test: test cpr-exec
Date: Fri, 19 Sep 2025 07:12:33 -0700
Message-Id: <1758291153-349744-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190132
X-Proofpoint-ORIG-GUID: Iy526LlzEYDF6NcBbSJP4D-AF4Ps00Ze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1eNNbEDgQsZr
 cW8DdeLiB3qLGd1iXCPIjAPgWKCW/xxeHhY4FYHCFChlRNyoBMKeSOjqfwJBeOmsmnUszjj8ao3
 xDYMNNYF3aMspDY04UIzOv4OlwtMjjOB/5oL/m1B8r5+39iX4z9a+SII/tHv42U6dOaxs4SLROh
 hYUAXuPH4uOscQWTOHkLBTQp0gq8iF+/ihlBqtI8RIhQAm4KSoNPqXkaH0qnZOrB/KR8GRWnuXz
 XbqAt7rQbyoqydmF2GGwlZsBSWxD0qxCU15zqgi9p8dMe/AM1tKV2ERWsCTtyOKzh76WN2eCraf
 qOhHnI/YRPe8fkKIPjLqrUK9DCSkvsxNkuI9ou826Jnk9kfp6okVG/X6Na7do1N68BYKcqK4rMu
 9KovxICraRxrGRRUczsmPftj7T23lw==
X-Proofpoint-GUID: Iy526LlzEYDF6NcBbSJP4D-AF4Ps00Ze
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd64df b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=6wcYFj--zyk-7TOt8ToA:9 cc=ntf
 awl=host:13614
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tests/qtest/migration/cpr-tests.c | 120 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5e764a6..f33af76 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -110,6 +110,125 @@ static void test_mode_transfer_defer(void)
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
+
+    args->start.hide_stderr = false;    /* omit redirection word from args */
+    migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
+    qtest_from_args = qtest_qemu_args(from_args);
+
+    /* De-dup spaces so argv does not contain empty strings */
+    from_str = src = dst = g_strstrip(qtest_from_args);
+    do {
+        if (*src != ' ' || src[-1] != ' ') {
+            *dst++ = *src;
+        }
+    } while (*src++);
+
+    exec_args = g_strconcat(qtest_qemu_binary(QEMU_ENV_SRC),
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
@@ -132,5 +251,6 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         migration_test_add("/migration/mode/transfer", test_mode_transfer);
         migration_test_add("/migration/mode/transfer/defer",
                            test_mode_transfer_defer);
+        migration_test_add("/migration/mode/exec", test_mode_exec);
     }
 }
-- 
1.8.3.1


