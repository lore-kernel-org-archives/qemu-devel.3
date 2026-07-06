Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD0C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfW8-0005Wo-J6; Mon, 06 Jul 2026 05:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfVy-0005WB-1t; Mon, 06 Jul 2026 05:21:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfVw-00061H-E5; Mon, 06 Jul 2026 05:21:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IRHK3133985; Mon, 6 Jul 2026 09:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=whQ62+MLTdnN9BnwCJBEcjL6zzZEVz3T5KyBXiOvN
 W4=; b=DjRNdhBiTeHu5g4rL7zYXjgzdcDZM1laUjE/sJqtOk1inV3hgXbzabfSq
 9Qrikfpl9mjqrTl2iIFhcutIuWwWg1t1rBRvGycXC29xlEHI7IN/jaRveq7wfhje
 kMdd/Df086KtcHHxa7/oorDiqTlthyWqQBi0gVfFS0tXCOvudlCTq0GXD5k97FE1
 hkRbsAtDAB0H+s/1Ja2bkeNX/P3Q4meF5AhZWKWqKVON6ESaTXljtYWN/lFsqZeP
 VQbx3cmHQ6fkEOLQudlVXiSnLdhIVOr5mFn6lyhuQEr6vG/ntSOwfdEv7zc2934L
 F2gsqQC17bPoKvwPzUq5ymN45Vvmg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh674-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669Jkow013189;
 Mon, 6 Jul 2026 09:21:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjvx7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669LDsP60424464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:21:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0E95805C;
 Mon,  6 Jul 2026 09:21:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBDF258059;
 Mon,  6 Jul 2026 09:21:10 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:21:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH 0/5] s390x: interface hardening fixes
Date: Mon,  6 Jul 2026 11:19:04 +0200
Message-ID: <20260706091909.864405-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kBFid1Lm600b1EHiyk6sZLSKkSoJSgTB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX1VNndnsta/1T
 hFTNtwQe7jOmQSAQqrjBCH+0nvHmys2TiXT3RiMV1OxJstvWcaG7WVvOryanWh/qVYRXS1FKn75
 bbL9bZpYmscnoMATG/DStEHfuonmFBs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b738a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=i4uJyk9pmyJJZAnwev0A:9
X-Proofpoint-GUID: kBFid1Lm600b1EHiyk6sZLSKkSoJSgTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXzWRH8pUgX4bJ
 H+uj4Adlm/3QK6bcVaIcGmE1gOm464+CG1S6cg0PHkMh1mz/4cKeZYNGgxZLG0+foRGcTn1hkb0
 HLcPpWb1gDz6Mna8xvEy8q9LPDsPrwxpFyvcEntmF+kslptDjEkP81twFDjJMWejzwaJOk6IKED
 mQa73URbvMu7rAXlJSj8xqaysyI2n6Rc4IVR1kp6xEB9yRLlZ10e6DW/thVJ+QzDo/St7ksl5YB
 re8Fsb9YIBZvspgNan4EHHSBE8KhGw+3Vb2FeDeoVJjRps5dOk8IBXYO3cgR8JUGBXnQQMDACfy
 Xclze5PAilnKKqL2p9IyDJP4evqcQb5LCNP9PTIaHYO2JlY2S6ewu3FKIt9hHcRnDh+x3i7YvAH
 r+64f7cuMdZDKePK8twM2aeh335y2jxOjVibEC4DSPJTp6BjJnD1DDsNSJUjIBsGBiLnJbwADZs
 tdQt6L+KkOQJJ3zfPJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060094
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

Several fixes that improve the guest->host error handling.

Christian Borntraeger (1):
  s390x/sclp: reject invalid write event data headers

Eric Farman (1):
  s390x/css: limit number of CHPIDs in description

Matthew Rosato (3):
  s390x/pci: Tighten region detection for BAR read/write
  s390x/pci: Shrink RPCIT ranges to registered window
  s390x/ioinst: Require strict length and format for SEI CHSC handler

 hw/s390x/css.c            | 17 +++++++++++++++++
 hw/s390x/event-facility.c |  6 ++++++
 hw/s390x/s390-pci-inst.c  | 32 ++++++++++++++++++++++++++++++--
 target/s390x/ioinst.c     | 20 ++++++++++++++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

-- 
2.53.0


