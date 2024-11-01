Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF100E6F08B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 20:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6yFH-00035Q-Fb; Fri, 01 Nov 2024 16:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6yFF-00034S-ER; Fri, 01 Nov 2024 16:27:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6yFD-0001IS-Td; Fri, 01 Nov 2024 16:27:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1KF2pC010886;
 Fri, 1 Nov 2024 20:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=1S3MQtofZm3bEzrzBxPfhS50YuO7Q1QXGf4Ts80Qs
 a0=; b=MKQnbgzn3W06t67DWvhaDwqLzxc9wimvzpsJEwdcVurDxYBB8tm4O79FN
 lNDtLqvX17ZL1r3ZxbgNLx6Ap4yNmlDjTgY810W2KouLmsXF6Oc1GR2mo74Tp5Yl
 Bpbm1RsCvJCl1Q4+dIV3X0bpFDygFRfep/3iNTDwb2lGdi14xvuCh4fkQeTthj4S
 llQSf+xST8Z5f4hsDexMj8/nOIQPX3QP4qwIVXOjcgFDHfobHvWhWcpfqq7mI0Io
 FdK5nlcjUme2uOEjduXzpls1D/b2YNFpYnIhBxsgL3uNwp7sfQy0yJfVknIh/8bg
 H1BeEBFiddbFjdg+VBSbynPV06aQQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42n5v000x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 20:27:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1HkLK7015899;
 Fri, 1 Nov 2024 20:27:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hdf1u0b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 20:27:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A1KRX649765402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Nov 2024 20:27:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4694A5805B;
 Fri,  1 Nov 2024 20:27:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4E7E58059;
 Fri,  1 Nov 2024 20:27:32 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Nov 2024 20:27:32 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org,
 dantan@linux.vnet.ibm.com
Subject: [PATCH v4 0/3] TPM TIS SPI Support
Date: Fri,  1 Nov 2024 15:27:24 -0500
Message-Id: <20241101202727.9023-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2W61t017IA9AAKT9kmpOg8Zu9lI_LjlN
X-Proofpoint-ORIG-GUID: 2W61t017IA9AAKT9kmpOg8Zu9lI_LjlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=815 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411010144
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/tpm/tpm_tis_spi.c               | 360 +++++++++++++++
 tests/qtest/tpm-tis-spi-pnv-test.c | 710 +++++++++++++++++++++++++++++
 hw/ppc/Kconfig                     |   1 +
 hw/tpm/Kconfig                     |   6 +
 hw/tpm/meson.build                 |   1 +
 hw/tpm/trace-events                |   7 +
 tests/qtest/meson.build            |   2 +
 9 files changed, 1105 insertions(+)
 create mode 100644 hw/tpm/tpm_tis_spi.c
 create mode 100644 tests/qtest/tpm-tis-spi-pnv-test.c

-- 
2.39.5


