Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EFCC531FF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3V7-0005Cy-Lq; Thu, 23 Jul 2026 20:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3V2-0004zT-Rp
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3V0-0006CL-U8
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeTMA948933
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ft+v/2Z62EU
 zmf/aX81ryG7chusTN5hSEzX0umqpK/U=; b=T+UFHcKFkMFyW4cT6bLnYj2yNdK
 ZokP0Di3k9hNbwLsDV3MDvRB6uJqCmmKOymK7/zof8zfdkTNaEjfECsdW4wZHouz
 aui0oMsuM7Vh/OuMokeUndbcXQLQM5NlfeeV1R77Dx8KnTOfW9JVgLBRNLR4Ihnj
 uF+vcFVRFMEb6ZZ67UYx79hfTn0gqE60qrvy9PvLbqysqgz3ph/c4fBQ5e2GVJ3F
 EWaS1PaD80/af5qVT/nGSEOEg34GA7Uui8aEwNTsdjXuptNEXE9k704g38zuI8YO
 fYEdz8uS+ofqoMa5ueaDnFTfm+uHFc1k5ZAZleSPUE14SHjsNp4F7tm9ahA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0kv2gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab041eced3so1919443a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851835; x=1785456635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ft+v/2Z62EUzmf/aX81ryG7chusTN5hSEzX0umqpK/U=;
 b=ZnMGDIfBEGRmFxJekWHLtCUd+RXAQSZbQU7LAmh3AiR87R2VC1gKuRStafFm1juOgm
 3wmcDoLSiY0W3MG0TKOjs8713wCDI9ldUYa2VYuOcFrVVJRx+MX9VP30O65Q5c5zXb0l
 m7HjhgxrqqhhAlxpPW75AGKgeHvQKO+qijzcT3q7phNJH/l9QeVbrVP8H/sbdnIrRsvn
 XX+wW7VovJ6cAczzCaFMEqUKP7n8vHhWHUy+gewk8s0hJsfUAqGCztAGD+UHsuwgO80i
 yNlyUxRVVgWmsSCqCZOc4+dVbnqDoyiQq1XzaENq41iryNwOWqj++7P4kEejReTCRJgY
 ICpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851835; x=1785456635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ft+v/2Z62EUzmf/aX81ryG7chusTN5hSEzX0umqpK/U=;
 b=kJd5ERJCKpA9xfztiguBoVhq0GnPxsOIDpdcFyBpD8E9c5IyvZCgQQSgjL3a0KHpv3
 TCiv0e+t5RLbgxbEIlIWAdNv7jvKaBpEWUxkowzWG39bqyePtGudaojf1Tf8j8/UNBQt
 +WltHgq+ZkGI45LVn76Fujc5XWxQzk/6lVCjGqSDWwwfSVXUutjkHpcG6PjCDzykLvhv
 NOoQ+MY0SFmb7AKSKujagoCuk+vhWRJBm1QmWCCuEciBxgS6cEYs/ZTvhtUuTVxX4HnE
 0SQv5GW5JpDyKiC1ERIkHfE4e2QQHCSy7v1mhCK2t+i9FWEdMfGOLYdxyoy4GnqRgYhp
 lz9Q==
X-Gm-Message-State: AOJu0YxuFzGGhr0uvo6YUa8GMxm+v0HCU9Dl+0GpX8VK/1AhoSGA47c+
 3Dfpdw+wFH1IigEwsCz5BjHB5j/yazf/Nyds9wRlcYhie1j//YQMAL6VmhvwoC65GYWaWq7kN/B
 RmfYL+wyrNZmgZF1uBFyBCKKLyluBvcBzhOD8qZXkCbqN/+0thfvTd/D6mnOTHa1cCQ==
X-Gm-Gg: AR+sD11Q/xHOdwOcumXpu6EdYpAoeMMC/ya8lmFHhJa68LQSL4AF16bHzpHfp5E5suz
 edGB1ldk05VZMbdT/DGUb6bPcBBbvYbQ+BwN+V9PP9BSRz2EbXNfpLcsSFAtEV8ctkKx816ujau
 iOGwqbp5TKqaqRKPo0h6O7oRbKPu4SmJOk1xkIG4WILnIGH04MN7EIr0wMoPheEgfCjBGN6U+z5
 6f8tRle/HUYX2lWuYnQpVAN24lUnMQZgefrhFTt5c+6yVzGqfXV27ACejZGfv8y6eXrnl8ea7uM
 A+Dt88ECJ1cBtz+WKUbaqFMWyaP3ZRriSmiHKSdP5ttaZzK+dMeJOCPt0WB3yrp20OT88m5tIX0
 OK+xDB4oIeffwmRX1Dnm1H7t8zztyVX9JlXqGt/yMUqIBJl6JUIyDwCWu5tmzZACGoel92KM=
X-Received: by 2002:a05:6a20:748e:b0:3c3:9a32:70ac with SMTP id
 adf61e73a8af0-3c44b191b31mr5805111637.48.1784851834960; 
 Thu, 23 Jul 2026 17:10:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:748e:b0:3c3:9a32:70ac with SMTP id
 adf61e73a8af0-3c44b191b31mr5805076637.48.1784851834524; 
 Thu, 23 Jul 2026 17:10:34 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 26/27] configs/targets: remove target info definitions
Date: Fri, 24 Jul 2026 00:09:46 +0000
Message-ID: <20260724000948.234657-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s7bhHOa-oeyNa5eZeoiBgZXoGv0TJoW7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX7/vPJkJtyIJk
 9hZ/fbL7bnT08P+7aq31MIfyQCF5b1UBUI7WRq3pHquo5JUvvvZbIT9bgTP3YSzatlDIlWGsn01
 Aikp5uulExmKFVFNOoJPZUqcjsn2amM=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a62ad7b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=NodBhzTh5T1XzD5vBEwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: s7bhHOa-oeyNa5eZeoiBgZXoGv0TJoW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXzzrgN3z/flBD
 PcjUcmo+guln9C7QxlOpKEQEBAeikk0SDF48YCCebp/aQva6yes5tjj3JmBJC0PcGuUiy0SFCRL
 OpEJitfqDqCq47kmcDpFZ1ChphCw44OqDfvyGfhlHJ5Mij0zdlmPewXrIGcpyH1HZBjjwSnMxtt
 x22H2nVFOJkbeOHCqal7KmWkgTDUQeH4xr67qENtnjn7Y93uSICHA0tvmj/FTQXGQkGbYTpmq7s
 S/K+KzgAmVZhCHYD1G8p7fW4UTziJvRzgIQjPZvClMdlpwlVahjd7ViJF/pWticShIBpNPsRsHy
 wcZS7wVz6jQFAKz+LPFdccTp79en5zO6AGyRnj/K3HraFWt+B6GMT5XWtkf0pUApnjdcyn4XXZT
 bgzMZbYQcbHmVt727U8+NPtAQImjOdstrJwdWyF69jfrKY0bfgxob3Evdc/W1t40E+KpExHCtO8
 ypAjpMKdnbRhygBKtAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Now that we remove machine_typename, we don't need to keep duplicated
file per target anymore. So we can just rely on target-info-stub.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 46 -------------------------------
 configs/targets/arm-softmmu.c     | 46 -------------------------------
 configs/targets/meson.build       |  6 ----
 configs/targets/riscv32-softmmu.c | 45 ------------------------------
 configs/targets/riscv64-softmmu.c | 45 ------------------------------
 meson.build                       |  7 +----
 6 files changed, 1 insertion(+), 194 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
deleted file mode 100644
index 9efeb366e3b..00000000000
--- a/configs/targets/aarch64-softmmu.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-aarch64)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-#ifndef CONFIG_USER_ONLY
-#include CONFIG_DEVICES
-#endif
-
-static const TargetInfo target_info_aarch64_system = {
-    .target_name = "aarch64",
-    .target_arch = SYS_EMU_TARGET_AARCH64,
-    .long_bits = 64,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-
-#ifndef CONFIG_USER_ONLY
-# ifdef CONFIG_MULTIPROCESS
-    .config_multiprocess = true,
-# else
-    .config_multiprocess = false,
-# endif
-# ifdef CONFIG_NITRO
-    .config_nitro = true,
-# else
-    .config_nitro = false,
-# endif
-# ifdef CONFIG_XEN
-    .config_xen = true,
-# else
-    .config_xen = false,
-# endif
-#endif
-};
-
-target_info_init(target_info_aarch64_system)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
deleted file mode 100644
index 8785ea01824..00000000000
--- a/configs/targets/arm-softmmu.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-arm)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-#ifndef CONFIG_USER_ONLY
-#include CONFIG_DEVICES
-#endif
-
-static const TargetInfo target_info_arm_system = {
-    .target_name = "arm",
-    .target_arch = SYS_EMU_TARGET_ARM,
-    .long_bits = 32,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-
-#ifndef CONFIG_USER_ONLY
-# ifdef CONFIG_MULTIPROCESS
-    .config_multiprocess = true,
-# else
-    .config_multiprocess = false,
-# endif
-# ifdef CONFIG_NITRO
-    .config_nitro = true,
-# else
-    .config_nitro = false,
-# endif
-# ifdef CONFIG_XEN
-    .config_xen = true,
-# else
-    .config_xen = false,
-# endif
-#endif
-};
-
-target_info_init(target_info_arm_system)
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
deleted file mode 100644
index 2ab4d27eaf5..00000000000
--- a/configs/targets/meson.build
+++ /dev/null
@@ -1,6 +0,0 @@
-foreach target : [
-      'arm-softmmu', 'aarch64-softmmu',
-      'riscv32-softmmu', 'riscv64-softmmu'
-  ]
-  config_target_info += {target : files(target + '.c')}
-endforeach
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
deleted file mode 100644
index 671772aa40c..00000000000
--- a/configs/targets/riscv32-softmmu.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv32)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-#ifndef CONFIG_USER_ONLY
-#include CONFIG_DEVICES
-#endif
-
-static const TargetInfo target_info_riscv32_system = {
-    .target_name = "riscv32",
-    .target_arch = SYS_EMU_TARGET_RISCV32,
-    .long_bits = 32,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-
-#ifndef CONFIG_USER_ONLY
-# ifdef CONFIG_MULTIPROCESS
-    .config_multiprocess = true,
-# else
-    .config_multiprocess = false,
-# endif
-# ifdef CONFIG_NITRO
-    .config_nitro = true,
-# else
-    .config_nitro = false,
-# endif
-# ifdef CONFIG_XEN
-    .config_xen = true,
-# else
-    .config_xen = false,
-# endif
-#endif
-};
-
-target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
deleted file mode 100644
index a28b99fd64e..00000000000
--- a/configs/targets/riscv64-softmmu.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv64)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-#ifndef CONFIG_USER_ONLY
-#include CONFIG_DEVICES
-#endif
-
-static const TargetInfo target_info_riscv64_system = {
-    .target_name = "riscv64",
-    .target_arch = SYS_EMU_TARGET_RISCV64,
-    .long_bits = 64,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-
-#ifndef CONFIG_USER_ONLY
-# ifdef CONFIG_MULTIPROCESS
-    .config_multiprocess = true,
-# else
-    .config_multiprocess = false,
-# endif
-# ifdef CONFIG_NITRO
-    .config_nitro = true,
-# else
-    .config_nitro = false,
-# endif
-# ifdef CONFIG_XEN
-    .config_xen = true,
-# else
-    .config_xen = false,
-# endif
-#endif
-};
-
-target_info_init(target_info_riscv64_system)
diff --git a/meson.build b/meson.build
index 2b5db0d096a..6cfa0e6e754 100644
--- a/meson.build
+++ b/meson.build
@@ -3745,7 +3745,6 @@ subdir('dump')
 subdir('accel')
 
 subdir('backends')
-subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4322,11 +4321,7 @@ foreach target : target_dirs
     endif
   endif
 
-  if target in config_target_info
-    arch_srcs += config_target_info[target]
-  else
-    arch_srcs += files('target-info-stub.c')
-  endif
+  arch_srcs += files('target-info-stub.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
-- 
2.43.0


