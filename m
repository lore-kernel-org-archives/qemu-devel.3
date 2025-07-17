Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74E8C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVSv-00073I-Nd; Thu, 17 Jul 2025 16:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW6-0008Uy-Nz
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW3-00008R-UN
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:37 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0j66010805;
 Thu, 17 Jul 2025 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=CPjLh5gQBfnwSKznR9Oac4ZSf2Y+9lmNJZ/lIKEoDXA=; b=
 PIZcTRxOg8HYBVMUJzHJ9Vp+BXQHn8wmG0R/bE2EsrY7BRoYN3g+3c9qVoVp1goX
 5pNZub8iKl3bk9IEHskEYpmSlt1M0753nGUPnInlQOwEiTmT+1YDMy5+tnMs2PRq
 wZpV7jpkxJvDXmSgi0DApC/0j1QjfWkIV3QAjYCPCoS4/YXxjeSBns/FlkFRHInR
 NQC1WCxbUGOWQxh2rNU+rec6JEnlS/D4jZF1qYZ14hoygcx0BJOnpJB5C9vqh8Dx
 Olof6D/p/K9h1eLGEgMWY8jC6NtrQVUDDf6p0if801lBNOY9Ut4Ys1S87qud+zHY
 ONzWzIVkRwQukXkmNzs+Qw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfcad1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HGsXuY023941; Thu, 17 Jul 2025 18:39:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2t9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoil007425;
 Thu, 17 Jul 2025 18:39:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-3; Thu, 17 Jul 2025 18:39:30 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 2/8] migration: cpr setup notifier
Date: Thu, 17 Jul 2025 11:39:22 -0700
Message-Id: <1752777568-236368-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170165
X-Proofpoint-GUID: P4GrYe6bmPEe7RQpPF5amFGTalN4MHsm
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68794363 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=8YgkOPFe86U-wwtjNboA:9
X-Proofpoint-ORIG-GUID: P4GrYe6bmPEe7RQpPF5amFGTalN4MHsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX+x/0f5gL7ahI
 HJW8UV3LmZS7qWB9DltXIoN4ZJDqgQiItt/zzKYqKNIhvuX4z7b/pntbGuFfA5+y+yCduiQ0ATo
 /SbaAWUNEJVj0FFPddThU3p0hw0zLeFJXKqxOhIPBZAXpN+bq0NMcILUcj2tSfc2uq8DD4twHQ4
 NLu4Xz7E2QW4U2FBFkd61UV1xbs4maAwn8/O7yVXvTHsmOm7ggAIQy56cDjb/zy1t9RB+lzsocB
 kcwoSsg9bgz3CAquf+vNIO9kEgY9wMvBfUNzDFHZW3ZRaqBIS8N8zrVz0k36cyVQTTVvVR1HeNs
 oDZ4Dc6F+vGGelMas2wcoXpBHFDAo6y1XcLKs7wwDhuOXMSDBcJegwdQzNKG6xWdbm5+tRCmA3B
 0V7fp1wkOV0KU08+rE68+THtqpsr7HzVqh5sCmvdX/qKBIbEf7izpr+09Mg9Hw9Ey1YwBTyG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Call MIG_EVENT_PRECOPY_SETUP earlier, before CPR starts.  An early notifier
is needed for resetting vhost devices, as explained in the next patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2efe60a..49d1e7d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2259,7 +2259,14 @@ void qmp_migrate(const char *uri, bool has_channels,
         stopped = true;
     }
 
+    /* Notify before starting migration thread, and before starting cpr */
+    if (!resume_requested &&
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+        goto out;
+    }
+
     if (cpr_state_save(cpr_channel, &local_err)) {
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
         goto out;
     }
 
@@ -4010,11 +4017,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     } else {
         /* This is a fresh new migration */
         rate_limit = migrate_max_bandwidth();
-
-        /* Notify before starting migration thread */
-        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
-            goto fail;
-        }
     }
 
     migration_rate_set(rate_limit);
-- 
1.8.3.1


