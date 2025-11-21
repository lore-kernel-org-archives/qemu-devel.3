Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE63CFA76D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO1t-0006mx-IJ; Fri, 21 Nov 2025 05:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzt-0004va-Hl
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:10 -0500
Received: from p-east3-cluster4-host8-snip4-7.eps.apple.com ([57.103.84.80]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzi-0007yr-0f
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:07 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 4DE5F1800138; Fri, 21 Nov 2025 10:03:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+amF34IhbuSeUQS/nlRshdL28a+sdYqnHhffWBoeRKo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bde/EWGfZBlEpF2ri1HYImSGKYus8aT81wo0j8Lpw9TCvSmljUywxV3wRE4+MukZKYCNvqT6o1V4iyjmRHJJh5rHun9/zle721dMf3EIXiss69lvBYwjKMFT8Gm1QRh7QAVjPT3xoFu6ZWfF5a0oJfgJZW9SOvZQXJzP28zrrQHkExbliIYhvNnLpi7H+jNOZhzt+Lr8wit7oaBH4R4hSCMjND3zFmZBQDgVZO5iGdSaYE3duXgH75QlmhdJFjNt6dL7iC6jumdn9su1WRbvcXMLpfqsjRspXTSrNUcTVJB6p7hVUssfDKhO64K3JL+gobhyzsioH5GbRNKOUFtwhg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 BD8AA18006D2; Fri, 21 Nov 2025 10:03:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 26/28] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Fri, 21 Nov 2025 11:02:38 +0100
Message-ID: <20251121100240.89117-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jr7CUPk9U-fAXK9KuAoKwRJIm8tCjClw
X-Authority-Info: v=2.4 cv=aqG/yCZV c=1 sm=1 tr=0 ts=692038f4 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Zj7cAsCNdc2pAJP8fGYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jr7CUPk9U-fAXK9KuAoKwRJIm8tCjClw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX7ggd+BACFi+0
 kc6sA0qxCa1Qmju66PJXNIevuVC27TxpzyJaBxZGag9XnA1yOT9jaMAJZBZl/PFx8B7RHo4hfHf
 ykvYFrNvwT1VfzZWEwbAhPoFijkiRZLY/6GtL1qqFKL4Ubfus/eYVX/lJP2jETGob+nzjAnlBY7
 Avm8g+Yuibuu2yyg1PtWwcHeUx+oBUl4JcjInGPqXBtNUVEl7+j+ksg9R2XBscyF1l18ffunJVU
 Z06SBEvxh1V/htpNngy2v57dFdPVIYcS+VChGTxXVup9y1/pmoXNvRFqyzH+ku2hf8pTu1J1nvx
 FfKjovBgKMy1eHuzyah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1030
 mlxlogscore=756 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210076
X-JNJ: AAAAAAABBVLw5IR+0qVSD0OpY4nlcsuCTw4ln+UrzGGmENi3JYxA1kCn59xAvz/Wr3I1CMA9MDIjOixkDEmE+zgf6WRABkkY6o77ut6r08fZUBZdNaBHPVsV5bjxIjK4ukzetG87+zlv2WJW/5pI3P03UibozB1Sz/hOOY33hDBVCpjTGSJCUhCv+PyNLzDvvyqkNEAanwEtse2BDOxnSBgp6yYHyeOu4mHpP8T8L/I7OHkDFQE3wrtDMSGNwaV0HjDCMo+UZ5GM9JzXh+T7y1credzBXwvoCglhM4fffZJ21ehkIfP8lwV9j4k8aZC3VcKXSlB3Ceqkev2a2x9dTm5lmXClvGZFs2Ink3H1EeMHMpbQG32Z8hdtIQ5IA9uq/W22JxL8zXPycCaV7dRQGmwNwLZDAqOTzi7ITI1f7R6MjI2Iv2HGWTULr892FTF1qW1ueSKweXRCruj+pPUBJjOb+jkgI0Cbg3nMnNn+KYJASNPL/Vj6iKPXFvEa9NC/hlEcGfnPS+bSC9yKiVnjWSCBCXkD9DIY4jG5Bnln5VEoUXrohn/3UU2s4wgs91IYp2ImzpY6armNRzfM2kNSdFmRriPjIeKyJ9ThEDvq/OWsnAbi24TWQ4wJ8HMw9BIoGScWnWqTDuyDOw+QQSANArQbHEROVHGTev2NFLNcH1dh7fDHAlK+3Br05hQsR34cWqVvoW+PoGNjO1SjGKxKrvdPBKp9CpFhgO6DZscm//25Km+OpzH/Ey6QqRZE3NgBZFlAH2YHpkmbHWa0j516zru4DSnosnKcZqU=
Received-SPF: pass client-ip=57.103.84.80;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
index b1706a2749..0de6568ec2 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -85,6 +85,15 @@ void whpx_apic_get(APICCommonState *s);
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


