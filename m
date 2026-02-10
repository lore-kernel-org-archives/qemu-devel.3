Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8223EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo5D-0007X2-Ht; Tue, 10 Feb 2026 08:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo50-0007SY-S4; Tue, 10 Feb 2026 08:47:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo4y-00052Y-6B; Tue, 10 Feb 2026 08:47:01 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619Nd8xn3286208; Tue, 10 Feb 2026 13:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=r64brsEFXIrJYIYqV
 v1xKmVK++ZiYAxOnnPBb59Azso=; b=NFvQ3BdAwpvnVIYJJyKIZOlZIbvHP8TOu
 qPQJfOnMcu9/BcDFsau4gFOW3FFLFj8c1F8/EYtOBrYqujJwEy/phufoB129qdiI
 WgcoMn/Z7wak6IC2LsGIHOcGu41danyurIQPrglljns+Fk/iiBbH6g9Bf477f3bz
 cZHwB65Ctbx6gI4IZbm4hlUVrSQj82gtkDF6+MtIZnAtXBfhkgujWNyTIkDFfloc
 XXUU/gD39IvsngrK1CNS2S+Isim50cBtNpLjnxN7vV5d2XfeTAv89Gp0K08rsCWi
 HIFkppc4LkqNo2d82BH4KN/k6S/AqTTdXOFkeFNVw/1OQPVDUK0XA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ucgf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AAeELS019277;
 Tue, 10 Feb 2026 13:46:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk1a95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:57 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADktg760883442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:46:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44F3558050;
 Tue, 10 Feb 2026 13:46:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 865D058045;
 Tue, 10 Feb 2026 13:46:54 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:46:54 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 2/3] ppc/pnv: Add unimplemented quad and core regs
Date: Tue, 10 Feb 2026 07:46:46 -0600
Message-ID: <20260210134647.2050821-3-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134647.2050821-1-calebs@linux.ibm.com>
References: <20260210134647.2050821-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698b36d2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=cJSdteDuGY5sE08ftSAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNiBTYWx0ZWRfX9ux6Ry4AJzwS
 nEobKhn+hs9AOfnGyBlq+IGl1sToH5vMF01aYg3Gnd35ziyIz6IeFsNErM77MetgHBXrYMDAUAR
 +ldHzZX9JsEJe1txCBZlBJha8gkG58E4YEFTCbs412BffzSUXbyFgi/sK84TysAweZ8ng6vK2Fi
 DjaRxYD8iPpgn9BlVFRosDRBXsudem3/pGQN1XGIbTchfQYwDAQey0OWjo3DpUkhb+16CiS/9GU
 H376LoqYAcafNZvO5rG0f6FIRKl7Cq7epEsnWvQe6cUdsigAFux8Ar4urltTsKfnDQyhDyC0Z62
 XSyV/WRZh5Dco4qnNU/ftXfHpYpqCy8iD+kOXvbyJaJxg/FR0gDwQrDlk0Okl/vKshOQyT7hh90
 IgdHZHrA6JERHgOBt30ODQumsEJktHDEOyHLHXr7J+Be6U2RU5r+AMw6HYbEfOPCEb1Yda9Zj7p
 6cKrBs8Wzbn9jicospA==
X-Proofpoint-ORIG-GUID: 12libQTqIXPOjpN4Ltax24pZ5nKIP9x1
X-Proofpoint-GUID: hGwfgF6LoBLY05pU5i_5st_Aj3lqYBGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This commit adds the read/write functionality for few core and
quad registers for Power Hypervisor development.

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_core.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8939515c2c..a95934710f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -183,12 +183,22 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
 
 /*
  * POWER10 core controls
+ *   Adding additional SCOM register support needed by the
+ *   Power Hypervisor team for their development
  */
 
+#define PNV10_XSCOM_EC_IMA_EVENT_MASK       0x400
 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
 #define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
+#define PNV10_XSCOM_EC_CORE_FIRMASK         0x443
+#define PNV10_XSCOM_EC_CORE_FIRMASK_AND     0x444
+#define PNV10_XSCOM_EC_CORE_FIRMASK_OR      0x445
 #define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
 #define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
+#define PNV10_XSCOM_EC_SPATTN_OR            0x497
+#define PNV10_XSCOM_EC_SPATTN_AND           0x498
+#define PNV10_XSCOM_EC_SPATTN               0x499
+#define PNV10_XSCOM_EC_SPATTN_MASK          0x49A
 
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
@@ -224,6 +234,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
             }
         }
         break;
+    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK:
+        return 0;
+    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
+    case PNV10_XSCOM_EC_SPATTN_OR:
+    case PNV10_XSCOM_EC_SPATTN_AND:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                              "xscom read at 0x%08x\n", __func__, offset);
+        break;
+    case PNV10_XSCOM_EC_SPATTN:
+    case PNV10_XSCOM_EC_SPATTN_MASK:
+        return 0;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -284,6 +307,19 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
         }
         break;
 
+    /*
+     * Allow writes to these SCOMs for Power Hypervisor development.
+     * Behavior is not needed, just to allow writes to these SCOMs.
+     */
+    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
+    case PNV10_XSCOM_EC_SPATTN_OR:
+    case PNV10_XSCOM_EC_SPATTN_AND:
+    case PNV10_XSCOM_EC_SPATTN:
+    case PNV10_XSCOM_EC_SPATTN_MASK:
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -579,6 +615,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
  * POWER10 Quads
  */
 
+#define P10_XSCOM_EQ3_MODE_REG1         0x1160a
+#define P10_XSCOM_EQ3_NCU_SPEC_BAR_REG  0x11650
+#define P10_XSCOM_EQ3_HTM_MODE          0x11680
+#define P10_XSCOM_EQ3_HTM_IMA_PDBAR     0x1168b
+#define P10_XSCOM_EQ2_MODE_REG1         0x1260a
+#define P10_XSCOM_EQ2_NCU_SPEC_BAR_REG  0x12650
+#define P10_XSCOM_EQ2_HTM_MODE          0x12680
+#define P10_XSCOM_EQ2_HTM_IMA_PDBAR     0x1268b
+#define P10_XSCOM_EQ1_MODE_REG1         0x1460a
+#define P10_XSCOM_EQ1_NCU_SPEC_BAR_REG  0x14650
+#define P10_XSCOM_EQ1_HTM_MODE          0x14680
+#define P10_XSCOM_EQ1_HTM_IMA_PDBAR     0x1468b
+#define P10_XSCOM_EQ0_MODE_REG1         0x1860a
+#define P10_XSCOM_EQ0_NCU_SPEC_BAR_REG  0x18650
+#define P10_XSCOM_EQ0_HTM_MODE          0x18680
+#define P10_XSCOM_EQ0_HTM_IMA_PDBAR     0x1868b
+
 static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
@@ -586,6 +639,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
     uint64_t val = -1;
 
     switch (offset) {
+    case P10_XSCOM_EQ0_MODE_REG1:
+    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ0_HTM_MODE:
+    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ1_MODE_REG1:
+    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ1_HTM_MODE:
+    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ2_MODE_REG1:
+    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ2_HTM_MODE:
+    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ3_MODE_REG1:
+    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ3_HTM_MODE:
+    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
+        return 0;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -600,6 +670,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
     uint32_t offset = addr >> 3;
 
     switch (offset) {
+    case P10_XSCOM_EQ0_MODE_REG1:
+    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ0_HTM_MODE:
+    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ1_MODE_REG1:
+    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ1_HTM_MODE:
+    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ2_MODE_REG1:
+    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ2_HTM_MODE:
+    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ3_MODE_REG1:
+    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ3_HTM_MODE:
+    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
-- 
2.47.3


