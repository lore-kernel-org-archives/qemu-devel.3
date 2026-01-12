Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A10C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGe-0003qZ-7o; Mon, 12 Jan 2026 05:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGQ-0003hT-4S
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGO-0002Lr-Ft
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:09 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BJPuUt016365
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5AAp3eOYrcQ6IgQ+8
 7dGlcp38fpACqq19IAQ9rU+af8=; b=OIlAT1Z57GmVitqlrIqAoJNiq/BX9qU2S
 Z4vVBtp5q10vSwOYxkkvaz9HPrHlz/kM4CEGBQoh/ahD8lnmclKwYvsm1VZxMWc9
 kE9HiPymIHl8CTHFnujT3oo0SfmTcIi/aGYMeQrvqAlTqx1y07POJId/Le7Cp2bo
 4j4OXgE3QABgCHNR8//zTUWGtBCU+3hdmVWx911BfpcX6xtq6C5Qya3pAf+9waPH
 MccFRDvqx4ncWA3Vb5/02j4gdUmOu8mhZUDpM6UP0qqknIMbYC/FX1zoBbm4MwVm
 epfDp3RfV2RLZfpCkXGC1Sa5iwozVqwLJTn4Qss9T8+NyLJqEAvpQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxj48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9MQPf014333
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fxwgkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAZ0Am28050156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:35:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC88D20043;
 Mon, 12 Jan 2026 10:35:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4103F20040;
 Mon, 12 Jan 2026 10:34:59 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:34:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 05/10] hw/ppc: pnv_adu.c added vmstate support
Date: Mon, 12 Jan 2026 16:04:28 +0530
Message-ID: <20260112103433.8451-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b3Zi_md8HjeNQ5OBW02icPfy-DeFHmgO
X-Proofpoint-ORIG-GUID: b3Zi_md8HjeNQ5OBW02icPfy-DeFHmgO
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6964ce5b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=CZX88_KXqTBcai1-icQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX2W0skiYEdpR+
 h9kni95G+wPmHjUfLlh67fq+IbzhG+mU8lobyC93oiP6AgZbHB4axoqnPBkS+ebW25cOcym3gWr
 s/7JXMFSI9dKUmMUEkmxy9qmehFYisJ20T+ZJlQj9TK9CNOPtvSh0ttBheOJOgHqiNSMhfK1lT5
 BL6iLOhcpe7RMQhXqovtYt39KnFjdW7h1c8pW4ABiWOUhixrIBCeIECp9EA8ULhBs1DAElhhrgJ
 sxEx9+hhjFvgj4fkHWA4exU8yW5ZZokoMhpJ3a825e4TjlwZAsIVPknnWqF7gFiRDeA3J4KlTpd
 cGI7MwrHnGijlaB2V07y0LzJhuABUpCSAVLQ9SBpqS8joLlcHUpRWr4ArBLqsBPJUDRLXkh3JHW
 TpKWfHMqKfTQRQHMJ1InD18WhIegDYbTw0Iaje7uGrz1AZJy1I1SWDCPcAtnzPZxqbNsY4lXHQi
 xvRPHzFTxBV1KVLyFDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

From: Caleb Schlossin <calebs@linux.ibm.com>

- Added vmstate support for ADU model

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260105160138.3242709-5-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv_adu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index d686bfa62d..f921a7bcbf 100644
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
2.52.0


