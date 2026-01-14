Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81997D37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg192-00081T-9K; Wed, 14 Jan 2026 08:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18x-00080H-Iw
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:40 -0500
Received: from p-east2-cluster3-host6-snip4-10.eps.apple.com ([57.103.77.211]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18v-0007Jt-N5
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:39 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 09285180017B; Wed, 14 Jan 2026 13:42:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4Um6hRxHh4BMXdx4GLCdFkThKG/poHmK1RPmbKL0RKU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Fw/cAFjI9PSNeGfaTonXBbvI2rcaH/t3PdLMgWjsBe4qsoUC01hkMTvKjzjUnk1KpWMNYCrzEwhB59x5jlB4Oob+QwLK+Dl20FBIQ1DDGQSfwPa460eR7gJaxMu/DzvSWKIxulypXY5g/I+QMkQPHkvYcc9goXU8U7SWQoGZtch2+TfVqhOGXEz/40dn6YeNXJF6t+giBipkXwGD5GZlxl97goKz0iPhGVKEk0SX7xN8irASI7vUvBk7EyCGcPaa989GdM9xIKqx8yNAXkvksTq7bsqq16m79fZ2eC2gO1zUoIUNyvE/qr3uGo48lWV6eXpq0rnhZkWX5acrJ2svlw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 9CC8C1800160; Wed, 14 Jan 2026 13:42:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 11/26] whpx: ifdef out winhvemulation on non-x86_64
Date: Wed, 14 Jan 2026 14:41:28 +0100
Message-ID: <20260114134143.26198-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX4rQfQd6fr/Z2
 B1PkWlBc9k6+k/gkx9RZQLdGXVU7L6+3FMn+qzoajt3oZiUUT/h8+yIbNCX4XC9UK69wFlMfCe8
 ksXcFAaRv6r+BOGLOaNHlLWJIm8EddLJLk08AhvKvfsPrNQv6GqDpEuzn3CfO8LLmGNPAShsrjy
 SfYIR1q9bAqp5ZzpclDWIArLz0Px3WMydxcncvv/cT3m/37q4xyWrzwyA+QYmAuVB8HpYCdV0nI
 A7z3XYifuZbMf/IGakf4VZiSWjoKhqta803FsyQXM4xt1PHeDWU1YGtmcQHQTeqKMvLBzRb5mTV
 tqi3o6rZ3995OUTPInm
X-Authority-Info: v=2.4 cv=Ys8ChoYX c=1 sm=1 tr=0 ts=69679d4a
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VExx-Oqz_yhFp4n2Ql0A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hwZ9tXDMFJRqIxELI_pULaOgOZ2NZZ0G
X-Proofpoint-ORIG-GUID: hwZ9tXDMFJRqIxELI_pULaOgOZ2NZZ0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=963 adultscore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601140114
X-JNJ: AAAAAAABOWCIyzu580eol8PGb5Rb+swz+4snP7RsDMkURaKm4pa05vyck/1w0AwyjPqYG5RV+LFDCsm4g+Cdby4vLRLrgWzKSRQgfioRHF7/Xz3hHtU6w8Ix1i9kFF/UEIZ9+YrHXXoqfK1EQu+w+OYZiscB1NlFFtJyw521HdDt3Fg8c5FVWhdymEb3c/tqtfb9t7V3cmTglUqptMPgm8W906L5+MtXv4zYD0TUEifktg+2gcPN12/dL6jaSlG1+30ddES2QU4BphPSmEAHu5lngC90dfUGwQbO/by3689i/9PKV137ndgOE761vsrD0GyVk+9RGQFGIeViPdqMO+ocNO4Zyj9RIa6fsppz1Z/VSFZ6eUnxtb+hyhvam7ObHm5wJZ4iuP6hvboSyYY3Hv6UMLa1C3JHSA0areAWrWMOzEJeSc9cPgdBs/UIrKIF+ssWNqUcYJyu+r9KVm9d+jFf/fgzx9/Ro5njqkSsG/hj/abopMxmHtNo0xx0h5y6/GBC4TtDRuK1jlQIZ/9L6zMdF8/I0ttTeXYvcqOqx98qNolwTz94oJJ/LUpA7FJgzKnifkCrQLzXCs6nMozmo/T1Gb7Uuormi+kEFMspn8tUqhTxZAF5DDxr4jc8Xxm/p7+mlp+UPXuC9nr6XBqY8I9pyjLwisxGVCYr25Abrj0SgdQ1NQGzL3cof2By3QPHt0N1X9kYMiWX9DdmN7nxFU62J4zyz6MSx1JsPriMleWAl0DnJtIEbZ/hZHvmHxYAYHLwNpcLS54CCoQPSepfA++h45gwROKR1YE0RZzjst2SNyqG0NY49PWoCDEboCz+3N5woc1bMUyKOs8jcpFgAq5DTyNPwU/9qdasvl9tRJeaRpxCFrDTfKyFYlt22WhvuDXoJEjX2DbDlrnGPKecIC9q8e0wDdSTN9s=
Received-SPF: pass client-ip=57.103.77.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
index 0a6068fdde..c58344cb61 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -37,7 +37,9 @@
 bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
+#ifdef HOST_X86_64
 static HMODULE hWinHvEmulation;
+#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -232,8 +234,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef HOST_X86_64
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -408,8 +412,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef HOST_X86_64
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        g_assert_not_reached();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -535,11 +543,11 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-
+#ifdef HOST_X86_64
     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-
+#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -549,9 +557,11 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+#ifdef HOST_X86_64
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+#endif
     return false;
 }
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..8f171d1397 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,7 +3,9 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef HOST_X86_64
     WHV_EMULATOR_HANDLE emulator;
+#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 041fa958b4..609d0e1c08 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef HOST_X86_64
 #include <winhvemulation.h>
-
+#endif
 #include "hw/i386/apic.h"
 #include "exec/vaddr.h"
 
@@ -101,12 +102,16 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+#ifdef HOST_X86_64
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+#ifdef HOST_X86_64
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
-- 
2.50.1 (Apple Git-155)


