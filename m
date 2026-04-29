Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E599FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEi-00021A-7J; Wed, 29 Apr 2026 15:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEg-0001yP-3D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:14 -0400
Received: from p-west3-cluster3-host11-snip4-9.eps.apple.com ([57.103.72.220]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEe-0000Ss-8w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:13 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 8E8F618000E9; Wed, 29 Apr 2026 19:06:09 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YDQhQVXAVWBlcUeQ1dHUUOVhlaDFIPWw4cFktGExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489571; x=1780081571;
 bh=iP9tdJ6jkY5u7kiEfu0n/jB1gTl+WbYwZraw8G3pTMI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=HGz/A+xuj8BYWKG5JK6HRdvjyGqvRSGZQU+O0djNiMjqiMoi/e8Vpm8jTNDLyVS7/CnYAa6V0xkTTjSs3hzSvWHi3iAVkTeulHU9j1pY9VognpE1AhBkzLWkMbZqXUJzE6KGyzMnbrx3uv0rmvqpHTBSYF5/uTfIKFGp3/clYfHF/w+2HLMYcD4DYednfeKTy3CpYo0vfBWmKlkbq/fwoEbTK5HgrqGSB+DW/5yxmB7XclKn60zRd6oMab31J6ej4sVx5J4PERudUxrCkfZu52atlPYgpVIr64OrgaT/qFZrp7uh6e3CYppaCaxFwBmPE2IUY4O4TGf8lraeekFASA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 A0B5918002DD; Wed, 29 Apr 2026 19:06:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 11/15] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Wed, 29 Apr 2026 21:05:28 +0200
Message-ID: <20260429190532.26538-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=S+jUAYsP c=1 sm=1 tr=0 ts=69f256a2
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=L1bH-B2CdzmaWMF7168A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6PiupehAnuchHIJGeP2gkUsd2Y0hA37i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX2Aqj/wTjqSNA
 NpsWEERJTRzK45u3wmGmgVjgVkuieXXihDqzKvXDA++MCOZLS9Gp34yQ7nuepjcsYy1AGGqZie4
 Z6h4/RKO6oF2PUxGsDQXc8LDvKq2poHSIGx9NX6a3POQiAcB4u6ePDH8x0lHaD7J5xOWDzD8R/3
 DSuzU96w7o/I43exG2pkvtHZkgfuBp5rAl+HSxdosqbSaxCApc1WOK05rf+irTH9Heib7LFREUN
 VhLnDFZ4MvxTBGSazI8ah5vCAclRETfTfV0ao6e370YnVzDZIQSo/Fj7GU6bBpDUV/vpRowcpxX
 aH05sKN4nd0KsvfI152ZJgIfp82PcK3uXnCSwV9JuQ7FKq2B/6MOlYzAhNalFk=
X-Proofpoint-GUID: 6PiupehAnuchHIJGeP2gkUsd2Y0hA37i
Received-SPF: pass client-ip=57.103.72.220;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
Pass through those accesses to the Hypervisor.framework library.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c40327ea2f..ceeb61fbc0 100644
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
@@ -1719,6 +1723,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -2007,6 +2019,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


