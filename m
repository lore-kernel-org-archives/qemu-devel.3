Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0238410AB808
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5q0l-0008Cw-Gj; Thu, 26 Mar 2026 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5q0j-0008CG-AJ; Thu, 26 Mar 2026 15:04:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5q0h-00069g-Km; Thu, 26 Mar 2026 15:04:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QGKJ1M510743; Thu, 26 Mar 2026 19:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RtE/5clT7cu4GPqkbbTk72wJEe/QVJcNX4X0gZsO1
 iA=; b=L2f8A65VO17DBJppZcS2Nwi+Nv7YuEnRzfIPafaZcmEwfVTnl02JiJq/n
 UeLqVXdfNNr6EkhMETnTGRN2bViDu3R5WeHRXT8GQyNoSWvcrCoeRvA8dRejTmWZ
 My21/C/cpwlfOxbMyfv6WHlXVOtdbXdpmj4m6d/QMpxdoCV06+xOtgoYE/dD4Mk/
 6Bdu3f6D6db3+HNDnJ5G278xu6dpB//iGu4W57t9kVvY9SDhLasxYmrqjcd65gqS
 bu/GWSMH/VG1kYnBMX0YKv4iNkqL1xVwy+D8Cx1wivlo+uNUcyqHsZk8ukn8XAeV
 gp826PULLh9hTW45+LF+kDZJFA1Cw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa6t1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 19:04:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGoF1l004392;
 Thu, 26 Mar 2026 19:04:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2c31r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 19:04:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QJ4i4H45023558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 19:04:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54D362004B;
 Thu, 26 Mar 2026 19:04:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A24B220043;
 Thu, 26 Mar 2026 19:04:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.221.9]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 19:04:40 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 0/2] Replace assert with bound checks in PnvPHB3
Date: Fri, 27 Mar 2026 00:34:36 +0530
Message-ID: <20260326190438.734239-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sY5NaZyT8yYhBlEtQMZWfAr7nNKIkG5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNSBTYWx0ZWRfX6VtZtzu6CrQZ
 kZbAex+Vjnn8OxRTaNpQLJrDpsd0qjD5YEsp30VjI1MNnBELx1N+Iqmg3qASoH8hGkJmnlH4bDI
 xCCgjNUnKHg6RiGUAL9swIfzFESvDDsMy4nmWIaW+AjTP2UC7+ABzgOIMO4k7+7D77AU7S9AOxD
 omtO1oHzUNowJtwaiKrDzdSug+IstMOw4NbVhADlc5cK/PmoUlnaPZEOseBNx3MZGgev82sxLrJ
 NdBiTMW6H3t3XRIRPE3eUCxlBXMlTLgg3/lN8Z55AgmDtyS2krKGZfB+glO0PMy9YDCoLaTDoDh
 07Ol7n1IY6GXRPXKPGT2iGOFCYB6TyIZrNpcssoSF9CbMCengIMlqWV3wnex7htibrzFoYboEMb
 XskmSn7Tm1qb3dxW1IezdFLy8hRAbfc6ZgqZmiRbApdDRInC8CfxiZHvEr/NIIKOlo21J3zei81
 etQJRIjqCGLCn88RgYA==
X-Proofpoint-GUID: 9xOUEgvQKlqwdnJgEzN9vpQzUX1kvL5-
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c58351 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=8RAKwYI-Gsm1ulX1a24A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Overview
========

PHB in Power8 supports 8 byte registers, and hence the ops structure
allows accessing of 8 bytes in 'pnv_phb3_reg_ops'

Both 'pnv_phb3_reg_read' & 'pnv_phb3_reg_write' pass the arguments as is
to 'pnv_phb3_config_{read,write}', if offset is PHB_CONFIG_DATA.

This when called with size as 8, causes following assert failure in
'pci_host_config_read_common' & 'pci_host_config_write_common':

    assert(len <= 4);

This patch series splits it into two patches:
1. Fix PnvPHB3 code so that it never calls pci_host_config_{read,write}_common
   with read/write size of >4, thus fixing the assert problem
2. Replace the assert with bounds checking

Patch #2 should not have any functional change, since the issue is
already fixed by patch #1

Testing
=======

1. Git repo with the patches: https://gitlab.com/adi-g15-ibm/qemu/tree/fix_assert_phb3

2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2410981612

> Note: One test is failing in the pipeline, but the log shows some cargo error,
> unrelated to the patch series

3. Testcase provided by Zexiang Zhang, this will fail without the patches:

  cat << "EOF" | ./qemu-system-ppc64 \
    -M powernv8 -accel tcg -cpu POWER8 \
    -display none \
    -serial none -monitor none \
    -qtest stdio -S \
    -d guest_errors -D /tmp/pci_len_pnv.log
  writeq 0x3fc009013c000 0x140
  writeq 0x3fc009013c010 0x8000000000000000
  writeq 0x3fc009013c000 0x130
  readq 0x3fc009013c010
  EOF

Aditya Gupta (2):
  ppc/pnv_phb3: Error out on invalid config access
  hw/pci: Replace assert with bounds check and return

 hw/pci-host/pnv_phb3.c | 10 ++++++++++
 hw/pci/pci_host.c      | 14 ++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.53.0


