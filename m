Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD94CFA76E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO09-00052s-5I; Fri, 21 Nov 2025 05:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzX-0004jC-Sw
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:49 -0500
Received: from p-east3-cluster3-host7-snip4-4.eps.apple.com ([57.103.86.67]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzJ-0007uh-Ki
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:45 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 3B63818010CD; Fri, 21 Nov 2025 10:03:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9W3/gkmYU0HZ8GpjnhrSzifwyhYfOKRgBYQL7/6vYH8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MkbBFEpfaZi2+YKKTYd6wL//DHezAVUixdbVUkwnRon+Zf/sw/+s1S3ageK8cUndtcFP/MdgOcavWftvVCD5PaOAvRc6LvDAq220Ak9DKN1KMUknf3mNc6dpRUYyXUje08g9Lk/o2xWrRXs0ILYpYUZUiE4GCfwWAbkoTazHTMV288E/oXzzV5hcFzfJkNYEDUiQLEMqSAU++19HGO9USV0qDKvvfo+ajrN8vj1x1yvZ/tXAQIaZPwc8NEv6/VplCNdeTUhKUbziYSkKzRc/h4erPZJinN2wtmSoG8u33H/Pkj4OmEhsu7575a8r2wcj+hgixFGKZ5Z+fAEB8GBWew==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 1CFB118000B8; Fri, 21 Nov 2025 10:03:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 11/28] whpx: switch irqchip in kernel to a bool outside
 the struct
Date: Fri, 21 Nov 2025 11:02:23 +0100
Message-ID: <20251121100240.89117-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=T/2BjvKQ c=1 sm=1 tr=0 ts=692038d9 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=flQ0qPZ-L44n-5z-kFYA:9
X-Proofpoint-ORIG-GUID: x6puwTrLHKF-I1ad95QrBjx1eu_ecKgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX1y7Tg/snnMj1
 Q2Y+/TDOdQCMjkMSlR56m9vo6BpMmLOAocgXPeM8IMq6KK6ijudJblfMxtNVdCjNocs6wxWa2ct
 37Y7mPzLvFhRtKKsxJVoIKEAhnrhNUn6Qv55xQdinTw8FO0+KWeXM3Mug/BfSYIrWPU6JOgVrM0
 s1dVLBMtXbXlY8bCvKyRN0yaz75okICdcTMVSK9UCpIzin6puv9D8mz/8mzC2M7v5mDZIHXBu8/
 oOoZM4uzhjP+HKgzFJ2DgAL6dRjOCoWOOhmv31591UsCPJCqjOHyxCYhpWDRlt0V+0aY6Ljg4Og
 o9LWSbMcNCnzW4nXazy
X-Proofpoint-GUID: x6puwTrLHKF-I1ad95QrBjx1eu_ecKgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 clxscore=1030 malwarescore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABsoTDkscOsxybTCIn3m8dBB8sbF1x9cOXnsXgc8c6CP7BRW76p9A+Z+90zPVfAvY3Z7zIrNYvn0MuOAaQUz/l/jLaDWmk+K+oBchjF4IdEsKfk/Jww3s4d9XrHJb0VZ4nJrCETGo9DfISV7gkzqi0mu6EQGbP47Y7V11KOf0Y69QMMn8kMHZM/SB8dGs2NUEVveGBQ7AfEVwCfosL7Z3OoYS5oda2Y7j8Zy/vuIazaLWQjphm6ytlVzGI0j8qMPJr5qPhWFKNbQdxZ63WKyXsz6hkC9v1j/mqTkQOuyiXfHYfF7csM42PiK/e+1rPwV3ykQKHsEEATDI6SkGMuaRUPSc97C3/iNPDZvzacTm4/uBXKYalqx0Fd7C7eWplWbLHzpsoE7XRQCsqzxFlkMSxN0yoApE+haAyW9xvGdfF697QATPGNBOU/LbO4toOR0mGmZga0tQAI7VnXIYLQL5duNwzsNTZH9FiZ1SKciZLoF6uWgEI3w6LovU9DFzibmuultnZboj/o0UTocLhUzkjuPocBgbn0ZdEhGPMklVpzne0HntsbnSuKKLNxe4eVZ0foJ31jFUs2kXWz5ZFs4c9OOCrE697eYmHJ2TPvk9RPdjV2LiOJ98r83QE7YzqnRwAO7m5gjHOZMztq80mKJdraOJV8uiuOyvOAU+Qnr27Iwf8ToaKOc1cfpzD9FCFZ8mgJgybZHCQTzoDLhl4b9P3MjZdXQwO+k7AgjF4LYmwobcslQ==
Received-SPF: pass client-ip=57.103.86.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix buildability on newer Qemu.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/stubs/whpx-stub.c        |  1 +
 accel/whpx/whpx-common.c       | 10 +---------
 include/system/whpx-internal.h |  1 -
 include/system/whpx.h          |  3 ++-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
index c564c89fd0..4529dc4f78 100644
--- a/accel/stubs/whpx-stub.c
+++ b/accel/stubs/whpx-stub.c
@@ -10,3 +10,4 @@
 #include "system/whpx.h"
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 18d93225c1..4dabe3a032 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -39,6 +39,7 @@
 #include <winhvplatformdefs.h>
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
 #ifdef __x86_64__
@@ -492,15 +493,6 @@ static const TypeInfo whpx_cpu_accel_type = {
     .abstract = true,
 };
 
-/*
- * Partition support
- */
-
-bool whpx_irqchip_in_kernel(void)
-{
-    return whpx_global.kernel_irqchip;
-}
-
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 81c0c1819f..b1706a2749 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -44,7 +44,6 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-    bool kernel_irqchip;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/include/system/whpx.h b/include/system/whpx.h
index 98fe045ba1..4217a27e91 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -25,8 +25,9 @@
 
 #ifdef CONFIG_WHPX_IS_POSSIBLE
 extern bool whpx_allowed;
+extern bool whpx_irqchip_in_kernel;
 #define whpx_enabled() (whpx_allowed)
-bool whpx_irqchip_in_kernel(void);
+#define whpx_irqchip_in_kernel() (whpx_irqchip_in_kernel)
 #else /* !CONFIG_WHPX_IS_POSSIBLE */
 #define whpx_enabled() 0
 #define whpx_irqchip_in_kernel() (0)
-- 
2.50.1 (Apple Git-155)


