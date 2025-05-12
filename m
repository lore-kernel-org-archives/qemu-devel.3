Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD198C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9M-0003hf-Lq; Mon, 12 May 2025 11:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9K-0003hH-D9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9I-0006dz-Bu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9epP017588;
 Mon, 12 May 2025 15:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=st7Mm3PlhXzH7vX8uMOmGtjIQplLsJJflVI4scUaJ/I=; b=
 o6ry2AfT37nbT+vzxMoIPCnuovesAqCNRpsbnnFzCmo2Y1Qsqc3wGkogsq+nqG1y
 pX/KVGphvtY3Ka2x9IpY/aVaq09ajbRZpkXzzaJzfF4DMAfgxerUcN01ivKtC7zl
 wFC26tjftDMmMBCK5qoJZeatD+EMFoCfFjYG+KWHnOPyTQTwxvvT4Qgn59/UEbwk
 /uJHxXsrKesjMp8HOgEHarGvuQKAeidl7sOIgh4uXFtQPMJm3exnfAGAwXDKKiXm
 7km7TmaR+hsbAJXTAhZktohnpVGzN8S2PKYWCDAERNFVO5vqumECb3MdlKdAnLWC
 xbL75NVP2h9mXW+XTNIgrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tveh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0qCD002414; Mon, 12 May 2025 15:32:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3663m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4e030605;
 Mon, 12 May 2025 15:32:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-2; Mon, 12 May 2025 15:32:55 +0000
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
Subject: [PATCH V3 01/42] MAINTAINERS: Add reviewer for CPR
Date: Mon, 12 May 2025 08:32:12 -0700
Message-Id: <1747063973-124548-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX8MzNtjG359VE
 L79KjdIv9sbnI1i7kx1zJhXqCYQVcmEX8zpr/Z4gEq1NGLDG4EjDcK3xgtOgvRu47EG+zI/xQVe
 qGsn/Dipk9GayzTAlPvNr4fpBYHXkDapl+kO0XQb5NDcKg71XBEHkiC6osyZQFmsTundMAVW0S4
 DhZimLBXw0634nu2ZQGNe97njzmK4xkBgLsfdjtVYT8pyflarEcieefvsXugOgF5bFStKcfGOqp
 JjfvJWp4H3u2RSw9e5llXW75rkW66lXNLTAxhchgb2f+35Bi9hwcL1Lktgt8z5OI0goegXoHWiw
 virYHTZp85YQb9cgtwuo0vd+2cDgNYQHsaDdWmdecGaEDaIsh23G9f+onYMJoKI3jS2xNrKDSzU
 kXvxXHW/EpWzFCSI35cZkh2abkL+tL20VibbcwI0lBvxVLoQqmEN2jWuqYobGWkgosw9ACFn
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682214a8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=p0WdMEafAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8
 a=hD80L64hAAAA:8 a=HbCQL4OLKEBnww3_1lQA:9
X-Proofpoint-ORIG-GUID: Oj05_ziILG6p7sI23mQyRA2npe9dwqSf
X-Proofpoint-GUID: Oj05_ziILG6p7sI23mQyRA2npe9dwqSf
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

CPR is integrated with live migration, and has the same maintainers.
But, add a CPR section to add a reviewer.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dacd6d..d54a532 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3019,6 +3019,15 @@ F: include/qemu/co-shared-resource.h
 T: git https://gitlab.com/jsnow/qemu.git jobs
 T: git https://gitlab.com/vsementsov/qemu.git block
 
+CheckPoint and Restart (CPR)
+R: Steve Sistare <steven.sistare@oracle.com>
+S: Supported
+F: hw/vfio/cpr*
+F: include/migration/cpr.h
+F: migration/cpr*
+F: tests/qtest/migration/cpr*
+F: docs/devel/migration/CPR.rst
+
 Compute Express Link
 M: Jonathan Cameron <jonathan.cameron@huawei.com>
 R: Fan Ni <fan.ni@samsung.com>
-- 
1.8.3.1


