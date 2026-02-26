Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A12FD8FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfxg-00006G-In; Thu, 26 Feb 2026 13:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxe-00005N-1x
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:42 -0500
Received: from ci-2002a-snip4-11.eps.apple.com ([57.103.88.141]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvfxc-0005at-FG
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:19:41 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPS id
 4CC37180182A; Thu, 26 Feb 2026 18:19:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772129979; x=1774721979;
 bh=agiXw2nrucHe1hKwJE/S0tKqgc/AlRiSaLAhW6W+4JE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EbCQ5x842PbOi6+udmw82lZNbE8VB5VU2QlnEnJKv8DM1ZlzmRbgXrvVreap07kUdBpWU2nYWruF1uRKEqHuq1IQGUIN+KA5CaG5jvytRr3ZfTgxrCyyfcRiz34uPjLFdGRdRPykgccLpOtwm2FueB1McqlqX6cpJ1k/5fO/ebrQR84zw2CBmaBboxRbqor3nSdpD7L8o3tFLHWwvcLWFJR5460QHNuVocwVk/68N6s9K9Jc2QvkJLpXd+Gbh+Y7E6RmEWH4E6hJqfGq293dqzD29n1ywvjwoil/EOm+tvbqDxLH/mGlJ4IcmezmuebkutYU4MPceGLKSeKFQHMvpw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-3 (Postfix) with ESMTPSA id
 D4F55180093F; Thu, 26 Feb 2026 18:19:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] hw: i386: vapic: enable on WHPX with user-mode irqchip
Date: Thu, 26 Feb 2026 19:19:30 +0100
Message-ID: <20260226181930.53170-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226181930.53170-1-mohamed@unpredictable.fr>
References: <20260226181930.53170-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7J_OxssxhAKlIjFKhaDR3HEZqNGmdDy3
X-Authority-Info-Out: v=2.4 cv=WMlyn3sR c=1 sm=1 tr=0 ts=69a08eba
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=SuDxGJzo5uN7fQlDX74A:9
X-Proofpoint-GUID: 7J_OxssxhAKlIjFKhaDR3HEZqNGmdDy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2NyBTYWx0ZWRfX0DophRzOg8e6
 KIFr7YF5UABZLEpoRzDlc1mCXF9dXATAUS96tWzYtbsC/ptnP/ynKMm/bQL85qfcoACFrhR3VIe
 wwXA3oZp8jyX0qGuASG2WutdmLJHLa2Zx5gwR7tRKfRC/xxtjbB35kMDAR3LvXAdkGxdBcwg5jG
 qIrurqdmhLaZ3agnv9ZzwKZPhg870nWkZ8A0GcDV+ZSf70UENgKNTKueJTnW596SERY/xhVKQcM
 Ad5d4hH7D8i7WfN3qw/0XdS5k/dItt/6kqMBgvPtv8H3TVsqQcD71ovzG9FewTaLd2NaaWGQImy
 qCtDnTLemD0lgYGSVJ18AWHIL32jOu87b2ZVyqHI4h2/UwTjLyO0mAampY7FkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 mlxlogscore=916 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260167
X-JNJ: AAAAAAABjCzhRupQRV6oJPJE1kGdTlHDGXNUI7hUXVHkUlRl/aFRYUn1/gbMutdMQpH1lJc13GGrYX7mKQ3jPC2dnCaxVa1IsXIF1TO4vLwXHD1N9lq57Esha76DS7u6yIOGjecOkJ+IquByqznGI+DyRE7hl81Z7utX+OHMxcThrzXLe84kNqZxkng89AZHKx9Y0YtRuBYwKrjZa5cjxlMyuf8rAY68PEQZCCDrgP/sWwcJ1BQH6ezGdp+kB1x8xXed69ca4cZMrKotIDkisXl0d2I36n0HwQYZEPV7SH1TWQYhwfsRU9K/z75s/z3LlwR2R3ZBpTSsRyb5g1xAkuWs58kWDdxdjbSpzV6DCfJe8qSFYC+F2NwMLg4Nvz31o85aNHiddhxG8kbG7BhgOSKaCDKiOhS7KgXVwecGV60whgPNgRwojAx72+VQUkxE+C9xjZxg/DtnET4WS70XstLNyYxP5GCnmMKU9gvQNV6SrYInrbUyc6SWerOAw6wzW1sNjqTyiMp3y7TfODA6X7ZB9n1TmVePfVtv09KWMaixoKu1PM9z7J0qpJeoN/t8UHPMxfXSxRkceavKZ2uQkE2P/zvKPvOKJtpRI8fv60YzUocd+srlp+EwCkmKBFnUS31jPksUldevukn1mH5U3BLfl1cbVFxcJYUo6BwgfxN3BkfwaWnrfIId3yv2JghnSu1W4kfrxxqj9jhQ3lZy3wiMplRkPIaGsmb1PA==
Received-SPF: pass client-ip=57.103.88.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

Alleviate a performance bottleneck on legacy Windows guests.

In my test setup, this makes Windows XP boot times be 20x faster
than they're otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/i386/vapic.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 670a50524d..35e28428ff 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -16,6 +16,7 @@
 #include "system/cpus.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
+#include "system/whpx.h"
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "hw/i386/apic_internal.h"
@@ -229,7 +230,8 @@ static int evaluate_tpr_instruction(VAPICROMState *s, X86CPU *cpu,
         return -1;
     }
 
-    if (kvm_enabled() && !kvm_irqchip_in_kernel()) {
+    if ((kvm_enabled() && !kvm_irqchip_in_kernel())
+        || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
         /*
          * KVM without kernel-based TPR access reporting will pass an IP that
          * points after the accessing instruction. So we need to look backward
@@ -549,7 +551,7 @@ static int patch_hypercalls(VAPICROMState *s)
     cpu_physical_memory_read(rom_paddr, rom, s->rom_size);
 
     for (pos = 0; pos < s->rom_size - sizeof(vmcall_pattern); pos++) {
-        if (kvm_irqchip_in_kernel()) {
+        if (kvm_enabled() && kvm_irqchip_in_kernel()) {
             pattern = outl_pattern;
             alternates[0] = outl_pattern[7];
             alternates[1] = outl_pattern[7];
@@ -679,16 +681,26 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         }
         break;
     case 1:
-        if (kvm_enabled()) {
+        if (kvm_enabled() || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
             /*
              * Disable triggering instruction in ROM by writing a NOP.
              *
              * We cannot do this in TCG mode as the reported IP is not
              * accurate.
+             *
+             * Oddly enough, KVM increments EIP _before_ the execution
+             * of the instruction is finished.
              */
             pause_all_vcpus();
-            patch_byte(cpu, env->eip - 2, 0x66);
-            patch_byte(cpu, env->eip - 1, 0x90);
+            if (!kvm_enabled()) {
+                patch_byte(cpu, env->eip, 0x66);
+                patch_byte(cpu, env->eip + 1, 0x90);
+            }
+            else {
+                patch_byte(cpu, env->eip - 2, 0x66);
+                patch_byte(cpu, env->eip - 1, 0x90);
+
+            }
             resume_all_vcpus();
         }
 
@@ -705,7 +717,8 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
     case 4:
-        if (!kvm_irqchip_in_kernel()) {
+        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
+          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
             apic_poll_irq(cpu->apic_state);
         }
         break;
-- 
2.50.1 (Apple Git-155)


