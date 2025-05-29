Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A3CC5B552
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis2-0003zA-P4; Thu, 29 May 2025 15:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirz-0003xp-L8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirw-0000BT-Au
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfuTF022089;
 Thu, 29 May 2025 19:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KN2UH6ZXk8/NTifVk2OSX9r0uEI5WnDo1i3IMxFynRM=; b=
 ARgllyY8o3r+MAnw/uw5LHVN/StGSJoOcqkuFGGQpbHrPFTqQUo5Ij29idRKZh84
 zhokECkYU9j3YafAsWwS8bDC5fuS+29TTkIlpbIu9hZ08biD9XnBtXZnB09M/CP+
 s/5v1EDr0lBuMWy6iJE7dJPgpZw0PjaXPGOfysKDzMlXYH/UIOFRNNW7Uyhnjqij
 rfrYHc/TE/Js5xpaZ9pIYrl4gYMt+8Cnd+tBcMv+NKG3QwK/cWS9fk2sqgrS5CRg
 rnDwXkd3ZazlJE3ehiE+sbBlUtueM8iOTEGmhC3xy1D9Da3WTk0wZVcglLFVnKCG
 JwZiDVsEX49xsHcPXt9vAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJ2DhL020314; Thu, 29 May 2025 19:24:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeQn022158;
 Thu, 29 May 2025 19:24:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-2; Thu, 29 May 2025 19:24:41 +0000
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
Subject: [PATCH V4 01/43] MAINTAINERS: Add reviewer for CPR
Date: Thu, 29 May 2025 12:23:57 -0700
Message-Id: <1748546679-154091-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: V8egECSfLkJUylzaulb73-6eoGA4wGFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX79O0RKPNZo4G
 eEXXt2EwGPASv89z5LR2bVertmKrT219FrNQ3rn7BlgZE/S3fdpuXXg6qqRGeOXkF0+bJKH5Nqv
 dH3yeVgaPhcoo/1amwW2fVU3/9ttGjNQuaMWG+9MEHKW4JPMXzeHvcPh0OYquPsMjmo4UmIHO6E
 DwP66eDVWHw8ebnoP1dI4mauve04z1v6RZ8Nyiz4Zbhw02C59q9f42hqM9S8RlGRXZkHfm49X3U
 OnYlIjEsCQeaKSvfS0Y4TonrFS2zWezei9dK1J1W5rV0w09dI0fYL+Clkl9Eq9XsFAfnkH4wWWI
 72amYiOrCPo5Ery1UjLx8aJf1StRGQbUUIXi0rx38//xXjZdscqEqf8XoUzBb1l/mYLUAFUYYS8
 ORzyFgFXFDRzAS9tJcZTmY/co04xTzg5DP5P5o0QWGbjJXHojKwRhoHyn/Ppk2Xg6WL5xma3
X-Proofpoint-ORIG-GUID: V8egECSfLkJUylzaulb73-6eoGA4wGFS
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b47a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=p0WdMEafAAAA:8 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=hD80L64hAAAA:8
 a=I-rtmlutLkb9hfGCvNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e27d145..e29fb4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3030,6 +3030,15 @@ F: include/qemu/co-shared-resource.h
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


