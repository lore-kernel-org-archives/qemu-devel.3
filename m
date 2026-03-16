Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF24F506D2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27ff-0000yH-Q4; Mon, 16 Mar 2026 09:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fe-0000xD-0C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:46 -0400
Received: from p-west1-cluster5-host10-snip4-10.eps.apple.com ([57.103.66.211]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fc-0003ed-Cr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 148DE1805045; Mon, 16 Mar 2026 13:07:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666463; x=1776258463;
 bh=330qKxMx+lSlg/KnK5hW+35xj4X6Z0+hRWexKmPVO7E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=WFGeTJ8DPdRvHbhIlwv4bxV5iJQDZvhoaYOsUg6Skwzc7OG9c3FmVuh19TJyVCTgQ0tV2u4ymgn/Calxl1COQU6qyXk77+9R2c8P8GzOv/6u+z9VUBSyJE8qFikmWCN8EwEu8exBiHL1YpKpR6Q/44O0JuRYVRGcJoTvRgpe7y2RDVus4f9fliho+plzu4BSo675SQq2Mfq+RJIPOf0cnh7HLlVplbIdLwRYW8Khr3pBlOqIH0QIak3iNEszJjfdk4mCdkn37YbeRh2cu8xv5hYg8jRrUVCWqcYei+xqd9KDWiwV4J+R0s1Zni/wm9i7EvRrY/iOPhe7wqno/QsfbQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 645FD1805067; Mon, 16 Mar 2026 13:07:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v20 09/15] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Mon, 16 Mar 2026 14:06:36 +0100
Message-ID: <20260316130642.13246-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8Cph-TyjJV4Ko7mAK9_KQWbRTqSfgAp3
X-Authority-Info-Out: v=2.4 cv=dL6rWeZb c=1 sm=1 tr=0 ts=69b8009c
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8Cph-TyjJV4Ko7mAK9_KQWbRTqSfgAp3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX6PzJjBbjsDHl
 4xvrOaqrudKAYW5Lk60XkAEpbgnsu13ZVq1uQXtyPTOLQv8DAxv3eZZrWkNBRkii5TZ3vFh7WQF
 EHutVb8xRkGEnamTgTLWXOjqOV6UTDk53l92ViFt6KWzqrk05WQGafMPkJw4l63/mToB2ah4PsO
 OXymC7kmaMV9/iTxB0cx8NAe/NewZP+LGbCellHBrTZSmkLxWvawU3+X+lYIfJdQRjqrgfU0tL/
 t479pd/vHCoXmatKXNYEh9ddj390ZgtEoqgHOdP5d5Q+aO1Qtd43P4L6eC3sJYUj6ZSgDZr9Vuj
 QPkbbedPAhZQ1Rv2b9XCO66RHLX3TXcX5wzb7Of450GffZPCtJoGGoKed2Sr90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=609 suspectscore=0 spamscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160097
Received-SPF: pass client-ip=57.103.66.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
index c457e67e63..c5f7682d7b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1696,6 +1696,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1986,6 +1987,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2393,6 +2395,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


