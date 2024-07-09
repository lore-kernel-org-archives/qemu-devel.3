Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADF1C3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 20:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRHvg-0005hK-MA; Tue, 09 Jul 2024 16:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHva-0005EV-DV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvV-0005WA-Oi
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KtoE2002323;
 Tue, 9 Jul 2024 20:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=MFYDPnMFgJiIFcgTnvD059sZcMMPfhkRR0EJOPChVSc=; b=
 odHdLMpt+dtCY6onxHfFYGZ93m9ykPaV8YfRc98C0icCdapmovPR+q0zpGgb9Hub
 Kupczo2kOUxATy82th0r9PNKsaLxeVdNebOCuyq2pPQi1iOjhw55uItc0bBmWFaj
 zQ8aCAJoMdDNcYcneknLu7rPgwa6X+y7QlfUK6EzeyO+0kgwzISTHALxFhbcj+gH
 lEMJuA9AU5fcFiK1/+3sJO1NbwPyT4H+ifxdnLLujD3ajHRCsb2c4UR5bgf4d+CQ
 ZfLnNqgLAp4QRq3b47rMYV2HVLDbM9qeD/JdbpNej+7D4hjKzF9M3mGRt3L5Rvpr
 6kcnrRnEBITl2cvRPQVIJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emswam2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469Jx0rk005008; Tue, 9 Jul 2024 20:58:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tve98ra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:58:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 469KwwCr012128;
 Tue, 9 Jul 2024 20:58:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 407tve98qa-2; Tue, 09 Jul 2024 20:58:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/8] migration: cpr_needed_for_reuse
Date: Tue,  9 Jul 2024 13:58:50 -0700
Message-Id: <1720558737-451106-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090143
X-Proofpoint-GUID: OG8-mx-dd99xvDVb9KwJJ-VIij0t00eK
X-Proofpoint-ORIG-GUID: OG8-mx-dd99xvDVb9KwJJ-VIij0t00eK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define a vmstate "needed" helper.  This will be moved to the preceding patch
series "Live update: cpr-exec" because it is needed by multiple devices.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h | 1 +
 migration/cpr.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index c6c60f8..8d20d3e 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -24,6 +24,7 @@ void cpr_resave_fd(const char *name, int id, int fd);
 
 int cpr_state_save(Error **errp);
 int cpr_state_load(Error **errp);
+bool cpr_needed_for_reuse(void *opaque);
 
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index f756c15..843241c 100644
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
1.8.3.1


