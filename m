Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0542C52D1D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAZJ-0007OL-Mp; Wed, 31 Jul 2024 10:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZAZG-00078K-4q
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:44:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZAZE-0004b8-Ly
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:44:41 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VCh7j9023626;
 Wed, 31 Jul 2024 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=ZPipbue8XEOy1ZXs7JMbjuMc+a
 yUzxlT8wDjLkWGgPg=; b=EXQ/ndaJiTpWCjU3jjpsqIV09kagtwAdqoC9ASD4eG
 9urtBlYHSjv7hnyB5LtRyV2TJtjQUeR3y/Hu/8iwQAUXZkIum1J8b3v9QHQirvzV
 Z3wkm70SSgEvKv08Ct3B88GFu7I9gPah7LCxaa6eeWkVp43ijXodR9b67NNmY2DO
 Z+2jubSMs1u2bkFDZ3FsMR7HC4cxIFKUDIUMenzQBLK+VA/Jt+H16roAbkeYwHXr
 U8haQLeowCB4ubbzvcPmkWW7GN4okSZhN9Hkmdgp+eu2cgydRi1O6zIAE/6Yl39g
 XveDBI6dqW/Oqc015a7WKp1knwCuGb9GpHfKfrpQF0DA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnbygf4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 14:44:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46VDIckn003773; Wed, 31 Jul 2024 14:44:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemkvp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 14:44:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VEiVp29634160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 14:44:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A61E02004E;
 Wed, 31 Jul 2024 14:44:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 421C92004B;
 Wed, 31 Jul 2024 14:44:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.89])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 14:44:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] bsd-user/x86_64/target_arch_thread.h: Align stack
Date: Wed, 31 Jul 2024 16:44:12 +0200
Message-ID: <20240731144428.5882-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Eu_dkaGhKDGPWp_JnrwbXXm1rHnl7J2X
X-Proofpoint-ORIG-GUID: Eu_dkaGhKDGPWp_JnrwbXXm1rHnl7J2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_09,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=958 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310103
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bsd-user qemu-x86_64 almost immediately dies with:

    qemu: 0x4002201a68: unhandled CPU exception 0xd - aborting

on FreeBSD 14.1-RELEASE. This is an instruction that requires
alignment:

    (gdb) x/i 0x4002201a68
       0x4002201a68:        movaps %xmm0,-0x40(%rbp)

and the argument is not aligned:

    (gdb) p/x env->regs[5]
    $1 = 0x822443b58

A quick experiment shows that the userspace entry point expects
misaligned rsp:

    (gdb) starti
    (gdb) p/x $rsp
    $1 = 0x7fffffffeaa8

Emulate this behavior in bsd-user.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/x86_64/target_arch_thread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/target_arch_thread.h
index 52c28906d6d..25233443c14 100644
--- a/bsd-user/x86_64/target_arch_thread.h
+++ b/bsd-user/x86_64/target_arch_thread.h
@@ -31,7 +31,7 @@ static inline void target_thread_init(struct target_pt_regs *regs,
     struct image_info *infop)
 {
     regs->rax = 0;
-    regs->rsp = infop->start_stack;
+    regs->rsp = (infop->start_stack & ~0xfUL) - 8;
     regs->rip = infop->entry;
     regs->rdi = infop->start_stack;
 }
-- 
2.45.2


