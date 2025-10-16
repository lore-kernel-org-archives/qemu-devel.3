Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02E8CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SyP-0001yu-NF; Thu, 16 Oct 2025 14:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxz-0001jw-Np
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:50 -0400
Received: from p-east3-cluster3-host7-snip4-10.eps.apple.com ([57.103.86.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxn-000281-21
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:47 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 7FD381800387; Thu, 16 Oct 2025 18:44:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=yaziaz//KfkV1qB+UvLaS9dqmb7Qx8vSQ/YVwpl0DrQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M2O3zpnqRU0A/o/NiHxtzv0CWEyQ4KL7t/bUhKbtvHa5fTlodppZ8Qsx5so5fKPs0nxcFZXdRFFXwGBLaMRmYWiqVmGs7nyVC7Ele3VjR5afuPtFLaMZ9UYFPoE1+7GAgEAbOmro0PZulJbJGQQ8Fg9FwWWymad41arbMkxN1+OoIJ1d8PdT/wkIc6n8jfWnts2ocXEQekmgWAbxtAi5rm9GOEmqhwXBxOoJTdvGv0N2kJu5VObmwPkO7eOhVSV1KXHaQx9ZatFpQE6rdYK90awlmcxCcmcFEpG74gMsb3Z2QMrvztGb/EnhHXxiaMcglmdQgtOha+1hxnA8/2ynjg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 6B7CB180016B; Thu, 16 Oct 2025 18:44:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 20/24] target/arm: whpx: instantiate GIC early
Date: Thu, 16 Oct 2025 20:44:09 +0200
Message-ID: <20251016184413.69870-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b-rAZPVuogUQxiVu2GuKxg4gM29ya_q5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzNyBTYWx0ZWRfX0D4YqSgiDzpj
 koxg8enKMxdoxRSj4T91xCO4PneMBks1+t7qfR2T05u3E86IJF53aIXC66SSUOJKGZYpuiWLoMG
 Cnzd8MCCuaVNuHnC6pYsnz+7Umfye7ZIK4E/8i9R26Sc+x+OQCSRnrMEbbFRulVPK41dR+MrT96
 52hVyaU6Hwxox4T3j6u2L8WLp+FeL/eWZAipMj+zeBpano1THvXlzHUxH3Id+1tZpr/GxaV8+Uo
 anoTm91Vmnr3QIZeIprcBXUDAe5zrLICgNhhyAMuJcFwgdlLTV2j3Yw/Z2htOFz9KE2rCtm6k=
X-Proofpoint-ORIG-GUID: b-rAZPVuogUQxiVu2GuKxg4gM29ya_q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxlogscore=608 phishscore=0
 clxscore=1030 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160137
X-JNJ: AAAAAAABvPxEW/d3I27A5YYqXEz8hh3xs5XcxZ9RDPp6hPUX8yPGUynRoH8KeQ2dfXpyY2LP3JHpTgYQwe+cOpauv4CHNaexBaaNyRsl/DiQlsvpm/s6OMIosk9Ja6SGZo28wjRXlINlcK6WbfYf4SR7R7rWoAuTE1TSIu+PuBa+4O3LI+TvL/shf7fKQ4Kg1nMuQ0PxhHO92A4SsBCEdt6TvTkF4yXbUY7PlMCExKtzq6uh855YNvaYlT92h7RaXirGj7uPZKvKWpF9207SDrJTz2KyAVZtu9L3Gsp+JDM0P3EMCrZD/4pEHTCq7qYy3zr974tXOhhnaienteWvVU/ob+Es3Nl/PeibQInzN9RRSlui5K5jSrZJySFkdSH8MMl72aIMSY0v20c/orf2xr08YvvM2pHe7Lbg4XGLqt1yuWj8HJEqg5u6PQxCwk77Xv313ayYMCOT0nzAoIbJ0tfVYaQN85yh2sqPqphmq5JR/nVX5kT7SpB2xFHzgSrOy+cvUyhf5ZGpnpsPm4NE4qiEAxyDRTwpqDHaG9OJiH5h7J9L2TzsisklX9IRv3URnabeMMUGr2ljnkgMEbJKWm54XZXRlfl6x9sANnYibp4/uzc0Y8hNoxab+WV7fLKrVwO5jpr8GSf3v3TJaOt7VhMICGOzSexnPQCHbWa9fbPm1vLBR9Fnj0Qg/HyaG4+O3K8BC7iNTZIx3gm4
Received-SPF: pass client-ip=57.103.86.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8f0a54f080..4d58e5e939 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -973,6 +973,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
 
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
+            sizeof(WHV_PARTITION_PROPERTY));
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


