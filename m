Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79A0CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhIO-0002mp-Fw; Tue, 12 May 2026 03:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHm-0002dF-13; Tue, 12 May 2026 03:12:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHh-0002kR-Gr; Tue, 12 May 2026 03:12:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK74u53187026; Tue, 12 May 2026 07:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fLZtxzPiE//1Grmg/
 9b6/lfDSHW7DBwxC8JordvpkLM=; b=FW6Li3lhI08Pzn4Szpu3e9jkDqSioRpfI
 ccLPg4QDbg0w7rPyLKFYFKU1ev7l7p7vkWscA9cYMIp3wOu1NHiPC1kOw/5YDt2A
 MMdsV3c8zO7wObAiRA0q+QUu7VZPywGcsNL9WRToe4GGW+ZS9cSVPt/j0YtIyYyk
 br5ia7gIWpiTGPN+JGkgy8EXhn+f/lpfD/mmJrykgG7wjrJvZ7qC3ruLptdVQIDb
 g5OEEzBGSYszseZV6nVHnd/iv7EFOT/WEbx7DVrYj5c9nTLepUJXeA48PiPucnas
 +rc8Cr3SUHDJGl7qOQZ1FTep+msErznPTYLymMKOhmNKt9FFSX2Fw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv59w0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:12:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C79NY0015801;
 Tue, 12 May 2026 07:12:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgj32c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:12:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64C7Buni14942588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 07:11:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFF162004B;
 Tue, 12 May 2026 07:11:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54FB520040;
 Tue, 12 May 2026 07:11:53 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 07:11:53 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH 6/6] MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support
Date: Tue, 12 May 2026 12:41:11 +0530
Message-ID: <20260512071112.9675-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a02d2c2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8
 a=VcH14TYERV92i4gI124A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: cObGPxUKHxuvu71j0orKDsyLCfRH_LKM
X-Proofpoint-GUID: xWivlGz2FkggdEksivLu6IcRzzXZRnzN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OCBTYWx0ZWRfX+CC6gRgpKoNA
 69nvhspeT20ikfQ2L/q2lQ/II5z4FdABYkUtQ/jW11Ijw4DbL1fmJeP8xEJd0LtdvR5ExKbF/i4
 T8imnEpc4TzQmr+v+Qr1YokK+Z9QLQhlcPIB1XA/HjHfUIesz3Wvz1Aowje9/xo3TI3n+u40k9b
 V4Lap0clFGNlVpEILCo2wnwoLcmKt0SN667yAMaUjRqMWv8ZwHtgczVxs5WBAJ0WLbrBHnwAWaz
 aHMSkUGVQ8vDWaLlj45e53jBSrXDp78+0rC9EPpys7Ig6sAMB3d71O18BAg+oyi8G8obkRRiXs/
 q7ASgMK+BCll8S464Xo2fIoxvPLzf8WXp59um1DUieoKM/+CIIgRhxsI4XD4Y7CZmrqHWYyFU9S
 sooUxxu2xbQhw5V9X7ZEp2NlMOk+6QOd9QBuK4iKgahn8vqFErh/LqqhcTEQdQLbVY+Lsj2x4+n
 mF5l9jaYaTNqvnOMjAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120068
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Add a dedicated MAINTAINERS entry for hw/ppc/spapr_pci_vfio_eeh.c,
which implements Extended Error Handling (EEH) support for VFIO-based
PCI devices on PowerPC sPAPR platforms.

EEH provides error detection, isolation, and recovery mechanisms for
PCI devices, allowing the system to handle and recover from hardware
errors without requiring a full system reboot.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..03a638cab1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1656,6 +1656,12 @@ F: tests/functional/ppc64/test_pseries.py
 F: tests/functional/ppc64/test_hv.py
 F: tests/functional/ppc64/test_tuxrun.py
 
+sPAPR PCI VFIO Extended Error handling (EEH)
+M: Narayana Murty <nnmlinux@linux.ibm.com>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ppc/spapr_pci_vfio_eeh.c
+
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Aditya Gupta <adityag@linux.ibm.com>
-- 
2.54.0


