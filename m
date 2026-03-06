Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16744F0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUp5-0001yY-SR; Fri, 06 Mar 2026 08:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoh-0001NP-WE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:08 -0500
Received: from p-west2-cluster2-host10-snip4-4.eps.apple.com ([57.103.68.177]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUog-0007A1-67
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:07 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 BA4FE180017B; Fri,  6 Mar 2026 13:02:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802125; x=1775394125;
 bh=CaOi167jT/nwoDpIL6fB5d8l1Tfp+3sDPSXi0RMPEFs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=HM212zNImUnT1IRNVYCWivYsAn3aqL7762mIWTcB7p5HNiu8lDOMY6TWxz7rlmb25SYp9FmL4/mAfvqgDtYzvdLyd9aZ4f/AB5vWH17htjhMY1dGMTEPnqyFXLZSS5hY1EJrQRwS/vndooFi61GuiAJ+yNbZoe183MysK/foxomd56OoHQQEIB+7efgib04Kwfm3hZGg2W3aR7vU5DuyJbrUkkfV5u9eFgMzD2H0qYdEnFXSZm6Nk2l40XdmeLqnTDYhLTu3ekUADq+otkiL33I5lV84DMjbPOqtyyvcmxo++ICigM+3G+3fzJlcSBtJlMUOkhSKm4Lvd53/NByIAg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 47F891800852; Fri,  6 Mar 2026 13:01:44 +0000 (UTC)
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
Subject: [PATCH v15 13/17] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  6 Mar 2026 14:01:03 +0100
Message-ID: <20260306130107.35359-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=69aad04a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX3sHBX2ko1qqV
 7z0U4VbaZqg5i3A0elWM3LnStqib4W0kBp5dfFZqPqkJNqGcG4hxyQDF7GcpWU8vWJmI14Ee2vi
 sfpxb3dqZkF+SzZTJLeIwL34gh6rZoZ/aaasIElrkvEwj0yZbJuT4QOiGI+6e0YHuwMgIqp0Ld8
 SoI3co4REu3i8/d1YM/PSZZXLfLqpnkvOHcCAMkKRjmQN5EuBf+CPdO88gt6c+1zgh021ytHoKQ
 sZlVm8O1EQZlTmqaPNW+2RYCueK96bgaZNxwIuhj1TeSsJKAiMUmb6UjKG9p9yc+DqQ5vUs8mLQ
 49LVYCmFwykF4H1z5EJyI8IziCPuZWdqTEDnetiCPVDSpfA+8Ea/XaCT94CAh4=
X-Proofpoint-GUID: BYJWHghux9g2NBDQq0ZRX2L3jqiaH9PT
X-Proofpoint-ORIG-GUID: BYJWHghux9g2NBDQq0ZRX2L3jqiaH9PT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=531 bulkscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABr/mov+bozTpxHlnNFnLUjx12+Y3Bb//la9yTQncygjjtcfOckOpI1HFBLCOr5vFMhHAip3i6DuzhLT09Vnr8HHElYUmbIfX/5jqzDQChL+fSoaQPWCUD50pAm65jDL9IwNTj8hkSFxwfmm9CLubeyIHPVCj1XrAgq81Xn6P2M1UwkU3qGwr39rDSWIsIBmkHpE1RRye4lN7dGLHAAhD0s467FEZe7dmLT6EAAMl0R2KZDVOwKlkTXz4HhEvPRinxVksJiWFKaBFTBZwPmD0W0qhMYR53SYH914BTF3sx4RsCZ6QM92lW+1/luR7Q53IFsuoRZN7W+9olroy5ExcE3W4Js6GbIZsz6tO4/8zSWWCs8khkI0MkQVDW6sCoVy2Wc/2SKku5brcMLqZDwNhhR4K97V1CmujTCu1ZIEjcMTz0RABJ/xOpDflbgk2ETCwQE4hjkeVd6+NQMXYbm+XBzVuY27O6FCyMaF0SuPS2bTmJUTGAySs3iL/Ep64VXl+zXND1A1T1bPSdOtZRaL6w0p8EITumldNix20Qbirv7MZgwRwzbvEfd+LNRYgtIKWDzTUDSEPJMXeCzKQBAYOuru/MBEUX6VVbA3byvW/Vxl9hBSkmuPh2x6BdfHMPE3s2t+ttz//ug7NcwMvIgXKBMficry1/sNwI+p9qlrIAmmTId7oi/1RsvuE4tzFHh/zrx6M/l4kMa5ZkjHC1UOz1eShSY1QWSnDFrLw6TkScy8tgdDCKRF/f7a+sBN1+YWzOGeAhzM0H
Received-SPF: pass client-ip=57.103.68.177;
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b50400d295..f8d5a4f596 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1669,6 +1669,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1959,6 +1960,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2366,6 +2368,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


