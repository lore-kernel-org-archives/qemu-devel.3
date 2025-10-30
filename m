Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B60ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMK-0007lw-GM; Thu, 30 Oct 2025 04:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOMG-0007gD-4C
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM9-0007U8-52
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TMkVUp019602;
 Thu, 30 Oct 2025 08:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IrH0MW
 bPHZa8iRM5jsV9yoO8WIE3kB9TPlN4okhLTSs=; b=GDBRGwAf8JRW1VcFx+QP1j
 nOGIkaRgseVeqpMX+8SC4ASpSQL9HS+O6wIpRLCv9fH4cpZ/8MWD6DtlKl3FIa4E
 KlP11Ft34/FVF3h9dC5vGlpOwAusvFgJy6McucSksBU/LquvwI4JH6161czEfWBC
 KwRVLVksNnL4F6bs/NVYiWvbj+0SZlcaC5SaJ1AW1j/TDnbzUdUhPljkaWw4ygee
 M/dx/gx3c5AhjXstA+SLaFgmXqwhsvHdiuwCytZwqeDxRwRY2ME1caGItfTESGgC
 ry++5w9Uau7GzPQlhZiDX1EnEENF7sDfea56tFYhvsZHi1Q+9YgSP6LyC/gOe2rw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agq82f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:50:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5g8hm030770;
 Thu, 30 Oct 2025 08:50:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwqra3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:50:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8nw7g34865418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9665020040;
 Thu, 30 Oct 2025 08:49:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8AC42004E;
 Thu, 30 Oct 2025 08:49:57 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:57 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] hw/ppc/pegasos2: Rename to pegasos
Date: Thu, 30 Oct 2025 14:19:35 +0530
Message-ID: <20251030084936.1132417-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=690326b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=B3uDY4gyMZ762VzqnAwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: Rf7JGX2zAdhIW7bOSNQr6U6rhSsv087L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX9yxxk2s7SwiM
 7BZfmqYSYWSu3o0vBqVymcxvKG6qD9LxFfbdKLpoMSZfUr9qMJXsQbnPSU0YtJLWQujUuUbjEb0
 X2C1I9dnbI3XmGK3ldqKzLs7rQGam4Zh2b8vkBju+HUjfNru7+UwC1g606z2tEEJML7p3w5S5UT
 A8bQiJKx0tqav1Oqz1RkSCW8EN8ONGdcz7wGgsrIhoiKkgE844MbDLp4BMYTfWiWa1B4Jl5ZcHm
 yDZM+z72lkCRleCfdEGymly8MOmfiZf5LOIUKQSRzSNOz8WDM6ic4x93Ef0/v//thMVsg+edRd3
 n9XnSPuKnOgzx3fx5gFJob9udEl60iB75Lyay+icPu2F8lGk4D3K8Mj+GJ0pFBShM6/jrVLzbLB
 TKPyz10wSzwsgm8yZe1pdDaOWh3KLA==
X-Proofpoint-GUID: Rf7JGX2zAdhIW7bOSNQr6U6rhSsv087L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Now that we also emulate pegasos1 it is not only about pegasos2 so
rename to a more generic name encompassing both.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/275cd2d5074b76b4a504a01f658e85ed7994ea3e.1761346145.git.balaton@eik.bme.hu
Message-ID: <275cd2d5074b76b4a504a01f658e85ed7994ea3e.1761346145.git.balaton@eik.bme.hu>
---
 MAINTAINERS                             | 4 ++--
 configs/devices/ppc-softmmu/default.mak | 7 +++----
 hw/ppc/{pegasos2.c => pegasos.c}        | 0
 hw/ppc/Kconfig                          | 2 +-
 hw/ppc/meson.build                      | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)
 rename hw/ppc/{pegasos2.c => pegasos.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a620ba87c..8063eefa2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1648,11 +1648,11 @@ F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
 F: tests/functional/ppc/test_sam460ex.py
 
-pegasos2
+pegasos
 M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
-F: hw/ppc/pegasos2.c
+F: hw/ppc/pegasos.c
 F: hw/pci-host/mv64361.c
 F: hw/pci-host/mv643xx.h
 F: include/hw/pci-host/mv64361.h
diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index 460d15e676..180ae31e2d 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -13,15 +13,14 @@
 # CONFIG_PPC440=n
 # CONFIG_VIRTEX=n
 
-# For Sam460ex
+# AmigaNG
+# CONFIG_AMIGAONE=n
+# CONFIG_PEGASOS=n
 # CONFIG_SAM460EX=n
 
 # For Macs
 # CONFIG_MAC_OLDWORLD=n
 # CONFIG_MAC_NEWWORLD=n
 
-# CONFIG_AMIGAONE=n
-# CONFIG_PEGASOS2=n
-
 # For PReP
 # CONFIG_PREP=n
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos.c
similarity index 100%
rename from hw/ppc/pegasos2.c
rename to hw/ppc/pegasos.c
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 7091d72fd8..347dcce690 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -92,7 +92,7 @@ config AMIGAONE
     select VT82C686
     select SMBUS_EEPROM
 
-config PEGASOS2
+config PEGASOS
     bool
     default y
     depends on PPC
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 6b7c1f4f49..f7dac87a2a 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -87,8 +87,8 @@ ppc_ss.add(when: 'CONFIG_E500', if_true: files(
 ppc_ss.add(when: 'CONFIG_VIRTEX', if_true: files('virtex_ml507.c'))
 # AmigaOne
 ppc_ss.add(when: 'CONFIG_AMIGAONE', if_true: files('amigaone.c'))
-# Pegasos2
-ppc_ss.add(when: 'CONFIG_PEGASOS2', if_true: files('pegasos2.c'))
+# Pegasos
+ppc_ss.add(when: 'CONFIG_PEGASOS', if_true: files('pegasos.c'))
 
 ppc_ss.add(when: 'CONFIG_VOF', if_true: files('vof.c'))
 ppc_ss.add(when: ['CONFIG_VOF', 'CONFIG_PSERIES'], if_true: files('spapr_vof.c'))
-- 
2.43.5


