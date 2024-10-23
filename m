Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57771D2CDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 00:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3PCX-0001xt-48; Tue, 22 Oct 2024 20:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3PCU-0001xk-S0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 20:26:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3PCR-0006tV-6t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 20:26:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0N3QE025218;
 Wed, 23 Oct 2024 00:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=zoUmU3zwpLxa4i9CBaxdXL5X/x3NF1kyMHd6KGx/Q
 Pc=; b=DfXF53WdZWqfDLs34+2Jue5U/dqVYZmI9QBcZoKufa9ohAAuPDiqzWTbF
 eYyvVjyac/22ye52l6x3DXFNP+kYLQA6L67Y/lB+Q6i0IXHfrFyMGin+fS7ma2yw
 FJqjZ5CgyQ3RuZ6TiDlbaEC8kwZejvg4TqX9t7NVULLd4YkNKg/xXisaSFVcJqA/
 I9Xtqworj4TBZRCJ0lt0dRS0tTcG+yxegT3Pfi9MqIAzCdECipsAdzRJq8UtepjH
 nNgUjsxaRSVQkdJIwvuwu2P3Sg9a6B7A80t9n6w1w4Xw6MdglPDrpSdy8eklFCq2
 Tzb9h86phYVDD+FC596pANcyl2TLw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaerehv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:26:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MM8ZRD014565;
 Wed, 23 Oct 2024 00:26:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7rdej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:26:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49N0Q1qX51970386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 00:26:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 425A220049;
 Wed, 23 Oct 2024 00:26:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D636E20040;
 Wed, 23 Oct 2024 00:26:00 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.26.72])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 00:26:00 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
Date: Wed, 23 Oct 2024 02:24:31 +0200
Message-ID: <20241023002558.34589-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0-5qhaM_zm-9f3EPUsjdoDuDqzuvgqS8
X-Proofpoint-ORIG-GUID: 0-5qhaM_zm-9f3EPUsjdoDuDqzuvgqS8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Running qemu-i386 on a system running with SELinux in enforcing mode
(more precisely: s390x trixie container on Fedora 40) fails with:

    qemu-i386: tests/tcg/i386-linux-user/sigreturn-sigmask: Unable to find a guest_base to satisfy all guest address mapping requirements
      00000000-ffffffff

The reason is that main() determines mmap_min_addr from
/proc/sys/vm/mmap_min_addr, but SELinux additionally defines
CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K, but,
in general, can be anything. There is no portable way to query its
value: /boot/config, /proc/config and /proc/config.gz are distro- and
environment-specific.

Once the identity map fails, the magnitude of guest_base does not
matter, so fix by starting the search from 1M or 1G.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2598
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
v1: https://lore.kernel.org/qemu-devel/20241021121820.483535-1-iii@linux.ibm.com/
v1 -> v2: Start looking for a suitable hole from a higher address,
          instead of falling back to probing (Richard).

 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6cef8db3b53..d6ad77d27dc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2898,7 +2898,7 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
 static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
                                 uintptr_t align, uintptr_t brk)
 {
-    uintptr_t last = mmap_min_addr;
+    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
     uintptr_t base, skip;
 
     while (true) {
-- 
2.47.0


