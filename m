Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092FDC02190
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduc9-0000JY-Ci; Fri, 31 Jan 2025 12:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tdubr-0000E0-Lb; Fri, 31 Jan 2025 12:15:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tdubp-00009r-T4; Fri, 31 Jan 2025 12:15:15 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VF1OLi012945;
 Fri, 31 Jan 2025 17:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=RJGFp2lPcJyiUdcrq+LsEo/sn5Lx
 ChSu/NtsePRZARE=; b=bzQQmFD1CiyjhdDAniQja75NmpYjcpJQOnLNUPUnhXnB
 ZWfJ20m/oe1EMxEOO+BxWk2yEihWBpGn+AcLCNP829/xQ3YZdZQGBl/vhnpCf8k3
 fWyWemCA0MU78jp2MG9q+PxQhvCQnZGSLHw4MV+W+ipvKDLU5dYIGLI2jB+eVb9Y
 wMWvIOSf3MTusfEcGZxCeTzxsYx7FDs2/PtQswrENtNlmfASg4rpetoedVNcNiad
 nTh2sCQrL7ZKErRT2nZcLi+WvpH/LGBBzL/uA3nzb+2UzkTR1awiskEVmVn45fti
 b8aGBX7SBp3d2wzxdXAej3EVs1aLoNHgK3cVMBk+Mg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44h0t00n8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 17:15:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VHBt2L011329;
 Fri, 31 Jan 2025 17:15:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44h0t00n8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 17:15:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGWwv8016133;
 Fri, 31 Jan 2025 17:15:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gfaucjgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 17:15:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50VHF3gp42991988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jan 2025 17:15:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 996AA20043;
 Fri, 31 Jan 2025 17:15:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A2B420040;
 Fri, 31 Jan 2025 17:15:02 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 31 Jan 2025 17:15:02 +0000 (GMT)
Subject: [PATCH] vfio/pci: Skip enabling INTx if the IRQ line is also
 unassgined
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: alex.williamson@redhat.com, clg@redhat.com
Cc: vaibhav@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sbhat@linux.ibm.com
Date: Fri, 31 Jan 2025 17:15:01 +0000
Message-ID: <173834353589.1880.3587671276264097972.stgit@linux.ibm.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E4AuL1GeJfP5Ggh50P16w311gPuSTnWm
X-Proofpoint-ORIG-GUID: wYur02Cmp1lChfuEiDF21C5LTfgZ0Tcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=722
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the PCI_INTERRUPT_PIN alone is checked before enabling
the INTx. Its also necessary to have the IRQ Lines assigned for
the INTx to work. So, check the PCI_INTERRUPT_LINE against 0xff
indicates no connection.

The problem was observed on Power10 systems which primarily use
MSI-X, and LSI lines are not connected on all devices under a
PCIe switch. In this configuration where the PIN is non-zero
but the LINE was 0xff, the VFIO_DEVICE_SET_IRQS was failing as
it was trying to map the irqfd for the LSI of the device.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/vfio/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab17a98ee5..69a519d143 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -264,12 +264,12 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
 static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
+    uint8_t line = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_LINE, 1);
     Error *err = NULL;
     int32_t fd;
     int ret;
 
-
-    if (!pin) {
+    if (!pin || (line == 0xFF)) {
         return true;
     }
 



