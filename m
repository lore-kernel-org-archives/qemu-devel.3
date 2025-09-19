Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F7CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrh-0001DW-9e; Fri, 19 Sep 2025 10:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbrB-0000V9-8l
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqz-0007Wi-Ce
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:59 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtphp015796;
 Fri, 19 Sep 2025 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=C94fURgxAcm48QywS9BooAcBLZJFdjmOuloYy2rtAog=; b=
 rKo7Yj2zAEPUbq7WYJky85OtGgto8jrSsEFehD9ghhV8QyAEZ1J01gjeA/yTnYYx
 z5EJXc9+NeO/YtkBHXPuu424oZuJh44geuReiSVMAjIvD3M9JkJO1veXLIHrrNDm
 rnR8TXIcMlgKISlcfv8wGZtU30RfBvopsqfr5aNQmygmzsZ/FpYcnuteMBtUoOth
 hQfs8YNR5UzyLTUEOV8nnzy8US+medGP1TFkJM93sy6PftWPlkXT/2fO6Mo2bswp
 aNHScTuZ/tUC5SC3g9RB+0Li6R5ZnQAPraEiGOedd3EyHQD8hKEoCqOcurwM/p8J
 eXYtPGNTa5Y1BeEADQe7lw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx95m0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCUAfh035203; Fri, 19 Sep 2025 14:12:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu97m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXL003357;
 Fri, 19 Sep 2025 14:12:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-11; Fri, 19 Sep 2025 14:12:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 10/11] migration-test: strv parameter
Date: Fri, 19 Sep 2025 07:12:32 -0700
Message-Id: <1758291153-349744-11-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: 0n83KltxGh5VqQ7EyK0GtZ6_qeLTzGBC
X-Proofpoint-GUID: 0n83KltxGh5VqQ7EyK0GtZ6_qeLTzGBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7PbAHpzBcBn6
 C3f0veiOMR085J3Jvdxe4KIzISxVkajm/MtgvQvfxopix1agYrKkjPihEhkoYnoacXn/ytkMVJq
 2Ws4QOm7cZCRqx6fwXP2WgXrFv0mRO70vvqubj0ITX7HPZ1EmPJT7tfwC66nwBaE+ZoxOXv3B7A
 +VcdkHa8XIZYfDhGvDomDyJUUI+Kw8b3styaTP6g6a3m0fAEaCXb33tWbfpYMR2FyozwC29LXn6
 Cha+jked8qnND9Zv7jdy/PrizX8J84mAtualyuQFojK4vvNuTOpLtrmFGC/C/QhLdH3h3q2iZXm
 tpmGxKNniQ9NZj7u+U6KHkk24TtPdNfXzjKiD4gXIXpexPbzjMFMXnm5Npz7J6Z2WnOrsgDDtw6
 wUhhzNQfWolgHOFGDx7WPJEnxTTWAw==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cd64dd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=7rmqtDVDOkByKEcGYTsA:9 cc=ntf
 awl=host:13614
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define migrate_set_parameter_strv.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/migration-qmp.h |  2 ++
 tests/qtest/migration/migration-qmp.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index faa8181..44482d2 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -34,6 +34,8 @@ void read_blocktime(QTestState *who);
 void wait_for_migration_pass(QTestState *who, QTestMigrationState *src_state);
 void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                const char *value);
+void migrate_set_parameter_strv(QTestState *who, const char *parameter,
+                                char **strv);
 void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
 void migrate_ensure_non_converge(QTestState *who);
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 66dd369..c803fce 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -442,6 +442,22 @@ void migrate_set_parameter_str(QTestState *who, const char *parameter,
     migrate_check_parameter_str(who, parameter, value);
 }
 
+void migrate_set_parameter_strv(QTestState *who, const char *parameter,
+                                char **strv)
+{
+    g_autofree char *args = g_strjoinv("\",\"", strv);
+    g_autoptr(GString) value = g_string_new("");
+    g_autofree char *command = NULL;
+
+    g_string_printf(value, "\"%s\"", args);
+
+    command = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
+                              "'arguments': { %%s: [ %s ]}}",
+                              value->str);
+
+    qtest_qmp_assert_success(who, command, parameter);
+}
+
 static long long migrate_get_parameter_bool(QTestState *who,
                                             const char *parameter)
 {
-- 
1.8.3.1


