Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472EAC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzF4x-0005Iw-2i; Wed, 26 Aug 2026 10:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzF4v-0005Eh-Fo; Wed, 26 Aug 2026 10:58:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzF4r-0000nC-NJ; Wed, 26 Aug 2026 10:58:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1cxL070305; Wed, 26 Aug 2026 14:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vh7s+kXlgxpAj0n+IdsMjxcQauFmQ4Jz9Ucq4lYGz
 vs=; b=WeyTb6oK3ojXALtW2zSRAovkA/3w4wqlyTh1R0B46H21XTnnkJcPL/r4m
 OIw8qufZvJGRFWH5LKQWxnHjKaMwn10Osm4Iprbuz8PyU1/zX6sW2K0bVEUgIr5m
 45boZ5N0KdTOOGzOZxqZgg1hskdyclD0FkBohvTCL7ZyIiqn8GWMw0PcbcnfjllA
 8BELD434ajZZcHdOX7OXq1+BxbybN/iI4XAmL2YeceCTIbDmhW+vzZRKYe5VZlOj
 hNOk+75PcW2paTT6vIqR7MkhcmAGVjuCPIA4fxBmZiA9ltJwJxS8C10IDZ4Xgi4s
 SVIxA6Mj9Az2fKm6CRBN3VHSy+Xcg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxf2uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:58:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuGav017900;
 Wed, 26 Aug 2026 14:58:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2hk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:58:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QEvuJj47907072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 14:57:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5E0F2004F;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A975520049;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 90F9416161F; Wed, 26 Aug 2026 16:57:56 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v2 0/3] Extend secure IPL support to virtio-blk-pci boot
 devices
Date: Wed, 26 Aug 2026 16:57:53 +0200
Message-ID: <20260826145756.2324598-1-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX3Y9+lP6pCbCi
 Imoq4TALzr3p3pD9WbZuPY0/zwu9iOOvMEf5wvdQnXsEI294Y+5IfexoecPVxfOl9gR6N9FWC2c
 3kzevxiVl66UlMKHc8KTnX0qnID1FH0=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8efefb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=__IoPmQZGUIikFOuX7oA:9
X-Proofpoint-ORIG-GUID: jBpxmz1o7d5gg9cAxrRcA8XqkOXjWwGM
X-Proofpoint-GUID: jBpxmz1o7d5gg9cAxrRcA8XqkOXjWwGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfXxXvDVARYqhlx
 8mbas3ZtkZyGXoumsgXRHJwSNvzkBB/FteQuY3bi1Z+k6bES/UydGEwSeaZV08KiwbFSFbQyccd
 2/yGzDW1SRObopsSdDeYfQRLkiGUJaoYtldITkCXdBNP/rnsPLCwN73Chy2rKH3dmy8iYky/yLA
 Hq9Lq5c70JYB5+3thtWehWV2wL9Ys4niJUsFf7wayycdC/cjnDQBq4GvpZJvZu9UOAkUf/2X7Gf
 vQOSPAo9MSObqSBt9CeQVi5ruMnYby9B3X6gffe9KjZOcHT5sIEbx4Us0B/NSFDFr9zcvAGWuSU
 LDvs1j9Unm47Rx0NZ9KbyaNzRZ9H5Uj1OwYyMlBIduUcWrSQewmxhsKlEpdadgBc1Yw3EvqQcmn
 r3YOTBYN4X3V371J4JAD3PeOGULDMb3mGIJbuNxqWCdhwX80N9NHfiaY0tNoBWBgOPd9P5+XDfX
 LjlHaYXbXYIPYFGo9uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Changes v1 -> v2:

- Added RB tags to patches 1 & 2
- Patch 3:
   The setup step is now run only once, as originally intended.
   setUpClass and tearDownClass manage a shared workdir for the
   subtests to use. Instance vars are now class-level vars.

v1 cover letter:

This series is based on Zhuoying Cai's series,
"[PATCH v17 00/34] Secure IPL Support for SCSI Scheme of virtio-blk/virti=
o-scsi Devices"
https://lore.kernel.org/qemu-devel/20260730214624.2328883-1-zycai@linux.i=
bm.com/

Note, the above series is based on Cornelia Huck's patch,
"[PATCH for-11.2] hw: add compat machines for 11.2"
https://lore.kernel.org/qemu-devel/20260723163806.368127-1-cohuck@redhat.=
com/
which requires a small fix to apply (see Eric Farman's reply).

---

To add support for secure IPL with a virtio-blk-pci boot device, we simpl=
y
write secure boot flags to the IPLB when using such a boot device.
This is achieved by calling s390_apply_secure_boot() in the PCI boot
device case of s390_build_iplb().

The secure IPL functional verification test is updated with an additional
subtest for the virtio-blk-pci boot device case. To run the FVT:

  make check-functional-s390x MTESTARGS=3D"func-s390x-secure_ipl" \
  QEMU_TEST_ALLOW_LARGE_STORAGE=3D1

To test secure IPL yourself, view the "Secure IPL Quickstart" guide in:
docs/system/s390x/secure-ipl.rst

Joshua Daley (3):
  hw/s390x/ipl: Add secure boot support to PCI dev IPLB builder
  tests/functional/s390x/test_secure_ipl: Skip test if SIPL not
    supported by hypervisor
  tests/functional/s390x/test_secure_ipl: Add virtio-blk-pci boot dev
    case

 hw/s390x/ipl.c                            |   8 +-
 tests/functional/s390x/test_secure_ipl.py | 149 +++++++++++++++-------
 2 files changed, 108 insertions(+), 49 deletions(-)

--=20
2.34.1


