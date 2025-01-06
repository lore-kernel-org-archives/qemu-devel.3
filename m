Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44130E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUpUE-0001Ov-95; Mon, 06 Jan 2025 10:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpUC-0001Nv-CP; Mon, 06 Jan 2025 10:57:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tUpUA-0000yh-Iq; Mon, 06 Jan 2025 10:57:48 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506Etp0I020441;
 Mon, 6 Jan 2025 15:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=5HT+phJyguizsiaNFE8sTlVSLQ37uzFOeEaUPb5dAso=; b=
 kooWO4nPYDexLQ3D0CmCtYJj2XDVQRLOr/TBAFA/3NEN9RLAbFiKMF8qhow0Ry4y
 4CCtTozO7kY+ldTjYuNDjH2SIuxlrCYzOcqGVA7XOHl82zvBCn+tpNpXYuGV0Nqi
 U7a0ZsOIEQeityGgZ73exARAgH2yr9Tjb/Gzw+h0TmAP5b7E7FOWE1phu+z69Eoz
 TVHVpsl6x26CDcE3Q5/5bY1Pmp40U4ohDL1OrnY38iu3cKyjDU5S5uAmThQR1+iV
 SDC/657cDuN3u/tTDFXrCsui8OsXKmDipy/vmlsA9r/WKAL5xsvrJqn0UNBqLnSN
 TGQJtJcV4Wf3ZKIpLz28Ow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk033fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 15:57:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 506E7T9Y026551; Mon, 6 Jan 2025 15:57:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue7nw3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2025 15:57:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 506FvegF016161;
 Mon, 6 Jan 2025 15:57:42 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-185-77.vpn.oracle.com
 [10.65.185.77])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xue7nw2a-2; Mon, 06 Jan 2025 15:57:42 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, leiyang@redhat.com,
 anisinha@redhat.com
Subject: [PATCH v3 1/2] net: parameterize the removing client from nc list
Date: Mon,  6 Jan 2025 10:57:34 -0500
Message-ID: <20250106155737.976977-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250106155737.976977-1-jonah.palmer@oracle.com>
References: <20250106155737.976977-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060140
X-Proofpoint-ORIG-GUID: on-PBDRQVR8gIWmmuXT8oKK7oTSvfiOg
X-Proofpoint-GUID: on-PBDRQVR8gIWmmuXT8oKK7oTSvfiOg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

This change is used in later commits so we can avoid the removal of the
netclient if it is delayed.

No functional change intended.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/net.c b/net/net.c
index c1bb19a523..07d760569b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -381,9 +381,12 @@ NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
     return ncs->peer;
 }
 
-static void qemu_cleanup_net_client(NetClientState *nc)
+static void qemu_cleanup_net_client(NetClientState *nc,
+                                    bool remove_from_net_clients)
 {
-    QTAILQ_REMOVE(&net_clients, nc, next);
+    if (remove_from_net_clients) {
+        QTAILQ_REMOVE(&net_clients, nc, next);
+    }
 
     if (nc->info->cleanup) {
         nc->info->cleanup(nc);
@@ -442,14 +445,14 @@ void qemu_del_net_client(NetClientState *nc)
         }
 
         for (i = 0; i < queues; i++) {
-            qemu_cleanup_net_client(ncs[i]);
+            qemu_cleanup_net_client(ncs[i], true);
         }
 
         return;
     }
 
     for (i = 0; i < queues; i++) {
-        qemu_cleanup_net_client(ncs[i]);
+        qemu_cleanup_net_client(ncs[i], true);
         qemu_free_net_client(ncs[i]);
     }
 }
@@ -474,7 +477,7 @@ void qemu_del_nic(NICState *nic)
     for (i = queues - 1; i >= 0; i--) {
         NetClientState *nc = qemu_get_subqueue(nic, i);
 
-        qemu_cleanup_net_client(nc);
+        qemu_cleanup_net_client(nc, true);
         qemu_free_net_client(nc);
     }
 
-- 
2.43.5


