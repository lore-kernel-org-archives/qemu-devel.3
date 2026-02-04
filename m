Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079EEE95394
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbiZ-000368-8T; Wed, 04 Feb 2026 07:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vnbiV-000311-Gb; Wed, 04 Feb 2026 07:10:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vnbiS-0006SL-49; Wed, 04 Feb 2026 07:10:43 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6140pmlJ003717;
 Wed, 4 Feb 2026 12:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=4wP3ADpDbte4LHWzUFq2GdySrUAb
 tQeUBWNqVmykOw0=; b=m9yjyN5I+QOgOh2pnZYRzNDq5Jpwenx+W4MjTuJ7ELeD
 dpPgn4KkQHrFQ/qLCzCWfRZWnosH3VEfKmAu0mv4EW/wH5VlFIRR9mJxyHJ0Teap
 2gOEGAeawxXoqpmRyQFMXTN5/PhxH7S4JKBIYqaAcAVWGgrXorXXCqojkMtH7VIp
 JInQOfNzQ2YteiTP/6zbOh81nSW4iURY2qC/JGwqWoAx/xGpOsjcaiyzd0kBRZiO
 4l/Ui33apAQM3MlPRmRcErbbTVU2T1Pz9nd14QPHJ/XZ/FkL2zAqFlGLyo3OiLbp
 93bx4ixH6oi6LzVq+CvmYuxYHuZuBcHT00VM3Q1g7g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6ht6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 12:10:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6148BUmK004417;
 Wed, 4 Feb 2026 12:10:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjw1k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 12:10:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 614CASjn48234800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Feb 2026 12:10:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 692CE2004B;
 Wed,  4 Feb 2026 12:10:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED53220040;
 Wed,  4 Feb 2026 12:10:27 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.140.180])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Feb 2026 12:10:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 0/5] target/s390x: Implement DIVIDE TO INTEGER
Date: Wed,  4 Feb 2026 13:07:43 +0100
Message-ID: <20260204121026.645382-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 12lNg9GgScTw3i7HZbNuHsl6p9s05BA2
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69833738 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=D0ifgjCuRPeBIYmd6-IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 12lNg9GgScTw3i7HZbNuHsl6p9s05BA2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX8Gx1Q+KEQ6zF
 h/gXQp4S8cVNqlLSsa8z8gzyRAcFCXK8ohiUg4vmQ0Hi7KE3YLMPT56vhm4kJQdU9wfU9HkcrIy
 DZybHCHGeCFXWmZEV2hYkrAVLX0gGR3sXK64gvQWhEEIASGJ75a2Q1yxv2zzIKtlWvPpgzVyEX/
 vXQWXlPgcvfL7Jn+HxFEhEiCvLI636rDd3fbuqscnuRq6c5YbcEurJOTbuCrIQXNbBbeRNCly91
 Cz0F5xauWbG3hF6/9cQ+YCnZgdeR8Pm4iX/5lcaiJwkI37pEalioTkrPdqwcQgzUaw5mWbVkc44
 zW2MBORE3yhiAOdQ5G887IF/qQqtpNE/3z/veRypUUPFpGqkfYK0b2KF4sd4ZD9s4oH9y8sBCIi
 45LGV2yMMU0zA69Xdz7ObeYf5pOjwZKnkhJqcghzd3aQIimSD6xJOMtf28VWFF5EFRD9Tb0rDHF
 IEWoisrco29aDDsaFNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602040090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v3: https://lore.kernel.org/qemu-devel/20260129190902.196262-1-iii@linux.ibm.com/
v3 -> v4: Use parts_round_to_int_normal() (Richard).
          Drop saved_flags.
          Collect R-bs (Thomas, Richard).

v2: https://lore.kernel.org/qemu-devel/20260127153736.62730-1-iii@linux.ibm.com/
v2 -> v3: Use FloatParts64 (Richard).
          Improve "smallish" comment (Richard).
          Use parts_muladd_scalbn (Richard).
          Get rid of manual precision rounding (Richard).
          New patch: parts_round_to_int_normal() improvement.
          New 64-bit testcase for a fuzzer finding on one of the
          intermediate versions. I have to admit I did not put down and
          then forgot what exactly it was about, but it must be
          interesting, so I decided to keep it.

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
is an improvement for an FPU rounding helper, patch 4 is the
implementation.

Since the instruction is quite complex, I've extensively tested it
using a libFuzzer-based harness [1] that compares emulation with native
execution at ~15k exec/s. The tests (patch 5) use data generated
this way.

Best regards,
Ilya

[1] https://gitlab.com/iii-i/qemu/-/tags/iii/wip/fuzz-tcg/v2

Ilya Leoshkevich (5):
  target/s390x: Dump Floating-Point-Control Register
  target/s390x: Extract s390_get_bfp_rounding_mode()
  fpu: Restrict parts_round_to_int_normal to target precision
  target/s390x: Implement DIVIDE TO INTEGER
  tests/tcg/s390x: Test DIVIDE TO INTEGER

 fpu/softfloat-parts.c.inc           |   7 +-
 fpu/softfloat.c                     | 142 +++++++++++++++
 include/fpu/softfloat.h             |  11 ++
 target/s390x/cpu-dump.c             |   1 +
 target/s390x/helper.h               |   1 +
 target/s390x/tcg/fpu_helper.c       | 118 +++++++++----
 target/s390x/tcg/insn-data.h.inc    |   5 +-
 target/s390x/tcg/translate.c        |  26 +++
 tests/tcg/s390x/Makefile.target     |   5 +
 tests/tcg/s390x/divide-to-integer.c | 265 ++++++++++++++++++++++++++++
 10 files changed, 543 insertions(+), 38 deletions(-)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c

-- 
2.52.0


