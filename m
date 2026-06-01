Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B66DCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAaj-0006c1-CU; Mon, 01 Jun 2026 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAae-0006ZV-Vj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAac-0003po-Lc
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FjnON643123; Mon, 1 Jun 2026 21:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=cuHFRuPy3dX20eno4YHIsAJYeUBt
 VsZTsF19WyrZc+4=; b=AXVRVJshVNz57vrwNTsmYWl2r/OxCr0iIywqdfyuWSJj
 LjWPY9FEWmxmNPjK6UHhm7SZnrbPaRWDj2vMthTXCwpjoRLDx6n7ScsoK+ZVpchE
 GKjNrR/sp2IaPZiIS4seBeUJPvWxJ53wtCxLsnaGknJyHSk+u+0bC/VeOg0eFjKT
 mLOVs86zcKGjZrxpbpZrP779w2FZpMRGyeLNaLILU9+4VgjPN+sD2XrJeM8t3a69
 tKkfkXGkoOeftGH9zyxbtMVNZLMYyXSJJhnfE1tHC3S9vOKA0Pp7h+XEA++5bWob
 qUfasjeT8bfB/lH9IvCVgUeEQlTV15h1Czk9ik4QPg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4u29h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsAt9029552;
 Mon, 1 Jun 2026 21:54:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k09as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsOg31573706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CFC758064;
 Mon,  1 Jun 2026 21:54:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 372C65805A;
 Mon,  1 Jun 2026 21:54:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 00/16] Merge tpm 2026/06/01 v1
Date: Mon,  1 Jun 2026 17:53:53 -0400
Message-ID: <20260601215410.517009-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VkhpmpyQU2XprLHUZXnnKQizLU4IelPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX+JPX1c/jDjBy
 EL8PZVF7zAay6jzSTDtcmDZm5ph6OixyQE6J9O5lqBuNrajATZMIiXi/TMscewOUwMAfSRyWB8D
 GHHuR3cUsmNB08D8Ls0fDDACx9Axl1I2bhR8f/TWdRt0+LqFhxtE3OKGKhNRpBKfQ51cB6ypcrN
 Ch5m0QDtw8nUEVrciBqCzkaRsrT8VcQ/F5/16Gat0qu2jiyc+5T7IrSTom9S8d1E584mCV7/VEm
 m2hFNpak0pTepXilbt3oXOV2wiqde35uw/8yX4Mlu7HTHYZa03hjTDGcaoDyQH+5psLkvavHoG6
 UvD1cTrMNaueFS0IzLtV8LvUp8WsvJRY+qd1DePCecy4ZoTe3F/H6eosMSawnWV2qbMa37/8vAZ
 BmFeKf4OEPqfYwaXvI06De0+Rwdf5SQAf8QKhWpLa8nzJ3BDt5c1zpX3Sk6UZ74p2aO1KCRy4uB
 tSBY4LgaawxGUba1b+w==
X-Proofpoint-ORIG-GUID: VkhpmpyQU2XprLHUZXnnKQizLU4IelPK
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1dff93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=7QLFPpikYoFE6dhQGUcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The following changes since commit 5611a9268dae7b7ff99d478ed134052a9fc7e9f7:

  Merge tag 'pull-9p-20260601' of https://github.com/cschoenebeck/qemu into staging (2026-06-01 08:43:53 -0400)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2026-06-01-1

for you to fetch changes up to f0602ce389ccda0e8df35ccaec3c1024478a0b10:

  tpm_emulator: Disconnect if response exceeds negotiated buffer size (2026-06-01 19:44:39 +0000)

----------------------------------------------------------------

This series of patches

- Improves the buffer handling in the TPM emulator backend
- Implements chunking support for the TPM CRB device
- Adds support for saving & loading of VMSTATE_GBYTEARRAY 
- Adds a swtpm test for the TPM I2C device

----------------------------------------------------------------

Arun Menon (8):
  migration/vmstate: Add VMState support for GByteArray
  ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate outbuf
  hw/tpm: Add TPM CRB chunking fields
  hw/tpm: Refactor CRB_CTRL_START register access
  hw/tpm: Add internal buffer state for chunking
  hw/tpm: Implement TPM CRB chunking logic
  test/qtest: Add test for tpm crb chunking
  hw/tpm: Add support for VM migration with TPM CRB chunking

Stefan Berger (8):
  tests: Move TPM I2C bus read/write functions to common files
  tests: Have TPM I2C read/write functions take QTestState as first
    parameter
  tests: Convert string arrays to byte arrays
  tests: Rename id of tpmdev to tpm0
  tests: Check whether the I2C master flag is set
  tests: Add a TPM TIS I2C swtpm test
  tpm_emulator: Reject a buffer size different than what was requested
  tpm_emulator: Disconnect if response exceeds negotiated buffer size

 backends/tpm/tpm_emulator.c          |  35 +++-
 hw/core/machine.c                    |   2 +
 hw/tpm/tpm_crb.c                     | 253 +++++++++++++++++++++++++--
 include/hw/acpi/tpm.h                |   5 +-
 include/migration/vmstate.h          |  10 ++
 migration/vmstate-types.c            |  28 +++
 tests/qtest/meson.build              |   7 +-
 tests/qtest/qtest_aspeed.c           |   9 +-
 tests/qtest/tpm-crb-swtpm-test.c     |  10 ++
 tests/qtest/tpm-tests.c              |  34 ++--
 tests/qtest/tpm-tis-i2c-swtpm-test.c |  82 +++++++++
 tests/qtest/tpm-tis-i2c-test.c       | 221 ++++++++++-------------
 tests/qtest/tpm-tis-i2c-util.c       | 102 +++++++++++
 tests/qtest/tpm-tis-i2c-util.h       |  34 ++++
 tests/qtest/tpm-util.c               | 162 +++++++++++++----
 tests/qtest/tpm-util.h               |   5 +
 ui/vdagent.c                         |  13 +-
 17 files changed, 793 insertions(+), 219 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-i2c-swtpm-test.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.h

-- 
2.54.0


