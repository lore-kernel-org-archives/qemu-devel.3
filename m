Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D806EF5859
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUbQ-0000Vh-Nx; Sun, 15 Feb 2026 00:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbN-0000TL-1D
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:25 -0500
Received: from p-west2-cluster1-host5-snip4-10.eps.apple.com ([57.103.68.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbL-0004w3-H7
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:24 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 0A4C81800094; Sun, 15 Feb 2026 05:23:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771133002; x=1773725002;
 bh=GLbIgTGdGVhANWp4nd6TkdA9/AvSuGt0b680ukLmQR4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dUq7asuwUjHsZI/S+ujKW4nOEl3DRq7oqXpzxBPICqQ1x7bvyCijjb1lAyQdJ/30NVTKXM9Y7bISYozZLZJL5IcbKdLcjn16XWm6mkstz/7Lwe55lKunaC9UtcMT1ByLEur8eACufCB5UxmnS7duFEXpmpfQhj4cLnibGIagrs2GGfl7uESQ2Ac+ViwhiXHN2HmFCFZisbnHL41EZTKbEoct00sYiOt1H/uWgKmz/0alRWQcSPT373xmAj1M+3KT+KwzxsfglL+wiFNZsWeOO7TpADJNcN1IqThZeWOqXFpUPfAASz09GoHBtrIbCSetcsDX191uhJYacQ+g0A7f5A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 8B0E31800139; Sun, 15 Feb 2026 05:23:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 14/14] whpx: i386: saving/restoring less state for
 WHPX_LEVEL_FAST_RUNTIME_STATE
Date: Sun, 15 Feb 2026 06:22:25 +0100
Message-ID: <20260215052225.22513-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hHsj441UFPPPPUy3O2prKuJBgtS4GHxk
X-Proofpoint-ORIG-GUID: hHsj441UFPPPPUy3O2prKuJBgtS4GHxk
X-Authority-Info-Out: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=6991584a
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=4wYEPAPKIlw1fLqtQJoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX6HNdg0DEwtCs
 4XcFJ93kCeyBKKNVVszGA3fWVKitkyTBtnyL/osRae5OwiXMzEi/sFHMVv80f8AohX1+HeYpCKg
 XQC4b8QkdH/kpUzt2i3+sMex7ZFqwnw4qtKh53W/d1CCf/dfN93aue4Cy5D0qnilBxmepA07ngc
 5k518+6cl0of+b48IrW/GIP8alkzJRFxYrz86y8SNuYcLgSqyfdK5jVwbvv7j4qkflycFkfOihU
 TWwjhEmZ4MoM9/KAS5ADsR05By0B8gCfBUHvWBwJBNb3kDC4Gc5m5dXHj3Kamp+A3KPW4aWTKpg
 1rQOaAg+gDBununtrHS4cwGAO7jun58jKOkn4N9t+Rnp/g0bBowqpEndtks94Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 adultscore=0 mlxlogscore=967 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABceF4vtI+nFjLRiX/C307SUvLIKgGPQPrzTaoqEPiiT7yve3DaH1TjM65dn6D/5/WqD6M0r/PhNNV0JyhEeOYTfLFew0qt4e1oiXQHCV5O6grjjIAwlzTQ+WfHd4QAn3yLlen/vQJUFz1IOZtnIoXYJ+jigwc7xq2hyv/aWlFXhPe3fo76scvmg8nxRK2QRwyq6+8zV0Xf4q8cJdLeYtuBKyTVjV24bzgPbvsnKfstW8MJ8Es/6v9SB1EFa7tXQtEivRvf2ViHscFMNExE14cYIh/ZaBQO5hfqOppJ7/CLqv/ezdVeZRX5Up0QYiB5hPaGNHuSp4TWvU5X/LqXfdsUkoerB0O01JE67zFs+7y7TSk9gyYV87b336Q4/kHjCvxcZgCtJ8UNMHopoxSMfAnrAhHoInp+pMaMRh0H2RR/hRd/pileVOJNzeUcM/iK9Fr2GiCkKAdnxfyriTLvlJiH3XP6k0iuPyXMfVy0IYM/PkNUOLhBoRLSgQU0CMucCm219vQydJA+IGUzp8INCXY6+eoqmfYOb6tUo+5S3Nkch2Bh+9ztL+eEVXofAuRQvKb6k/JTGZ9fLgWHYpRXncPWwfb/xa++dOhkJTTYzZCWg0kYk+SsJqINURKc+dlJBUagFaYzHL1iMkDuPVbqh9bZujJH/XndMaSGERW8kW7zyg8+A3F9S21zlbYSQ2Sn9npseplWJXTliTxibQCo1LPrfC+XmGQn11hU1yA/5fzZY5TKBBl8PakA9TOqiVQb7YlpgvJb78jKu2DI8i7iMCehzxbRVHdXW1MGXOkC5TdmC2UebV9962p1JOMZ2zugIrT
Received-SPF: pass client-ip=57.103.68.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Optimise vmexits by save/restoring less state in those cases instead of the full state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7bbe63e794..9d1febce52 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -420,6 +420,13 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
     }
 
+    /*
+     * This is a hot path called on every MMIO access.
+     */
+    if (level <= WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        goto skip_to_set_registers;
+    }
+
     assert(idx == WHvX64RegisterLdtr);
     vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
 
@@ -529,10 +536,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
+    skip_to_set_registers:
     hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index,
         whpx_register_names,
-        RTL_NUMBER_OF(whpx_register_names),
+        idx,
         &vcxt.values[0]);
 
     if (FAILED(hr)) {
@@ -612,7 +620,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (whpx_irqchip_in_kernel()) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -668,7 +676,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[4] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr8);
     tpr = vcxt.values[idx++].Reg64;
-    if (tpr != vcpu->tpr) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
     }
@@ -754,7 +762,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (whpx_irqchip_in_kernel()) {
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
-- 
2.50.1 (Apple Git-155)


