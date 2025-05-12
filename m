Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C66EC3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9c-0004Oa-QB; Mon, 12 May 2025 11:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9a-0004Ha-K3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9Y-0006fO-MX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9jNb003954;
 Mon, 12 May 2025 15:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=VsOIPiEryaqcqeJEJCnlnULMC3Fth56QSg7Ts+PxjV8=; b=
 CAHf4w14fBnb52o1vCT8juScX2EPYw0iiIA5TS7inqXzdj+j60Id8LNXgtzd3ACT
 kj5Y3pD1XaXTCliVE0SupJadVdg3dcKT5F+HX/wV0VF4yBAytcruju7ajKnhy29U
 wv2av3dDf9ZFpG8h5SL2Sq3e/PYg6ytqOIF3rAI8qRepa0j68IXSwBMjSXEs/N4M
 KN+4OCocnLNatPEI9ajWnD7rr8UvKWNDFQrVCHFRtzFUNK0z5o7l8mhpN9vuM8vi
 YJsyK0Nb3zU+TMStQ1HoDojuLrZwBVDssCcYFLwVJpPEOBhDbDbMXJ2D3J+HWU0d
 0idN1hl5UsOsLkXKTEDxTg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epjsbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEDx3i002961; Mon, 12 May 2025 15:33:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3669j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:03 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk50030605;
 Mon, 12 May 2025 15:33:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-12; Mon, 12 May 2025 15:33:02 +0000
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
Subject: [PATCH V3 11/42] vfio/container: mdev cpr blocker
Date: Mon, 12 May 2025 08:32:22 -0700
Message-Id: <1747063973-124548-12-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX8Zz083p9IL7F
 FtF63ATi0PqCbiTnLJrjRLpbAvpQX8MgoJUA0AkmkLrJO5Di/ND8c4/3n8UKBMKOxVNT/kZUl1D
 9z0iC3grjvHPMHGukc2gFFXSXLqA/aVoQJaX/m9maHcQNABb5luD9SMzHidr2t7Bn4t+rvj9aho
 WpvpBPfhtczcT1+45vj2NBNGWFgB5L/F5HyBpbidTFGyT8ntVHIsDPY+gWmHLqZM73vVWr6DoW4
 IfX74RjOvL7wXVj8Nv9lGXQWvRjhkk1XxvUAyyUZADuyX/8ofZoz1wV+vkxVxANMYCdWBCQ8kqP
 xTAvdVrtofIIHYW/ZvlgRK3Rzr+dVDsnv9zaMb6Pqe4N2kEdT6Ag/R/7D5Do2ZFXoGs0iGyBvt0
 +gqv1m8QBuY8bKhaHei+QqLuZJ2JloWNBfWj1G1c2XqJGX3E3e3Wi041vS7NFsvdXr/NiloU
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682214af b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=PnZKiW0O5CgTkK3-2owA:9
X-Proofpoint-ORIG-GUID: ARsNCu524YoMPujAG-m5YT084x-1i3t_
X-Proofpoint-GUID: ARsNCu524YoMPujAG-m5YT084x-1i3t_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During CPR, after VFIO_DMA_UNMAP_FLAG_VADDR, the vaddr is temporarily
invalid, so mediated devices cannot be supported.  Add a blocker for them.
This restriction will not apply to iommufd containers when CPR is added
for them in a future patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c        | 8 ++++++++
 include/hw/vfio/vfio-cpr.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0e02726..562e3bd 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -995,6 +995,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto device_put_exit;
     }
 
+    if (vbasedev->mdev) {
+        error_setg(&vbasedev->cpr.mdev_blocker,
+                   "CPR does not support vfio mdev %s", vbasedev->name);
+        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
+                                  MIG_MODE_CPR_TRANSFER, -1);
+    }
+
     return true;
 
 device_put_exit:
@@ -1012,6 +1019,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 
     vfio_device_unprepare(vbasedev);
 
+    migrate_del_blocker(&vbasedev->cpr.mdev_blocker);
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 1c4f070..0fc7ab2 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -18,6 +18,7 @@ typedef struct VFIOContainerCPR {
 
 typedef struct VFIODeviceCPR {
     bool reused;
+    Error *mdev_blocker;
 } VFIODeviceCPR;
 
 struct VFIOContainer;
-- 
1.8.3.1


