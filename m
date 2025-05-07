Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E56C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjne-0001vW-Al; Wed, 07 May 2025 14:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnW-0001s3-8u
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnT-0004q9-Ex
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ILxJ3020552;
 Wed, 7 May 2025 18:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vfcEeH9KjcjHYG0umNVUq6ajQHnTZXWzx9BSMYQP59o=; b=
 OX1YlgJeI+qSafMiBZxPCGWKAySau98bWTUNxbjzxu0xVx/9Mewx3x0vdKqb65cI
 lM+JHxP7b8I2PmtiPVx7dFb047RL/2hJ5ZONLQtfpgVWZNysibj8mOS6aZnbpHgy
 tLVFsipDIJN44qAjojVfemMwblQyHjoz72daqnHouSSrHzHO21s4nVCOMheGXwpN
 H3e9yTjIEDU95UMW9GyuRywHXHKZme2ojlolM2QGWzUnJHF5pOKhINXIygtqXOYa
 ph8IpHh62m+pIcmoh1RYms8+F2ZD3MkMXTrZZjF0n8yqke8kXxcp/QwJV/PVT3pQ
 0LgTfg6hah/zKTVBur/jTg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcqrg236-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547H2xdr036101; Wed, 7 May 2025 18:47:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhd83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3iv029452;
 Wed, 7 May 2025 18:47:06 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-2; Wed, 07 May 2025 18:47:05 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 1/7] vdpa: check for iova tree initialized at
 net_client_start
Date: Wed,  7 May 2025 14:46:41 -0400
Message-ID: <20250507184647.15580-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-GUID: MiZ6B7PfO4A3sIis3ERdHPYZDm1p6xL9
X-Authority-Analysis: v=2.4 cv=aJHwqa9m c=1 sm=1 tr=0 ts=681baaab cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=_qgkVcge0i2d_SHi9Q8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MiZ6B7PfO4A3sIis3ERdHPYZDm1p6xL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX2p7MD79IUygj
 NGRqgmmckgYi5iujPgTtfa96XE5f2+QwJOq3nFq2Jx96PnAyEutSY4BZSHz+PYkqnrohcKIR+Xw
 KGaKJoIf7vBMnEsNSJjaVFsM83wEtOJaL+4Fs3C0Itd0f5EZyv5QLAkSjCpovl5Qvpu47bX9iV9
 HNEwlPVK4b4zKBMZ9AHUInzMkE8CxGsEaNH6FQnHazwAWQqNF+BDYXmekYC9wqQTmZH0Hek3iVE
 IgnMmiZrrObmnKqWZe9rpfXMvdpEoglFHrCjggE8NLybDLuZYAldMYjPhw1BibQxR2TXckvJPE8
 TZ6PkTkwPmBaFN8nM93Oq8fFR/PcslxdTX3C74Mm9fYC0xy4VnxLLuHfBmAugEPja6twwjNbXQm
 OCX3u9+DikGHwsn1kQgKOBtk0e9Ww7xgITiS3TqJbVdAxmrDadZFqGpiqc1Lk9FTLNICnsJR
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


