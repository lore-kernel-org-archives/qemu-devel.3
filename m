Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA8C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpkg-0004fG-2W; Thu, 09 Jul 2026 10:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1whpke-0004dz-99; Thu, 09 Jul 2026 10:29:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1whpkc-00009p-P4; Thu, 09 Jul 2026 10:29:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EICpK2171206; Thu, 9 Jul 2026 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=20VQtIND6Ohyp7sZPMDuWgvXzK0cIR3FAdlSv65sF
 +U=; b=GD2gL9LMyJDxSOPA4bcj+xjJ5/9jKsCK4YoNhG9k7lC/LgickasFygulw
 +SUKQFdftMOgwhHBOnCltpjB3vWYY8Kn55vNZNrmjwr6sdZHTWUGtsdoKDoMT0Mh
 PENHb4LYfWIqMyFb677nQs5r6sSumHr7RIbZhg1xaQ4H0/zq9bz9JwvURbdRqurz
 SZu0JuxVEQwVkoCx0UQ/eppkbvqvkoTS9lhkU8CZnJAjfd3cjT0Z7DjGlBsevZSn
 XAWyThpFGjEIWRKzfYGE07cbTi3uRas+woLClS3ITqmwwjU/NZTbVacuQuPTR4gb
 Zz3fCExdicztpm2N57KatKFZQZgUg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw525e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:29:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EJZ9o029820;
 Thu, 9 Jul 2026 14:29:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdqjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 14:29:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 669ETA0E53805388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 14:29:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3128B5805C;
 Thu,  9 Jul 2026 14:29:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1898958051;
 Thu,  9 Jul 2026 14:29:08 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jul 2026 14:29:07 +0000 (GMT)
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
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 0/2] s390x: more interface hardening
Date: Thu,  9 Jul 2026 16:29:04 +0200
Message-ID: <20260709142906.197474-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UUktdiK1XNC2hYXne6AeVNFEmpd_7mYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX+q9DVEMKsACs
 GGd50havmI6xeXd0G4Hoc1cDjts0vPjIKB6Y7CoSH0VYLjsmGG2gomEIbeNZ1etq0YE5rn4qJ8E
 JbT7/r8odX6OvX9+vqM5a4Si6au3UcDdelgl61kHF4gxzWAik8zGULb/s/5jyLCMgYmsPHspwUX
 fh238Fpac2PIIgZJRPhLt7/NBPPqfoQwgI54yG9+fHFzclMh8B0PFu45oIbqmaMxdYouGPHdCgM
 TI9NQoL1FiUunOjGcuwHmv8KfFadf+iDCmaZU76ihMQnoUGjrKfGG8q5lsVQselcr31+1EGaZa8
 w9puT0r5PBquUuwEfO5DADkev4bwg0Q7I7Q7Wna4p8bBDUc728nU2HO/Xo/6z3TgovmC65iIZH3
 vXLu3STTtBHHAGMJr+aKZnF3WHt7+P32YyQdesimq7zWx6zWCKrw+oSNto0T/zVM2lVWA4MNZm1
 CdMur+HIbJQPsk6PnHw==
X-Proofpoint-ORIG-GUID: UUktdiK1XNC2hYXne6AeVNFEmpd_7mYw
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4fb039 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=xivdhShUinh7jQH9kCAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX+Vm5OENy1a9p
 OfBZwFBU7J8KuqjotohyvqjwbD23RPboPbpgKJ4w8mtgvNjDHV8qYwQxPNZppt3bgvue6JvPi5l
 YsHKxTJINuiR1eHuSqRyrmqQRShMDW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090141
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Some more fixes in the sclp resiliency

Christian Borntraeger (2):
  s390x/sclp: prevent re-reading the sclp header
  s390x/sclpcpi: check event length field before reading from buffer

 hw/s390x/sclp.c    | 4 +++-
 hw/s390x/sclpcpi.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.53.0


