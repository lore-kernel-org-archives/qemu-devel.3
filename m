Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EC6E6F083
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wqU-0008Ia-7P; Fri, 01 Nov 2024 14:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6wqP-0008IM-1Y; Fri, 01 Nov 2024 14:58:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6wqN-0000gK-7Z; Fri, 01 Nov 2024 14:58:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1FhCWO010353;
 Fri, 1 Nov 2024 18:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Ac6r120BdJTjqJVXWaaHnlCXJlgF/hXviBFU3h7LN
 t8=; b=PBECCO31LMlGI2AelgsjZ5nzu5dsPT4VL76SzB+HYEibTWOir5nAj/pOQ
 OzD1phgVNQkA8UJR46zjuFrDJZF3SnLSraFZ1KIkZ71mZ9Mr3qPrhpOQUEk2qoso
 q4DrIjVNxGpwRNPKACFBngNW3m5HU1no/AZWzxQuRCyGkGCHb4cm8BhOeEDj2mEg
 EakOiHDhJ99CF9QVK3Jg5U9lS21UxblCC5fCvn9PSOn+Cml/y05/vIa9ZTY3fc5U
 FhIuwMxKbA5DIGPM3sQDMWeinJkLshQxe3up+5iI9MKY5rN0ZRw7Uf5Zgyh7/axO
 Ghl2EU1ETjSFpBifvB2/qjiOE2HHw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42mw44syyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 18:57:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Hxl5g015817;
 Fri, 1 Nov 2024 18:57:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hdf1tq2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 18:57:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A1IvlSa24838876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Nov 2024 18:57:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2679E58043;
 Fri,  1 Nov 2024 18:57:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B282A58053;
 Fri,  1 Nov 2024 18:57:46 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Nov 2024 18:57:46 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org
Subject: [PATCH v3 0/5] TPM TIS SPI Support
Date: Fri,  1 Nov 2024 13:57:13 -0500
Message-Id: <20241101185718.5847-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xw8ozcN5xm4ZXZNFGnJlaqISpWmPi87-
X-Proofpoint-ORIG-GUID: Xw8ozcN5xm4ZXZNFGnJlaqISpWmPi87-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=809 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411010134
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

*** BLURB HERE ***

Support TPM for SPI (Serial Peripheral Interface)

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

dan tan (5):
  tpm/tpm_tis_spi: Support TPM for SPI (Serial Peripheral Interface)
  tpm/tpm_tis_spi: activation for the PowerNV machines
  tests/qtest/tpm: add unit test to tis-spi
  tpm/tpm_tis_spi: Support TPM for SPI (rev 3)
  tests/qtest/tpm: add unit test to tis-spi (rev 3)

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


