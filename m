Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72343D2CDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 00:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3OpN-0004ib-0E; Tue, 22 Oct 2024 20:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3OpK-0004hX-8T; Tue, 22 Oct 2024 20:02:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3OpG-0004QI-UQ; Tue, 22 Oct 2024 20:02:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLo8p5016253;
 Wed, 23 Oct 2024 00:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vb77iz2g4XK9z4Nh2vB8sTCndJRm7Rm7jk/LWyDvk
 54=; b=De0S25mf2124TkiphU5gpMjj8XAMHFJTmy5PJKAaC65QUM3YDz/H9E/6/
 7d1dSdex1XqYN4Kw7cVlGKmyTVWor4SejXmdr2GYj0M8yfxb09h5Ubb1ik/f1YbZ
 GJ8R384PzHQUMoXI58Ojs8WzB0dAvl8PXAA/ryTWcg/0QX+oNxnlI2s56+3USglx
 qLISycIaN66OM1EP8W+sQYAr3yD+ld/7B3t98LaPc1OAfFQBTiBUHkKvfo7fGCSq
 ObhvAdoijxBe5WuPhbt0RniOcQNVxrSWQEfIxCVR/dpd3QfS4bbpKADM0NyqeBSB
 k2NeoHyn7/gPfpFkOKGxyI85D4THw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafrctu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:01:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MM8ZZZ014568;
 Wed, 23 Oct 2024 00:01:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7ray5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 00:01:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49N01oqP48169308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 00:01:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C6C12004D;
 Wed, 23 Oct 2024 00:01:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9282420040;
 Wed, 23 Oct 2024 00:01:49 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.26.72])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 00:01:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] target/s390x: Fix the floating-point multiply-and-add NaN
 rules
Date: Wed, 23 Oct 2024 01:59:17 +0200
Message-ID: <20241023000147.34035-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0oLTWlGPn0jf_9lBSeQhVFIIzLA0DFF6
X-Proofpoint-ORIG-GUID: 0oLTWlGPn0jf_9lBSeQhVFIIzLA0DFF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=666 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi,

Peter reported on IRC that FMA NaN handling was likely broken on s390x.
Patch 1 of this series fixes the issue, patch 2 adds a test. For the
sake of readability, the test sacrifices the 90-character line length
rule.

Best regards,
Ilya

Ilya Leoshkevich (2):
  target/s390x: Fix the floating-point multiply-and-add NaN rules
  tests/tcg/s390x: Add the floating-point multiply-and-add test

 fpu/softfloat-specialize.c.inc    |  19 +++
 target/s390x/tcg/fpu_helper.c     |   8 +-
 target/s390x/tcg/vec_fpu_helper.c |  12 +-
 tests/tcg/s390x/Makefile.target   |   5 +-
 tests/tcg/s390x/float.h           | 104 +++++++++++++
 tests/tcg/s390x/fma.c             | 233 ++++++++++++++++++++++++++++++
 tests/tcg/s390x/vfminmax.c        | 223 ++++++++++------------------
 7 files changed, 449 insertions(+), 155 deletions(-)
 create mode 100644 tests/tcg/s390x/float.h
 create mode 100644 tests/tcg/s390x/fma.c

-- 
2.47.0


