Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCC0C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 12:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raEXo-0003M2-5Z; Wed, 14 Feb 2024 07:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXk-0003Jr-TG
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raEXj-0002Yr-B1
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 07:39:16 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EC4oAf015187; Wed, 14 Feb 2024 12:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=LhggrbhTSpwx+U8ydNJSvY5ohKf6sTAgmyti4QtJjOM=;
 b=KzlY/8dbuIPuJS59xQ7DwCK+FcxYjly4+YWuRoBrckroeaj7QK0BoTK7IfITKG3b/SB9
 KteWd40FlL5l58ORtvucyhxeyXMA7ffbhBW7HDa16gHDej4LfHBN2/sWP7s6F916IrMZ
 IVi2jlKMx77O9aN6/uoO7dz9kBqL+AmwclrlWczDg9VHLqcp8SNAzG8ebQd64M6FcMSZ
 ROQCqDqLJvFHWQ7ydTO+AHXkzLwSrxE4jTx3SEdzfndejK38HaGLbnYzL3k6uLOCmw30
 wUT1Np/vAM8SWEcWQXoqrkZNbNuf6LjnIf6UdTwcfMBkb+LUkY3k9dN7nSm5XvxlgUoP YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8w6v81st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 12:39:14 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ECKqpu013766; Wed, 14 Feb 2024 12:39:13 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3w6apbnn3q-10; Wed, 14 Feb 2024 12:39:13 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 09/12] vdpa: add trace event for vhost_vdpa_net_load_mq
Date: Wed, 14 Feb 2024 03:27:59 -0800
Message-Id: <1707910082-10243-10-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: MDhoXV4Q47J354QYpSXwruf1gvYaZt8W
X-Proofpoint-ORIG-GUID: MDhoXV4Q47J354QYpSXwruf1gvYaZt8W
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 net/trace-events | 1 +
 net/vhost-vdpa.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/trace-events b/net/trace-events
index 88f56f2..cda960f 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -28,3 +28,4 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
 vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
 vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
 vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
+vhost_vdpa_net_load_mq(void *s, int ncurqps) "vdpa state: %p current_qpairs: %d"
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 6ee438f..9f25221 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -901,6 +901,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         return 0;
     }
 
+    trace_vhost_vdpa_net_load_mq(s, n->curr_queue_pairs);
+
     mq.virtqueue_pairs = cpu_to_le16(n->curr_queue_pairs);
     const struct iovec data = {
         .iov_base = &mq,
-- 
1.8.3.1


