Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19981CA5FF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDstI-0005DR-AI; Mon, 05 Oct 2026 20:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsro-00040E-Gl; Mon, 05 Oct 2026 20:17:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrk-0001Il-9G; Mon, 05 Oct 2026 20:17:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695Ha00H1277040; Tue, 6 Oct 2026 00:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xX84bgeCv4cjrrG4+
 Qm8o+gpboq7e1y9GEnbKgQLq98=; b=rAnOXSCo64wakSIVSY8v8l3RUuyDurq/k
 /VrSFB2BGzadgYlzeBrnqNxJxlo86/fZSDnG3UGqwiCF+i7A+LkU7UBDnjMaPY8t
 OtZgW8r+yFONde5DZStr2hwmzMeQtS4q6tmFAkom1iLhFBgfFzN/Rh8xmgOiv8P1
 AI0N80UeHpD5uLr/0VgIw12DrtA2Ew7IUBzEoI+V3/DJChRI78NQvJxjKE7m/Q9M
 gUrU3BtypCHpHVPXMravQsgU7mizivVmjHOGZH86sv4n8vGdcTQ8BqGYMMafWisU
 f9QS9Fttrp3bM+CneiBmVmGdtGyQlIJLtKfVszoXJ0VydJrLA0R7w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv49dr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:17:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695M13ZB3252046; Tue, 6 Oct 2026 00:17:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy7gj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:17:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6960H3h933293042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 00:17:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8A2358043;
 Tue,  6 Oct 2026 00:17:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EFB558059;
 Tue,  6 Oct 2026 00:17:02 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.221])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 00:17:02 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v12 15/17] s390x/pci: Provide each zpci device with a unique
 stable bus "path"
Date: Mon,  5 Oct 2026 19:16:41 -0500
Message-Id: <20261006001643.420929-16-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006001643.420929-1-kshk@linux.ibm.com>
References: <20261006001643.420929-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iG-YYgQkvHJiNmBHEy0P4qgyQK5tbGtB
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac43e00 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FTiRxYJs2mcrdzry0IkA:9
X-Proofpoint-GUID: iG-YYgQkvHJiNmBHEy0P4qgyQK5tbGtB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX7Nrm/J90zOP3
 PWB9YcsAZ1epBbj6H+Xvy/FCOJ2XPW5TTzwgaJbJBy5+m6qcwalk1W57xMrFYu3s3RZ2Ep05k7m
 JBoVDImURUc/cuK8w0TQKlgH86nwhrw13fVqF6JlJfKlI/SwfP49EV4DlfzJeTgbUmXAGuB9G9y
 5lCEKNLTisQP79jhzJ/ppzbBMMgI1YpZ3tYPRDdXsyNkkHcyt/vieKptXNMSZBuFSRpryyxCFtr
 Rlgl8XZCGK0ndRUcfKutuy4ldETOl0BcO9j/0/wVSqFMleaj8gLrLwzcQfW384O/rkkgiWMO30S
 7oSl5S5bhKVbMjyRDevkHG2IrgbiDBr4jvEH8QCOxMb6zELb7ecyJvUINY8wbpKF49Bgre9PFkd
 p+WsODs2EmtMYaLlO/dRedE+27fFG0oGOhIH0lg4wWBvpaokqpygQbF+LkMevrvb9aiKH7hOjBs
 hlMWtpzfxGV/aumL3Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX++PWBIeh94j9
 6wf3iW4aoNLufDbQ+zunX38O0iUAWbOQeUfY1fVuSaOOtNO2x33XqiCQYb4ysq2xfwAKEtxxP1k
 EA7zQXECS8nb+HYTrjBMZYeptWnA6UQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is necessary for the follow-on migration support. The new unique
UID-based bus "path" is used as part of idstr in the migration stream,
making idstr unique and instance_id always 0.

For migration to succeed, (idstr+instance_id) must match those generated
during QEMU start. Without unique idstr, QEMU will generate variable
instance_id to distinguish devices, and that instance_id can change
if a device is unplugged and plugged back, preventing migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 799e596fec..7dff771ee6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1474,10 +1474,33 @@ static const TypeInfo s390_pcihost_info = {
     }
 };
 
+/* Return a unique bus "path" for zpci device */
+static char *s390_pci_bus_get_dev_path(DeviceState *dev)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    return g_strdup_printf("uid-%04x", pbdev->uid);
+}
+
+static void s390_pcibus_class_init(ObjectClass *oc, const void *data)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->get_dev_path = s390_pci_bus_get_dev_path;
+}
+
 static const TypeInfo s390_pcibus_info = {
     .name = TYPE_S390_PCI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(S390PCIBus),
+    /*
+     * Implement get_dev_path() to provide each zpci device with a unique
+     * stable UID-based bus "path". The "path" is used as part of idstr in the
+     * migration stream, making idstr unique and instance_id always 0.
+     * For migration to succeed, (idstr+instance_id) must match those generated
+     * during QEMU start. Without unique idstr, QEMU will generate variable
+     * instance_id to distinguish devices, and that instance_id can change
+     * if a device is unplugged and plugged back, preventing migration.
+     */
+    .class_init = s390_pcibus_class_init,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
-- 
2.34.1


