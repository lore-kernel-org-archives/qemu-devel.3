Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D061CFA771
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzZ-0004ic-Gq; Fri, 21 Nov 2025 05:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzQ-0004fB-CT
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:41 -0500
Received: from p-east3-cluster3-host2-snip4-8.eps.apple.com ([57.103.86.21]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzG-0007tf-Pz
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:38 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 92C7918010C3; Fri, 21 Nov 2025 10:02:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1HDLl+vsTco3N+tEGqvISSZb2bm2NYHKpsf2pCMBzc0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KEHLuVr86nRpO4/BwUC75p23yPe2ohoVy3fp4icjRVg5kJsDwnapfPXDahq6JmBt69C6c+QyqfMI6m/ZweYWHRK64TM6pL90AfYwmnPh4b5C3hq/rvOZGTizwlKzuwKrlZBPSWVKHfmzUUzbQmipj6qBMUGTiDdYQBe4vabCKLlLxlu4ElpxA/fMO+M5z4rW0TETV3G7hPEsA61cYwU69IRFPdG05yB8EyHoYjUmwjDuQ6N3WnThQMvnZrGDw0I3g9vXikVuL3TgmB24eEzviFJnN+E8iUycn6+on8WpGMLtnTCyzFEnqChi6e0z2i4cZEKL0M8+OZJiNT8Czr09HA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 C71D718000A6; Fri, 21 Nov 2025 10:02:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 08/28] whpx: ifdef out winhvemulation on non-x86_64
Date: Fri, 21 Nov 2025 11:02:20 +0100
Message-ID: <20251121100240.89117-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8am2yJNSNirpzvJW9nazTpRAj3k-vLTK
X-Proofpoint-GUID: 8am2yJNSNirpzvJW9nazTpRAj3k-vLTK
X-Authority-Info: v=2.4 cv=eOMeTXp1 c=1 sm=1 tr=0 ts=692038d2 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=VExx-Oqz_yhFp4n2Ql0A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfXwnFJVhRUyOi9
 F9Zo6Y98yggMtrJqi8rUEatAnG28XRuBIEjtV2EQ7wWhiI16il7Iya+8GK6feS2aPaQ79c3oH2B
 3vuttViTwiDVsXXrKp1NxnCx+f3f80rHMVEtap++K2GhdSHjoNuaMsbKsMIpE9n6m6kqaLC1sou
 gwJ+dB0557kssmFINUe1+9pKkE1ZkI0VJOKB71x2FHLsXjQQMwf1dNf0m00txi8VzWf018EWL9b
 48c4+NebWqqpTcyGshbzLBbF1tn9092al4QC08FGslSN8J/NlfoYSHjor++/GIvMUYher9Svv9A
 rQFDH87K8CqH3raYLly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=770
 clxscore=1030 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAAB8r1G76cND0K5hFiJBhvNjC7BgVE0OQG6Uw34ddj2FeXFKSxWnV4xnadKeDwXzsKhoBYX7T+v5v7O8eBmzIdrHULGuOpSLfgUtbI8ClkTVsJiMGjWu5MTexiO1iKGydMEcWhQVRJ6Ak5A3J1b+AgykCyIblGOpF89BQb11hLlr8YXdhsDT3Hxx8hWGkPj5zxyHEjed+aBaBdnVC+14qtnobuvrbpfSBrTnHIWhi6bsTxfdc/nkkE8mvU7L3enZdd/vSf+x6fZ3YwYXNlTPAuOz+hvbqSUO6jq7CuROvBIZV46q5uNDfOkj4B5p46lA48qcBextBpboM6eQWLLTEqyHcOXV6NEEc258D62gvrMcqe8SoTP7KNoe8/fWwRlcM89/K115SyyhjiyL/fKCOwl9F0nJdGMd2p34rCGuDypmZE6Ih2y9h7xVmlzWmf+J5C0ux1Dx3qj5NTVZDMrEZ48pzpW0K9KsnCC5H3j0fuCtcaPVXlFwIdLGzSH6WWR0Zi4UWAEfctfDjdu5N4ot3KYcJtDRMgezryASrFtBkdM2gZx+19Gtn1fhEF8O7rxmJkZ+/VeIFKzKNgFnIgAkwJECo54TvuVBPrzwWRqNqpY3lMDl70jmrAnoIqDonKEXoo/N49Am5J81KCXFWPig8V21Fvsv0ojcHU/CAAa9vmzropv1UflXhTJT9wjjGZ4NA1J6zaRiWQkUgMysx+M/z2eZAX7IWcpUDUbqTCZauyPa5nyG1dkmJuth578ajqrudcbsQw=
Received-SPF: pass client-ip=57.103.86.21;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

winhvemulation is x86_64 only.

In the future, we might want to get rid of winhvemulation usage
entirely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c       | 14 ++++++++++++--
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 66c9238586..95664a1df7 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -41,7 +41,9 @@
 bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
+#ifdef __x86_64__
 static HMODULE hWinHvEmulation;
+#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -236,8 +238,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef __x86_64__
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -412,8 +416,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef __x86_64__
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        g_assert_not_reached();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -539,11 +547,11 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-
+#ifdef __x86_64__
     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-
+#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -553,9 +561,11 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+#ifdef __x86_64__
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+#endif
     return false;
 }
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..7a7c607e0a 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,7 +3,9 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef __x86_64__
     WHV_EMULATOR_HANDLE emulator;
+#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index c59f9de091..4565436682 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef __x86_64__
 #include <winhvemulation.h>
-
+#endif
 #include "hw/i386/apic.h"
 
 typedef enum WhpxBreakpointState {
@@ -100,12 +101,16 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+#ifdef __x86_64__
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+#ifdef __x86_64__
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
-- 
2.50.1 (Apple Git-155)


