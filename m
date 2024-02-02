Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E7BC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvPw-0005Rr-IT; Fri, 02 Feb 2024 10:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPu-0005R5-5l
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPq-0006li-LC
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:20 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412EbLnA002317; Fri, 2 Feb 2024 15:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=dX6OAz56GcsfHGfTlCOxQc9W+Ow+S5BivmfYoD3O3dA=;
 b=MEWDs8V5i84lz1a1czZ0k2sOnslBowg8eleL/2hEl+e+1Q95uB3vEGmZ/t4cFVS3OEND
 dghuFXQ3L85h0wgh9vZt/75U77uOCIQkSzn4fTy3G1CdcJQIg+iCzYSqEYsK77tYeuzi
 8tIcEtLLMYwnnno1ncpMpFhVTQJp8E7P/dcjEGFgm7QLI5za+iHlkhqBEZoJ0kFCtuOn
 xE0SdUwhSC60IRfS90FZYIebEZIS7O24CJ+yQTwDnGCigwpzq7wLuDr2FsTYQcOaHpUn
 Exmo18AZvoD2v/rgWMWg67myq+Az95xP/Er/ICFUHy6em82Y37LZWqYD6LQ2c534A0VH Lw== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w10704r2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412CtDqb010833; Fri, 2 Feb 2024 15:25:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pc2dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412FP8SL7996084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 15:25:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F0052004E;
 Fri,  2 Feb 2024 15:25:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 697F720043;
 Fri,  2 Feb 2024 15:25:08 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 15:25:08 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/5] gdbstub: Implement catching syscalls
Date: Fri,  2 Feb 2024 16:23:42 +0100
Message-ID: <20240202152506.279476-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S3sYQCDh5vswcykvVZqMrDtHOgEP67ox
X-Proofpoint-ORIG-GUID: S3sYQCDh5vswcykvVZqMrDtHOgEP67ox
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=627 impostorscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02980.html
v2 -> v3: Simplify the catchpoint state by making "don't catch" a
          subset of "catch some".
          Factor out several prep patches;
          Don't use snprintf;
          Add some comments (Alex).

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02911.html
v1 -> v2: Avoid touching the system gdbstub.
          Advertise QCatchSyscalls+ only on Linux.

Hi,

I noticed that GDB's "catch syscall" does not work with qemu-user.
This series adds the missing bits in [1/2] and a test in [2/2].
I'm basing this on my other series, since it contains useful gdbstub
test refactorings.

Best regards,
Ilya

Ilya Leoshkevich (5):
  gdbstub: Expose TARGET_SIGTRAP in a target-agnostic way
  gdbstub: Allow specifying a reason in stop packets
  gdbstub: Add syscall entry/return hooks
  gdbstub: Implement catching syscalls
  tests/tcg: Add the syscall catchpoint gdbstub test

 gdbstub/gdbstub.c                             |   9 ++
 gdbstub/internals.h                           |   2 +
 gdbstub/user-target.c                         |   5 +
 gdbstub/user.c                                | 108 +++++++++++++++++-
 include/gdbstub/user.h                        |  29 ++++-
 include/user/syscall-trace.h                  |   7 +-
 tests/tcg/multiarch/Makefile.target           |  10 +-
 tests/tcg/multiarch/catch-syscalls.c          |  51 +++++++++
 tests/tcg/multiarch/gdbstub/catch-syscalls.py |  53 +++++++++
 9 files changed, 268 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

-- 
2.43.0


