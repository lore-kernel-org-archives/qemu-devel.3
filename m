Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3111C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 22:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVIgz-0008VB-Sp; Wed, 31 Jan 2024 17:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVIgu-0008TV-8s
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 17:04:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVIgq-0002iC-Bu
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 17:04:20 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VL8q9F022575; Wed, 31 Jan 2024 22:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=C0LuXU3HStt5FxTADOOZj3v2htHG109/FP22/FS2HgM=;
 b=DJM+MKAxEoG1RJYe6LcbBw6Pf7HzhV3TYt9VFg5uVMIt35dW9Ttxs0QlffyqJ2SU9XCY
 72Bp93UN9qfew3A2d345l4Wy22QHYMwqEYva7VV3RCQPONnty1he+8dv3EUvPumR07sF
 nccARmCrLVvSSjBd6/01HFeUBSBOzcJoySG8v9wSm2pDEouGvcsjspZ6T8zvj2qiQsb4
 WBdgrbBZE7upS8xXZeOzwVeXX70Pvwrl5obBFasUKt0p1foNxWiJsYQX3EDt8+/QbQ+r
 aIF9vKF4DRcYDBWJsqD43zqsAbco6d5n2lqqfCjCr0tVQB1dG3Qs8so62cLgfl8rWmwn 8Q== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vywv0s7qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 22:04:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VLt6T2007964; Wed, 31 Jan 2024 22:02:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnm7yc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 22:02:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VM2lcs8520324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 22:02:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 937A42006F;
 Wed, 31 Jan 2024 22:02:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 405D12006C;
 Wed, 31 Jan 2024 22:02:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 22:02:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg: Fix the /proc/self/mem probing in the PROT_NONE
 gdbstub test
Date: Wed, 31 Jan 2024 23:02:18 +0100
Message-ID: <20240131220245.235993-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dBcsbm3so-UVQZFoWU3_b2-zLGCBjlYY
X-Proofpoint-ORIG-GUID: dBcsbm3so-UVQZFoWU3_b2-zLGCBjlYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=614 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401310170
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The `if not probe_proc_self_mem` check never passes, because
probe_proc_self_mem is a function object, which is a truthy value.
Add parentheses in order to perform a function call.

Fixes: dc84d50a7f9b ("tests/tcg: Add the PROT_NONE gdbstub test")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index e829d3ebc5f..7e264589cb8 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -20,7 +20,7 @@ def probe_proc_self_mem():
 
 def run_test():
     """Run through the tests one by one"""
-    if not probe_proc_self_mem:
+    if not probe_proc_self_mem():
         print("SKIP: /proc/self/mem is not usable")
         exit(0)
     gdb.Breakpoint("break_here")
-- 
2.43.0


