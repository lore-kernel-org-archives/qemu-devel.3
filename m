Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCB0C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigZz-0007Rc-4l; Wed, 21 Jan 2026 17:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vigZw-0007Ni-KN; Wed, 21 Jan 2026 17:21:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vigZu-0003hU-Kd; Wed, 21 Jan 2026 17:21:32 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LE0F8E006841;
 Wed, 21 Jan 2026 22:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lO5IkYqI6GAgpDqgIEy6w+Pm1IJFT3Ede156hkDDf
 QA=; b=pUZ7TMygPFBV9RYlt4FZ4FK++md3guXytWEq1x3DI+1F7LaNL0ecFcpRy
 NH/lR5qmJ1xM3uF6Q3p9rReCQ6Z1ZBe1fUvYrE47weNKuRvjKxGWpokmnsLjJuSz
 64MFNI8Rpjsb1fvqkBhWfkCgzcJqDbDho7PiuOqYmt86pHhDwTDOqreDY2hJXf4M
 ewis5FvSZ36s/WL/qtMu9uZAciwh0+hvV6IadsRU2Su9bra7Y77Glho2H6KWyVO9
 X7AIcpnzxBONkV/qqKwf/EJqJWWXDHKD4tvGuQefbz5Bl6fWKO8NgJLz8cnPU/1o
 XWIf6xNtzFruLb05OzbaZGllZxPoA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6tks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 22:21:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LLkpxt024575;
 Wed, 21 Jan 2026 22:21:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxarw579-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 22:21:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60LMLMHv36897246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jan 2026 22:21:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78CAB20043;
 Wed, 21 Jan 2026 22:21:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F18B620040;
 Wed, 21 Jan 2026 22:21:21 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.153.49])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jan 2026 22:21:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/3] target/s390x: Implement DIVIDE TO INTEGER
Date: Wed, 21 Jan 2026 23:12:30 +0100
Message-ID: <20260121222116.713325-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FAujaY_CGGNF21nyFPTETKGDSNrQ0u-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE4NyBTYWx0ZWRfX1duZe8F7WGDq
 jpPtfbcgIKjqs05htyxmaILRN++6vOqnpGJ/Qhh7UTMLv3P4zbc3hBzk8Dg+BLEGfgHhhKDWQ8a
 KtMbJEv+uz1sNPyW+pLFcoNUBzxzcaMUxR4PkSDdvDWnmx34jat4IDTQqPOLLZfhm5ZdxtDVB9e
 fnWp0YfqcXzkDoVCg1IFPWyWtVe9wqyyERYqo6bi5BN0vwbl+nMzgtNh8i4myIbTcIMfifZEuK3
 JuRz456p76CbHrKCA8BpH6S5vdkRBsOlwDRv6pqR3kYv0xCZmJX/V0VsbwlDe1nBfRd9QRED7jP
 YeTp8Qeygy1vZqmBg66MHKsloEo7U7wcPDkoK51pIGWIZZ5HHR4GaHNUs7lvWPj6/gB2TQfBqr2
 +hEk9EvfpE15eLBZhs//DQMhVhr1RcCaQr4iwmfZ3eXOE5fDRU/J0uKOJdUygwB21Cq8BgZzwGy
 2L3F+9Z39qewFYPR/JQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69715165 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=hAPbp5IQ8TBwi0d_fvwA:9
X-Proofpoint-ORIG-GUID: FAujaY_CGGNF21nyFPTETKGDSNrQ0u-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210187
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Hi,

This series implements DIVIDE TO INTEGER instruction, which is
required to run LuaJIT.

Patch 1 is a debugging helper. Patch 2 is the implementation.

Since the instruction is quite complex, I've extensively tested it
using a libFuzzer-based harness [1] that compares emulation with native
execution at ~15k exec/s. The tests (patch 3) use data generated
this way.

Best regards,
Ilya

[1] https://github.com/iii-i/qemu/commits/iii/wip/fuzz-tcg-v1/

Ilya Leoshkevich (3):
  target/s390x: Dump Floating-Point-Control Register
  target/s390x: Implement DIVIDE TO INTEGER
  tests/tcg/s390x: Test DIVIDE TO INTEGER

 target/s390x/cpu-dump.c             |   1 +
 target/s390x/helper.h               |   2 +
 target/s390x/tcg/fpu_helper.c       | 199 +++++++++++++++++++++++++
 target/s390x/tcg/insn-data.h.inc    |   5 +-
 target/s390x/tcg/translate.c        |  26 ++++
 tests/tcg/s390x/Makefile.target     |   3 +
 tests/tcg/s390x/divide-to-integer.c | 215 ++++++++++++++++++++++++++++
 7 files changed, 450 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/s390x/divide-to-integer.c

-- 
2.52.0


