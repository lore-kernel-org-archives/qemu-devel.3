Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE59D58E6A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwx9R-000838-2k; Mon, 02 Mar 2026 01:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9M-00082p-1G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9J-00026o-79
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:02 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6215PCX6196496
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=WFizwxDGlAytsWbH8W2Rv6kUjBcE
 gFuj1s94f/ystiU=; b=dleij0+Oru4DOlEnJi9tkpFrb8dMr2MhGWPQ2Vix8/wN
 E4hLdNNfDml0bnj8P6EqyKKsqhmal9eP/pJWoVu2CX4C8DgwY2/p0zRhrChVglOi
 GJLlzWD1Oe3bhUqWAx7+f6rNFTziGQkr55cLVaXNrg+leBtWYTDuL9qByque8h24
 VYEo9llkQXaIEshP5u6cu4MPjQIWuxGUnPIyFKoYfuzceeXxBEmkOflyoKjN1Upx
 SBqSUM/AOYDKFurpBxBxJ2vk9y7SCzcJV/GtGYjhBAp4mVJqPo7CSFKH8m5Nogiw
 oz3zj9W6f03ZSM0dFNse5UPWQ6fFT5z7rBxZfWyBRA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcn99j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:52:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6224Zxxj003210
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:52:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xvsn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:52:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226qu6760883382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:52:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1702E20077
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2026 06:52:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D8A920078
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2026 06:52:55 +0000 (GMT)
Received: from Mac.com (unknown [9.124.211.120])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2026 06:52:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] ppc-for-11.0 queue
Date: Mon,  2 Mar 2026 12:22:13 +0530
Message-ID: <20260302065230.56220-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O6liAex4Vrw2TMOVve-XcHARInAg3j2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1NiBTYWx0ZWRfX4dDvyIJNCg6s
 YQe+HW8GbBe+MQO06v6BOWi9BGqqKrenP4HH5GeGkzN2S/2Vz0j0wa94I7mlb+h32R1AxYwUqOa
 +dGZvYtX4QJnUzKFUiMj3U2DiUD800NZbZ4pdTs3k2Wlqbv94qTPXQCFO45WWJ0ek2ppIb4v6yD
 Goy4FHdxAJ97VVmKQzQeHzGqSAqvO+zNQAvtxaUWtw2tkIdClJrT4Xp4fbwsooFqapexaiy+RxH
 U3fUsV+Y5eVn5CkQZRHrEw5b1q49hCnowOWq8KWhutwtLplpuQ7t/yaBKI0HsIhWvzwhGAeqUG5
 NYnXlxxVuS9N96gJecNhz5XjQ5UZdb9TVH5b/M6pmXO6FGL2DMCdAuOdPM/ZMjKhU1lNSn5SFox
 pjR7AJdjIxGeK0RCT/m0GIk3qHWk3nXjyopSceEdAhy5f2lQ3BQpDlUIy669n5Qrt2T2Fvf7Ho0
 r1Yk81oeiPAXTg8hlWw==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a533cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=p0WdMEafAAAA:8 a=PLDK5rTcJzNPIfYv7fkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: O6liAex4Vrw2TMOVve-XcHARInAg3j2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:

  Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-20260302

for you to fetch changes up to 8dec25e04e016e02c19cca68deb7ac6afff26cbe:

  MAINTAINERS: Add self as reviewer for PowerPC TCG (2026-03-02 11:17:34 +0530)

----------------------------------------------------------------
ppc queue for 11.0

- Fix TCG debug assert translating CLRBWIBC
- Misc Power10 PowerVM bringup fixes
- MAINTAINERS: Add Glenn as PPC TCG Reviewer.

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmmlLJAACgkQRUTplPnW
j7t5yg//S6Ch3ipR0gt13Q4/Hpseila6NADPaU+ASDcRNaWgJCjc+a6jW8xN6m5D
myfms5vcbNdRLvDNdLYqNhtEjVqJgsbvb7jaFDK+Ny1vJDPRHZK4QIlsx5fWSteL
fefWgfAu0ce70MQNY6zIsy/a6ORz6g+fTEv6XWsfZEdvlxow4BsClfnDcQw6vu5B
YLi9FY50Kk7BxQ2gfFbAAPqCU9XSmjSObCANil9qiGl81lLG7VqIflSBEdQ6NWa1
hJpUUoSEq+BzLtrVLTswb0/EnG2HATHyExRG5jy+oycuB8hKtZIV7g6zAdMBibrk
EBAAU7MoH/dzcf5XDtrWEFzRm3yXHorMEIxejt51ss/7s6XaiDOciViOR2OEPOxY
pzJ+8K8wRCxrM9tE2ZHZhmscz7Dns9nU0T5TrJ0NExUe8sB9A19nOQCSJsdNaWSl
4AXsevm0lqkoUCBgd+6ZHPgSSoheNW4DXuGr7dvaQiDY9xUw8lvAeG1WIVa2W0il
GAGECZ4Da5e1bLlpSw8ALvINLL+/OjzpL8d//QQOTE7xoF/5SgGUAI/w7OJJXYtX
vdvzAE9Dk2EMo0juRU9yLKiy7fjz+Ecp6wV74t9r18ZjzkD286+6nAOaXjvFH35i
c3UMUPdVYRNRjVdFxKw8B/CJ22aWauz8z9X+fFwnqKYH7YLLUZ8=
=AkZY
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Caleb Schlossin (2):
      ppc/pnv: Support for SECURITY_SWITCH XSCOM register access
      ppc/pnv: Add OCC FLAG registers

Glenn Miles (1):
      MAINTAINERS: Add self as reviewer for PowerPC TCG

Peter Maydell (1):
      target/ppc/translate: Fix TCG debug assert translating CLRBWIBC

 MAINTAINERS                         |  1 +
 include/hw/ppc/pnv_occ.h            |  4 +++
 hw/ppc/pnv_occ.c                    | 55 +++++++++++++++++++++++++++++++++++--
 hw/ppc/pnv_xscom.c                  |  2 ++
 target/ppc/translate/ppe-impl.c.inc | 12 +++++---
 5 files changed, 67 insertions(+), 7 deletions(-)

