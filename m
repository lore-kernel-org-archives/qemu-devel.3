Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A97D43358
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTorB-0007p4-EC; Thu, 11 Dec 2025 17:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor9-0007oL-SB; Thu, 11 Dec 2025 17:09:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTor8-0000rt-B9; Thu, 11 Dec 2025 17:09:51 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBI5dok009194;
 Thu, 11 Dec 2025 22:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=44fHeX7l2wlwmfL+5
 d4CWL4ReGvcYhZ6mdi5DIEcxz0=; b=g12Yg+UFUPPr+4QFWOtbw2sVRRZ31Oi53
 GmsZHwGTv05z7CuOuMSJRILKKhRXs80fSYZ8/k79YezAK73liu7H9gzmBXiMUTxM
 2sduvau4+iOHDS50MKAsNkZ3tAmZZL6CHSZbWPdl2wfAXAtx6ZKn65QkGBpY4CgE
 ln9fgy3QgTLEkF0unkPbT4iPM3zj6lp3TLKi/eRRo5EFuTKI1taXEU0e7JtgwXh5
 px+88D8GtgpXQEhdfLMIU0cZJxWkKfIWeZ/cxYm6eAS3ZkEyMA57ikKRJJd6QFCS
 +3dzN+XQBL+L+o9/rXsy6uswVJEXG56gZIThHS3Yd2QZOtjt0YI/g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aytm93hjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM87pu015404;
 Thu, 11 Dec 2025 22:09:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aytm93hjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBKFZ9M030340;
 Thu, 11 Dec 2025 22:09:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtsh13c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9i5P17433122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB4558053;
 Thu, 11 Dec 2025 22:09:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6749C58043;
 Thu, 11 Dec 2025 22:09:43 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:43 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 3/6] hw/ppc: Add pnv_i2c vmstate support
Date: Thu, 11 Dec 2025 16:09:23 -0600
Message-ID: <20251211220926.2865972-4-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YBbBluHsL4OAxfL7Ojz_nzNasZUEqoky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA2MSBTYWx0ZWRfX79mA1sNV6B0U
 JXrSnj5Z8ajafxU3DBWTKOkvEUKuYy2NfEwo84wHM+mstYe5NfHzEedbANyYVFt/vNUMMMPYGFa
 wgGqgb4uS7yCMMs0eTtjA5KgxoWHY+XjaeL8gsbISLuobC8G3KGrhu0YUUb7v2uXrFCvYvvsABB
 BjeWGyfLPNEtnuMKfiFoM6jmT58NjM/RHqBLQSiU+dd5zRj0afU2MdtIuGT6gAnp/jOQCztFh1x
 xBcCjbOcgTu14j7WMkSlU72FjacitHgv7MRGjvTMx9iWobi7X0uWUiEVqXRDgnBrcagKfa3lu27
 6clARkaAJ8CIN4SBlcI2mffTtOlYRjgF9hw1OSINu4MX2wB6LhZlq1OiqGmwc24wwykMnYciyQa
 ZLDR9lYSt6XQU/I0RcntKJSz7dNUEg==
X-Proofpoint-GUID: IVfs3rpdtzmOWVza3MAQ54lTD_KUVaaF
X-Authority-Analysis: v=2.4 cv=F5xat6hN c=1 sm=1 tr=0 ts=693b412b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=DGM2Vrrcx73IGRt511UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512110061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

- Add vmstate support for i2c registers

Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 60de479491..1018078228 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -19,6 +19,7 @@
 #include "hw/ppc/pnv_i2c.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/fdt.h"
+#include "migration/vmstate.h"
 
 #include <libfdt.h>
 
@@ -549,6 +550,15 @@ static const Property pnv_i2c_properties[] = {
     DEFINE_PROP_UINT32("num-busses", PnvI2C, num_busses, 1),
 };
 
+static const VMStateDescription pnv_i2c_vmstate = {
+    .name = TYPE_PNV_I2C,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, PnvI2C, PNV_I2C_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -561,6 +571,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "PowerNV I2C";
     dc->realize = pnv_i2c_realize;
+    dc->vmsd = &pnv_i2c_vmstate;
     device_class_set_props(dc, pnv_i2c_properties);
 }
 
-- 
2.47.3


