Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EDDF0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQcc-0001Ec-I2; Fri, 06 Mar 2026 03:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbN-0007Nc-T9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:08 -0500
Received: from p-west2-cluster4-host3-snip4-10.eps.apple.com ([57.103.69.241]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbL-0002YY-7w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:05 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 5A29718003CE; Fri,  6 Mar 2026 08:32:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785921; x=1775377921;
 bh=t4q77Dqvvy3Y0q2FeiECDJSHa9xcTExBPNU7QAvHHos=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=PJyPmKGmCpn3hohjO6J0ZmQgQQvu4X+kpxobTTRcTjW3sf2YbHGLBE5GqZ5f8ddaY1AGJXjkAz7TmW7skrJpftKrqOFt+I6/QgI+AwxmoTQmc+lLhjjSAegpAgGr9kuwvRLCOIRdQ7cLJtuc5suaE7nTE4REfU7KA+5zcX328JohqaRljqpFnW/ygIzjA8aP+2fJs4xbk/Caf+Goco2p+QwM5dNXiPteUWdy2YuJortS/FClcuBG9wFYUnM5lXN2qL2zhz4d8MfoBdcUdmSnTwUYb8/8hPmtPW0i7hK8MI5IRL0TAB30XEY/H2Mu1C2zW4HMn4krHTQehpLeAlp1cQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 A2BBB18003F5; Fri,  6 Mar 2026 08:31:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 16/19] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Fri,  6 Mar 2026 09:31:10 +0100
Message-ID: <20260306083113.74177-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Yb+wJgRf c=1 sm=1 tr=0 ts=69aa9101
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nEevsHPi3Rz0V0tkg53yL7rU5c2BLov3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX6bPpmbt1N3gK
 MjmmvGlyQAcja5pjgB/emCWHnfHHfkxNm0jM5IgGiZq/KI14KxZAzs1onVrgFMEa2yvyn14shQK
 fi8xYGkg6z8tjg55iWhRAU7HlkRVLDW4Cpi4q1KrUpXbeTy9ecw4g4wdkQ7CFp+rejidkQhRZaN
 x8hQa4vCi5BFkHqtmAs3vRPsRZLc1CQegURxguOdynsKPTOrzigU6V/K4u8DLeyiigS1dhc7W04
 ogxCQsrxo2KK7r1HqZs2POQjIIIB0ymR06NxDdBjEg1/uHCPNArCP71m25PGxl/TkPRmqmNktI/
 mOVUAOIyPnMzdHUyY2m3aAVHhX4I807NbR4MsTpf2kz+vU97X0mm+LPQ9Txwv8=
X-Proofpoint-ORIG-GUID: nEevsHPi3Rz0V0tkg53yL7rU5c2BLov3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=648
 bulkscore=0 clxscore=1030 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAABamlE6HEqmMjz0+HIc6pNVjxaRjDwS/HV+TPwk1NXhX7dqf7TRMAMtlFrEsoGTyh4RtlI06NzbmPQ8wtv8q19hCkc66AbMyydqNZaBJWSwG4YWT22MzeZ/HreeojXhRlGO9/A5xO5AhM58zQAyWNq4fvNUfneCHKD8AIDsfD6XQoKqMZPv8H7gNGJGmblNFuirESD2CRoOANX3gHRBGMarKqF5xGC/C/Bj5xL4zeOOoJ3m5JxuBCc5P+cWQ13IHVVaRnQrjjTwt712KyXEpCBAi0BxhMDYtHkEVzr0fdoeTCWUQG6FPAVNUm8nIv2n88AbzaKyaVEeh4lzmX59Na+pHQQv/ZcF6IRpzcKP8qHWFxoP0+gKY+vl9VN4uHkkUqNVeM6QXxyrlIc6JfkgSHmfsKGbcVBMaO1ts3qoFIkLq1L/TrPKrgNdCNPyS16qrMeTvlum+J7fee9/NZ7YdNcFildo5byigjszjuMob2DD3pmjVx6i4lKKvnIK9zL9gRaRcVqFGn7EU/bMZRgQ3ejug/nacBjL2qMKqqHi7rdRRuBDJ1zCayVAdsNhf6rxP4z5jtqAOyWmJxVeVJASgRkB4UVNlKaloKT9eleUZvm4H4c+NSUIfrKfOrvAKzwWSSggdYviU1bHxcsyxhwe7oA4skm4ptSOS0TQz/i26HBSjnCRCqX2sWHyhnUHlg4yD+ISgoa778AgwG8MyG0vjHdBtgQsscbkuSL3g+23fA5YyLVmbT/3RkePi0F8BWRKyVKRxA4WHScoD6z5m2/tnbO
Received-SPF: pass client-ip=57.103.69.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
index a07702047e..8d1333cbb4 100644
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
@@ -1662,6 +1666,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -1950,6 +1962,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


