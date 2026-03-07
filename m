Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F4AF55105
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywFh-0005PL-Il; Sat, 07 Mar 2026 13:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFR-0005N9-J8
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:34 -0500
Received: from qs-2004a-snip4-6.eps.apple.com ([57.103.84.9]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFJ-0005QQ-2Q
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:27 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 BF02518000BA; Sat,  7 Mar 2026 18:19:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907558; x=1775499558;
 bh=4TmqJMoXVEKb3HMgHzQp4gRnTyoFFXJDWRIsbiC4fMg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=F3hvOUW8nhe60YOHJdW/y31BRG3p2zSoGyYogESdfMJQmWeCmozfLONHHVJyl6253htcO5f0wVacYhIRfQN5Q6q7igR1v06PgO9Xykk+pwjo5f2jcNbR/9xxtAim1v643efArM0WUpV02qxvvONbqVG0c1VkUydCoYaRGuLdTnnJ0nKZFKzgDfqNaTzUDIkgyofX3NgNNdDFvHJvUEVQgty2lx/Ttei1vuJQsOWp046X9bd/5b6ObwHnkfozZC2b6qFAAXUqrzTIg4QgdbOlH79qJP42KhQXbfybwQFJ8UhxcLdZU/8cJDfjqKr2vLWU6tD5HSEeBpxUw4thrtmTqg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 D07F51800105; Sat,  7 Mar 2026 18:19:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 9/9] whpx: i386: remove SIPI trapping
Date: Sat,  7 Mar 2026 19:18:56 +0100
Message-ID: <20260307181856.2209-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=69ac6c25
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Xl7PRCIL3n5FuX7mVuoA:9
X-Proofpoint-ORIG-GUID: DNTjkG3MYCzHppKc-k1mrUtYAjFA-jNs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX7tmvMso6NtTR
 srO66yC/RggzR1rTSt1Ky9cXYKC6bhX/0g99+D3+eXzT2QKJYRPZgeooVrRTV1j6sjl+WDDeu3u
 D9HBBqBJhYlBghhpiki5r6STRRRQPsQHLWS4MilJVYk8KO03rOBx2cVnS8CorZLac37FvqFcs98
 /ihBHaHN04b63/u5UE6tu3yAvJA+Dy16cwBikl4ToJQgqBzIklXxr7OUCxi/r5CLHNKzfjwC5R3
 j9cqDYQi1e8I3ZcB1AbrC2J88FV6ODOEs33rQ4nYGYEOLTbmdtlkzgzf0MY45rSJpb7GcgZV5DD
 eF4zhLr17ra2cYqphUtjUGKwUP0OTY0io4GEavpZNMTT+1mHFCqLXFErqX5UCc=
X-Proofpoint-GUID: DNTjkG3MYCzHppKc-k1mrUtYAjFA-jNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxlogscore=994 clxscore=1030 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABSGpcWkOZLQfwfIgGzeH0tMgTxGAyEj9jqyNtwQ0lJ6QB/7yeWaXhOwDx+cabxSlGmP0XQhGR/3F0YfbFGJSwKv+dmSPEzY09XPoZ1KTERL6kGrCimY6YcM0j6+3taoeCJu2tgemVt7Xy5zlwSaKy5bo+KPXCSr7/yyxDy2OZZL5T+RBqSqaSX1YTiIJWWlA5BHMTEj+lMPJZadHt2IxFHzsIHgc9hqoG6ohl40t75vShWc/40wv+iTQCo6n9ZJ93v+w7KP3Q9hMjApAOljI8nfl4Ps7XpXkWX/9/ZF0CcnLrWcF5C5Vw+iZkXiId8H3vS0kA57pVK7hcTiIVYHliyV+rdLW5Mod9RMVF9l08OE7bphRJJCHZxrk/u4bW+hMw++BB7J5yjKMFMPR6OeYbuRFDtQ6YD9YVIFLU9h7ShEAq4UVHZtz51lpWlWL6IT3RgX0ZlbLBSxQDVxLcVsRj8MnAvJpm1D0Yz2jwiwhQUMuNDRP5bzqWJ/jFRsJt7suonIHi/AoMydXzdwmottt2cdJrqKLk2Bpaek4mHD/xrMod+/XlFKjnYEZc0SNJyeI4ds/yNKtZLX+8Mz/QyoUDvLFsj+uMIeNpmJqk4D23juweVLMQ1yQJoW/M+poYIEc14MpW+1uaKKyIJwHLlzj+umd2vswom5vDBYdm1rzojJErPqfkpJCPfmZ/MuSmrWJuctVqWf0FQMAAOVZaHlpvTpgbfTHC4CusUnZvVaqJg75GivEaN1nbVCZffT1Dn6iqS/fZQy3kp3UzUP1vls0jReRbQ1MyN1jsYQwkYaTb
Received-SPF: pass client-ip=57.103.84.9;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The implementation in Hyper-V works fine and the code
currently present doesn't handle x2APIC correctly anyway, so
remove it and use the implementation in Hyper-V.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 97 -------------------------------------
 1 file changed, 97 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b095c96962..4d5d3dbd24 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1692,100 +1692,6 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = whpx_handle_halt(cpu);
             break;
 
-        case WHvRunVpExitReasonX64ApicInitSipiTrap: {
-            WHV_INTERRUPT_CONTROL ipi = {0};
-            uint64_t icr = vcpu->exit_ctx.ApicInitSipi.ApicIcr;
-            uint32_t delivery_mode =
-                (icr & APIC_ICR_DELIV_MOD) >> APIC_ICR_DELIV_MOD_SHIFT;
-            int dest_shorthand =
-                (icr & APIC_ICR_DEST_SHORT) >> APIC_ICR_DEST_SHORT_SHIFT;
-            bool broadcast = false;
-            bool include_self = false;
-            uint32_t i;
-
-            /* We only registered for INIT and SIPI exits. */
-            if ((delivery_mode != APIC_DM_INIT) &&
-                (delivery_mode != APIC_DM_SIPI)) {
-                error_report(
-                    "WHPX: Unexpected APIC exit that is not a INIT or SIPI");
-                break;
-            }
-
-            if (delivery_mode == APIC_DM_INIT) {
-                ipi.Type = WHvX64InterruptTypeInit;
-            } else {
-                ipi.Type = WHvX64InterruptTypeSipi;
-            }
-
-            ipi.DestinationMode =
-                ((icr & APIC_ICR_DEST_MOD) >> APIC_ICR_DEST_MOD_SHIFT) ?
-                    WHvX64InterruptDestinationModeLogical :
-                    WHvX64InterruptDestinationModePhysical;
-
-            ipi.TriggerMode =
-                ((icr & APIC_ICR_TRIGGER_MOD) >> APIC_ICR_TRIGGER_MOD_SHIFT) ?
-                    WHvX64InterruptTriggerModeLevel :
-                    WHvX64InterruptTriggerModeEdge;
-
-            ipi.Vector = icr & APIC_VECTOR_MASK;
-            switch (dest_shorthand) {
-            /* no shorthand. Bits 56-63 contain the destination. */
-            case 0:
-                ipi.Destination = (icr >> 56) & APIC_VECTOR_MASK;
-                hr = whp_dispatch.WHvRequestInterrupt(whpx->partition,
-                        &ipi, sizeof(ipi));
-                if (FAILED(hr)) {
-                    error_report("WHPX: Failed to request interrupt  hr=%08lx",
-                        hr);
-                }
-
-                break;
-
-            /* self */
-            case 1:
-                include_self = true;
-                break;
-
-            /* broadcast, including self */
-            case 2:
-                broadcast = true;
-                include_self = true;
-                break;
-
-            /* broadcast, excluding self */
-            case 3:
-                broadcast = true;
-                break;
-            }
-
-            if (!broadcast && !include_self) {
-                break;
-            }
-
-            for (i = 0; i <= max_vcpu_index; i++) {
-                if (i == cpu->cpu_index && !include_self) {
-                    continue;
-                }
-
-                /*
-                 * Assuming that APIC Ids are identity mapped since
-                 * WHvX64RegisterApicId & WHvX64RegisterInitialApicId registers
-                 * are not handled yet and the hypervisor doesn't allow the
-                 * guest to modify the APIC ID.
-                 */
-                ipi.Destination = i;
-                hr = whp_dispatch.WHvRequestInterrupt(whpx->partition,
-                        &ipi, sizeof(ipi));
-                if (FAILED(hr)) {
-                    error_report(
-                        "WHPX: Failed to request SIPI for %d,  hr=%08lx",
-                        i, hr);
-                }
-            }
-
-            break;
-        }
-
         case WHvRunVpExitReasonCanceled:
             if (exclusive_step_mode != WHPX_STEP_NONE) {
                 /*
@@ -2249,9 +2155,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
-    if (whpx_irqchip_in_kernel()) {
-        prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
-    }
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
-- 
2.50.1 (Apple Git-155)


