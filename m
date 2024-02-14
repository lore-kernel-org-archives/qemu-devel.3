Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5B2C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXw-0003RY-1O; Wed, 14 Feb 2024 07:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXo-0003ME-Eg
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXm-0002Zq-PE
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:20 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41E8iJjQ005670; Wed, 14 Feb 2024 12:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=2adgzyL/ZKsQMs8r1z/tF72kUJSLbwoHGCLGlTudDRg=;
 b=Txc0aioTg5Blv/wXUZecfHi1R2twu8/+w4EoVlUQtHHMiYoAJ2JYyUmYoHkzJYe5+hGJ
 GCQGf0eznvd3hrmeI1QnF+RzhfZeY6C+ZEY2ixf0RA0MmkNPH+xiMTbj1wfVoJEAh+8w
 0qxI+ChpeqiIdcKutMi/wy8Cgk4a4sPMuV7doKKJeCwQWSK8kV13/zGGQ+pvc3k/bD7l
 lKBMCJPrhXWMc1pR5nNcqeI+82/5THd4endVx2dpDYJG0DV0ymaWZHOnemLHttum+pdK
 xZkmVPE3TrhvRcnqdGNLQ+9MLvDzBRYp5zeS7fAtYAnklp9p3ipM54JwPtupHqTWV77f 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8rtcgqq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:16 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpw013766; Wed, 14 Feb 2024 12:39:16 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-12; Wed, 14 Feb 2024 12:39:15 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 11/12] vdpa: indicate transitional state for SVQ switching
Date: Wed, 14 Feb 2024 03:28:01 -0800
Message-Id: <1707910082-10243-12-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140098
X-Proofpoint-ORIG-GUID: _mZnw-PCz9yxBI3y1JVJnwX2pg5kGXjU
X-Proofpoint-GUID: _mZnw-PCz9yxBI3y1JVJnwX2pg5kGXjU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

svq_switching indicates the transitional state whether
or not SVQ mode switching is in progress, and towards
which direction. Add the neccessary state around where
the switching would take place.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9f25221..96d95b9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -317,6 +317,8 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     data_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
     cvq = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
                                   n->max_ncs - n->max_queue_pairs : 0;
+    v->shared->svq_switching = enable ?
+        SVQ_TSTATE_ENABLING : SVQ_TSTATE_DISABLING;
     /*
      * TODO: vhost_net_stop does suspend, get_base and reset. We can be smarter
      * in the future and resume the device if read-only operations between
@@ -329,6 +331,7 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
     if (unlikely(r < 0)) {
         error_report("unable to start vhost net: %s(%d)", g_strerror(-r), -r);
     }
+    v->shared->svq_switching = SVQ_TSTATE_DONE;
 }
 
 static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
-- 
1.8.3.1


