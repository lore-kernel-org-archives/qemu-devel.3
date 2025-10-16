Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC11CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SGz-0002hf-1h; Thu, 16 Oct 2025 14:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGv-0002gn-RB; Thu, 16 Oct 2025 14:00:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGt-0002xA-2J; Thu, 16 Oct 2025 14:00:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHlaF5021029;
 Thu, 16 Oct 2025 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=2i2RhCKqFRenQ3FZbb3tjxQkLKL8
 OTsieKgsCKsKRIM=; b=s+CdOuOPbNEu72BGBtlTdUA+K0+1YByFXfeYtENRSCRn
 If3FvAoLLmuH5BIKCNSHQYy5NJvlqW73k0MHTNxEjAP+4piREKOkebGcPaD0d5U7
 +1Zrr+gcv9IzkNjumtc6zXZPqoxpG79oCMG4aQrfoCCuWkt4FzBrg8EfDl1q/t4H
 NNH6GDFDhk6LfkMIP15Fl+ZFJQHdhKC7qH3takfsXlRUeHNzVYXrVu77ljev8fyC
 FTjn45KJpTIPfzrSXBEPbbD2tTHDqUq2UUbMS/z/RPbu8V7Y+2HzU2u5+w72L7LG
 pymqC2n/irBLBI7aYRPtcyhO0NpMOutmyYg3g1On3g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0b5tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHx8hi015016;
 Thu, 16 Oct 2025 18:00:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjpwbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GI06OS61079884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 18:00:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83A5520088;
 Thu, 16 Oct 2025 18:00:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 352B820087;
 Thu, 16 Oct 2025 17:59:56 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 17:59:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 0/3] target/s390x: Fix missing clock-comparator interrupts
Date: Thu, 16 Oct 2025 19:58:29 +0200
Message-ID: <20251016175954.41153-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C_iunvi885oaNhfh6bUMv9_JeDPzqiq4
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f132a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=wulB5n37dczb7JW1nh8A:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXx2c5bvHkVB86
 7hdggPYxpbr4AzfbPQaEtc6zGpU1WtOLt6pBjX83zmTeOzhil3cBDLlO8vt4Arpte1DlalOuGmu
 GM9QFJrUNN0F4JZOZkPkpkyjOgrOPq5OmvsRJ1TH5NmllNXflv3ori9FGIMSzzLdVPSSNJrJbVD
 OJSmn6YsveU99V49mfkPS1pugJ7BD/1KJBJ7Xwf0QF7gHdOXSuj1UBc/vvMhSVDg0qrM8aCv2be
 qknX0XJFeEACMOSpTnQwyUr6L8T60QqqpInfVnOALM86nH1aixKtB+GUuA/T1PIyJVsVHrVCAbz
 pclNwr9/BeFAYAAZIGLKAeDM8JCzq8bD8VKdvSU7xenxz4Cvz4kCN8f9CsjjNiaKXewvo3gkyf5
 PHPt2O/NproSkeC/EEKpsyiwmFyYFQ==
X-Proofpoint-GUID: C_iunvi885oaNhfh6bUMv9_JeDPzqiq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
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

v3: https://lore.kernel.org/qemu-devel/20251016120928.22467-1-iii@linux.ibm.com/
v3 -> v4: Add a patch for the missing address generation affecting
          interrupts. Slightly adjust the test, keep Thomas' R-b.
          Add Thomas' R-b to the timer rearm fix.

v2: https://lore.kernel.org/qemu-devel/20251015142141.3238-1-iii@linux.ibm.com/
v2 -> v3: Rearm the timer on control register load (Thomas).
          Add Thomas' R-b to the test.

v1: https://lore.kernel.org/qemu-devel/20251014160743.398093-1-iii@linux.ibm.com/
v1 -> v2: Add Thomas' R-b.
          Cc: stable (Michael).
          Improve formatting, commit messages, and test (Ilya).

Hi,

While trying to reproduce [1], I found two bugs in the clock comparator
handling. This series fixes all three issues and adds a test.

[1] https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/

Best regards,
Ilya

Ilya Leoshkevich (4):
  target/s390x: Fix missing interrupts for small CKC values
  target/s390x: Fix missing clock-comparator interrupts after reset
  target/s390x: Use address generation for register branch targets
  tests/tcg/s390x: Test SET CLOCK COMPARATOR

 target/s390x/tcg/mem_helper.c           | 11 ++++-
 target/s390x/tcg/misc_helper.c          | 12 +++--
 target/s390x/tcg/translate.c            | 11 +++--
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 63 +++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/s390x/sckc.S

-- 
2.51.0


