Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18627CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvh-0000Tp-56; Mon, 22 Sep 2025 09:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvZ-0000QE-1H
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvS-0001u0-HU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:00 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NNsc024185;
 Mon, 22 Sep 2025 13:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=2bWnxhTfby+JfYwTzPOe6ikvJvlzOf50/3Bo9FgmuXY=; b=
 NQvdccYfVL5jq/ZkR111bxNufECVf3MD6fmxY0ZJjJZINL6TQ+4U6wgdykgk0Ujw
 BfB6xas9VM3rDb4Bsf2RMCvKIPDPFk7zzEyZu1eMi9JEAp5r3bjtz1o1wVM5Nlaf
 SF4sRzCc6EnasZOlC9sRILJrZmtkl4oE+KbE3CkPmFIgAYhVZTgI3gJxKfjYd/uc
 0EuZFJBL3ueLNNqNvKA6GKNO5c7c65mSfy4C52hFT+zfTyKl96bhJFnh0s+kfHZg
 izkdDg0VZUtpPkW29pgapZu1kMPa5RvZlBUcEg9jUNcXKe7Fzd2NUoP0OcWw7cFJ
 ZgYmeXRMfwvnSkv54mkoyw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdjg8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCGFgP034388; Mon, 22 Sep 2025 13:49:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhan8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWF004351;
 Mon, 22 Sep 2025 13:49:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-3; Mon, 22 Sep 2025 13:49:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 2/8] migration: add cpr_walk_fd
Date: Mon, 22 Sep 2025 06:49:39 -0700
Message-Id: <1758548985-354793-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Proofpoint-GUID: x1yL8aEv2pIU9zhWR_lXw7jXqChR34yy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX+XJwVbkWD8fk
 K0/tiBKNEXrF0IHc9mjVauGZsmaMwncb6yHjrdY2ZFmunZ6MAAGuuusKszS8L/YUmOhy4VxyxJ4
 54ZzG0CMMoGG6A0gD2zkZxrR/1YJnnZvIAeLL2l0KtPkrOxO2NuK/bbmJ0axMZm2KuDSmVk32PD
 YVkhdUVKTdJoW6BiipEWGUtINcFgfP1R/Xywk+x7MhiZM8t2JcU8+XTIzSfwVWm98yWvpV+fmSX
 hHWUbEmdjHJZERSEjOBG/j0Ip1jK4v5pIMETulBlaztfg6bQLJdgaoX6OX91ReKWEsRx/eGCDqg
 0ruxrdcu6cvIznPyBFusWsO6QZSfERfqy0yPs3qAirOX6COWhufSMhupHjoRDSm/P6qD991dgO7
 w78hPTfdtIEBUTMLEN9VgtNrvIT/1A==
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d153ff b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=XbKixnoXw7dXUEClIQQA:9
 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: x1yL8aEv2pIU9zhWR_lXw7jXqChR34yy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a helper to walk all CPR fd's and run a callback for each.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  3 +++
 migration/cpr.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3fc19a7..2b074d7 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -34,6 +34,9 @@ void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
                 Error **errp);
 
+typedef bool (*cpr_walk_fd_cb)(int fd);
+bool cpr_walk_fd(cpr_walk_fd_cb cb);
+
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0..d3e370e 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -121,6 +121,19 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
     return fd;
 }
 
+bool cpr_walk_fd(cpr_walk_fd_cb cb)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+        g_assert(elem->fd >= 0);
+        if (!cb(elem->fd)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 /*************************************************************************/
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
-- 
1.8.3.1


