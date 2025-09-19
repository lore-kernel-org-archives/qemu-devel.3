Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D15CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbdp-0005VS-6J; Fri, 19 Sep 2025 09:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbdT-0005S4-Kx
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:58:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbdL-0003Bz-2a
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:58:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuMKP017630;
 Fri, 19 Sep 2025 13:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=kGsGOlGV
 OojXDdph1nJk5GiqPu7d3wjciWIrM04nBVo=; b=d+6MaLLL2FnLiiUJ/11FSRZR
 UfgXFrwuukMZgTmaWQ+ElVmSeTPuzRDj7M1dHxE/7uxRgIYWqaXSzYje/DvYMbnE
 yPVQ2OlNpEYCoC6/Z1Z270lD0xQbLHtu3XZDZxQxqdJ+/972bw6mbbdkitzjsqcA
 8MrtvvgKruGyG8vKc5ekSb235k15ux0/Uzd+FLRWGMPZJO88yoZIxRTT9zpdx3bX
 DGBTFwLmc9qSf5+6brHcFTIkyMJ3DLpOVeq6ThEtR7amPmW6JzzPHzOw6iUcFMl4
 3K11wW/KR5eU3/DP4pYU3bw29ZUWk3WY4sPOX6XDCx37s37j2hiNfj26C8YdbA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kdpq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 13:58:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JBqv8B028831; Fri, 19 Sep 2025 13:58:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gjpw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 13:58:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JDwVLW025678;
 Fri, 19 Sep 2025 13:58:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2gjpvb-1; Fri, 19 Sep 2025 13:58:31 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] tests/qtest: optimize qtest_get_machines
Date: Fri, 19 Sep 2025 06:58:30 -0700
Message-Id: <1758290310-349623-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190130
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cd6188 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=7je7RYxUaSp8zG-zYl4A:9
X-Proofpoint-GUID: QQsjYtS29HKNIRHOhe-qlIk62AInWtR8
X-Proofpoint-ORIG-GUID: QQsjYtS29HKNIRHOhe-qlIk62AInWtR8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfXynmCPwyjHzea
 z0JnV/e5WK7cOKO1Bj0KrJrC+3k+6kySIquiPih466zrfrHOgDCh89EeBEqErlKkAqYz+lwqz2K
 oZN1blobtNPM+BXjsF3E9VK0TX+knelUwqzirbX6CwC1gIX/8+NP07kxew0Shk2WA5QVdGKsa5k
 pq0Sgk3+gC3niN5T6yYTdikNzyKnGJ5/Z0QADFQ9SOainUasDulaV1nnSlK6OjXGcPqoiewFsW4
 6xyWh0NiZFF1nK+Iu8QMVOCCAddWqdPVXjvbnQUZpjwX+eQpxu9MpkehaM6Na/Q2a/HMczIha2b
 sFjTauySXhoF+omXSosXJ9+/dnpxV7wuT35wVuMZIfsJSznseEhKMBpnJVotvbB915BvkVDODDW
 kM1KB9jk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

qtest_get_machines returns the machines supported by the QEMU binary
described by an environment variable and caches the result.  If the
next call to qtest_get_machines passes the same variable name, the cached
result is returned, but if the name changes, the caching is defeated.
To make caching more effective, remember the path of the QEMU binary
instead.  Different env vars, eg QTEST_QEMU_BINARY_SRC and
QTEST_QEMU_BINARY_DST, usually resolve to the same path.

Before the optimization, the test /x86_64/migration/precopy/unix/plain
exec's QEMU and calls query-machines 3 times.  After optimization, that
only happens once.  This does not significantly speed up the tests, but
it reduces QTEST_LOG output, and launches fewer QEMU instances, making
it easier to debug problems.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 94526b7..f3d4e08 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1630,7 +1630,8 @@ static void qtest_free_machine_list(struct MachInfo *machines)
 static struct MachInfo *qtest_get_machines(const char *var)
 {
     static struct MachInfo *machines;
-    static char *qemu_var;
+    static char *qemu_bin;
+    const char *new_qemu_bin;
     QDict *response, *minfo;
     QList *list;
     const QListEntry *p;
@@ -1639,9 +1640,10 @@ static struct MachInfo *qtest_get_machines(const char *var)
     QTestState *qts;
     int idx;
 
-    if (g_strcmp0(qemu_var, var)) {
-        g_free(qemu_var);
-        qemu_var = g_strdup(var);
+    new_qemu_bin = qtest_qemu_binary(var);
+    if (g_strcmp0(qemu_bin, new_qemu_bin)) {
+        g_free(qemu_bin);
+        qemu_bin = g_strdup(new_qemu_bin);
 
         /* new qemu, clear the cache */
         qtest_free_machine_list(machines);
@@ -1654,7 +1656,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_ext(qemu_var, "-machine none", NULL, true);
+    qts = qtest_init_ext(var, "-machine none", NULL, true);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
-- 
1.8.3.1


