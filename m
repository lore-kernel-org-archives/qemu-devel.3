Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FE606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=jEFRFFBw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZv-0001zu-Q5; Tue, 27 Oct 2026 11:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYh-0000uJ-Ci
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:59 -0400
Received: from ci-2002b-snip6-11.eps.apple.com ([2a01:b747:3005:206::17]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYa-0005kT-0l
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:49 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 6D200180015E; Tue, 27 Oct 2026 15:57:45 +0000 (UTC)
X-ICL-RepId: 01a17e14-f613-78f0-b147-fb3e4de34c84
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116667; x=1824652667;
 bh=x6QpE31YHSYm3IN5HGzUQG5BULloTc4Z+l5HgHvxa6Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=jEFRFFBwpXd2DMQrJnzE1Q8AlIgqvDsPtxtPqxnOh3uEKTc0oQ6zuq7PgwoWsuwJQKSR4EZduzUq+ofARFoMc9C5e8ygkHIdhpRg2KCwPabXtLTUAZnsMkK0h7cgqSwugM7l+O6UoBY1e0cluHTk1jBzdGNcVt0qygHHeBBNYy1C+c2sXP8LqUl4g4DLZj7NTdXqI/EnyPZjr5N23UUDB6BuMJ57WtlYFQ4kLDP/sH/8XrMXaWQfHnAzEpE4evQiqufkuhGZdzjMxPhub4v6UOeblu+7pW2uNsrtmIZcZzphaX/aXvZH10hR8i1ly4xt/k+QlZ2XhG7b7lT7di5oLg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 5774A18004AF; Tue, 27 Oct 2026 15:57:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PATCH v2 02/18] target/i386/whpx: whpx_get_xsave_state error handling
Date: Tue, 27 Oct 2026 16:57:21 +0100
Message-ID: <20261027155737.59271-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=f8hFxeyM c=1 sm=1 tr=0 ts=6ae0c9fa
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=CyeGX34NJn-RfCE8euUA:9
X-Proofpoint-GUID: ROyJbfVHzrtZB_5Oit-_C7PY9EVNoJhk
X-Proofpoint-ORIG-GUID: ROyJbfVHzrtZB_5Oit-_C7PY9EVNoJhk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX/YJ7GwVUAnad
 IMpKV0nX27dJCbMtyTzWX0nJBsxlz6Gwg7ylRZTPsdqTwOkjA3L/29xapnuKU+GonLXiKPJMstj
 qW8nT5nKVI+Xqx0PkJr/+xITRgz1lNCwlbayzptyQKn4prJPRq7EzdE75cAbHBmi/Z9aTMYRxfZ
 XdBauyZTOgIqD+Cnofhj7iPver3lJiUSKp6fYXCqOlTgyJa/0LEToaOdOy8fC867SQvuRUqLm8Y
 bEzf0/vQ4egFUBeruTAJl0bKCm8ig8YtclxlmcExdHIArOuf6PqbIfQ3QA4oJzn5l6MkzjVpb+x
 JEkMkasin7B7yQ8GVT4XaCqbBnSHjH1h3seQXQhPwcGdpWiwNASw88nZFY6rO4=
X-JNJ: AAAAAAABMyChzEYDyXjHvZB6oJrors1IrreOH0yOu632Zv06ULR4oFAzMXPPC8ECD0J9qjVPVnZ1DFI8l6+BIIysSdEd/OCRVREREWCbMtcnxPjGM1hc6OEIgXdYjdDfMZiLeRhFcNFfiDAYfDyiHKeA9j1zoG4KkzDAoH/SWgFo5HMv2ew0WKXhP25EHU6zhuvpAHuqgVemoFhHMGZ9ZmF35JNTsQ1HmZgpDwK0CtFmu4SBMPMHjrwa6mgNdaHs0VxlxCQeMSZ64lskAtPUrZLnJsbEUV+x1EpTMJJnEMqboXkmp31B6a1yXveO1dpDnKyGPUBkCL2YGon5eBATqh0ImaJIv5FqO4pKi5ytzHKuzQ5CB9WxDFDcmG58oNXhPkgOaZJX6opeS3EJSLFvcw4lEzkvRLC3r/Zl8JwFPxirORyJTol67k03KPDzKJ6CefSBHw81Ud7RGzj5n3/KNQ8eYDYtClDThNBhmWhZvprvqeTkDYZsh2kjGECU/NEURWANZgtT41Xqw/H6OMd9txjMvdHJUwPtPlZvocC+oUuuzE+ZfFbX7DcLD6AjxbAMPKsWY5uGEuyt1SPbCMomMGM1FYKkEZXcOAxAMUwsLWAN46N6LfuaTmCluY7Qpi8+KUd2Ob4SC+PTvfgdo9+LLTsDoerc2xtVHqZWMBlEUlYi9eER6TRFBR9CIziO77TZft+9T1FOU4GoPZIouymzVE06NBOAKFuNPgUSKQIUosGRYR6A/biXCmb43Uz6ygjMHqD3tYJ+tYXvlGdqmF2Lz6t+Z69CGtF7G5GhS5Xd0GNe7091vu04N1Y=
Received-SPF: pass client-ip=2a01:b747:3005:206::17;
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


