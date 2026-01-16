Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD1CC79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkH8-0003o2-On; Fri, 16 Jan 2026 08:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGK-0003Fe-6f
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:19 -0500
Received: from ci-2004h-snip4-10.eps.apple.com ([57.103.89.82]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGG-00028X-Tq
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:15 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 15C4518000A4; Fri, 16 Jan 2026 13:53:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4Um6hRxHh4BMXdx4GLCdFkThKG/poHmK1RPmbKL0RKU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Iwx2sEeJIY14b4UPfe116J5xYO9lyo6DbFNSjP4VJ6DGg575wciXE/evv/WgvqcbVjh8aXPpwpqyWJHjDxW/hhCnK5dOCTKZvuTCuuTIAFjMH4nkh954y7bZW/ihCRrzczdwZO04SbubQtsT+lVbQ5Sn5rGd4VE0gpx+WZgOopwcgYGvU8mzXhP47Lld1s5mmdqOThr+QwU+FrQk1aArEoYQCzsFCh2xnp0rRFn5GNg7P4J0mCWNPq9JbI/MPB1ai8OCSXRivSjQUIgHvN593Iw6qG424zRQgagoup6pZPp6wXFSWRy7STg6fygaZ6t1qKthFIZkcRmYWTwfHMqRLQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 606C41800211; Fri, 16 Jan 2026 13:53:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 11/26] whpx: ifdef out winhvemulation on non-x86_64
Date: Fri, 16 Jan 2026 14:52:20 +0100
Message-ID: <20260116135235.38092-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6GJPcTzBCxOFlIHIdePcmzMkjDt5o0Iw
X-Authority-Info: v=2.4 cv=HtB72kTS c=1 sm=1 tr=0 ts=696a42c5
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VExx-Oqz_yhFp4n2Ql0A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6GJPcTzBCxOFlIHIdePcmzMkjDt5o0Iw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX7FDXO5VVXwr8
 FnYdfbmoAPU6j7JDV6Eq+pBA/S8tkJct5WZhzq5PBmGD+fmRZpul/eIBp2V8sYuUJkXYcHJnB9F
 Twi+bNhiiKhT72Q5fIwjS27AjkK/XehRBuRzEPeXhfl997gfCNx/Ix87DJgq4lKzxi7xIU4Ozdx
 AJDSFEJ68qBrqi2zgr5Kz6HaAxivrYx3u2yfRhKKvJbiUYhU/kNI/jzNnfLdxP+inhNv5Jxi3BR
 RI4YDV6SjB8iWu6PhY8UJgCSWweH1G3vT4HvfrNdKhkh5nUY9HHSNavES4WwBmXCeMKsuTkEu42
 l+s/147qguNsoP3tlYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 suspectscore=0 malwarescore=0 mlxlogscore=866 spamscore=0
 bulkscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABjsUw10cmh/oChTqqykJJbXj9s+ZxcTN52P7fTKN07Ek+EN0utnIFNSGK5JazROQWwcOGWNkMiPfaetTaaGzuuarWMOYWT2XY4mz2N+R3KI8elW003xhgDkmzPzQYJ76ruq04/W42azFuuooGUyJIJD8e5rE3u5UDPRTixsk4+R4ekm5SsFo21QVDzeXgvuyGj6++5VCw0v2b3ze+LZXLeYugFhBjLrwaw+ugXf0tmbQuQGApZCQvnNqNvKj2ceJYDZRsw2sfc6HopnbDuWnH1TQ8uH7kHq/SL7Kzqz2OOrEkTesYWvOadg2PkKPJJwyi/AxB4m4CQm5eBxlOq/QSAaHa4c1RxzJrAStQSfBBXWrR2uG0of3eg29m0EABaPBIBJ0TlR6z7tsQBP7Z1X6ydjTtzRd4Lyn41Oh7R8hVDP/BnyaF84r2oe77qylgu2C7aYpe5JbGrOUdfwyCOvxyOVcMpX2mxc22czZSi3lVWr62MZfya16M/rCWKUVdB5foNOCUzgmNr+gcvTl2QlKlA2egutx+xqzCXtZUVsc3i4BQt3m0JyY8UIyvXAqV1+f2Zt/LOE2Te7dF9W2o/Fld6hyW/JX0RwOJckiX0SibnnseX8e1J8Ij8ei/pGcaz+c65ssANmo2aYlOtTrqYDzD/NSPq2Q6lcOKYP/nH7CYHETIIS/ZCjLaidJdi5CmvDl7zkoM2/5eBTJa6rx1rRTt0IZX/enQIX+jC2a2jFpO/qMn6usTN+7zeaA6gDyDYucJ1NedRoVkB2gSbnhytDMmCbtEOy8j4uauOJl2NeP1BQ==
Received-SPF: pass client-ip=57.103.89.82;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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


