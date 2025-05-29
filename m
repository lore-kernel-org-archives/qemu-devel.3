Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8893C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKist-0004MJ-5s; Thu, 29 May 2025 15:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisS-0004ER-KE
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisQ-0000R3-Vy
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfxVf022106;
 Thu, 29 May 2025 19:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=fxDcFwFeZtL4RvB4l4f1LNOH5ChDVZEc60qqlx6krBw=; b=
 G+Ba+jWIcb2BU+qxyheJMhdvV1odBLyfVlwksY6CRkNPRDRBCdgbxIQ2kgJ1EpzM
 fCMYcj7iOMo0yYT8unawUwxJqlAYWMB1ysss9yxnz7Hn/j8qYe936MOUCzFD/7D0
 3dFEY9tEuSbCNm9oIzyNcrYlzetb5E5cO1QJrIHq/cuE3uYxaUEWEZ1/JHmf4lOP
 Q8aNVL3EB0PSpAN3JAWzh2RooHX4G8vC53qCBOHmK7v4u+lDlCx1JW49W00ZPd9R
 cpBbQlQCOTIi1obk+m9gQAYTm3mvaZPcKrWgsYeTkLO8P2+paJluzT6XrWPaWdW+
 bfCxwyhcSGlB/i2qFTJ8Gw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THfAdT020441; Thu, 29 May 2025 19:25:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRl022158;
 Thu, 29 May 2025 19:25:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-31; Thu, 29 May 2025 19:25:05 +0000
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
Subject: [PATCH V4 30/43] physmem: qemu_ram_get_fd_offset
Date: Thu, 29 May 2025 12:24:26 -0700
Message-Id: <1748546679-154091-31-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: wWIGb6kdZOne-9SKDqJSKyffL86N0GYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXyXZHIjg7qfkP
 xg+eq2nGURmr+wcGKgW0COPcLiHClVQiWDw7zzQxxc/mTGo0ZBeGuUY3llX14SahJ3BCwdBBd2q
 JISlXNPGlyPU6LOFaLZ55ktfvz2WONPNKSyyBCsTode5bII+JfgQPo4+Tq3zCMQd+8qUkTg2IaO
 E6aelYc49lxvmEtaYiVUarz7pIWlZS7GEC0w/t3ik+PseKxBQlun/lVoOA9W/vhfBN77v4URB/K
 NElaOUnvjCDwV39+svCIGzeOVRHSMM8OUdb+vPMOorBRg62OqEnymr8zT/dJVCjsZo2WL0p8mq7
 37A9rWCmSD5kYKImYio+xrEhxJeRQc3rTrrKIkiqyB4PDp1aCH7G4K54GXv5SCYo8qWFoNWVvdY
 YDU+yEI/BiUIagzPktE10boY1koFEql8LywvcO1KHC1K/Dza45PXI6NwLy0kiU9AQIcZaxbU
X-Proofpoint-ORIG-GUID: wWIGb6kdZOne-9SKDqJSKyffL86N0GYY
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b492 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=s_ck3szjhOtuhh_aLR8A:9
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

Define qemu_ram_get_fd_offset, so CPR can map a memory region using
IOMMU_IOAS_MAP_FILE in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/exec/cpu-common.h | 1 +
 system/physmem.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a684855..9b658a3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -85,6 +85,7 @@ void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
 void *qemu_ram_get_host_addr(RAMBlock *rb);
 ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
 ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca3..18684a4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1593,6 +1593,11 @@ ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
     return rb->offset;
 }
 
+ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
+{
+    return rb->fd_offset;
+}
+
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
 {
     return rb->used_length;
-- 
1.8.3.1


