Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEC7C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufDtM-0005j3-6m; Fri, 25 Jul 2025 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtI-0005bm-QL
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:34:56 -0400
Received: from p-west3-cluster2-host5-snip4-10.eps.apple.com ([57.103.74.53]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtF-0003O0-ME
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:34:56 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPS id
 369331800174; Fri, 25 Jul 2025 08:34:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cBn1WfKnGFblnfiu+ECL4GTAAk/dYzreQo9gWD9hOmQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=JVT6X5FeUEwctsExt+1bRGvcen6ECmsrDnzQLx0J6UBqdkwip1ToF15a1AOTnwm0n5kQbro2mqomJbJ/clfnYd9i+UM5KPYzQbTr2jtVHvOdYfBAQzsEHS8OgI8qfsgEQfpgJhd2AVLilp6BixmSyBfs5OcR1KjkQ1ISPj3hPC5QzQt7thy0mfWelnJMEAyp0NxO6n9eLVWBUERighyhojm9ReoOydaPfWl5Rp8WTtNxTlbUEHdlp4XoF3VTvqgPa/E/i8kkYKPxcTN0yYFKEkSI4R8ZPAhEhvV/7GkHTNPZUuPbE4ueLYztdW7S6dPsB9Bpoi10YPxy9l0/9Pfjbg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPSA id
 295A518000AA; Fri, 25 Jul 2025 08:34:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 4/9] target/arm: add asserts for code paths not leveraged when
 using the vGIC
Date: Fri, 25 Jul 2025 10:34:26 +0200
Message-Id: <20250725083431.91450-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725083431.91450-1-mohamed@unpredictable.fr>
References: <20250725083431.91450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fBqzvndi9SxI76I7ymxgiNsEoxl934vc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfX4iI5oD7SDoSx
 8wG3qXYBLXELpdS9h8i0NnA68V8DwqjXTI293s2udLDDz7VPzR6QyZa6Az5UZ+3ioYMKvN8vsTx
 5vT9BIhBOC40of1MqeelVlHSr+/D1oVSYYac738PsTPWlA6iKCTA4ZZANHTXi4u9KbGPuaIyby1
 /nNpH6Gl83diaac4nf5v5r52vX4YIJm/YZW6WiAXwKoiz0c0H6F3DimImakJM7XNjXRlMTamMDk
 NCkU2q/AUOV7uFFfBDnP1RxOX0Q9gh0n67fxlv4gwjnVMqd1N9OEVuy15k2BefuVAX0GCOqNc=
X-Proofpoint-ORIG-GUID: fBqzvndi9SxI76I7ymxgiNsEoxl934vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=662 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250072
Received-SPF: pass client-ip=57.103.74.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index bb31df90b8..7b4e8297af 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1378,6 +1378,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, reg, val)) {
             return 0;
@@ -1694,6 +1697,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, reg, val)) {
             return 0;
@@ -1957,6 +1963,10 @@ int hvf_vcpu_exec(CPUState *cpu)
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


