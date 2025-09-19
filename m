Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129ADCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrc-00012W-8s; Fri, 19 Sep 2025 10:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbrF-0000ah-7U
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqz-0007T7-AP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDunD7010150;
 Fri, 19 Sep 2025 14:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=MbX+XABKhHuOtwP1+0G2UmM7gcUxrOsq74D1aZH620A=; b=
 o9mEOsTm8jaNapiLc8UQqSVz+LGLBGV6h0O8ZdG+0n40jCFrAEs1bmCUE1QjKWjM
 ijZcxVhqjhXXtj2tLFxotKCZMI4IRZBamBKHYWTwTS5Kopg6eN2F2NFvInNqlI5p
 41F03FuuoAfAkARvFu5eoryJide4ttjo3BqSJXk2NSf9qL97lG7vEDXrpleYOapI
 qC/DWF0IVoycSLFgk+dwFYJ3QCY8gPFmdtJ/DpMJeAJwtFX6djoRvXS+MVsa8SlD
 tYNhHfxdhC8MTjnvIPlHf0hb6yNNi92Fog0k8SD7iI+cfc38vHBfbQR4k6nW38vl
 7mF9BRVNVCI4s1FUPce4UA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb5mm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JD4V6O035195; Fri, 19 Sep 2025 14:12:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu95c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXB003357;
 Fri, 19 Sep 2025 14:12:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-6; Fri, 19 Sep 2025 14:12:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 05/11] tests/qtest: qtest_init_after_exec
Date: Fri, 19 Sep 2025 07:12:27 -0700
Message-Id: <1758291153-349744-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5xZJZbBmKYfs
 q6JWrIbZgDNSAFVaY+VjbWAya0jqOcPYbg1kq3trpvRNUyiGO0xwPMWF3m8T5iEDjRcAAbbKeht
 tFJRGAo3BGc45pgGJ2ea02uIv6QtZ5mKfR2OqJ/KKzpe+4QoLJLHcGPdm6u3DMpGFtLVuRpKk2i
 l8jGi7Ha9ad6tuwaqYm8OU1LKmPcVWLcovJtTeL1BsOY9L06mIV1PjGVB59gxllde2pjm82Ofze
 G4e0If28YrWR9PKQFARlZzGcas+ZYPpTCI6iNv2qU3j5jpha+2D3QEXHJfWhwPg8bA1/4tS7r/7
 M6XCvR2vFAd3cx/uzJS6lLmyFndVWQkbSW9nqpA3pvEHLwGx2treprR5WBb4ZFNzUIojNASlLTT
 08RRT/ZydmCPObS5Kzk2Cp1tfUBDfQ==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd64d9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=-mka8b2Hcs0XyqHMhc8A:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: LK_SXmfGJyldr3NlA_Y1jA69ZOKdi3V8
X-Proofpoint-ORIG-GUID: LK_SXmfGJyldr3NlA_Y1jA69ZOKdi3V8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Define a function to create a QTestState object representing the state
of QEMU after old QEMU exec's new QEMU.  This is needed for testing
the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.h |  8 ++++++++
 tests/qtest/libqtest.c | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index a164f58..ce6b9b0 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -57,6 +57,14 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 const char *qtest_qemu_binary(const char *var);
 
 /**
+ * qtest_init_after_exec:
+ * @from: the previous QEMU state
+ *
+ * Return a test state representing new QEMU after @from exec's it.
+ */
+QTestState *qtest_init_after_exec(QTestState *from);
+
+/**
  * qtest_qemu_args:
  * @extra_args: Other arguments to pass to QEMU.
  *
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index d97144e..3522d75 100644
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
+QTestState *qtest_init_after_exec(QTestState *from)
+{
+    void *opaque = (void *)&from->qemu_pid;
+    QTestState *s;
+
+    s = qtest_init_internal(NULL, NULL, true, qtest_attach_qemu, opaque);
+    from->qemu_pid = -1;
+    qtest_qmp_handshake(s, NULL);
+    return s;
+}
+
 QTestState *qtest_init(const char *extra_args)
 {
     return qtest_init_ext(NULL, extra_args, NULL, true);
-- 
1.8.3.1


