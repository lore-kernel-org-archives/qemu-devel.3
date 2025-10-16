Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84FCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mo0-0000kf-TC; Thu, 16 Oct 2025 08:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9Mnq-0000a0-5b; Thu, 16 Oct 2025 08:09:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9Mnj-0006yP-59; Thu, 16 Oct 2025 08:09:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA9Poj012327;
 Thu, 16 Oct 2025 12:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=CBA8QNOEHYuBUyfVHvdYeasAg2ZQOdtRszj9sMf+l
 D0=; b=qGYJh5ioHoCjqEeouaVZTBTi0l/g8ADyh64xQ41zkXF0Bee6qNcd5uS5s
 GQG2xdHaH4xLJQy4SUkyUfbgRUwfOhp/lO76+7TZ3mB5UTSELaQ9Oe5y1Qp00Ntr
 SCuKJ6DGS5wDMDRohGhSa7DmBrutCNvnLPh9C/VQrzJv+U9jYfHFya8bCyiLqTBG
 7kn1pMlR3uZMw4gV7/Xd1x9g9SDX7DubNbd/Q//kijPYD5pThX6GZCa5glrolcXC
 rxuXFKQk4tLL1IjkzqCEl8IEM0upWWq7Q0DScMEtkOQNIrfJOaYt4aUjiWPouvUD
 bc+VPZiJp10DUl0tYXpB2e11UtfPw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrhnbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:09:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAvNR5016756;
 Thu, 16 Oct 2025 12:09:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k5h5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:09:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GC9VL331064482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 12:09:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D595620175;
 Thu, 16 Oct 2025 12:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 674CA20174;
 Thu, 16 Oct 2025 12:09:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.71.186])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 12:09:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/3] target/s390x: Fix missing clock-comparator interrupts
Date: Thu, 16 Oct 2025 14:06:58 +0200
Message-ID: <20251016120928.22467-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f0e07e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wulB5n37dczb7JW1nh8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: pNGhjbj0GDT7Xd56en_r8_AukjsBqE3F
X-Proofpoint-ORIG-GUID: pNGhjbj0GDT7Xd56en_r8_AukjsBqE3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX49zMmf3IFLOZ
 QeQbsdg4NcNuCEuFSO6NbgNkvCACpTf9h35jHlvKpJ7sHYGqKQbDvh3xbHvdp+YfIm20WKkVN6h
 TFo4zKJgmRjc+McFWdom0fFOp9Z8T4necr5HA/nD6+eImbNbLCMRnIF4KozlGsq/zAM5wuNtTJE
 ekESPLrlpxsxdeN6SOmJOEkepmKX9fEi5zHQjvJHjKNvwqr0/YEyq98YFKVGB8cFb9AEidlOA2T
 oCqjkjrfoJ6/ydG7uFBIgmexYcZJd2Hf0TS30tZneS6j+a4tUZoT2GEOAgAPIqodPTOtiDImjPt
 ou0A+3UMZAOo2Dr6eSPxuExXXIqLI2DjocBfZIhvD4AfifBXUDfLXovWBwxYDbHjmmgtg4Ys7BC
 4lLtLUYwVnhRF7Iiua6ViVF3xc31hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

v2: https://lore.kernel.org/qemu-devel/20251015142141.3238-1-iii@linux.ibm.com/
v2 -> v3: Rearm the timer on control register load (Thomas).
          Add Thomas' R-b to the test.

v1: https://lore.kernel.org/qemu-devel/20251014160743.398093-1-iii@linux.ibm.com/
v1 -> v2: Add Thomas' R-b.
          Cc: stable (Michael).
          Improve formatting, commit messages, and test (Ilya).

Hi,

While trying to (so far unsuccessfully) reproduce [1], I found two bugs
in the clock comparator handling. This series fixes both and adds a
test.

[1] https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/

Best regards,
Ilya

Ilya Leoshkevich (3):
  target/s390x: Fix missing interrupts for small CKC values
  target/s390x: Fix missing clock-comparator interrupts after reset
  tests/tcg/s390x: Test SET CLOCK COMPARATOR

 target/s390x/tcg/mem_helper.c           | 11 ++++-
 target/s390x/tcg/misc_helper.c          | 12 ++++--
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 55 +++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/s390x/sckc.S

-- 
2.51.0


