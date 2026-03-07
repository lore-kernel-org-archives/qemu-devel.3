Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95C4FC9EDF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncK-0006mY-Tc; Sat, 07 Mar 2026 04:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncF-0006la-2y
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:31 -0500
Received: from qs-2007h-snip4-1.eps.apple.com ([57.103.84.202]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncC-00013S-SA
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:30 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 21B47180012C; Sat,  7 Mar 2026 09:06:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874388; x=1775466388;
 bh=6UuB8iVHhPQblcJXhzbN5Wpvalp9/JAXN2NrpAvEGcI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bJLnONPbPYbfbvC57EE/RrmQHwl3B6GPG5hGzmX4VKxiH3JGMN7choE2gtoxk9JMld2ejrb7ZOWFbFCf186JXQzfyftbv/xHvyI4eh8uppkq2G6fYmTQiiHEWmt5VMfsJC68M/sPIDDmleI/aOob5Lf3SpJkdv4r0ioWYv5UXm7hVDoYAfPoSSBMmAAGG71jK2zW2Ocs0VnZCuAv/6Hj8KzGOkZGPPgYKaAB5L+xJf46bQNJsIuvn/BxVO95C1VPRsaUHPoaz14uWDbHZyZ5HH6LOIcSOCLUk3IrBO8uZ3da490u7Z7cC5/fNpVMN+YZ7AcTjYRgyW5qU5eL/Bk+/Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 15F0E180009C; Sat,  7 Mar 2026 09:06:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 09/14] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Sat,  7 Mar 2026 10:06:01 +0100
Message-ID: <20260307090606.95300-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vO8ZTWH4TCAA2xcNe8BPb6RwrEqY1e_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX5wDDnpVt9oiY
 Yr3NOy0nbu70k0r91K9YJnfdpSP7e2jfWm1QWHqLMiczlIXNY+8D25LUtAWfne6TfistkdzWSek
 FDMR/zELYxJkcZ1KLa2X/RfYYvJuVszAQweVArqBspUxwENMzY8c6lCjM08R2CzDmA4W8W9iDfb
 Hv1144voVSy4N1Y8z8bivXIWRdf2MBhyzovwv+pIzOmubKiRJKMGzm19qhc9i5Qh3FFlijkZNCF
 lgE0xI5EDIyUxfQYEqCldFlxX9X0vntLLZpiB3U0/3DwBRpm/pNHfdTa9VEs556DNX/8TqbE5CP
 b/UTAlOceFhsyPWAaCPO0wcSripUK9dmTOHTBdg8pxk5ioPR5rY4+11aNOZUS0=
X-Authority-Info-Out: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69abea92
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vO8ZTWH4TCAA2xcNe8BPb6RwrEqY1e_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=526 suspectscore=0 clxscore=1030
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAABzghG9VpaQ2CzH8KwqiuUaW3gVIJX23Vev9wXaSPS7p75AAMMt6vDG3lfFZDk9tnH3DhBoYcE4D3ADH6pdMOGxDD+eTcyN3B8c8dTbfhui9vZTDElRKk80FnoYo07UErPbl5D6Im2bLOeXcycMOOimfSmeopyjHbV7OCbO/Eyr6iBkbFIR5PKfLFFEV337R9Ko/n1EjCo+ELoEwIvnkUM9Q5O/HLnH+20Q1lKim2cX6R8STe7DkmMgrYUwn4Reqf/ps/ya01ZgnoIfaeuXLRCogsm3vo5hBDxkmaJ3KZQE1sis7t37ukPMz2JuxMUH3WXw0rV1J+kn8vr7mhNR10OHuINc9+Q6T8BG5CkkE6c69NreAgu7gUXFP7IlwNMHZI/XHx6K8V8WEGbYGGy76l5KJQKgLOMVACGGlkZIB4+HNehxPYw59a6bZJnckceUoAjhuIVSYK1UOK4OiU1dGzRjL2q6tBG10IajuG8EY8ub2bEzgYn/UYmpGZAid9mUhy3+Yrz13c71dsauUJtqsAr4wA3Lctq8kDCza3DR7499c9i2i7sBT6mS2SDzzNf+gt6nOKXLUlAauUQ/tM46/zmT/Ml1+YwWsdjCfUuHzskGuZSzERjj93zXai9yT8NhYbDE8IvLMtJDxEu++vOfFYUMlVdh/SlYGnr5Z/Us2E99QhNfq+EM/jPbcX34v/1MJxrY355lL3YR9Wnb9RJWEKCZQpGRqDo+3eKR4qwNahQIZnG6XeRn88q3lV1
Received-SPF: pass client-ip=57.103.84.202;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 30272107a3..53ca84c35d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1681,6 +1681,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1971,6 +1972,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2378,6 +2380,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


