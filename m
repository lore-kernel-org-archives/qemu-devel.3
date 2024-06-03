Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D282C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6FE-0006c8-RD; Mon, 03 Jun 2024 07:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sE6FA-0006bJ-LH; Mon, 03 Jun 2024 07:52:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sE6F7-0005yE-KK; Mon, 03 Jun 2024 07:52:52 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 453BTIY6026484; Mon, 3 Jun 2024 11:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pp1;
 bh=Wnp8U7NIKWaUhM9c3TbO1vWHG0cSSHKFt8MbqKwlJx8=;
 b=haRc06IkMNIi1P/WZ151UEJkGKCVa0bf69LzgfUK8FWnQqKaC3YM8JH/ponEPXE3ebyX
 rcqlyLY5Q/mT5Oxa2kn2fM1nRqJRm5JaAjXqN6l9rLOtsrqCQS4nQuF8Mu5Gfu+ZZWPE
 j3BrFJ4qtIZgBy/8y+nBGp+T3oZ46X1q2UWedThOKBkrlC/soKacETvY5uV8DWWJLJrH
 o1qQJLJKYbxBSU9TMyG99vrfAQjI+LMNW1eUQPurCAEvk7FlIqFRsWoUudkKMXosJ98m
 vDUy4JvzCajCZQbvfRTRV2fjT8mPQfOCzPFlHL7CbP16P2k7isqUtiCFfq4RCQTVFPTv gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhcyh81wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:52:44 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 453BqhaX006568;
 Mon, 3 Jun 2024 11:52:43 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhcyh81w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:52:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 453BC8P6026513; Mon, 3 Jun 2024 11:52:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp2q5r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 11:52:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 453Bqd5p31916566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jun 2024 11:52:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E72A20043;
 Mon,  3 Jun 2024 11:52:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E55A720040;
 Mon,  3 Jun 2024 11:52:37 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jun 2024 11:52:37 +0000 (GMT)
Subject: [PATCH 0/2] ppc: spapr: Nested kvm guest migration fixes
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: cohuck@redhat.com, pbonzini@redhat.com, npiggin@gmail.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Date: Mon, 03 Jun 2024 11:52:37 +0000
Message-ID: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L2qsxaO1ar0TBWirwF1QFFWePUBOHC3p
X-Proofpoint-GUID: XSm3BDUuls6AH45HNc06d8QprYaR9IrW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxlogscore=942 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The series fixes the issues exposed by the kvm-unit-tests[1]
sprs-migration test.

The sprs DEXCR and HASKKEYR are not registered with one-reg IDs
without which the Qemu is not setting them to their 'previous'
value during guest migreation at destination.

The two patches in the series take care of this. Also, the PPC
kvm header changes are selectively picked for the required
definitions posted here at [2].

References:
[1]: https://github.com/kvm-unit-tests/kvm-unit-tests
[2]: https://lore.kernel.org/kvm/171741323521.6631.11242552089199677395.stgit@linux.ibm.com

---

Shivaprasad G Bhat (2):
      target/ppc/cpu_init: Synchronize DEXCR with KVM for migration
      target/ppc/cpu_init: Synchronize HASHKEYR with KVM for migration


 linux-headers/asm-powerpc/kvm.h | 2 ++
 target/ppc/cpu_init.c           | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

--
Signature


