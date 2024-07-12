Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B234DC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGqy-00011F-Dt; Fri, 12 Jul 2024 10:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqu-0000qP-5Z
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqs-0005v8-BE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:23 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIhH0028172;
 Fri, 12 Jul 2024 14:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=7LVpahXMk4/9lxYHPPx8Bi3WW1Xzr0usvH6SGIEWUdg=; b=
 QugoPQa4DibkyUQNIX8rMK5Bnj0cWXk/cH19FyzovW9P3kBPle1wOlWj+UTm0NYA
 uNJg5Yy78vVVEFLMPJMuHBDKmNMuSLmSU9HY6edrBfadup7J7Erv+n0pnoS2wjXV
 sf2KNQCKvySetkHIo5uETx27RrVVpZKXKzx+O99Chiej9ADuHTsUfPmBviZQkVLY
 sV4CTjIYlPvM2mW5XydRHwDaXRQ8jaNyc1y+yywT2sJPo73U7kbypB1ZEdssujKd
 sgTK8J7FNOPQ055GB60lTVr52rtts8n5raXsWLWCOMLO0ZA3233oja1a1UZ1KIF2
 34YpyjaO3OSKHo3mRPr20Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkyc4f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CC5fAD010941; Fri, 12 Jul 2024 14:02:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DPo020438;
 Fri, 12 Jul 2024 14:02:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-2; Fri, 12 Jul 2024 14:02:14 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 1/7] migration: cpr_needed_for_reuse
Date: Fri, 12 Jul 2024 07:02:05 -0700
Message-Id: <1720792931-456433-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-ORIG-GUID: K_EZ-MEHU4kdPD1xI367mEADj5pGTSec
X-Proofpoint-GUID: K_EZ-MEHU4kdPD1xI367mEADj5pGTSec
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Define a vmstate "needed" helper.  This will be moved to the preceding patch
series "Live update: cpr-exec" because it is needed by multiple devices.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h | 1 +
 migration/cpr.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index c6c60f87bc..8d20d3ec49 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -24,6 +24,7 @@ void cpr_resave_fd(const char *name, int id, int fd);
 
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
+bool cpr_needed_for_reuse(void *opaque);
 
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index f756c1552d..843241c073 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -236,3 +236,8 @@ int cpr_state_load(Error **errp)
     return ret;
 }
 
+bool cpr_needed_for_reuse(void *opaque)
+{
+    MigMode mode = migrate_mode();
+    return mode == MIG_MODE_CPR_EXEC;
+}
-- 
2.39.3


