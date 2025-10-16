Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D02DCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SHC-0002o9-Kb; Thu, 16 Oct 2025 14:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SH8-0002lm-Mb; Thu, 16 Oct 2025 14:00:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGt-0002xQ-QH; Thu, 16 Oct 2025 14:00:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAm8tQ001407;
 Thu, 16 Oct 2025 18:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EzKm11nqW+trbGiKs
 GzK9znJG9oIvCByUzqEON3sMw8=; b=qokGfRVqbRwoBCFBNBqGCiF7oJLCYOoDk
 yEEzfdkuHiAKVjMYe37BQhw5SPEWHafhRIvnpQTN0DyVklsqC25Tg2Xn9L5PsXc+
 e4ZSPIOIffsdylWkf8yrTjLPmB6DBqz7tJOsl1f5fq5BfoANe4btsw6yD1LCTdA8
 maCYrXDVxiTv14gYa7aeTtCeSUAzEyrgQR0eEswroKTmFqd2lbFQLe5qkjkY3/HR
 RRFvZ8cF2O7Qvvmz7fab2Nb9vSmggpDwf4dxIUsxRVEH3LsFkZw7yGPEtEQONqMf
 sLAt9R2ucQ8E2gO6Df5m6ey65FAx6oDl0ct3tAWZdymD5yeEaoclQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp87a7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GGkX6f003663;
 Thu, 16 Oct 2025 18:00:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy7852-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GI08ge52232614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 18:00:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A203E20087;
 Thu, 16 Oct 2025 18:00:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 492D620082;
 Thu, 16 Oct 2025 18:00:08 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 18:00:08 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 4/4] tests/tcg/s390x: Test SET CLOCK COMPARATOR
Date: Thu, 16 Oct 2025 19:58:33 +0200
Message-ID: <20251016175954.41153-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175954.41153-1-iii@linux.ibm.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KXB9bjzdZtayiVzbU51xEFovoe5EPdjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX8FJsVv/bju33
 K0RIfZOiXC7yPiqgQum9rfbiSn7Fodzs94WXFSulMXN0CAgYX817BWb2Y6clSqJLJyanciYFldV
 qgquzkvYYbOXimIRXJYTayrUFwkGy5ZxRau+NWI3UrkOjEm5gpSQoBoYwQNRVvx2Tb5gsombbpl
 x7BoMqSdmS8YTl3DLdTqL9uVBtKcluP/QdEC3cwAXiMK+39oONBH60FeyNWmOo+yaOExQK7Zv6O
 ZzIlZCNM6oN6MLV6SLzPZn+CE88mLXdSaqRByCUN+BbEM7INTCW3u/HUzhiCPIZzuCb0YhFhuSs
 SGfPoYJZahsxO76Uim32uh+qdniBAFR/jxVovBGAc7p1Kt6YPy+yN2kNe0zqMStoR3fG9NnV310
 iSH3aGJc55YWJ5GphkvpOtzGyvQGIA==
X-Proofpoint-GUID: KXB9bjzdZtayiVzbU51xEFovoe5EPdjm
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f132ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=CSNLQJF5lyc3cYxs15YA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 63 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
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
index 00000000000..ecd64a3059e
--- /dev/null
+++ b/tests/tcg/s390x/sckc.S
@@ -0,0 +1,63 @@
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
+    .org 0x1d0
+pgm_new_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
+    .org 0x200                         /* lowcore padding */
+
+    .globl _start
+_start:
+    lpswe start31_psw
+_start31:
+    stctg %c0,%c0,c0
+    oi c0+6,8                          /* set clock-comparator subclass mask */
+    lctlg %c0,%c0,c0
+
+0:
+    brasl %r14,_f                      /* %r14's most significant bit is 1 */
+    jg 0b
+_f:
+    br %r14                            /* it must not end up in ext_old_psw */
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


