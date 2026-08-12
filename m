Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DD4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAlv-0002UG-4j; Wed, 12 Aug 2026 11:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAll-0002LO-P0; Wed, 12 Aug 2026 11:21:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAli-0000MN-6C; Wed, 12 Aug 2026 11:21:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CE1f3k3687067; Wed, 12 Aug 2026 15:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=f1XMOTSKGgm3m+r0r5oSLBZLg61mZA2zTCXsVGSFB
 Vs=; b=EC0+v2d04i8lZvqkwFBYTfr8XQ/fFl3WSr+VuypVc6I0Z/lhC8jIteLlk
 8W8D8Ognrkyy5YDicOyxDYgO+p0MzkLYkk9vlETHn3vNYyR3dwUDZvQ47SiblNQ5
 Zfl7lnf1nlk5FyMQvsd0kG/sAFiQSgrfIq3W5zhUDaF0IoXNVr0v/viU4ooN6aIL
 SoKT5oE9VcfmutT5Qm2kGuhDqajYY2uMVrFgiOZUvUf2Bcpf0f6g7Ztd0Rd03G9u
 Q0tpV/OFCna4nSd4fOSVALSYBCXypUgeNqhWV55xqtMSp9vRsPJ2YqXbyT9Ctva0
 7zWzumY0+BsMUS7WJobvnsDy6fskA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9u7ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFBKwT003252;
 Wed, 12 Aug 2026 15:21:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6e1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CFLDRa52035854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 15:21:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EE1120043;
 Wed, 12 Aug 2026 15:21:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7F1420040;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id ADB14161205; Wed, 12 Aug 2026 17:21:12 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v1 0/3] Extend secure IPL support to virtio-blk-pci boot
 devices
Date: Wed, 12 Aug 2026 17:21:09 +0200
Message-ID: <20260812152112.3330493-1-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX8DKvh2tlc67h
 k92oGMuPZPmFWtIE2fP4i2hSW6QxW+6YI9CaVKdTyTemKGLTnDRey+T9oLVPIurR1CKgS01vHBh
 YDdZGuKVzgm78OcZnSpmTF1gKvBQPy/32wTRrEOd+AphZaXAiDBJbndv/7jtpubhgcYMg7DB0n+
 O9gpTP4OlFqA06QK9teBuEy+JPt+JHiAj/OzRPOju79jpjkRgnP3UHiIt+bKijYfwMw7VlJJnPx
 huvLcbTZEdL3vKKRBRhS2aYu3zn7rdhOi+yEUMhtdT9qGxUMh5vB7X68CN59lXwKWvsBtFR4hgd
 Ry95dHmmBWNd0MSeU5U5qk+aJ7jIOIW90anG36HdgqWbD8t3fjAVeAl6dZ3TBsDwzSnDozBTbhg
 2l2aXyfkIajfnd0ENMoiBDO71K6inuQ567de4FOyuJ3EIZhB3xpx9PfI+KSDbmHO4XO2OdYWdlP
 k/edcnvZW3Mh2u8+WTg==
X-Proofpoint-ORIG-GUID: abGBH85qeOHlLke6V_wasNRMbvqNd2_l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX1o8hhp4COrEE
 9QC20efOBLOWMBt0DWznersnprLAP65Q8S5vwTerkBJ8v7q3zZyCp+NBMz3Aqk+kvkKjONCmBWF
 ZcplYfZ2qbtouI8ZyXVksT/dpc8CDRE=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c8f6d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=pCRGzWM9ABgFAt1Bl0kA:9
X-Proofpoint-GUID: abGBH85qeOHlLke6V_wasNRMbvqNd2_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
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

 hw/s390x/ipl.c                            |  8 +--
 tests/functional/s390x/test_secure_ipl.py | 88 +++++++++++++++++------
 2 files changed, 68 insertions(+), 28 deletions(-)

--=20
2.34.1


