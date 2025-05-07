Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897E5C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXDV-00076N-F2; Wed, 07 May 2025 01:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uCXDQ-00070C-HX; Wed, 07 May 2025 01:21:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uCXDO-0001a7-4f; Wed, 07 May 2025 01:21:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546LgXqb017561;
 Wed, 7 May 2025 05:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=DgfivDdqSg+ugkf7im1JPsKJd0A8
 CBzr87EcsfKRr8k=; b=jTK+xp3usLtxGpPuAbf9TYvG45b9EmrKUK/W9D8B6/Md
 3YWGoViUMZkKKiRGhxpxMhYYiUB14a/jByG6JmNoUZnE89600qqjAg940Qkym2ni
 Qj+Fx+wTUeAqou8U3e/EdUc96YKiJUTjOHoT2OF+lQFFglxliQpgmBgCy1kw89YU
 ihbVuGLi9+kAeQ4d0EFvlyxGiJwovi9eNju16i3D3mSK5sSTfSDw/3BJDeh+iGPk
 97XUfIUUPAyXImmiu3Dyj7Ed+GJJ04Cd+K/RAYWDh8+BvwoIQGlcbHOYI9wooVin
 2kWvAaHONx1CHM6ALEDcrLberXbOKVTnZYMcIGoCpA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ftjw1hcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54759CKL012003;
 Wed, 7 May 2025 05:20:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ftjw1hcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5474S3Ew025798;
 Wed, 7 May 2025 05:20:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyy9fg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5475KpXw39584236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 05:20:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDF262007B;
 Wed,  7 May 2025 05:20:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DECD920040;
 Wed,  7 May 2025 05:20:50 +0000 (GMT)
Received: from ltcblue8v9-lp2.aus.stglabs.ibm.com (unknown [9.40.192.95])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 May 2025 05:20:50 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH 0/3] ppc/spapr: remove deprecated machines till pseries-4.0
Date: Wed,  7 May 2025 01:20:45 -0400
Message-ID: <20250507052048.90559-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0wWfb7DrllCkbUzfxYHZVYySowNiDV1l
X-Proofpoint-ORIG-GUID: r0CeIyCuMYz9DN3JE--NJp74QAzjNKv1
X-Authority-Analysis: v=2.4 cv=R4ADGcRX c=1 sm=1 tr=0 ts=681aedb7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=f7IdgyKtn90A:10
 a=cNYgDV58IKDmlT7_HDAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA0NSBTYWx0ZWRfX6FfYK2dkzhjk
 L+X2I7pnV0ZA7rmAssQUNFgLnqHB+iLZy8QJoFnvEiYenYisyk8y5tk/iEWgYuItATN8229Ko1I
 M1bDxOXwTRbbZOKLcnLYSSmeq/HVOJnECWZI5OHprOsjGvT/pGD3s8ukI17kBGE+PZ9oy3cMUC6
 amrDNze3qyBe0NEmUQknB9s14o+tzq2Rz2HXopDjwx0xzMlnHef8FfquSTtteFs0BHOS+RfpoGb
 XI3eeT20hElywEAfU2An0l+VfheGIi9GW2XFxb44N/nqXnneOfLFBz2lm91Wq/HVFX42PHttJwk
 meN0Dn/iRZmBuv5wOP9bU/Pdbrr84BIUfhnNZkRf0sKfmnU3TRKBwCS74EOEy/0r4OXXNysqleq
 6EcpWZirkHVKJysw4LZEn8wnJhVKNEWWVXH4ghbb42LQ+EecVY6dYk7QksBAf7ritL+VHa0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=325 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

pseries-3.0, 3.1 and 4.0 had been deprecated and due for removal now.
Also removing pre-4.1 backward compatibility hacks that aren't needed
anymore.

Harsh Prateek Bora (3):
  ppc/spapr: remove deprecated machine pseries-3.0
  ppc/spapr: remove deprecated machine pseries-3.1
  ppc/spapr: remove deprecated machine pseries-4.0

 include/hw/ppc/spapr.h     |   5 --
 include/hw/ppc/spapr_irq.h |   1 -
 hw/ppc/spapr.c             | 118 +++----------------------------------
 hw/ppc/spapr_caps.c        |  12 +---
 hw/ppc/spapr_events.c      |   8 ---
 hw/ppc/spapr_hcall.c       |   5 --
 hw/ppc/spapr_irq.c         |  16 +----
 hw/ppc/spapr_pci.c         |  32 ++--------
 hw/ppc/spapr_vio.c         |   9 ---
 9 files changed, 13 insertions(+), 193 deletions(-)

-- 
2.49.0


