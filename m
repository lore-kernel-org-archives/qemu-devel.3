Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B8EC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqek2-0000CB-UI; Fri, 07 Mar 2025 15:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejj-0008Ou-HO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejh-0003Yx-2R
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:02 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527JthGE011174;
 Fri, 7 Mar 2025 20:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=0XK4edV2KXkj8pAHOtSX3fgeaum7BSpCDSnbKsvqK70=; b=
 fTRAmi8LyOGc4xHYvZxKcmF1lrqlKj0bkCvzTYjNo/EbksQweBwwS4DGtY1El3Zy
 ZkI2pmzD9KJ+PGMh+Znm/p5+BgY1TFQpLGk6XCmkGpGaYt6oZjk5wN2iZbRlT5Yt
 OdvVPdSkL+zw6yIOfpPSA7/+ON3H89DUqyWBZTZEn8UNwrJ0BD9QCedntgRK2Ptx
 yTo3nah1+Pf5EPnHs8Br5v9+JcnpkTiyzEQxaSEGkE50GB9kQhddqevpzoHfuEHs
 IJQQQp/f5pFQnafdnx3yXmPHbrQps4ddrODkFjB/kWD7SXP3VwBb6gW0udYvmoom
 nPkObtYQAYXvlFmZfixhzA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r4cwpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:55:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 527KOI3L010894; Fri, 7 Mar 2025 20:55:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpfmv37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:55:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 527KtuLr016275;
 Fri, 7 Mar 2025 20:55:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rpfmv2c-2; Fri, 07 Mar 2025 20:55:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/4] migration: cpr_is_incoming
Date: Fri,  7 Mar 2025 12:55:51 -0800
Message-Id: <1741380954-341079-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
References: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070158
X-Proofpoint-ORIG-GUID: jC9aC-_mz5zegdrcVrJ-LdNYnFaTOMiK
X-Proofpoint-GUID: jC9aC-_mz5zegdrcVrJ-LdNYnFaTOMiK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define the cpr_is_incoming helper, to be used in several cpr fix patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h | 1 +
 migration/cpr.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3a6deb7..7561fc7 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -21,6 +21,7 @@ int cpr_find_fd(const char *name, int id);
 
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
+bool cpr_is_incoming(void);
 
 int cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
diff --git a/migration/cpr.c b/migration/cpr.c
index 584b0b9..0e935ab 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -128,6 +128,11 @@ void cpr_set_incoming_mode(MigMode mode)
     incoming_mode = mode;
 }
 
+bool cpr_is_incoming(void)
+{
+    return incoming_mode != MIG_MODE_NONE;
+}
+
 int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
-- 
1.8.3.1


