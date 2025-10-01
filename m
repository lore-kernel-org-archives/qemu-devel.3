Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1475CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrQ-0005Px-2K; Wed, 01 Oct 2025 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrM-0005OH-Lo
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqq-0006Rm-QH
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:15 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMw4q005657;
 Wed, 1 Oct 2025 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=GV3WlZSJwtRU9DtbTfoO/oCckcBk8wvwO/ObdQuG/oY=; b=
 Nyw+TZYxfRw7ZotmGu+VErX9JzFBWen75R+hNhh+IsRtWSZxb9z+Yijc4m90Gpvm
 8iPTUE3Gwc6VrEiMIEc9x/RndxtNN7O8Vx130kdEUxLi733+wGuzJ5NfVFjuNek5
 8341ygzmTbQnDd8S3FKRBkAuqVQD0nBL5M/ua0kq/wZXexrzXKUBf68eLfvOwtne
 lSoDIbyyO06+2ZQniRgZEP+01LJ4nKmjVSqatGq771B1Ciiu6hVFSHhE+eeCoyox
 p/DSDqoPrSl1qMo07wrGbw58Nxph6NenPBjt++CPPFxYLsIhGc3/A0zBMZ+muflV
 uSqwqg3oBe5iq/oBTGsxXw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq1pqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EmWse023147; Wed, 1 Oct 2025 15:34:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCr4014790;
 Wed, 1 Oct 2025 15:34:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-14; Wed, 01 Oct 2025 15:34:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 13/19] tests/qtest: qtest_init_after_exec
Date: Wed,  1 Oct 2025 08:34:05 -0700
Message-Id: <1759332851-370353-14-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfXzYiGq/ma3xKt
 7g+YU9O95B67QLnTPf3AWci0T+SIzITewzA66CQpe2rnXtQ+8TelhHnre5Br9mUF4pMiA6odGW6
 FUfWWiFq+pUzu14V0QN3+4jU2ycAH+pK9/OaoPOhXxMZbJ90w6Cti98uqpn+lIeIrOPqHjfggxS
 QC0N9VrQsiWnLumhqfj7X2HPH/tkivaYu0wyAE4digVCtfl3UF40ZAoQEqbv0hDJnXe288qT6vy
 0UrjavyVUJkqs9F7UcnYUMnHw1XYLc3mkMOBBfeKLersGYNnf/bLg6+uo69eLeL8HiN4MJUM0pn
 kwbI3Khq+wg6TREasjSFgTGOb+8ddOygBV6KxwIrXuIt77XcrFmXXVPb68ECAqIF5+4x7q+CDOZ
 VlUK/91A7eDM+vfB1hqfRSoC8QqZwg==
X-Proofpoint-ORIG-GUID: sA4npsf16qf5iOKZiCipCbyd-VsO-qhr
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68dd49ff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=Df2fqW_L1vg5yVQ28mgA:9
X-Proofpoint-GUID: sA4npsf16qf5iOKZiCipCbyd-VsO-qhr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Define a function to create a QTestState object representing the state
of QEMU after old QEMU exec's new QEMU.  This is needed for testing
the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.h |  8 ++++++++
 tests/qtest/libqtest.c | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 7f8dd0a..9c118c8 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -57,6 +57,14 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 const char *qtest_qemu_binary(const char *var);
 
 /**
+ * qtest_init_after_exec:
+ * @qts: the previous QEMU state
+ *
+ * Return a test state representing new QEMU after @qts exec's it.
+ */
+QTestState *qtest_init_after_exec(QTestState *qts);
+
+/**
  * qtest_qemu_args:
  * @extra_args: Other arguments to pass to QEMU.
  *
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 644c634..ea39c22 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -615,6 +615,25 @@ QTestState *qtest_init_ext(const char *var, const char *extra_args,
     return s;
 }
 
+static QTestState *qtest_attach_qemu(const char *qemu_bin,
+                                     const char *extra_args,
+                                     void *opaque)
+{
+    int pid = *(int *)opaque;
+    return qtest_create_test_state(pid);
+}
+
+QTestState *qtest_init_after_exec(QTestState *qts)
+{
+    void *opaque = (void *)&qts->qemu_pid;
+    QTestState *s;
+
+    s = qtest_init_internal(NULL, NULL, true, qtest_attach_qemu, opaque);
+    qts->qemu_pid = -1;
+    qtest_qmp_handshake(s, NULL);
+    return s;
+}
+
 QTestState *qtest_init(const char *extra_args)
 {
     return qtest_init_ext(NULL, extra_args, NULL, true);
-- 
1.8.3.1


