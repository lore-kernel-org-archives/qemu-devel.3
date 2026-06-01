Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E611CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAal-0006cp-4C; Mon, 01 Jun 2026 17:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAaj-0006bw-AL
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAag-0003rZ-MW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651GIFwK1890877; Mon, 1 Jun 2026 21:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0C388f
 SRG8hFxg+xzknLhBj/a1NA9X0niV07fs7p++8=; b=GpMnpMK7saP+9o815obeh8
 zLAuhqN3eNmXOQiwIdm5WXg3DdA9oN5ywkeIggerB7zTXQ0yeVr8W76ml4x9wqRc
 /vG+ujy4sC2C6+lYYQkbVeiMJyZSqi+6J9fKSSX7miTcDvSYhByzEdIHRhG1Xjn7
 ixJCIBI7AqyEO3NHp7prGo1JQyXfu+n7xxhaeMDvx6XbftUSJm26hQ2VUFQTiUJZ
 c1yyjVCTDkDYvDCP11tz8EgFfPbOBigABxbaXXl/X5UrlCV2iPE0ETPAUKBoc+Tl
 9MCb3pEMrpSNbktEpZ9B2o5y3fwAiJV+jM1uJ5nNzqaYF6R1KFVa8L0a//LnsSgQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd434hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsMun020935;
 Mon, 1 Jun 2026 21:54:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy7yc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsVRY20382256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9DC45805A;
 Mon,  1 Jun 2026 21:54:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FA7258054;
 Mon,  1 Jun 2026 21:54:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 09/16] hw/tpm: Add TPM CRB chunking fields
Date: Mon,  1 Jun 2026 17:54:02 -0400
Message-ID: <20260601215410.517009-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfXyZIhxanZvXv3
 WBrnVaypFcSNfqy0XS+vI/ndHl7s0QRqo1LXF5+I9wPMBRdB+m6W46cIu6xcovpphpQ+HCAxHQz
 eBzH7wEYO3nZnMpTkRJsXYah+XVAN3GAr8ySlSJbEmAZuQ+KzbZ7er4gGbhoFfw3LOHDQqWCVIW
 reXDViUOd/W3B/XWYteMFj8FOfu7McGAf+nwm2+UBFL5awoxbSlmpLE63OwMXGYu1jvso6FFlKQ
 qCz/DxZM2xs4or+A6fwYQDbBNgjugPte0zNHuwUMEverqwVescI2zT7S+J9MZSf0oJhridVMlh1
 xcYtaBxaRCthFZY8tUuIVTXCcPcpQHGdGukYEq81k1KsmcwWGDu/zZXfQUpFj+Me9DWhkg2IfPZ
 0XuRzWK9cnlSvkIxUS+pnJsJ73xzTihNoL8NmBmsQWf9USr2I8lcUtKtKRZxDxhmEMYVOMJbI4Q
 DyT5lBoK9XO5PBeS/OA==
X-Proofpoint-GUID: fZDf4ebIPF1r6mnMBdFdZcAcYI-CLn_g
X-Proofpoint-ORIG-GUID: fZDf4ebIPF1r6mnMBdFdZcAcYI-CLn_g
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1dff98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xt6ew7UTAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=VnEbsEd4Wcsep8Q3BYcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

- Add new fields to the CRB Interface Identifier and the CRB
  Control Start registers.
- CRB_CTRL_START now has 2 new settings, that can be toggled using the
  nextChunk and crbRspRetry bits.
- CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
  this revision of the specification. Refer to section 6.4.2.2 of [1]
- Add hw_compat global property called cap-chunk because the chunking
  feature is only supported for machine type 11.1 and higher.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260506075813.120781-2-armenon@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/machine.c     | 1 +
 hw/tpm/tpm_crb.c      | 6 ++++++
 include/hw/acpi/tpm.h | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f..00eb3432a7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
+    { "tpm-crb", "cap-chunk", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 02701ab948..bfa09c04cf 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -44,6 +44,8 @@ struct CRBState {
     size_t be_buffer_size;
 
     TPMPPI ppi;
+
+    bool cap_chunk;
 };
 typedef struct CRBState CRBState;
 
@@ -58,6 +60,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
 #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
 #define CRB_INTF_IF_SELECTOR_CRB 0b1
+#define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
 
@@ -227,6 +230,7 @@ static const VMStateDescription vmstate_tpm_crb = {
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
+    DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -258,6 +262,8 @@ static void tpm_crb_reset(void *dev)
                      CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBChunk, s->cap_chunk ? CRB_INTF_CAP_CRB_CHUNK : 0);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      RID, 0b0000);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 2ab186a745..782dc8212c 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -150,7 +150,7 @@ REG32(CRB_INTF_ID, 0x30)
   FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
   FIELD(CRB_INTF_ID, CapLocality, 8, 1)
   FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
-  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
+  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
   FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
   FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
   FIELD(CRB_INTF_ID, CapCRB, 14, 1)
@@ -169,6 +169,9 @@ REG32(CRB_CTRL_STS, 0x44)
   FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
 REG32(CRB_CTRL_CANCEL, 0x48)
 REG32(CRB_CTRL_START, 0x4C)
+  FIELD(CRB_CTRL_START, Start, 0, 1)
+  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
+  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
 REG32(CRB_INT_ENABLED, 0x50)
 REG32(CRB_INT_STS, 0x54)
 REG32(CRB_CTRL_CMD_SIZE, 0x58)
-- 
2.54.0


