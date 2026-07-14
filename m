Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F11C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgIo-00009M-HO; Tue, 14 Jul 2026 12:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIn-000098-D0; Tue, 14 Jul 2026 12:48:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIl-0000q0-UZ; Tue, 14 Jul 2026 12:48:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGC94R1814353; Tue, 14 Jul 2026 16:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VIDSt5fU3DSEhysEv
 B1jJNkKaAGODVMoBhuiHeN0TaE=; b=DA/aPTfisirwtK+jk0nMhZTG3hCNvwBkj
 OjUm4BSI7eEKB48IPPL9udImHlYqVuVYTyOsWFtlFnfmG2vh0UKSlY0UyLxQqO+n
 U2zO1wNZ4k1ne+LLPWEyn6Ph6yw0NaO+ipyXCW2pjN0GYr00Pj/jOPbRXFERGufQ
 ZauqQ+w6rNMEIvkzkdS0RvKhl5stJGvMEZMwPoWyDj2OfHA+O5YhoKH8DV03w9X+
 TRIZAkoNyo1oV6ut/+8vog1e/JHmGTJbGFMibJE/r1iW6x0qFnDX2WvcViaqGadD
 zus0HV9GoI8JqiKqg8ZXMdeHGey4jE60i8BQTKKqmzFa5n/ok98DQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt7asu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:48:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EGdW3H017179;
 Tue, 14 Jul 2026 16:48:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy3es3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:48:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EGm4an40436222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 16:48:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDED620043;
 Tue, 14 Jul 2026 16:48:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5895420040;
 Tue, 14 Jul 2026 16:48:02 +0000 (GMT)
Received: from shivang.com (unknown [9.124.218.131])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 16:48:02 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 mahesh@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 3/3] MAINTAINERS: add self as reviewer for PowerPC RAS
Date: Tue, 14 Jul 2026 22:17:44 +0530
Message-ID: <20260714164745.573141-4-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714164745.573141-1-shivangu@linux.ibm.com>
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LH_sNW1GKun87KAFziflK4Z8B9D75Sym
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfXxGoPcq4/cGlY
 EjMrnjzlG9EvITG2+oloOXyQ9TZmbNm0zo3Rlzu/wNp0MXg/EIIIq2aahrxk9sHPq3a4pYe+4Uc
 Ia7rPFfE51TBHVfmVR/1NtX98UKpTWs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfX21k0AEEglyBZ
 aTjON65C+k0PHp8Tgf8EeFm2OSg4k4gSxHwI3/0LDjy2Dtv+4dNbLhxEBJn175c04wRLVFTxuIT
 Bezid9s9UyZR73hWrrFNqlCSQh+ydUUPwBE+VJz1PdTYUWmcEbbChcM1zAqtFwsCMCv22eIZxDE
 EOkJvAzH8o0/brQZhfxf3ycVaZguHs9vB3VdEkh9f91YT90t5Lf8FKO/bdtLqtAbfo1A4bGAy3/
 uIF2hf8Q7xf6NP0+jE/g2l+s5n+xaw4bBbyzo501quu8r3O+8KGQ5ef4UO5LHKZOA5lxx0h0o9q
 yT7Twd9elSNSNpke44fviyB27KM00OSJtzBMEJ4qt61bUbLmbp7ild+FMgP8uLP1QkeJE7T3QD7
 iYfn2TG22PKnDZFj4JX3uCTVAE11Fw3sZTx968k4+/li2VPJPQ4GhIBSxndR4Icvp3Ab0UNJATJ
 JhqvsRd9OCraXVXqOvw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a566849 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=WK6P9NOuF5wEigxtcgcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: ttIdjpSfNeF2gANwA9mYLV5wNA1ctFQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140173
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

I have been contributing to Fadump, MPIPL as well as PowerNV for quite
some time, and my daily work responsibilities includes taking care of
PowerPC RAS features. I, therefore would like to step up as a reviewer
to get notified of incoming changes in this area and help reviewing
them.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a010d4807..6bbb725ec2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1749,6 +1749,7 @@ PowerPC RAS (Reliability, Availability and Serviceability)
 M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
+R: Shivang Upadhyay <shivangu@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
-- 
2.54.0


