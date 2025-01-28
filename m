Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B36C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 00:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcZEm-0003QM-KF; Mon, 27 Jan 2025 19:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tcZEk-0003P4-O1; Mon, 27 Jan 2025 19:13:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tcZEi-0006Ii-R1; Mon, 27 Jan 2025 19:13:50 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLITQl009850;
 Tue, 28 Jan 2025 00:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=SqAp5IFYYlhlEYRlsilgyI/9OY+vixvBN9P62f6XE
 xQ=; b=bjcxTtX882UaDEfZqv3erL23q5VL63u5YIslEZNgnykxxOwDj4X1fmryA
 VkNVVNbHv7Cm26wm8rsLL220tEC4soIg1VCCIcwXsvUmZ0xxEaLyOg1epnPxyqR2
 6BjOFDR3QnExmNYbTTptAEHNUzVeVc6N61iB/KFgneo1faRCIe1Kxv25N1hX9eah
 JE5lbx0Tx60+kGYw1fW178KcPS/zsMjpHuMkZPu/VWmkEoLoYVgpBnDkbYmi+Xy6
 1zxR8B0z4aoQTP3DLGY+LrFOi7Y+4Ix5RhAdD6Cuy8tl9FK2mc5jKC5tKvpI02K4
 /7uIRDQ8fs+BOXsQ56GhDqtKteWVg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e0yyd7t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 00:13:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50S0DhQZ014173;
 Tue, 28 Jan 2025 00:13:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e0yyd7t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 00:13:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RNmncP003924;
 Tue, 28 Jan 2025 00:13:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44da9s8wma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2025 00:13:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50S0DegC53608782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2025 00:13:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB27F20170;
 Tue, 28 Jan 2025 00:13:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58BB22016F;
 Tue, 28 Jan 2025 00:13:40 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.23.68])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2025 00:13:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Berthold Gunreben <azouhr@opensuse.org>,
 Sarah Kriesch <ada.lovelace@gmx.de>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/s390x: Fix MVC not always invalidating translation
 blocks
Date: Tue, 28 Jan 2025 01:12:42 +0100
Message-ID: <20250128001338.11474-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gna40URQCOuf9MRSxAKVADFywTMwLCKo
X-Proofpoint-ORIG-GUID: gLfGu02axKVXfpKMiNjRghna8Glu5n-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270188
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Node.js crashes in qemu-system-s390x with random SIGSEGVs / SIGILLs.

The v8 JIT used by Node.js can garbage collect and overwrite unused
code. Overwriting is performed by WritableJitAllocation::CopyCode(),
which ultimately calls memcpy(). For certain sizes, memcpy() uses the
MVC instruction.

QEMU implements MVC and other similar instructions using helpers. While
TCG store ops invalidate affected translation blocks automatically,
helpers must do this manually by calling probe_access_flags(). The MVC
helper does this using the access_prepare() -> access_prepare_nf() ->
s390_probe_access() -> probe_access_flags() call chain.

At the last step of this chain, the store size is replaced with 0. This
causes the probe_access_flags() -> notdirty_write() ->
tb_invalidate_phys_range_fast() chain to miss some translation blocks.

When this happens, QEMU executes a mix of old and new code. This
quickly leads to either a SIGSEGV or a SIGILL in case the old code
ends in the middle of a new instruction.

Fix by passing the true size.

Reported-by: Berthold Gunreben <azouhr@opensuse.org>
Cc: Sarah Kriesch <ada.lovelace@gmx.de>
Cc: qemu-stable@nongnu.org
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1235709
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 32717acb7d1..c6ab2901e5a 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -149,7 +149,7 @@ static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
                                     int mmu_idx, bool nonfault,
                                     void **phost, uintptr_t ra)
 {
-    int flags = probe_access_flags(env, addr, 0, access_type, mmu_idx,
+    int flags = probe_access_flags(env, addr, size, access_type, mmu_idx,
                                    nonfault, phost, ra);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
-- 
2.48.1


