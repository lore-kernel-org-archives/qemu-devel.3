Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F16D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXbf-0001sQ-J2; Thu, 29 Jan 2026 14:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXa2-0006gx-Td
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:29 -0500
Received: from ci-2002a-snip4-7.eps.apple.com ([57.103.88.138]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZy-0006Bq-6d
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:24 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 134C21802001; Thu, 29 Jan 2026 19:21:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714478; x=1772306478;
 bh=dXlBjrYQLV1qCj1RHDhCy7H3jFtP7Evi4SFhHqHKNZU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZSIuFBRS8l+jVZDKnRkzCHmdO4KKNStzFDvOsy84MvKoO/sM7WwDGW7eIYAAcitmP+eYI/lN+46bfez4PIw8ux+lrv4cBpVnZK3vTlYIAn2HTa/hmsn3NWBGkiW+W5ohDEyjTe2a3wJmV9r5ipYDwfzxwAoIs2saPzCtdUftqMH9ofOnvnqj5hsGRmf3RlNct5QziZM/8qnYWD+JsCeiXazcw12Jgt9dB0PN57yzRe4Im5yBmPfowYvWJA1hrs4Xvr7p0L/i6FVTvd9ayCiYJVtGCqTmqhNCz46Yp4V4eLtmGxqHPV5md+xLSc/ruhJpFkPltzKbifBVQnI0VEhpIw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 CE15318005D0; Thu, 29 Jan 2026 19:21:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 20/22] target/arm: whpx: instantiate GIC early
Date: Thu, 29 Jan 2026 20:20:05 +0100
Message-ID: <20260129192009.14707-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yIlvRgWDJar0VVbxeZBOzwtd7MuY-kRq
X-Authority-Info-Out: v=2.4 cv=H7jWAuYi c=1 sm=1 tr=0 ts=697bb32d
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EYz79TNVRTG0waESW9UA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yIlvRgWDJar0VVbxeZBOzwtd7MuY-kRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX/tmXgZUwK9Pt
 Vtkmoxrbe9jy+avQKKzh5Z0bTnNRGVpwV8dOV0YshOdV85KTuBons1v+LzZiKbFMThNGvezm+ka
 2uNkcQZ0bg6eHTqsPQsWctVNKijNQYKV/eH9FQDEY55gSE8nGgB7eYDgMIq9X5RHcm2MSsEQ+Eu
 ePlmJhF/ABSOK6nLG539Q/neCs2o5smYhDEIFhHoUIj0dDFCSXzCQuUfU9bieDPLHubK49c+/R8
 y2zWtg7GwCk59a5Pea2/OSdtPU2OB4anvLTnJQLGey2R5Lw9R1qDPWoOc1PnPYypxP2IGdHcX7e
 RaTk1DSiR24CCGwU6udoLBf4E8t8VhIdhxekofAHEJ02HXsT33zMSir0KFRJjc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=953
 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAAB4dXYq7ag2oA9MeJIQTfaOKeXWC9BU/BYl4yAJ2ja/uoyL0j1+HYKgBrMCQjb3asQbBI/rtVf/9A4LblPApcDVNhVSQnI9BrRMUtndFZSmK2hdnWMgTE/6GcMZtjEOBDsKXwog0bc0ePh6DkSI9+dd17oLe/N7lx1HT4RoXCqDAKyFOUKNhOpHhfKkYeLW+ym6MLyAlWbgVAfHp/Ki2FK6/eZ7QqqKyz0fELswxU8L52rn/GILpCU55+63Cd52OcRJ5gtuGRrCpmSE41j5wsV3GHl8SpJGt913x6QjoBT+jVxpeRLHCKxYTaWva9L1wWv9YJvXidK891hKHAiaOlT9Xk1vuhrFIp1SDJfUIZPdCJukkVjvsPX8njGCRr+hzQ4pVE9GFhjhsr0v2KnZoaVEOvor3geMzRntVx1JCDv/gx3aJyhgkmFZJbX58Ms+CBXPAFy0B1VPwmSRne+jV+SJ0PDLcqNnOAuCfSrc80bOKHwdQvmcRJCMYj8/i57T85bxAesil4+l6VloA7PGSOYiMAJggyyGEJJbT7I/M9kSn7WR/SzqYTuEoe3TIPgbw9jIUWWInNvfWErDGWxBd9Fx38s6vuGBwYzGLizwDr4FVcT+GAI5BZkEdBgHSXhG0g5kvNa01VftpmZq81U6qGRtsicDu9aq0rQCfYA6aRBD5UAyBOic4NQuPTLbJI/+acoM7OStYkYHUnpBw9nz2W/XHJwOhbk9eGgkoOhPQKP8H2rjgVrZ5oiBoE/Pb/Zo4Yqyxd3ThfIIEOlj7pYBosnrrKXeo2KmzwWHt6IhwmsSX6Uj75qDTPkrWqorlzeMZj23BMWegjGnhTwyFQMUcbyZBTyL/tIA4YM
Received-SPF: pass client-ip=57.103.88.138;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/whpx/whpx-all.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index c88c67a9e2..44ef42307b 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -939,6 +939,38 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(prop));
 
+    /*
+     * The only currently supported configuration for the interrupt
+     * controller is kernel-irqchip=on,gic-version=3, with the `virt`
+     * machine.
+     *
+     * Initialising the vGIC here because it needs to be done prior to
+     * WHvSetupPartition.
+     */
+
+    WHV_ARM64_IC_PARAMETERS ic_params = {
+        .EmulationMode = WHvArm64IcEmulationModeGicV3,
+        .GicV3Parameters = {
+            .GicdBaseAddress = 0x08000000,
+            .GitsTranslaterBaseAddress = 0x08080000,
+            .GicLpiIntIdBits = 0,
+            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
+            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
+        }
+    };
+    prop.Arm64IcParameters = ic_params;
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeArm64IcParameters,
+            &prop,
+            sizeof(prop));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


