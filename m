Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A0BF0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQcA-0000J5-1D; Fri, 06 Mar 2026 03:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbM-0007NS-OQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:06 -0500
Received: from p-west2-cluster4-host10-snip4-8.eps.apple.com ([57.103.69.189]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbJ-0002Xh-4H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:04 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 6AB3118003EB; Fri,  6 Mar 2026 08:31:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785918; x=1775377918;
 bh=T09YaB2jPYeKCsoJalctReTDeuCKV9icg1YoMmiUMB4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Cjy1L4G4qevXyDBJfihBnPEXxy6AvUxYISTr/dr+qVMGi2xuAabKk+W+aNroYRoVFdHcJivSRIOXDNcJnEMvIZsg674rSGL+yDZ90tJhwRgAICBqhG1lkDcTdTxUDqX82kZsE4a15yxjVkQoq50IOFkicU+6PnRryIZ6sCCOjbl2KXc6Cz7lcIrN7zBla1O0cDKamYE30fFH6QTSNWbxVEPPxlTiqW6b8zQzOS1cAJ+Vb2LZNZZTzT6p+9TPekzShoNmEDzjdUxP54hxk/Le59OXN8IoZaJOT26UhM8OKU6hIZqpGrn9M3wOrdjlvTDnHWrSxkBLMCgqv6Xdbh/JQw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 8329718001B2; Fri,  6 Mar 2026 08:31:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 14/19] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  6 Mar 2026 09:31:08 +0100
Message-ID: <20260306083113.74177-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wToGWqueeIAMdIF4Cz9tAVqIDtpy4Ycb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX6WM3dCx7OeA7
 5oNDIaPhKXF0cEpMa7GzKmhDDmbAJxkdSaH0jYYCXvjikKW++5sNBgDktEi0VJiOCXbB+fR7QqS
 t087MNX8KeAe3HM4RbEz/bpgzh6+t3x0mVWcPYmENjJ/+RHZxV7o4V6hFWBwIw+vRwgr1yv1YX5
 tzkaB4+f82OOj1QrOHRWoUFH34VYovS9mo1mEEwYm2wbzctZnYTzP5RbC5MXGvjGBGww4UVx626
 +k0oIsLt52Qpa9JY4XRLFsd+DvwE5fCk5C1cvlPpZITSWaD4Qj4J4jC7GJ2A7ghQJ/wHIG127Xw
 9+8wr+Kvf0yykcgssXvkF7HGH5sOK4xnFdrBsDJvhIKQJxEcB8PgCVkGch1d0c=
X-Authority-Info-Out: v=2.4 cv=KqNAGGWN c=1 sm=1 tr=0 ts=69aa90fc
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wToGWqueeIAMdIF4Cz9tAVqIDtpy4Ycb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=531 clxscore=1030 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAABYXCE1Mhj+jEgoR+9NYMNuRjPHaNHCrxfKEB5lfRPwgi+YHAK1L2WqnqDSP2tNK36RmwLvD08CoA0/49q4aQ10q05vcpFouUtscNEij9xMqU3ouZZwHJCGJdbke9jgts1dRFsPyXm+2TeAwH3KpRGW8aCZlH71rTuBUlWIDJKI27BUqAfvB9g8YiRldpue2CXSimmsXG2aHMxYCffiHKFvu6YOHXtafA2i09y+6EC3QRcyb0kT6klIuaf7oskXPbBfIg0D0VbOBO0QnRXkZryPNLKBKIwj7im/aivHUIcE8RY05h4f3GdFvpsMmsk3daiz8W/ZejJCprhuG3ixbkQeKtizV1kARZ3b4nf6V8Mu9+httXbzlXa39Tp7x8N8pQjuma5AqFQIbLTeV5SjMsACJp6MlPEzjHvNe75/RNgQgusBiJ4SmY6lJiek9ERiqJRvax0ZsMGloiE4RN2b65hDDdUixSp0L4enj7Arux3cOpmaChm5HfNRsGzFJ/aYJDKNC+SXabBsdQ0BWsvHt8+i6zsOH4uZ/YbjohM3rqnrsRj4CWswvPVaQGfa6qoLloEAlL7X4gbFKWi73+ewyXbMS4l3rGYg5xf+ogsG/z789fBI+j9XMPXVcd4196TC8ZU/PRo4RJOtb7Pb/TS4IH2hNoDurtCH1EvNCtlrCRdtkI5IOsTmxkonwS1QZM8NHXnowqTpZf3Dvq+0fVTstEiz/ZvEm/lPY8kBxMzVqTXW9NAf9xTCd/jVqmNi6NT7MwGH9+h+3WI35I=
Received-SPF: pass client-ip=57.103.69.189;
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 212efab731..0c96119ab9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1647,6 +1647,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1937,6 +1938,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2344,6 +2346,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


