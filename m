Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38627D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXbq-0002Lo-JQ; Thu, 29 Jan 2026 14:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXa6-0006qA-G8
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:31 -0500
Received: from ci-2002e-snip4-11.eps.apple.com ([57.103.88.181]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXa2-0006HD-I9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:29 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 9068E1800179; Thu, 29 Jan 2026 19:21:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714483; x=1772306483;
 bh=+zW8Xnd3fSoP8tYABJv1S0adhsQ8kwT3yFXLBoRfW4c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hB57NnoZdA0fbkwj7XWGljxN0U2ZbO6L30QjTdVs/e7yMy0lAzqgQglLIUUzvVA2SRdccdi5IxnRJI9Qih+HWrn/ciNAjtkSrLZLP4LnUeIcIuKl0N2Oswvo0hhzmeHj8guvORG7HCYGld23EkMKsSuZTQfi4ONPufR8q6J/qXa5/RtfSDas+FoRRz81pFDTBjDkgcG6uYpsvl26pv7cpNlRgfanO96TzhNjHS5T9fyb1jld6n9xC0jCgFVKn1uh0d5vSWJZodFKvjSAubSIC7x5TtTDxdHA0NIFXRb3bnztKYbhJmnkJxT2uh85kySGif4/gjZr7rGlnAD8Rq7jng==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 5988F180201E; Thu, 29 Jan 2026 19:21:17 +0000 (UTC)
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
Subject: [PATCH v19 22/22] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Thu, 29 Jan 2026 20:20:07 +0100
Message-ID: <20260129192009.14707-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX2IMeZSjg2NoS
 urVdtLNnCn7+rVJfhy4aXhMoUH0tOAOt828f6pQhgpuJP9ogtIH18VUDasH+inyCZTakmDMzXpD
 rUZBeeiM9AGYFtpB7V5URphDmL2N7qocZikhoRn1VtJr1JcnHiy5B6BsSl3G4TEzEX7S+/hAx34
 fSO8Jt1Kr1zaLQB5tJpvwQxg2MRLyF85oVXxAkkRyByhKholVNah5tyvv5KauFsocJABJYDF9FJ
 u4mDzsB57m+mW5+2rZIQFLnM6DwUOybvxTlQ9XvUXye05mzv55mN03WDuOe4mpa10p/x//wQLq4
 H4r7krP9KLgd4RE3JGCVt5zjLU455YWdNnk3Ox8OaLqUEP85noVMkPuAghf4KI=
X-Authority-Info-Out: v=2.4 cv=ddONHHXe c=1 sm=1 tr=0 ts=697bb332
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Z7WaYgHFM3B6hGzFikbQNEjAZqZFxvaO
X-Proofpoint-ORIG-GUID: Z7WaYgHFM3B6hGzFikbQNEjAZqZFxvaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 clxscore=1030 spamscore=0 lowpriorityscore=0 mlxlogscore=993 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABzD9xllN9ziL4LXjXNlbOds44IP8xTx0nABwcaEiW4l9mfV0LRCMAdz7L+jkaI0YT2x1QM+bkEMugpIneUnlkPwFzqPEUEjRObOgdRLhfZ16cijtJjrUhoOUuHARSd31Y9XbZAYSciNa9jCKdX/lRNQEJksu4f5iaVIOpiTieyW+r67cytjo3cTSKp3MLXkuo9jvBwYAXIikyGZNP/vDAnjBHLUygS1Wjfj7l3jv8v1N55LQlDzywNx/zWJo4wEkdpNEzXA0MUXD4UO1jjaskDPtKMN9AAutBm+m5kGji6WokVAzi4nqLFexoA8hNIwzC4dY6Xs9gPCXOxykYpOzXTAoNHwzz5RF6w/fEnDlRi7zSsXc1z8mrtgx7YWNN0ouB6enhtcgwAyeQO9S6w/T0UTuYlwAUkatUb+nlQmgdeNh5BqUyfNlk6zfg2OfKQuWK8z4/tiJLlbweDYjlTCgfP/Es9dovnyfQpo6eyBEncCpOvNsc7AtonitDRkfkHWSfeYBmLJuqOAw7IFynE13KkZXeJ0LbHZVjwfTyow66Ia4mNGBV5lSaxW3og8puZW7sjfxfKf10U9RlQUr3H4RVSCVZZaEx7wVsr38G4+Nkrvm2RRKv9cnNAkmIC3zqq4k7Dn/Bgy2bLnr0cHlcm1WS8MCBfYoMkazOUPTVUlkBVJYuwdCZ9+cYkPZ01aidWO6Y/1yrWB6Z6BORkeTzx7cAH3qvSSiih6z4IUpE+uTTVUwDJUBeuKciAjOHfzBd7PmnCSN8SZMkjHQdSLxHUmMK+I9esr8kZYE/T9Oyc/nXQMmAiMkRQlWixBe1QKZNxTFkIZ01jen/2DqA71kcztfjOE2AN15CiiuG2g==
Received-SPF: pass client-ip=57.103.88.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..ad6ade223e 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,8 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 44ef42307b..36c5e30a03 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -497,6 +497,8 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
+            /* Partition-wide reset, to reset state for reboots to succeed. */
+            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.50.1 (Apple Git-155)


