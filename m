Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC85C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbC-00014I-3V; Wed, 12 Aug 2026 13:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZw-0000BG-3P; Wed, 12 Aug 2026 13:17:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZs-0000q2-PA; Wed, 12 Aug 2026 13:17:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1fpU4120470; Wed, 12 Aug 2026 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2RbTbGmrU4jKsusYt
 Zsy/euM0jgTxne1kpJ+lAsgieE=; b=eunrdSvJR7MDEgrol4dD6uGbrIQELFR72
 T8j2/bxZYC7wUg+DNMfQJWV5pM9ouTAg73A35pp9RrqfHmO5pp0YS0nFB0dZ5qI7
 vrPcq6NDaMmybkPWOj64ZQNoV9vX9p6bof37XicQ+2yN1Z30aaZOuHIrr/e01/SQ
 1Mnti8T4Rck62+kBd/MFtywTobJYGqg9bIHk2uwv0gfKKFbgLxYGfABFkOV1o2CW
 OVDde4hgfJ1Cpe7xnWdnQrUip/5Q6k8sVFHgLBKE3YOcoEIxmVNGd2oAAbbcWLSL
 KP9Vd+EsNRJHhgiRQjvf/UR/5JDsJ7wndspJ/Kbz/54Z5FKLBcIog==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwavhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBQDI028255;
 Wed, 12 Aug 2026 17:17:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjy4sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHGbnT3801630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:16:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBF565805A;
 Wed, 12 Aug 2026 17:17:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14D785805F;
 Wed, 12 Aug 2026 17:17:15 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Joshua Daley <jdaley@linux.ibm.com>,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 07/15] pc-bios/s390-ccw: fix out-of-bounds read in
 iso_get_file_size()
Date: Wed, 12 Aug 2026 13:16:59 -0400
Message-ID: <20260812171707.1605637-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7caa9d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=7LMK5Y9_BSpTnHNW6BwA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: ioL8opsAL5sZapMHPsrYxjLbV1WYzX0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX01NRvxmJLOCm
 PFEjNVQjdzPTFTFD31Ra2uLPIitDYVlgnePdtGgLczMY+4Lkw2uJOoc0SaFNv8amZi39WhSRUe4
 23ykukfHji26Qd+AqK9nB10kX+hyFSk4aaWdCgN1Q4duP00+pmnCb0PVbjQPflgIM6MwaDqoJPX
 NWQnjKKeCHNxWbLXcYwiZ7xEV/KMMjh3vOr7SpH7NFcMInLvmC3p7sS0YPGHYgBrXi+cSWg69nb
 R3sW3vD7kzQQ/ZGTlgA4YovaAaWhjddis422zxT9X6PY14zKOIAvEEG1TaRKc87cu/I2TegpLMl
 2xAJxDz3ApIXPOFiO9PR/T2D4JRljHu+Cezcvm3f9YxBJxIjLUED4Jm7z0yYEnHy1pnJyJgzVkJ
 +Nhtm1I2n5ojo1sTa1SsctCSRxzlPc9XPhqTfHGcY+PI/BRJxR4AMhyIbbjzkXrC92L6eUWQpme
 hNHXm9FD4nb+EHawFyg==
X-Proofpoint-ORIG-GUID: ioL8opsAL5sZapMHPsrYxjLbV1WYzX0s
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX9RvAAl6Hb6SF
 lB73wDVPaPV9D/8CNvpKfEYSO9It5Ge6jOl9aGzxgQZUUZlBhVKBWzQCkxK8EEC3/6f39ji45+P
 oIU2Eh4w+wU9JuAKunO4tNYbuXIOh5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Joshua Daley <jdaley@linux.ibm.com>

In the dir_rem[level] == 0 case, level is decremented, then
a virtio_read() is issued on sec_loc[level]. If level is -1, then the
4 bytes before the static sec_loc array are read, and the virtio_read()
is issued on that garbage block number.

Guard the call to virtio_read() against the value of level to prevent
this.

Fixes: 869648e87eeb ("pc-bios/s390-ccw: El Torito 16-bit boot image size field workaround")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-4-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Fixed typo on Christian's tag, added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 420ee32eff..ed6e8cbbc7 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -902,7 +902,7 @@ static inline long iso_get_file_size(uint32_t load_rba)
         if (dir_rem[level] == 0) {
             /* Nothing remaining */
             level--;
-            if (virtio_read(sec_loc[level], temp)) {
+            if (level >= 0 && virtio_read(sec_loc[level], temp)) {
                 puts("Failed to read ISO directory");
                 return -EIO;
             }
-- 
2.55.0


