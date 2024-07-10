Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026CEC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWrO-00010F-P5; Wed, 10 Jul 2024 08:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sRWrM-0000yA-Jn; Wed, 10 Jul 2024 08:55:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sRWrK-0005fP-I5; Wed, 10 Jul 2024 08:55:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fSmd011998;
 Wed, 10 Jul 2024 12:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=qf40bDhxPFhRDg9ThubZxQI5wRwaPxg4h+qOsZKv6uc=; b=
 lOeqR5l3/c5WurKT3tisflcJ8DBh+zC29O7RuMJuEfHHQVPhZLDBT7MZCNk5CaGY
 9VjG/Ue4ZOAQzysuYbbTJ9kmihpFKuc5Am6S5MbHBDNEdvarw+OVxZ6cJ949HTpY
 KGAs/jI8dCwywYL4gwE7EeY6nEpg9Z9NkutCwb6Zd3ayzxkfbUjQsdaYKgCM40vR
 eajIi4hMRwBUsMo3DDyCgHG/D6JWN8a6o4WSfIisB7gd35ZOK+d/nIOxIB/uPDgh
 wpz0fX4Y2dtPAOJMip7pxX70QbVkOQomWzff+lej2r4ref6ZkvBJR/fGOXs6T827
 VT6wJrqJiJvLjlPqtva3HQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcf5k8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 12:55:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46ABbjXq007488; Wed, 10 Jul 2024 12:55:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu4r0fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 12:55:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ACtQtS015847;
 Wed, 10 Jul 2024 12:55:27 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-182-124.vpn.oracle.com
 [10.65.182.124])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu4r0e4-2; Wed, 10 Jul 2024 12:55:27 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 eperezma@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v4 1/6] virtio: Add bool to VirtQueueElement
Date: Wed, 10 Jul 2024 08:55:14 -0400
Message-ID: <20240710125522.4168043-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240710125522.4168043-1-jonah.palmer@oracle.com>
References: <20240710125522.4168043-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_08,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100089
X-Proofpoint-ORIG-GUID: xraxNThPA4OGfJLhYzUPhxSCx4o6tehO
X-Proofpoint-GUID: xraxNThPA4OGfJLhYzUPhxSCx4o6tehO
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

Add the boolean 'in_order_filled' member to the VirtQueueElement structure.
The use of this boolean will signify whether the element has been processed
and is ready to be flushed (so long as the element is in-order). This
boolean is used to support the VIRTIO_F_IN_ORDER feature.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 include/hw/virtio/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7512afbc84..fdc827f82e 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -69,6 +69,8 @@ typedef struct VirtQueueElement
     unsigned int ndescs;
     unsigned int out_num;
     unsigned int in_num;
+    /* Element has been processed (VIRTIO_F_IN_ORDER) */
+    bool in_order_filled;
     hwaddr *in_addr;
     hwaddr *out_addr;
     struct iovec *in_sg;
-- 
2.43.5


