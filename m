Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5C9C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXl-0003Js-2D; Wed, 14 Feb 2024 07:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXh-0003Hk-Gw
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXe-0002XH-J5
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:12 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EAZUq4008672; Wed, 14 Feb 2024 12:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=ySDHdR9ct56jw4j7fTE9RMRShSMS68pwh0JBOmQ7V8w=;
 b=gdCGUSIGcw/0j68SmGKsEHg4DGxd1mbdPwoJAIJH33T8Ap4SZe8zIRMvRFiRKHCT44zF
 vGV9hPS7lFA5OvGkLR3DmxEJdIx4V5jzxcWJwfHHnhM/UpIdVcEboB6VTFawfAW91Lhu
 BoxtG/Q7wj6cyE2pSdHxL6MAESqzUFX6rCco9fUCLtBleO1TJPuzKhxZMgyU8zmi6ohc
 1DLIUkbPfMuf3xVjo7Qc1iM60QnLeyj3leuvkTJs7e1+lFhOBOTtEvdRwFX42ea3shFH
 KYiqMiuNBCfT6BuCLtRxetzJYUafMTCQhQOmi0r6ap8p0CnbghZb3WMq3M1U/aS1wCMA lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8uvyr84d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:07 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpk013766; Wed, 14 Feb 2024 12:39:06 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-6; Wed, 14 Feb 2024 12:39:06 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 05/12] vdpa: add vhost_vdpa_set_address_space_id trace
Date: Wed, 14 Feb 2024 03:27:55 -0800
Message-Id: <1707910082-10243-6-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140098
X-Proofpoint-ORIG-GUID: LSugYAbNzE28R0s5954gxl5jsXGZV7oA
X-Proofpoint-GUID: LSugYAbNzE28R0s5954gxl5jsXGZV7oA
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

For better debuggability and observability.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 net/trace-events | 3 +++
 net/vhost-vdpa.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/trace-events b/net/trace-events
index 823a071..aab666a 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -23,3 +23,6 @@ colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, in
 # filter-rewriter.c
 colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=0x%x"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
+
+# vhost-vdpa.c
+vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4168cad..48a5608 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -29,6 +29,7 @@
 #include "migration/migration.h"
 #include "migration/misc.h"
 #include "hw/virtio/vhost.h"
+#include "trace.h"
 
 /* Todo:need to add the multiqueue support here */
 typedef struct VhostVDPAState {
@@ -440,6 +441,8 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
     };
     int r;
 
+    trace_vhost_vdpa_set_address_space_id(v, vq_group, asid_num);
+
     r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
     if (unlikely(r < 0)) {
         error_report("Can't set vq group %u asid %u, errno=%d (%s)",
-- 
1.8.3.1


