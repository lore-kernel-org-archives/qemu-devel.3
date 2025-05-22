Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76881C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7O6-0003cZ-LV; Thu, 22 May 2025 10:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Ns-0003Z7-2m
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:59:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nq-0004hk-21
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEuCLj008288;
 Thu, 22 May 2025 14:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=PUaqSMqmDXQRr0YFHa7Uv411pXGB/vmn0fExGkb8muI=; b=
 hcJ+obgZsSEfPt5CUqmx5BGslRK6fblLWoF2ibuct/eg0E0DRBHhFuHD2t1Kljrf
 ioxAJJw5goVi9nEXnZdO4LnuOdUcuAjZ99ba898gQ8NMGaU8EK93qqIOebCcYq5I
 o6lHkQ1G4xCHln7w9Pvd6+iZkao053GT8l91gVB4rii7YeExBkgKnEYjimliHUJg
 Kt4s4rc/nhR4C5aILrdSmAwSUJGJgt58O/JKZj32SwMlzY2wxAxRACvfXG9mrtOZ
 VWCGW2YcTZNIG65mjZytABw5PqFdabpqusUhj71ifPn+45fe8X9Yjlcs+qGsgQCo
 Sm1rhty1pMsa+84//8C5Xg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5fug5hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54ME0B5B034612; Thu, 22 May 2025 14:58:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwer992t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54MEwiU5010227;
 Thu, 22 May 2025 14:58:50 GMT
Received: from dhcp-10-43-71-124.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-124.usdhcp.oraclecorp.com [10.43.71.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46rwer98yj-6; Thu, 22 May 2025 14:58:49 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
Subject: [PATCH v5 5/7] vdpa: reorder listener assignment
Date: Thu, 22 May 2025 10:58:37 -0400
Message-ID: <20250522145839.59974-6-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522145839.59974-1-jonah.palmer@oracle.com>
References: <20250522145839.59974-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505220152
X-Proofpoint-GUID: VOMAsPDgfaCNF0gzh7p9omadKR91EP4_
X-Proofpoint-ORIG-GUID: VOMAsPDgfaCNF0gzh7p9omadKR91EP4_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MiBTYWx0ZWRfXwXcHS680nsVY
 ucomb0E4aYOGj0xrLOwD+IZIRpsORdkmTF/dWvnJyZZFK/LBJ4d0VOsoD2ooj0I30Jc5RdCBKq4
 X2psdv64dvouWjvK+fRrLuRKtmRQLiIid2GlOrQN7Xfrs1jOYKHHXKHQmhO1uTB4fCcimusJ4Ne
 2So4datnidNX6iETLmgHm5XsXzeNkGVEkGJhFSliysZX9SnHYX7RZ5EwIT5MzhBe7BZNrkEUxKn
 q5s08vytb6ILknPJ45NW0x3hNRQTeRBD/nclAOgwxjYAcRUys9s+Ux9ERtjFK3uFNkmYtjNGwY9
 ykn0w5JNfdoEsfeT334Ub5QA2GWebQuEAqPlfRYTC3k2WTJmkzcV17gmoJUlbfaiLso0ssVxm+h
 eMmJNIRRFZKLhJOxJ9USgefmhrbq1zgDuS1/C7b62iia6f76ZU4A9/4ODRUP4PmsFldzYMUj
X-Authority-Analysis: v=2.4 cv=CMQqXQrD c=1 sm=1 tr=0 ts=682f3bac b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=GYyZ9lEBoHdOIgxxpYoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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

From: Eugenio Pérez <eperezma@redhat.com>

Since commit f6fe3e333f ("vdpa: move memory listener to
vhost_vdpa_shared") this piece of code repeatedly assign
shared->listener members.  This was not a problem as it was not used
until device start.

However next patches move the listener registration to this
vhost_vdpa_init function.  When the listener is registered it is added
to an embedded linked list, so setting its members again will cause
memory corruption to the linked list node.

Do the right thing and only set it in the first vdpa device.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 450f68f117..de834f2ebd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -633,7 +633,6 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 
     v->dev = dev;
     dev->opaque =  opaque ;
-    v->shared->listener = vhost_vdpa_memory_listener;
 
     ret = vhost_vdpa_set_backend_cap(dev);
     if (unlikely(ret != 0)) {
@@ -675,6 +674,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
 
+    v->shared->listener = vhost_vdpa_memory_listener;
     return 0;
 }
 
-- 
2.43.5


