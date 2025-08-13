Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B55CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCIk-00074o-6T; Wed, 13 Aug 2025 10:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umCIg-00074P-Tv
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:17:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umCIc-0004RV-5R
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:17:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNBwa019317;
 Wed, 13 Aug 2025 14:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=tiz7JBsgDCVRtx4s
 iVe9ub1AXjNEw9e0D816QLfv/9U=; b=mSDYzKGTPPMQFh9+AVoozulmrAQPkZ3S
 /hyiFfx893YrgK/j6SRoG2JOw6Ti94bAUYYp3kmRzGLWHMHtRqpucOvBe8iEvrRk
 wVNgQ3x/+d0kBfUakGcejh4harWfZWQLmdneqMXNx+/md05e+qj0WocUHD3AiYlP
 OZDwyf0Rnl6TQQZJSyLuZEVw/fP62OTMbR83TiPOYnJELqHbwEN8/OOBR7Shvsvt
 n9/UvnhT0Y5HoHarX8Wa6DFqUu1aoreLkwnRmO8hTjXwhqReOLx7twMajvE0no3k
 H7sKRuGqGlHjsAKKBwkbPwmP8WorTFt6iycl/nVAG//bf6jX6ZOMqQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8efnbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 14:17:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57DCeLZ4017389; Wed, 13 Aug 2025 14:17:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsbf8e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 14:17:48 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57DEHmhU018173;
 Wed, 13 Aug 2025 14:17:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvsbf8dn-1; Wed, 13 Aug 2025 14:17:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] vfio/container: set error on cpr failure
Date: Wed, 13 Aug 2025 07:17:47 -0700
Message-Id: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130134
X-Proofpoint-GUID: hHUTqb1fsNEM9VOrwa3WASwMapJ3TM8U
X-Proofpoint-ORIG-GUID: hHUTqb1fsNEM9VOrwa3WASwMapJ3TM8U
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689c9e8d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=RJe6Pf5eNMpdvKrrBVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=CKOJFrdQhwIypUwta_Sj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzNCBTYWx0ZWRfX3XZFf5B42Cuu
 s6fy+If6pW1NEAUuwP2eFICfiPsFG4cZr9mGvJoRNzuinLl04vtfsyKWyH6BJy71kvhaqoTvPCF
 Ez1g5fcrYwO419Wz/KzBuqUab5+oHELZt5REf1gg8WvcWELxVFbtX0LdlGtOLJaJ4ondfY3Ur+0
 5cmAy2Tsu/obFD6goPPHz+BVwZ1AxjUNBrcqRcrd1mtbt2Vup3rXNdPaaJS2PmHzqCrEcKgO7vi
 OHLlp66oZ49VToxdvYjFg+ssNqbX6mN0tAHHaesjKs5QL0zCb/14OUyWQyAiEDveS2Q6z7E9qqN
 af7ueXkl7MeBjr4jkAyN2/oh9pMcyFts9SRTUgT2RIrSlNyWtljxlLknVOG87AEloBOczURZ7Jz
 2LnEiXWetJHtYp9rVlPbH7Z/KxCFaR0UsZCa0/lNJvuhehOHkR5ICA2vIVkzuHU/GFS9i7lZ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Set an error message if vfio_cpr_ram_discard_register_listener fails so
the fail label gets a valid error object.

Reported-by: Cédric Le Goater <clg@redhat.com>
Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/listener.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f498e23..5ebafaa 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -574,6 +574,9 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
             vfio_ram_discard_register_listener(bcontainer, section);
         } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
                                                            section)) {
+            error_setg(&err,
+                       "vfio_cpr_ram_discard_register_listener for %s failed",
+                       memory_region_name(section->mr));
             goto fail;
         }
         return;
-- 
1.8.3.1


