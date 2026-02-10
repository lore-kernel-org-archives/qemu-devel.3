Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11330EB271A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvTh-0005zr-5Y; Tue, 10 Feb 2026 16:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTa-0005xw-Bo; Tue, 10 Feb 2026 16:40:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTY-0000Nb-OI; Tue, 10 Feb 2026 16:40:54 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61ACM8vU868900; Tue, 10 Feb 2026 21:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WMMLBE
 nlB9senlYLt6cuRQlVO3rduv28qhpgXcZd+tQ=; b=lyIr9WPUOoG4QiUMx/CDbT
 hNxwaWw84xQ0lf4g/sORF4Sla86zlDbOJtMAxOT0/g5+MGOm92CGNe1/7TElu3mZ
 g00HklnlppTVw3MHjwR/gsqdWAwqVmiLQ63fDEQ9oyKLtSROmIRbEyjptsSOKuiI
 Dlkspa+AFa+g8HQSpuNJ5IOCetdsQN1zqM+n5qddQFyQJCd9VhDjg0PtJB6imyEs
 e2KOwZv36fr1QGsSd5d3yKyFcg7sVTQJQI9fido5wWEOn4fVusmwCmpBIV7BrLiB
 tJ0BGHRATcVYXOb4JRXhG4jXfPwBPewKdTGoyuAmphUCZfhWoTyTVEINRZm9rG0w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v45g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AJA96W001815;
 Tue, 10 Feb 2026 21:40:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je22yct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ALekaR18481548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 21:40:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C3982004D;
 Tue, 10 Feb 2026 21:40:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E25D820040;
 Tue, 10 Feb 2026 21:40:45 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.60.229])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 21:40:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 1/5] target/s390x: Dump Floating-Point-Control Register
Date: Tue, 10 Feb 2026 22:39:00 +0100
Message-ID: <20260210214044.1174699-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210214044.1174699-1-iii@linux.ibm.com>
References: <20260210214044.1174699-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZyhU6R11mS7vKJvzkMtWdsLC_6OHVSM
X-Proofpoint-ORIG-GUID: 4ZyhU6R11mS7vKJvzkMtWdsLC_6OHVSM
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698ba5e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=WEarJFB7UarLcg5xSFgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NiBTYWx0ZWRfX70QekL+DdPao
 bv+rFwmU2PfpjAY8snf+gtltMnr4tMxaVgxkLpp21P/a2pL6butexqYAK7ZCVbDm/e3C3OhxJ2+
 2LJc68ck9Oh+TlOj/NIvNNzgrZJg6IxcQ1r9V/mGMF6XQ1170rDhMOSw6wmaVDVszHNY/jm6ldP
 4/BN5AE55/PsDhx2jL6N2ubuj1JPT+/wyhpLmrcFOxn84kRbJNxrqD0kF/Se8g3qQwcVzppBs6J
 ucbMgLTSKvLIqg4Y0FLuMDZWkXS9rqf3ufEwtkKi15P9UsoQgQI7dhYM2ePb+vnMnxIsjLTCua6
 mwIn3CNcp2ESw3I8gQBn3WwOIzZuyv91aMjxmA6fFykBNsTyMvJc4W/LP5Wk4fcJ7Js1PdZwecQ
 +kcnGhMB45DO1AF2u6yeaSiwKCtt/XNC8pivT8sQeSB/qTrB7MSvfelToh3LsdJeA1hfruKitC+
 IBMB07IGdxuXoJ19zew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100176
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Knowing the value of this register is very useful for debugging
floating-point code.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/cpu-dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
index 869d3a4ad54..5b852928031 100644
--- a/target/s390x/cpu-dump.c
+++ b/target/s390x/cpu-dump.c
@@ -63,6 +63,7 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                              (i % 4) == 3 ? '\n' : ' ');
             }
         }
+        qemu_fprintf(f, "FPC=%08" PRIx32 "\n", env->fpc);
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.52.0


