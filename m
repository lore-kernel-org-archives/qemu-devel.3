Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D1DC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Tz-0003P0-Pp; Wed, 02 Jul 2025 17:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Ty-0003Ns-GU
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tw-0003fQ-R0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:10 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQdR8007931;
 Wed, 2 Jul 2025 21:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=kdVfxQGUysBPpDLYSckkY36Yu3TUl1HNI99P+eYOMEE=; b=
 aAxVI9rkDEslavWLI9alJWg/61putc7+R5t7nIt+Zr0qCrqWOb2XPmHLXHOTtD+Z
 UDcaG8eVDsVY3tldrMo1lEi9pbXQhZtG2qx6kNX3op6IZ0iGZ13FAiEi3Pxxchtw
 810wGWTUWZRGBGubBU0L1vHdprJwy6Pt51g/aROZb56Vqq45UZtgJOHINKkCZh+g
 e3P+m5JiWbrqeptGQxnXhpecJcs99u2mDl3GX/YncjwYd+kbz2e99anflLNFWnZc
 ymsWkkngyiOnX/bfIosRxh1U+nT4RbPaOeJRz0nTsatttf3bmONlS5YPIYceEpxX
 ND1aRwXUQVrSyhHhPmUznw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af7vh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LbuVM033681; Wed, 2 Jul 2025 21:59:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:05 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxg8020012;
 Wed, 2 Jul 2025 21:59:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-8; Wed, 02 Jul 2025 21:59:04 +0000
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
Subject: [PATCH V6 07/21] physmem: qemu_ram_get_fd_offset
Date: Wed,  2 Jul 2025 14:58:44 -0700
Message-Id: <1751493538-202042-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-ORIG-GUID: obi8YBlHRUWbknvqO6-RgryWWTzFEWcS
X-Proofpoint-GUID: obi8YBlHRUWbknvqO6-RgryWWTzFEWcS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MSBTYWx0ZWRfX91abZd+7PJS0
 2zLARf01cZu8JxiSC8MniSa+9NndMDEv4+WEhPbR33RA3t3sjTGkn1d/zfiaK4agcgVy9/0rHGz
 GdGX9JOAflzMkH+kdbkurJUJ9Dvc9E0j2Q0JL611h1BH9Qm9JNoQRFIjQBN8VIFPuFjVfasJcrf
 1Z+LU52MdEaQd2Be3jK8Y9edZ4Aw8R1wOM8TgRd4IfnVqKhgMYfE7wOl8uM++k8d+H2NN3CfzAN
 67bVA5cWGvrWu5CTeVPiZf4q5wXx6QE+IK6XgKdfJMiBW6PiJSlDJ3hMKeYme40AAQxKKZEVNzj
 cd/JQgG5eZhKAls+y+Prwy3Ems7j3Wb9ZgGdJZqTz9l5ON8Kg9g181oxNNEOgefgKD5Sale8qg3
 xIF42AsQ9m/Ru0X7LzFDUK9rXtHMjZiYZfAdy2lWpcHS6tcLkefgbaG8p3fBnIMo56NMVcMV
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6865abaa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=s_ck3szjhOtuhh_aLR8A:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index ff0ca40..130c148 100644
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


