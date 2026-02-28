Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC7DFD0048
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUg-0002Ys-RA; Sat, 28 Feb 2026 17:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUf-0002XQ-3K
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:09:01 -0500
Received: from qs-2004j-snip4-4.eps.apple.com ([57.103.84.97]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUd-0005pM-NR
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:09:00 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 D76DF18000BB; Sat, 28 Feb 2026 22:08:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316539; x=1774908539;
 bh=Y6XyA1f2arTOnceFjb8L6hyLWH6tKlG/yXeOWw4vtXA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=AK51YNkiswPcqm0R073U3/mWtepRuDUiNLy+OiUX7iAEzzZWJcCRv0v3EGPxlHL1g7O2X2laEIQ+RpZ/LPL7blU526NqIY/Et8WMC39RbaiC1wA0zJWsZOdGMGRGmxY7xPmLGM4ILrgI3Gre7QHfC5xdybNPJYZnoBmfrBhz1EfoyiFz9PczmhACMcl7d04Qw9AdsJV3Sh5vvXe50EDjP+J7ksTcUB54LKzsA6rHW3WCfOOX+tIDYBLKW1WQKlDCBa+99efEWQZo8tBPEfT0e1rWIYCLQm7BZvflOXayEASwQvLs5hgfNYvW9CczgVhxqMkHkoNuU5U5lAp1v2UpMA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 2E4D6180013A; Sat, 28 Feb 2026 22:08:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 11/12] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Sat, 28 Feb 2026 23:08:36 +0100
Message-ID: <20260228220837.35275-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69a3677a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D-Os1W74FdizXDcUohL04NgqcuLjZJv7
X-Proofpoint-ORIG-GUID: D-Os1W74FdizXDcUohL04NgqcuLjZJv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX6FvFBP/SrP5r
 PzxuJg4/eoFukrow90qbUJxXCq/v+IRorQ3zlJyZRIwDHlmssfaCf+DopvMZFpnYgQ6USnDT4No
 xe0wB9MMzJRd6lddB1AbZJAFGxyzdBLp4kw4Lp98jel3WKbkOrYB0iYiun7DzIxkJNCMP6FUzjN
 YqghDNbiOyJ84o54zs42GGVZieyjLkaJuBIDaT4bLC/R0R67RzJRwU2ak9RuptuDArUDufhB/43
 OLSxOxGyPB43fEi4KvlM8HV0PSuRH85EXfnDZGncwtx8Bq3B+mX0S9jGCe7Lzjd3nPvxv2ngX9X
 MYWfI+DP9CvOgU8lIUyStwBz9W1OKA13wZax/D6m1Q9LtNEetmPiY/9bUWIAfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=680 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABO1U+7hH3nVf4X0oNKjBfbXU+d6cQ1zjpfJfdz+V7ZXTRakBjEyj1WCHF6FB44LXlxcOVZK+64iRewhu2Ag9mgmtYqjLmL+dBbNcueOxNXznXVsngAYqUdLDpuR7R3Yfcr9avVQeMHMPOQUTqYSyWgdqdnmL2prSVKf55eyJuRy2FxF/njmxREQUt7HJS21Crh7C7W99KhLlU5EjGv9c0qZPl00Kr6Y18UL9tuJYWcJpf2K0nk9k8djQPUkHmn4Rk2HD84F285CViXKMtqjDmKeHxbiLj5i9zrqsw9iSSnclDfcA80vdJ/jeAGrag5DOt6KLa3a8KSUcQz7W6FVf+95wWPA1zN2rpxSUgfdueIE9+bBAmuI/HKDBrGjYKt2aWzKQ2fnQU7lPwINKqnmzvLPeODyr5GjiikqnwiZGVdTLd6HL0nyb9Ars0kPZNowq+f4LkfEUyNIpxN9iQ/cAMCUIlX3gMS5F33adLa5f2mZp0ZO0iKBtHMJrb0zKZLLbz5EDOnqZnV6MDNVhYsYmPAt8OIoChW0SWoTqsx7xs+Fp69UZMGUdqagsJFi1BXjqVwxnrID66+jfYJV9dY/1iQ25xW7xUm3l12tcas/FVb6yXmmOAThV+R03FibLQSeIHU1MCT4LgDMI0nGIEHdpiPkjVldn3CtuyyThhgTVIRg2FJwNG3rrNhHQREBuC3mBpqJf7EHtH+PgCww0dCchqi/EH/cxnIDOFS2LQ
Received-SPF: pass client-ip=57.103.84.97;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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


