Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24098D43358
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 22:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTorE-0007sV-Ek; Thu, 11 Dec 2025 17:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTorC-0007pt-GA; Thu, 11 Dec 2025 17:09:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vTorA-0000sc-U7; Thu, 11 Dec 2025 17:09:54 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBEHnvZ011122;
 Thu, 11 Dec 2025 22:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SdpLhz4gBnLtduL7C
 2cApbMmBpkEcgrEWxtX6bGA2eU=; b=J/H1d+TyL3UtTQpdEca0Ookuj0VBjDMfH
 smGJp2mffs4/LPi4LQS8EH+wimlCt20XJ4p4YeLnLdJ+N1yqmDIkLfDVXfTooksY
 si8NXR3gsbmzKOF/FNbc3hzN4yQkRPSUpzwjyFikGnSrahgUgvNh1lbTKX9gHJ2f
 oEYNwZTeRb4D4o0TpI2B1x9cnKCs+69AxoRAzfv/rTDSqePDk7itxbiOwL1mNEWf
 FOkSdeltR57CG/IG5ZJwsO/uBcohJHs4brpk8x6G6txRaMm+8eIDEHU6GMrezA1L
 7GsWF+KAPLB7IfVlIkFd1PIR9XCdPK6ZIdKkH73/LEf8G8Tmkp9iw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61tb9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BBM5qPX030334;
 Thu, 11 Dec 2025 22:09:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61tb9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBLeGkg008472;
 Thu, 11 Dec 2025 22:09:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn8vdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 22:09:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BBM9kfc31785506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Dec 2025 22:09:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6846B58053;
 Thu, 11 Dec 2025 22:09:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA9658043;
 Thu, 11 Dec 2025 22:09:45 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Dec 2025 22:09:45 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH 4/6] hw/ppc: pnv_adu.c added vmstate support
Date: Thu, 11 Dec 2025 16:09:24 -0600
Message-ID: <20251211220926.2865972-5-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211220926.2865972-1-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX20nyzV7xHS7w
 e2u38o5X3iCdcn83uVEJW/KTNW9FS6SHVK8rQmEGsgkHiGyZrROkwIt/UpXTf/cRvxpj7UfKkK1
 5SX6Ob/ON2hqNMfMtOnp9T9dVqu1ErDdp/JRriuziSS7kVLgJ0gb4iTPvHHNi1Gi6LA6MYZamKz
 M4WO9t8d732zAIWSM7MDVrRb+dxVIeOxeOc7OLhDP9ioaR0O5dmCCaOqd3ZrE5eR/TFGJBNIaaG
 t3uBtS+kN0wZ58xdiuOyOjZAxWmMtuf/5dlHjvU8Kcj1tEq+llYcIueSc4Oby0UiCOwfZ9vThw4
 1gpp+nxHXr9RyOttB0kaFwpFv/JjOgnlP4AJhWLa049c2o6BPeR7jeBwu2f7YqlBE1jJNieJx4l
 AvaBDF8PwZsP5AxeaDwgO4AVvF5+Rg==
X-Proofpoint-GUID: K7h-JTgBBoe17lJ1G23fKYf7ot26yNYw
X-Proofpoint-ORIG-GUID: B0kwrDr_kQr6vwmzf3bnz_-G2Czro2wa
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=693b412d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=m8CB0cBNnUspx3rFgAQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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

Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
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


