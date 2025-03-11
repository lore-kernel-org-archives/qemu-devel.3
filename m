Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F108C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Lp-0002Dl-Fr; Tue, 11 Mar 2025 11:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1ts1LI-00021y-2H; Tue, 11 Mar 2025 11:16:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1ts1LF-0005Y4-P0; Tue, 11 Mar 2025 11:16:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCmQ2t001290;
 Tue, 11 Mar 2025 15:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vGKanFs/llgf5AvvC
 KwDpFDL2TMYbQ4sUcJ+mfE1oNg=; b=RAqn07QJWVG64mqsqqSADJuSOgSMO2Rtj
 kqNPRyH3THQAdyHvf6IwM3I+Gyav5Fg9hZTiq6Z6lr2RrMGUISHSM0NlfD68WRHb
 cyfuYVk63xf0FAtP4vrIILwvsWkSu8C9VXYbWUgz6XFQ4TkXLwPljGZGZelyOiFy
 y3M5HN6JwG0S10d1tIIdbpvoQhNVz5zJxQQksFZMTEk4pn0SRuWcClB/MmQVz5i2
 LVMqZYv1d7TJr7jdbkqs0sDaV4sCvnFTeZlga78CscUToxtVXtYpsjyxKm6ZGAcE
 +E9eqMK3Ry5BX8If/HtO2Zm7wi/+CL6RDtx4wlt/3iOT53uMNADrg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb3f6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 15:16:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEuDxV014024;
 Tue, 11 Mar 2025 15:16:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1vd9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 15:16:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52BFGKxd11272774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:16:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E045758058;
 Tue, 11 Mar 2025 15:16:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADF165805E;
 Tue, 11 Mar 2025 15:16:18 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.244.69])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Mar 2025 15:16:18 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v4 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
Date: Tue, 11 Mar 2025 11:16:12 -0400
Message-ID: <20250311151616.98244-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311151616.98244-1-rreyes@linux.ibm.com>
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ikw0dQ2jWXeW4WI2tUHg3qi-eiD-9BNq
X-Proofpoint-GUID: ikw0dQ2jWXeW4WI2tUHg3qi-eiD-9BNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=939
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to specify
an IRQ index for signaling that a change has been made to the guest's AP
configuration. This is a placeholder for QEMU patches that use this value
since it is a linux-headers update which includes changes that aren't
merged into the kernel. Linux-headers patches should be generated using
scripts/update-linux-headers.sh.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 linux-headers/linux/vfio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 1b5e254d6a..d0426b5ec0 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -671,6 +671,7 @@ enum {
  */
 enum {
 	VFIO_AP_REQ_IRQ_INDEX,
+	VFIO_AP_CFG_CHG_IRQ_INDEX,
 	VFIO_AP_NUM_IRQS
 };
 
-- 
2.48.1


