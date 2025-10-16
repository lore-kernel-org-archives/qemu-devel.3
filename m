Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB442CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RIK-000108-Qq; Thu, 16 Oct 2025 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIG-0000zS-IV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:37 -0400
Received: from p-east2-cluster1-host12-snip4-10.eps.apple.com ([57.103.76.63]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHw-0001aS-Ua
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:36 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 835F3180009C; Thu, 16 Oct 2025 16:57:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hP9mipJJlzEp8BAG964JLQLLOKiV7YupjQ0pPg2yZ4w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=P1YybNG4h/afzc31t5JKrk+Ro30CCIRUcIs9btvVmE8ZR1c5y32KZpiILT459adniFeouKiYH7dXd8YYjfIPIi/XIiR3OuzJESBKQhc6AVgzkjHY/sA0NKmfceZWUyDGrGIEWBuCE+YHfG7FNnBcFAOLcplXXCtx0VwoK/om+NIlyhms7s/T5v6Gya9MOzM5b+/i1eSYR/YiQROYCujRY3UF1yjbtZGybXl9KLvsYXJuLSnTm/BFRfqGqI09VCszNhxv6lCDqrkb3MNELJf3vaRNv9LCllR/5rDGjQukK0knDasaZGaaHeZAgbZnzIpwk8NaXAyxe9ttMnYrbs1SwA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 5220C1800326; Thu, 16 Oct 2025 16:55:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 08/24] whpx: ifdef out winhvemulation on non-x86_64
Date: Thu, 16 Oct 2025 18:55:04 +0200
Message-ID: <20251016165520.62532-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BIBHmbkbIcoNOF3xP2060srcDzIfcEwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX+L7V6sM0ly+w
 0JVy2IliT9nDKb5ST+tMU8irr4TkOiwZGqlR7SRrXjEQPwXz+ZrCIhPh7HLp6rMknnQiEDbs8Sn
 OFNHqBwk0Y2ulNThG64aErKieb6iyutzM0GZ55d6HG77sf/NtK2DkmDJ0BIlMI+vlr0KaI12fsD
 M1kuSTJ3PDHUjEPPCx410R5p7tZp/ZvS0zcrEJty/rLoGXHnTMzhFRxTdS30BFYs2PPH+PSMJKq
 PhZ38OJj1bgWRa0Tj4pW3ag9BbMW85NlH12AEfdpQH2sxngWd1J4Xq0eeFsIyqT3O7D0OeNUs=
X-Proofpoint-GUID: BIBHmbkbIcoNOF3xP2060srcDzIfcEwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=766 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABxmB7T2oLXTufbol1toOlvGlC9GSprD2ZN0jDB/s5IZC4wz1mhFk8RlixS4r49vz1l0ZdrcPjD32GZGVsvptHG4t1eqr+HeHxNefqi+REcXV9gzvsqwvmQtjxPZDeHyQh012OjhZwDraQZ96fhHIR0X6TEEze3JxWKB1D1AxyCO2qJB2VBC0h1kbUsYOW3TVDya+gE96lmlzxvnxyBz5UQcGddTDfk59eEPITZVxpBVyXqxEFxQYuBF+fqURCmgCtOzeNgDfHdO9f5ayVruvTjYfUh15YC8JuPHKpHJTOMbiJnorGzsPuwYZynW0rMLfJHLHsyMeVw2ae+jt45ty0/CIpwwn4SZxfwnZq42gEdbjDMee8WBvIlh2fQm6KkhNOXVRjuc3Qu3NtbQ2cTQHu93aQCzEEF6QSUcucF+f6MnQg34rFC05qf+afnjQxBdFfV/4ZC2MOJg8WhM90NC5iv/zFdX6AGotiY2KoFiDkj+TFgnHp6VbgLNOOc++mEukSsJq2WWFoSZbQ3+lEu/V9yszAAmdzs0HejmqDF3OiSuE0tLj/9kQ5/LimXN2v5GZrVU1x7WrToTQk9eQHr819kGMRtXcFNDczfOsUBKT/Kv1ARmpuwQq/yNSuAodYbx8I+tLzc69AzhZ466vGEVl1D3gOkbwW8e/66D22+Wow2pkMTMXC4flbq4tRuFNAAYlOPECSxqYGyxOFnXIkJp1nRu848H3hWeAVnQoBcSNG1/bpnQxA7cnnAhO6IPkQCzNox2FILqwJokXDOWu5KaOvCn2KeTWh57/7p86cuFWD9psdE3XnUgsPBFr80ysVwYCmFFkBIoTASF5VTGTGDv7ckEQoh6c32JpacmKAdNY1Mdzfxr7hFtaoqBQkye7gwqziDm11aqJFnV5H8mB+TMy+ug==
Received-SPF: pass client-ip=57.103.76.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.50.1 (Apple Git-155)


