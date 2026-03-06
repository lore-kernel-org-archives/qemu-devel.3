Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3E8F01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ5h-0008Ix-DT; Fri, 06 Mar 2026 02:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ52-0007aJ-E8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:47 -0500
Received: from p-west2-cluster1-host11-snip4-4.eps.apple.com ([57.103.68.27]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ50-0006G2-UE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:40 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 88B851800255; Fri,  6 Mar 2026 07:58:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783917; x=1775375917;
 bh=t4q77Dqvvy3Y0q2FeiECDJSHa9xcTExBPNU7QAvHHos=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=S7raPzsyXppVmi/n3Ig5N4GBAvo2QaYEJSK93qx+lCwLT3tB0IAsdXNEdV8pKpgYbCF9wimrKqDfJ2C3loPSocNZOpUZekN14vxuhPTfOJcUNzDkx28c5S2+pC1Iglz3QEXTEbh6YLl1QLIgIE76wutuLnVA3rTnm3Fq8p61M5rLWCLRzc/iDuZGgJIshav3EDeoVk1pbEhPzXhGrAmPFWBiyd/Z8QIM+siApTzG/iKPlDcCEpH/GXxME77UjspTiUQLfAWw1G2h/4KCN8rA3+4iasdzI+rVSTZSS6oyTWn378zrX8tEu/yWAoUDAemcpr7N/F9JQcNTfV7XvBAhqw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 5DC7618001BF; Fri,  6 Mar 2026 07:58:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 14/17] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Fri,  6 Mar 2026 08:57:53 +0100
Message-ID: <20260306075756.88922-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX60o0Hf6LqQeu
 PjKC/E6scFTiYiNJSe2wvm6l3+Ej2BzD96pmaydHhe2DHpTvhOM+Sbr8HEc8Q1l4m8EJWEcoBPO
 mQxszDSm664PB9nUtqzukiXhb8NWD/iZF8EjCKiDvcliHPuCekKE4jcdkLWL4vlyQwdf7VFfWlD
 7t1vocSbirWCF24+L07MVCDqZqbfAEJPIhvEs5J8WOsD0vjdwevPByideaX3HpW/UDtm/w/TGLg
 dQLrXiMmQWrA24iH5TRV/rq37uzTGvs3F12BvTsifeNf0PnCbQExlvucoNKbcSf8VJN3ukfrRcf
 E9fJXU3Vb7v9dU4qTes+6ZXU4a8p9hGOxsK3FkC1HHt2hRHIAm8h75MDb6bAoc=
X-Proofpoint-GUID: wdn3kpamxfVWy1t91UsjdMkG5_O9gkBI
X-Authority-Info-Out: v=2.4 cv=bbxmkePB c=1 sm=1 tr=0 ts=69aa892d
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wdn3kpamxfVWy1t91UsjdMkG5_O9gkBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=657
 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABksULakR+jxMso2syFeIv1rXtWV7bDpnU9DSmg7JytrKsO4GcoVHNB3gF27BV2NJrUBobEp7k0Xad8lbQsMkmgSrIYD9/Hv1SAIDg3ruR2vTEzN081LeCfmfED10nd5yGVpBydjqRVJPzPxDAbElkGpsgg8gm40paH55wh3fjxNMB9WmusxTfXn/VRT24zcsbxe8VHJ+PMHRYt7A0oho+sn6Tb59ZsX/bcCx0E5AZS6BT+DugjczGjIfgOqnjuYwMVZgq0vbar6O7U4oMa4WRgJkxTs2kuvJawqsJDQnPKjGkiJdjBf3h/neoSTXQKcCJQxgtktK/M/EVq7bozdC23vJbBl90/SnbukRZcwJ/xd9WNSLCcziC/o6MweA5OqukehHVNDTT9RTf4XSXeKkOV/4Hdpkxld+nRVeMkF3gLtXq/gv2RTVJkTBJqIjhFi3nAZEdutiMjrjqHXB7TNQjHPYH3hPVFzTP1QNpIJeSxlR/qOhZf5/LlQuCn+R5t0Xgu7paCtoWva6SruZz+CMX3tNnlyoZjbf3V8lLsI2uipi9C1MPhITwQDbsRZNaQ0PLXg6Vfv8ViFvPfVqsekzN5L+YiQS66pXxFwH7L06NIAKIFsgdtsnlNRmR4ILnU7pJwxTtgNl1i/9nbD6l0/hFRhVRxgg0ZpZ+9bvFZJyRNh0ZXrClxuW1LX+rIFLCEaxBZYmsZwtR5gV/5CRzoMIccWFDqpYKB/O9UQqwEnjmgCh8lql7jnwe1efeLgj2
Received-SPF: pass client-ip=57.103.68.27;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


