Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88415C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmaz-0006NS-AZ; Mon, 06 Jul 2026 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmav-0006Mf-7N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmat-0002z2-4M
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FICY8611101; Mon, 6 Jul 2026 16:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8ss3E40EI0rdnZNYw
 r0CI94r9B9laz4ljhng878AcOM=; b=Ug2INCj3UZ0M5qAAz/UN3FVKXG7d8ZcQ9
 lKRIcwqWjWYw+NLxfrN4TFWWJO4Vin1/kazXpWhXdXtJgAGDIbT07HRK9uqhQoS/
 ZBWEqfMlEP5GVYs+ay92b/bHivUi7uxEb2353RsIIFAZOziKMgaAPzKcmjwCz3zz
 nxUcP3F26Cpii9d0WAdMubob/YXXtFegEY7HoOCm4ZB69Lhicu9JKEs/NwyZNLWV
 7R7Y9ytoBOfU3WhGLZ2umvj3Ijy26E1bK+ivebdqseN44TbG+JIteQXYEqE1s+jU
 6nmBWG52ueKzfCzheynyXuzUUg8raTd58dU2Rl6atyT996jGrHNHg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3jhvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666GnePA012929;
 Mon, 6 Jul 2026 16:54:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvxkkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666GsncT30278238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 16:54:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9834720040;
 Mon,  6 Jul 2026 16:54:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F54620043;
 Mon,  6 Jul 2026 16:54:49 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.23.52])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 16:54:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/3] Revert "tests/tcg: skip the vma-pthread test on CI"
Date: Mon,  6 Jul 2026 18:51:25 +0200
Message-ID: <20260706165445.57418-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706165445.57418-1-iii@linux.ibm.com>
References: <20260706165445.57418-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bdddc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MR-Jva-bgZzsNAeRGaEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX+sYkR9KsTOqo
 xaVd7PT9rVgv/+zaveTThbx2lCZ2I1BRBsAD/MF6sTVzzyl/cZRVCrw8rs9HQK5Lr0cCZF6Qezp
 6u0Y/pV8gmFqY2t0x4rq+rm8e4x/KjE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXyze3i9fhFwrL
 olG7vzKaob/PoQ6PSvDpvCJzgEgIuzvEhqTWh5CjU999j0YG3UcW8tIQxgbCXH9yVA77GMco6ul
 z2RUszI6Ker7/vIa8IO4jpNt4jyjVBzZPRpYhYPtq1rUgrmmLrDwOKSHQmjkOkZXg+LiaFO56pS
 nURnXaVaOHxQRed1NI2sUd4w078wBvqP86FVCg+cOzCY7SDl0LLVNepN0g8R/Awfve+r07jnCaK
 0rMA4undyIX8SFF1HKdPtu2/Nma/3Nvjbm6gPMOfYfnmQwg57DUshcRonDPKMmNA756enVb9kyD
 qvO/YX9N9qMqbabzoeaASw1TWRbwFO+aSjheXPQawHZsK7HdcjXfwfmly8x3O8I24X5MUa+8i5j
 188vhSc+13xXTp4t0khpGgu8CefPPrq/5umwwXyK8WDijwErPGPA8dqBf6V12yII5HYmiadMnwZ
 Gkvko4t08r0vZY1L1tg==
X-Proofpoint-ORIG-GUID: tXsNdLv-uI2uGb5-u1DrvYcJAePr6Lw4
X-Proofpoint-GUID: tXsNdLv-uI2uGb5-u1DrvYcJAePr6Lw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Now that the page_check_range() race condition is fixed, let
vma-pthread run on CI again.

This reverts commit 5842de51573fdbd7299ab4b33d64b7446cc07649.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 508149d57bd..ab4bf9c5d53 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -60,15 +60,6 @@ tb-link: LDFLAGS+=-lpthread
 # code to work around the compiler.
 sha1: CFLAGS+=-Wno-stringop-overread -Wno-unknown-warning-option
 
-# The vma-pthread seems very sensitive on gitlab and we currently
-# don't know if its exposing a real bug or the test is flaky.
-ifneq ($(GITLAB_CI),)
-run-vma-pthread: vma-pthread
-	$(call skip-test, $<, "flaky on CI?")
-run-plugin-vma-pthread-with-%: vma-pthread
-	$(call skip-test, $<, "flaky on CI?")
-endif
-
 run-test-mmap: test-mmap
 	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
 
-- 
2.54.0


