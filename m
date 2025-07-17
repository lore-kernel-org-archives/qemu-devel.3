Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9588FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVSz-00079Q-LP; Thu, 17 Jul 2025 16:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW7-0008Vv-Tc
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW4-00008x-1d
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0hHE010736;
 Thu, 17 Jul 2025 18:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=lTkdRg+GBBI4tZWpYzx20rweRuoFZnawHnP0zLPVa+0=; b=
 jVQSOGR8wJAcIJkWePQcepeVapnskWx5GlE22efSOhQcOYQA1dDPI2pUdCsdv0gx
 460BGpw5RA9ki65NHhQtmna9DPwqO+12x32j9th2A/KyUMxJQSjyy555eR1VVKxm
 +YxBmKp1xve4EwGS9QPlVEoQbJx8/xm2sp4160tQXilYiSIUOpJVKGax3owA2g5S
 wZUFWZH0nWJfWHcRjqLKKcleLDRym2jcxPyda3pSu7brkmi14kgizeuXazEsZ1bO
 yrsqZX1B+y0s/KKJ7hsVMZ9Sk5ki6OcJUENWtBrWocanZyVD4L/mS2eFYvyw+RFs
 Ua2rIu/qqXwR+c1HHU+3XQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfcad3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHgYw7024121; Thu, 17 Jul 2025 18:39:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2tas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoir007425;
 Thu, 17 Jul 2025 18:39:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-6; Thu, 17 Jul 2025 18:39:31 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 5/8] Revert "vhost-backend: remove
 vhost_kernel_reset_device()"
Date: Thu, 17 Jul 2025 11:39:25 -0700
Message-Id: <1752777568-236368-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Q22_tzSNJwxA8catDn0cpZMNphkkRCSV
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68794365 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=hnmyno6qhCV68aGjqbUA:9
X-Proofpoint-ORIG-GUID: Q22_tzSNJwxA8catDn0cpZMNphkkRCSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX2qKT8oxIkUht
 oSRtLMAs3TzwmoXw3zk7+FgVY2Kx/88MVIT520uZZNDXLEGyY67JnLTqmHxLCSGh4in2747rk1c
 1KyUw98wnfhO6ts5tWJAgTYVj8SojX/EuObtdM8k7HOx1GKS7BEHimCKRduCA7juvCyTaI5z/Kc
 ursdrW8s/yPDQBXs05R0zCgAprxh2nBty8prtyCEZ24bECmMPHBSclxzo6QifceqTmFxAFMTr0s
 xflKLJB0PI+kuHqBanb7diYx4j2V8d6TZhwlQ0uvnfwma9bAVxjlv9SLk8bQeW2v3iw8gYxFG6e
 hmL+OATbpKXhyAx7Acz7LAt5LSOOV4EDywLeSwcXenkpLSAADAJLkVlK6K1ymWR+g5hu7kfePfS
 erquqOPHqtcjGuhRPNooxuyPAOjNKae+Su4QcyRsQqk2oXhCeQcMmJ+0udendtDsFmwrnUHH
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

This reverts commit e6383293eb01928692047e617665a742cca87e23.
The reset function is needed for CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/virtio/vhost-backend.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 833804d..9b75141 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -221,6 +221,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_device(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -345,6 +350,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_device = vhost_kernel_reset_device,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
-- 
1.8.3.1


