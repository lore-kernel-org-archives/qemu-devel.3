Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F627C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Lgg-0003p0-3a; Fri, 04 Sep 2026 00:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lge-0003mn-Af
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:38:00 -0400
Received: from pv-2001k-snip6-11.eps.apple.com ([2a01:b747:3003:200::6f]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lgc-0003kL-VG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:38:00 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 A30DE18000B8; Fri, 04 Sep 2026 04:37:55 +0000 (UTC)
X-ICL-RepId: 01a06ab5-82f9-701b-95ce-47fb1769d422
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsGQA1LBFkFRQtGD0kAQAFGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788496678; x=1791088678;
 bh=yY5NHesJMmbXyN/yR3hvgrlPh/SYN/ZfeqVoj948Qy0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a1IHUQT/AUV9KxTzm4YU7ed5QGolP+UVsTl8VtiF4D0Hdl1FO81DnHdFYU/qx7ntAF1fSlV6TQHbGo1Rm1EMN3VXc/WF0m4SGGX7AvH3dfrsZ4fSmlYId7S/itO1GMub6LO06blHOcEiN+09T32jYwK+Qy3yb18JRifXSoeEuVBuslr0UFWAhpaW0YV2o8ViS0eq3cGJMDxNdMK31FiYNLV4NhBe+Qv1Y/UF7fhyVycMopsc91TquvcWT5rpvp9QUcjEe/TrSIQ/p55reZO0aShoAbF4MnuArYoTvg86/y74ZYYPpAVt9fjikAanCNkJoyA5916tQVG9Hnz05CMypg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 AC3841800206; Fri, 04 Sep 2026 04:37:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 5/5] hvf: arm: ignore accesses to CNTKCTL_EL12
Date: Fri,  4 Sep 2026 06:37:42 +0200
Message-ID: <20260904043742.96613-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904043742.96613-1-mohamed@unpredictable.fr>
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B_fC4Ek0eB8cMCN3U0vNzAZlK9viJ3L0
X-Authority-Info-Out: v=2.4 cv=VYf6/Vp9 c=1 sm=1 tr=0 ts=6a9a4b24
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZC40V5OMU4B0ixddbTkA:9
X-Proofpoint-GUID: B_fC4Ek0eB8cMCN3U0vNzAZlK9viJ3L0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX73QnIR5+Q1iy
 zW8SNgUVUPYEaXuChjHvmfrj8NkgDs3Gx7O/QZhJBTR8A90GwsoieIpxfzZosLYWBVMGUVE/8Ln
 KKHnz2bJAYZen0l2DLWiGHhbXiv0y33JM3ECGfypdtsZ0Zkuj+FD6H8UsHG3e37AtFQNzyGUVAL
 T9NXYlj+6V7Czg/fck0qN/1XsYzerJhpLBLNfrYWltkfB4BZF0hlLt+47kgpAshWzjuxakngb3j
 HFA0dLzmk4LE5CxBH5+qVdvfYn7E9BJBg3PH/Cm+t+R4nLGbjVxbpxChD/RoWMkjm7Ze31ibg2Q
 1nuE3fJb/uX3x35MROGms1PO3QVWuR9r6YhCACgIfJCD7lEk8Y5BbWGgTy+Fh0=
X-JNJ: AAAAAAABeC/rVPsqIETKXCcDex0AHPLadF8rcNS6nKvXjUd56V5WlpLmgENL3izvyW+TMY3pC2+ovskw2uegdonNiE39b1CJVTxDiL9G4AW71U7oayMxiq8YOmhCYONaOAkJvEGLnCWUz7wkruFYY5v7QU3FhYvgpdXztHeLD6+tLERwItJghocTtDWUxxnFk0c2gUePnfBZsITBZo18u8OIy1/OtYhT+48d9pFC7bmEg4BYUtXhjQkOYSTrmSjiORfRvXon84402t9cC/eYA+BPoIpi2ieNuWuDm5p5UhOVD9M+EfuKVWOK61dGurdz21RThGJrf/ErMnES+qbjQCaDa7xtOa657yCx3Z0PHhqWLGIOo0I/ugsLyfh3uDU/mOW76tYhF9EZqXZ9g1o46OKZIKa+blFISt2K+odriEa0r1f84xsKNAMs/NDkWsECDfIkQLQsWctEdj6P1Kc6auPjmK4DqcwK7tQGHkhn3BZeqBpSNQx6z1ztURmsPbb42NM8NSuO2nUm6MHwTJLUVmkHgEf/2uWOC+R2J84cfxXK77/CniEC+Hj5bMc4/Qfaxqu07tnX8WTE3/GtPda8yxGc296kHAQ4jPfozg8+61tM1rQzYoI1sfRohKjtQ/sDHZmZ/Pr8lj8XNFlBcA2wwe6vUMyspyNfHe6OAClJBKix7vTkvF9RPsQFHyp5G2a578iSICJddKGWlftOlyrH3uVaXqM6ZmD5HcBmjAXeeIoCRgmT7MbnUdXYLVdIN6UhGcpJKWbi3OFiysGZ8eSWoUyx874jIm0DQd4jCd8Bpv6Sh8wMG2vUXEA6RUUe8A==
Received-SPF: pass client-ip=2a01:b747:3003:200::6f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This makes KVM work, with runnable virtual machines.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47eeaa0f30..c32c705ddd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -305,6 +305,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
 #define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
 
+/* VHE registers */
+#define SYSREG_CNTKCTL_EL12 SYSREG(3, 5, 14, 1, 0)
+
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1857,6 +1861,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
             assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
         }
         return 0;
+    case SYSREG_CNTKCTL_EL12:
+        /* Ignore for now */
+        return 0;
     case SYSREG_MDCCINT_EL1:
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
         return 0;
@@ -2155,6 +2162,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
             assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
         }
         return 0;
+    case SYSREG_CNTKCTL_EL12:
+        /* Ignore for now */
+        return 0;
     case SYSREG_MDCCINT_EL1:
         assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
         return 0;
-- 
2.54.0 (Apple Git-156)


