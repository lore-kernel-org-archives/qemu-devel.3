Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E35D12D53
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 21:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAFJD-0006iE-13; Sun, 10 Nov 2024 16:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tAFJA-0006h8-2p; Sun, 10 Nov 2024 16:17:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tAFJ7-0007J2-H2; Sun, 10 Nov 2024 16:17:19 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAEb7Te006565;
 Sun, 10 Nov 2024 21:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=JYFO5TmByNSt8imMqOOhZxti/l2DLQ7U2bAilxhHi
 DA=; b=G7t8IRaSyEhFmAuyk17kcHHH0nc4cjRJzulO/SkGM73AHN9kc+oph/pAA
 tWov3spXqV2N2gpxre2ApcYf8ELuUXYFS0l+KxIwUP3Amo8uatO3nwnnJVl3RP30
 +PRrxRl7wKR7bw0yK/o7JvH7eT98WH5dGocRafpFhd6HiOcuF/0dHB5q+BsQ8wNF
 iu35IDdUhnCu+DIKqzCydXw8Ok0lqGLx0FrF9vof0zIBzmaMxFJaaD+DXw9LfTHp
 kXGePta7hqrVt4e4k9N+oD5RSf2n9I0c++UVMep3PaJ2DgOn/+706fxrN3NOzvRg
 Yr4AEITrCMwhgm+JxGkk5Qa+e0twA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tqassscm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 Nov 2024 21:17:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAIup1H008076;
 Sun, 10 Nov 2024 21:17:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjexywv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 Nov 2024 21:17:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AALH34439452954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 10 Nov 2024 21:17:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54EF25803F;
 Sun, 10 Nov 2024 21:17:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 341DC5805A;
 Sun, 10 Nov 2024 21:17:03 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 10 Nov 2024 21:17:03 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org, dantan@linux.ibm.com
Subject: [PATCH v7 0/1] TPM TIS SPI Support
Date: Sun, 10 Nov 2024 15:16:55 -0600
Message-Id: <20241110211656.10088-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oNUY4TKAPeaHafbClzijMBUvEzAX0JuO
X-Proofpoint-ORIG-GUID: oNUY4TKAPeaHafbClzijMBUvEzAX0JuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100187
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 include/sysemu/tpm.h               |   3 +
 hw/tpm/tpm_tis_spi.c               | 359 +++++++++++++++
 tests/qtest/tpm-tis-spi-pnv-test.c | 712 +++++++++++++++++++++++++++++
 hw/ppc/Kconfig                     |   1 +
 hw/tpm/Kconfig                     |   6 +
 hw/tpm/meson.build                 |   1 +
 hw/tpm/trace-events                |   7 +
 tests/qtest/meson.build            |   2 +
 9 files changed, 1106 insertions(+)
 create mode 100644 hw/tpm/tpm_tis_spi.c
 create mode 100644 tests/qtest/tpm-tis-spi-pnv-test.c

-- 
2.39.5


