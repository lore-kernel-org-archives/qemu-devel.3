Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4388CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbra-0000xO-Kc; Fri, 19 Sep 2025 10:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbrC-0000Yw-4o
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqz-0007TH-JG
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:00 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtmJ4023169;
 Fri, 19 Sep 2025 14:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=KVZKlScSL3fpepmijDdmzuigZVGCzb2oGsUwxVW66x0=; b=
 ZzX4FPYCgLjn0Ekjs+xp/JuEL5ZpQB//d/kTj8pf2d4Ot4DOgM0+twTFdkdo+2Fh
 LL/lFhaCmM/FqVJBWniT9kCPRJVVRyk8MsNVxJT2xpnLFsNCKQvqtNGn7z90ub9E
 cQDwr6csDM65aQZoOJ+zRGLYWGl2toz+D2LdEibpU14PhVaJQJ3bvDV7zvVBxfgC
 Lc/aUldOzwqgLzltnVdxzakacxka9dCK1+yTHt6duh74f6CgrXDESGQQcNp5ugy1
 mZMXByzWYuIgn6Ofqn1tBzw9w32EmnLGmNqL5H5RgiSFRRJFVnBHDQRebrcfcXZb
 JyFXPDZG3bW0Vb4z0O4afg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6np81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JD3Kc2035230; Fri, 19 Sep 2025 14:12:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu96c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXF003357;
 Fri, 19 Sep 2025 14:12:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-8; Fri, 19 Sep 2025 14:12:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 07/11] migration-test: shm path accessor
Date: Fri, 19 Sep 2025 07:12:29 -0700
Message-Id: <1758291153-349744-8-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cd64db b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=mXoANcZEXaB-ueEzDlQA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: b2W0aUOPtQGiKJ_vT_xq9BwQ8AW8wCC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwH3/KmeVEsDE
 vYBAyu4lz4jrdegu5V8xoXUEfG5u1bQ2iLoHcUjZYvrCAhIcewf52M4WrM4ESOSyUaRmkfddR4Y
 l/D84sh828+E6E0o39Zf27F2fBKxgr+Ih7/b5Run2VEFMNOusfqYPI811JC3Dw/PDAd0/k9n19K
 JS8IHOZwjj7TP5EOxSyq8mzmpoeNV3+LxFoF5+XPj9zyxOa+0XDbFkI3R6NcZucm6qi6JyoWaeg
 EMagS1bhokE3f76qVMXd86liyORUliMB/+8CfYm7i/GT+R7Na6BeO5exRZsxOF1IvDm2qjv2cZj
 2yuXyxd3aNNUDV4jxskiVUdgYjSgtZ2xBrP+DmQ38hHPtsqepiHnStU9AyE5Qu2Vp3H3OCN4DGT
 qWr4BoJwRpgekAtvt1iksBfSigmQ3Q==
X-Proofpoint-ORIG-GUID: b2W0aUOPtQGiKJ_vT_xq9BwQ8AW8wCC2
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

Define an accessor for the shm path.  It will be referenced from
multiple sites in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/framework.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9564293..9d04f36 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -255,6 +255,11 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
     return;
 }
 
+static char *test_shmem_path(void)
+{
+    return g_strdup_printf("/dev/shm/qemu-%d", getpid());
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -342,7 +347,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     }
 
     if (args->use_shmem) {
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
+        shmem_path = test_shmem_path();
         shmem_opts = g_strdup_printf(
             "-object memory-backend-file,id=mem0,size=%s"
             ",mem-path=%s,share=on -numa node,memdev=mem0",
-- 
1.8.3.1


