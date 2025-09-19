Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78524CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrN-0000bq-0p; Fri, 19 Sep 2025 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbr2-0000Ta-K3
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqt-0007Qa-UH
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:51 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtw6l017757;
 Fri, 19 Sep 2025 14:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=FK4BXkRVbSn2QYxeqnwzP2tz/KaIxCTbszEjhBZbEs8=; b=
 A4/cMQFF6TWHVE/D7NP3lvTZd9hn1przoBz//ZadEJrr0204PNgZNCvdpyeQiDkb
 zcKh4wOvvs5ilwn50pAuGY7hzQF568vRzTwLfyCUTOZi52tX5giTso/EWIeBe6S5
 D5tfA4XvLPXrUA7JXdQSkSEIg7Aa3bDCedcIfE2ZRhtZaxAcvh05Re6MvW2Fo6ak
 MY2mv28rW0S+08uOIFvcYynvxqc0nA95X7u0T20S1E3TTfdunReE4RLeMlDJ9C5L
 g5zoCimmw5U+UesJEUmw+/lfhhiZlkVzO9NF20uUd9br5DpV3aqZqJactNCuKIOZ
 RDwFzoUgez193y2PbmZomQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9wpqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JD6QkP035161; Fri, 19 Sep 2025 14:12:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu93k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYX3003357;
 Fri, 19 Sep 2025 14:12:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-2; Fri, 19 Sep 2025 14:12:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 01/11] tests/qtest: export qtest_qemu_binary
Date: Fri, 19 Sep 2025 07:12:23 -0700
Message-Id: <1758291153-349744-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: vqXtNoQL_6QTfCbjgDk8QCAvC9A7n55Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwyo4oxIKTXuz
 BFnQNhGjjuTzrHUfiCrQGsSKNo4Tu+oNlig0rNieLpYmFDuDR86WSXv2Trr5u+dAwHwRT/XX8/F
 8nNbXK27jrPQNZhnEUTX7wOhy7jDg4IFxwApJHPVFDL4xDtxtmY+ssgucKY9HasZfkzRT/x+Y9o
 xDbq/JZ5/Z1qoMlFeK23R4r2MsNkEmQXxTgE0wWBOgbX0xtjmsj+akfvw9681/Hr5O4MxuMbk76
 w1nlfceTJLnPXAq3dxRT5LG55pgiK4eKxHnnwHqpMht3d0HvcoPhvfMveSPOzuiK34qByyAuVbv
 QBmfFLKiM92YSl+A8Ho8EmXlRgFO/RwJk2HqKij6x989kO0jqKkmsVzh//9StCXvlqKEwPpbS2x
 1rPnq5O6OsyDULi4hhSkNNkNGetbiw==
X-Proofpoint-GUID: vqXtNoQL_6QTfCbjgDk8QCAvC9A7n55Z
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd64d5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=8YXl1s7RIgG2VgC1okUA:9 cc=ntf
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.h | 9 +++++++++
 tests/qtest/libqtest.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index b3f2e7f..6d3199f 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -48,6 +48,15 @@ QTestState *qtest_initf(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 
 /**
+ * qtest_qemu_binary:
+ * @var: environment variable name
+ *
+ * Look up @var and return its value as the qemu binary path.
+ * If @var is NULL, look up  the default var name.
+ */
+const char *qtest_qemu_binary(const char *var);
+
+/**
  * qtest_init:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f3d4e08..6f76be1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -357,7 +357,7 @@ void qtest_remove_abrt_handler(void *data)
     }
 }
 
-static const char *qtest_qemu_binary(const char *var)
+const char *qtest_qemu_binary(const char *var)
 {
     const char *qemu_bin;
 
-- 
1.8.3.1


