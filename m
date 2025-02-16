Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BB4C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 22:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjms1-0004C3-Gr; Sun, 16 Feb 2025 17:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tjmrz-0004BH-Tq; Sun, 16 Feb 2025 17:12:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tjmrx-000702-Uf; Sun, 16 Feb 2025 17:12:11 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GBOJi9018083;
 Sun, 16 Feb 2025 22:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=VY8/BPdFjwms9qmnzv8QEOliqZAEpwdknYSlY/SA2
 GU=; b=Ah1QrGuRpltU/aT9nC4Nsdu+Axq8cB8IOP92L5qxvGtULQBKC3tT1uxTr
 hlrb16z/63EkkVkP7RW2q4MFG5l19LLrMii+OV5IcwSZW24mPLXXnXp2jpWqSkzz
 c9VmVxEKarJKF92jpWpoX+Zrm6jpDl2owOo3nskbFuPx+DJNg8Z/OAU4JHoFH6+4
 F7gywC8k+cg3R8PSVPf2M0a02hP6XYaiIZRibO4UGHPjrl3xxdKlDF7ZnkVfbU53
 Sem6yQ2l/1Y/uerhdlaDiUmh2YjIzXi7xc6rNnrZYu3M0HzlwHm9Cl2omShxUovq
 7UlGytarldV3SRwA4vgfMH5n/50Ew==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44u639bda6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2025 22:12:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51GJHFOD013276;
 Sun, 16 Feb 2025 22:12:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkb3n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2025 22:12:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51GMC25S25690800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Feb 2025 22:12:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE05C58059;
 Sun, 16 Feb 2025 22:12:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 682E65804B;
 Sun, 16 Feb 2025 22:12:02 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 16 Feb 2025 22:12:02 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, dantan@linux.ibm.com
Subject: [PATCH v9 0/3] TPM TIS SPI Support
Date: Sun, 16 Feb 2025 16:11:52 -0600
Message-Id: <20250216221155.30013-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vPcvrNHunHYx4DwbSbuZwwdA04DqrHe3
X-Proofpoint-GUID: vPcvrNHunHYx4DwbSbuZwwdA04DqrHe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160202
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

*** BLURB HERE ***

Version 9 summary:
    1/3 tpm/tpm_tis_spi: Support TPM for SPI
        - rebased with the master, and conform with the latest
          device property definition
    3/3 tests/qtest/tpm: add unit test to tis-spi
        - remove unnecessary tpm-tis-spi qtest start parameters

Version 8 summary:
    - re-package the email to comply with the convention.

Version 7 summary:
    - tpm/tpm_tis_spi: Support TPM for SPI
      - Reduce SPI wait states to improve performace.
        Although the real SPI buses have four wait states to accommodate
        the timing of various slave devices, there is no need to emulate
        that for this behavior model.

Version 6 summary:
    1/3 tpm/tpm_tis_spi: Support TPM for SPI
        - amend commit description
        - amend hw/tpm/tpm_tis_spi.c prolog to reflect the generic nature
          of the implementation
        - remove irrelevant define of IBM_PONQ
        - correct the function names to comply with the convention of
          beginning with tpm_tis_spi_xxxx()

    3/3 tests/qtest/tpm: add unit test to tis-spi
        - changed sleep(0.x) to g_usleep(G_USEC_PER_SEC / y) and adjust the
          timeouts

Version 5 summary:
    1/3 tpm/tpm_tis_spi: Support TPM for SPI
        - removed DEFINE_PROP_UINT32("irq", TPMStateSPI, tpm_state.irq_num, 0)
          from tpm_tis_spi_properties
        - In tpm.rst document, under section 'The QEMU TPM emulator device',
          moved the 'PowerNV machine' section to immeidately below 'pSeriese
          machine'.
    3/3 tests/qtest/tpm: add unit test to tis-spi
        - modified tpm_reg_readl() by
          - removing the special case for TPM_TIS_REG_DID_VID.
            - however, I did not use the more efficient 32bit access due
              to the SPI bus master implementation. The 16bit register
              still require special treatment with the SPI RWX bits.
          - correcting tpm_reg_readb() with uint16_t reg
        - tpm_set_verify_loc() added checking for TPM_TIS_CAPABILITIES_SUPPORTED2_0
        - test_spi_tpm_transmit_test() added
          - TPM_TIS_STS_TPM_FAMILY2_0 check in status register
          - TPM responses verification
        - fixed the PowerNV stdout msg from running qtest-ppc64/tpm-tis-spi-pnv-test

Revision 4 summary:
    - fold v3 commit 4/5 into 1/5
    - fold v3 commit 5/5 into 3/5

Revision 3 summary:
  device support:
    - moved variable tis_addr from TPMStateSPI struct to local
    - added the VM suspend/resume support:
      - added vmstate_tpm_tis_spi declaration
      - added tpm_tis_spi_pre_save() function
    - fixed trace formatting string
  qtest:
    - removed the function prototypes declaration
    - fixed code format to comply with convention
    - changed function names and variable names to be the same
      as the tpm-tis-i2c test.
    - change hard coded numbers to #define's with meaningful
      names that are identifiable with spec documentation

Version 2 summary,
    addressed the following review comments:
    - break up patch into 3 separate commits;
    - add more details in the commit logs;
      - I added links to the TCG TPM standard documents as this device
        model communicates to the TPM device (hw / swtpm) via
        tpm_tis_commom.c which is standard compliant;
      - the TPM SPI model implementation in itself is not platform
        specific. However, the SPI interface is via the PowerNV SPI
        bus master, thus it is only supported on the PowerNV platform
    - change all qemu_log() calls to trace events;
    - move static global variables to the TPMStateSPI struct;
    - fixed code formatting (verified by scripts/checkpatch.pl);
    - per requests, make the code more readable by using self-
      explanatory #defines and adding comments;
    - added some documentation support (tpm.rst);
    - beefed up the unit test exercising major supported locality
      functionality

dan tan (3):
  tpm/tpm_tis_spi: Support TPM for SPI (Serial Peripheral Interface)
  tpm/tpm_tis_spi: activation for the PowerNV machines
  tests/qtest/tpm: add unit test to tis-spi

 docs/specs/tpm.rst                 |  15 +
 include/system/tpm.h               |   3 +
 hw/tpm/tpm_tis_spi.c               | 358 +++++++++++++++
 tests/qtest/tpm-tis-spi-pnv-test.c | 711 +++++++++++++++++++++++++++++
 hw/ppc/Kconfig                     |   1 +
 hw/tpm/Kconfig                     |   6 +
 hw/tpm/meson.build                 |   1 +
 hw/tpm/trace-events                |   7 +
 tests/qtest/meson.build            |   2 +
 9 files changed, 1104 insertions(+)
 create mode 100644 hw/tpm/tpm_tis_spi.c
 create mode 100644 tests/qtest/tpm-tis-spi-pnv-test.c

-- 
2.39.5


