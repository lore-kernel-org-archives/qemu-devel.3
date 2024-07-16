Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2151AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToId-0005Gz-6x; Tue, 16 Jul 2024 15:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIR-0004VU-9s; Tue, 16 Jul 2024 15:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIP-00069I-C6; Tue, 16 Jul 2024 15:57:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GJQ0Tg009550;
 Tue, 16 Jul 2024 19:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=jTIsUtgA10e4d
 IRpK43GBn9TNSPz6bDvYmR9PBXmyZs=; b=igiFxgOrGEU6vI2rPyaKEz8/amNs4
 S7zNC1qOLgqk0Lx4ctW2mQHMPKcfNdBnmtFl8VY6hX2OvagiouAh4LRFg78qrmla
 p6lC6aW2DPYN+ARZ5sD/kio0NtrIoSraY6j9/LhhRMEQv+8n9E9pmMSe6FYJnaRe
 g122TP53G0rcpZkyZ+eJau/f9Zs9jazS0ldUGdf1jXKIWuuAxyU/vNI8K9rYprSA
 2WRRn1fsFIXjltrrWu5GlfRqDpCs86BnaP5fNwN1PDDxq/UumS8Ox9Td3853G7Ou
 UYCx5QyWtip0WVyK7cDDql7OnTCVloAO3QsxXVJ1BAifbIaOp9ptETZzw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dx5xr58s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GJv5eT018881;
 Tue, 16 Jul 2024 19:57:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dx5xr58p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GHmvXU029210; Tue, 16 Jul 2024 19:57:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkj0gh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:57:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GJuw2e56033586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 19:57:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E9352004B;
 Tue, 16 Jul 2024 19:56:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1624120043;
 Tue, 16 Jul 2024 19:56:57 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 19:56:56 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 8/9] pnv/xive2: Fail VST entry address computation if table
 has no VSD
Date: Tue, 16 Jul 2024 14:56:32 -0500
Message-Id: <20240716195633.12679-9-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A7C3lpu3OYZlM9ZNy6Ai_Im1Gc0QrJPF
X-Proofpoint-ORIG-GUID: 3vALp6y67bltM8XXO6_Qf-t9dJwZC7BL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=794 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160144
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Fail VST entry address computation if firmware doesn't define a descriptor
for one of the Virtualization Structure Tables (VST), there's no point in
trying to compute the address of its entry.  Abort the operation and log
an error.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index dab4c169a4..9fe3ec9a67 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -244,6 +244,11 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
     }
 
     vsd = xive->vsds[type][blk];
+    if (vsd == 0) {
+        xive2_error(xive, "VST: vsd == 0 block id %d for VST %s %d !?",
+                   blk, info->name, idx);
+        return 0;
+    }
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
-- 
2.43.0


