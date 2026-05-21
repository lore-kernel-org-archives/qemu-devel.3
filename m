Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2270CD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ89e-0004ra-Fu; Thu, 21 May 2026 14:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wQ89c-0004rC-Pf; Thu, 21 May 2026 14:29:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wQ89b-0001XZ-7f; Thu, 21 May 2026 14:29:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L8ffv0591905; Thu, 21 May 2026 18:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=LwARbCK5+Yx12ERuQlkJJxEFLKWZeYFoPDNh7uCQR
 kg=; b=tDvHcaQVdN/0x/nh2vVpMN/2Zxil2FlbGU+ZX21JNfdeR35lAYB5f58QV
 YkCHURwYmzddIhaLxCDXQ8Yj4sW5K6wmJQkfijMM8YHg/iqQ1ZtV5vOoDyLQ7UwR
 D92BiVa1Cpwr75LhGz1IdljCDuyeTZRZun5OeWWGTUDtYajLdqnAZryBq4rnjrrP
 GmM+NKf+BHxkEwhIOkPFsFpQgAjfE4xaQFx9FBBXJ3oztCcVKDvp/5g7qCKdR9X9
 hKA+TH5d4TaoM1vyAZuQwn1WkFfWOKTuRowc0pIzvZDtoODwVfOnN9JxMefdUMOQ
 5cv3eFSrd1Ga1F9aq2cy7Su3DCcJA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h758g08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 18:29:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LIO6vu028187;
 Thu, 21 May 2026 18:29:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkdk1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 18:29:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64LITIpf21889744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 18:29:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D04DE58056;
 Thu, 21 May 2026 18:29:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B46158052;
 Thu, 21 May 2026 18:29:47 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.49])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 May 2026 18:29:47 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alifm@linux.ibm.com, qemu-stable@nongnu.org,
 Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v1] s390x/pci: Fix interrupt forwarding disable for
 interpreted devices
Date: Thu, 21 May 2026 11:29:46 -0700
Message-ID: <20260521182946.1607-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0f4f1e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=dVcCwYAGXp18CurUozYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: In8rO7-Vl9ivIzAa62uGeMbka2cvSNM7
X-Proofpoint-GUID: In8rO7-Vl9ivIzAa62uGeMbka2cvSNM7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfX/muKIc9rRbqX
 OouNz4nPu/WkLQhAB9eQjlqdnkXOg01bkC29zNg5U8Z1SNcOaGA7yzPnowbP3tzqAo3kTz/x59y
 +dzhvHlGkhqkDWFiCk3+GVALleNI3C1AWTkq5O1cV4J7u9A/j9UWO1fu8vBV0Ra6jqyJmzJ/n/s
 kRDWgt9S3v0tyWMKfVjmO1FqltUOffjJ0ii9WhZV483rTTUBQg0s0H51q18uxxDMvUZrRx6vzoi
 T0NbBa+6no0rOFSLEIOywxQMOaZaLgu6lMJMQ0ejehSrYawLet3kge+h+kAEqq+IL91O6PDe3h+
 OvvbknhWWuq4TpROS0edBkgQkgJmQ6oyjvwMOFLFYkfFXwrM3IlaEl2lm9LdWbB7matihH7MEON
 5Wy+SjDAsX8LO+NpCIiiCmi6M3ayDlK0FM/w5O9mHRnxbuT3bTSeeXpT0ToSPVLbD5XfxC7AakD
 xvBNvLecLHezqYvzkKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210182
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Remove the FH_MASK_ENABLE check when disabling interrupt forwarding
during device reset. This check was broken for the default case in
the switch statement above, preventing proper cleanup of interrupt
forwarding.

The pbdev->aif check in s390_pci_kvm_aif_disable() already guards
against double-disabling of interrupt forwarding.

Cc: qemu-stable@nongnu.org
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3665aba106..2f7b214891 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1542,7 +1542,7 @@ static void s390_pci_device_reset(DeviceState *dev)
         break;
     }
 
-    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE)) {
+    if (pbdev->interp) {
         /* Interpreted devices were using interrupt forwarding */
         s390_pci_kvm_aif_disable(pbdev);
     } else if (pbdev->summary_ind) {
-- 
2.43.0


