Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE139CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrR-0005QA-9J; Wed, 01 Oct 2025 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrK-0005NN-Tf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqs-0006TC-07
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMj8v022673;
 Wed, 1 Oct 2025 15:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2K41iqP8nj4Yhtp06VCmOCrfsPnqOQZISPBShx7G3ww=; b=
 AasmaInm/lc5BgIcGCLk2trVQhpljQOsjiW/A/lZvTwGy9koCQBRVPfN6AV1qEB1
 auEoVki84n78rj9xXq47XsVkq/Llh4YKCTf1ahciZ/XXhybEGurFhyF2Aq5WHwOe
 btJZPvBEMWUwfEuv5pLvky0RslLjng6itC9V8/RERKMPVS5l5U1C6hy87mk9sBHu
 yiG87XRuQlrAG1RnXZspnfvO2nzeYJNy8KpCG3rFGIQ/8ln0H6XZg9837pNjlRzp
 MEDSFcf+ssa8xUgSe+5oX1ys01LUQ8gLbt3YOBisUYsaAUyLu/zonO99ghM/GM+f
 4wuK+ZlkGqmxbDeqrUJYSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bhqw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EkqMe023130; Wed, 1 Oct 2025 15:34:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caawaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCrE014790;
 Wed, 1 Oct 2025 15:34:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-19; Wed, 01 Oct 2025 15:34:25 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 18/19] migration-test: strv parameter
Date: Wed,  1 Oct 2025 08:34:10 -0700
Message-Id: <1759332851-370353-19-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-GUID: vQZc-oqFWUGFOmVG8j9ppHgZ04Fwt5b_
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dd4a03 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=2nCFX4KoIgSfmLCypf8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX8qbS1YRl8xHt
 2p+eL5xP1e3wspRlSNY1C4NwMg+7lVNBJfhwdnDIgSsK3qPyRDmLpE6wBt2KYYrZky9q2iqHkNw
 vQhZBN/w60UQeXC6wQroD6bt7Kt7BC2H/btEZmAEzGAkyf6nyEhEmDnhBlWkTPwmJ4psjsMBEQE
 n78RncHoQLLPgLRZQRJuHRorjEfwfG+utkboGcaX1bVNnc11RnzPA1D5XPEJJrdNPNMo7AsDE8o
 wEKS7bUTeBegSUCiYsS9/gYzwitCgXBqVxD0cPIC7I88iZZrqbBjxIsBaKdiCRtXeOEu783UNFT
 Zp69ZUfAikkBJQTqkieAR8IFiHqdry+5BA65AO75wMxDM2COLEMNoxurluK7HlyFCrqG1rnT7tr
 tlp65qFcYRk8RImXTBD2RyhJbITJnQ==
X-Proofpoint-ORIG-GUID: vQZc-oqFWUGFOmVG8j9ppHgZ04Fwt5b_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


