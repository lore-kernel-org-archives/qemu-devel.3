Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052ECC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIxJ-0007qh-AT; Mon, 13 Jul 2026 11:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wjIxI-0007qL-3U; Mon, 13 Jul 2026 11:52:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wjIxF-0003aE-Sj; Mon, 13 Jul 2026 11:52:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DFEWob2770761; Mon, 13 Jul 2026 15:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=sHB23fdt0lCd1Y8YP05MfTNHMFuKALrucSg3NY1E1
 I4=; b=fOBm3GpfM5bD0TfcAT6ndmGbsVVKxRyl6QqLePUKwrCWT1eOAqITRqY97
 0IRh1gpKg1IzR7BzXoG7f4pOMzJhnIyMn/Bdulff3pHBkAKzWa4kZWj7Ztd9bMMC
 AxbLPAbBsk1WC1t3lHqAiKdNgzsRyeQ+rcIXi/KFgPsNrgoMZ9/jqMyIQ0G3zSVY
 rhbhHPxyLBvbXx3Mv3aXusWVNqy2xiUQKeb3308Z7lW0n0C5FP0dvNgztBAtQqG1
 O6Pr5pJeiXUc3A2rl/D9DPStvk52A9KzkdbKZYfDaMzUcb+tU8Y5Obao+1CC3IaZ
 X+YVE/8G/6IAo4uo9KlH0UjgB2YIQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwh4mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 15:52:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DFnpBx007904;
 Mon, 13 Jul 2026 15:52:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pxkr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 15:52:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66DFqEII41484792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2026 15:52:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0998A20040;
 Mon, 13 Jul 2026 15:52:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 152C120043;
 Mon, 13 Jul 2026 15:52:13 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Jul 2026 15:52:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v1 1/1] target/s390x: Allow 2G hugepages guest backing
Date: Mon, 13 Jul 2026 17:52:12 +0200
Message-ID: <20260713155212.287444-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0bQj_9KOn0ROPDlNjDON1xrbULu_cNeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MyBTYWx0ZWRfX7vlw8bKrgzNj
 5NuvZDHK0KiDEOY/KaK+88cqarkpQ3k0x6q9b2GY9YeznKLjUh8/KRcPBkANgNWE7uheVkgvuIM
 7FqiJPR4UHEY/Ua9EMQTm1DQPI0zl2CQ3cPGhTZn0J1kNmAvkKJkVDbt4fI5dpr/fe+LZMTHIWq
 xJEzQQQH9tO7+6LGEuwTyfX4CGjnfZpy2HAmL5dZoG9wJ/5FBDBeN5qkBvmzXC2XCqzhc4vEFcu
 wup2zAvT8JrCfZrwWTKP1L13GGdIMp2Y9TUB/W6Ven39mD0/rh5cOt9xFeC1KRmAquWZf4ov44c
 sZUdBDQPeG45rncJxjpcAImfZzQUyGW/CPBOR1RuGAjR9TabvaXDhzKKC5pXnvX900/NjyFcdRs
 ucHmF8zQrYJgO6VwnyYG9tV1QOdk1R+f4i26t13n2B5rDCDtOi2Du/SMhcE/HfoYhQdxwZbFlHy
 MUduWAqUGH1rYKBShWg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a5509b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=opN3AfycTWIiqetEv7YA:9
X-Proofpoint-ORIG-GUID: 0bQj_9KOn0ROPDlNjDON1xrbULu_cNeH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MyBTYWx0ZWRfX+XB0+ioQ5NIF
 LzwZInR3V1LshYbR/G2/SkePzhesbGsObakw6PVzs5bx2MksYWzE0xvmSPo3nwzMQd2H1jtkfCk
 XHEnRIkzJZPlfFHDlt1k3wfn2iOJ1+c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130163
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Allow mapping guest with 2G hugepages on hosts that support it.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 target/s390x/kvm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 72031a5714..23fa714b69 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -298,13 +298,13 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
         return;
     }
 
-    if (pagesize != 1 * MiB) {
+    if ((pagesize == 2 * GiB) &&
+        kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_2G, 0)) {
         error_setg(errp, "Memory backing with 2G pages was specified, "
                    "but KVM does not support this memory backing");
         return;
-    }
-
-    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
+    } else if ((pagesize == MiB) &&
+               kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
         error_setg(errp, "Memory backing with 1M pages was specified, "
                    "but KVM does not support this memory backing");
         return;
-- 
2.55.0


