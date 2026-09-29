Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFEEC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZmj-0005lZ-29; Tue, 29 Sep 2026 11:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmg-0005kB-LW; Tue, 29 Sep 2026 11:30:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmf-0007w3-3U; Tue, 29 Sep 2026 11:30:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5NUp2187763; Tue, 29 Sep 2026 15:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lKhXEN6KQfWMGVWgrDMA3hlJK6rYwC104f/n4uoyw
 10=; b=GSu5VE6A+ZY2e1lAH9gMQBBfk+ekO74K5li6mn75jfFGLDzKVsrZbFD78
 /+J+/irkP1ELr6xebKgplwXTYAEMaO762bubvN/ShCGUrdvRqIJV8N5Ul7bFTD/t
 VmOQfRURG/mIA3aPSragZNFhSrJBF4TW7pxQyDsfLto0+giO8mxL2AC8BwbXSV0X
 XWpX0aXt34asEPmwNiU9l/i+BSXMkUtMhb9SFRghNBSQ67g9QT3DAilW1F7YKp20
 DT89Fq0K7M1v2PLC4jUkAe/3i8p28OKV3GN2T00GE7mhA1WknE+DBqukrCuJle1T
 b+Pmq3AbhZYNMHo5UVTkyI4vMCkpg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr7sta-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF10nU1647411; Tue, 29 Sep 2026 15:30:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2ya30s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFUE1M17892060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:30:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4797058055;
 Tue, 29 Sep 2026 15:30:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80CBA58059;
 Tue, 29 Sep 2026 15:30:13 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:30:13 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] s390x/pci: some translation fixes
Date: Tue, 29 Sep 2026 11:30:09 -0400
Message-ID: <20260929153012.774530-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX8V7gDyHcD04E
 h3xWlwX/Ib2zmcV8ejLB5Tv0yOQ3BpFchEc6mvVN3mTOdlmwGngeWicVq1IuY8iXP4o9dJm/N7I
 OGXNS+LAj+8UVQSsoRKIDqIWVh1uZ0OtPVesJmPnk6ZiWrc8PxQkU0RsBVg/ekkLTmPHiOkS/kl
 /s5Tg10dZlGIdsTNAdjR5qT0jBW+GMe98MfLwppYTmRLLBA+rB+QXgKUKuIN+feKHXD1RZ+V38T
 e5Aj7vIlnxhbkxe3ps21O547HtRAbIcTA/fjCi6TBliSG0b6Pf7YnD/Q8gElcFOvLNGnmTxlFaE
 sWkHfDeJ5fERLYdlX/uXPpLlXjSKwkacpE/Uuyyv+ke6YsuPbRx/3yB0EzDQ9UI559vRXjG+GNS
 89qAUUU45zCnLa/nkH2LCqApKR0gVUGl3qHNJsqagod5mXXU9kmqqjZvu1XvLyitI6VqqjLMQ/r
 EYrH3NC5BfcutEIOBig==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbd987 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=XbGThKhIVj4Z1Gef3_UA:9
X-Proofpoint-ORIG-GUID: AuSphLcwi4OLbmm846kHcqcNFnHBcJiU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX1D8VQ/5/G+ka
 usYpVHuRpzdxCD20A1sT+dbFC9JJxnmphuCY6wnbitkwXRX4hAPd16/lIcMi7p7HlsZN93exV5b
 YyMNPFm/6R3XHT9GUcuo6k3MW8ixzzQ=
X-Proofpoint-GUID: AuSphLcwi4OLbmm846kHcqcNFnHBcJiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290060
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

While reviewing Konstantin's migration series, a few edge cases have
been identified in the existing code.  Let's tighten them up first.

Changes for v2:

- convert to QEMU_ALIGN_UP
- add newlines to qemu_log_mask
- drop qemu/error-report.h

Matthew Rosato (3):
  s390x/pci: Fix frame stepping in rpcit_service_call()
  s390x/pci: Use qemu_log_mask() for guest-triggered errors in
    reg_ioat()
  s390x/pci: Reject apertures beyond IOAT capacity in translation mode

 hw/s390x/s390-pci-inst.c        | 25 +++++++++++++++++++++----
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.55.0


