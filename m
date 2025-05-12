Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5503C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9W-0003ze-0G; Mon, 12 May 2025 11:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9O-0003kz-IF
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9I-0006e5-EE
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9ha3027386;
 Mon, 12 May 2025 15:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=uaqq+7gquEayfn/0kgwiKUiJvGbTTqrhmM7dvHphsoo=; b=
 p6VIHB21i63F07H3sCV27uH5+F4VxwbCIk66lZuS415ks2KfTFEL8+ch8oLl2/H2
 +/LvJHuau3JvRgrW0vPMSvBo7cB1sT0MXUewyYXfIByNHB3TQqd8s/1gh5FyJeQX
 YzM+FKpoRFDxa4UIH4zeDDIIOTjQlReoxaXQLff6jl1sX894oEpFp8ESt9808Ktm
 vqHTl0Q4rSm0R7FAxylaU7q0/ZT6OaAdiQ2iWugS/2/K/DigNerF5IEbefHh0RDo
 Kn034AzBQnfsFQWQ2wj9RLJWakGJ3jI+sbFUKXm5Zj1/ivAbi47yii+OAZwJ0waB
 oDMIoXyVCn61Yf8FAORhSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1662uqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEDx3f002961; Mon, 12 May 2025 15:32:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3664h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4g030605;
 Mon, 12 May 2025 15:32:56 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-3; Mon, 12 May 2025 15:32:56 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 02/42] migration: cpr helpers
Date: Mon, 12 May 2025 08:32:13 -0700
Message-Id: <1747063973-124548-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX988d13ArWjlS
 VQ2bcnodOXmcI0IJT0nM01fQzCUDCdsCr4eGPDI+Og4UZUJbmuxF7GVn0H7wG5D9IcMKXUw3q48
 ew2s58SnaVUgC5x7LyFsRmMc4LssyAlt6r342f0yUPS8P6nCJ6qDIzYcEeUHzwhvMe+tIOZOvdn
 OkRIHrLZEc2M5Ncc84ZeHBh4vi+lV17rHyndGrnzY5HIKDCZCRqJ5Vq+r/LWS+tpVWfkdqYm2//
 lU5qbEGyBf2m/ErREb7MPgVz4J1+2wQTXe7QEIIUaA4BioNv69iiPDsCi+dkFpF8ewU+Msa20GD
 STVg/Yek/VuXs5O+hcD5EjL5HDZbUix5x2SUQRGnx10rzKbkiS88sQ9zNyOO4EDU428wEKKtWqs
 9WQJ1kKVPCKwJYdtX9VgIWjghX7cilvNidsWQr/ImVpiLUjqfNFBxy+swaTXwN/Gwn2saSx/
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682214a9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=VUDR8QsyEHr-E37xdxEA:9
X-Proofpoint-ORIG-GUID: 5zW7dh72xGwCfrBwjz63PHZhzi65_6FA
X-Proofpoint-GUID: 5zW7dh72xGwCfrBwjz63PHZhzi65_6FA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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

Add the cpr_needed_for_reuse and cpr_open_fd, for use when adding cpr
support for vfio and iommufd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  4 ++++
 migration/cpr.c         | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 7561fc7..fc6aa33 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -18,6 +18,8 @@
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
+int cpr_open_fd(const char *path, int flags, const char *name, int id,
+                bool *reused, Error **errp);
 
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
@@ -28,6 +30,8 @@ int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
+bool cpr_needed_for_reuse(void *opaque);
+
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index 42c4656..0b01e25 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -95,6 +95,24 @@ int cpr_find_fd(const char *name, int id)
     trace_cpr_find_fd(name, id, fd);
     return fd;
 }
+
+int cpr_open_fd(const char *path, int flags, const char *name, int id,
+                bool *reused, Error **errp)
+{
+    int fd = cpr_find_fd(name, id);
+
+    if (reused) {
+        *reused = (fd >= 0);
+    }
+    if (fd < 0) {
+        fd = qemu_open(path, flags, errp);
+        if (fd >= 0) {
+            cpr_save_fd(name, id, fd);
+        }
+    }
+    return fd;
+}
+
 /*************************************************************************/
 #define CPR_STATE "CprState"
 
@@ -228,3 +246,9 @@ void cpr_state_close(void)
         cpr_state_file = NULL;
     }
 }
+
+bool cpr_needed_for_reuse(void *opaque)
+{
+    MigMode mode = migrate_mode();
+    return mode == MIG_MODE_CPR_TRANSFER;
+}
-- 
1.8.3.1


