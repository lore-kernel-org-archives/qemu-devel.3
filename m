Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77812FC9EDA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncQ-0006oO-CU; Sat, 07 Mar 2026 04:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncN-0006nE-9v
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:39 -0500
Received: from qs-2007c-snip4-1.eps.apple.com ([57.103.84.152]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncG-00015J-9E
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:33 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 36071180009C; Sat,  7 Mar 2026 09:06:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874390; x=1775466390;
 bh=syC9+/wPtHmD5MD5ZZLKFPDmC7DIMxth9hphPRcSA70=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Js7XWRd/3Ef9JnnGOOi/IsUbJuadXo2Tu3BKFOFT/vyjgohAVKO1WU1g6ckAlDVkTGmjaMRsB60xLm5TqDDxRxgaOG/lvSP+UyHnzg6sJ8qkDRGu1Aj8OCW65Zzqc28l/NUeL6ZEgItWTRp2a/P94QJytyH0TOo59B5UCHzRPO+y22bXqNKhdiUSnEvOk6FjT4oztCmWBR6VYoAg6hkKONhWFq2gtsXGjYWN3ZOTwZPrKweIY1VallTwrPRLDMBF7lqDU0Zhwk421CU0Gh/IH4YlCzOXOW52HgnIBH1AvEhZ2aNLKBQRFaK0x8y0RfAF9COY3InEfLAo037Y1Fo7jQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 43A9A180013C; Sat,  7 Mar 2026 09:06:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 11/14] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Date: Sat,  7 Mar 2026 10:06:03 +0100
Message-ID: <20260307090606.95300-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AtjjHe9P c=1 sm=1 tr=0 ts=69abea95
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=L1bH-B2CdzmaWMF7168A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX5CqF5A3gqAjh
 wh+5VZYhrMVINLcfr9R9Xxk7VApI7dBkrbkfFdPiQ/IRl5nxC+JnLDhQjLHSxWEQEAbi53z7n21
 1ksA99NA4Vut7CsHw0dKhEKaYV5BfVmmKU2wJYhVjdANunMQ4DbOumLFBxi7jk8LsKawpE/1/31
 b2JBwfkC/1JOd5+0l71UI1/tiYfHyo3yqGa/eFpJx4iBdelg+HWFDySEWhkKnVd9Auu3FLuyKVy
 uNXlq+FaxqseiDRwB3b377HSHh/kyRf7JQhPAzswJF2oXjGywJCZE6exp9MjLEjp6L1BlqMJU7/
 WqfvUMP8XrWsXx41MN9xL0ts75OgcAcB4PS7vg2HzzuJHv02A4q8jL6frX+2FY=
X-Proofpoint-GUID: Eeie2X6u7C5b6AsogarDAlgi8KRMxjAG
X-Proofpoint-ORIG-GUID: Eeie2X6u7C5b6AsogarDAlgi8KRMxjAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=643
 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0
 clxscore=1030 phishscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAABSwtHa4cTGG5zi29xD743kLpvvaF+g0YzmNMRiHlitO5ZyKiaUY5pzBtnBPO83tR9gUOaZ5hTe48ecZBe8l/4dbk5s+qiw2Flt4GMxqT8i37xhS4t3l1vrUhyDWCXDlrU7vYcGRw0CH1wvvRrdp1T2zkFNC47UN2FcEy5+YRBX7IkkFVOBF1IXOQ2z/Ey0dU3t5UIBNDhf3LtXyg9/weSjK+N6lYQA2fB52DNfFyO0QhC7DZaAszu9UmNDMDz0oVRhNmTO5vP8P9zPvRNtRohx+7VUR/U28XBuc6Htu/yZ6g9mooKtn2oDVSnwmc9N8U+/uf7Qgg40xbRpIrlZt14xbSnWG/HA++JUnyWbbVtV9lHO69TEOx09BjhlNRriKC27UaH37bPiBLRlWnpkxAK/KhdNSg9N0fb49d2V71K8AbUK50/Hee9jzQ5dXncq9vXGc0gP7jpz2N1a4vHCq+ufLy+kylvMgGelOvZ27YNmj5hg0WajPl6tFCHzkldTvpFL22JfheQcwGJkailw1k+REIPApFbtYGCwKhAY1xbWdvAD+/fQFAmelWrbOABIK3FceMlkH4o0VJU3UuImqOdUh16K7nRhZaHWB5AUjrYNIprnPpqjN2WgrTc+jMegf8uVh8QzmVxNf5i+HPi9pRIFBUIkUFni6v5b7xcbtYcotBtxLV1RcBZSxSApCFtt3lTdfzhUPWgK7jQSleVd9f58RmdpT3ZDh8T8r6S7hU7sYbCT5OFHhbI7eBeeFldbIaj6MvUjZpIsimcyLiuSoEQor4=
Received-SPF: pass client-ip=57.103.84.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
index 949c4a3431..6666d77e18 100644
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


