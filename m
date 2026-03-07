Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3037AF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyte1-0001Ys-0Y; Sat, 07 Mar 2026 10:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdp-0001Oz-1R
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:36 -0500
Received: from p-west2-cluster5-host3-snip4-8.eps.apple.com ([57.103.71.91]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdj-0000QS-Bd
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 B200B180013C; Sat,  7 Mar 2026 15:32:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897536; x=1775489536;
 bh=qk5kNnRc/8ofMH+hHbzmjYvw1FzBv77gS+l8F0NuDbQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=aTD+6C6tp9X9eZZAStMlFbjkFzOceEngqCALk4QfxM4YotcdWIEgdhrbsh7ntQ2Gu/xl9lDJZLbQr1WKYTDzsDzJzqtiAs84yV9jniIUpuMwDEkiRUv9qt67zdM3IIuUsJt1sY17bo0qXL3cEniru8bdOlU93xAOz/Jv2MfcAlmlijoj7NFnyvFVBJ57XJ/m9DR7DdvxDCF9N1LKI1Sp2jIle7bvgaV3HDDOvvnmjneiRi4pSCu4EYybQ3KUMRz3M3pfBjiqkWRk8WIXpR+6igyb0ZdyBpEXFnppycc3lduZi4tW+6QcRqErf2dz2PzZh6O0nXGA0/Bly9Jrmih/oA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 2E786180009A; Sat,  7 Mar 2026 15:32:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 11/13] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Sat,  7 Mar 2026 16:31:41 +0100
Message-ID: <20260307153143.76893-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b3YGGUXZw5iHW2O_791YHL0JyrQNUdCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfXxDITBkFsvNq5
 1XO17qxeic+Q/VS0UGGk3DK0e2iI9QcVrdyIy+7vOSH5tkD3H29MxTC/KZ69G0ldfEA2CSZzY2Y
 eNe/WC5ZWl94YccQUTMVbPDEi+Qxgle9ahOHB1Tla/oL8SwjPULCYeedGYN+eESrB3YMCT6bF6h
 PeGM2m8GrmPgB8Lrg+9N1mFkg81AG+DCIy91PhpJMlv93XYWKJ0+5RMSufgH3OLHXE3gptcwjiW
 d2pjhBzUfCKU4b6wLr1tRppHNqVS6EOAhrSuPDJrqpfWPHVeDch/hW7QC8CnqU2lAW16XxR5gI8
 RbxoM8ArrZM1P+FR74d2v+2cODknmU0NnCPe0ozmjyE4oPBMpN1g+x72wtquu0=
X-Authority-Info-Out: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69ac44ff
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: b3YGGUXZw5iHW2O_791YHL0JyrQNUdCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=578 suspectscore=0 clxscore=1030
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABFb9DsRDarQcWzsjiyNiMVxYMz//2CyvvxT8foLJgWyGHUeUhhkw0RnNqO/cdESWnLoo+orQtEeChqsyGzdJ8/oQKGJh1nIGUxQeo00H7mftNufSmjXaR+80/YQajK6aHVQoPdlUeUis45r9U3iNqoiFNhlTXqJtZoIEn50ts0bhEQk9nFAP3jSSICnT3LcM4gO6fpqmbNuZ8xjBPyLSbvVREBjsCetltGIlN3zd5+VdDiDfT2lCVUCU1YwVJtWpxaAR4F+iRNuFAL+yFxF9UC2hKJ00xOUUIrBTQdQf6VoubY9bxYJUSu390OLg1JDbdqHYqq4kzz4zsY9tC9sL0Nf0G1hz+xNgMsezAJJO3PK5mszm3/uIFFwK8GX/JhFFimbvNebkDdxLtXQ3rlVMkTrd8OJxOJKSTKJsz1DbgMtvgyT5H5Tv+H+eq9M2N+xHT/e3RahX5UD6xcJXJPn1vYGQBUGMG86k7GCTpLNkEv8Y3ToN11panf+8/EmjJ1J9gtk1a5N56KE4fH+XvqjyWJffdpgXSNSCvREarshXiVFWRtWbb3N0J2xNvt3gmqWBIKcHTA6BBwqOdZ3MLOLTaam3XCwWuj5D0UfaK1stUKB0rPwP/B9NjSugbSZusOu1VYrDAEa6HcjqdJmjO6B2lqgyLxnnT9/2scbpF2pLzwsaJIk+kVceitMWv+KQls5ZSzfI9B+Qe+mP4fNCbHdEFmBn0KNd+GrOXIWyJ4SqwFKpefnPTrk3C5w==
Received-SPF: pass client-ip=57.103.71.91;
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


