Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A0BC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXm-0003LF-SQ; Wed, 14 Feb 2024 07:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXh-0003Hi-H3
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXe-0002XL-QO
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:13 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41ECKJdC015116; Wed, 14 Feb 2024 12:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=fNUPkUaoC1M3EfiBrG5gFlCzG2ZQFXeSo/ZczHr6Nm0=;
 b=cJMpCElG8nXcg4hEwNK4Rf/pCDJNBGMOGoMlO9ba/P/nTaB+yqzUHh1M1o/aTjTnSPWj
 B1x/z2hMrIZMwWA+wGZjz4J+A3uBuM0jBrfaQcwb6+RtVHA1cd9DHpN/PyrdwqCT2Ukc
 PkfKy3YpDYNKVty/nVrwgEqj6+b/SeO64Pjtp3wQ8S2UAGl383jniOdq1OxCcS4BU2Kh
 QQM3mfuQJ23uHM/qJlFNqUHfjM6c6xeh1Ywv3IZO80gK+POtr4EAfIVLrOQigS7iw1Ff
 G5T0gP3inI5cNirvPEcqfVO2p08Hc96+QT6QFuc/Y+o6OzQplEQFzPPWouL8L93U7i2n 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8wdy8102-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:05 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpi013766; Wed, 14 Feb 2024 12:39:05 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-5; Wed, 14 Feb 2024 12:39:05 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 04/12] vdpa: factor out vhost_vdpa_net_get_nc_vdpa
Date: Wed, 14 Feb 2024 03:27:54 -0800
Message-Id: <1707910082-10243-5-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: VXwd48IZ86EEQA0rBxKiFlyuampihN2A
X-Proofpoint-GUID: VXwd48IZ86EEQA0rBxKiFlyuampihN2A
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

Introduce new API. No functional change on existing API.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/vhost-vdpa.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 06c83b4..4168cad 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -281,13 +281,18 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
 }
 
 
-/** From any vdpa net client, get the netclient of the first queue pair */
-static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
+/** From any vdpa net client, get the netclient of the i-th queue pair */
+static VhostVDPAState *vhost_vdpa_net_get_nc_vdpa(VhostVDPAState *s, int i)
 {
     NICState *nic = qemu_get_nic(s->nc.peer);
-    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
+    NetClientState *nc_i = qemu_get_peer(nic->ncs, i);
+
+    return DO_UPCAST(VhostVDPAState, nc, nc_i);
+}
 
-    return DO_UPCAST(VhostVDPAState, nc, nc0);
+static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
+{
+    return vhost_vdpa_net_get_nc_vdpa(s, 0);
 }
 
 static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
-- 
1.8.3.1


