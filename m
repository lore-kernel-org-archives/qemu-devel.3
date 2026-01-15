Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613E8D3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB2J-0006iE-JF; Wed, 14 Jan 2026 19:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB2I-0006bm-1N
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:26 -0500
Received: from p-west3-cluster6-host1-snip4-5.eps.apple.com ([57.103.75.68]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB2G-0001z2-BW
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:25 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 D48FA1800413; Thu, 15 Jan 2026 00:16:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=4Um6hRxHh4BMXdx4GLCdFkThKG/poHmK1RPmbKL0RKU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JVAjuVAtCE+83F6oFz892g5wC7P6G+rQzbCtqwST+dEhLeUuRgXC1xb7l+a/+9/1T5TsuMaF8KD/coun0R7geLNmPSGlW2HUIwuSB+k83+BtiiEPahCtwk+4DM+TlEfmyNHmhcK6kKdV9UNVs1a63ria5uzq6d7ts3FWwN+FJApF5Neh88PSwikpI4yOBRzCrU2uurnEZQEhJL8/hu7QpERKLl4g6O92fUC9G1wGFnEj7/ISbnfVCjOOcX0f3FGMdb4468iMI8ZSWvGdXy8vtKfkDKtlHP9F/gKxJNPxGStVU1q5qpBrrr4po+H7gEmbNG5I/FOATFyjTUyapOcc5A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 20F3F180043D; Thu, 15 Jan 2026 00:16:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 11/26] whpx: ifdef out winhvemulation on non-x86_64
Date: Thu, 15 Jan 2026 01:14:50 +0100
Message-ID: <20260115001505.57237-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=dJCrWeZb c=1 sm=1 tr=0 ts=696831d5
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VExx-Oqz_yhFp4n2Ql0A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qS3gXXQQ8c9Sjt7JlzrmSzD6LgnipskV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX5lc18MFdaxcF
 +9a/xtCTrCaQ+FLRUsEPxUJXAe+GMxnQtQ8DOKBMZ3Tv/L9T+QzHNT1DkPR30x60Joqe5prNZjo
 vMebNbVHB/TKvomvuXW8EJFSmKdW+vr/t8CNGPsUmjp8znVhDaJsqSMdsQ2ZlQM6ufOZfuI+Ftq
 RHGnNiGavgZ2sQpUOJDclRc/8YvvdlSs686970DLLehfDHu0cjZOFT/XNVwAiTn1pO6B10iLqnu
 BHCYVZNu5P0jyLmXfnluiv7oVVr3GBlwqJcWewONNBjS775l6ZTaf4qRk0ipP32TyyIffwij0r+
 4NL3Npm3gZZX/ywaxIU
X-Proofpoint-ORIG-GUID: qS3gXXQQ8c9Sjt7JlzrmSzD6LgnipskV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=963 malwarescore=0
 mlxscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABnlLcDfPeZ6GG5cU1t0SDj6PrXeSzTqm9IJ6xGJf0IB54zc/gbMiWh+bE9xCdDlnQ0x5/5B72hBM8poAmJVNvohT++0GQy5x/u34/dXV+KRc6qFKoCx0qtHjpVslvDUm19HeXZuAkN+arRtXiCUh/A3C6wemV5a41VEKs+3wqYOxnYpe5FzM1mwDJWDi5SyGTW8fNo5fCuKR3fHoc+O0VucDPCKgyLjubJiRUbtVa1R2P4unavdMLbQbqVa0lCSxW5NYmsjBZh2cW1/hahQWJRCHDu1hHOlhhMbMMvf2BVZmbDavLtRoF03dzpxhzTYiYpQFtjbiUcNbpWAgo8pzVSqO44pMGB2ALPgH53xgX5JTF8a7CY+L/FDwTNrTLjBieE+hjbwwRNynut1AzVgmEdyTccrQH7LrAD9s53a3juoPk+rkomyuX1KQb8qAxHjkDDYYqB5ptbW6C7QLqno3Wrbn0B6mKW9pmevG4dXE+la6KWFIBoCyEA5Uvn6rK6mbKK/XssLGw4TTAYfnkuyUr5kuQqlxaqDkXsAt12BPTpDrjC+vIj1uP3jHsOpdFS9uiW4QSJQtyu9UMCR7wJH/zbeyS+U4FEJBThJy/yP20E9lj1pyNug2nZ1sklI0UEYD6YJkjUWdFZSRIkorjxZy9m95d7mROu5P3RSW7HDPbofYmiIbNl3tP3IiKDyYTodJzaU7v1CHbBN1+ct+o+/aNUvpLIN1qjtWlULk7gya1jEGP22iDziOpMDefhgNKqKrURpVVPD0TUNvO6I5BrEjYFH+p63rbsTfzJu1dMRa1sbgO3zJ6yUeJmweFTG7tmeMaehzibEoCjMBfZkbGACLx4kiG9WIIrmeHdSI7+FWxTWpnVGm8HyaepmnFj5fmVsTZZuwYrrrZm+qnjA+QdcUqr4Gp106Do/xqX4HP53PkCGuvC1OO2Zo=
Received-SPF: pass client-ip=57.103.75.68;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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


