Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7A7C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7Ny-0003aU-3t; Thu, 22 May 2025 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nq-0003Y0-Lf
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nn-0004gU-Oo
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:58:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEuAwX021564;
 Thu, 22 May 2025 14:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=I4qcJTTuaF4HU3WUWEyU1Yq6POF7mMupkp07YNW15AQ=; b=
 OvoKNSb6eBsIuLHEBGAD8u3sqoMXXybS02RVjoh0FA9h96mY2MDlhl2ynP6m1cJq
 kK+pwPUg+lTxYYFpw6vmY8rSY+obVhySpRmyQYEFyd0y0vYHK/d6ONpg1H648Y6W
 aNJ8hSiqCaZmFqwdlPSYAGrRJufPHSXWPExDUkqhiXme7snMCpQpVv+6VoVmZuMX
 W2s4A5elh7n6NU89jHKX0L1O1RWJQjrrnxkXop0yYP4CmM311dVRO33HDLxZkPJb
 tfl4SHmjF/RwuExwj/vJ3I1iyGSflPqj98DlVvr3POCpHIUyYNX+4jicjce6eRFG
 +XFFnsIOsuwBGlActVBsbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5b407da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MDkZjl034582; Thu, 22 May 2025 14:58:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwer990d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54MEwiTv010227;
 Thu, 22 May 2025 14:58:45 GMT
Received: from dhcp-10-43-71-124.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-124.usdhcp.oraclecorp.com [10.43.71.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46rwer98yj-2; Thu, 22 May 2025 14:58:45 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
Subject: [PATCH v5 1/7] vdpa: check for iova tree initialized at
 net_client_start
Date: Thu, 22 May 2025 10:58:33 -0400
Message-ID: <20250522145839.59974-2-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: sgaBq3yV8uZD7Q1-VZ2Zcm1PRNNfJUL4
X-Authority-Analysis: v=2.4 cv=AdaxH2XG c=1 sm=1 tr=0 ts=682f3ba7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=GYyZ9lEBoHdOIgxxpYoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: sgaBq3yV8uZD7Q1-VZ2Zcm1PRNNfJUL4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MiBTYWx0ZWRfX68E4AoxOcz9H
 eHCSfuTQkaea/YcaaZTPhNrb/CWJibUE/tUYuaaWgCu9nm06J5BDZPglNxA52rZuKTG9G1w0M4c
 23n0H87EhI2LsYvjFwk+0B4eF5CtS278Gt5JE3cxF6O8t521lENprQSNynAoUZixJGtHZQbCdrj
 b01NuxSFrnXUBtdZvB0pd5EI2Dw68yZ9NhGXtjRQLDlzJ74OMUm1+2zBPnXHMcyyzqSwYgjY3sI
 4mna/xqVUutnkrAhjJtklSCaLgVxsUETHCv6dczXMx52/9Gu6/hUyIdzl3mBBW0yQ5rFoSLNT7U
 aUskdkqexhlfnAuu4wIKIeOYz7avy4c38Iyz8w4oGBY/Lh4M7+tA2zLWx/JBWWDne2sUvrRaLdr
 tbVVRy36xN5aJWSO6nf+CS9Qj+OBvlaETYDQKzMOqxMogOkM1+PJz8HuNnoc7nc5uSEeLyZU
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

To map the guest memory while it is migrating we need to create the
iova_tree, as long as the destination uses x-svq=on. Checking to not
override it.

The function vhost_vdpa_net_client_stop clear it if the device is
stopped. If the guest starts the device again, the iova tree is
recreated by vhost_vdpa_net_data_start_first or vhost_vdpa_net_cvq_start
if needed, so old behavior is kept.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 net/vhost-vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7ca8b46eee..decb826868 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -366,7 +366,9 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
-    if (v->shadow_vqs_enabled) {
+
+    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
+    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
         v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
                                                    v->shared->iova_range.last);
     }
-- 
2.43.5


