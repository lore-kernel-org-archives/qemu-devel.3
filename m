Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5DCCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbapp-0005KT-NG; Mon, 22 Jun 2026 05:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wbapn-0005Jx-Or; Mon, 22 Jun 2026 05:20:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wbapm-0003Hn-1T; Mon, 22 Jun 2026 05:20:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M5IVaA1602673; Mon, 22 Jun 2026 09:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hkbW0eHSV8gBVq1aeSo6vFvh7L2GT4SfaVKcCjiTh
 7E=; b=W33oNh/rt9e5iInty0IcLXBRW1lD8oWWjwitd2X1yRHWkh9XGoA9FP2pv
 jZYtLGgV1cSbwdqdmEevDWTr925yYF4nVaMpyh/25SpCpK7OSr7zlmpRsS60J9Un
 2i+BrEpe5QGvoWaydou/puRbmA3chSYdb3C/eMiFfSf4Tz6nx/g85PXUNF7mcAHA
 fCHpgcEruT+h48MtTlTd24dHax8R+0MpwLz961h7CK2zpZZ9AONJYmIr0oUBrUd+
 f8oaVTGdgguISFAuAiEOAbVrFzSU7fOAPfQ9ebQS60VRMMEAVs/g+Hee7EESD+DN
 BBHl8SLJc+FUd3l45zvvJ1G6GP2wg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9g8bm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 09:20:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M9Jb0g004545;
 Mon, 22 Jun 2026 09:20:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66jweku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 09:20:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65M9KjWV3932774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 09:20:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ABB05803F;
 Mon, 22 Jun 2026 09:20:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C837358056;
 Mon, 22 Jun 2026 09:20:43 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2026 09:20:43 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH] s390x/kvm: clamp stsi 3.2.2 size
Date: Mon, 22 Jun 2026 11:20:35 +0200
Message-ID: <20260622092035.400959-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mP1WVK6LfXFtCv7ClVBnJ13D2kAQl0um
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5MSBTYWx0ZWRfX2swHsqFXoTGG
 drNL1XHQMOCg7bnNZm+ZqtHxE8AWMfJz+yRtFVz+ZYRY4MTnCGud6XlD7/z3K8DW7Av+fn+mOUl
 b8bQ8XdyakBfTC3go9LF33MTlGEwK0I=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a38fe6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=Sg5gpWOPNxpWzqQs3-0A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5MSBTYWx0ZWRfXwZ3ph/fB/Hbn
 CBIwWQ9eNwwzDA/zwQa1sgNtjtTZ0PPL0QftrqUWIOVUiCgJPn4FQg3eIxeI5SiORCO6phJZafN
 4JqFOfkPb7Dk6oHUo6rr/orJnCe+9oIBVuf4CRb/SLIV2VyAA3JjmSRmsX9MUCNA8/7uK9HZg17
 gTem1AXRzP+VmIDDb3w2/rANImUOJu4f0L/qIXDcyfuQ0jtU3CQdgGXChTUYfc6XjfAYt4T/Dm4
 P3oOb4os6wXxP6RCOWHA+YA6eHXlYN/fIWGDVbvrU4WSGgGeJDPB2JlWU3V/ugpb5+eKH/51epn
 bAZjkYuboqFfjLZxaPiLSzl+blweR1PR5C8SRcqCBOP/kp4waKujR/0RrFe5AI5LYb9RjWJz2pT
 b6yiYdtOj5XJMf63tGFhBf9IfYaMqkG00oKGeOQA8MKK39QI6HK+wvi+YBQzVDDJY37TODZLuVp
 rMu2GpCNHsZQnkEWh8Q==
X-Proofpoint-ORIG-GUID: mP1WVK6LfXFtCv7ClVBnJ13D2kAQl0um
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220091
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

The stsi 3.2.2 page is being prepared by the kvm module and the size is
clamped by the kernel. As the memory is mapped in the guest, another
guest VCPU could race and overwrite the count and messing up the move
operation. For any out of bound count, fall back to the kernel buffer.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 target/s390x/kvm/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ed8cd6b410..a3835573bb 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1791,6 +1791,15 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
     } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
         return;
     }
+
+    /*
+     * The memory was filled by the kernel but mapped into the guest.
+     * If something is fishy, do not touch the buffer.
+     */
+    if (sysib.count == 0 || sysib.count > ARRAY_SIZE(sysib.ext_names)) {
+        return;
+    }
+
     /* Shift the stack of Extended Names to prepare for our own data */
     memmove(&sysib.ext_names[1], &sysib.ext_names[0],
             sizeof(sysib.ext_names[0]) * (sysib.count - 1));
-- 
2.53.0


