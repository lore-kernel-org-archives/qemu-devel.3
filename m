Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC6AD34088
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkl8i-0002Jd-9S; Tue, 27 Jan 2026 10:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8c-0002Av-Pb; Tue, 27 Jan 2026 10:37:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8W-00024R-Vv; Tue, 27 Jan 2026 10:37:51 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8197Q021671;
 Tue, 27 Jan 2026 15:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=IASbPgk1MeU0LfDQexVXRIxvfBaV
 5lpO59U42ceOzbw=; b=YP6yPgQlqC5UQtuIZBe9r0g27P+aEUowuQbKE5mvxtYS
 SCnjodj9vwbkujCeXXcY2v7kFNV5thtQOHs3k3bjsKEfEZdGNVid+wtzkgtvgo0b
 LxMiHlgOWE81diMWmydFEqqFXVzYDimNTHSzV5UQLTOtMiUXXqUvs5WvedrETvKp
 GA5s0KcaaPgs6x87M0fqQLXoGGPkjqQoyGavgQ9sR37FqHqb7flKafveKa4WsOo4
 OmYfeZiEup6bKzKe9qBBNHsFC6uOl0g/q2/7smIYIbyRRZIjtFaqfq5ZGu/Ezct+
 1bgZVfQIsbmPHOQENGRsPZhuLERBQY+DaGzhkOlgFA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x8cg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDnlEW026333;
 Tue, 27 Jan 2026 15:37:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk951v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RFbbqe37421334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 15:37:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A139220049;
 Tue, 27 Jan 2026 15:37:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4413A20040;
 Tue, 27 Jan 2026 15:37:37 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.80.246])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 15:37:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/4] target/s390x: Implement DIVIDE TO INTEGER
Date: Tue, 27 Jan 2026 16:31:41 +0100
Message-ID: <20260127153736.62730-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a5UeLxAXDZeYygPAEqsZlRCH2C0-njUK
X-Proofpoint-ORIG-GUID: a5UeLxAXDZeYygPAEqsZlRCH2C0-njUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX6r2TqpnhWniT
 IGEfBGQwldGCuhwOD9gexovEYNAwQz4APmri0qzBx/wOaxhmVnOBYaqi2YuJ/H8yJfnLykG9igH
 4F+URz1YPkytKOH2PiUjuH/i0nHOD4XpKpP3T8LebZ6Xxu3EYxNSGV2iw2Wk9zfQucCmn/AQmt8
 /MS4d4CU5eFWuo7VWsWbBxnPj0BqGDlrY+r6fro4NvZdw5mbs/tg/RCmjxNX78uF4QMcyxTA5OS
 LxQVezqKPdqXVsyPverAE64NIL3pqGIX3fY6keOmLXoXAmrqf6il6hFKibEy1V1xlmjO8Rf/BCb
 lgkL3pi6zMq6pyDAJcdBYmgpXEyvuamKq0Zys2sDd043pnenGqI96w/uz8g01ZVXebuEGfRjQyH
 yr0ZEFCzRK9vecPafg8T2yInx7+YsfxfMpdbTKETv6/rSBsOe48XRIs5DG+4OyEq4NVxV/3j3RF
 7ds+2P+KQKLNylt7Slg==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978dbc4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=IK1K9Dv8yIwDGoJOiUUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v1: https://lore.kernel.org/qemu-devel/20260121222116.713325-1-iii@linux.ibm.com/
v1 -> v2: Move the implementatation to fpu/ and rewrite using
          FloatParts (Richard). I can't say I particularly like the way
          it looks, but at least most macros are gone and it survives
          fuzzing.
          Explain why we need -O0 for the test (Alex).
          New patch: s390_get_bfp_rounding_mode().
          Add a few comments with calculation examples to the test.

Hi,

This series implements DIVIDE TO INTEGER instruction, which is
required to run LuaJIT.

Patch 1 is a debugging helper, patch 2 is a small refactoring, patch 3
is the implementation.

Since the instruction is quite complex, I've extensively tested it
using a libFuzzer-based harness [1] that compares emulation with native
execution at ~15k exec/s. The tests (patch 4) use data generated
this way.

Best regards,
Ilya

Ilya Leoshkevich (4):
  target/s390x: Dump Floating-Point-Control Register
  target/s390x: Extract s390_get_bfp_rounding_mode()
  target/s390x: Implement DIVIDE TO INTEGER
  tests/tcg/s390x: Test DIVIDE TO INTEGER

 fpu/softfloat.c                     | 158 ++++++++++++++++++
 include/fpu/softfloat.h             |  11 ++
 target/s390x/cpu-dump.c             |   1 +
 target/s390x/helper.h               |   1 +
 target/s390x/tcg/fpu_helper.c       | 118 ++++++++++----
 target/s390x/tcg/insn-data.h.inc    |   5 +-
 target/s390x/tcg/translate.c        |  26 +++
 tests/tcg/s390x/Makefile.target     |   5 +
 tests/tcg/s390x/divide-to-integer.c | 242 ++++++++++++++++++++++++++++
 9 files changed, 535 insertions(+), 32 deletions(-)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c

-- 
2.52.0


