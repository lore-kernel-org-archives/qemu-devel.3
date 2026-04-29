Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820C7FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rY-0004FB-Ak; Wed, 29 Apr 2026 08:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rV-0004En-5P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rT-0000nv-JZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T3F59k1895497; Wed, 29 Apr 2026 12:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+9Z4ukb/m3lvKut2QpYsrhyAF25IFKA5zi8QcSAmI
 ug=; b=a8w2j+TwzWUSQLXnGXigu3YlrWQ3hNF8oY+TSEovAzJxncQ3p6wrM6i5D
 Z1iNLjCPfyZlr6iIbX5u6DeKiuv01NwrlYgAYffl18YJIHJhKrukNTQxmxIrDG0G
 UYiF/zhX1ffbG9ckFZ+Ok20q+pHo1appQoECKrf/TPfTmCIzdPTiTGOiLbPSyNAr
 kI3AoF7YaligSRuUieyAKoUvxIw8V/AZ5L3fsn68oMxcR53qGb+mDNGsQ+mbkq9H
 zth5vxv7W5+PLvHOMOgUUkZEhnzMFJ75VWlMc/3678OnAD/p8UatUuWLh4S0iJF4
 hFUYAXZzhMvtaQ0xCJpvxF5m66p7A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e0ydn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TC8jj4031983;
 Wed, 29 Apr 2026 12:17:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqeare-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHmiV27656822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8FA358050;
 Wed, 29 Apr 2026 12:17:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3673F58056;
 Wed, 29 Apr 2026 12:17:48 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/6] Add test case for TPM over I2C with swtpm
Date: Wed, 29 Apr 2026 12:17:37 +0000
Message-ID: <20260429121743.1346635-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l1-751gKbn706hw_6i1jdWMnTtyNI8U5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfXxCOozmsC2P1U
 vDEedcVQy97qcttFKfV1cC4OCj53Gtz+AOb8kjPJevOcFAtMOESrxdlYFrhCZwYXDZWaGQRUxYQ
 p7o2EQcZj0BwrnSD7ufqtNtkaWe6kc36az94IUNFvPI5vRVmKyK40E6RdENngDlxBow5mr/zm70
 tWChqiha6sTU2DoQgqT0U46nA5VAkddTBLmediC6Q/WNQkfR0BcEEzsg6dVhy9WTyEAM2wKOe03
 KnhP/vKSFnixnMfnXQ7o3NPOobmeuTw+y0xu2tfFjhySbS/JNYaAOV40qBApby4qmJmIaT6bZjm
 /ahogFSfAA0tRALg4g0QOAaOKVLB7H0m1b6iV+DNXhObvq9djyoJkr5mNi068q7QqTUcDSsxjN2
 ubg2IrQH+LAVaNlz1Ks44gqT7GYAHtZNQBMpo2TGIFQFxieBFdo0CCefwjnTnl60ZOjrMSNEDau
 gdL7mXrdqc7dywcnYDA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f1f6ee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=WTSeslsn95BALrEyGCwA:9
X-Proofpoint-GUID: l1-751gKbn706hw_6i1jdWMnTtyNI8U5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This series adds a test case for TPM over I2C with external swtpm. It is
based on existing test cases for the TPM TIS and CRB. The first patches
refactor and fix some issues in exising code to prepare it for reuse by
the new test case.

   Stefan

v2: Addressed some issues pointed out by Arun

Stefan Berger (6):
  tests: Move TPM I2C bus read/write functions to common files
  tests: Have TPM I2C read/write functions take QTestState as first
    parameter
  tests: Convert string arrays to byte arrays
  tests: Rename id of tpmdev to tpm0
  tests: Check whether the I2C master flag is set
  tests: Add a TPM TIS I2C swtpm test

 tests/qtest/meson.build              |   7 +-
 tests/qtest/qtest_aspeed.c           |   9 +-
 tests/qtest/tpm-tests.c              |  34 +++--
 tests/qtest/tpm-tis-i2c-swtpm-test.c |  82 ++++++++++
 tests/qtest/tpm-tis-i2c-test.c       | 221 +++++++++++----------------
 tests/qtest/tpm-tis-i2c-util.c       | 102 +++++++++++++
 tests/qtest/tpm-tis-i2c-util.h       |  34 +++++
 tests/qtest/tpm-util.c               |  53 ++++---
 8 files changed, 373 insertions(+), 169 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-i2c-swtpm-test.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.h

-- 
2.43.0


