Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428D2CA9EDC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPuG-0005lZ-AD; Mon, 12 Oct 2026 19:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPuE-0005kx-76
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPuC-0006HT-KT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMiI5m2859234; Mon, 12 Oct 2026 23:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=P+D3H
 ARnzG2Mn3lr4TOHFwK41OWaCqzIbnPjwoNvv3k=; b=p3jTVCjbwyNQxHn4bDJuY
 AFiTWF/jO4YFvycMO0TjnYQyWMhv2TADBZGwJNefn0cclVC7sQ0r3Sg1knEreLnF
 Au1AqdPHgXi3/R2mXUdUy/z61E5XUJunHIaKFAU0grEWW8lrQQ5W/TxiCv19AY8E
 O72/ihOHCXj4EsueV4YAOZOKzdWZcd2gHxuZrRIYIlGwdY5tTbUZuulnGf1klbfp
 ZMpixeB3ZyxJqm3F/AVLXPB7Rds35t9wJOG5PytIRPRlvf2eMbDUNU+L9gDfDeRu
 WSW72BT+WQg2hl5OXTOIxdLMycRMV4VD6efWhR8D7qHaWn/1czzysKHdq7bP/7ey
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demk5va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpfeH015139; Mon, 12 Oct 2026 23:57:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHf025328;
 Mon, 12 Oct 2026 23:57:52 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-18; Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 17/21] migration/cpr-luo: abort session when migration fails
Date: Mon, 12 Oct 2026 23:56:13 +0000
Message-ID: <20261012235727.398133-18-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6acd7401 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=mQQDvgQqBV_NPTwpIXgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: nuPnndyeCr-uoaJQq8NAR5Oip3Ch0cZg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX4VH+7alNYOsN
 rfoTwcImP+p1IFQqS/w+LO9NK8zntaxAcH8vkp5sQmnKb2xtFuaCVAyej6EHwsqok+mu5R1wyW3
 T3aZTdo2yKciuaPAKxZFJVyaxzlfaAN5tkKsTvXrhehiAYnA2KKj
X-Proofpoint-ORIG-GUID: nuPnndyeCr-uoaJQq8NAR5Oip3Ch0cZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX58FG9tHYgwlG
 fATJALN7TJ54JldW7LlBjHqWfg04KNi6ZTCzRHaXYrm0sldDGEkJJarPC7QNyCQJsfuHPGE5BZ9
 3eznBmmV0kstlgTQVeTkRIgB2SiKcPitPDxd4JJFoicMy+eXWhLApfeHtKOuH7UuV42B1MDZ0tX
 VraKeUaV6qewE4q27nWwPdfiRRlMg9ke8HmFkvzFmnP3zd1s6VJMBfy1BJhlQLVtqRHdAaCzOtQ
 KD19vcq2RJH/+pI4RvrASFm0CmgTnQp2QUexxu9N8/q/TpgCjuvCz4yBXv/xSShlUxQpGFdXez0
 /jw29YdsI2SGyVYpcRV0L2ztTFvjoy+5eoVBTd5ve6TEmbm9U2t4xnIF8Q3bxWhnQ9bhB6LjtdR
 vtQvIzkEM77N2pmXRrnS17zruskosieZP1HgbxG3sOfsWV1v6r2hcywo+GRche5oQAURR2N+RHa
 c24Ylgqze485Za1gAfBlo98cA9VnFvzqFlGoLtO8=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Register a cpr-luo migration notifier that closes an active source LUO
session after migration failure.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h  |  1 +
 migration/cpr-luo-stub.c |  4 ++++
 migration/cpr-luo.c      | 20 ++++++++++++++++++++
 migration/migration.c    |  1 +
 4 files changed, 26 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 96529ab3a1..239cddf352 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -97,5 +97,6 @@ bool cpr_luo_retrieve_fds(Error **errp);
 bool cpr_luo_save(QEMUFile *f, Error **errp);
 QEMUFile *cpr_luo_load(Error **errp);
 void cpr_luo_incoming_finish(void);
+void cpr_luo_init(void);
 void cpr_luo_abort(void);
 #endif
diff --git a/migration/cpr-luo-stub.c b/migration/cpr-luo-stub.c
index 22a7037c20..4eb14ccbbc 100644
--- a/migration/cpr-luo-stub.c
+++ b/migration/cpr-luo-stub.c
@@ -69,6 +69,10 @@ void cpr_luo_incoming_finish(void)
 {
 }
 
+void cpr_luo_init(void)
+{
+}
+
 void cpr_luo_abort(void)
 {
 }
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
index d9aba3bfc5..02ca947507 100644
--- a/migration/cpr-luo.c
+++ b/migration/cpr-luo.c
@@ -11,6 +11,7 @@
 #include "io/channel-file.h"
 #include "linux-headers/linux/liveupdate.h"
 #include "migration/cpr.h"
+#include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -296,6 +297,25 @@ void cpr_luo_incoming_finish(void)
     cpr_state.luo_session_fd = -1;
 }
 
+static int cpr_luo_notifier(NotifierWithReturn *notifier,
+                            MigrationEvent *e, Error **errp)
+{
+
+    if (e->type == MIG_EVENT_FAILED && cpr_state.luo_session_fd >= 0) {
+        cpr_luo_abort();
+    }
+
+    return 0;
+}
+
+void cpr_luo_init(void)
+{
+    static NotifierWithReturn luo_notifier;
+
+    migration_add_notifier_mode(&luo_notifier, cpr_luo_notifier,
+                                MIG_MODE_CPR_LUO);
+}
+
 void cpr_luo_abort(void)
 {
     int session_fd = cpr_state.luo_session_fd;
diff --git a/migration/migration.c b/migration/migration.c
index 7c2bb982a5..a9503607d5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -340,6 +340,7 @@ void migration_object_init(void)
     ram_mig_init();
     dirty_bitmap_mig_init();
     cpr_exec_init();
+    cpr_luo_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
-- 
2.43.5


