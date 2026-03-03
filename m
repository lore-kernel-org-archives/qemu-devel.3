Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F631EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhK-0006BW-Mf; Tue, 03 Mar 2026 15:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWhH-00068q-6Y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:27 -0500
Received: from p-east2-cluster6-host10-snip4-4.eps.apple.com ([57.103.76.205]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWhF-0000nt-99
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:26 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 F1F3F180012C; Tue,  3 Mar 2026 20:50:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571024; x=1775163024;
 bh=xfi6rjeDQo4vpSHmbqs0x+tY5PCeD7vMjLpTj63mmJI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gylOBL219wo9mpENOvJe3UyCADKcXdPd2ypLZG+fBRLQiMYazjUDX+GuZBGkKHm2rjlcbE4KMkarVXswfQT5cJn2XALB4MAonC4pHzXAuN2SNPQE0z0VZJyxkDcd29hKCjAEROqqKUDMgDSqqn3R0IaWK5IpxWYftvjDmNBaesoJCSD99/r0F8ExbEri1C/CP/BJWMHM81NFoA8DrGm37OG4Dx/EYP+n0pM44nCoz1tzKm4bVdLoxhUiDlY9fNS4Ei0nxFMdvlwy5TeXzhO8Q4vOFKPjQKBeLlvQkbTAB2f59lJdb7HVQefi8LGweONhcfeFREufOgbm55iMeSfQ7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 734571800580; Tue,  3 Mar 2026 20:50:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 9/9] whpx: i386: remove SIPI trapping
Date: Tue,  3 Mar 2026 21:49:59 +0100
Message-ID: <20260303204959.31156-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mzhYWAyi_613Jwd4bpiBuTmORIiMM3rO
X-Proofpoint-ORIG-GUID: mzhYWAyi_613Jwd4bpiBuTmORIiMM3rO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX0z/KigJAZAp2
 TWtvnB+44FINTwfORfTx1/WXjqqwdcSe8wMiigD5X9M2Ti2z34GxLE8za/pho0+2mUBRMxPSDgp
 kLEIe4zngVjBjjf3JPxZQdopqaCFWJZETFZu9VPLSSmN5YM2K7PMSbT9bmsg6ZFpBzrFuUEBApe
 KZ+ZQTzIaB1uiujdbvRr9X7hMgUMLz0zGbyhFWqT9Wd1V6lxxVmNG/XRiMnLsH2nYcvtUHTdLy6
 GrS3NUf1AW5chn+YlxUvgYkpXmbhNCdeAhv7LJRMMwBvkm3z409mL1LnOZ//Sd/iQsKFawmH/0h
 LsxRvK9C8b9tro0Z7Qu6C88g2YuNTJDSVdZl+bpz1Cfc/bNWk3fLLR6uHeXdVU=
X-Authority-Info-Out: v=2.4 cv=H4jWAuYi c=1 sm=1 tr=0 ts=69a7498e
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Xl7PRCIL3n5FuX7mVuoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=997
 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1030 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABCLcq71L/nAeaqvrS3vPU4gHNlLZ9/ZhxGO9u5sTOjbwjlIZDliblJRi1ssLIfnPqDOBEtHMqi0kuth//nX9asOABqFZqwXo6cVH09eOqscDMDHPhc5CuxFZPhJtb18oxrjH0h57TGXbJ09Ow5j94jOipXEQEU7tutCw0Z+i3xqHFaf12RW74Y3FBdArDQRFUDOLYhOwf64sft4JOXfla/zVJtTN81xHdk7jM5Zm51S5XDwXgf+LaVnmi+Ypk6Fs4cNnt6Xf7uzS/PunGT8KKVO/lG/3GCnteJ0ns6Sc5UiOx0uECiCRvIK1nAXnxputr2xxR1wNMTM2K4K13tj5TSTWgXDNDQr1ql53O6oebN03eVtbouhYUlfZTYbM7TkE/crfz8lEKgtt8XRUlCu8Bo0WM+xIzCJwtSgfIuObbEaolmjJufBEr39AjblItCycq2d6vQjo85mEyIma7dmtmBqIkuWjdzKdkXJmYj4J5dNOTs2ChaDodnhcRTd2jYyP9UjJdV/j0ayTALz1/ww5O7jq37SRA555qhGMjDdwh4iSu4qulZdeHx86JfQ0Hzn36tK9NxIjtPHJWvlqyUMKZkzbRbGon9TJZdUrUPyYBFkDplxzPAUi7YY8vX2/oW/6AIHrxSBzU/k1rg5SUIq3i1zMQBTcaYyO5tcfhM0umLOxm/It+n6WB5TM6TuUUvffpnOdwEUIprjzzPvNwM0jWXP0WE08Laibx7KzTM2ypRl53qvJEfz2oDWuDH2rlPmOc
Received-SPF: pass client-ip=57.103.76.205;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
index 4968a5a3e4..fa78218f80 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1679,100 +1679,6 @@ int whpx_vcpu_run(CPUState *cpu)
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
@@ -2236,9 +2142,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


