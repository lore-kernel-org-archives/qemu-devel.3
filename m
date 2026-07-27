Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A756C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJre-0004yC-Tp; Mon, 27 Jul 2026 07:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrN-0004vh-HP; Mon, 27 Jul 2026 07:51:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1woJrL-0003aX-QO; Mon, 27 Jul 2026 07:51:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RAIXjF1844602; Mon, 27 Jul 2026 11:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=s2/pXswdrVAnMv2CvhClv30IKAIgeWe715ypWWuJ5
 8g=; b=rzT0csmiEYV32gTGL4Uodyzs4oOjVTqXlS/7VSDn1KGPrXrmg1i1jNN7+
 AHfvzR4a2t9S6Fqhdlr+gzPGIrMqEH5pCnwWmzwuZ4tG7xkqNcIZj36AjOEbE3QJ
 GFhnEV1GajjF2VA4jP/i8aBjO4JyKVxijcIp6mYARAnCIIIS7pfRxuxUFCSW74Df
 FejwrhTgN6pASyaYJ/ZpB1i8H5PpVIAOuATVhgKe6G2FMaFbCKjzm51bh3WfYAuz
 UXIyO4ykXVno+xK2unrOVJ2GZgF0NGcy6p395juCrjjcSUl6GElHCvmI1Tg/GMs+
 MFddnGlZjArZFIW3lJzV7ztijz7mw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhycwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:50:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RBfJBC007048;
 Mon, 27 Jul 2026 11:50:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xvxjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 11:50:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RBou0l17891960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 11:50:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7CC65805A;
 Mon, 27 Jul 2026 11:50:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CB715803F;
 Mon, 27 Jul 2026 11:50:54 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 11:50:54 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/5] more hardening fixes for s390
Date: Mon, 27 Jul 2026 13:50:47 +0200
Message-ID: <20260727115052.24289-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX/LrQZlHgOABS
 21c5rOWV/oGC4YrI1SGkrrBFtmD/MGh9Qh/Rj30ZUN7D90/4x153ru0pzclM2eMz4PFk1OZyw0w
 JVigNVcSSCXvFa6jXI6kHuiRAjnapw0=
X-Proofpoint-GUID: yw7iTYIxSFNo9xs8xp9ej5u9-dWIYIbV
X-Proofpoint-ORIG-GUID: yw7iTYIxSFNo9xs8xp9ej5u9-dWIYIbV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX4wDuZq0FIA66
 tJtPtyeQFEEbWMMq1afVq4NqJI9MIb4SgTjo+405GL6Jz/d/fGR1uXI3ixL7cAL8Z1Lf8j3BiMe
 p4q95CFuQhMzUl7brzxU7Ytp9oYWgB+Q38ITD5Ba3jYlE++zztrV9lREe9U4FSRUPGIFgPq6Q1M
 cIwOWOOw21Skgdb2kCiMID404kWtCBxrEskJ4bug/nD03vnFn1N0/xKxU87vkXbPQIVjwkM520d
 YO4aYUhxmTe6yqlfXsZLkZV056ItFbyHS6/pUu2ujEkL4MvgxK4rg6dc7mjl7QOe9RzQ8ROveHD
 5BCARD5+i+m86eUd0CayJKEkANgP5bzfjA2j7dcmqlku7sSBpxrE1trCnxCKT5YphWeLAnBWxVV
 LY//dkdoN2GGqSLtkdqdHdNv88HKF+FXf04otEtCcJU4r+RHBCbJ6uC0R7TCJkwp0nkMIVzjEXq
 JKMERXAbtX3tuNtFoMw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a674622 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NLiCwHATAAAA:8 a=X2q3w5tz9y4kLuQqkKgA:9
 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270116
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Cornelia, Eric, Matt,

here are 5 more fixes for hardening QEMU against invalid input. Nothing
is strictly a security issues as defined in the policy. For example
https://qemu-project.gitlab.io/qemu/system/security.html says assert /
abort: If triggering the code path requires kernel privileges (or root
account access) in the guest, asserts/aborts in QEMU are a self
inflicted denial of service. These will not be treated as security
flaws, at most hardening bugs.
And if anyone can provide invalid boot loader content it can provide
anything to boot if secure boot is not available.
We should fix those anyway, probably even for 11.1 

Conny, I did not rebuild the s390-ccw, I assume you will do that?

Christian Borntraeger (1):
  hw/char/sclpconsole-lm: avoid guest triggerable assert

Joshua Daley (4):
  s390x/ipl: validate num_comp against iplb length before iterating
  pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
  pc-bios/s390-ccw: bounds-check zipl menu entry index before array
    write
  pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in
    zipl_print_entry

 hw/char/sclpconsole-lm.c    |  3 ++-
 hw/s390x/ipl.h              |  6 ++++++
 pc-bios/s390-ccw/bootmap.c  |  6 ++++--
 pc-bios/s390-ccw/helper.h   | 10 ++++++++++
 pc-bios/s390-ccw/menu.c     | 36 +++++++++++++++++++++++++++++-------
 pc-bios/s390-ccw/s390-ccw.h |  2 +-
 6 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.53.0


