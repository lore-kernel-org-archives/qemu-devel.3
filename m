Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7817C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzuD-0005jM-3a; Tue, 07 Jul 2026 03:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzu9-0005io-MN; Tue, 07 Jul 2026 03:07:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzu7-00034b-OY; Tue, 07 Jul 2026 03:07:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674INQu2519198; Tue, 7 Jul 2026 07:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=vDqJ1Y4SqY/9yk9LHh1QeDpjjGqT
 qkQ2soO0F+ZT2ho=; b=ArTgp6Hldu5d8lljMD/4ynrm7d9j5U+Gx1UkGqGzfyES
 h8JZJhBDCOUEehsa/4XpyRWNIo+ADFl9wtOuKckK21dyCubJidLUIJzrdHFBWUy7
 d+wH/ncXhJ12BAC0MZEpEweuDWZ4wnqIai10H5kV2+2fD/siOQZ2PGAMhftjCw6k
 onmDsQm/zYVzj5wtP0AIQiNoAAP+7raJM9UGybxQV0CEB4tCOm8UXN11bH+1rwQs
 oITDU2Nw2X7Kq75sEiPXTugF6A3joSVoKmdZrLDvomuIrJIdGJOGsX8d37ILJ7KL
 uaYsYQfpBxv2Nxzcjbr15rRIR5o4bmSqWJFZEGM9Eg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkndjge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6676njIk023434;
 Tue, 7 Jul 2026 07:07:34 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq1n6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66777WZG31719984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 07:07:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9266A58059;
 Tue,  7 Jul 2026 07:07:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A14B45805D;
 Tue,  7 Jul 2026 07:07:30 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 07:07:30 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH v2 0/5] interface hardening fixes
Date: Tue,  7 Jul 2026 09:07:23 +0200
Message-ID: <20260707070728.147203-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4ca5b7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i4uJyk9pmyJJZAnwev0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qWDhfWbVdnP0RPNJcHyy0cWLPaUsq_ES
X-Proofpoint-ORIG-GUID: qWDhfWbVdnP0RPNJcHyy0cWLPaUsq_ES
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX1pfBL65u8r8m
 WYiNr1kmI3f6St5Gh/kkC5gYn3hMh76nGFAmjsTqPGN7anugCQkRAVTT+ahaNQDwaOUbpv8S/AB
 e/P+GYyF3RhjSPn5+FPt+U4J53t4JDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfXy+rEvo+zTGuv
 c9k0IOIS7RgdYzeSv1eBGAzhsANIJSRi7tt0UTtOWvJGjdzA/qki5FlGuSd+atvBKJJ/x85CM6r
 m//ZExvYR2cnLTZfmJytqmcZat2zdzGsUgD7jr725QWTZLah1J0iLf5GkY56FitoaqTxnGjLe+w
 /Ht8utyuecui0uMHpYGEVj1lBfWCrEimIJkQFuDuyKicHSmR2bSIYR5LgD4NXBYllaWIabn90XN
 gNd2p9tCINhOfrEDkRKM8Sh8HJEUzDbr/ybMuZFY6cf0KQ/N/l8nFVdatNKZ82WecNMCyPqRvp9
 0paprU7LgzOdxDGhYGDeNYbDiUNTEQEa/EQ/euIGfVXpXqqdYbjAHjX0oX06XKVzxvPiFdshXpX
 kIHr+LBkHwyuLjLmb4C/g8Juyj+jVmNZ4RnD1UgD5AKcVHQoy6xUm/QBGDv+g5vm4sQFm2TyCFt
 +X7Pj0jPf7y1yBkA3AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070064
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

v1->v2:
- add missing signoff
- add RBs

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


