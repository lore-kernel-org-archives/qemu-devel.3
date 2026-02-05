Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661EAEC1EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzAJ-0007si-0G; Thu, 05 Feb 2026 08:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAF-0007p6-CJ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:55 -0500
Received: from p-west2-cluster1-host4-snip4-5.eps.apple.com ([57.103.68.78]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAD-0001aS-Mh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:55 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 E8A571803781; Thu,  5 Feb 2026 13:12:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297172; x=1772889172;
 bh=mBFnX+1GWKubPDZlgEM1plJqBHQoJzuLiKUgkg0UYPU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=O2l0Tg2Jgdk5MPo5/PDpK0dy0XVnjVfNdI9NBLgJ9vDM+hxyQSUlguMJ9O8LYkHvEOyNJ0Aih6pIccSWB3J6ynSTT/kAEqrQh3VVIquK/z0eu/QwtUSJbwAH4i1KFEW+rW88JDvXqKvBvcVNFYeb5goSkUzDwBZYzzkHZaqSWou5Ff+EhdbYKlw0Nc4zVJ8sgDPTgisB/AdvCvBKPlf8JZubQ1b39cEyF2RUAgNTM8j6XwXcW9BFq2l1gCZn1uLqIEOgmd2tcvtiZA1h33IJ/kNm+D777YpwTS//7yhxEtz3OJ3A+lGUGU6Qr5rn2qvSph+6mw1BwSeJv+tna+bXhw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 22BA518000BE; Thu,  5 Feb 2026 13:12:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 10/22] whpx: ifdef out winhvemulation on non-x86_64
Date: Thu,  5 Feb 2026 14:11:39 +0100
Message-ID: <20260205131155.22780-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX7Hrgf9zHwskB
 6JLD6niMGrKQULALBmHqL3ZfU11rZUJPFOqC4qSP3AGiWZcwgKXi2j3cjobIjFYJuEDJ8CceNOR
 2dZHj5+pqbTqkJ/69wszXUtTWSQ5/b+Zr8HW23Yd7c5qBtiUlXyPac5I4ybvXQ6o12nZ11yg78o
 wYKZaIu56VVuyj/J4hPy/hamZ1U4AAAfYDfjDvT1GktVfttO/3PHBbOjlSWJa9KffLik6RvmhzX
 hdDToiRYf05KGbHD1z2AmoQSVeoAA+uEf7jMVvG5XaQzLIfrcEVt1mt1TZY8R1SwMm/EK+NgsWa
 vem9v1/mLPXIBIo50Ew/wgx9kfVLalnEc2j6bZd/H6Ax0uYvhzMxrG2BX/6d8A=
X-Proofpoint-GUID: c0Ntjrj0Yl9nAES5sYEMe3sXb37GQlih
X-Authority-Info-Out: v=2.4 cv=c9OmgB9l c=1 sm=1 tr=0 ts=69849752
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VExx-Oqz_yhFp4n2Ql0A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c0Ntjrj0Yl9nAES5sYEMe3sXb37GQlih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=982
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABiKcAD6T7igeZwsgIlwlarp55DLB9ZzFO31+Vw7FtiHvR8l/D5UO7CIBpteU+O1IVSATTD/IiewY8Fkd18KXUS0j6VywjJnuHa+4I7nNLfjUyb8ARZcIxcj5mMag6S3AqNI8kGR73mI+aE1UayF0OG+jeJTbb9im9A0KJoEGSCYVcCl/aMgnw+ljpEM1LHTCyEfqM1fYNOzw6ylpPhNNkyPrp1LXeX3J4N5d4Bvk1AQiyVU9uCwjk0KT9XnVofGUmrhiVbgF4aUpohlevmBwQL9Qw0Jd/WQKJaF4rDcAYq4lPzNQEGiPvYcBwZoQg39I8HptsG8fRsk/ugjzblHhEBo+gwMwPxhWig3XEqsSY0Dn26c+9nPB+yV2oXfm73Wk55PYwE7VqaAD3PXfBKUTLysj9P9CrVuP+wczgjAaygdYA1+PRnPuDIhKxI5I5Xr/WBEraLmwsvRWQxXKXn+9YQt+cXELpJrKO2uiYd/JUllue5xbgIlNzp4k/o4cXlej/M30J2ef5L3y1bNYMVljieI8wkohE/elW59P3BZiG2BRhUNAlCvOhZ4gQ2vtmaUKWCvri6Gh7PY573eHtsGzCAceU/H1X7YIVj+EyEmJmKyDRDateWZi38nmx0uLY7hFxUuWVue491ulIHazRDs7CTRkn5rinE1yGAnibVEawcqO07elwNlES4p7V7T4jniJJ1tCUUwkqxY6fmbBCuigsk/DqHPoXuB6s+ZflZtD/QQU0GUYVv30deFXSJo8i+g/iP9mEhwjQQpBG7oyEMqsujeXnfjf3bn2WaR9Y6ZW79892hdIxLINMApgTIx8pJ2Plu/P2tojeEmoH45s4WMJHkNRggDFUS+1l0LmYYHifpNdwrFVb+9hzDZdufyZ/Po65ulDyAXjdFG2lzgpB/imMYKelOko67TQFIdr5+kEe975YirMJ3IrfoOU/NC7grQ==
Received-SPF: pass client-ip=57.103.68.78;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


