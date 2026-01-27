Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3FDD34097
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkG-0003yW-J6; Tue, 27 Jan 2026 11:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vklje-0003Z8-Pc; Tue, 27 Jan 2026 11:16:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljc-0000mD-UI; Tue, 27 Jan 2026 11:16:10 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7950A007304;
 Tue, 27 Jan 2026 16:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WDMbyYPajbfqbRwJs
 aVA/NtqWqIpOOZER5KWRS/AEiY=; b=Xyv4/icp0CZGxOvQ1DYEQW6w+/k9579mL
 0JPQ6muoU50d22zMHd45hAThPOgo6fBxSB1nQEcrWTGbax9dPho6tgRkK8CbSazz
 S4EOee+j8Jygg6uLe71/F2FBdANYB1LDnq/HYk/MZKrRfKH335ilnT/87R1yg7qo
 3dLpu6XAKe/HhmvXCc484+pFFu0R9tXeqLI2Q0FwFpvOoGIJ+edHmyFwmjKwi+We
 CrwG2g22osp6xHsrcUFzldNWFXD3GLys63l41G4e+VqxHD8QTNvx+FJduS9VdX5n
 KJlLekr2ha60GKbEg6qfp2nC3v/g9yAbKG/PBP7d1xx4SFo4EwzUA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrteaxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCptjL031069;
 Tue, 27 Jan 2026 16:16:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dshdsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGG4hY30605826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E6495805A;
 Tue, 27 Jan 2026 16:16:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D8FA58054;
 Tue, 27 Jan 2026 16:16:03 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:03 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 06/14] include/hw/s390x: Move CLP definitions for easier
 BIOS access
Date: Tue, 27 Jan 2026 11:15:39 -0500
Message-ID: <20260127161547.459443-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ep1d5yHJkGh_Z9sKu641niD_0flL1Ics
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978e4c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=rFK5pxbz29QmIqMdG50A:9
X-Proofpoint-ORIG-GUID: ep1d5yHJkGh_Z9sKu641niD_0flL1Ics
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX4RwzQ1IonRIM
 Q4gDBPRWssWX/f7hnoeqvNErGGmpcgr+SoZqy+yl/GJBq8CX7PNYKcim6dmTjJTOFuA8J/kW7uO
 lG1XYrHiCrgZzXCkLwai6q2DtLt664RwzVhKN8r6kL2deKPNupdOim4cY5KkbMa0uRDpSG5JoWT
 oGkU3g2y8CclbPRlZs/AU6BHOfqcfx7BBgtaA0eQRFk9DRZhMoX4GKkYm8GIzwaNi9IY5oFQIJ+
 6DuGBqOLqDHr3CF6FlBoQ6AcEEBjjsWZ4FALkJIm3W+sS5fay7dA56TsS3eL9S8pAzTKR961G3u
 V6DBRH11o9CrAhrXd8ypPTPawlUG0/JdwglAoVyHCB+vQPhArkqzhXYHn5nJl5AyjF0OS8uxeGY
 t6VOW1IIPekx4+MqJD+ndp5maJ4NQK0l1IrEMtQNiG+NMIVwUPffI5Oc1dygCPoyhZ2sOyYJGvq
 fpPuCgMirNWegG/UR5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jared Rossi <jrossi@linux.ibm.com>

Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
to the s390-bios.  This allows the bios to reuse the architected definitions and
prevents code duplication.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/s390-pci-vfio.c                  | 2 +-
 include/hw/s390x/{ => ipl}/s390-pci-clp.h | 0
 include/hw/s390x/s390-pci-bus.h           | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 9e31029d7a..8ce44dbecc 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -17,7 +17,7 @@
 
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container-legacy.h"
diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/ipl/s390-pci-clp.h
similarity index 100%
rename from include/hw/s390x/s390-pci-clp.h
rename to include/hw/s390x/ipl/s390-pci-clp.h
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed..f643e13057 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -19,7 +19,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "qom/object.h"
 
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
-- 
2.52.0


