Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9C5C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4K5-0007WJ-Ag; Wed, 12 Aug 2026 04:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K4-0007Vz-9E
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:28 -0400
Received: from pv-2003g-snip6-11.eps.apple.com ([2a01:b747:3003:205::47]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K2-00052D-Qv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:28 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 DB7AE1800966; Wed, 12 Aug 2026 08:28:21 +0000 (UTC)
X-ICL-RepId: 019ff516-37f6-7c02-afc0-8066abb8607c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523302; x=1789115302;
 bh=6NRueJblP8aIw/OsQ8F5jg3sZUd49Zglh8TaSrbigVU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=qk7Pl25OKC2Jm9Ua4Ow1QxbJAz1NeuucVoSejJCcp3/rdzHeb5NOM2ccJwtJYo24hVjSyU1gZiM+NBDKsIABcvbBZ89T95pyaCgua1SKxMbK3JPrki7UXp32mHnUzTKB2ZlFttJilkcpX7dy2U5QFoc+t1LvFsEzwMXMp40liNd2wlSL9Xxx9EakV8RYT//3yvnrgiJwyyh8sGTrHz43fPBQRXVLxNeva7wAUKioguvqyRTgFnlmVVToSNnn5suCGaOVzPsIXURMWd9o7MyUGReezZL7epn1rmWhOuNeIbTl34FkZOi8RzjdkXyLKzhxCTqhmZysBbek6IVd6QOGQQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 7C5F61800949; Wed, 12 Aug 2026 08:28:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] hw/i386: fw_cfg: do not set VMX feature control on WHPX
Date: Wed, 12 Aug 2026 10:28:10 +0200
Message-ID: <20260812082814.27217-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Pix-INabtEUbn_CgeZDyINTiM_8mP7iY
X-Proofpoint-ORIG-GUID: Pix-INabtEUbn_CgeZDyINTiM_8mP7iY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXyPEwbtJ/8aUn
 EqUcoGZcJyUEhfbWz2R+7W62L64xdy8vI3q7fcckkA6Z9PlqeIoc9473X5Zd2E5+lQM/UVxwV+B
 U3TlaV33TUBetKZrYxApbaXPSv9suEBNbTkrZikI9MnO2Zb/jABcw/Iw+cYqoCsP2Ptv+Qny/DZ
 rIDfugPiXtpbNwRt6Ympl4rW4NqjByuNTbYQ9hHv2TQgmR452XEJEhahiLY84Tq+Sh1aaf8YmBs
 Y7sgHEhIkCYEkHLYNSsaYfCFktfmA8F9l/2ysinEEAHIW2vbmzBOowrB2ijEyt5I5tH+gTUpl55
 TGe63XqvrkB78MK+f9WYsMWGg6GnwTGK+RTC3meTP62Nenjxo8OXW/GEn5PIwY=
X-Authority-Info-Out: v=2.4 cv=DqBbOW/+ c=1 sm=1 tr=0 ts=6a7c2ea6
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=03zX1AGEHLO9id_vLjQA:9
X-JNJ: AAAAAAABYoX05bFN98HoRDILnaQuVvxX5V3Vk4Xy7jErPBGp9Gwx6S1SBV7p656b21NBGnFEAmmionMgYxBPFuYNCvNz8rnY0kcK5Vncg+g0jypL2lZd6nHdQdCgFVfReKUo8svaJ4I/Zbg507t7SgEAqk4uE1tQR4N7TWQsny9O42AkXg3ljV0uzOe5Xl3Rodkhd9Omg+VgXd70cysb5cJx6niItH/bvG7D4VbA7wD97zZt2zVrY3lXKRgkibgSVdo4+D7dqcILnJNiWCRx6GOix3USnKqhhRj1O5gOXovhLoW26AjtMsUfbIa1AX7o+66i0Cmljk5Ey8xEKC58jWnp4ghzzQAlOm9kfJPWgXax0VHgaUVyDa7E2R6ZuGzUTpKb76ZH7IHtUVZAomaLD1H3lDOqgNB7REmAUYpVxpz8xYyhrxJMQipNC1yRiVn9VksGzKAxZrj9xT0QyFmL3EkaSOXYlGdWffGAy6hdatoItGEE5ZRZxY+el1QEdTjaFm9tUR9p+rgkbB+9m3wYjf2i9d5b4oL1bLnBCW6yKHcZZM+WTo7Rkijqm5amN4ePIZi88ypUOemD+/wmejwOeQuN+cUJCBfcL0/hWo/7qTqAiOFUlHybeB4jaUFyZQwy7opEcfpTdpiRmthGSKkS0Mp9Hj2Y34FPCs0gAKO80VsclIet7e1OkEzjdliJ2bh+SDH/3o6YmTSE5x9MjFdpIs3bAVWqrb1sJ4cy
Received-SPF: pass client-ip=2a01:b747:3003:205::47;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hyper-V doesn't allow setting this bit on build 26100.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/i386/fw_cfg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d422302c1c..5903994a7c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -13,6 +13,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/mshv.h"
+#include "system/whpx.h"
 #include "system/numa.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -182,8 +184,15 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
     uint64_t *val;
 
     cpu_x86_cpuid(env, 1, 0, &unused, &unused, &ecx, &edx);
-    if (ecx & CPUID_EXT_VMX) {
-        feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+
+    /*
+     * Hyper-V in 26100 disallows this bit to be set.
+     * Otherwise a #GP gets raised.
+     */
+    if (!(whpx_enabled())) {
+        if (ecx & CPUID_EXT_VMX) {
+            feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+        }
     }
 
     if ((edx & (CPUID_EXT2_MCE | CPUID_EXT2_MCA)) ==
-- 
2.54.0 (Apple Git-156)


