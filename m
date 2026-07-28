Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A391C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woi9O-0005Tt-AN; Tue, 28 Jul 2026 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1woi9M-0005Sb-Ok; Tue, 28 Jul 2026 09:47:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1woi9J-0000QV-Jc; Tue, 28 Jul 2026 09:47:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SBIGXk854402; Tue, 28 Jul 2026 13:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Rl+8KV6hQs7LOtHIoLKbABfULwvo828ZJ1JqlK/Id
 U0=; b=SrUlXCA8U18JAnVVP9EJBQrfmMja30yOj06GiC7huyDhi6+5AcXYcPOe2
 WaUqaaX8O5X8BvGcndrFPC+0RBfv5gkvg+ssQkCKSAw6x5oeNtQKt3M/40qqodjP
 XSgJyPqCfTPccMrn+gJNs0fA+IcCsCZxWmNOZRbfHU8hNA3kBNyCl1YSR81BkVk9
 bdsyf5F6TWetJrmvCD6T2vSEeBX7cUOwZjSRavy/aC/hZlV2Ppekwsz9wNXw0mh+
 a2mcmQmwz1PNgpQsvv795hlFQ0TEVCCtH+mNJDqfe34kyZn4Fe4rX3RvnV6U2ilq
 hxyD/8rtlSt+2/wgn/ytwRhDFMLBQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nmuq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 13:47:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SDfFKF010623;
 Tue, 28 Jul 2026 13:47:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw26w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 13:47:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SDl5Km27656826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 13:47:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED83F20043;
 Tue, 28 Jul 2026 13:47:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC6BD20040;
 Tue, 28 Jul 2026 13:47:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 28 Jul 2026 13:47:04 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id A41EB162592; Tue, 28 Jul 2026 15:47:04 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: farman@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 brueckner@linux.ibm.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, mjrosato@linux.ibm.com,
 jjherne@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 jdaley@linux.ibm.com
Subject: [PATCH v2 0/1] pc-bios/s390-ccw: bound zipl menu strlen and replace
 VLA in zipl_print_entry
Date: Tue, 28 Jul 2026 15:47:03 +0200
Message-ID: <20260728134704.2924005-1-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExOCBTYWx0ZWRfX12/hgE/jjw3w
 a07JjsIZbtdeURQdSOxsLNZpcIR7pbixsc+UriaC/yDzbDPrrJgPvzT/JTbORg9C8Y8A/seC/1P
 MUWBzkuFMyv6waNeA2yedJM4mZeDc74=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExOCBTYWx0ZWRfXwY3wcBC7DcaI
 pWfnj71mVpYv4VSxMNIDi/yxJKam8OBMqQOVFVKg5lyfmUnyXP5NjjA2tASUwgny817S1FYgdsk
 t1PtWnZjQutYyOSp6p8Z0FPGJs0ddFIqtXTlIW+fGzbUxbnUkESndW8sw5JyvxeBTGRMI5LBr5N
 yplTIvOQXHnb0lLHYVw4ZRlKepGp1RnvdUVe9q10XQWzpokDx7GBeHVvco2LyIuzbjZcAX/4G/C
 BHPTi32lsS2rQwUmwTIfii/NM0pTDIJChDxiYVnuS/ddQzbg2dPPHug0kwR0NalGSXpJy8vT3NT
 6Ea+qr1R5DKYwmsqx1CyxnlySFTz0Ourqmn+vwsZOipZjjwh6ZKuOj8vpDIvioZwY8zDl29RtWE
 IE0UdyDRSIWkMu8Po17xycwL+dOxt5PzAKGNRIYYh1JBxA1F1NNMWL/yHx9BYlSuuLh3ad6x5QX
 3xqwoRPTzBV1P0G9TxA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a68b2dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NzGWJsgcWuOPWxY40HQA:9
X-Proofpoint-GUID: OlDFo4LnHkRgPnKIfA6ZsDA8NuDV-g6M
X-Proofpoint-ORIG-GUID: OlDFo4LnHkRgPnKIfA6ZsDA8NuDV-g6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280118
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

The original version of this patch is part of the series
"[PATCH 0/5] more hardening fixes for s390"
from Christian Borntraeger <borntraeger@linux.ibm.com>.

Changes v1 -> v2:

- Added a condition after the banner skip that returns 0 (boot default)
  before printing the banner, if there are no entries in menu_data.

- Modified commit message 2nd bullet, final sentence.

Joshua Daley (1):
  pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in
    zipl_print_entry

 pc-bios/s390-ccw/bootmap.c  |  4 +++-
 pc-bios/s390-ccw/helper.h   | 10 ++++++++++
 pc-bios/s390-ccw/menu.c     | 29 +++++++++++++++++++++++------
 pc-bios/s390-ccw/s390-ccw.h |  2 +-
 4 files changed, 37 insertions(+), 8 deletions(-)

--=20
2.34.1


