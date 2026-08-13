Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6221AC5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuaJc-0006wj-99; Thu, 13 Aug 2026 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJQ-0006uf-4E; Thu, 13 Aug 2026 14:37:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJK-0005Ax-RM; Thu, 13 Aug 2026 14:37:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFWjov2685145; Thu, 13 Aug 2026 18:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Vo9eyr9+UkJfwfUtV0Da1+Uflrk5+KygY+59QfWYz
 u4=; b=RCy8XleXF1v260UhYYcUiHyKr0EjJlb+i3mlHOU3GwLSIy4IqA47teXWG
 B9nprODluWucOVoIHEgIZ6va/1+jyqaMiKOxERRoCpHBns8A9YpBFAwWeyHR87k8
 F73HkhsDiKhuxVO+c/yYHWYXElt020UrYl772+nrmlkDEFWDrGqn5n8cHu2VvoO3
 NKjuuM/19VB3o5+M+T7iAZ9mm2dnBbP9JwQt6+7DfUOpV+qV4EpvsEuJwf2POfNc
 bVd2EQenLt+g1Jz7CnM9iVxo08C3EBvC1Mg3O0Xv9NbkQhmuwFlvT33pROimNZJ8
 VXyveDQujP0CFWyoNOnGEoex4CYJg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9sd0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DIQM0r020440;
 Thu, 13 Aug 2026 18:37:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk4741-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DIbgTE38601164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 18:37:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 082282004D;
 Thu, 13 Aug 2026 18:37:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1B662004B;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C9246161136; Thu, 13 Aug 2026 20:37:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/4] iotests fixes
Date: Thu, 13 Aug 2026 20:37:36 +0200
Message-ID: <20260813183740.3503107-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rUMivVv1ny_NOjKZlyhEcxxzagww7H8Z
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7e0efb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eod-ie64-X_AbYvUT9oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX8cKmamF6osmq
 NbMSnowBm061eCMFGDxJCaKK8ORmFW4geT/al5RjBvnCLFsT0e+6d8JtoHQOi3+xVE9lWX6ZT3q
 Iwj+o0PrzFtDacuRxUrN+pDaLpk/P4LIX2sNbRgartzh0MrMjlo/NDt2sVMgybsUnpSJQSHpMy4
 jNXczznsngLt8uncRYbYjLm1KpDvm6OzEHG5ZT3Lxk/xivuqe2s//qW50GytMblCiOf4/xuVdtH
 dLLexX2qR3JkwyJLtrWd3DZpydRislJAqQh8ZZcJ8SFQisCn/lzEv7XOnMOaP5xtkb76ubP3JYF
 qeLBkf1d/Or28TAfnMynpzuBEfdM2hp2w3raE/K7p6w2nYa0w5GxzIUMtF7+Bfk9J5hVHilupxG
 2Z+SfyhkZa3eqXOux8Zoc1vkN03rjpGTGm9XoDAfkXYzicKo7EMX1vqKACexp/20hziKziGlmDu
 DgYGn+WBLIH68H2/xVA==
X-Proofpoint-ORIG-GUID: rUMivVv1ny_NOjKZlyhEcxxzagww7H8Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX8Iiyx//CPfme
 FMEu56SNRH3dTiEDL+/bR0ryay/tn4vJcYSGFUkGFSd6mQnxgUXux9+9dZxrK8EVJADMnU/sVzR
 2AFbhL/00JKyCZxXzkqvP0BoxDENsuc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

Hi Kevin, Hanna,

Here is a third version of iotests fixes from our s390x systems.
They aren't related, just came up walking through the failures.

In fact, only patch 4 has existed in the previous versions of this "serie=
s",
as it remains stubborn for me (hence me putting it at the end). This time=
,
I added a check against the qemu-storage-daemon to try to do a mount agai=
nst
a null device (similar to the test_fuse_support() routine in fuse-mmap-sh=
ared),
to bail out of the test earlier than failing on the "real" command later =
on.

I look forward to your feedback...

v1: https://lore.kernel.org/r/20260725125651.3896151-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260728192644.2879028-1-farman@linux.ibm.c=
om/
v2->v3:
 - [EF] Add two fixes for NBD tests, and one (new) fix for another FUSE t=
est
 - [HC] Rework the fix to 108, and perform a dummy mount to see if fuse w=
orks

Eric Farman (4):
  iotests/nbd-in-qcow2-chain: use default machine
  iotests/nbd-tls-iothread: skip on non-x86 hardware
  iotests/fuse-truncate: skip if FUSE is not usable
  iotests/108: skip if fuse is unsuable

 tests/qemu-iotests/108                      | 17 +++++++++++++++++
 tests/qemu-iotests/tests/fuse-truncate      |  9 ++++++---
 tests/qemu-iotests/tests/nbd-in-qcow2-chain |  2 +-
 tests/qemu-iotests/tests/nbd-tls-iothread   |  4 ++++
 4 files changed, 28 insertions(+), 4 deletions(-)

--=20
2.53.0


