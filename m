Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097F8CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9ji-0007wC-B5; Wed, 29 Apr 2026 14:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jf-0007t4-Bm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jd-0007E1-I3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TDP36H935847; Wed, 29 Apr 2026 18:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lbYm0T
 JdDIN9DDCvXgRz26JDSOmNN+9rTKX1RGG2yWE=; b=afEdnv8I8TQw1iuiAa048S
 /V6Q8v+dxU8GGGXOBOgnEvY7cSe46vLYv828gFbfMlqsDlSdwdBu6LVdRn0a1HDs
 onAGQnu8o7TFrIPyx7xtwiu+pwfV7Hr/maGh9l6pH1Xlk2d12HKLjjESBLE4ImV4
 rZ1ZQhfw90nawcyaXUyr9VxKoAJu+QkTTXv/fUiR6muMvcygcwYwAHKNN9v/3BKz
 ngtb7BRbH8A3U29mF9vdLNarUXublyIfRW+ZtNl2Tlaz7p190ZXYTuR8sKsJ6ukY
 RRGsH5+pfZPtI0brdTMeV0Y6IfxIxPGnwOHHepX9LTp43UJZ7eLy+IYC0ZxTiMOQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rc24b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 18:34:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINjmT014409;
 Wed, 29 Apr 2026 18:34:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqfqj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 18:34:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIY4C931654426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:34:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41BC32004B;
 Wed, 29 Apr 2026 18:34:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F413C2004E;
 Wed, 29 Apr 2026 18:34:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:34:01 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: kiki <Chan9Yan9@gmail.com>, Zexiang Zhang <chan9yan9@gmail.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/13] hw/intc/xics: Add a check for an invalid server id
Date: Thu, 30 Apr 2026 00:03:03 +0530
Message-ID: <20260429183310.12455-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: PVazXUW4Cwi1z9_6he6AkQRv1lkk8gw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX5NcN3C6kMjeN
 ZlOPyHiLTsEeb4NNQSXU6enfGZ2YRlyUH7TE/A7Wzp+fohwU8PTPeUvMHP9CzzCh6/88dYh5tso
 UnOHewbtrdybBYmxgY7DlEF1DHoSXHdyxCz2wOQ/l0tPgEVUfUPneDqcoql4Ef9W5+goi9MiVcy
 pjMHbF+45hWxTE61ZMO0ArjxX8UGvjexQ38rn3V7v6ioDpd09yc/b7xRgVCYRTAdfj84quu89zZ
 w03VqZkRhlACFaWMK9XU3sWUKZEuEUM0tcXbfguEuF8NbA16LNnSNE3TB38cswo1GHuO6f0M5E0
 7H5aDnWwYD/lbq/BibiHBaWp5dcGUA2X0yPYkpRsKIrCoNLR0Zd/bQyGlYEdm9IYtX8t0IOQWv+
 EmDqCHNYxoy+hD0OYtzUMVuAive7UmE8iwHGXSA6CZXZTLj53XMSgRmuyf6ugQcuH6UqfOZIXwK
 HzmK+Z+R8aVEzubvV2w==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f24f1f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=TGpnWNUbWJQoO7jwSJQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _uLaCzQFRz-DmcnV47_lXC37ZtFIdr5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: kiki <Chan9Yan9@gmail.com>

A malformed IVE value can result in an invalid server field being
passed to icp_irq(). The function assumes the server id is valid and
may access invalid state otherwise, potentially leading to a crash.

Fix this by validating the server id before using it and ignoring
invalid values.

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3324
Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260428103645.50617-1-Gautam.Menghani@ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/intc/xics.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c0a252d051..e32984e9fc 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "qemu/timer.h"
@@ -222,6 +223,13 @@ void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 
     trace_xics_icp_irq(server, nr, priority);
 
+    if (!icp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
+                      server, nr);
+        ics_reject(ics, nr);
+        return;
+    }
+
     if ((priority >= CPPR(icp))
         || (XISR(icp) && (icp->pending_priority <= priority))) {
         ics_reject(ics, nr);
-- 
2.52.0


