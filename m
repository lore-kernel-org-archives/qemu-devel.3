Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3EDEF5871
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGg-0005QR-EO; Sun, 15 Feb 2026 06:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGa-0005M9-PE
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:20 -0500
Received: from p-west2-cluster1-host9-snip4-3.eps.apple.com ([57.103.68.106]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGZ-00081L-50
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:20 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 D465A1800164; Sun, 15 Feb 2026 11:26:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154776; x=1773746776;
 bh=Y6XyA1f2arTOnceFjb8L6hyLWH6tKlG/yXeOWw4vtXA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=S11rd9+BF5m0GHb+Ac/SsgZ/X5HpRoV+swSBmhYV7UooWSQUlrvjn3TN5elrBLZQinbpOPM64N2Td/QSAgG2W1Voye/APpD8NXu9VdbpJoENDg2fi/pAnzX7QzzyIzI1o6R+XIinkRPGDZL+05IgLMIgky+K1A/Ozu4IlX7HePS/zQDJ3Q7dsT8TJuGeb61bMfI55c3il3hMFrnAXf5dfJYJvoEWE2eq3V9OG/duusP+e0To5M+I2Ngw2Yu5kFEU493NJYyiLvXoQhzI4z8A9uGso/tnFK1v8TssfQkpkRqfTEkpB/4XzMTTNgIXEyqYySYiTnGb9N9gRRXyh8hQbg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 8DF1B18004DB; Sun, 15 Feb 2026 11:26:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 12/14] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Sun, 15 Feb 2026 12:25:41 +0100
Message-ID: <20260215112543.4817-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX3Vd1vtFsVgSk
 WLmnOTHw5taHIewhcUbWni+zxlKEBJY2DXd8NXP9eyOmNeFZHL7biIcdLByPg5TkFWKd1pF+gsl
 LQd92R0dUyj8XWcAOnTu+uzg9s4BjK8p6l8Ygs8TMz0qRkvROFgLgOYK9xSX9HXcTZsr9H7SnF5
 mLayWoQ8WfqSQF6jhHUsc/I/iBURQd4Dn7zfI63U+68OnmiwtHRgD1A25Ku5yfzqNkTAdYZbOvQ
 vSfnNgoD1opQO+Ht0xs00tfYXnHBAtvVB1QCilmWLVa+9hIFdPOzh98NpKLyf1+6+OvDV8rATJv
 1e2xHSf9vl0HqWla9zwh/wiyFdUAmtE92xZaTztwsSwVFfTIAh6rSNSPaNUxVU=
X-Proofpoint-ORIG-GUID: YlgQNDROTELYr3aPwz8uovpIf0WrIhJE
X-Authority-Info-Out: v=2.4 cv=Z73h3XRA c=1 sm=1 tr=0 ts=6991ad58
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YlgQNDROTELYr3aPwz8uovpIf0WrIhJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1030 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=696 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABpZafzsTL747uXfRUHVrZ+XNMAN2Ywcng4q2UkMDDmX+oJGJtCkAuV2TnfimKraI7GDbmgZyriBUj7x0rC2YGXQNDaWQS2LVOW8VaYW8lys0ug5yZwr9p53PHtW7V2iYEfhKw+KNRaeYIyLv0Bm82Pgp5soYS36wnrwrXMRITOweClNkpbg66/1mp7R4in1mAUap/xBVqsZMVCJeq1DeIX0ZUIXGJLwA5bwzHb4MUWivEGAUjTRWHyVIAfaHpfcXebnAqmmAKK5kwYprM6mMFx7ZN8+eVz6u1Fy2yjJ4EZMAVrejNuHMuo6gJyGeL8gmIAzq8+bBenuS+5CP0IiXwa7gBggjhn62822dG+5Kr0zUAtiRfTrs/chDLSbzYsoIznqE+VpDNa/hUxJHxzTBL6qqVbonlmBk2/SuTnExLu5WOcn8BLuyR48i2P2KdoFRXSiw/9uc3XIzMnQUakyP2QR8VkHwEa3gxKUWSXewFfrJGQNcdAj/CYoTw/veOBQZGZ5zPYTaNiBp0KoUOw3mlHRYZuIxjiUNjUqkRrhIklyNzn701BPZog8v0G6WxStBs+1Sk6Dr99wdRFtxqdRzh67gdK65AcZZoP4cgYnQ1EXaDdFr/PrdaRRl1uvWqW6qXw3KB+HJPCmxVbGrQR/6hQwwwHWKXZmCUo2prs2/y6LrSLTziyuWwbnQIFzb9ujyE6HZOVl8to8jZX+cTgMifR2kTpCaGyA==
Received-SPF: pass client-ip=57.103.68.106;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index f286e6a014..8d537b6201 100644
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
@@ -1368,6 +1372,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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


