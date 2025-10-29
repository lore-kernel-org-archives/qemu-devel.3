Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BDBCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBW9-0006Lf-6b; Wed, 29 Oct 2025 15:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBW4-0006KK-SA; Wed, 29 Oct 2025 15:07:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBVx-0001Ok-Mi; Wed, 29 Oct 2025 15:07:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBhYaF025829;
 Wed, 29 Oct 2025 19:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=loruWgS67tZo9cCGhjtic8xIjCWocaotthBd0nsRn
 dI=; b=D57ytYMfjR0mNVH0aKA5qrXL5Mud1lKmOfJspQJa2D4/ek1jL/pECWYQE
 w6n2f8b06sYRIoQknilkoMhHRvmKGS2VdBzx42ZhmrqT1y23tF9mBeANWr2YUr+b
 1IK5kJW/VSQ7GXsCxJaj1ecSRdlow6hc9QjcTSFxBISoozFHHdu4bUkFV3M/rTWW
 xXRAFXi2np5jo3HtY2yMH3XpmPYc+ecbrCJKZmD442MVGgZUy/Wxce7zMANRWOOw
 ouxdrAxhIdbeC3CvGFoSd93yEQ+D5rcJGlhaNW6VdrNv2X720Ko46aKMQBLiMGtC
 u/Ruue3AvT+UTBXUbQvmSH60VZWeA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aamwx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TJ75TQ012706;
 Wed, 29 Oct 2025 19:07:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aamwx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGiqo1031682;
 Wed, 29 Oct 2025 19:07:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33w0516s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TJ71na15728920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 19:07:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A92720049;
 Wed, 29 Oct 2025 19:07:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5F9C20040;
 Wed, 29 Oct 2025 19:06:59 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 19:06:59 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: mahesh@linux.ibm.com, ganeshgr@linux.ibm.com
Subject: [RFC 0/4] ppc/spapr: Add support for RTAS PCI error injection on
 pseries
Date: Wed, 29 Oct 2025 10:06:14 -0500
Message-ID: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690265da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=5ZNKSiU7cXmCqaoduGUA:9
X-Proofpoint-ORIG-GUID: sXc8TGe58mxlcuU8-hK2FlpFzCxMOeQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXwPFU3rMToj0e
 3kuHGEWXSWsGPOda057KWblF7sy2KrM4JuUi5bJui/5gU+gOz+9TiqKEDqvWG2KlmvQJZ1YfFNP
 ccaWutVb8abply+tapMnhAzKU7VxWxoJY/FyIvEdjqspGgnN/2UaNH6TtZ2M+QBZsOssz5FuUvv
 bqVdCzn0NlGqwmgjdokcxnbycE7HQ/JkhsAYhZ/BIh0RbP2YwgoQeynqsxYDpb1HVRtdxiB/UZE
 3wU81P3SBpYX3HUldxHuxJndOabhv3OTtdRIV/Tldk8bJCT9mDN05+9vWLXJ8X9DlR3Qzw+pgZI
 k6q6q6W9XgHW38p93iidMQSAf2UpAGgQEYPBFahPd7j50sWnYs0V9CGq/tttjPS3/yUNerQoDKZ
 vk2GntVae7ITL+evw3ugtoiu0wgh+g==
X-Proofpoint-GUID: Hszcw84mYP8Mt2JdxVR0OcXdw_j3SHyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch series introduces RTAS-based PCI error injection infrastructure
for the QEMU pseries (sPAPR) platform. The goal is to enable QEMU to simulate
enhanced error handling (EEH) behavior for PCI devices using RTAS interfaces,
aligned with existing firmware (OPAL/RTAS) conventions on IBM Power systems.

The proposed implementation supports:

  - Backend error injection via VFIO for passthrough PCI devices
  - RTAS calls for injecting specific PCI errors (e.g., cache/TLB/bus errors)
  - Controlled access to error injection via open/close RTAS calls
  - Device Tree (DT) updates to advertise supported error injection tokens

This series tested on pseries host with kernel version v6.16.0-rc7

This series has been split into four self-contained patches for clarity:

Patch 1 introduces the VFIO error injection backend:
  - Adds 'spapr_phb_vfio_errinjct()' which injects EEH-like faults
  - Includes minimal enum definitions ('rtas_err_type', 'EEH_ERR_FUNC_...')
  - Introduces stub and headers to integrate with the PHB VFIO path

Patch 2 implements the 'ibm,errinjct' RTAS call handler:
  - Adds 'rtas_ibm_errinjct()' in spapr_pci.c
  - Handles parameter parsing, validation, and backend call dispatch
  - Registers the token in 'spapr_pci_rtas_init()'

Patch 3 adds support for session control:
  - Introduces 'ibm,open-errinjct' and 'ibm,close-errinjct' handlers
  - Tracks exclusive access using 'SpaprMachineState'
  - Provides useful RTAS return codes for access errors

Patch 4 updates the device tree:
  - Adds 'ibm,errinjct-tokens' under each PHB node
  - Lists supported tokens for guest firmware/userspace to query
  - Adds fallback blob support for token discovery


Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
Narayana Murty N (4):
  ppc/spapr: Add VFIO EEH error injection backend
  ppc/spapr: Add ibm,errinjct RTAS call handler
  ppc/spapr: Add support for 'ibm,open-errinjct' and
    'ibm,close-errinjct'
  ppc/spapr: Advertise RTAS error injection call support via FDT
    property

 include/hw/pci-host/spapr.h |   7 ++
 include/hw/ppc/spapr.h      |  56 ++++++++-
 hw/ppc/spapr.c              | 106 +++++++++++++++++
 hw/ppc/spapr_pci.c          | 220 ++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c     |  53 +++++++++
 5 files changed, 441 insertions(+), 1 deletion(-)

-- 
2.51.0


