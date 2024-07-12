Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBB6C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGrA-0001mJ-BA; Fri, 12 Jul 2024 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGr2-0001NU-Oe
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGr1-0005vQ-5V
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIMrN023701;
 Fri, 12 Jul 2024 14:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=S9Iux9B0t0Qwr10Zwlv9f/aWAepqp3WhMb9It8eH5qo=; b=
 atijf7pARGfwIVEaO8ZsSHzNWTf4maTJx2XWw/SFMHJGESsgFyL6Z/jG2Ebihtpg
 bAGOO0jkiD35Vfi86fgI+DBENt7MfnBC09XIhFUdjljojcNMN7R81QIaUYgpGpu+
 0Ty5M/1yAYyP6xekUW6pDWcpCfWQVQ1yPEHBRy/c4BFaNKtDlMRHeWZ/X8SgClW3
 qprUKWKxlOGhhetDqGbEJ4HFQaJuvPoP+baY2JHQgyoAmhh/QJlQZdLR6666sB/X
 lNokS91rJMr2ZGZ7+Dh0wBWluSrDXo0XUksni+SG9Ulke/2Aq/kXnax+eucRstfO
 KCoagVLjeS/pQ61hlAJFzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt37uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CCwLpM010887; Fri, 12 Jul 2024 14:02:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DPu020438;
 Fri, 12 Jul 2024 14:02:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-5; Fri, 12 Jul 2024 14:02:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 4/7] vdpa/cpr: kernel interfaces
Date: Fri, 12 Jul 2024 07:02:08 -0700
Message-Id: <1720792931-456433-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-GUID: a0OpHpbWmSD__iZJ8Vqiereq-MCnGA6Z
X-Proofpoint-ORIG-GUID: a0OpHpbWmSD__iZJ8Vqiereq-MCnGA6Z
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

Add the proposed vdpa kernel interfaces for CPR:
  VHOST_NEW_OWNER: new ioctl
  VHOST_BACKEND_F_NEW_OWNER: new capability
  VHOST_IOTLB_REMAP: new iotlb message
  VHOST_BACKEND_F_IOTLB_REMAP: new capability

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/standard-headers/linux/vhost_types.h | 7 +++++++
 linux-headers/linux/vhost.h                  | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
index fd54044936..fa605ee1da 100644
--- a/include/standard-headers/linux/vhost_types.h
+++ b/include/standard-headers/linux/vhost_types.h
@@ -87,6 +87,7 @@ struct vhost_iotlb_msg {
  */
 #define VHOST_IOTLB_BATCH_BEGIN    5
 #define VHOST_IOTLB_BATCH_END      6
+#define VHOST_IOTLB_REMAP          7
 	uint8_t type;
 };
 
@@ -193,4 +194,10 @@ struct vhost_vdpa_iova_range {
 /* IOTLB don't flush memory mapping across device reset */
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
 
+/* Supports VHOST_NEW_OWNER */
+#define VHOST_BACKEND_F_NEW_OWNER  0x9
+
+/* Supports VHOST_IOTLB_REMAP */
+#define VHOST_BACKEND_F_IOTLB_REMAP  0xa
+
 #endif
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index b95dd84eef..6c008c956a 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -123,6 +123,15 @@
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
+/* Set current process as the new owner of this file descriptor.  The fd must
+ * already be owned, via a prior call to VHOST_SET_OWNER.  The pinned memory
+ * count is transferred from the previous to the new owner.
+ * Errors:
+ *   EINVAL: not owned
+ *   EBUSY:  caller is already the owner
+ *   ENOMEM: RLIMIT_MEMLOCK exceeded
+ */
+#define VHOST_NEW_OWNER                _IO(VHOST_VIRTIO, 0x27)
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
-- 
2.39.3


