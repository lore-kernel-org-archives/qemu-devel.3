Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D282D3CCAE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFKA-0004cp-J8; Wed, 14 Jan 2026 23:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK7-0004a2-VE
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:07 -0500
Received: from p-west3-cluster2-host8-snip4-2.eps.apple.com ([57.103.74.35]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK5-00063b-7k
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:07 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 656051800136; Thu, 15 Jan 2026 04:51:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=dXRAQKZUU933wGPCdPRQlvbdzroQQGsjC52KsKmRRWg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=JzdaKAOLyc8Q/VsG2Av+UlQDX0xLn16wBlEt3jua805AU4APEwSulpIPSRvRECramkYFMIjHrW3GTDJxKsuMhJoqFXs9e9+iUywDMvf8E6aidIoUORmfCXu5CLuYIjaxhQ9TkslWbg341flUK4ZyLeU0RNmNk8XyR0k32JEzE4158AdvJrv6sb/o2d8DeI1k6frLJyAy5QuREOO7BIJVeG8rUuBIjPt1wkx9pJ7o7O76Qwn6qTDF97thX0F2pGmy3cKMQpc7Ab+1gNY3pt9ivxWq+G8bEoGtXBEpdz+QBVUUDaxxqaJBTJX+kqpgw3GP3HOsMB/sd0qoHnwTm+lF0g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 E834D180012E; Thu, 15 Jan 2026 04:50:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 05/10] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Thu, 15 Jan 2026 05:50:37 +0100
Message-ID: <20260115045042.70086-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: R-WoSF6LR_WluFxrnIe4_B0leevJFovA
X-Authority-Info: v=2.4 cv=QolTHFyd c=1 sm=1 tr=0 ts=69687236
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=L1bH-B2CdzmaWMF7168A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfX4Q0i2AQxu6tZ
 ej/d8gyJsqiXXFU4Y9ZGPvngcfCn0OnH6q5IL7gpsOWpoLaiX4Omjy3mYmhTkK52d4+ieAxFgUi
 mO+jvVKbreEDbDO2rKbvJ8Qdd/aLfP0Sv6PaU2PjP8KFCw+fZ2DV3W6ecBCJ8EIBbplD0gkOGvP
 m47CTXHWFanV0STGe+j18fxtq5MOEsPGYVoz64D9Da3mu1WRai5Jo7aifENee7tZe7jBUTtP/sg
 7rSVW1i7UAb23sj6XYYmobIZ/u15NVGKd8rjuE2bTPFy2thSCLlDeVphiZ7XBdbx6/QEJgbNiz0
 6oyhD14OmyV13LWaNs+
X-Proofpoint-ORIG-GUID: R-WoSF6LR_WluFxrnIe4_B0leevJFovA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=696 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601150029
X-JNJ: AAAAAAABHQqk96HOVsApiKy39qShir3bNGZuKXmFeLhAx8pHgs7L0KCwJ2EWsh970CRJTrn7p4pOm6TC0Shhew5Cb9c4YvOUrgpw3HdcmL2E6IAMMPMeN4/6G3iy+mxoyGde9Hg6BmV6/Pj3VDnKT3H6Q09GANt++VPuwbDDvkJcyyKs5Zap6BoUqB+cHpEqvbPzpVI1U6qLKNkTd844RdQuS04CkAqV4OCr1Xi/NW+Vj16Myi6dtVTrqbL+IM1sMUI+Su6FB210hwlTEmI4NN+kVBNwbHkFOCjSUwpS7t12v2SJuhGmhqMkM1BR4iWyt8zT2bJdISjA9GioCv9RkNXhsUcbExuDsDkpDdvmW5EER1ck4qVRn4VbNug/RAkacV2IE49yygJ+jvzAzpCGCugumeseiBI8A0qdwOzu4qjZsJZBeeH+A+umj/yb9PUk2dAq7Dz9oBwwDccvrmykPIKOl3HXj2n8SNVWMs/VmY5HNWYHhW8mfWsZrFJ6BwPEi6KFxnvjCkT5rJyF2QXa3e1CR9+cYilbzEp2E8JZnUuHxBKtz9Yx/xJv2Qlrv6PqCfxVZDI9qJ90Swc5twlwcd1XrbPEf5krIhzFSYSj+4zrvTAiTshy/Vp+pz/DcCtDqkCf73YmrjATxoLLLqEkOqvi4/jwPBPhDQtYGKrEXZm7UofYz3/cGm/MNrUi0AnnMLirVVPIs+8xEOSahdVfNSUo
Received-SPF: pass client-ip=57.103.74.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fe9b63bc76..fdfc8497b1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -297,6 +297,10 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+/* EL2 registers */
+#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
+#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1289,6 +1293,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
@@ -1607,6 +1617,12 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_CNTHCTL_EL2:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
+        return 0;
+    case SYSREG_MDCCINT_EL1:
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
+        return 0;
     case SYSREG_LORC_EL1:
         /* Dummy register */
         return 0;
-- 
2.50.1 (Apple Git-155)


