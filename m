Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9B6CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAg-0008Md-8u; Wed, 30 Sep 2026 11:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAZ-0008Do-R0; Wed, 30 Sep 2026 11:24:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAY-000204-50; Wed, 30 Sep 2026 11:24:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE65Ie3172226; Wed, 30 Sep 2026 15:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kU+0FnvLhfF5GB5EU
 vcJVrnEdThXGKf4ji4hJnkp+OQ=; b=MB1h6OHirJppQFNeaohbqgJV2uH+WdRxN
 bksxu2PKeo/B4L+8xxIo0xMv9E1EcLAvz8aqLfUqmvxl2AG6T5hH3PohFVmkKREb
 ObJ60M8HgGAXzsO9r+YlQW4tZTRwIpUlGnQG6Nb7cewq6y8gOKH4MiMY6tGSeAiB
 QG6qlZWICi0kwHKghlD8rYfJKRSJP+ebkuhXeYb49f/HsVVA8XWCmIyXbf3Ee3XH
 PmtQxX27O6kYuOCo1I4mflD+7jA2nNa8XPE8FTA8Jux85QfDyrfVPyFT5AiroFtS
 BieipuObWBbGKk3u4fmIYN8J+J3LIYkAK8EtqpBDFM9gEWrbpAEFQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5dtr0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE34xU3605826; Wed, 30 Sep 2026 15:24:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhq2f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOPsm32309990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A983E5805E;
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 355455805A;
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 07/23] hw/intc/s390x: Fix check after g_try_realloc
Date: Wed, 30 Sep 2026 11:24:04 -0400
Message-ID: <20260930152420.1956230-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXxLXQXCbAtiyw
 mSfQwVulZqtRWSIz3n1qPoNjCmn0qR+DsaQZoA1PRUS+eRnS6eeJlmbiIlKAgRkbVSTYxW8yJ4g
 sDhpKfxB0qPCJUQzgNUAlHmAKGPgkVU=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd29ac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=M8FnGKaJMcETolB0Q_gA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: -ZGZqMBhyPH6ge9IVsYitL9NbYdjoiME
X-Proofpoint-ORIG-GUID: -ZGZqMBhyPH6ge9IVsYitL9NbYdjoiME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX+tUVk3FIZ7Ku
 per6QZyVAB5eY2ivuTq5pgeyF7F9HTLUWHSOnAZiczqDyR4lwk57bmLeKq0gt77nvC9fsvHBR3Q
 KDHFrRWKgS5hHmLEAQbZqxwRXDLd7Ss3ybNdJdcHDnyNb4SmmZpMFRU7Hphue3WLaymRafmWT5w
 +DKQu5i+O8I8cGjk+acMkfScV1REMReqfNk39N1da8KSfCDE0pvE5hngChVA9xStZtvkmxVTF/E
 rUb58cSd9iX1x2ZohLEspCkAJrc8Ih/x6zHtrPODm6OfppJY6R/h9Hd8yVayKmIXplsDmVv23yE
 7Zjr30td3U8NiJNGzRmYsPe2BkuUVXvJgkJDrjjGukmV0XYlx8FXqYyelWUNsr8nca0tKKMtSYk
 huBeV4c53zUsPo/1QQ12blFiqceTNoY2XSdMDe1seXx0prba5VNGP1tnQ/FogxAUazcHdRhpJ3B
 MgTfOcxm+ShE8Zj/fXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

The loop to store pending IRQs uses g_try_realloc() to expand the
buffer being used, but the returned address is stored in a
pointer-to-pointer, thus the check is supposed to be examining
the contents of the pointer, and not the pointer itself.

Define a temporary variable to catch and test the returned pointer.
If it's NULL, return to the caller to perform the free on the
unmodified buffer. If it's not NULL, store it in the caller's
pointer and restart the loop against the new struct.

Cc: qemu-stable@nongnu.org
Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller device")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-8-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 5e6d422fba..63c6ce81d9 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -254,6 +254,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
                           void **buf, int len)
 {
     int r;
+    void *new_buf = NULL;
 
     do {
         /* returns -ENOMEM if buffer is too small and number
@@ -263,10 +264,11 @@ static int __get_all_irqs(KVMS390FLICState *flic,
             break;
         }
         len *= 2;
-        *buf = g_try_realloc(*buf, len);
-        if (!buf) {
+        new_buf = g_try_realloc(*buf, len);
+        if (!new_buf) {
             return -ENOMEM;
         }
+        *buf = new_buf;
     } while (r == -ENOMEM && len <= KVM_S390_FLIC_MAX_BUFFER);
 
     return r;
-- 
2.55.0


