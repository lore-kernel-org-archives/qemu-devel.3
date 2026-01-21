Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08340C4453B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjn-0000Iw-NK; Wed, 21 Jan 2026 08:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjV-00006f-7b
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:55 -0500
Received: from p-west3-cluster6-host5-snip4-8.eps.apple.com ([57.103.75.111]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjS-0007LG-Pq
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:52 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 D69FE1801C50; Wed, 21 Jan 2026 13:58:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003929; x=1771595929;
 bh=T2uYX3ZXjFdzYZIXfuq1mJX71N5W6sfpEAgNTzUdb+A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=BAxd4yfmYUg0B4CiiKvFvG4uCvQXGsmIPDzXM4Evb7QxbVLyn/u3jSvB57Ogj5l1XQNxU1XinEMTAUoJ69bf42yJwi8u5epBhLlWopKu92Q3W1kuwEearP7IrO4acOXUXFn1oXCKsuTte+ykA4WH5W1JJnITZTYq4zjVVWqGm7LhIi5zrpwYINNlulAKP0O5ZSPsRQMESCZkTGzdWu4guceP3Z7Sc9NwaxtB5k0ozAd+kymH9Q1Z4qJZR8Xe0uilVstVI0XuLNAu7xmiimvOqi2SG0w+zKU2U28Mq4J3DJzlFdauL5D10dtmYs3cdqPOW5/hXKKqYBJtiSvbL9TG6Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 2AC71180105A; Wed, 21 Jan 2026 13:58:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 11/11] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Wed, 21 Jan 2026 14:58:16 +0100
Message-ID: <20260121135816.21258-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfXzGE7P7yxasJ1
 1qm1qvGaWhyhbdungbE4yb6nxSgES3LBrRmzM4MzOos0yEgkyiyt6S6N6w3edKO9QmLb1BPIC/2
 hCfKQNHlZZ634ekIWGzkps96rapcwcbPv9Do9W47makWYDvRb4NQKRBjanvf+3nllLZ8fnBJjDq
 4385Iem2H3W0Nt0EuKAdnKkCP7SUoU11uZWfdZF/ZZMw7CkacCLH1h9xWj2/LYg0d6+4lqy+5Bs
 MU3QUmKVzyhJ8hZGiPsuHGgki8XpcwDrCFKX88aUqO8oiCSh4X6JEE1+T0mcho8MBmNylm8jM9x
 GKieLcyUbVGKUajMiKa
X-Authority-Info-Out: v=2.4 cv=ape/yCZV c=1 sm=1 tr=0 ts=6970db98
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=L1bH-B2CdzmaWMF7168A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dSo_eLMvSY9f3WIUzBVSLjfZYTmxH5Vp
X-Proofpoint-GUID: dSo_eLMvSY9f3WIUzBVSLjfZYTmxH5Vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=657 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1030 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAABFkkwBF+7oqqMYCoNyOLEht7NkAMeTiV7+Nih4bUi61AsJAcwCC+iUvV/S+GDZo2mlCEWQ51ELcoaQpdG3io4skJ3xZGAE7HVCt/KOrJ/il6ODHD/xUaitMNrRKYAP4H1fG9x6klPI7tg1KR1jqMtgzH8LDEp9NDwDjQtchc7ICjqbckZyvfLx0SCJdItQMpxI0LR3J88wjou8ddw2Cj6zQNtQrxh/uQC6W0vdt267Wr1YHjv/rvGjVbnyLIlB5AXGabpT5/zp1B9yEuEaRwyJaLXrK2Rcq3r1W63UezJgid1r9+2n2a9wA+wWedsdlatdIKY5cP1QcpySw/Tat5ULbSQ9mhTFKb7tWomd4oaoaseiJzzQn/pVcWsB4vObjOlohCOclZcWx3khJC+ojWgWCHTS6CYS802OaOhlmmqgSyFNaQ06mymmtlqwiD3Qmvqml0kuK+2+yADMaIiatXDAC0GKnuj6ewbp4Cb6wnjzJAFyVV5S2tHN2CUxc/96J+L9+Tx9CwskiGq3JYRTxhzAoyGDqO6wZSrST0hlpxoKnC2zeH15Hke+CGJuxVKvPpQhGhHvNds6ostsL87Yi2soteY5qJ+5I26IFhdwXAAvoF2s/4e2qWoxYttl3fsB3EJJQwWjI7t0FST9d+/jrFQ6yuXdy94X5OYQhC4j70IUxJ6dhkSHy1ZDQ2Mf9EX0edgQLR3dmXFPpRfuRswheKgJ1Cs
Received-SPF: pass client-ip=57.103.75.111;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index e1031b6b43..2568f24e75 100644
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
@@ -1338,6 +1342,14 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -1657,6 +1669,14 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


