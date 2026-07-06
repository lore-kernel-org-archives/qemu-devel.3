Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A8DC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgedy-0004Mw-UM; Mon, 06 Jul 2026 04:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedV-00049a-V7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedS-0007Za-Rk
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIFlS2197661
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=EjgdvmC28M4HJ/V4TBq0PaSmyS9p
 hJWS1Hi9g1ZXT1U=; b=KC1g+adbu0jrsJHAORQRfjxuVkkne1r82jDdtJm0KHeC
 N2AoHsFau/ZdqYoZrltQosoNzHr3i/fS6czEEN7qsTXBUAaHR4OBbJRn2wtnX5fs
 Cci+YVsRmqQ4r79C8zPjtz+tZQR0PTwBY+mpeq34V9/cN47H0tvDz1ZdGwdz1yWr
 I8OKmLhnW6Jonmi8faEvAHONtQgcoMdzj5gDjl0G3fJWzIx9YmSNIsX6qhCowVpn
 PnQ73nRJ3+Hw+sh81N0/ad+BMV74r3aJJkKyEZfwEa0moJHdKvpFnpIx+yr0Ome6
 a+GYpD9giaQ1LfefOrwU+xMjdGL3LI2FCbHsThxAoA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4gdyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:24:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668Jot2011546
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:24:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpvxhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:24:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668OuPo50135546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:24:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B9642004B
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2026 08:24:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C73A20040
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2026 08:24:55 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2026 08:24:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] PPC PR for 11.1 Soft-freeze
Date: Mon,  6 Jul 2026 13:54:43 +0530
Message-ID: <20260706082451.59299-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RplO_eApG-ZpLJ-zVvnLgvNADNU5qW88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXzwg5VNNWFyoe
 Ukl8tqHBZROBNlcAf6BHP98k5l7EW+2YV6IFpYs6fQ9kDGybTnhhnFTRgLUPCPbSXqOoQP87waJ
 j8m7cWOoJ3tTFdkxky38jhAFdw59JMqKgwMBnptpnr5leV852SzFR9iTYzLwflqRrAG7ZdceQ3f
 ij4QSffuPX4A7AyNQWQUVCcw24J8XuoR8Ln6LkpaRV88BRY2keBoh/5l5C0fbjgH1CpFX2FcHdP
 Wr6W6U6pL78n2y/3rjxP7goUuXhBnxRLONyz8Qxq7mWhmhIy4djvknWhmI5opbei/bRn+wpCZ0e
 IQNMGbm78IY0/919Af6bbvloz7pBNnBuaHVWcr7KEKstcq19uZnuUqLHcHhMDi1EsCJogObPbiK
 xTRdcyD1CUh51hlh9hIeD/SeV/YR2vopCF0Lby+udAy+wElfEVg0PGjlekMYB4kxXUwmcWBC8cz
 WnDPj8hTsDsxU7EOqCA==
X-Proofpoint-ORIG-GUID: RplO_eApG-ZpLJ-zVvnLgvNADNU5qW88
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b665a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=p0WdMEafAAAA:8 a=MdZrTe2ayghipT-8awEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXytyPoQMqbOTO
 ccgv0t4+dzDn3jVsM+o2+fqLCRgWY1bkobGO0Vd0hBDgDlBPSSMVBm2dK+zIj9FFhjRXEP5bkrd
 QWPv7fOrbbYFvjxQM4wy8IVAS3yL8m4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

The following changes since commit 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf:

  Merge tag 'firmware-20260704-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-07-05 08:42:47 +0200)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.1-sf-20260706

for you to fetch changes up to b44a3c71f237eaf3cb28344598bc547a65f22ddf:

  MAINTAINERS: Add self as maintainer for PowerNV (2026-07-06 12:06:47 +0530)

----------------------------------------------------------------
PPC PR for 11.1 Soft-freeze

* Testcase improvements for PowerNV
* Remove deprecated Power8E and 8NVL CPUs
* MAINTAINERS: Aditya transitioning from PowerNV reviewer to maintainer.

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmpLZTwACgkQRUTplPnW
j7vb/w//XmleEwlL+p+YKndc4Su+qj9c3lApEFEiFi78biATrXpFTNbOxhOpWdv4
jaI1kWyINrTPgnXgHEKNJuhhsSjy5/HURCgkivPnnvhK95mWMi/0f1SzICmc9DCo
hjDeQfHw5zhF6hu6QknTfcworpsdA9uVtbx0+8s0lMMDmWze2WLg6f9OXioxhseN
vJoRaJoEo1f/vwwDFOdGngz36p0xD+eUynPTRlOymMJfW271KtNlZqouCCryI92I
ksaYa+jorE16l608SyG1Yhf/oDSlj9BufFHmgAngvlDwPFglhoJx0kPeKIrT7QE0
oGzwnOwXJH0lGuwQwISvgrtquD8unY9gTZvrF6NPIPtpMJSE+TGluoNdf/Sr2c3l
xMG/+yIwHehgXa/Lh4UN3G7yALaIjVdkcSdexuo1pfFemUCwLYPDMGoaksda+SZd
m4Xd05ZCvp2RZHRNbWheu6TxZKEHKWO8UV8U0zNgKZTz7muVURrtLpoQJFLRq9V7
krqyeLOePZtGC15a8unAbIVJVK2vOOnoqQPbuqZ57GTVqcmmcTSIEkRDcbMTADKo
Qv8WEqOWo9OYQvGF/BMP+ed1UiNzGXY2WnVrF40D3K/I/wT11mHbuKZY3gbFZ5At
1y2I59EvV/xYHdjBmDoT8smzuQwywSKZnzeKptbIVGFbuPPVFFs=
=icWo
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aditya Gupta (8):
      tests/functional: Add remote interrupts test for PowerNV
      tests/qtest/pnv_spi: Test Power11 PNV_SPI
      tests/qtest: Add Power11 chip & machine to qtests
      tests/functional: Use default powernv machine instead of power10
      ppc/pnv: Replace Power8E with Power11 for 'none' machine test
      ppc/pnv: Remove Power8E and Power8NVL pnv chips
      ppc/pnv: Remove Power8E and Power8NVL CPUs
      MAINTAINERS: Add self as maintainer for PowerNV

 MAINTAINERS                            |  2 +-
 docs/about/deprecated.rst              |  9 ----
 docs/about/removed-features.rst        |  8 +++
 docs/system/ppc/powernv.rst            |  2 +-
 docs/system/ppc/pseries.rst            |  2 +-
 include/hw/ppc/pnv.h                   |  8 ---
 target/ppc/cpu-models.h                |  4 --
 tests/qtest/pnv-xscom.h                | 38 +++++++++-----
 hw/ppc/pnv.c                           | 62 ----------------------
 hw/ppc/pnv_core.c                      |  2 -
 hw/ppc/spapr_cpu_core.c                |  2 -
 target/ppc/cpu-models.c                |  6 ---
 target/ppc/cpu_init.c                  |  6 ---
 target/ppc/kvm.c                       |  4 +-
 tests/qtest/machine-none-test.c        |  2 +-
 tests/qtest/pnv-host-i2c-test.c        | 10 ++--
 tests/qtest/pnv-spi-seeprom-test.c     | 20 ++++---
 tests/qtest/pnv-xive2-test.c           | 21 ++++++--
 tests/qtest/pnv-xscom-test.c           | 22 ++------
 tests/functional/ppc64/test_fadump.py  |  2 +-
 tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++++++++++
 21 files changed, 175 insertions(+), 152 deletions(-)

