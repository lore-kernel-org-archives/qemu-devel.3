Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C903CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92OQ-00022s-RG; Wed, 15 Oct 2025 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v92OB-0001yO-RU; Wed, 15 Oct 2025 10:22:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v92O5-0003Ey-4Q; Wed, 15 Oct 2025 10:22:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhIoV012462;
 Wed, 15 Oct 2025 14:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nl58wB/743+XYbyH/
 PRwPwx7180GhCodSAoKZ+9SPCM=; b=G0Cf3uB9k8eWwram6AoPCeo2I43m6jApn
 N3hplGX34rQkyEa36s51kHn0wlIciN3K5nwE8N6b7kWd4sXxQITjUhx4x8ALwNnQ
 9/yQmBfIgsIZQdC61WWwrc1CF+ENgfZ2xV6pRpW7PlxUUURQU/4CDO0+hLkv10MH
 zro5+YC0BwT1u+CKzTvatgoKUgoW7B4RgJuB1fCDW0BWC6vznE6Etvp7/QYnwPXd
 yCH0QjHFzFcjiWWXrLSt6kcYCl9WcIUAILfo/O4kD+MOMzvjEBu3Y2DQx7ecO8xz
 By0OXqt+pns632x82hJYtiCtCuQRDtEqQf56W90JqDURK2DDyoOaQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrcgj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 14:21:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FBq6So018348;
 Wed, 15 Oct 2025 14:21:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rfacrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 14:21:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59FELj3t24052190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 14:21:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A7EF20107;
 Wed, 15 Oct 2025 14:21:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDE7720104;
 Wed, 15 Oct 2025 14:21:44 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.134.59])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Oct 2025 14:21:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 3/3] tests/tcg/s390x: Test SET CLOCK COMPARATOR
Date: Wed, 15 Oct 2025 16:21:06 +0200
Message-ID: <20251015142141.3238-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015142141.3238-1-iii@linux.ibm.com>
References: <20251015142141.3238-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68efadfb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=o2U2niT9lMQTt7bDKj0A:9 a=Fg1AiH1G6rFz08G2ETeA:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Nbn5RUrsbMwOUv7SpwDBNgGRVodRQKAv
X-Proofpoint-ORIG-GUID: Nbn5RUrsbMwOUv7SpwDBNgGRVodRQKAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX39X0ggSbt5Pt
 VFSU/zCML/iXt/8b+tJpxRURGjshb8qimEuw38EX1f8N1NFipSDjgb1mNk5y25GyilKJ+Kggbly
 DctgA8xLez4XAoIK903MK3ItynomV6vxDZwIHfk4XLqODga07qdcu1Ts/2UIbS4RLZlpjVF5kqZ
 Jf5TJqwMjKmvwLK0WBqORXtmVjv5rkVENRhTRgfCUG8bgM1cooM88X8L+0Wj+OtAACXrDOHqQwN
 DMjzDuLwoTF/pCJtO37dNLykurhcfU9KakIU+msPbBtwFvhPpOUIYRWU7dtqSypu2ZlEqxpZHFn
 bZM8R6E0E9JJDb1vTBwWBU/rX37Puwha12pOIs0UqgVZZ+u/zUHCyNcgTn0kWUB/ebTIwC3Sw+S
 4wiSnB+PdYK4/YXGuI2CiJTAjIM4tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a small test to prevent regressions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 55 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 tests/tcg/s390x/sckc.S

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 8cd4667c63b..a4425d3184a 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -28,6 +28,7 @@ ASM_TESTS =                                                                    \
     mc                                                                         \
     per                                                                        \
     precise-smc-softmmu                                                        \
+    sckc                                                                       \
     ssm-early                                                                  \
     stosm-early                                                                \
     stpq                                                                       \
diff --git a/tests/tcg/s390x/sckc.S b/tests/tcg/s390x/sckc.S
new file mode 100644
index 00000000000..66e8733f45c
--- /dev/null
+++ b/tests/tcg/s390x/sckc.S
@@ -0,0 +1,55 @@
+/*
+ * Test clock comparator.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    .org 0x130
+ext_old_psw:
+    .org 0x1b0
+ext_new_psw:
+    .quad 0x180000000, _ext            /* 64-bit mode */
+    .org 0x200                         /* lowcore padding */
+
+    .globl _start
+_start:
+    lpswe start31_psw
+_start31:
+    stctg %c0,%c0,c0
+    oi c0+6,8                          /* set clock-comparator subclass mask */
+    lctlg %c0,%c0,c0
+    jg .
+
+_ext:
+    stg %r0,ext_saved_r0
+
+    lg %r0,ext_counter
+    aghi %r0,1
+    stg %r0,ext_counter
+
+    cgfi %r0,0x1000
+    jnz 0f
+    lpswe success_psw
+0:
+
+    stck clock
+    lg %r0,clock
+    agfi %r0,0x40000                   /* 64us * 0x1000 =~ 0.25s */
+    stg %r0,clock
+    sckc clock
+
+    lg %r0,ext_saved_r0
+    lpswe ext_old_psw
+
+    .align 8
+start31_psw:
+    .quad 0x100000080000000,_start31   /* EX, 31-bit mode */
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+c0:
+    .skip 8
+clock:
+    .quad 0
+ext_counter:
+    .quad 0
+ext_saved_r0:
+    .skip 8
-- 
2.51.0


