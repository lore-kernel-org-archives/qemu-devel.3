Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E65606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=FLWFzTeC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2hc-0003Ph-W9; Thu, 22 Oct 2026 20:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2hZ-0003Iu-5t
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 20:00:06 -0400
Received: from mr-2005l-snip6-6.eps.apple.com ([2a01:b747:3000:206::75]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2hX-0002FW-2H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 20:00:04 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 4921C18001E9; Thu, 22 Oct 2026 23:59:07 +0000 (UTC)
X-ICL-RepId: 01a1660d-dde2-7469-807f-9a27ee7f3d2c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713601; x=1824249601;
 bh=x6QpE31YHSYm3IN5HGzUQG5BULloTc4Z+l5HgHvxa6Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FLWFzTeClE7Nt1ArXeFeDtGZrO+ogDoNNRcW0s6Xp98LjKmIF+PBbJ6P7sYihcJuejn/THM5yxYti0RtEtNKMupO67EFyKEhMJY1IsqUnnbcSTauVcYRO0kesj2nQVFjbPoXEsRk6NISR01y7NITYWS8UIiEjIzL/lSl9G9zX0vbfKDx/LtyOtu0oH+ehHDg92ksKwLhYkspsO0sTyfkYsEr9LGtz3ows4Jk7cVh1PnUM/yBxN8Z2ykdMYG6iVVWy0Yhq6ZJ6SkSItktm8dCx4m5bkgAaCgsXD49jt/d6Un7mg8WunINc5Z0DWccICmiaTgc68J1ClGVAb+MD9nXiA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 6EE341800134; Thu, 22 Oct 2026 23:59:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PATCH 02/11] target/i386/whpx: whpx_get_xsave_state error handling
Date: Fri, 23 Oct 2026 01:58:50 +0200
Message-ID: <20261022235859.88753-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jz1C0U3JhQ5yaOokW_xdll9rf42s_aZs
X-Authority-Info-Out: v=2.4 cv=LJFrgZW9 c=1 sm=1 tr=0 ts=6adaa34b
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=CyeGX34NJn-RfCE8euUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX+xv1Ju3rp6dA
 qPQhAxwUKyTbiXceUjcAO1X4lDArm066sectl1mfI8LilA3bKf4YePV0jOkWNW9Ls23pAinOy8v
 3Jk39LLywvU5BvnMvlcSrqnezrz/57mGRu9wFasLui5VoltPmwjSwnCQhUdGmoMfT2dcWg5gNTm
 A4n/jIAguHBbGfXILzcXZ6Pp5VxUwZgFAl0FYBDbrWZYlRnksfa5JJFbbMUJReag34aClThD9qk
 gGMrqyUr8pJZxlFEqSD0geYAx/sehfLF2wXE1I/aLDeOei6pdzP66NAGU7Dk1D5mf+7Cz8pmMEN
 /S//r8zWKIjS8FPydI2WM/AsRHTN55v6sBfiKgqvSyvwrxuyYmw05PPN5Gewnk=
X-Proofpoint-GUID: jz1C0U3JhQ5yaOokW_xdll9rf42s_aZs
X-JNJ: AAAAAAABuXesWyQYFwYpNjHUs1yNlIX3ChppcEbc/CMTJX1w2wg+eifHmWy+w+10Mr4VoMIahdw+L06Jenyf0CiZb1HYGThmpOVfmQYCmHLtkiziN8oGp+W1HHB42dyQ8ytKY1mpu9DalHyYNyLMB4SvsHLi0ruVEOOjhQidQjIf7YCQ4PyreI8ahBCr5cCbjV23Cn0BIONjz22z1CnwPqYMI6XGuy/UPQ95Gaf1661BaoLdoMNS3SW9OQYfCqnijuWSIPz/ofxlImR8UB1eGLO0vqUGeMbIrm/4hfe3tJ6PF5PxTgd81Mn3lHd2SLqAZaVSS53N51HRPrpzle4PZLtKgt2JOoqA2uSCctayvcCJURgWK2uV6qmt8AQmb1KllWKs0Iv+PVhBUYsidfkVhRpviwiqjVvAJaJqjXRdZkqWnpxGLqFDTLGi7UxBGCEbs96WRuXpMazW5AYukbqjkjQmlviF31XSrVyuQLptcMznq0hk+A1IHAKe/vi2a+6ck57fPe2lVQEMOmL8TGpZjwduRbL7jNFRQQ8YIQKNXmm8unbXC/SdFxWHlBtINCTx2NfrPI9ox4DULUGcZ/mpFREzK0idbNFmNncpnDn+h1xDLDNhw3FUt0708I3LR4SeIWMx2j083e3U3tla2Bt0wkM7qgnyri9spDSI+IxYizcCzqUOsVI28fs3HLNb/tWdKcWPCzKQYdwbuDfuO1RYSS2ljbmsCkqsPAAx54yS04IZ80tb+aFXg9jdbfzJmpIzPYcI4ncApGbrSs/HRfdJzcLSfwBCWn82obU+eYKY7mT3
Received-SPF: pass client-ip=2a01:b747:3000:206::75;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
index 1386affa9c..68272c5657 100644
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


