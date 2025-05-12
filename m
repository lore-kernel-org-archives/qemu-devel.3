Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA284C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9f-0004St-7f; Mon, 12 May 2025 11:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9c-0004Ms-7a
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9a-0006fv-Fx
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9euJ017589;
 Mon, 12 May 2025 15:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=pMBq4OaWNbRqyPmyPTzi+bg5JhhdckZdPD3XgpNZpM0=; b=
 DNVd9RjFa5AXEcYvKRf2A3+AgFDxoRy5CjxmraoBGYEd4Jnv2Q7HjbGQ3qj5+B38
 D9SfA/OQC3Ql28rY8yHRVtjSdCq3UxiGMVhq27aRZyLqGajIPqsb02kJoKlITsnj
 sRy0Gc1JyAdoHOkqP3Xfehc9HGVR+fW4boCbLFU+aGuTXvuvfVvmLC82lwNObrSB
 zfSPu13lV2dh+n5TGOvO6hv1ckxOwiFBhjwe/B847WMDKPNVWbS6NiWbXKGPRcp3
 mvWCslwiZlz0htMyMAS55RUPYgZV3XQDjMy6wCSOWXus2pzREPzePkPGpZgd95Pc
 LrdcYjfDHqL6VXP/FMXnRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tvfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEI9FP002457; Mon, 12 May 2025 15:33:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366b4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk54030605;
 Mon, 12 May 2025 15:33:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-14; Mon, 12 May 2025 15:33:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 13/42] pci: export msix_is_pending
Date: Mon, 12 May 2025 08:32:24 -0700
Message-Id: <1747063973-124548-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXwf4D9ZdFHzLF
 Ic51cxjGw5msa9J8lNDYHPypPlHMduAu7jMk+N8uCyT50O7ZdFhRYaFr0N3nvB+WbYIx1wPmfLy
 2OOv/L7Yc339VhWF+NxbMK2IUnVPY1KP4OURG9VF5tVeHlSTuWtgOWQA3lhEl0h0bRv2Pm20lO1
 mjDoxkB+JidzLzAsbOJhnPkvYo6qGVw2f9IzRCDbZuQmOpK/1sNapygnipLYePc8uXLQI77yO8i
 AZdzL8+v6Y2GGw3rndgl8ndqpuSePGR627liTg2zikD6fRoeJiJGxOxzagkqGZ1rXeVcn+FNCmt
 cmiIDOCH9Qla2Iu36NmPmAMwQuIF27HNzaAIq4MqZwWUgeu8W1EAMt07b/KenXsSLFi4QCIJ5ch
 OBfutCZTLXfIgWtEOllscX4O6Ougsr+DRmUY5K8Q7HrXZzZTK3XX6UyXgZ9POetBy2g0rRYM
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682214b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=b0qJq_d53OdcEBA1QiMA:9
X-Proofpoint-ORIG-GUID: H9fdT_-HmZMnGllhDZ5PypdvtjY88Y6_
X-Proofpoint-GUID: H9fdT_-HmZMnGllhDZ5PypdvtjY88Y6_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Export msix_is_pending for use by cpr.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c         | 2 +-
 include/hw/pci/msix.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 66f27b9..8c7f670 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -72,7 +72,7 @@ static uint8_t *msix_pending_byte(PCIDevice *dev, int vector)
     return dev->msix_pba + vector / 8;
 }
 
-static int msix_is_pending(PCIDevice *dev, int vector)
+int msix_is_pending(PCIDevice *dev, unsigned int vector)
 {
     return *msix_pending_byte(dev, vector) & msix_pending_mask(vector);
 }
diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 0e6f257..11ef945 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -32,6 +32,7 @@ int msix_present(PCIDevice *dev);
 bool msix_is_masked(PCIDevice *dev, unsigned vector);
 void msix_set_pending(PCIDevice *dev, unsigned vector);
 void msix_clr_pending(PCIDevice *dev, int vector);
+int msix_is_pending(PCIDevice *dev, unsigned vector);
 
 void msix_vector_use(PCIDevice *dev, unsigned vector);
 void msix_vector_unuse(PCIDevice *dev, unsigned vector);
-- 
1.8.3.1


