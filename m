Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B73C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 22:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufQyJ-0007SD-C2; Fri, 25 Jul 2025 18:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQx0-0006fl-1i
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:39 -0400
Received: from p-east3-cluster3-host4-snip4-10.eps.apple.com ([57.103.86.43]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwb-0003kY-Te
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:16 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 E081E1800125; Fri, 25 Jul 2025 22:30:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=eR/9MRlLPW5uSL11Gkutp5bmbs/sIhqyKweuQxFjGMY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Voh37PAJV+2cdxFJO5KjHs/pwY/+kA/etdYsb5zABmWMS9JMLBJesLWGHeYU9Ugh/kDFU1XzkuMUFmmlB53CAcopUIlQ1LQZuVk0MQV1k9W/HtLj8wpjPleHRT7YDUMEl/tH1kbz9HWYL3QNgBr365hVMHHxEEuFXZ6rK1vZA0Rs8bShYHLrdZoAFkdNFOUjafiQ4dDyEsFr+T4NkY0p2zqbiZcfM/ALVaqgVJPxcCwxaQDLJt3SahElfXPHF2/PPdpONG5cc0JiZWgChIeahTfTDUxsxgknaxYc+d0qSikiDb8Xq5IXRDSJoxxhcLRBnK6jH0uOHFEVioY5pqdwEA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 9511B1800130; Fri, 25 Jul 2025 22:30:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v3 3/9] target/arm: add asserts for code paths not leveraged
 when using the vGIC
Date: Sat, 26 Jul 2025 00:30:29 +0200
Message-Id: <20250725223035.52284-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725223035.52284-1-mohamed@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5NSBTYWx0ZWRfX4JtxKITk/DhC
 a8hoEifeHhARm5CivU7hNv7B73OVyGLcBKQddU/ZHg4sqNgpnogNFQTpSKo02ePj8J+rVxR7M0B
 /ev/rm+f83rxYlt6pcJ6Ow6YzPUYghbKllksC5RENSxaKf7DuCH/Caw0gtjJ0GjxHmbLZT8nNcS
 dMnFLtF8QGbSe8LGkzG3xZzCXztXpVvmfYCuobdsQ98l9KvOP4/ed3p3SlVmf30t2anSSaTp8M5
 G26HEsKeBmcTcrxL1uwsmE4RS7GY69SIE6jZp1h0ssAPdUibF6/vP8MDOP/bVZg1Bw+u1H5d4=
X-Proofpoint-GUID: sCZ8l14TPXwGbvbldrRGT-fZYhyiMevG
X-Proofpoint-ORIG-GUID: sCZ8l14TPXwGbvbldrRGT-fZYhyiMevG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=662 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250195
Received-SPF: pass client-ip=57.103.86.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When using the vGIC, timers are directly handled by the platform, so no vmexits ought to happen in that case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3ba74b8daa..7beb47caad 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1382,6 +1382,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, reg, val)) {
             return 0;
@@ -1702,6 +1705,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, reg, val)) {
             return 0;
@@ -1965,6 +1971,10 @@ int hvf_vcpu_exec(CPUState *cpu)
         /* This is the main one, handle below. */
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        /* This is only for when a user-mode irqchip is used. */
+        if (hvf_irqchip_in_kernel()) {
+            assert("vtimer activated vmexit when using platform GIC");
+        }
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         return 0;
-- 
2.39.5 (Apple Git-154)


