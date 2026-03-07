Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC69F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytn6-0001BK-KZ; Sat, 07 Mar 2026 10:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmc-0000qz-96
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:47 -0500
Received: from qs-2004b-snip4-2.eps.apple.com ([57.103.84.15]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmU-000220-Oq
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:33 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 A4EB41800887; Sat,  7 Mar 2026 15:41:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898089; x=1775490089;
 bh=4TmqJMoXVEKb3HMgHzQp4gRnTyoFFXJDWRIsbiC4fMg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=F6ZtOheDof1eRFvbg6u7W254/XWfqkXOA6R7TnUh2ZX5ljKJQ4lt1BLJ0Z2jghSkWNrnuSUioiDZoivBG1CjAGHcbbBzzdQv4Emh/2bPe5YhdjWeMpXCtQvznY3bciEnHZ4AzJoKyvdvcl0G7SMAKFptORC/1h8Edi3nq68s4uMwHF5w6wdq5n0pLG66x4WY+SX+zbXZMzMUWLfDiCmLpDmH2Qku0KSwVdYwfl9ktbSqgqVoSm94KujPjHhf3ZIrKW1JkoisoYmTxmagNTSQyPcjZQYRo8+Q8FLlaU64UM2wFry1m8sxLZjbaRRFIvURGxblkJ7i6+pMO93HQxOrxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 13FE718008B3; Sat,  7 Mar 2026 15:41:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 9/9] whpx: i386: remove SIPI trapping
Date: Sat,  7 Mar 2026 16:41:04 +0100
Message-ID: <20260307154104.84567-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TwXcvAcxO-jxkDyDV4XaXZkxzziGiNwN
X-Proofpoint-GUID: TwXcvAcxO-jxkDyDV4XaXZkxzziGiNwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfX0SIHvIdOxHg9
 ySwSsgJui+sLQLAFRKP38Jo5NecgMpfLeLVga9o63lDqG7KDEAhFI3tH2mKZk+87lBbyFoaPOnv
 CMkYn8aXcTIh25sFm1sdhSk+Y8XYfTdM+2/fXpHv9AQtZww6zSeY2ZaP39VETdekbg/KAFPF0Ux
 /SjnTa4tFBzUlA+V1Cf0dqe1VJj6y7IRbNnGyruUtkEcEKg7s5b9U/HjHGR+JOxodZtetyFs3ve
 SItc5TyxDIFoBTDrMJ/zLmOTAFXQ1KnoSmaWuZsPDwKfyxxnCVEUuoGfE/nP0UqD++4YW1dPQ/M
 aVx4AyvufZsW++AwMIh8eLVI3q3D9bgIkfFoOZiVMqFPYBqWv263g6YwYF7woI=
X-Authority-Info-Out: v=2.4 cv=V/9wEOni c=1 sm=1 tr=0 ts=69ac4727
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Xl7PRCIL3n5FuX7mVuoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1030
 mlxlogscore=994 bulkscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABPa8AEV7HaH+GjlN4CgWo5tATV80sRRUm7KZSbvydmIqyL1QZyn0AcjAspLBA0kmZFZLy7z2eHwUCy1Zm0xe9plv4eMsTuH4G1/eUP6cO87yq0N+M/3LOIdAuRZu6psArCCLwR0KtUj/JQpsDbYFptWSvvP2pqoJihCRCVboD2bVdh9lGsDPqgRsr8qw8H9Ss3R05YF6YUBiYvk0H0z8QgNMsARUUltZeT1qv95QlyOG5OClaS5E0/e3LvgYKunmAGhgIh/N9Mlti9MQ9M0AjyEA/R7pkrp1e8Krw2lR3aClf3k101Bxeq7kPKzilcFEDew5lbzVVA0THeqme+9BSfycsEuXY+jhdrcpTAS7gUhcLNAC1UPyRTr+hS6xBhDy11Tb2yDMcOrbib+jfDotKYvhqg8nfot1Q1MtQ5B5TQGqfAamQD8iyP3LLpKZ9FJzCCrBeiOo44yxRBex599wMiPu5RnRh7j2BRanywVcKEHIJUDCwWvgpbUbuRjegVnXZcOLNmofBgZACv856R3Eyv5QnjL21KbdmfI2YcoLQ1yzyx+Se5m+wdQf79iEvlqcwy/BpMcNyqAdaeJnA6emno+4obHNXJyzrp7LsKjGHPkV6U/X+wi93vyZAHDmms56QOhxT6zydL2xfkAq4mB5ewpFJu48V8yfhSvdYbuTDMx5h8Atk5DDzGwfbE2PX9kKVG74jv+6pbqL8WsvfskfjkAYca+dtpT0Wr4ahB+b/QBGi1ULKDRfP18KI2NTUx6/Bfd9WhT2AAmec1RtlzGFAZUSouo9T
Received-SPF: pass client-ip=57.103.84.15;
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


