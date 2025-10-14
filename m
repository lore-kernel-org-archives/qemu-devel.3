Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EC0CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hZC-0000JV-Ag; Tue, 14 Oct 2025 12:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8hZ8-0000IG-Uw; Tue, 14 Oct 2025 12:08:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8hZ6-0005BM-Rx; Tue, 14 Oct 2025 12:07:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E82qC0015706;
 Tue, 14 Oct 2025 16:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RqEaTGD44kyr1mqua
 1w6dAKaJJc+0MWxgwbHeGOuWd4=; b=aNfUC+2spPugoGIq5PqYt1rg+CgMSBvr0
 zfKEWxiGECJgnrG1Az0kZPEV2ubHxQuI6+FLitJ0BBnRV7/riFC/Esvs0aXpDJXV
 JTpu+Gcjjokm0+L5IA1jzVP62O/W707ToFE/qEt6l1I3uyTbJB46zlU0Fsre0OUh
 iQXWpw9jBM8tInzxbtK3bt1y7OvIzCkYKkRdoHUVkALxEe3qVSzxLWSqrN5RPVs9
 OAQs4RWHBRQR+Gm96lYJGR+ptZr7wWpfmWX1zxIxsD+MwFGvmWwsFyxl2nKZDqYO
 OsXJqS3nVmqP3ZpYBs467hOrhUM5rq4T8BEsv4lqniNIxPNbC4+3Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtyqt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:07:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFRi2b015028;
 Tue, 14 Oct 2025 16:07:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjbk4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:07:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59EG7mYl61014516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 16:07:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A60320117;
 Tue, 14 Oct 2025 16:07:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2594C20116;
 Tue, 14 Oct 2025 16:07:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.67.246])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Oct 2025 16:07:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] tests/tcg/s390x: Test SET CLOCK COMPARATOR
Date: Tue, 14 Oct 2025 18:05:15 +0200
Message-ID: <20251014160743.398093-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014160743.398093-1-iii@linux.ibm.com>
References: <20251014160743.398093-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dcVRObKYBl3B2A5GsTIhqx6uJ8qgl4N3
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ee7557 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GplkH8VCR8Vvap5QFYcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: dcVRObKYBl3B2A5GsTIhqx6uJ8qgl4N3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXxNHONrjQBEV1
 gwZqwHg6ad35ySxnHFOdCBfPVcFbObaUPYDlhu8RZqAapLqgBz+ynZclP9JIDDbdMKfMkDff99S
 a87V9yRBUGNYZXbc4EHVrKV1Oi0RxWjcDMp1f3PbVPsfCRcVOY+G6fUNdZH33coZ2yR8Y7Jq0zu
 TTB9u9SHaMu/fx5c3CkaqzIKqTO6khm8Oh588sxcuyt76YMzj/TPNB+HGz5ff9kAlpo1+HvpErg
 R1L16OZ8PFyJ33V/7mOJmbwMVgQmX4FRKRsLBboemaJypcQTRLuWPb1s30/uyAxOiPQrg5Utcx8
 VEYCrOv/hTLkCDk7ltp8xaRHR7j2RUOottImfZHS9bBNjWUC2PzWLZ5MkLzXUJrwnCX4dO4ij/6
 Xaw2yVTA+SKSiFFNv3x/kGC0g6lkvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 53 +++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
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
index 00000000000..0fadec0dd65
--- /dev/null
+++ b/tests/tcg/s390x/sckc.S
@@ -0,0 +1,53 @@
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
+0:
+    cghsi ext_counter,0x1000
+    jnz 0b
+    lpswe success_psw
+
+_ext:
+    stg %r0,ext_saved_r0
+
+    lg %r0,ext_counter
+    aghi %r0,1
+    stg %r0,ext_counter
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


