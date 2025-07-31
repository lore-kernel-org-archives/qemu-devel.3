Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB74C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 05:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhLr0-0000mB-5f; Thu, 31 Jul 2025 01:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpq-0007Uc-8Z
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:10 -0400
Received: from p-east3-cluster2-host1-snip4-7.eps.apple.com ([57.103.87.138]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhLpn-0005m5-Ji
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:28:09 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 43D9D1800120; Thu, 31 Jul 2025 05:28:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NW1fD2Mb3upL6hkpDTSF+2K6D3SQ4d3+mABFysdCU6E=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=BOW8IOKNlwDWpXUkv+iEkHTRMM1GCvPFlwnF2RkIfFS1qskpRzQ3urNiLSQOhGjBQFeCUgKyOPQOtRcrft3BtyKBoNkmrYmIvQxFKoBwacvo8mbkGWmgMWDa8cQj95OGB2UwGcY11IWMu4qy5G7jnSkE8gqaIiLptwxp0s1fIW+9uBD3Ti+cvh1+T+DhOyT4nATScgw+TaoKiTK+qjOTEF4US+W+jQ2FnKMJ49kHJr2qM2uD/Zr87Hm151ecFbWkk4dgFOABGgU0LZP6arBVQhF7Ak6cFBcjjvIM9Iwm1qTZBM1qNY+Leq1UAx6dDxZY4fgm0TKh0G2LMrGGlbjR3g==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 6DC6E180009C; Thu, 31 Jul 2025 05:28:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 5/9] hw/virt: make Qemu aware that WHPX has a vGICv3
Date: Thu, 31 Jul 2025 07:27:49 +0200
Message-Id: <20250731052753.93255-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250731052753.93255-1-mohamed@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P--x1FFXyLYH7V36YJfpURK2uykTJ6JF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzNSBTYWx0ZWRfX4zA61keFxr+q
 Tg/Lovod/aLtkPphSRhhJxCyvO7T/fix8mKikq8wWLGL3Ws68qKGzYN0q/sn9/hXqa2KlRpw/NH
 Yibw1t3JgsS2r9ghfIrmhZGW+25agylY1OmM37xi/WE1MVU+qVZhoGBLoZ2KcVWnB7MMVogQM1D
 uqiU2W9+rxOhoMXatQCbwzktA8tLCwrLJxTpxKA/2CxmhjgzVwuXixWp0GcsJWU1qoPUHrmBXEt
 3ONKnplKejX8wZKzaI280UTmJZWqBzaJA8uwWxkw5IG5HPWNsr3yo8pp6UV7p6rWE3riLcpW0=
X-Proofpoint-ORIG-GUID: P--x1FFXyLYH7V36YJfpURK2uykTJ6JF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 spamscore=0 mlxlogscore=854 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507310035
Received-SPF: pass client-ip=57.103.87.138;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

WHPX is a vGICv3-only target without vGICv2 or user-mode irqchip
support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f..4996c2075e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -49,6 +49,7 @@
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
 #include "system/qtest.h"
 #include "hw/loader.h"
 #include "qapi/error.h"
@@ -2058,6 +2059,8 @@ static void finalize_gic_version(VirtMachineState *vms)
         /* KVM w/o kernel irqchip can only deal with GICv2 */
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         accel_name = "KVM with kernel-irqchip=off";
+    } else if (whpx_enabled()) {
+        gics_supported |= VIRT_GIC_VERSION_3_MASK;
     } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
-- 
2.39.5 (Apple Git-154)


