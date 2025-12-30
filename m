Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2283E92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNFW-0007Rk-Dz; Mon, 29 Dec 2025 19:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEq-0006Uv-7O
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:28 -0500
Received: from p-east2-cluster2-host6-snip4-4.eps.apple.com ([57.103.78.37]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEo-0003ze-82
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:23 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 79F821800476; Tue, 30 Dec 2025 00:05:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4Um6hRxHh4BMXdx4GLCdFkThKG/poHmK1RPmbKL0RKU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZNOVqCS5e1QkBx0XqHCiOJHXHdgUWyruHUrbrAPJ4OSRji8Ny/KKqjouqW1Yg1WV8a0tQdZobOi0Okbbvdf0ctj0QpCFamD1aumisK4QPXehjN2UZXXdVYg1CMnVn10OD4f7lcVKlgaMg0vJtdcwM0xopm6StXcjO8gw4JrUphEC4L7Yf17H8mtsdG333bobYPoBcyjZLPy0Dfz2/QMJ5p2Y8WGL0Iap2FRsdHmuQSJ1GtIwPi7m/3gNt8PFzA6d1lGyFSNKwwjh3awzX6l+0xvfn71B534DJy9LjRcQ7WeNer3vuFwDDTaoHK8Kw4Pz2z0JWdYJTIXfkfDJfobqAA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 2C18D18010C6; Tue, 30 Dec 2025 00:05:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 12/28] whpx: ifdef out winhvemulation on non-x86_64
Date: Tue, 30 Dec 2025 01:03:44 +0100
Message-ID: <20251230000401.72124-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=6953173e cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=VExx-Oqz_yhFp4n2Ql0A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -SLd5QbamGTec31qWKgJVVlMrdbi5Xb1
X-Proofpoint-ORIG-GUID: -SLd5QbamGTec31qWKgJVVlMrdbi5Xb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX3/VcHyAM/+Vf
 2TzReD06mYXJ57o5wrnf5tjS0Gx8b4yME3PMSkEHeFBTpPyFC75cjKE5NtUb3wHF7uXhTXWoHaA
 Y3lFYK2ShMWsW+/Lh7AWoteRWeNAmX8ObIZPlvw6m9U3PbPW5sZaUYP7HqCFI5yJ6SezT4LlIyl
 JSQdjvmrbe7BBoHiO8uwClPsj5w9rPFc7lR+03hPPg/BGMahUOte31SZFddYDM3yGcn9GVj70/o
 95Bdx0BHsOcAxLXeBFXUw+hTmcVCoBVzRACgBcFBSYQmyDSBXtQEPedGKHKTeuTjwwQtndgd8dI
 reMwgViE7ffjDjvgsy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1030 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABDzjAdje+YPBjOeYtwlohvi4W9ZppOayefDMLQEdfH9MwmdelI7FJFisds0KF1IlWXeij5+02xLFJndwBVJ5j9tU69XNhaBoPoBipyn9cfNYGA/DdraGryghMg9PqwTCLO45Nw1ynUMaaSA4IIW/9ksyv9U4ufd2YnSw6x8ketEiwCyy8SHJ7iD/lS+ni7l074CSDYISXHGZIJrO3pH4VmanQeuKxOk5ZSaxZER1J110IxlP15V1cLvK7As1nant3XFcZXFcS3Y6q10GQydVEKsuUNgqDH99OaBA0TL6CUO4XfhMpxDCw7snBNgVb8PA5mdU9NxE4G+OP3IJIdPFd9rCXbWjiqBYs4P1Xq/0mO4/RTnQdqGBY+Rpl/zFbLblORlXMPmQud03pxB3XTgpz1MP3y8ZNaSr3eeRAeDyGCFuqF9a5TrFcVVcccynzWjO5/Ego16rYGA5fMqeY3cc9xtMK2y81HHo7/UVU/SQp7Je5c38LoBKd8zalvXZGhAecbriOrgCTYgA+HC1OI/YjiiEGihhZEySnDt5lwxwK74qLCx75ymV2eLnwkXaz1IwPTvODU94uVUIb9dfKwBgFfT3+ymtbbX9KDphdvZjcB65L+9GLfnuqG5K4tJp6qkeeNIuFoTHdNMAIsby3JczYhseRZs3evYuEh9PBbOzgUWJJqRFFo//aTqFLyiujRr22oIEcr6wYBHQXeiWJM4/XQR9qUzlniO9CBGK2h9u3wLS9WmW5539leH4QGHzC0C8Q9btOYsEyHFhSUslOdZzlq8uEtG7xFYlE0fjAl92iqqMra6nq9dMVjyTPmjEpv0PM3HIebRU1UPajijYREhR4/jhtJCEB6NWBLngyAGI207jkxJOfCLLLErW4wV59fEJU9xphKnzb6S9UEVeZC6dr2ndF7emQG1l8w3gNTM+P9S7BtZSIPAC1NQ==
Received-SPF: pass client-ip=57.103.78.37;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


