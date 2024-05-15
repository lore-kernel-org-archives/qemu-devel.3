Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33D3C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 11:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7D9k-0005vm-0V; Wed, 15 May 2024 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1s7D9O-0005qd-V2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 07:50:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1s7D9M-0008B0-TW
 for qemu-devel@nongnu.org; Wed, 15 May 2024 07:50:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FBkNEE018954
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 11:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ZjtsGKrHlpvY5GDQRIfldl9fuRL7iEFmkNMtkX4gWuE=;
 b=L6FjBg3RpLhVVpnH0NNckWNlSxz7LCnrY/zyc/uxGV3+B9fWnQ6yrtXNtEg0wJWYnh1w
 Igfii1uY8O/2mDAXtZbgeFuyDDEUkz3eBKa1Z79o9eY1BlaQmwalaVBLvDQsK4nMbpAY
 1XIUi8KAubjGcJ1Tn+etrCTJC9m0tr1rjEjLHL4VII780CMNQk7ZEh9tpiAzP6c6ZY1m
 Yg6p34DoGInpxP5jgbWilBWaYaffC56ffg84wRXrvGSTHQD3jmAS66Rru4GqdWgWYifB
 huoz1CrG4RR8byLouXLW3ZDSOhCVM6p5XZR3R+MfSqwcVSH+4n7LfO6gzMwDbKxLsgTX Sw== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4tv6g856-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 11:50:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44F8nspk006769
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 11:50:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmka5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 11:50:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44FBoFSZ52035914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 11:50:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C46EC2004B;
 Wed, 15 May 2024 11:50:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31A6B20043;
 Wed, 15 May 2024 11:50:15 +0000 (GMT)
Received: from ltcrain8ad-lp4.aus.stglabs.ibm.com (unknown [9.40.192.221])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 11:50:15 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH] ui/gtk-egl.c: fix build break
Date: Wed, 15 May 2024 06:50:05 -0500
Message-ID: <20240515115005.3553790-1-anushree.mathur@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3ZLSjaYRy97hhJfC3CPGAXS74hCg0xW1
X-Proofpoint-GUID: 3ZLSjaYRy97hhJfC3CPGAXS74hCg0xW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=640 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405150081
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Qemu build is failing due to an unused variable.
Removing it to fix the build break.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
---
 ui/gtk-egl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0473f689c9..3177992b91 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -70,7 +70,6 @@ void gd_egl_draw(VirtualConsole *vc)
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
     int ww, wh, ws;
-    int fence_fd;
 
     if (!vc->gfx.gls) {
         return;
-- 
2.45.0


