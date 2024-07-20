Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532A8C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZD-0007MK-DW; Sat, 20 Jul 2024 15:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYt-0006pu-CI
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYk-0000pc-Se
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJAbUS021307;
 Sat, 20 Jul 2024 19:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=7tzmnxKwo2znaMzLs9b303Ot3KrE0JHiqIjx0pM+AQk=; b=
 ReYqZCap+RNHb9xFUGrG0UVQyVuwu7d2uV0XUDpgJ6vk2BSt/iEsKg7199C53pTH
 uF/lWvpYIUOKqrUhJ5+EAXviDcpBiPBcg9mXNHjDdarzVTEKq3YAjDbwITJk1Jcf
 IUMmKxL/qvYtofAUJ0hmarhZAHtKG33SezIoy1+7KthoFWmW/gBEG5SnbXnna5qW
 gSxburRD758PHOgXfZ4fC95OhgUiuXka7Vm5CoFMAVd0wlvTlq//VESt9GpUJdF2
 CaAoQPng+2NQePrurcOTzM9nO+itf9M7ANT631RM5EpB/Aoznwi4rMIdQqOdVTcK
 aRUS52idNMbKc4vPEd0Ajg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5gr055-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KIF8QN027510; Sat, 20 Jul 2024 19:15:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5puty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdf9028365;
 Sat, 20 Jul 2024 19:15:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-5; Sat, 20 Jul 2024 19:15:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 04/12] migration: cpr_find_fd_any
Date: Sat, 20 Jul 2024 12:15:29 -0700
Message-Id: <1721502937-87102-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: z0rzYnRqnXyymF91NvI1MsEyXCNYAXdG
X-Proofpoint-ORIG-GUID: z0rzYnRqnXyymF91NvI1MsEyXCNYAXdG
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

Add a function for finding a CPR fd by name, for any value of id, and
return the id.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  1 +
 migration/cpr.c         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index bfd9864..c9e6111 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -19,6 +19,7 @@ typedef int (*cpr_walk_fd_cb)(int fd);
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
+int cpr_find_fd_any(const char *name, int *id_p);
 int cpr_walk_fd(cpr_walk_fd_cb cb);
 void cpr_resave_fd(const char *name, int id, int fd);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index 853d3a1..096e8d8 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -109,6 +109,21 @@ int cpr_find_fd(const char *name, int id)
     return fd;
 }
 
+int cpr_find_fd_any(const char *name, int *id_p)
+{
+    CprFd *elem;
+
+    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+        if (!strcmp(elem->name, name)) {
+            trace_cpr_find_fd(name, elem->id, elem->fd);
+            *id_p = elem->id;
+            return elem->fd;
+        }
+    }
+    trace_cpr_find_fd(name, -1, -1);
+    return -1;
+}
+
 int cpr_walk_fd(cpr_walk_fd_cb cb)
 {
     CprFd *elem;
-- 
1.8.3.1


