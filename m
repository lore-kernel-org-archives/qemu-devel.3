Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A85FEF5878
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGc-0005NQ-T3; Sun, 15 Feb 2026 06:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGW-0005JU-7j
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:16 -0500
Received: from p-west2-cluster1-host7-snip4-8.eps.apple.com ([57.103.68.91]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGU-000806-9C
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:15 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 252551800145; Sun, 15 Feb 2026 11:26:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154771; x=1773746771;
 bh=1uKhzDlSbas1IjPvaDDAfrSs4GAL5M/GoOUNIoCOEjg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GBm1w5atMxZSz54kaRyrF8OfE7yQCR2w1qiYQWXzudw7xd9NvPq5ogJmwxJlZ4GLJhEfJQKhgmSTT8YD6SQ1khqGDzJgmv3arbt6UU66rZTzPTC0bs3tOonmxtxFyISmWITrve0xP5TiOhD7hD18XGMlVm3elUefSNeHAnozXPLlBtxK5TtDF0deBFmTCl8RxSbaqDsUVhXW45tleF43nQApUl2QT5hbDl0+BIh1Z2yDjoRCVaI3viUH9kFWRDb9zgE0RbbGlwmVs9A4BRivkrBj2ud1yPN5/roZVrAGqwLqeAjIGa9RPjo+A+VzuhC8BVbMACNs1PBW3wFIKBE4cg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 033111800164; Sun, 15 Feb 2026 11:26:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 10/14] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Sun, 15 Feb 2026 12:25:39 +0100
Message-ID: <20260215112543.4817-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EyQ0CsnqrdKamFTy-rX-3KwUl1AEXbls
X-Proofpoint-ORIG-GUID: EyQ0CsnqrdKamFTy-rX-3KwUl1AEXbls
X-Authority-Info-Out: v=2.4 cv=WIByn3sR c=1 sm=1 tr=0 ts=6991ad53
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=vbFX7M0ab_H1AmF9bzsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfXw8bNI+lQCZN3
 bexfUNVqASB9Eq1g0QPwWvmUyxBWXUwiY6ue5IAzJP6+D3TldqoXHNYulYO5bICAzlEsDVe3499
 gykcF3RAJ3rOnDPsQgbsawPHXJy+lQBG9BITpMEWCpxNqyYVDkYA/b4V7vu30+5sMijihKHnrcM
 w75dBqvzAn09Idy6mt5bud2U5eExAHVMoKhgZY0lkD7fmQd/1RhbLlQjDlpPhpMj4VYIANXe0XR
 z0Gea2Pl61n7UeGf+/PNoLAH/ucsIwlY5SBjq8p95IqxMa1F8oeNEkZ/OIgY78uOOnW0qrwhN4y
 +fqgdBv8IB1kVnpDgu795GiS2IxbOOjwA59LodJGKJjO5nlP0+cBOcRDZ3ppHo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1030
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=480 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAAB6EzD68mzq3Iaatxaf+gZD2DaerlhCbewA9frVPCvfCfbQa2fVG+03UP4QHTy15Rd4OYnIDD/Wh/rSzFU6eP5dXi/s86QFE8KY09bMz3M1aPnhp9gUk1QOudaOvrA2FLNcSOggr1gapGeEEtiU65Do2NOOWudqKPwoIbGnghnnKMzvmOW0Q7UUk4k/rWUsk75BcGOh6qhgTzZVlAjT4A3bRhvgn8en5frhad4r6PmrdgIBPKGh9D0pcco4UqzwMzVCZbLjngm61uRQGmlMBkq53alGqPh/7/IIv5zh32tDKwm9DHfqAQy7XiafycguaQBKWW5IRdcg7BGIQBfIRKuIbUWZF+j7YBu6mdBx7YvH1CLOM0QDUbQVKVAkTZCPU9J38qsvT4f5Cnyyvm+F7TaZuJFg0kVd3+KNZAHQO0XpjwgGx/sRz3vLv34AyXV5qOVWA560rVkCamGkU3qTKeZ5Ik4c31f1QApXegQFmgm5NePcO8uxEJ7zMRJJJeWNtpAN0EKejuO8YZfGMEFhsOnjlTakFywIe+/xGLL3tw3EN/11PPFDJf8xtdWKp75T/udas9/jv0rDxMW+CqdaUoAz55AycYCxNN+DodWQSSTqIFZ0pANNnNJrBtuWWaQ5EbIJNbelXAU95QSBGZZx/pASntq5DSvLIQYNL2SUDlFEJvxMrBHWH95G/lRSxRNNfR7WiWRuW8yPB0=
Received-SPF: pass client-ip=57.103.68.91;
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


