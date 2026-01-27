Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C0FD2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4w-0000p3-Cz; Tue, 27 Jan 2026 13:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4f-0000Ta-BT
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:02 -0500
Received: from p-east2-cluster6-host10-snip4-10.eps.apple.com ([57.103.76.211]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4X-0007fC-7L
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:00 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 57B3D180012D; Tue, 27 Jan 2026 18:45:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539549; x=1772131549;
 bh=+CrvNyqLNT5lQ9RKEp5z/1duGYq7rWnoBtjWjWsbGfo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Mu2uji5M83l32J0GdKDbuU2sux8acntq7GP25NSMH5I0atFqZ1UnkUTr+Jm+yCh0b2V6NjtObaZPZzCn9/po9oy3CDzlM++Xtb/MkFPKbApzZ3IWoVU1VdstuxukEneafa1R2jgJRR2lOrnwBCtjn2YUm6Tz0Nz63YppRjnZLiFZKAC3xdyaU0j0/lpBhK+b4dk7ai9ERHTG6ENL1BMUtVtZ9HSWBCBXsv6Wq6sjTs10M54TNyoE9GUTZSGWRazn35Iu4Dl5atci5tKkYyTGwkr8ELvZhzCgbUyUiN4FM5PQubze8UPkwyZ/roNZF91Tt8GjlfYFN+OBSx0C55DYdg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 0CAB81800675; Tue, 27 Jan 2026 18:45:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 11/12] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Tue, 27 Jan 2026 19:45:22 +0100
Message-ID: <20260127184523.5357-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kcw73PcSu-XXvcCz9XMafPGI0oMzjX_T
X-Proofpoint-ORIG-GUID: kcw73PcSu-XXvcCz9XMafPGI0oMzjX_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX8oCMt7N1R/ax
 tFRmnz8QUNmKz2/Uo3mb7eUzNqFIa5s8lW35tGw49VzNDxlK+fPJAIQoxGKcZ+o7y4xzdkPlc4l
 eMhOFa3XKXQr28LwXrndgrTGtK7Ej1XdpFpiWHDnNr+VhwChpTaIRUqW0JNYSppwhZ+i+ePWfLc
 G3V5Fpjz3V3y/vDu/ig12p/bka1vVpS8BRtg/mCt+aoAgUxAZKr6abG0vzApMveYgcBBbNt6qAY
 /h7kbPv/Hn4SwyRgo4QILGhDlHzd/wR6cNqdDkYnCIknAJYqFBOfMwdORK+2KfYlnoq0BEx5aYS
 t/OW31J0a8BG5WIMg8WX9tMy2SEi3BF4iFrvPhPmKQv3pGn7BhuXMHud62Z3/Y=
X-Authority-Info-Out: v=2.4 cv=Q4ffIo2a c=1 sm=1 tr=0 ts=697907db
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0
 clxscore=1030 mlxlogscore=696 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABbpOVaYC+g+UNdiWxbTmLB5UyzP+v1iXYOE1THuGyuDtpddHoI0qVOqmjmc+TvcN+l5dPmYUXVc6fSAEUtyHIkxPS764cC6UDeBTudotsHqVxW50q6D9UbOnIsjhhLg0iC6Xc0/zRYuF3rC9aV7P6C4PX/VsscZU7kRUPjEzeoQ2OzYESKo9Y7NLAdYlMqMWFJ32IYIsf5Hu0jUPgLaooXW8QIXobkCX3rgMXmm7X+D/ow9hdNjcqKoB7lb8LUJYai9oUqCMOCy/GeyYvd+PItlieFjI1nRUXVZxFoTkgjGjdNs3Qj8oJbZCvIsqg+re2rawy4rSyiJo4GeYAM9V8yk6FSNl7Q+uiZ9nrBoKVY/+0WoIIq4PWJPzH/7uxi6rhzW3PHUC1SaW0lfzBu0xyvgUrdkNaAnz7E6l3bpfd/V8lHHflMGHokjmc5hjPrht0+yWAhx8ClBG04kYmBseEtWWJn6PJJYaZHCy3OoVfY1tH/EOd9LcVu1ZSmGupafX6eSXL3rDZX+lCNJJ/uJoS3If1k2dBDjymJn8QGF6OaBHKMLGSJp6JgpvztO9uppCzNwFLSmfDHWMC1Cqs8RKSDgq87PwDaviGd+uhUtmSlSY3i5dpyFRorWhms6P46tD4BBRF6lN/Rj6wWtRltrCERwxYnXwpF5l0IG9sRBbtDglZySYLds4fEAnh138J2+T1iCb8TFpwEoIpr/8fxTumOGsb7dZPiP1UhO9n9004
Received-SPF: pass client-ip=57.103.76.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 39a8b08c9e..2ed48a2eb4 100644
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
@@ -1337,6 +1341,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -1656,6 +1668,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


