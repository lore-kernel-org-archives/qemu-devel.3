Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05929F55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0W-00024x-Qj; Sat, 07 Mar 2026 13:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0U-00023b-DZ
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:06 -0500
Received: from p-west2-cluster4-host1-snip4-6.eps.apple.com ([57.103.69.197]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0S-0003Xd-Q5
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:04:06 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 CE2901801271; Sat,  7 Mar 2026 18:04:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906643; x=1775498643;
 bh=qk5kNnRc/8ofMH+hHbzmjYvw1FzBv77gS+l8F0NuDbQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=W+mdJJY58rBofdaSiaVkj+ahTF72wrpHCWVRXJ0vxg3xCsfcg86ew8SNWmd6xy5a/RJQbK7KWrFZkp1jaP9uRsMkQD6CCc/ESH7rktAt+SczGsZ+mIPdYZo7r88BAmtqX8lS/Y/hzE+LhfrZ8Hl/bZzMWpoxM9QkOrWrMWcy3fBiPMuVmT+n4ch2W6a75fqjhK4nsX/55U/5kh3QxXcWo0yFCBorbA/H/hrXN/MUk3DiGhBAQ7Vd4VKoIsZtff7eupARUCELhJlZ0lpdAHpiHl/A1CAAKvEjToH9B9f1L76Y3OUofJHFLHWdYFzt8sWykB37uYziEw+AYHxus1S3NQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 67CED180126E; Sat,  7 Mar 2026 18:03:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 11/13] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Sat,  7 Mar 2026 19:03:28 +0100
Message-ID: <20260307180330.75168-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX4DH9kSKqITn6
 npQ+ZHWq1pWzs0ZSTbg8nVoXool3UTmw6XfPFvOrOo1S77Rp5TjOSlvQraPyyInUGI3VGJPFPHF
 ENyLfhpnAB+esq5n1xQsufBSnP/8KQdVW+j844Wqj/9ffCU5o6YdP/QTnUXth9ABupam2bjfmZO
 pHYpIB6bM8s8BYY0dhUBKLZP9bTHe4TRK8kvsFZYieJMsURbDNN+Jr6b9YHkbeqMle4TY2WePa2
 KLm4rnYHdejPjURjDmbMfGFqgN8SEaKk+DMuEB0nDsuMJfJyiLdjMTONLKEIuVwW+DEsE7HDcev
 GwAR0PoNVnP247+xzUGHOLdXdP2bXg7j4A7UrdFH1uGnXgFjrkoptmq1cbo2xI=
X-Proofpoint-GUID: sTPdbL_SEmm0cmavCQcpEH9oxfRjYg02
X-Proofpoint-ORIG-GUID: sTPdbL_SEmm0cmavCQcpEH9oxfRjYg02
X-Authority-Info-Out: v=2.4 cv=QstTHFyd c=1 sm=1 tr=0 ts=69ac6892
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=578
 suspectscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABXQ93YIyfRvaFHCz3ptW30WhyyHio8u5N+6kdSkI/9eS2MuGZF7QIvQJeE0ZguzTyLRHHozZWzKFptUg+41EjSWbZhEOhU8chPl5OrH/MfkmITsyHVKi/bnbjrqhBBKl09vQYy8MbZj3ss+6wjxtSOvKb1PMfaFTmFgHqHZsPQwNVlbTx0iiNAI3tsL3pmQdcHsqaqGoauXpYBtoaMaM5rQPRTPEuK0q9CAw/TN5IMf1gK9diUIxeJoeJDs08loPDki/BLU1n3+RiiKeqdyQyIBbGaOFqau4wDjQp4oVhU5XEWUBdjnSF6++hUOdmwPI57gARPeeetWSjSm90wpm3OBdsEoolYnHZu1kn2D1fahQ9yeQpF1M3h5WdcnrEf+NHTGjzKPaZI5/SrtqiYtnMbdAsVPylcDIBQzfPeOaHF6vFYrccktTVNhrHL2+uiq3tolQ59k8lkkKXQbKpJgsFU7UVvV/V3NfC4Crux5tZ7U5YiRMheDEjHsu0wdFyte/hjli8CX4ooL5c5frq1EO4xtjfgBRhYddO2dB3F8zE0dRoDXlPaulXEY3afruphoSYqrNk1WWbt1njihHB7U9054srVl5CWFKtqPNTPd1m58Z9sk4alMrchywtln1p/v5udaKzIF3aE9IPnjOh6vJvjmQIUO5P5eS8S/9GcSDatun8XcEY+8LXcBtw7kY5kEbNisLeh64GufuDAxhsNGEOA6nCHWUiCuH0SRofGyJONO+bUNfG6DVO
Received-SPF: pass client-ip=57.103.69.197;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
Pass through those accesses to the Hypervisor.framework library.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f6385532f3..03b174a8d4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -296,6 +296,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+/* EL2 registers */
+#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
+#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1704,6 +1708,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1992,6 +2004,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        if (__builtin_available(macOS 15.0, *)) {
+            assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        }
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
-- 
2.50.1 (Apple Git-155)


