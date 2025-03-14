Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BCBC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4gC-0005eS-Ja; Fri, 14 Mar 2025 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g7-0005cJ-Du
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tt4g4-0005vK-GZ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:02:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBlrrn017187;
 Fri, 14 Mar 2025 13:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Xqwrvn874bLh+h7YBTKEQquGJPTFQMZ3gI8uye2oSX0=; b=
 DtrLu2gmVwtwsjskSjxtI/Y2sd4aT3LHOb5vg2kribi72cCvLG+yoSenFn9NM14o
 LhGUO/NsVV3ewUEnVQiLmHit8ATBnxy9of/BBiTW63mMdodrF7MrD51vczChPCvK
 xzSaiC4lBUrfXYJaLHj0J+J/vc1dUsnxPYnSiW2BO8MDzV1vE0kAdzDUGIOoozwD
 uQp9UNoFZRR7ldGHc+kGd8rmdWtIA1abQGAVdWghwoKjTt2ps5s/I3/o7sEj1FSy
 BAr5UrW2+7IqeMuYRABHiV7rLGqutCUJLDdQa/30A810xTOuPY3UZmc1fQXhweuh
 2M+m3wXZ0Q4q7Y6ZF5T73g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dpesp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52ECkbXF012195; Fri, 14 Mar 2025 13:02:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn41d1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 13:02:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52ED27R9015104;
 Fri, 14 Mar 2025 13:02:08 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-73-135.usdhcp.oraclecorp.com [10.43.73.135])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45atn41d05-2; Fri, 14 Mar 2025 13:02:08 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowant@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyan@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v3 1/7] vdpa: check for iova tree initialized at
 net_client_start
Date: Fri, 14 Mar 2025 09:01:48 -0400
Message-ID: <20250314130204.11380-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250314130204.11380-1-jonah.palmer@oracle.com>
References: <20250314130204.11380-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140103
X-Proofpoint-GUID: FVTMP2LkkldG_GsRtDIYA6-V0SEijSr6
X-Proofpoint-ORIG-GUID: FVTMP2LkkldG_GsRtDIYA6-V0SEijSr6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 net/vhost-vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f7a54f46aa..5bc945d3e0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -354,7 +354,9 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 
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


