Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B12C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VF-0001Su-4E; Mon, 17 Aug 2026 14:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VD-0001SI-Jc
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VB-000632-U6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIW5sT2219898; Mon, 17 Aug 2026 18:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gSSWQe
 YQRUXqYZVgIDa+p65lSpMjF2cqOx7EqYE15dg=; b=Gco8hBstpBzwPeXastWA+M
 eanmmC00j0ZMrky19GtBfV2mmWsrOeqbE50l5akCixJAzK+3wyrZlTuRWeWG8nYW
 xbjUi6FwG4HIhnb9xjN7fpXbjMUhn2NhK/CjEtRx07rTDVwoe+/eC2fEQDG13iQK
 lgoIN3vIE/G/i9sdG5+KK831NQsh7PCKIWG8ivzdNdedUKqUHukjcNFDHkcvRlex
 YsmZl7YLgWpNFGG59F7G7cJdT0sgZJ0qVBuwukbLbyH2y9BJd4X5y/D8F02SJUOk
 FtsWacXY8lltuHPyxHOPmRG2BtA4RCCv8VVeZ43Bv9vvtPCVB60LTQ02EU/27AKw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt3e2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfLU0028907;
 Mon, 17 Aug 2026 18:55:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgy8hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HItouV26018306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:55:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFA3A20043;
 Mon, 17 Aug 2026 18:55:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D38B20040;
 Mon, 17 Aug 2026 18:55:48 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:55:47 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 02/10] tests/qtest: Fix virtio msix message endianness
Date: Tue, 18 Aug 2026 00:25:32 +0530
Message-ID: <20260817185539.376740-3-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a83593c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=Oifax1jXoojvXuSGEc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfXzFFwEgEj3MAE
 yi1LoWNNtF0jY4lme6yAfHCoWv+gLGMjoAap9WoUtXBEYKVODdhAYv07tyUJ12CHx/Q+EZ4nPNE
 S4WCyFh+OPqyvd7Vus7ZB+XzIO5vgCc=
X-Proofpoint-GUID: nFVk2A6Jy1IxjJWWNtCXUF-P6oGCuMBH
X-Proofpoint-ORIG-GUID: qIe7OgQiJ7j1SqvHC-H3j1nyLY0GhHvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX98qqZTAx4ZBR
 jzv2gD1QiKhr+GU2DhzS7XNCdfVh7i4zQ6/yL3Zi0h0zFJJ8oSAEgvKjuiRQbf6PLhO0AO4+HjS
 ppR6SRHINoKbcLB05nWlu9sFv1WrIdmA+56yXrkCC0zfFDhcZERJUlck3dycA30siVZkSETDjIu
 MJyOODHpHIkUK80p9xTzpMeQskIPNeNkk6VFN7UXHjJsXi6PNDP5sl3B7iRrlLibgWYR+GK/iA5
 ugem8YhnPVehoj/cA7sQghKaPD4FubZHasFXUGHR/Xm4cgJSqji8Koz+LM0eIqHc5ye5RhUAVk8
 7omm7Lh3IB3Qa8jQokq2jhE4ZqCmAgj82kKULWTorbvQTzkINi/sLa5TQ1RJ1w0rV/ci8V8aJcK
 FGtR/pUaxqcTd+gDeg0nVfBVufGF0y1i62b68A3sUJ4Z8eYahvpMB3IkOMb5TU9D2a3uCsCDEdG
 TC05RSG1tvHyPpz3B9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

msix messages are written to memory in little-endian order, so they
should not be byteswapped depending on target endianness, but read
as le and converted to host endian by the qtest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/virtio-pci-modern.c | 4 +++-
 tests/qtest/libqos/virtio-pci.c        | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index f31b3be6..5dae41e6 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -136,7 +137,8 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
         return qpci_msix_pending(dev->pdev, msix_entry);
     }
 
-    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
+    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
+    data = le32_to_cpu(data);
     if (data == 0) {
         return false;
     }
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 102e45b5..76ea1f45 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -131,7 +131,8 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
+            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
@@ -156,7 +157,8 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
+            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr, &data, 4);
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
-- 
2.55.0


