Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C204DD3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFKJ-0004mS-FB; Wed, 14 Jan 2026 23:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKH-0004lJ-FI
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:17 -0500
Received: from p-west3-cluster2-host8-snip4-9.eps.apple.com ([57.103.74.42]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKF-00066d-FV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:17 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 51F7918007CE; Thu, 15 Jan 2026 04:51:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hhK0gjOPgXHYue8VG35FfS2CFXhmIydJ0V3P4lqNths=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ahxa65RdZOmysmqSxpWgKYINyqwsPE0PQKz/bQ9t94MZxgbp8DShakUOf5OzMUXDzzwkCgZ8ttr5DCgzk9nEN6ecuyuOHXApnkXATdB+WVdnTcBuTLSQ05nSGRrvfevdac7PmS+EBMQE1AvrLDr2o6lCBqR/7FoGW7aQ2sLtz3ahLSqv99Y9fEXdClf+sAcQz8bzCLMF1/oSY2ZIM69GeoO2HbF/CHgGoq8Yhl2LzwAObXxilFMBlYL2cTFIhtgUIVtu5vk7G6dSAfNBLrib7hcZj494TAH1WX5CLPhqKCMwwFV1zaQMy71yPMXQ11CDrnmqT6nfau9eplgExuLSIw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 CE7B2180012E; Thu, 15 Jan 2026 04:51:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 09/10] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Thu, 15 Jan 2026 05:50:41 +0100
Message-ID: <20260115045042.70086-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7pPt715nX-P4KLoLalcny6DylXS32EK9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfXxr+rUl45WpVD
 gY68V1IA8QFqacKyQJs9BVBqMNVG9sfsDZPf1Ca7tjcRUOhGluSjpTOTPXlcgCqNs5PSrMyiz6S
 Rh1Rr0/5/nrtVyzZx1xatp+dYOkM/G7Lv9EawcJJQ6ZwyHNfds6iHaiZt5vwXzy7P3f7Q8eoWqA
 /zbt0yBb9lFMiPK5vxFVT/aLYFuwv4ZhJJJ0OwisM9k8mZSk8hvxxLnfeuq/7ZyHdy7P2OvTXYy
 1hHi5n/d/DgVvBIfVZvLHuU7qpWjgDp2BFyoFRXircprJ+tjG0eu5zuw0eN3wEIk4Ul+8bo/Upz
 a8EJPUKae4Qsk2ApzXR
X-Proofpoint-GUID: 7pPt715nX-P4KLoLalcny6DylXS32EK9
X-Authority-Info: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69687241
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vbFX7M0ab_H1AmF9bzsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1030
 spamscore=0 phishscore=0
 mlxlogscore=482 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABB9SHQ3+QDLfyC2wgV5sGHmoW8EMhfFSNUP1PsJQwztrlqXRPIbA0R7BlYI0Rf71ghtJT0Jj1Z/a+1MVsLq4QWv6m2d8Q6pevZn8ni+J7qRUYyVNKVBxSMEjdTAkK2mAc6hsoTsA+Iokl4jqRFBbuU9fphf0LVmcbGyGgahjx9MlJGD9ymR+wVHVfwIS6XEmNlq34pudweZTzMqifiFm+ui3+QkWZc55BnO4AYy1nVTQKMyan/uZNlyDDn3q9gaVpeGFxYJ8Zw3GmzVl0thaAxGGbSFqX4Bvdz8w8YxgCC391wSChFApNcYJdhvOnS5nHIpUImI+m19P+fb4/KKa/c1SAjQ1Lg8KwU/V86cSp8v7MuW7xobthqy5mPicnWILwrgQLDzCLPifNIFV2TWRJkjIugT+E9wAaiETTKbIVWdCgC9qN2LKbGpKeh2gRvkkPGCxfP0MmmX3tHtLRvdEmCTI2L2HcYoVgCp4YtrGVR97cMDnkGdfEaZUkRBkkYh4BQ57WYeWO5wdSHGWbI3wYWhUEy6xmHx7BOreET/UNrMGn1yGYSyT+DehBJSbHMgO9IH7MarG3eBePIYxrW9oKy7jX/+bUh5oawGF/93iMhWhORM8ghlPDo7tbG2zFL+QEIsYWFMC/mlTur47Opxz26zbnYmj09NaRhopqbGsSw1rFiZdlxy4WUi9a/Fvabgz+5RMxVA==
Received-SPF: pass client-ip=57.103.74.42;
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f9e9f7cce0..9a70cbed28 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1341,6 +1341,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1668,6 +1669,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2075,6 +2077,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


