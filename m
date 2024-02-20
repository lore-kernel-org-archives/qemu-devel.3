Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D23CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLdB-0004AZ-Gb; Tue, 20 Feb 2024 03:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcd-0003IU-Iy; Tue, 20 Feb 2024 03:37:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcY-00058v-DI; Tue, 20 Feb 2024 03:37:01 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8RjQZ004996; Tue, 20 Feb 2024 08:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S9vqoazcrEdLeBpc4mGwKpGOENwIgnDDkIa+Dp2l8a8=;
 b=UVn1jqtQbiIDMwsD6+vH1m+4beGgChDlwl2/P1oXSN3l/fQc8q2x3xGi9R17TCdF0xWa
 VHN9UKbRtPSq56MwDfudcmYOvIqZMtbCuO6agsm9gNaua0hSIc5CuKr1YgzGDXX0T111
 R5JzOhRGDlLyrbF+G8cSw1+DoCmcaXHbKK35yu/CZmVnRRlTcqkJc09L0YvsbVL4SR9u
 aZ2EMJSJCZ3SiER7AjUOKBa/1V42tpKPJD1h7f2A/A3hsAeMRCMqS9fkwQazRltWsJ9J
 GLMO2NdpbSz1cLQSmKKzQbeWdLA/SkFR1ABW9wX/LqZmDI1QNiRW0T2zKjBBQHbhNyl7 GA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcrk989db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:54 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8S2GE006402;
 Tue, 20 Feb 2024 08:36:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcrk989d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K5uMe2009627; Tue, 20 Feb 2024 08:36:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p6xd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8al2R24380090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 987FB2004B;
 Tue, 20 Feb 2024 08:36:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2AB220040;
 Tue, 20 Feb 2024 08:36:45 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:45 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 15/15] spapr: nested: Set the PCR when logical PVR is set
Date: Tue, 20 Feb 2024 14:06:09 +0530
Message-Id: <20240220083609.748325-16-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fgyVWuxnZugjF2t0xy3lA50kpzNwELB1
X-Proofpoint-ORIG-GUID: VxSTjALgUp9AN-wzfUceKjsI6_me90F_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>

In APIv1, KVM L0 sets the PCR, while in the nested papr APIv2, this
doesn't work as the PCR can't be set via the guest state buffer; the
logical PVR is set via the GSB though.

This change sets the PCR whenever the logical PVR is set via the GSB.
Also, unlike the other registers, the value 1 in a defined bit in the
PCR makes the affected resources unavailable and the value 0 makes
them available. Hence, the PCR is set accordingly.

Signed-off-by: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_nested.h |  9 +++++++++
 hw/ppc/spapr_nested.c         | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index da918d2dd0..f67c721f53 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -229,6 +229,15 @@ typedef struct SpaprMachineStateNestedGuest {
 #define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
 #define GUEST_STATE_REQUEST_SET              0x2
 
+/* As per ISA v3.1B, following bits are reserved:
+ *      0:2
+ *      4:57  (ISA mentions bit 58 as well but it should be used for P10)
+ *      61:63 (hence, haven't included PCR bits for v2.06 and v2.05
+ *             in LOW BITS)
+ */
+#define PCR_LOW_BITS   (PCR_COMPAT_3_10 | PCR_COMPAT_3_00)
+#define HVMASK_PCR     ~PCR_LOW_BITS
+
 #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
     .id = (i),                                     \
     .size = (sz),                                  \
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 6e6a90616e..af8a482337 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -740,9 +740,11 @@ static void out_buf_min_size(void *a, void *b, bool set)
 
 static void copy_logical_pvr(void *a, void *b, bool set)
 {
+    SpaprMachineStateNestedGuest *guest;
     uint32_t *buf; /* 1 word */
     uint32_t *pvr_logical_ptr;
     uint32_t pvr_logical;
+    target_ulong pcr = 0;
 
     pvr_logical_ptr = a;
     buf = b;
@@ -755,6 +757,28 @@ static void copy_logical_pvr(void *a, void *b, bool set)
     pvr_logical = be32_to_cpu(buf[0]);
 
     *pvr_logical_ptr = pvr_logical;
+
+    if (*pvr_logical_ptr) {
+        switch (*pvr_logical_ptr) {
+            case CPU_POWERPC_LOGICAL_3_10:
+                pcr = PCR_COMPAT_3_10 | PCR_COMPAT_3_00;
+                break;
+            case CPU_POWERPC_LOGICAL_3_00:
+                pcr = PCR_COMPAT_3_00;
+                break;
+            default:
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "Could not set PCR for LPVR=0x%08x\n", *pvr_logical_ptr);
+                return;
+        }
+    }
+
+    guest = container_of(pvr_logical_ptr,
+                         struct SpaprMachineStateNestedGuest,
+                         pvr_logical);
+    for (int i = 0; i < guest->vcpus; i++) {
+        guest->vcpu[i].state.pcr = ~pcr | HVMASK_PCR;
+    }
 }
 
 static void copy_tb_offset(void *a, void *b, bool set)
-- 
2.39.3


