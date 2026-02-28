Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7F4FD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUe-0002Wh-0H; Sat, 28 Feb 2026 17:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUb-0002VX-Pe
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:57 -0500
Received: from qs-2004k-snip4-4.eps.apple.com ([57.103.84.107]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUa-0005oN-Cu
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:57 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 D302918003A9; Sat, 28 Feb 2026 22:08:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316535; x=1774908535;
 bh=1uKhzDlSbas1IjPvaDDAfrSs4GAL5M/GoOUNIoCOEjg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KhQoUASWzyCoJaQaEX4ucxNwsrDPgZZIMOaHV2/Zxtvkp5K4o0Ez1QMLswccPG3HXg2J7rqrVilw7OAKCOz9cfijPA8PSEeHqxj88ENKSDkMPhSLbCQ0g5JBB9O/DKjI0ed/gehikjtWdRBO9+Mnq/BD/91HSu3F6iE3F3AOnODzRXavtt3Osu4SObRPVaht5U414KqlCMDOS8CeL/JGYSS2OtOZj0WWAmzG6gYa1AC0ZEDU12BEXFZ3ZL3wTgVXJ0qD6DXo/hfH7NJP4bsxt/Qz0b/mUUwA3yWOyfIDIKIeXMXQdvp6nHrfNoUw8Xu11pjFKUa61TH+WGemSNkVng==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 4A1B218003A3; Sat, 28 Feb 2026 22:08:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 09/12] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Sat, 28 Feb 2026 23:08:34 +0100
Message-ID: <20260228220837.35275-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfXw+EI7f+p9QTU
 FZrkGUEyTjrmGuicgYFP+DIfVXNX5XxivQCkTOLFb1Nx5SHLylyQtGOZt4cPJut/sO/BG+WrbAZ
 x/LDV1IIUM42v44uU/cCp6OORW/RGPFtVBh3DAprKHP+ZItq12QlDlOJA4IxTg/IT3aYO7i9QZv
 NLXczhy+EjuADP+wGrGCX/HccIl6SYhYJfBBngzhfc3MVGLbfEzZ5oyBxsqmN3mwDJ3TB1XqIRv
 cltJthlKRLvnFX8LRCiDe3CbN/HhgH7T1YnmxUtXoRgAfpwwctiEal8GxKrL+Vp9NP3jWM2lGUU
 XpHI7m/7+XncSHJfuDBA7rBkfDWw2HvvAAb3wcLAvypGIQv7EGyIcwffnoSRIA=
X-Authority-Info-Out: v=2.4 cv=bu1BxUai c=1 sm=1 tr=0 ts=69a36777
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=vbFX7M0ab_H1AmF9bzsA:9
X-Proofpoint-GUID: Jl9xv1oSduLh_sYY-VklKA88RAQxf1IL
X-Proofpoint-ORIG-GUID: Jl9xv1oSduLh_sYY-VklKA88RAQxf1IL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=507 spamscore=0
 malwarescore=0 clxscore=1030 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABRQe/FeNm1cm0XN5jHI3FhFCFJ+pUNFBwvAJps+j17gkojDUB50zBAgcrY/ZGM9wAYJlY4fFljXbZOjchr0MuzbtG3ZR4Fzhz+WN2wncXLgABLWzbiuzDeog7vPt3qQFb6LlbDaQus83KMUtTUxOHVyCem7z6IvDAzvL8T/ewdggp11wWc4HoZgyKpefkaMCl+QNuwADv3qazonw3T2n1bY1hR99VlbP91EvmzJ/biO035j4H0G/uRMBvNuTaXQ/w94GOfJRKKZtKKXHDsUb7Xjam8kDyOIvtghxqWF6MPoRXdr+AHbrS+T+bzNHJkaQHhpJepZM3Z5cnqK4PTAwtOh216NpCjnQC22H1uwRNDwpnBBCTqsyYrzg+86MdkLCIVXSWkI/L1h3NOvJ99I7ZOfDDob5LaEJy9PuOMDEMB9L1QDPDHLxxSpnL/qYqivIsjq15p5y/XSLb8zyXTK6+TwF77VIgXuyXPKvCBdUY1yQ6vCwf+9vkQu1mf2HW2BDASbn6iLI0wt+RP13VmA8lElwI8kSDTK4af6HD44PiNSAPsii+Df+a759QB6v+aLKBMROvFVB3dth9A9pKfQ9Fbq1kOjplOg8ntob1BezDmPer1anZzGAtG+vxa3uyT4gMPRXHEeqkL/pnRa7LG4gTFd46AIUJK2/Zf+ahKosKutQs0mRRGWNR29pePsDB3KNreHS+AJp8YoE2VkMrxQ==
Received-SPF: pass client-ip=57.103.84.107;
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0f45e22221..0aae421ba6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1365,6 +1365,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1655,6 +1656,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2062,6 +2064,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


