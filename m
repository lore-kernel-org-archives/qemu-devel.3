Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF12C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbUW-0003DZ-1S; Tue, 14 Jul 2026 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbUU-0003CS-Gr; Tue, 14 Jul 2026 07:39:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbUS-0003jx-Ur; Tue, 14 Jul 2026 07:39:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6fkGV487869; Tue, 14 Jul 2026 11:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TRWsmXpdk5GBQkZaGWi3dDh0Zo+6fjCgdHSJK+5Jp
 WY=; b=iTkmiug38h+VVxWVW8LTjpAELoSDflZGWSbr0g37NX87VG5l3tv760z+Q
 OopyBRxmMtd6zuY8V7wjLJaiiKAvKBKbUAtfaqG+Dq5gKqWhPfV6MktSHoYay1Zv
 8EDKV1KEKk9eISz1IBsXW7Y6+glolDHzglqA1t5snKORSV7pHJtWXffIYz16SVRA
 VKtWX3p5y1ZIGC43HPENoohtZyrECdjgdfMZ0PMva5lUaJVAtzliDTmJKqr8QVlR
 ZXWU+Zhlr4Fo55fXJZiOunNnoVMwPeZ2DGCRJLe7E0v3HAp/bGDfSkopvjSFv+JJ
 Ha57H/Mimz1vyfhqE+MlBP/FP8/tw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a5d2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:39:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBYtPR008500;
 Tue, 14 Jul 2026 11:39:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy285g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 11:39:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EBdmOl62456242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 11:39:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C8202004D;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 199A220049;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.75.242]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 11:39:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Harald Freudenberger <freude@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] target/s390x: Make PRNO TRNG interruptible
Date: Tue, 14 Jul 2026 13:34:49 +0200
Message-ID: <20260714113946.275122-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNiBTYWx0ZWRfX50eTKoAiHh8l
 fGf8ZYdg6q1WPN4MaYsxc4wpPSdtI0PyxPE/1sffYdG80JVPiBiYYMfDDNkypNpU/kQcWCxkaQu
 l6pu00qgW7w9ekzm1+1wZ0D7TPT1+mY=
X-Proofpoint-GUID: BqdOTIaYGRw8hzrHzarwlqF2wau69A9p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNiBTYWx0ZWRfX/QJuB16zDmtr
 cazJktvvyNaxY5LZJr3L3FFeZntuy1xUVqk1Be6zQjPixv52h3jod/ZsH/55U4C32v9dPsMU4Tp
 WtEe+CXNv5log4QIDYyqjRbcNeFeE8b1j8P85oNCWPAw+Lu16+8W+xinx0RrJeYfFtQz/hIoEx/
 WZ4Dn3V2qyJ+pfAHAVqfqQ8QE9Sip8C9qTz+b1Cc+Oj9B2LtV7u6MWeP7787di3o1K6wwcrzOjN
 dSskQrj6ZweANqpCMIUcW5c3OQLDFkgsg57yamBeGLPIFOy7OyqiviSKUkeFBwp3WW7NMEvkKvb
 vdC3MEIEtpov8TL/096xA33NU8/HLi8ClYPwDHM8XTnbou64GHyGJGvk6uSZ8NHYAcCrTKC9Q2S
 LPRKjZRlwMYwU3IhrMm2/n1Qz9m3dqljS1EYBXchUlo6MuMiWrEDEKCDztYLczEywhUZGUBHN18
 fy9TFZW/p4E0o1LM4Cg==
X-Proofpoint-ORIG-GUID: BqdOTIaYGRw8hzrHzarwlqF2wau69A9p
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a562009 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9M258467kB8nMN-SsRoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Hi,

Christian has reported that one can make a TCG guest stuck by running
PRNO TRNG with a huge buffer. This series fixes this by making PRNO
TRNG always end after generating 16KB.

Patch 1 is the fix, patch 2 is the test.

Cc: Harald, because this may conflict with the CPACF series.

Best regards,
Ilya

Ilya Leoshkevich (2):
  target/s390x: Make PRNO TRNG interruptible
  tests/tcg/s390x: Test PRNO TRNG interruptibility

 target/s390x/tcg/crypto_helper.c | 25 +++++++++---
 tests/tcg/s390x/Makefile.target  |  1 +
 tests/tcg/s390x/prno-trng.c      | 67 ++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/s390x/prno-trng.c

-- 
2.55.0


