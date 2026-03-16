Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1FDF506CC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fj-00010K-Nt; Mon, 16 Mar 2026 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fg-0000zA-VW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:48 -0400
Received: from p-west1-cluster5-host6-snip4-10.eps.apple.com ([57.103.66.151]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27ff-0003fN-FM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:48 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 82745180343C; Mon, 16 Mar 2026 13:07:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666465; x=1776258465;
 bh=vcEZ76fInut4X77oyKjJUctXE0Az9GETyf6eiquHYdE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gkdX2kkD+Nxi827y2zeoSyA4j6FisfCCdNVmccYyXwk1c74uGP/DuN85IKNIWBTvciabikr8Sq7wprOnsO6s2g+8DebDIiQsI2/mczFdI/u/HdRuZXcDXurl5+CmxqQZyaVMLF03zKrxYvPAP8VWTjnLVwaM+gTMmvwAARJh95AkSdJAPU32PztcmBrN9BgC2PXRVqwygfF48Q8s+RwDOg1XNwIx+px8NGm0ktVtYbrnwhvQCpg/ChFp91pjoUJPAblG30gQDRXg4a5WFSB6BrnfjCnET7VVNiXOwqsA8ocmQMP/CflPIluVIqwL2fpEYR3Pj0p8meR6+7bWgr207w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 DF2CE1803D20; Mon, 16 Mar 2026 13:07:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 13/15] hvf: arm: physical timer emulation
Date: Mon, 16 Mar 2026 14:06:40 +0100
Message-ID: <20260316130642.13246-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=L/QQguT8 c=1 sm=1 tr=0 ts=69b800a0
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=165Gk8QOMT2DXJMqO5MA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMCBTYWx0ZWRfX2h2h+jNihLzX
 yhmb3mFH6C/YipBvlX7cNronbzk/GbWk31WzJFl37uGxBF9guaA+0pJljxFsRFmO+55IPeD9heu
 A3HJUhieB5l9SVcpzIxWiU3ujr2enSLJ/f0ZqY5RZ0a/kJ0vYcvwqg+JIgvl0ecQJPfcizR7NZN
 3dYGrxWJEdA7+R/uN6+I1AvwvF2rQT7S0LhMYYkVPCtf+07dck055CS2H5/7ZaTGXWxePW4BP8W
 +UznynUSAvOKCoAMPEmoONJm2rZrJu6w/pG0blcSF0pTSU6gFfN0n3i08WP9DqRds8JnI4dtp8R
 DcBnX6Y91cL0ShvOrxlc2I7XugAqqKF+AzkiOvpoX64WXRwFEtyGg78+7ylFuY=
X-Proofpoint-GUID: b0sK3AG3IDfErq2fqaflESjZb69O2_6a
X-Proofpoint-ORIG-GUID: b0sK3AG3IDfErq2fqaflESjZb69O2_6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=806
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160100
Received-SPF: pass client-ip=57.103.66.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Enable this through leveraging TCG's physical timer emulation.
This allows nested virtualisation to work with a kernel-irqchip=off + GICv2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 88d4732fbf..33fdd9705e 100644
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


