Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECFAC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 05:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui4zp-0008PB-89; Sat, 02 Aug 2025 01:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zh-000894-Pd
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:21 -0400
Received: from p-east3-cluster1-host9-snip4-1.eps.apple.com ([57.103.87.84]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui4zc-00063X-M3
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 01:41:21 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 5A3F41800880; Sat,  2 Aug 2025 05:41:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=at/Y2OtfaWvTKG4XZpa/WbQ/msA/kh54pRtcf/l0OZ8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=dJu/5iVCEWi0J6VSF28s41KeTCzKwBNe0XaocH/z2ilZL2+j6vcGsmDjszVe1rmgjQKYMUlPTcrT9c0JYlquc+OcfZtHrb7M6iBAyiJEeSHVrWDPX1I7PHZGjac2+r8tmSij16dKl2guXzZrRmk6oFXKoDV4M+3uBySAJGacKAeTGP+PGJ7yEzqBiCYqWWB+7Kf4FSO/shuUaAHoLTIJr9qMb/peF0aAy4slWujNFU/aumInIU8yAQ3B6783KqLGeEQhJDZr7kdVTZqCGZHnowQ4ZbcByz06aYnq5+P5dIzJlxBjGhnanMstINLMXd190kMG7wM8ovlqp+1B9zSShw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 7818A1800A83; Sat,  2 Aug 2025 05:41:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 04/14] whpx: ifdef out some x86-only code paths
Date: Sat,  2 Aug 2025 07:40:45 +0200
Message-Id: <20250802054055.74013-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802054055.74013-1-mohamed@unpredictable.fr>
References: <20250802054055.74013-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA0NyBTYWx0ZWRfX7bWz74ZP1Tqs
 BHKdI5hrrSsieN0F0bF9chzzfgX6rXJWfWachANAqWB5Me8PVyNnPg1+A3A/C5PSIrHJl/eB7qq
 I9M4kApmcWW121yOaBJgt+H5V/ztHJlf+WKessqK3SGcAGhlk+9+uyGKGsxA1qMhkM36ZaI++Hg
 jagPPskvYrTYZxsWug8DbvG10bPg0q8RTeh03XgxU69xDluxVG7rurgbaBmn7ANunYTs4ARR+ex
 xZ6558PnmGyAwWhxsXcGM7LlrO8F2QNfSGFL97y0pfTdohBhGnems0IV+W36mvnZgMtROrO7Q=
X-Proofpoint-ORIG-GUID: SCEYznBe6nmk_XBNR87EmcQyzpR3Z0aK
X-Proofpoint-GUID: SCEYznBe6nmk_XBNR87EmcQyzpR3Z0aK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 spamscore=0 mlxlogscore=798 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020047
Received-SPF: pass client-ip=57.103.87.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Exception exit bitmaps are also x86_64 only
Others are just variable definitions not used on arm64.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 20 ++++++++++++++++++--
 include/system/whpx-all.h      |  2 ++
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index b5e5fda696..eeefaea329 100644
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
@@ -106,11 +108,16 @@ int whpx_first_vcpu_starting(CPUState *cpu)
              * whpx_translate_cpu_breakpoints(). WHPX breakpoints must
              * now be recomputed.
              */
+#ifdef __x86_64__
             whpx_translate_cpu_breakpoints(&whpx->breakpoints, cpu, i);
+#endif
         }
+#ifdef __x86_64__
         /* Actually insert the breakpoints into the memory. */
         whpx_apply_breakpoints(whpx->breakpoints.breakpoints, cpu, true);
+#endif
     }
+#ifdef __x86_64__
     HRESULT hr;
     uint64_t exception_mask;
     if (whpx->step_pending ||
@@ -132,6 +139,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
                      "hr=%08lx.", hr);
         return 1;
     }
+#endif
     return 0;
 }
 
@@ -238,8 +246,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef __x86_64__
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -414,8 +424,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef __x86_64__
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        abort();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -541,11 +555,11 @@ bool init_whp_dispatch(void)
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
@@ -555,9 +569,11 @@ error:
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
 
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index a82b083284..838a25fa75 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -8,5 +8,7 @@ void whpx_get_registers(CPUState *cpu);
 void whpx_set_registers(CPUState *cpu, int level);
 int whpx_accel_init(AccelState *as, MachineState *ms);
 void whpx_cpu_instance_init(CPUState *cs);
+#ifdef __x86_64__
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
 #endif
+#endif
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..629810b384 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,6 +3,7 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef __x86_64__
     WHV_EMULATOR_HANDLE emulator;
     bool window_registered;
     bool interruptable;
@@ -10,6 +11,7 @@ struct AccelCPUState {
     uint64_t tpr;
     uint64_t apic_base;
     bool interruption_pending;
+#endif
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
 };
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index e61375d554..e57d2c8526 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef __x86_64__
 #include <winhvemulation.h>
-
+#endif
 typedef enum WhpxBreakpointState {
     WHPX_BP_CLEARED = 0,
     WHPX_BP_SET_PENDING,
@@ -98,12 +99,16 @@ void whpx_apic_get(DeviceState *s);
 
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
2.39.5 (Apple Git-154)


