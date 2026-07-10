Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F07C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCPx-0000mP-PK; Fri, 10 Jul 2026 10:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPq-0000h3-LK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPl-0005VO-7E
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ADIGCP971305; Fri, 10 Jul 2026 14:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QPWJeCNNngU7FqaVs
 znAi5bRHUfWVCKx5JmJR5Xq2Tw=; b=Xw5wCYHU9DBrIf0aMNxyB6kBmnsOBAbrT
 2cDU6hSw7Wql75RNu8wzWvwrgFLc0ymCnbQ3TA4tJgfryeLaDtd66AuIYvgpySjW
 6oTziZ2iOcJ9UqI5dqqtoOS7ZK+u7j4TLvIE3UU+I50H4eUZgy6xWTfQixeCXdBe
 JOp4GU1cj6a0SSy9NA0r3u5dAdxZbTc0MlL83EssEEkof3lmKPh/pXKr4aV49P9Z
 XR9NatRYLxOMngyrToD00qLQoSbOFwPn/rCPm6PLw1eQHe7t1wBc6T/Md/aPojjT
 rlkLfHa10hgHPRrDfe2iUAgczGNKurG4Yi7Rt0a+E7+WZRrkN7x0g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw5797h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AEYciQ013526;
 Fri, 10 Jul 2026 14:41:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0htb7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AEfBtM62325224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 14:41:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82F5A58054;
 Fri, 10 Jul 2026 14:41:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 047AC5805A;
 Fri, 10 Jul 2026 14:41:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 14:41:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Mohammadfaiz Bawa <mbawa@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 1/3] hw/core/platform-bus: guard
 platform_bus_get_mmio_addr() against NULL
Date: Fri, 10 Jul 2026 10:41:06 -0400
Message-ID: <20260710144108.621828-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710144108.621828-1-stefanb@linux.ibm.com>
References: <20260710144108.621828-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wtW4jHzerNpnWVcuJXKUapm8NwMeGtkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX13u+0NtAhhn2
 5dU7dI7UuCsuCoVQdOwOzH1DE1+XWm41Lc90fyOy3o2TGIuOO9UKjSkcYQANnB0AHifgGB32fnE
 IovoXt/7Oo4CSENIN7dH+AjPcQqUhLKFo5bg9PFocxcqWnjoWUiRk3mM8NP+QQ4Op3FF970I6rd
 Le6z2kThO5uGOss8wdTiog3q6hmeh3RYjnjZUt7O7duQzPpoF7pE0Y+7jUBl5AwWM/ArphLbiL1
 M7xO6ShTR/d9P6R0NHuFD/43ErYfM1qNvHWb0Rz6azBZ/Z7ZGMfETvpVtn1xNkZHf80odo/5WLh
 o5PgbjAAJRKg29BOMTdwsSZO/vBoN8C5IOPlkXHKtzZG4bKJCpCqwJTEY1R5gDmmrrGQ4dsP3K7
 yNtpKZTQwsw6CrHSra8MaALUiQPsSxyfAMY1Ar45rn8/R+TPHOBvisBye2RzSG7AfwaF9I/7nLL
 nq/AC+oa6tYJbiBisGQ==
X-Proofpoint-ORIG-GUID: wtW4jHzerNpnWVcuJXKUapm8NwMeGtkY
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a510489 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=-kfjqqwatEbdier3Q44A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX/zA8fJH+l+Ui
 H3kNJlBkM3aJYfozC1XZDexDSqRaZzeXPM9XO3+OTPgWIrQ3R3/nitLsiLWVMiCPjZ2p9OrWLVh
 UpTanXfUgK9SwnlV9A8KmEYH/RjzizM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

sysbus_mmio_get_region() returns NULL when a device has fewer MMIO
regions than the requested slot index.  platform_bus_get_mmio_addr()
passes the result directly to memory_region_is_mapped() without a
NULL check, causing a SIGSEGV.

Return -1 early when the region pointer is NULL, consistent with the
existing "not mapped" path.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260619093140.832136-2-mbawa@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/platform-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index a2217a2dee..16d0ecc0f3 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -59,8 +59,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
     Object *pbus_mr_obj = OBJECT(pbus_mr);
     Object *parent_mr;
 
-    if (!memory_region_is_mapped(sbdev_mr)) {
-        /* Region is not mapped? */
+    if (!sbdev_mr || !memory_region_is_mapped(sbdev_mr)) {
         return -1;
     }
 
-- 
2.55.0


