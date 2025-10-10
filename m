Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0067FCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 21:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7KnM-0001aG-RN; Fri, 10 Oct 2025 17:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1v7KnK-0001Zx-UX
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 17:36:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1v7KnI-0000Tq-7y
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 17:36:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFtuCL029806;
 Fri, 10 Oct 2025 21:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=FwmAf1f7AVOmRZ5aT9VsF+gnXMDW+
 GydOoEoEgvcHn0=; b=CrcpEHX5+87S9AWk6yjiNjYamQW6dmlZL4/EcEMZH1FV5
 PiUB6mW4qhCBDz6o2E0tG6zVCQeEzFTCmWzxqGShUhhkHsAFSBBAqSpSonzMsYC2
 Ky1CViIclnn3cm5yUG7nbjD/R24J2n9CggYXkkFowC/AHOPsJ1tJToaDyR1Wu0j/
 0zR1m6Bv4J87mVWFfWfXyp/uxi2JY9pXLHRRpI/Ek64mFXqPK+WTXA7u6YyerM2M
 LYhNBTDMRnR5P6n/7CHk0nRi6xShUfWounsiDqDEIC16yzrLWCzP3V5qnfh82WlI
 rgs6PwfdPsr/01oYQU+G5UxByu5jmZhssiOGKoP5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69vg02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 21:36:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59AJP0q0010248; Fri, 10 Oct 2025 21:36:42 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 49nv68qdmg-1; Fri, 10 Oct 2025 21:36:42 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com
Subject: [PATCH 1/1] cpus: resume hotplugged vCPU only when the guest is
 running
Date: Fri, 10 Oct 2025 14:36:39 -0700
Message-ID: <20251010213639.1634-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX62/93kuNuCLp
 xOeFN/EnSi78ExWbqvW9yFK+Cw846dvjAkIvH2JTa70MnZswy9VEstoUQm8oCwYjBVembk/IfoR
 ARmnCJt4d8zwsBsz2sIzUe8OqiRwpOt4sJGJMlB4bIUzeJrXfehw90nEWhw0Z7Fcf5WnNk40XPG
 SZXyazLVYYTmL+JWiGeZHqvSjs0IljQ459NQsAKRXg5L0fw4xrX9SRFpROVHx8RUPJhx19YHEsi
 H7mqdJw9Q2zTdkWAhlnQlkVOXA0R5lesULA95z1u9vCyKNxQsjrqrqkPv/qn1XSa/pYNT5uEBs0
 UDbfQfABrT2lFdQuHZ/ddFbZqLPT3lumxdaP3t+y7HL4vx2/HUEy7APqMkXnKqAte/t2W/lWhnu
 LVDgXGlB2WVrwtRTBa72iPkUkdAI+w==
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e97c6b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=TpFyzyTL7qCKQcCO:21 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8
 a=qg1BVPZ4bwsD7C7iym0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: xB6fezvs3HuCcEBwiWDL5Yh6XQk05XJL
X-Proofpoint-ORIG-GUID: xB6fezvs3HuCcEBwiWDL5Yh6XQk05XJL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a new vCPU is hotplugged, cpu->stopped is unconditionally set to false
by cpu_common_realizefn().

However, there are scenarios where the guest is not running, i.e., when the
guest has been stopped via the HMP 'stop' command, or when the instance is
a live migration target started with "-incoming defer". In these cases, all
existing vCPUs have (cpu->stopped == true), except for the newly hotplugged
vCPU.

Unpause the hotplugged vCPU only when the guest is running.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/core/cpu-common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c306c89e4..789382cad5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -30,6 +30,7 @@
 #include "qemu/target-info.h"
 #include "exec/log.h"
 #include "exec/gdbstub.h"
+#include "system/runstate.h"
 #include "system/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
@@ -263,7 +264,10 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 
     if (dev->hotplugged) {
         cpu_synchronize_post_init(cpu);
-        cpu_resume(cpu);
+
+        if (runstate_is_running()) {
+            cpu_resume(cpu);
+        }
     }
 
     /* NOTE: latest generic point where the cpu is fully realized */
-- 
2.39.3


