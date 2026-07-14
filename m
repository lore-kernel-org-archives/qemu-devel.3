Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3928C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiQJ-0002Qx-Io; Tue, 14 Jul 2026 15:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiQH-0002Pf-W8; Tue, 14 Jul 2026 15:04:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjiQF-0007x3-Pt; Tue, 14 Jul 2026 15:04:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGBoMu4104267; Tue, 14 Jul 2026 19:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TPYtOPt4p1s50mllt2Z40WMRwdQPphXE+nV77cLBD
 BU=; b=TIxbFh1UaGqhD4/8vVNas4al4Jl2I1kQyXV9uV1Qrn6j3/pqMejHhGem4
 BUDtzYOjPqOG6OJ1VtTPvEtnlbImffSKtb5Ex82MuOD3M3oIXqkoFs65ZY1sMY1H
 B59KIskg0Yyq2C24kYCEEF06ve4v4N5fOxnjJ7KT6xF1GmZRq/A9/ZmonfklYIQl
 oCIuoCs0lWxDPmF8FqGhUctOfkIHuy13/yNGn+g5Y7zyi6Wu2KGPnDypQ/9n4EAd
 Rob+6socffFCT/MaLwrFG1OHucueDBFHnNl8K+uUtOMr3wO5cavo0QfbcsSDgai2
 V2DILCz/zOYH3wMBOe/GUwJTa9hsw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv338dvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:03:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EInbIX007923;
 Tue, 14 Jul 2026 19:03:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhc79x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:03:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EJ3s6548955670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 19:03:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 894AA20049;
 Tue, 14 Jul 2026 19:03:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E78A20040;
 Tue, 14 Jul 2026 19:03:54 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 19:03:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] target/s390x: Fix DR/D INT64_MIN / -1 host crash
Date: Tue, 14 Jul 2026 21:02:39 +0200
Message-ID: <20260714190351.337923-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX+6BSC+sG8J/q
 zgEbUrb9VmsbC4PyRaDbCFWlSonGoqgfpjIk5ORb3pFjFHq8C52UTIrgas1OXcvAMlMonNadNjh
 s4bFXQy9xJxrFTmlY5Btc3jhSabFUQ4=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a56881f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=ErGMPq-Rduplk58_MoMA:9
X-Proofpoint-GUID: Ue2FTEst_5pTNPHAzlBCmxZ18CQqIwqZ
X-Proofpoint-ORIG-GUID: Ue2FTEst_5pTNPHAzlBCmxZ18CQqIwqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5MyBTYWx0ZWRfX60Frw3Wx6ZEz
 4g5P4bC4ST2gLVUlx80QM67naBEY5LxCRKuh1oY5W0Vc541gZpHgNAsHz4947F6uJ32b8qv5fEd
 Y6hoeiNCBqfuwqoajrBPp1BHM3fbCivAupCNcaHCq+KpLO5p9CUwOx5IjHVuMBSlvrw7IuOPxVT
 zDff+zIJV7Ny9eXQxx48MTKG3rLzovDqMT51tGGfFmltxu0/nt/VXb3kDbj/0lYGDddaYccabe2
 AUecaB6+/inoM3Lu7R4kJVSf/iQDgwsDwxEUbSuQmHDNysvOeFhC0fjf1WGDkKc4mi2LsGAgAmH
 YR1VFR7lu7d/ZGznamV9aSQIYlphYU9eqlehf7hWcbku/Af3jp9FvylYL318sw7Hv/TAOlCgRas
 QmzO+SHzXzLPEpghoo+HMerygcD/VimbCAqVWArr3AHcMpKGp0h6oQiPoUWhhTC8qTdGragxFNS
 xeFHdlAKSysz+gEbDxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140193
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Christian reported that INT64_MIN / -1 crashes the emulator itself
instead of the guest program. This series fixes the issue and adds a
test.

Best regards,
Ilya

Ilya Leoshkevich (2):
  target/s390x: Fix DR/D INT64_MIN / -1 host crash
  tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)

 target/s390x/tcg/int_helper.c |  3 ++-
 tests/tcg/s390x/div.c         | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.55.0


