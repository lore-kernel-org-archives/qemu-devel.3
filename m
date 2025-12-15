Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F62D5B85B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCDo-0002bl-Ms; Mon, 15 Dec 2025 12:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDQ-0002D1-Fd; Mon, 15 Dec 2025 12:18:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDO-0002hh-S5; Mon, 15 Dec 2025 12:18:32 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFAH1W5004552;
 Mon, 15 Dec 2025 17:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=44fHeX7l2wlwmfL+5
 d4CWL4ReGvcYhZ6mdi5DIEcxz0=; b=meui0fmF6+j6stqxIxVubE18vlcb32HfI
 wZ2qVCCflGJknYUZQh58HMYL3E40HTBgwc+tQWLHbM1RvqEP7ykJzo2jOPg95vXs
 05PUbPRUsij8TQM2AGRfeyhFCxbAwsjdgjw6F+Yv19an4fp9fNasNSACuwz+OtZy
 5t97DQgpAtV+6XZCQgqNlzwcOpV2XwJJivWmBGliLlkUMcDOrNLF7msDRFpt1U7j
 jTsCIEF+mT0KKeS12UzJp1gOnHSfkJKv/pvLwR6yveiOdEOnlAB6X1mENOmJd8UN
 kCmpOlNdpiMHrHFyl7x1uOpEpaaQL+2IoXrtaiVST5vINqc5lo8wA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1ag5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHHddk021536;
 Mon, 15 Dec 2025 17:18:26 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1ag5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFGAd3B014318;
 Mon, 15 Dec 2025 17:18:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjqc7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHI8NR8454684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D27C58056;
 Mon, 15 Dec 2025 17:18:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A163258060;
 Mon, 15 Dec 2025 17:18:23 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:23 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 3/7] hw/ppc: Add pnv_i2c vmstate support
Date: Mon, 15 Dec 2025 11:18:09 -0600
Message-ID: <20251215171813.1670241-4-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SHkDNneAByNVkPjCWHZ4w90xIjQwNhNz
X-Proofpoint-ORIG-GUID: Taoa8tOOrNv-pQsz3yL7ikumqkVdKGQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX3vl1M7s/pZ3V
 eSCE2JRCiHO5Gg2yoK71JAMoBFbdMwR4oAcGCV9dgQRxYNfcZCU2YM81CGyI+Q2X2gK05vyr549
 1YMz4eOzGmJF0SAgCkaYJlHSxtU38UepPY2pW4CKrKhsiocYFjtqNVcwrspVjl3Vw55Njx7hNO6
 uKCaEuIUAvRr87taSf0ewZPhky0xzKLD02mrD0u6XYtLqSis00LYoocsi6XWQeXKAFgKVq4kntH
 m14PSEERp+b17zTV9TcAwKTTcgVOkq+60Y7mxC5lrmAqVHVHHX4zxLvQGw4zZhUver/n3hgsVW3
 Iw5RUYKuDbij2mJV5cTHXD43PA9virRSTXHNLx9Xheso5pQgHTaBCc5Rc+4/Xc9vs3f7i8YtUpr
 i3uT3e2o3eibJ1JJWhjBcb/tcWIoNg==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=694042e3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=DGM2Vrrcx73IGRt511UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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


