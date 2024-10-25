Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD9ED149EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4QgY-0004Oh-Rr; Fri, 25 Oct 2024 16:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t4QgQ-0004Jt-FW; Fri, 25 Oct 2024 16:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t4QgN-0001fG-Ud; Fri, 25 Oct 2024 16:13:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHKM7J003071;
 Fri, 25 Oct 2024 20:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vSw9fDKcZKzqM94QiJRAU/Ko1dNKC3t+FbdTNkjJJ
 xE=; b=mKbL1MqNUkqGKvKLqbjimjp2AMbJe2UXxn4vnl3EKpr4EU54HvJhq7Juk
 6eyCaHV67QVv4gyyjPGaudZyOolfo9+ZPGiC4FizBiIlbTuXYnE3agrm2IhS/68f
 VCYKOcxojlBBNH1hE61cEk5VxmJ78FvMWNQBOABInknY/MWIz/jg+mo/fKle+y3T
 +egN3TDb37dfe720lDLERNQGK9YfS5J7GTpfDjghrf0LOpHAsj9ikbNRIOpaNmZ6
 SqcFyy839yBKNYB/U9rWrSQsbyODT6mXY3F7IBufArrjLuL+yNNVEdP3WQPp9w4f
 0v4mM6KY6vZJycEo6igj4To3W6tvw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g5kxkyfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 20:13:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHamYB014571;
 Fri, 25 Oct 2024 20:13:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk87hta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 20:13:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49PKD1eu52560354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 20:13:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F8CD5805A;
 Fri, 25 Oct 2024 20:13:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 184B458051;
 Fri, 25 Oct 2024 20:13:01 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 20:13:01 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, clg@kaod.org,
 lvivier@redhat.com, farosas@suse.de, pbonzini@redhat.com
Subject: [PATCH v2 0/3] *** TPM TIS SPI pull request ***
Date: Fri, 25 Oct 2024 15:12:44 -0500
Message-Id: <20241025201247.29574-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -SgmhAcIjmBTocnM2dfnUypqEmsOk1Xl
X-Proofpoint-GUID: -SgmhAcIjmBTocnM2dfnUypqEmsOk1Xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=531
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250152
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Tests: 'make check' and 'make check-avocado'

dan tan (3):
  tpm/tpm_tis_spi: Support TPM for SPI (Serial Peripheral Interface)
  tpm/tpm_tis_spi: activation for the PowerNV machines
  tests/qtest/tpm: add unit test to tis-spi

 docs/specs/tpm.rst                 |  15 +
 include/sysemu/tpm.h               |   3 +
 hw/tpm/tpm_tis_spi.c               | 328 ++++++++++++++
 tests/qtest/tpm-tis-spi-pnv-test.c | 700 +++++++++++++++++++++++++++++
 hw/ppc/Kconfig                     |   1 +
 hw/tpm/Kconfig                     |   6 +
 hw/tpm/meson.build                 |   1 +
 hw/tpm/trace-events                |   7 +
 tests/qtest/meson.build            |   3 +-
 9 files changed, 1063 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_tis_spi.c
 create mode 100644 tests/qtest/tpm-tis-spi-pnv-test.c

-- 
2.39.5


