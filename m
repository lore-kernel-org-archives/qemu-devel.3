Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD0BCD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtr19-0008DZ-Lo; Mon, 08 Apr 2024 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rtr0x-000896-6G; Mon, 08 Apr 2024 11:34:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rtr0v-0006rO-Ep; Mon, 08 Apr 2024 11:34:30 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 438ENpoX028680; Mon, 8 Apr 2024 15:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=fxTG5H+k9GuEV1QiH20UEngvezOU2CY6pKWF9qduMa8=;
 b=YpIdkTDg30RKAtWQmF6/TyC52wPJGVkbgBJ/GvteDF7dGmKcY881GwJjhhLLal9TYzYa
 yGGyjsMMi19N+9LuJOiI84R506C0jv8Sx/I7bjWhzqmOtYj17Kjuya8f1NrVB+dl9o3/
 FBeuILL035v5sCqH5+VDOw+cTLGSjd+DGCbjh1QvT+KR0Ahg1b8K2VFzss1OuabD6I6G
 a50foKxJCQHFp5RI/00WSaE9uF/9FXxD/tQGNX2VzQgsm3Bmpy/YZtxR3euqnNdojKPO
 cxi04045MfKbbx4sTbKJtB2vX3H0Vjkf0KLiUO5wjypQ0BDIPyOyehy2XT7thq9FNKAD EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedk1rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Apr 2024 15:34:15 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 438ESwuF032371; Mon, 8 Apr 2024 15:34:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xavu60dau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Apr 2024 15:34:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 438FUlUu008521;
 Mon, 8 Apr 2024 15:34:13 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-195-157.vpn.oracle.com
 [10.39.195.157])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3xavu60d7m-2; Mon, 08 Apr 2024 15:34:13 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v3 1/6] virtio: Add bool to VirtQueueElement
Date: Mon,  8 Apr 2024 11:34:03 -0400
Message-Id: <20240408153408.3527586-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240408153408.3527586-1-jonah.palmer@oracle.com>
References: <20240408153408.3527586-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_13,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080120
X-Proofpoint-GUID: k8vp9plj5_NjByBtSI8kFoZ1z8-8OjcA
X-Proofpoint-ORIG-GUID: k8vp9plj5_NjByBtSI8kFoZ1z8-8OjcA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Add the boolean 'filled' member to the VirtQueueElement structure. The
use of this boolean will signify if the element has been written to the
used / descriptor ring or not. This boolean is used to support the
VIRTIO_F_IN_ORDER feature.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 include/hw/virtio/virtio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b3c74a1bca..9034719f1d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -71,6 +71,7 @@ typedef struct VirtQueueElement
     unsigned int ndescs;
     unsigned int out_num;
     unsigned int in_num;
+    bool filled;
     hwaddr *in_addr;
     hwaddr *out_addr;
     struct iovec *in_sg;
-- 
2.39.3


