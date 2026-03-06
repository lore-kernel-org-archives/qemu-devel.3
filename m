Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9A6F513F5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdz-00060v-Mq; Thu, 05 Mar 2026 23:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdx-0005wg-Pz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:29 -0500
Received: from p-west2-cluster5-host1-snip4-2.eps.apple.com ([57.103.71.105]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdw-0002WV-4W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:29 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 651B61800571; Fri,  6 Mar 2026 04:18:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770704; x=1775362704;
 bh=t4q77Dqvvy3Y0q2FeiECDJSHa9xcTExBPNU7QAvHHos=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=LVoN1qOFV5ukPV20FneBEFBipfdtAb0THp6E4L4OZH1UI/kwgu5trKWbvvPrmzzPbn+0XfgKad5FiUtQ/PVSpEqv1um4NzQEeIbHjWbkG7srZ/k/TN5XoxZJhgD88fZ3qCQ+/9VkOUJ/tt3FJOfF3uZ1XMf+Vu4sgWRpIBssFGu3TIhl4zdHKzneEiFEj7MTu9Q3snTMwUAwEjcK+5a5+9XzwHsD8zIPaYb8GzqMd3Y1ZW7l0XEL4YDqt9xawcAiJut5jT3PefYR9MfLLW1LE/KPjVNluQFmRAgXJhhbTIy2dWGTnCQk5tr71zlcYDJYb7FXP0gt4Y1/8SRS3AClPQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 3C01A180056F; Fri,  6 Mar 2026 04:18:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 13/15] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Fri,  6 Mar 2026 05:17:44 +0100
Message-ID: <20260306041747.54554-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX4FLK+H+WKlMF
 1ZUOztebIc1VbnXU2WDXyFq3Oe8vizsCz9SWXBWIm6fD01Of+un7Kgvz7sP8+hmHW8u3g7b8bU/
 ztw2nJ3wRYkqDHPSpJXBcexPOZY8bCITYzocFjrU6m43U3LoiJOE5hh/yR7bQdvyF03G6lus0zh
 EaryQ/oNRNJwKcXxK88HCD/+MbleZZhSnq7N0CkWYFb5RVw10YjZF9Pipbrz/CYTKwdAjtcM8Mi
 9QYbNc6YIjxSX8aDhpOwF4A3z89es2S5Oy1/5B9Xw2cWXfE8R0NWt7xkFfz8m6RgyyOdf1+4iFP
 UstR86PhCQBXVbatRGKxW/ZHKh8A0w0vUIysXgPb169wLZFNcNFXLEF9mCjNhw=
X-Proofpoint-ORIG-GUID: fedJY5RNZTgSOUeeTOpdV-eAxl97LkgB
X-Authority-Info-Out: v=2.4 cv=GaAaXAXL c=1 sm=1 tr=0 ts=69aa5590
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fedJY5RNZTgSOUeeTOpdV-eAxl97LkgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1030 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=657 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABFVMg4lAjGDlsae0y+2ZbBqTnddnAs8CABW/gssa65BCc0hpJVhnC1lp6A00GxqeJmFqG0e0qjZ5CjBhqOl5D0QawbMPv5wv4XZSt4W0hpnBxdMJdkXHFqqDFdjjf0i/Xn+GBB8XOVibDpYdktnw5QmKOoh/sguc87PwL8CQU/yjxXld0Xk5VXKOeBgjPkBXIyc6aD3rn3XNACD0uGeWiqXiMOyBkP5/xAEaDm5LN+mmlM8DfKMfck/BX4rzBIxaV5BMIC1rGYMQu19g3DytHQaaQ25clomE/h1gRy4EjMKgl6N1nsf2XMMsWnCWhMxmpO3FumvPAJe7jD6Y1WnELtFIgKDfShU0ZCaQJhWXmdgnpum6RqpKi02s6ZO6F3Tlx3HLkr59+QY7NiJGEERsHXlNT27GylrxeRH5H2OjTysOhHA6rBowUwQjjMMOTKY5+77JBJo0i/NQcdq2VM6ksFEpSw+FHI0kL6+5cU05JifuH2iAcfOi/+N5lhlUzvdtRWy+ESAM3vuqoR735IA4YMaPR+l3dN339NnnPmUJFYdk594f6qFsXVrW2AuGmM9OMmWcnO1RNGeCNfQI5XlL+kSHGU2+RPDMpvXPZCfxHtRCl3h8wGm9QtKdPcGOJxSZBAqrWmxCxWHg11ImlHkrhvMkUkPrHqFuTgk6hWzmUubmu9tN8yz9eZDa1Y1LOQiQNuRsgbnSqP+BH7seI4rvbI+8Vk5v7nk7YzOR/PtZDxZpuv+BZwHkuUIAy
Received-SPF: pass client-ip=57.103.71.105;
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


