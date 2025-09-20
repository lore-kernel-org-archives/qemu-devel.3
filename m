Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32502CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBU-0007C4-UL; Sat, 20 Sep 2025 10:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBS-00072B-PG
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:26 -0400
Received: from p-east3-cluster3-host5-snip4-2.eps.apple.com ([57.103.86.45]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBR-0008CX-5W
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:26 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 51D041817344; Sat, 20 Sep 2025 14:03:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=c/5rsUrStdeRorYSqBu3+Q8xyENsD0DokCuHFqMkrGk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=B64izZL1vTxTRxZdn12k8FBC3jD9Eu5bv9kzu+z9fxmEjgO+8zzKPtDuMebzIY/2JrgiV/FKVbNlihiSDDc2t0sxrja3m9mRAvkfrSD2/QttuNVqimylam5rcdUBZMvwo7dB+D0McyDYH8sI3Z+UpEQYhCpVc6MutWygV2ZsDJUH4OCQx7utswBC4fWkDSFEtaz39triYg0a3XEx1RwqpVMbWSmIFSMm8ny1RZ0xkg5DphIdS+REyg+jhG8Rmnzk+idvdQ8k3JPe5Y8+yrPhI4an/aeIKoPURifIuxrier2hYcmXtK8087Q0qxcF5A9A6ksz4plv8/R6tPrihB8mUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 4746018172C7; Sat, 20 Sep 2025 14:02:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 23/23] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Sat, 20 Sep 2025 16:01:24 +0200
Message-ID: <20250920140124.63046-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX9z6N3cyeSVux
 +RrFvjrsbkKKcWyfTpBMoj/2bnC//IYiCJxi/U5ewhwymsheKn+sqk5LxwfMyxL4inO9XnYJuKP
 4eXhjyw46jwHKhhR6EM/1YROvB5Fu2xmt0JflCpiAJETk+Ra3CCMhnXW2PGieGDcRC6kU+3XQ+4
 9cILwuLeWBTQsevw5C2ziSJizQk/f6kazF4YPGvkcD5Tg5IFshQ2pLJJgXCGLwuZ5TA7QIIyvKN
 8ksbpcyC1VWOegRd55ZvjxJ15FPr6dCwu3suXwGSyhzZsvRKUdFCKsxnN8oqHX1sK7eFS3qIY=
X-Proofpoint-GUID: c83yXiQoG0AGIGpW8wmiFxYHfBhemJTi
X-Proofpoint-ORIG-GUID: c83yXiQoG0AGIGpW8wmiFxYHfBhemJTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=818 clxscore=1030 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABmrj6QRYIKNB2jjK68fLx1j8Ye4m2/dogagyZ06LY5SdiO0gKY3szkKLV6wZbdP6RmoPxsv/pQmJqRVLNkmGCPeLH7eW5KBSvwdZ73lbaDbHyGc64iPkGbWLcdMkkjCM0eE1uFnkK+uwAraaw91y4pUueOCX4MGrRjAIxd9/QecvttWiApxr1dIIpHLcy2HJqkG5Cx66zN2l+xKkPoErE24iXBaIXjJDgIQCeP0YfcwbhFmlG4qAI7ZYeoZy0Y6lrNLDcGqm2PT3RiHjUuzRtVzCoePpCz7TMsavb3TFMN+6Ima69FpY0i4cbj8cVyZHPV9yOvhpO5WEUsiocs1G0ymOO0+r/aCX477x+X1L88XXYsgTyBwimk77hnN4qKIy0Weo6d+p3WzbnhhRcY3r4qF3iQYPRCCears/rw19Fv5+mupNMrgvxT8TtKX7gBe5tQh/uMjnzw2nF5kwGTUpjC1chgIUcT/T3vQM7vBvf14znv78dOYdh3yY5AoU44O3AYR6GsMRUftetGF11KUOO9UroMORpW1bcQR569yPrwI7E0DEvwbEsSQc8ZEmcP66Qe6ysQcwDC2/3INBqFEqrEfQp3Qs1Ni8J//M0JGCbO86JRlWOnOrqMTEIw7OJzixq9KgeNeTyeMBQUx8F+ZxV0FPs99kZ8btYAHpqEc3s1mGjWF/nC+5SEqHK7g5G02Sk+bacw8VWKnrDZp4+IJqol4FGkOtFviymSWzPwbMFnrpnXBoMRdIQdz/zRXdJBtvdZhLV3U45NF3WFN15+Y1B3BlakJSUQ6XPR+4qvljaluwLz/YAwnl8ryCsQowHNHbLuDp9RIWVImxSnrfuEU6fcdR/zpRViefMeOhkhzQKT8ms/y8EvWP/I1q+qQ==
Received-SPF: pass client-ip=57.103.86.45;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/system/whpx-internal.h |  9 +++++++
 target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 366bc525a3..b87d35cf1b 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -84,6 +84,15 @@ void whpx_apic_get(DeviceState *s);
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
index badb404b63..285ca28ba2 100644
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
@@ -156,16 +166,28 @@ void whpx_apic_get(DeviceState *dev)
     APICCommonState *s = APIC_COMMON(dev);
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


