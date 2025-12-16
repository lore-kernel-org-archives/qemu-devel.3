Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35D6D609A9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWko-0006qT-Sj; Tue, 16 Dec 2025 10:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkn-0006pO-A2; Tue, 16 Dec 2025 10:14:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkl-0006xK-AE; Tue, 16 Dec 2025 10:14:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG9pFHY003617;
 Tue, 16 Dec 2025 15:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UXGPJgqGe4SMmBhzj
 kw2ibPeM4RYnUTKtGy7LaGhK0I=; b=Ixt3IEFXxZSyxMqgwe2wewEI3USNHtoRN
 zZvttdOHc0PQ5WFmIxcBh9gxiwU1Lv6p/VED0b7EO4Ft9DdUfoJZNx00HfsVW0Xe
 bq31QIYR+9FdJjcW9Ummm943ICpItE63VmT7FugKRbYpFPBfamZyg6C3W1CRFK78
 QjMDZC2EHd7OFvSP/pO1aU4WXlzZe6+CCsDB+ckdWTNY3a2Dl26nmZbQh3SY8pL6
 3Ao/UREKUfPriaFpeLngCB72LjXdbHZVaNud0N9UN0+Mres5EVgWHvoRUTs+92TB
 inWjBBMqgxY9F8/eZB8zNxUlrNo0a+oJV3lgPsOpzU78N21v4Z4Uw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv7rbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGFEEbl026764;
 Tue, 16 Dec 2025 15:14:14 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv7rbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGC5ZBL005971;
 Tue, 16 Dec 2025 15:14:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgnudfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFECXx41419506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:14:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 396415805D;
 Tue, 16 Dec 2025 15:14:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6720558043;
 Tue, 16 Dec 2025 15:14:11 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:14:11 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v3 4/7] hw/ppc: pnv_adu.c added vmstate support
Date: Tue, 16 Dec 2025 09:13:56 -0600
Message-ID: <20251216151359.418708-5-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216151359.418708-1-calebs@linux.ibm.com>
References: <20251216151359.418708-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX8DdJc0E1KbiR
 iNIs5ANenadCSIUkRXqtQ/BT+nGNZIXu4rulpSqtTjLtdYXT+TeRcCHs+bYL7hDlNKDSqGYggqD
 Fs3Qd86rgzKgucm7+fKYbFiw152ln5EamnkWbL/cCOfNUBZXoVCo5LGL3zw3EfLePxSnjFxRK2f
 P89JHcppiSYQ7RJwWlnq6jGwgdbnjjET06ZzeIyeikeQ9ZKCI0GVSJgyX+cA83bOoYB30KR5fi0
 YUe/JM+2+89xQyJe8TblMKqqh/O/0M+rmZOLUq2RVHKTvTxAo2CXd0JxAakxBcKeUFfHzIegvfR
 FOR+jRyS3k0KqKkplT/XHviemKsp3XuFzmHZEsuvtoTbkJ6qGDMzQrRi4hOfwRNn+hpEw74xDwp
 wPb81MwDMXeszjrmO9aRXpk/svF8aw==
X-Proofpoint-ORIG-GUID: EAaghSScP9O8dn6xJTNAVrSGtntkjHSq
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69417747 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=PgXMhBZ8xRIDpNHfNDEA:9
X-Proofpoint-GUID: h_K-szidJaZcU0n_eL5efbQfist84GGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

- Added vmstate support for ADU model

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_adu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index 005fbda475..bd2a9e233a 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -23,6 +23,7 @@
 #include "hw/ppc/pnv_chip.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_xscom.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 #define ADU_LPC_BASE_REG     0x40
@@ -189,6 +190,16 @@ static const Property pnv_adu_properties[] = {
     DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
 };
 
+static const VMStateDescription pnv_adu_vmstate = {
+    .name = TYPE_PNV_ADU,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(lpc_cmd_reg, PnvADU),
+        VMSTATE_UINT64(lpc_data_reg, PnvADU),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_adu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -197,6 +208,7 @@ static void pnv_adu_class_init(ObjectClass *klass, const void *data)
     dc->desc = "PowerNV ADU";
     device_class_set_props(dc, pnv_adu_properties);
     dc->user_creatable = false;
+    dc->vmsd = &pnv_adu_vmstate;
 }
 
 static const TypeInfo pnv_adu_type_info = {
-- 
2.47.3


