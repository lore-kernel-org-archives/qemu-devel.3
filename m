Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B93CFCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqH-0004IS-C0; Fri, 06 Mar 2026 11:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqD-0004Gw-J5
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:53 -0500
Received: from p-west3-cluster3-host9-snip4-10.eps.apple.com ([57.103.72.241]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqB-0007BJ-B3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:53 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 DC91A18007BF; Fri,  6 Mar 2026 16:15:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813750; x=1775405750;
 bh=XPN2ek9vzGXI2utFTvmBBZ3jL3DtXEEa5/J5j669tcA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=dKn0r181O0qB3pXW21bj1UfDAZG6KJw0oc41YwN/mznXJ4mBXZvxjVptTCRYDm3enLB3kIJZm7MpKxvZtpB8bMePF0TsyRWUYIEAv9VkwrAmKt1rmrz+6FweQsiR1FhQMoh8SSi1OK3AFc5GlGCK4chLTc0DJsCYUsPV1ZWx/XkBlQ3jz3v9y/2pH8y0A5O576YNOrdJK5Q1H3D3PceWn5SpohDTLbohpQO1wB7AvSK/BCWmOmJ1kbB8q2l7qihLq89l6Y3f4u6eqsc6HjkdnR34Vxu0JiRhi8zmMaXBVVLuG8xkCIEtnsgoJ+4N31ht9rak13yaPfJyzQ4O55Zb+g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 27B7718007A5; Fri,  6 Mar 2026 16:15:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 13/17] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  6 Mar 2026 17:15:05 +0100
Message-ID: <20260306161509.79712-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: moVBsHTQ_TTLJcBvWeKdjOWrB4Dm7pZz
X-Authority-Info-Out: v=2.4 cv=G70R0tk5 c=1 sm=1 tr=0 ts=69aafdb6
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=vbFX7M0ab_H1AmF9bzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: moVBsHTQ_TTLJcBvWeKdjOWrB4Dm7pZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfXyrGKOoJcs8NJ
 hz+UqjNNXhD/A8twf27W6JpPVIKr8ib30g2id+a6pbsI+u/he3zhGAVBhRre91etisrbCHXCnzc
 NwKmiN77T5S6iD/Xl/S/Zt55nkRfRKTtqkMAPL0iMfbSROxMYTH90wxPtWdK0XJGqa7izTzBo97
 3LxH58ck6CwsJVoVL0Z8wwsGMBbunIfDIB5EevuGXoRBVmMnU2Nb/tjXQt3QSK/T8w4g1vNi2Qk
 Lc2bsFcAz1SHBj+LjYoJsVaTl94gZKAC8tZzohipifkUXbJ3BjU04Ql1qvON5sguHONrwmHUX/B
 d6fWgXEXvzm4zjUoCdg2aQnFmQzkBPUlgXsVJ5u5Hi8bKWznxhTQemN0Ke0H0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=531 clxscore=1030 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABWjXv4Pt+xvF/071PrRQ+POfaoQCjRbBVCCyO296PNEfjSoD0smykXHBW+vzYRbC1PttvMZOh8Gz009uw3l04qB0oAGtKHphZdzybbqXsbw0PKUiG7cs7xRaE7Lf3ao0AEwAjDDgcbEIW4jTexzohNexIBxq9JQd2bhi+Kh6xcoYdU3XuAHXm+AjBVS9rj7JMo7uQe++cHdGgjPe5uUN7FQpkrjN84U5JMjMe1Izbeih+ZVMaaowcQj4os3rUq2KuIqN429gGkYuzYzbfOiS+6xBO2LmhICMBDGJXAkpXaJGnnoFU7zcp+C4RYbWmSB15nQ4DOBkMqf0veEbgouEqGXMcUblRXWrIJ+kFJLQhQixDtkIgXtkxnQFZ9dLoMh25Fbn4zv9Co0H50Tryvy8qxPq7KzEPlHLngTOmrVw/+QUtAwoyqJvboxn916XQzikIqNPj3vJLE/zFmxgf2DoSEvxZWNzKK9D3bmdl+DTmpjIPWBbknTRA3aUeRDYJpj794JBRkiXSp0QiLHC4VZ30PuZnaxKAhZKIST7LZULwTC9KoxjQ4JsJ6NEVjNBWbittMV0EDG76J+j5EJr5Btg+mfrQfiAeZzCAFNlZS/LWKD3GtNHbnssKlm10RCmjTc2xu1RO8EYIbc9S7w68uUIDTPEMmyuvEdQhidf98qQKUGHqG3XlrC5eS4ngtwkbUJ6QpHuo5oRqJxCUFErWg+nIHX2OZwncEdQpNSubYqQVCW5sMJ6BKmnOnnSkihnlwWnsiIp6gOel
Received-SPF: pass client-ip=57.103.72.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 2daa2ab132..9c986178c4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1678,6 +1678,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1968,6 +1969,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2375,6 +2377,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


