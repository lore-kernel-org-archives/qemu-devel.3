Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E91606A320
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=g+6Bg9wv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDRu-0005hr-Cp; Sun, 08 Nov 2026 19:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRr-0005hK-F1
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:23 -0500
Received: from ci-2005h-snip6-11.eps.apple.com ([2a01:b747:3005:202::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRo-0006Ky-4w
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:23 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 72FA918001D2; Mon, 09 Nov 2026 00:41:14 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-89ae-7104-8471-a29bc488a93a
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXhoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184875; x=1825720875;
 bh=h06E3zBebDGKkNiR0+MMIDzb/mlZpYU2o+KvSJo9YoI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g+6Bg9wvWEGvFuWb7iDw5GdySq1L3JKxBvdBqaJ3ARjuS0z39tYWkQBI3FdgFDX+0jkub16vIrVg0k7OGuhjwaFdbjpIUwMzf6FhbFCifxj26+a4FzaKv/KrtJlR1XQp4/KpZuZWzD+Ikdxm7wwQ982CEKem34CqaSW8SEQXlTZVEQ219w7Hd2jRbnOzW2m3zOAzXqddzCCn/qacA50paKdiNg691A1SP0hGm7dw7b3XPKudKEbwBb75eK8PjDbgAiakanoHu8yVBPBWh06s1gj37iTv/F2YXTQcSc3EPYXagwUXMhCbbTw/QCFEZ0ze99ht1dw0M99Pf+yGmqy1NQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 8438918001EC; Mon, 09 Nov 2026 00:41:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PULL 02/13] target/i386/whpx: whpx_get_xsave_state error handling
Date: Sun,  8 Nov 2026 17:40:57 -0700
Message-ID: <20261109004108.85808-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=R9sO2NRX c=1 sm=1 tr=0 ts=6af116ab
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=CyeGX34NJn-RfCE8euUA:9
X-Proofpoint-ORIG-GUID: iB0pdqnkWBkkJbraYWy98gzVNFVB1fy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX7Va0nCHROqeF
 nJo4pVFHfhaD1Ti+fwDvea5dlAwJE8YX1kPK1LQe0srBpECd1SzqIB0dFSFrJuJT0dkL+jinE0z
 TRNn1sxXB69p9RY8xdwqswju7a/l8zWoAeGsiKav4QVeXE+iUzyJFxyhCeh34bA4YJN1BwKLi79
 5MMeTsHOPQP950ob71FfTHaWQGtSO4bf6DS7BJY7psio1qBSgU9H3PUuNgCNE2hYydSc6tdmqJq
 B33PSPWAYFn9o9TnWehNSBAWtudTxD1RmYE2n1Ztl0n+5lhaU9TztSrvHv1m1dHm9UXJPzpX19M
 m3aR8Mwo6F5WkqRNMJ2lUNLOIKsN8L6rQgKS4niYLLRr2P6PnipouCOg4+89lY=
X-Proofpoint-GUID: iB0pdqnkWBkkJbraYWy98gzVNFVB1fy7
X-JNJ: AAAAAAABlV02S7ppif5sNmcMTbMS525KHH5wUFhzh/uYAS9kNAtco9hZRuC5jUea/yza0I
 0dmt16VeuqdhvSUOwm6S+8mRqAmjcdoba2H6qmWLATDPp7f8RKmVwnwg4Fhhs7PMJsqxVf
 64qOhCJPlT17d48Lc/JzY9Hf4TghPcB5zT0mdK6PhuxdCNUNNaLNC0sEDsAyFw46c4mKSF
 5zj+xIqWKw/weCknbAFJznUKsCkYv2FexCvnyrlluqQyHTXsfVCKzVAMtAYfqxL1e+tmdS
 DcplPGMGtDkphTq4Roet4CA840Pq+xE6OQXHRWikEGmiPC+IfXdEFTIL+PSWnGEFqWJIs2
 LrULnXGLeMPm59kXtGm5uyXTV6nSGFqWJaQgF++kRY84r02xKDNVN4QuB5VBboDMr5W51k
 3qcrl0OxvPe0SEdwpaUhdpkcdxmRFofj7aHjzSN4T/Ac9Wf0tZJgy4L5Wkp5LNh7dO14id
 v/7okowv0Ub+KUotkLuS9B5lis/JuOEOBdTxpqZz3/56IhjShGISgwuk7upJHA0p6/KTCv
 SjhQAc0n/AVKljI8n8N5v36OcU+/oww4TSWMrVeqJaXEI9z9jjOokF1noD7VkMsZMOu/1U
 SjaW6p3Cg59KmQH3vdFa3VBkU2EcOPlU7+dsvdtglm5n7xqwQbK7eCkzfz9sZ8VxCA7txJ
 aL9UHaAf+oO0dZBOx5NtBmvHIzHpqVGIndas0khTKBfh7Pa9wN35stLfAAF4E2lWctx0mK
 5IgUrlHJkK2SYRbU5KG3Za7WpLfmydg8qBf0dgoLmGO3d0TWJbWlAmCUx2Pw==
Received-SPF: pass client-ip=2a01:b747:3005:202::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>

Several problems with error handling in whpx_get_xsave_state:

- Does not handle WHV_E_INSUFFICIENT_BUFFER, which occurs frequently
  in practice for XSAVE state.
- Does not free xsavec_buf when an error occurs.
- Error message and return code use errno where they should use hr.

Fixes: cfaa3b6c9597 ("whpx: xsave support")

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |  5 ++-
 target/i386/whpx/whpx-all.c    | 73 +++++++++++++++++++++++++---------
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index c295c5a529..b15f3d8faf 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -58,8 +58,9 @@ void whpx_apic_get(APICCommonState *s);
 
 #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
 
-/* This should eventually come from the Windows SDK */
-#define WHV_E_UNKNOWN_PROPERTY 0x80370302
+/* These should eventually come from the Windows SDK */
+#define WHV_E_INSUFFICIENT_BUFFER 0x80370301L
+#define WHV_E_UNKNOWN_PROPERTY 0x80370302L
 
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3312dd8593..f5f5c3b462 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -442,8 +442,8 @@ static int whpx_set_xsave_state(const CPUState *cpu)
 
     qemu_vfree(xsavec_buf);
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
-                     hr);
+        error_report("WHPX: Failed to set xsave state, hr=%08lx", hr);
+        return -EIO;
     }
 
     return 0;
@@ -809,9 +809,28 @@ static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
     idx += 1;
 }
 
-static int whpx_get_xsave_state(CPUState *cpu)
+static HRESULT whpx_get_xsave_state_buffer(const CPUState *cpu, void *buf,
+                                           size_t buf_len,
+                                           UINT32 *bytes_written)
 {
     struct whpx_state *whpx = &whpx_global;
+
+    if (!whpx_is_legacy_os()) {
+        return whp_dispatch.WHvGetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            buf,
+            buf_len, bytes_written);
+    } else {
+        return whp_dispatch.WHvGetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            buf,
+            buf_len, bytes_written);
+    }
+}
+
+static int whpx_get_xsave_state(CPUState *cpu)
+{
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
     int ret;
@@ -824,27 +843,43 @@ static int whpx_get_xsave_state(CPUState *cpu)
     xsavec_buf = qemu_memalign(page, xsavec_buf_len);
     memset(xsavec_buf, 0, xsavec_buf_len);
 
-    if (!whpx_is_legacy_os()) {
-        hr = whp_dispatch.WHvGetVirtualProcessorState(
-            whpx->partition, cpu->cpu_index,
-            WHvVirtualProcessorStateTypeXsaveState,
-            xsavec_buf,
-            xsavec_buf_len, &bytes_written);
-    } else {
-        hr = whp_dispatch.WHvGetVirtualProcessorXsaveState(
-            whpx->partition, cpu->cpu_index,
-            xsavec_buf,
-            xsavec_buf_len, &bytes_written);
+    bytes_written = 0;
+    hr = whpx_get_xsave_state_buffer(cpu, xsavec_buf, xsavec_buf_len,
+                                     &bytes_written);
+
+    /*
+     * whpx_get_xsave_max_len() returns the size of user state components
+     * enabled in XCR0. The hypervisor returns an XSAVES image, which also
+     * contains the supervisor state, so the whpx_get_xsave_max_len() size
+     * may be too small.
+     */
+    if (hr == WHV_E_INSUFFICIENT_BUFFER && bytes_written > xsavec_buf_len) {
+        qemu_vfree(xsavec_buf);
+        xsavec_buf_len = bytes_written;
+        xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+        memset(xsavec_buf, 0, xsavec_buf_len);
+
+        bytes_written = 0;
+        hr = whpx_get_xsave_state_buffer(cpu, xsavec_buf, xsavec_buf_len,
+                                         &bytes_written);
     }
-    if (FAILED(hr) || bytes_written == 0) {
-        error_report("failed to get xsave state: %s", strerror(errno));
-        return -errno;
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get xsave state, hr=%08lx", hr);
+        qemu_vfree(xsavec_buf);
+        return -EIO;
+    }
+
+    if (bytes_written == 0) {
+        error_report("WHPX: Failed to get xsave state, no data returned");
+        qemu_vfree(xsavec_buf);
+        return -EIO;
     }
 
-    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    ret = decompact_xsave_area(xsavec_buf, bytes_written, env);
     qemu_vfree(xsavec_buf);
     if (ret < 0) {
-        error_report("failed to decompact xsave area");
+        error_report("WHPX: Failed to decompact xsave area");
         return ret;
     }
     x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
-- 
2.54.0 (Apple Git-157)


