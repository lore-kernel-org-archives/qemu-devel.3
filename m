Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED74FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAF1-00027R-FJ; Wed, 29 Apr 2026 15:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEo-00023x-IJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:22 -0400
Received: from p-west3-cluster3-host6-snip4-1.eps.apple.com ([57.103.72.142]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEj-0000VD-1j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:22 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 AFEEE18000EE; Wed, 29 Apr 2026 19:06:14 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YDRBQVXAVWBlcUeQ1dHUUOVhlaDFIPWw4cFktGExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489575; x=1780081575;
 bh=gNbSk4mhcSHHYyl7q/rCyMLz2tZgFqhxrKmMqMwETx0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=L2BQXfAM2ZB/+yJFf/VibiEGMinwCTMM5pyaOAANFbfYjxfEtH/Vks/Q2S370p0xuuLrUZYVpFA/gX/Is+t4hdejXTAvqzoJMTD0FyxFVRXPGEDaPOcSJYKKmXop46Pe3eEmrOQuB8hD/bQYn8tC3VfMmklleVJV6E9QT35QIKN6hlRirkUSard2x08flN+yEjrrlgV20yyBT88hSFbUuCiOSVc86z2MtTDqBNbxbdKhkfnK11xhMIqX3AGTsW/DLFct6exBrSX3GkitgrQthecy3MIaEl+OSuYzMIBdl/U51rPQwFdtPMNZNbzBE71G7gmgi5O/ajtt0MpL3wFD/w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 0594018005F9; Wed, 29 Apr 2026 19:06:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 13/15] hvf: arm: physical timer emulation
Date: Wed, 29 Apr 2026 21:05:30 +0200
Message-ID: <20260429190532.26538-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4zQ8q1Cd-A05ceYn43ghB3vEOGqZ8o37
X-Proofpoint-ORIG-GUID: 4zQ8q1Cd-A05ceYn43ghB3vEOGqZ8o37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX2EG28RBeLX/G
 2TM1lxGa1R4EThCp7SyrKH0BpulMgxj1DcfCcv+wIU4/PJaGgFQAmN/LqOSi0QI7+i7ypXJROo8
 O7j8xODW0+TzF/6BaUb/4eFQ615bpikTVImMzXxoBxciVaT1jtCfuELwmnIMkRcaoDsljQ3pNcR
 Qv7H6IxLsaoj0DbWB6po7oYPmbCyIM+Eco5UNriuBn0Ty/mJdA+AzhNwz2mOI7PttUov4z4UvFk
 1ZzHKxsd/jHLQG0k76aUUtFPME5zCqO3ZbDe8rCbWZQK6a3PHmikNG6fQ8a1095cn8CE8oMBwJn
 YlOkaKeS0rfXmqav8djFqjq7o9FAYbVxsDZRNXeQdDs6oSr+GUzuehaPM/YxNs=
X-Authority-Info-Out: v=2.4 cv=Ce0FJbrl c=1 sm=1 tr=0 ts=69f256a7
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=165Gk8QOMT2DXJMqO5MA:9
Received-SPF: pass client-ip=57.103.72.142;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Enable this through leveraging TCG's physical timer emulation.
This allows nested virtualisation to work with a kernel-irqchip=off + GICv2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 51b37b3331..4f0f7ffba1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -189,7 +189,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
 #define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
+#define SYSREG_CNTP_TVAL_EL0   SYSREG(3, 3, 14, 2, 0)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
+#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -1719,9 +1721,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
 
     switch (reg) {
     case SYSREG_CNTPCT_EL0:
-        *val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-              gt_cntfrq_period_ns(arm_cpu);
-        return 0;
+    case SYSREG_CNTP_CTL_EL0:
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+        assert(!hvf_irqchip_in_kernel());
+        /* Call the TCG sysreg handler. */
+        if (hvf_sysreg_read_cp(cpu, "PTimer", reg, val)) {
+            return 0;
+        }
+        break;
     case SYSREG_OSLSR_EL1:
         *val = env->cp15.oslsr_el1;
         return 0;
@@ -2015,12 +2023,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         env->cp15.oslsr_el1 = val & 1;
         return 0;
     case SYSREG_CNTP_CTL_EL0:
-        /*
-         * Guests should not rely on the physical counter, but macOS emits
-         * disable writes to it. Let it do so, but ignore the requests.
-         */
-        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
-        return 0;
+    case SYSREG_CNTP_CVAL_EL0:
+    case SYSREG_CNTP_TVAL_EL0:
+        assert(!hvf_irqchip_in_kernel());
+        /* Call the TCG sysreg handler. */
+        if (hvf_sysreg_write_cp(cpu, "PTimer", reg, val)) {
+            return 0;
+        }
+        break;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
-- 
2.50.1 (Apple Git-155)


