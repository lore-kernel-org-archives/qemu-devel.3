Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8C2CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6N-0004MH-3j; Wed, 29 Oct 2025 13:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA64-00044u-75
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:32 -0400
Received: from p-east2-cluster4-host7-snip4-2.eps.apple.com ([57.103.78.233]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5W-0003UD-Re
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 AF3E11822229; Wed, 29 Oct 2025 17:35:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jo9W/NpYfEdIC6CdCIx10Eqt7ku8SV4hAzngP6kYZbk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fKO4tMTeDao8zb9g9cBp0oH/7TRt/ojvbx6OGogenTqZb6D9CNaSxR40KLTFZEy8JhiLh3iEGzzd66/ekup4sN8XZE7mPCB152q1hRfOYgWksYLCR0OKTMQMPT0xkmTXizzNdphBaLMi/PkX27WkDiTAMaC0gPRUIPSD6bnXDpBNjMQ2GVhOFl5DpKknj/DGCyZi6f2mWaAQ6hG6+Rfp/pXn4PyY9iFmgvqowNVwK1iUGsER7xIfxp89P43wrqyQbhf+G8YRoPHoTRATZ+nuZHIfd53h3Q39J2QHhDRoXSDEbc61KAqx2ZVGSBsvxT1erg4+3Y2T1BkO28DwoNiqkg==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 1F70C182A829; Wed, 29 Oct 2025 16:56:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 26/28] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Wed, 29 Oct 2025 17:55:08 +0100
Message-ID: <20251029165510.45824-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KIGkLvFYij0r-LB59apV6eRjmKqNHzmz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX3EX7BAezJXmu
 ex54krSvUGIi03TT/uJs0SMsq8fUttmpPeGjUXZkeL9Ivw1Uu5Ksc9cAkvpgn6GXdtH9UbeADS0
 nfUbRm7rqRVzh+QcrlIq49iGi+s3iSnLJeZqBOFQSjVIZq+OKZb2lXo9COPCWwzb1cUJ/yLGMv/
 MDiPyq28GG3Qg0e3245Epi6XaaifOwna2Ne3GjOdb0SpG6sT1l7S83Zi+y+TqHlMYPjks6f4ai5
 pgsCmOYtjkL6kYcLY40hbum6xXfwPU8upkUN5/l1zgneRMxUDO97coW5EPSH1B8jj50yXzqFo=
X-Proofpoint-GUID: KIGkLvFYij0r-LB59apV6eRjmKqNHzmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=618 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAAB3RRpPt/zdTnoC0Qlep2bJr6VbAHPl85HEcgYnP7TRnbJaG5dZVWZEwLMXVllYWMCr8xarPGkIRDjxybYp/h2H5AZ8QoFEZeEp+0FFWpQG16suzONb9ovFCbCruBNmIvNzsXKEJVDSfWLBkC5aJRmFcOR+YkxfS3pgy8UcmUaItH0alczd+S3wRsnbeMQTzq6431GH/NAswobxr1fZJWG5ihiO2FaiCQr5gjb9MjS+CImqbT2qffrE+NhSKDQ9kh6uBOtwRa/DxW8kQfqZz+CCB1S3usmLOyYG064wiHBRrhLOwEzTi4RDvcg+ywjoXITG2wioYdcecT4DKV6ofgbYinBaB5E2JdHFY8puohAQ9guU4RgXfnbIbM2S4/RsfdhFWUb3p9L+4x2ZlnkP5MWFGzUZOkOz1S6GhlKfd98sVPsSDcmOVMONSSt3clMjPIYwiKkUCvLgEMiwua1parBaXc7Ta1twar3EfyFx20W47cl2Nk8MJj+HfHvaWiMjds8NIJBep7xjMgpBDVlVrtomqSRReofN1u2SMoIwwAS9Xbd7mtiZiCpnQ/Kuuff9rIQLdaRhITh0Ezc/oZSJDVPoCNP654C6iTsclcBaZIe/4wnCqw/u7a8Vq+UDvmcrubzq/rqNf1WNHmex2CLh5eg+ItRpcdY1orBKiGRE5M9CXqozyn6BNLVNSb+Q7MBlaFefC7W0vy6uRmWhvCrOuXJWWL2GteR48P0DiUsWfYMytnaDhheMoPqHaJ0OOLvPekxz8syzxGxKk9jE6iFM0A4TZNgfpwOP3E21P0=
Received-SPF: pass client-ip=57.103.78.233;
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
index 81c0c1819f..90b4077b76 100644
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


