Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9A9F436BA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDl25-0004PY-W0; Fri, 17 Apr 2026 11:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDl1w-0004O0-RQ; Fri, 17 Apr 2026 11:22:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDl1r-000266-MP; Fri, 17 Apr 2026 11:22:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HAfNPa2130598; Fri, 17 Apr 2026 15:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cj/A1WrtZjurY9GZj
 EksmswmJlhdPC1HRWbFlD+jy+A=; b=Q+auiwFRvgLN8cH7olQNNmLwCJlLA74o/
 kJ/6gWUWtNNN4ze4JkztrR4UnJT36EYbU4HJ6g0a7h8dkTRJsFP/rIkHLigpjZhf
 amwdRzdZUiW4YaouEK+xwpn09oEXIblSdrZ25YJngWmm//NnPhCLT1uJc++k4Ay4
 q6Un3vPpW0I7hBCgv/NFkkNBtgALbeMqwNTAT0zXY4r1qhWPH/ZaTe+NDMTGO7GA
 x6E1brdOAmemguirbg9+wsMQqrkBb7aNLLXWHjj8X5Jiw5kHlMYQBYjIphDCGPu5
 v4cbK9WQKW4anf7s0mG1oDmn4OyKPixcaxu2scw+4bQu1j2J3fXgg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nuasv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:22:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HE2bFc026284;
 Fri, 17 Apr 2026 15:22:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujyhp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:22:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HFMcu848103730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 15:22:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF3220043;
 Fri, 17 Apr 2026 15:22:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E3F720040;
 Fri, 17 Apr 2026 15:22:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 17 Apr 2026 15:22:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 223A7E05E7; Fri, 17 Apr 2026 17:22:38 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 1/1] MAINTAINERS: Update s390 trees
Date: Fri, 17 Apr 2026 17:22:36 +0200
Message-ID: <20260417152236.1305333-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417152236.1305333-1-farman@linux.ibm.com>
References: <20260417152236.1305333-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mPr0cjrX9yL5YKAceCpHT4zkjusrUbPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfX4IhAigEPzLMZ
 YxQXtfBbRHXAd6zoXH3vv3xuVusnSsolvLGcBysethvZ/6sJlvtrphH29dcudMGTioeGj+AAbZg
 E7r6jAsP6XRggmUZjwiZiSVArbZvpI8IRIdmZZyYkQgBW61oOkUaXh33VETSSuojOFQC9FY4nq4
 7BJ0u1RSlKLFHizqw/hK8obEpuQMvkrBtxu4RqNtNGq9EM7EM2P0gjhZkqaVJuXkYioYHlDH7ok
 SvmiI4l4kbzypCY/Z6iQGPZU0/qOGgDoC/3ERbxG/RH2Xa3yHzLFoDKQ6/mkpToU9xke3o8PlXZ
 fHCwLBkI8ZDWM6/Sn3V9cMocfCQR2DVLPoXZi4+aYXSKHjikwJDTT9vDoOJKLXrL3e7Uni3JsvX
 lqOWvr7uGra6/Ez0aUxacGbbguLI2gefRUpLSZSHb2vZQHIHH2YJaX9pmQ4qldTIjY3GZ/WkNtV
 TPtlpkSrpBQxUDHpfHQ==
X-Proofpoint-ORIG-GUID: mPr0cjrX9yL5YKAceCpHT4zkjusrUbPe
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e25042 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=Z1qelsxXmbENWnNv04YA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

Move Cornelia's git tree from virtio-ccw to the overall
s390 architecture group, since all the subgroups funnel
up through that.

Remove Christian's tree from the subgroups, since they are
not specified consistently across areas but also haven't
been used in ~6 years.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..cdec4872d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -126,6 +126,7 @@ F: docs/system/target-s390x.rst
 F: docs/system/s390x/
 F: tests/qtest/migration/s390x/
 K: ^Subject:.*(?i)s390x?
+T: git https://gitlab.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 MIPS general architecture support
@@ -500,7 +501,6 @@ F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
 F: gdbstub/gdb-xml/s390*.xml
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 X86 KVM CPUs
@@ -1854,7 +1854,6 @@ F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
 F: tests/functional/s390x
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 S390-ccw boot
@@ -1868,7 +1867,6 @@ F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
 F: tests/functional/s390x/test_pxelinux.py
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 S390 PCI
@@ -2468,8 +2466,6 @@ M: Eric Farman <farman@linux.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw*.[hc]
 F: hw/s390x/vhost-*-ccw.c
-T: git https://gitlab.com/cohuck/qemu.git s390-next
-T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 virtio-dmabuf
--=20
2.51.0


