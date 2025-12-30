Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1141E94104
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNLf-0005GA-NN; Mon, 29 Dec 2025 19:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFr-0007rP-2N
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:30 -0500
Received: from p-east2-cluster1-host9-snip4-10.eps.apple.com ([57.103.76.113]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFo-00046Q-PB
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:06:26 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 1CFD718010C9; Tue, 30 Dec 2025 00:06:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ikn0HzDDxg3hSGfBkyUa/ql2C2gbLWDqs4VNlGZIV7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g+9XCp/U55N+eWCp+HNwSET7HOO74/r+cqf9a6GUSZaIrHmYf4HYHGEUGOv6Ny2dCuCzSBOgCOrJgS0ktM6HPucaDC9+r+NyA810luDBZldtvDqyhqsRKXYAqC0zXjQviuCIQd5jjAnyJL0vhoIBUtEbqvzqk6wTz+np+uMR3FJXC6f5lFjEM7eXThS6kz4NiAIdhuxszEsOIl9s4Z6jiENNtiaebUZ/9AGN6N+KXdqJ1h9pHzH+C2dmBVpRAYOwTVoNzqi/OhjTvKaZi/UiDJjM1VwENa2eElg62ie8xp4YUWzqYYu13nM64qCEAuu8JvgnVZzhqGZiL2eJSfW/Jg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 BECEE1800479; Tue, 30 Dec 2025 00:06:13 +0000 (UTC)
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
Subject: [PATCH v13 25/28] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Tue, 30 Dec 2025 01:03:57 +0100
Message-ID: <20251230000401.72124-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vmpQQAt2xnlk7uMwHFjNfF6-GSBNQiIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX7ITmP0IOYR3t
 RLB332kjU6IVeHbZT/OEcoVN4I8wxXwLEH+mMxjG00ogKx57huTAWixIDPkpS+jrGdjGk1rChJ6
 Qku7N48CosZ05i5wjJndORGYIkH3XQbP5lVyb0n5cw/girFxNRlZ5uzoa4Hsm4LDUuubqnjtOmn
 SRgJfK+4aWDXk/LlTmmi7o8vvtwjcAck5e1pDPTj/+Qk5Rkayg703N1gAP80EfjR0jDPlGyPstJ
 Ccyjm3lMWQYsUoLOeBOWOPgjI67enGoq28Wi78/SCm/yZSrGt1MRzSFYe00xf9a/EUTbtNY9Xpc
 S/BjzzRmshPQZ71UGBL
X-Authority-Info: v=2.4 cv=EJ0LElZC c=1 sm=1 tr=0 ts=6953177b cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Zj7cAsCNdc2pAJP8fGYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vmpQQAt2xnlk7uMwHFjNfF6-GSBNQiIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0
 phishscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABR1RI/lv0++ynqMnDJEKbJWNKA9hGNl/lQrnPymcjstDxZnzPyULmLVVBfFO0Q69qiiCPhYo6S2PD/ocVqnfigzPM/gNHTt5WEZvw14S3d+jjCZAw96afZM3Y97ojU+qla8relHA1m6gJ5mHbyGT8eAV9HHVltGBO89mIwkUSIzjO5Hbs8v5nBXxXpHbQG2kESsCxWVY+mUIVU8Hb1OU28SUYtPwzcZiY8re1jHecSL6A9+IGQBzKSXmI0WYjRQYz14Du8bJUxUlW+7gCITagyRz1yKz2kf/E1dW32mHLLfYQqOypZKQXcqTr41dap4EZYvqb0JoRrkh/ptTl0q2hQeDnuKfFCvI5A5D10wXaivefBAKnFaBWDUouMDB1vdDIZSqqcbRFHtocwWhUZg4IuUi/eHcBVgZ5lFFEwfIlhFLUDa0TMLUk1qpFbYiZS6kQOjlgOPEeIrWRKVEwYFOmxqvTQxXXdCrYHvs/suUS4LLl9VRDymqvyPjG/pN+3CIJk0lVytq0uR47VmHg6Ax9+DilIduVG5jNB6Hc4jGWvoVKqULB0xiKAHNgRbTrsxlSoMUv7XoJMCiVHDe3UBCFuCwWuYY9VJ9wKe8Uwn5tzgavlU+kPpHDZTUl6KfnQ3cIXzUQrgxME/XSC6/yB+VPR6EfxsC6Y6qvu1oYyklkrqxyR0eD6pEYrJKx3TTJdH3EU56OQpvYGud+jZhbwxbbwkx1XO3/aDghwNvKyqyr7vpfiz2F7hH7lXrmO8NgXAo1vZesTP2qE+b5mShzsUALg6qhbDn8P0YbVk3lG9IVpZxlCWAszSV+f93xta0tM4R62jCm0UUSakwwMIuxMRXKgYD/WUan3t0hu4w3XkpChQqtiOLtwoSxEO7vBDADFJEwl5LRZfoUxGOI8itJcOaEJLt2n4YiELxjU2p2uYxYRF/Jm/qjU4SOhuj2OqXFPW3hH1O2pg==
Received-SPF: pass client-ip=57.103.76.113;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

WHvGetVirtualProcessorInterruptControllerState2 and
WHvSetVirtualProcessorInterruptControllerState2 are
deprecated since Windows 10 version 2004.

Use the non-deprecated WHvGetVirtualProcessorState and
WHvSetVirtualProcessorState when available.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/whpx-internal.h |  9 +++++++
 target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..9e872e5f56 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,15 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvGetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
+
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index b934fdcbe1..fa45a64b21 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -137,11 +137,21 @@ static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
     whpx_put_apic_base(CPU(s->cpu), s->apicbase);
     whpx_put_apic_state(s, &kapic);
 
-    hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cs->cpu_index,
-        &kapic,
-        sizeof(kapic));
+    if (whp_dispatch.WHvSetVirtualProcessorState) {
+        hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx_global.partition,
+            cs->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            &kapic,
+            sizeof(kapic));
+    } else {
+        hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
+            whpx_global.partition,
+            cs->cpu_index,
+            &kapic,
+            sizeof(kapic));
+    }
+
     if (FAILED(hr)) {
         fprintf(stderr,
             "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
@@ -155,16 +165,28 @@ void whpx_apic_get(APICCommonState *s)
 {
     CPUState *cpu = CPU(s->cpu);
     struct whpx_lapic_state kapic;
+    HRESULT hr;
+
+    if (whp_dispatch.WHvGetVirtualProcessorState) {
+        hr = whp_dispatch.WHvGetVirtualProcessorState(
+            whpx_global.partition,
+            cpu->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            &kapic,
+            sizeof(kapic),
+            NULL);
+    } else {
+        hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
+            whpx_global.partition,
+            cpu->cpu_index,
+            &kapic,
+            sizeof(kapic),
+            NULL);
+    }
 
-    HRESULT hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cpu->cpu_index,
-        &kapic,
-        sizeof(kapic),
-        NULL);
     if (FAILED(hr)) {
         fprintf(stderr,
-            "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
+            "WHvGetVirtualProcessorInterruptControllerState failed: %08lx\n",
             hr);
 
         abort();
-- 
2.50.1 (Apple Git-155)


