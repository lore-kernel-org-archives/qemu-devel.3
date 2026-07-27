Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEDBC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJrk-0004zt-4P; Mon, 27 Jul 2026 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrU-0004wn-2J; Mon, 27 Jul 2026 07:51:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrR-0003bY-Kw; Mon, 27 Jul 2026 07:51:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAIRon1921906; Mon, 27 Jul 2026 11:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cinOn7EZUswlo4m4E
 SBe3xqFp5wap0QF3wBx+OjvrGI=; b=sTa19WlvyAqVDrzYBs82M0xqpNpo1GSR8
 oXD4D6o3ZfEyJkAkQ5xNZ3L4TdV+tizRM28NDY3520dOCSdLb96glnLFAy1m7c2y
 Ez29ElygV00oD7UjhobupywobV8yHv+g8xlJPhfloa8fwNz4g8pkfn0XCY35zCJ2
 zYcmPvmRvYZPz7Df7uRW4ziwu+CIVmpWMv/dobyskXyuI1R5Ett6YyH0KV4gnQ2M
 m1vdhO0zAMNua8rbad8rIdS34GPMSgXVygfLRoG3BlZguIqS2pgJud4hYkhc4RwO
 qoicNGyPjwQPfOh0K/NPNqRpLcObsN0U9Rqr6MhXN7+YmHgLpRfyw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw77t5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBfJhL016262;
 Mon, 27 Jul 2026 11:51:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg510x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:51:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RBp2HJ31523480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 11:51:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87E305803F;
 Mon, 27 Jul 2026 11:51:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA3CD58056;
 Mon, 27 Jul 2026 11:50:59 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 11:50:59 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/5] s390x/ipl: validate num_comp against iplb length before
 iterating
Date: Mon, 27 Jul 2026 13:50:49 +0200
Message-ID: <20260727115052.24289-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727115052.24289-1-borntraeger@linux.ibm.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7krlJ-0RR7aSYbWViqpd66Hih9cmGFow
X-Proofpoint-ORIG-GUID: 7krlJ-0RR7aSYbWViqpd66Hih9cmGFow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXyOyOIC7K//E4
 jLUvQiTPqWdlWGbU+zbe2KAb6TTcJM7J25H1C0dQBRnt0nqAXopZQTStUPRTDZlM++g5IwkFhZU
 wsw4l45F9wCw5ZQrym4X59AlVoflklKnnN74w3u6vnpGP74M25rB1uEkcSlxeCKjFkBVkGwQZYy
 osircfqsZT7fdMkisosRhf/fo+mJFrLOemyces2Wv7S/B+lMdMvWInA6pl/yzKyZB0dPhdHrAxO
 rqiEDA308dFXUbPowfIrhs93qNnfkRJZYGgEhV50D6zbrxJeb5GjIiRZWEXS0/o96NIrYtscPTr
 EzXTRr9RnEkP//T4gjnaqVgDz5hG60sPHsTQkU5oh29Xgia7uRJFpBCJ74PX8OD7xR48Mx7DbgS
 uDJDkuyd6PEWgKcJOR+JN9yAdBkPwE4jJDG1SJe+0v2u+LAN+Xx6JFRWgFl598p2DJ0x4vTpYBY
 DllaY9PRRuabFEg3ttw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a674629 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=--xg8yz4SgT6yQT1UFEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXzUAS4Suk2KcY
 VwK8Qliw3ifypgUupez12auWVgth7hR7TQEnSQX25hM/Gsqa8jqspB2upxMFmOLdbfmAuiOYTxY
 67OlP2WRGmpqZ0FDReWYHUWY9fhQ9Fk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270116
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Joshua Daley <jdaley@linux.ibm.com>

In ipl_valid_pv_components(), the upper bound of the for loop,
ipib_pv->num_comp, is read from guest memory. Before iterating, verify
that its value will not cause a read beyond the end of the
IplParameterBlock.

Fixes: c3347ed0d2ee42a7 ("s390x: protvirt: Support unpack facility")
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/s390x/ipl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index fac30763df..ef9c063d90 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -124,6 +124,12 @@ static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
         return false;
     }
 
+    if (offsetof(IplParameterBlock, pv.components) +
+        ipib_pv->num_comp * sizeof(IPLBlockPVComp) >
+        be32_to_cpu(iplb->len)) {
+        return false;
+    }
+
     for (i = 0; i < ipib_pv->num_comp; i++) {
         /* Addr must be 4k aligned */
         if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
-- 
2.53.0


