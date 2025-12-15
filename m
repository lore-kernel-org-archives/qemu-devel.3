Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2EFD5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCEF-00030C-0t; Mon, 15 Dec 2025 12:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDU-0002GO-AB; Mon, 15 Dec 2025 12:18:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDP-0002hz-Q8; Mon, 15 Dec 2025 12:18:33 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFClVqR015244;
 Mon, 15 Dec 2025 17:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UXGPJgqGe4SMmBhzj
 kw2ibPeM4RYnUTKtGy7LaGhK0I=; b=ik6/Sn3DAYmnNb+eFUeSDnjJud4OcSKnj
 lETrNilvXoT0h1jbRhivV7gLn9eAF3o/h+QhZtdEyB9dAZV0164F09azSKm+0E20
 B6GFjWurh3knV6ooe4c/Cc2xXbnmhEeYUHEqRTi+fsukSX/PNpogMR1oBeCT92eg
 Fdt02kqBH3uLPMEQq2i7JtyP1a+5TFmtHom68H/QO9hlSGtAEp3lS8dIByowlMLO
 /UufB8ief0hgXRUXQGTl9e/66Pe9UoQTsWMGXLvCLVVN/UeQRRQbp5ZcQb+n+oCV
 ahk8wimZw31HHobm68QGzt4GJpa4WaWdtWv+RES94fezeUV7kBevw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb33tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHElfX013240;
 Mon, 15 Dec 2025 17:18:27 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvb33tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFGAJBP014324;
 Mon, 15 Dec 2025 17:18:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjqc7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHIPN425494094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BFCF58056;
 Mon, 15 Dec 2025 17:18:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA2FB58061;
 Mon, 15 Dec 2025 17:18:24 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:24 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 4/7] hw/ppc: pnv_adu.c added vmstate support
Date: Mon, 15 Dec 2025 11:18:10 -0600
Message-ID: <20251215171813.1670241-5-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=694042e3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=PgXMhBZ8xRIDpNHfNDEA:9
X-Proofpoint-GUID: c8Odpvyo4tmTzszx9KO0c-ZEVyYuLsmL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX0j8whX2UHJPy
 pDuwffDLFYCpXShRxG3gj/HvM+yyiTLxE/1ogRSI0/hdYKrFWwL72HY5oLVPh1LXKdFHOWWio0C
 pQ8GUkp4EkaodGGigKDh3R7Hidw8KDI+8Wiv+49aQfb6bwq5PecNNpHJ9t4oBMt1odSInBCeiBI
 +aSA/7hP5sKvnkr1FJR0B7qHOE7dk20Q8FbsnAVx4Z+y+0UbIMhKOjZxNNTgM4BTIbZS/SrZokh
 d1OrAw35/WvwLWFTTEPdwerc+HzzdscYFW9aEqCrAJMv9+4D1UFm9F+GkjTd1lmtAy7NEZqp/6F
 f/nEzQDRPjBokb88CC7AZ0phIZ5AwqrN2Yry7AEUft5DOsgmWrNPCVAmxIqtq87oduzF+PXtk9r
 F/V0AocDteuiBcdxSHJFEPXD0dh6Iw==
X-Proofpoint-ORIG-GUID: HnF_8VtVGbBBkbqVaQhG2CZCmoQnszJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
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


