Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE77C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVlR-00025S-TT; Fri, 03 Jul 2026 00:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlB-00025C-Rk
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVl9-000338-OF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631J5Ef1151893
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=aaH20zl/L+ei22Y2hn7LFTKFDYye
 Fdz2YSO/vxDqROk=; b=HWaGPMSlEnMCA3b3QYwiJR6idDXg+dCACxjhDdlZC8b0
 PyHy70mJSGp4Ko1+YvqbcMODh4NKII3eO5i2umf3+4loDiUxrH3YZDNhRQU3jBTj
 cVoTS5DGX3KDb+hX+rqW3aq+nPJkwrM+8jOZjBxJ1JeriwNeJqnZrjR0gr6LaB/j
 Jl8deMYO0yR2Ifm71J5zcGMgaHrCwHl/USx8UmoyBb9HZbOeJlsuRZbpNNLNpfym
 sh9kZKkYPtbHIe82823/6at//D4pMQ0gQA4sHxJyuTbSM92nHYVKLUWa82mKOZ80
 WbNaXdsh1dt7T2v0q9lThU40WKj7Oqtyt2WztGHmcw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk4x7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634YYAc023912
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gq1m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634i8kW28181074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B42AB2004B
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 04:44:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAE6720043
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 04:44:07 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 04:44:07 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] ppc queue
Date: Fri,  3 Jul 2026 10:13:55 +0530
Message-ID: <20260703044402.79723-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX7C9EIXZAiHSm
 LWoJckwS8LpunFJiVIy9uxLCcCAu89uB8TeGtYpHSzm2CfYJhr0ZlBz9vgoGq/Xp9MBVJ9/6QPN
 lzCH2PEeLYNPchMIx3lSDbBh6mhsOdXP3KZ1RC0NoIUI86yJDLqe1GGrA3u46QLug/4JpWQO1tM
 mA8YqwTpdxacGVCmo6YrGTr+rjE562jliCv8Bugn90OslMaQeQasIXVQGlcMTH7Z6i16yDRveH/
 2oh7nkbjXtvBYKtaDOihjx2S5Vnkg1PM1ulPicTi/SP3eaDgDiQIQsD/qD5eb5KWO7wwrYHJ4Zy
 IhXOi1r5PnRapoMRMjDe0gWpYvex2pZF1V/I1t02Gdlpd/SXGRNP8JXeiGZBfVat2SQY9wW5b/n
 hp6oMiILbIuDvmT0rUAwg58fnHnWrSLDeh1fKm2t8jUecIzoSSIcdkNqXOYGnCFJm8KK8Jg/4hZ
 194kd+EMFLhStSesE0A==
X-Proofpoint-GUID: Qt8dGvVTfoivfP6_4mzooKMe2maWQ1NK
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a473e1b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=p0WdMEafAAAA:8 a=syKfl9KtHoKKEz0BSpoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX/WzEmxbzWECJ
 HqEuJgRl4RwUYFchanOMgjoPB/QSGlD+Q08nGGqIgY3e1rIuAAW8A9mviE7ddZS2Lq7oXtvMHn+
 6sq5mWpT111zbM0nNRgNOuldv9z33S4=
X-Proofpoint-ORIG-GUID: Qt8dGvVTfoivfP6_4mzooKMe2maWQ1NK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030037
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

The following changes since commit b4bdad7dcef623d2874df4e79e0be01075096c3b:

  Merge tag 'dump-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-07-02 16:04:08 +0200)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.1-misc-20260703

for you to fetch changes up to f9d05801eb4acd6402d73cb25d498a2419920cf9:

  ppc/pnv: add test to verify external DTB is honored (2026-07-03 10:07:21 +0530)

----------------------------------------------------------------
PPC queue for 2026-07-03
* SLOF FW update to 20260627
* ppc/pnv: external dtb fix and test addition
* PHB code refactor for better maintainability
* Revert deprecation of 405 CPUs
* target/ppc: Expose TB offset of guest in Qemu monitor

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmpHPNAACgkQRUTplPnW
j7tkjQ/9FP3/sTw0MxhGdLItxurrEzu3f4jiDKpnjEIqiJInzYl/2fJKZU611PSp
gydfdNhkr71TxuJggibAosEblcWRq9KqQXysDpNrJ8rqEIeLj0lv9/JigLTZqU3e
vsfDmfdCAB7YTtpm6HkTYW81EPD0X8AwQqz4FCNDQ0zeNUBIU8IU/ARP2j80CTnm
5xRK42aZb9CMYYIk3p8l4FuZmv6Y0Jf0daXM4WsEdHu9KjGvYr1glTY/lgblNPug
kWIcjPqQ6x/hloYqxTTcsfJBnKfdaVppuh6LbJbgISsQIBzTqrD2HvEIpNFJRKnS
1XGwLj6cMmm4u2tv3BF0yVDJCEff312n2VFskmOrCUJOR+g2UqDzMb4+7JOpufEn
Fla38+a9H9ThdnUNaak8+KquHDOJzDAOugOdMvsID8KlJ/q3wrTTEUUImj5Bwyqz
Gc7naNx+3D+BSiahDe4LP71ZFLrQJ/eYCj71for5xZNcZVOQ6IDhymEMUAcRzkt6
2qICF6XmkYfuH+1113KMxG65NpKGEvktONQ6UpLWTubQ++BNK1Bt2v8PAWSis/d8
EYg5M/R7RqhbxufIUDLXJIuxB3xuiVg+e+x/M8X0LffmYhPI1cuZPmth4/75IKL+
9Vddgc1hSHX1EUjRyZpoK6WArOTNvUOZMEcAhGr/0NgK5O/1Z10=
=1TRv
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Gautam Menghani (1):
      target/ppc: Expose the TB offset of the guest in QEMU monitor

Glenn Miles (1):
      Revert "hw/ppc: Deprecate 405 CPUs"

Jishnu Warrier (1):
      hw/pci-host: Split PowerNV PHB5 code from PHB4 files

Shivang Upadhyay (2):
      ppc/pnv: avoid regenerating DTB if external DTB is present
      ppc/pnv: add test to verify external DTB is honored

Thomas Huth (2):
      pseries: Update SLOF firmware image to release 20260627
      docs/system/ppc/pseries: Update the link to the SLOF repository

 docs/about/deprecated.rst              |   9 ----
 docs/system/ppc/pseries.rst            |   2 +-
 target/ppc/cpu.h                       |   1 +
 hw/pci-host/pnv_phb4.c                 |   6 ---
 hw/pci-host/pnv_phb4_pec.c             |  58 -------------------------
 hw/pci-host/pnv_phb5.c                 |  23 ++++++++++
 hw/pci-host/pnv_phb5_pec.c             |  77 +++++++++++++++++++++++++++++++++
 hw/ppc/pnv.c                           |  10 +++--
 hw/ppc/ppc.c                           |   5 +++
 target/ppc/cpu_init.c                  |   5 ++-
 hw/pci-host/meson.build                |   2 +
 pc-bios/README                         |   2 +-
 pc-bios/slof.bin                       | Bin 994176 -> 997576 bytes
 roms/SLOF                              |   2 +-
 tests/functional/ppc64/test_powernv.py |  19 ++++++++
 15 files changed, 140 insertions(+), 81 deletions(-)
 create mode 100644 hw/pci-host/pnv_phb5.c
 create mode 100644 hw/pci-host/pnv_phb5_pec.c

