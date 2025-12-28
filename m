Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F03D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0eR-0001nx-0y; Sun, 28 Dec 2025 18:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eP-0001h1-Mn
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:17 -0500
Received: from p-west1-cluster3-host11-snip4-8.eps.apple.com ([57.103.66.31]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0eN-0007Sb-2c
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:58:17 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 D5F941800758; Sun, 28 Dec 2025 23:58:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ikn0HzDDxg3hSGfBkyUa/ql2C2gbLWDqs4VNlGZIV7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZhSKC4/ejR7jgiYDF21umjo9GmI5TaV0OEUzCFnOz/fSku6fk/+LYtzWmJr2r2tqBUq7ID84KApVQlqveRWB032PLgPvhgEAK+GF7CAjJfAZYPm02O+PffpRvDXSNpCaM/5SaacBjRKBZU1AjHBRNnd5VtyOR2sawGBl3ndhpmuqw5+R+DYAJ78FrRXMXciEzMc9vDQ2NA3cJWQTcNvoXtHlSDj5/eCyayN9+hyZheyEvOxJfXIYouY8BKgfe9QnisupNKVJOpM0bq3XvAIa+l7j8rKcdXpEv6C4adAeCEgZMO61GMj7CIpm4hxTtet951GOMunUbuXcaBb+QD/2QA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 83AD41800761; Sun, 28 Dec 2025 23:58:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v12 25/28] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Mon, 29 Dec 2025 00:54:19 +0100
Message-ID: <20251228235422.30383-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Yc6fkOfZM3JNY6KYX7Iu5tdGTUIF_Fa0
X-Authority-Info: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6951c415 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Zj7cAsCNdc2pAJP8fGYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Yc6fkOfZM3JNY6KYX7Iu5tdGTUIF_Fa0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX2KCzWElALAb2
 cf5Lkjbu98j7dLG2eA47yjVDpAGHoMUrANJE3mDxzhktlWeekCsi4K34PTM9ohh4GqX2wG+sqtr
 kKQhtrEa7Ex/6r74IrBALB1ObHkYQ5ir9T8HkfndxfrsX7w5Xdsvc8LR36OYv0vGpRyRzMef13a
 miJzUrw5rvepaxjZnvuYUkkbcdx1jefEsVfIuG1Netgqnr3nvU+Wi4NQGjOWIYsgftMF95y+3iU
 itf+e8vgnH2arxYI7wFDB9VM78XuqinhutH5M39uc98gY9ZiEWbp4pXVVq8mjiPOoxXLvwWSn6W
 cMp3Fb3OAOtoinVmONJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=766 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABoPCKeGPIe4B+F+gv+aaFqONWp5hwfjtaN9+u1CxdHkq/DRjgalAHDffC3gpsfdxYpnwZBx1OZtY+vubmhH1dMLEvncxioQz061m6v3TwL3c3Su5bizooEXxR+rQ6hCJ7f/U6CUbWtnx05vgCV7VwOkIweKmEozA8B33VPncF94D2Kh59qEI1yhBDSVvFj/kd4wv8/hBHGAEWaTpBeiqK2UykAw2aFoNPTfVFGAYKfQheNqBvstVoyZ92B11iab9zLvESe8Wd6zwyGAYQVmVj3jN11a4NLu9g3A3gaHS3utcPS5e1giSdGp6ex6mXGU/og1FnWBVRxEChE3rO5tSa967gf12ph9FV3fIYg52ffcM8Zzt3Pe53ao4lnQsGRUlhljCNW2CyZwLCKPXWIANacBEpP9yhQaRatBa9oCofZzb5VjXK9lcXB4GPn1Y8AnOsAc9TV9bHvnc434CPnSJWe7DfA5GQfHH77wZwVmjejqHCwWhg+KaMjrY/vaH7S2t7DSXDlCN8nD8lOSWX+kEugrOmk2GEzWJ2h2RD00HErciiYUJN76nAO1OGnAesM+8X4iS1IWE70BIzgrnVbLmO7hCbH4uJXd1B8lDSFGbc6bqpACdowZTBOIsVwt90vvat0+O0JGOLn7nPDfcyCV4At4C1RRdsMohf970dtDIHZ0pmTNovHqCiA2miAfPA3w1tJJltoK8YLtv12O8XQZWLofT7uhT21LNvEDvOmV1H4VV15d8iyvMahzSm6F49g54TmJV85fvrXncXvBCfaDFZPIXe7m3tRPuMXxRuK0PCT011XZ88PIm4ppgDTR2zX1+9NrycTO+IwIn+myWoOQFJrqL2DWJcl5Rfgg98uGVgQLMDnCP8tgM7qcnHyF2qWWMJd+9Hb3zyYZxkC1kCN8tp/CR/dZtFu++XXK1LIKoll9klLfCNxXMIV0txwNj7pVAFudR98KR5QvdThAebtLsu8Nt
 T
Received-SPF: pass client-ip=57.103.66.31;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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


