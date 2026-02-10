Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D09EB271B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvTj-000614-8x; Tue, 10 Feb 2026 16:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTa-0005xx-GZ; Tue, 10 Feb 2026 16:40:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTY-0000Na-Pw; Tue, 10 Feb 2026 16:40:54 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AA74BU247099; Tue, 10 Feb 2026 21:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=S0A9I4tLQc3/8LGEgvl9eT15NuCK
 OA583ihe38JnFSI=; b=LQ0mHOyx4q1oOKujXjGHNcqXt+EwihsnJfxNaZXNqJnx
 OXyGwcREkXNXIFp3PhKnizK3LK6hvRuKhjz8wU7JeEjH13XptpuMinUw3sz0A4Xq
 OyOCeIeyNGaa2DEzxb1k/yuhHyFz/rtFxbTXSpgIoaW4wBLV9bL0PegCtMHjQAVV
 1uQQiY4CYjZeWtdDZ7c6beZHEY+9Y/q1BU+6M9q6ZbyyUEzZkINOZrguAhq10dsg
 lSSokToDgb83RjR5pV1VDT6ddwa6FPAWZgcFLeLGyvB5WybkEmhP6EnNNh/LMgkH
 qwAC+BbQKIRkPX6C4M5g52yT2oddo8nP2zLLhFNs5w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uv76f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AHYIQX008883;
 Tue, 10 Feb 2026 21:40:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ybbnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ALejGO30998916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 21:40:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE1342004B;
 Tue, 10 Feb 2026 21:40:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DEF220040;
 Tue, 10 Feb 2026 21:40:45 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.60.229])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 21:40:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 0/5] target/s390x: Implement DIVIDE TO INTEGER
Date: Tue, 10 Feb 2026 22:38:59 +0100
Message-ID: <20260210214044.1174699-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NiBTYWx0ZWRfXzh3WUEzoEM5E
 bsSKg09RlJav29krAdm/QprI+owUqoVwsxYRnG6Hn1WsdSVcmY1Up67zDT2JL/VtcY5yoUFh66L
 ePURSgnyuz4ETHLx0Ih6s2Lv3km0apREoc46KXBnkWa4ifs6CiWbsCak+R1jdEL+WXJ3I86RWb5
 X/EZqxERmYSao/Y19s+C6PHEMgRacA4Eo0K5TKupx5Ipc6dz6JF70MA7WLlYEp7SsZTUc6Z0nPN
 7dLf3T21ZaE2f/1gW3C6WB8vLb4xktxABZbWwX6BGLO6AGouUr+Eva0/EXzZvQATEFOaoPY01ST
 MbDdtBoOSqFmLoy6dZ1zMzmnIDvXrnaXjZsR3FNU4yVZkX3AwU57Prq1fC1WPZxKT2PY6vOCGPB
 l9+KbmnQ948x+2OvpUIrgC42vWvm2dwoCvCkf93j6xAqiaZ2L7+YDMTYUNW7Pf+Ekb6L0BZbtk0
 P6TPvC18NunvhaYlOdQ==
X-Proofpoint-ORIG-GUID: kGVfSDz3u5liXKPjd-c9dJV7sTGNrt4i
X-Proofpoint-GUID: kGVfSDz3u5liXKPjd-c9dJV7sTGNrt4i
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698ba5e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=D0ifgjCuRPeBIYmd6-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100176
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

v4: https://lore.kernel.org/qemu-devel/20260204121026.645382-1-iii@linux.ibm.com/
v4 -> v5: Restore "& 63" in 3/5, add a comment, drop R-b (Thomas).

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

 fpu/softfloat-parts.c.inc           |  12 +-
 fpu/softfloat.c                     | 142 +++++++++++++++
 include/fpu/softfloat.h             |  11 ++
 target/s390x/cpu-dump.c             |   1 +
 target/s390x/helper.h               |   1 +
 target/s390x/tcg/fpu_helper.c       | 118 +++++++++----
 target/s390x/tcg/insn-data.h.inc    |   5 +-
 target/s390x/tcg/translate.c        |  26 +++
 tests/tcg/s390x/Makefile.target     |   5 +
 tests/tcg/s390x/divide-to-integer.c | 265 ++++++++++++++++++++++++++++
 10 files changed, 548 insertions(+), 38 deletions(-)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c

-- 
2.52.0


