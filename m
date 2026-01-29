Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2E2D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXOG-0003He-7o; Thu, 29 Jan 2026 14:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOE-0003HC-Cb; Thu, 29 Jan 2026 14:09:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOC-0003Ai-C4; Thu, 29 Jan 2026 14:09:14 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TF43NY024642;
 Thu, 29 Jan 2026 19:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=UYqidjxEPXGL2ppNz4uzhvp+dyo7
 WcJTtHAgqIMvINw=; b=NF4bcMxmeWbzLnAG8bRjuNXa0TNVLiCrp4OwClcUtqOo
 acqMho3q7v/0iY2HLUvDtAjyRWSCYm+9VpCInUiAjZV9jcOn7JGOuPOKALyYpLjZ
 oNY96p9hVWhZ4LlWMNTW4FsWSzB1Kq0Eec1j2flWs3GvkIqDSStrnGhKAumI8nhu
 /HzNOpvL0OtnJXVG6p8M0CWrXPGKw79gYJdoadBt03/dfwgk1LpYXQPuY5t/f0m5
 sxeNV1oBGMHama3jl/hs8Ab70oWrQClGYSfgjZ3qMdCEFLIibA0MYsWOwxJ1UiX4
 u6v77PQ8Js63vg3NEutQOaWVxsYEBn4viLo+UHHjBQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrttbge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TGHT70031037;
 Thu, 29 Jan 2026 19:09:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsuaum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TJ95kV41877838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 19:09:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEBA22004B;
 Thu, 29 Jan 2026 19:09:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 852D920040;
 Thu, 29 Jan 2026 19:09:04 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.137.8])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 19:09:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/5] target/s390x: Implement DIVIDE TO INTEGER
Date: Thu, 29 Jan 2026 19:57:20 +0100
Message-ID: <20260129190902.196262-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BgngIIsLR926kXBox9lEXov1dXRzv1Io
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697bb053 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8 a=D0ifgjCuRPeBIYmd6-IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BgngIIsLR926kXBox9lEXov1dXRzv1Io
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfXxu9xJRR5+/Hz
 kN/xzS6cefkyicuPLm6sIYnnr40ejofk1wrGQXuBeG+Nhb7aGNaQBzdM7AlbMi93b5payPw984p
 nYdhHVICLUzceBJH0ZVNlA4pOYRp0GYNxpoay0FyUUJCkAWUOMkv+gPhanZDXzlaIdk2r00piz+
 4RsQE/VYbIEhoWsfjPG5HinHhFOTGLcerh4stSZtVRL19VqQnFJUWhZCxvEzdfCgI4F4hFfMDp+
 PkiG6HZqfQsUxC3Zan0/LfuwzMqKPL219G68q3+UpO9g0Z5ys/RoQicvuIMPE95zqmObkzDnIjx
 +Mh+q0Qm4JAdt8Bjy4w7JfQbi4l1SJBkpdMgipEcC2bOiUu1o5d/ng5T+lTLZ+9ZC4JTlf0qdLg
 kh7swe8GAJe5kYrzH78eWnQLLOFOxzL/u1SXD5fcMcjYoUoiiPHNW0RkIM9pG7veGo2Xwix2usJ
 1EXsE+1pI7Ul46h5pvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290134
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

[1] https://github.com/iii-i/qemu/commits/iii/wip/fuzz-tcg-v1/

Ilya Leoshkevich (5):
  target/s390x: Dump Floating-Point-Control Register
  target/s390x: Extract s390_get_bfp_rounding_mode()
  fpu: Restrict parts_round_to_int_normal to target precision
  target/s390x: Implement DIVIDE TO INTEGER
  tests/tcg/s390x: Test DIVIDE TO INTEGER

 fpu/softfloat-parts.c.inc           |   7 +-
 fpu/softfloat.c                     | 144 +++++++++++++++
 include/fpu/softfloat.h             |  11 ++
 target/s390x/cpu-dump.c             |   1 +
 target/s390x/helper.h               |   1 +
 target/s390x/tcg/fpu_helper.c       | 118 +++++++++----
 target/s390x/tcg/insn-data.h.inc    |   5 +-
 target/s390x/tcg/translate.c        |  26 +++
 tests/tcg/s390x/Makefile.target     |   5 +
 tests/tcg/s390x/divide-to-integer.c | 265 ++++++++++++++++++++++++++++
 10 files changed, 545 insertions(+), 38 deletions(-)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c

-- 
2.52.0


