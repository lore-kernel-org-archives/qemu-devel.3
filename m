Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D7AF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUov-0001bF-Vj; Fri, 06 Mar 2026 08:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUol-0001PH-Vz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:14 -0500
Received: from p-west2-cluster2-host12-snip4-8.eps.apple.com ([57.103.68.221]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoj-0007BD-OQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:10 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 4F7D61804C44; Fri,  6 Mar 2026 13:02:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802128; x=1775394128;
 bh=8CBX7iwpaM/+kvFrxkVa9sONnBfJn6BVBaOm8ydKF2E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bwZkoul3d7bFxMe+YvSEoh/AsSqI1Vq81p5rJUINP9v1oHUP7hRbrugbbNlPxBAn5WuH2jNSyuu+Fo+3JHbQr7O8s7QMeqaDmmVqayPd5W34gf4S99ykEmKj6oCHXycyUZ4qGeICLA+jPbwNf/DbXN0ItmA31R6nDkfUhqpnSobSaQ3/aw/bSHaxyDmZTbZgKw9drJjgcNwW6VjOxygR6s9t233H68Du3T43YpT+7gvgvLjY30JhJiTLiYy80qcUw8Rm0tkUYlUU6Xo06p7csVgfLfxUj23zpJQfTZIZTNwmcTJ4SrYDwaZxIoJC2s5QVH5eDwiFbMliiP8OtlMp3w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 85E0F1800476; Fri,  6 Mar 2026 13:01:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 15/17] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Fri,  6 Mar 2026 14:01:05 +0100
Message-ID: <20260306130107.35359-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=TdGbdBQh c=1 sm=1 tr=0 ts=69aad04f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rNrUgMQQmsKL5USOO3m4EQ2ZU-rbPOAJ
X-Proofpoint-ORIG-GUID: rNrUgMQQmsKL5USOO3m4EQ2ZU-rbPOAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX1zF+IlOWLN12
 JSkH7CK/ENtSEnYGXJmiJYFe2uj/i/jo38Z2tlHQEIqwpEq9e9F2dktxIJf5saDJU32L8IIODyX
 gghwT2l+4D+wEm54OHcF80ALZcsMreVxAK1wF6ya65RQTeZzIu3066tBl6vePruO4rwt6Yf4Itl
 qDzaWhB6uK+bbWyR7Aixn5rS9E44JvL/ebAWNnpxlpBWVSy04wru/vGkcCkVubGghL24zKZiI4p
 K4m2NrF77x0W/8fBVZuQ7Ib1gba3CxMWVfztIqYXAQ+DQsGFYeQ3+kCHhQiC/YI3VqGmE6E7OV3
 YEB1oMk0dkdhEAEcq5G7HVPnPNgUwWOJkXCcdDO6T+3tj3/T3Aa7907PFzBvFk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=648 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABLBhBhIyeWC/jCmahJUN7AMfJ6lDU1Cpz63937NybQ/YpA6mdl0hzqW/RlaAXCQQ25d4wThCoq3QVgVnqSnOEiEhYDlDnseWKlMDN+NiFZrnRxUBIONhblgpOVNwZR8QST77hl86+DhiHHkDJzJHQkworAf4zJ883LLqBkkgJLr+fahz0ZfghOofRGuU5MNkghMoRoQ2nENIeg09R+PgLWTi+PCxjzaIsunSp+j8VFmFkBkXrFNshlgqNfuaAjJ6DnPop7k2QSPcD1tqJmL4FKmSiOWmgzQ8MyBkunbSy9S7YxgDlTf1hUM92WLyGTBdBVHre8aLtV+9nHFvySwz2JWokWcavleWDAUNui0I8OVripphiMxxpiXtEsaLY8PA57gkaOordKqO5lJ9whFGVmouKmiZWlhPiRy2dzvMd/nXohvhK7Fo2p5ffOq69NRgI/CYtU8nzS0ch1xO/AunXLyjbupPQJaJzuXTfEh3AW6Ci8NyUz4l1r4c/oN3DcnCuUJU1QThTzQXs6aWu/XHxOxRSN44Z1N8PQz+ApAAYQDJVZ5zxB8NYLXkmLL5VMJFfRaEsxiUtBGteN4qLWE/KPf2t3wgdzbK7rLl2klq7uWIIbyNFohw1EVr0KCT8fyxGYHdjFcpgZ3qryxF3lEocA9ckRRzn4M1uF0UuaHC8O2HLeegpqS14GyNk/4jmWaJDYpcDTu6mEZotp2EeGhJ0xxOudWuaA/vCC0BkdPpCDK0MlfPblaCUb4G5UQSvAu2kauINbXNAKmvODqY=
Received-SPF: pass client-ip=57.103.68.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
index 6e41789ba8..0183dd8a60 100644
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
@@ -1684,6 +1688,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -1972,6 +1984,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


