Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16127C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFIe-0007B6-HH; Thu, 21 Mar 2024 06:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFIA-00070R-J9; Thu, 21 Mar 2024 06:04:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI8-0007Yq-VO; Thu, 21 Mar 2024 06:04:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L8xBGN027838; Thu, 21 Mar 2024 10:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uANCeZgXqXhB6w96wEupYPLK13hQ3ZQrNGy4uOq33DY=;
 b=XpZ5dhfoqNCGebqyDNZ4iWUNPyISH2v4+shEhQ70BSGAHUPCJgpTjnbCD9WVLFNjXDK8
 Ul2D2ufWM8gx8ksks4dL9qAoQtW+toFTTCw7FDMfGJIrhFY3V1q3aBVQfjn0NOPfwXfu
 td6JitLI3bxPg+md3CxuVodz1ZnQ7L13JRZZhkHdtaOnHcHQ0HuVjWb59RaxUscBiZfe
 CqRnEavkIJjstaft8E2QJB4b79PDzScRqzLM8UTZMwJYnHpUgTtbRqcvOyNHz9CVdMC6
 a7FcnH2wauRnjduEtBFcCivgmS2dXaTAbr1yUspYZ7gaj4qhANHxHttprZEgBBoG7jWi qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0gc80bu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:43 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LA4h38003485;
 Thu, 21 Mar 2024 10:04:43 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0gc80bu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L7jC9T002779; Thu, 21 Mar 2024 10:04:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2uuae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42LA4cvP11600542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 10:04:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6655758066;
 Thu, 21 Mar 2024 10:04:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E937758069;
 Thu, 21 Mar 2024 10:04:37 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 10:04:37 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH 09/10] hw/pci: Set write-mask bits for PCIE Link-Control-2
 register
Date: Thu, 21 Mar 2024 05:04:21 -0500
Message-Id: <20240321100422.5347-10-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 21ry7I3VE5mL2z_iAwIHN4U05MC9bwCd
X-Proofpoint-GUID: 1YzBzkFti0jm5hOR5nyfSpxlHwfCy6V7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=773
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210069
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

PHB updates the register PCIE Link-Control-2.
Set the write-mask bits for TLS, ENTER_COMP, TX_MARGIN,
HASD, MOD_COMP, COMP_SOS and COMP_P_DE.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 hw/pci/pcie.c                             | 6 ++++++
 include/standard-headers/linux/pci_regs.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6..e3081f6b84 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -212,6 +212,12 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
 
     pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
 
+    pci_set_word(dev->wmask + pos + PCI_EXP_LNKCTL2,
+            PCI_EXP_LNKCTL2_TLS | PCI_EXP_LNKCTL2_ENTER_COMP |
+            PCI_EXP_LNKCTL2_TX_MARGIN | PCI_EXP_LNKCTL2_HASD |
+            PCI_EXP_LNKCTL2_MOD_COMP | PCI_EXP_LNKCTL2_COMP_SOS |
+            PCI_EXP_LNKCTL2_COMP_P_DE);
+
     if (dev->cap_present & QEMU_PCIE_EXTCAP_INIT) {
         /* read-only to behave like a 'NULL' Extended Capability Header */
         pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index a39193213f..f743defe91 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -694,6 +694,9 @@
 #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
+#define  PCI_EXP_LNKCTL2_MOD_COMP	0x0400 /* Enter Modified Compliance */
+#define  PCI_EXP_LNKCTL2_COMP_SOS	0x0800 /* Compliance SOS */
+#define  PCI_EXP_LNKCTL2_COMP_P_DE	0xF000 /* Compliance Preset/De-emphasis */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
 #define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
-- 
2.39.3


