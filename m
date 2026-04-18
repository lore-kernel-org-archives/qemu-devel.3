Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B14F99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFB-00070k-Du; Sat, 18 Apr 2026 18:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF6-0006WN-T0
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:24 -0400
Received: from p-east2-cluster1-host10-snip4-1.eps.apple.com ([57.103.76.114]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF4-0005BP-IK
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:24 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 6975B1800222; Sat, 18 Apr 2026 22:34:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551661; x=1779143661;
 bh=maUs5hD4ZFBbp6kUsVKDGtuJCsMxM+d+qMlkC+QlVLE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NThp5/HYoPDyUOJT3+ubBKmikHFhn43XdztoQp5jHgVEq2SVtw9Bkua2pwWDX2Kcvy8QTgb/bYV/0V8JrY9byFJA93fo/2GdJ5wwd6d+FfwHirXuSLhM9SGA+VEryEdJYrr7Vjbo3Ko6PXJhbXWXdyVzMISMFVUECWzJIl5MpvmtQTTLaXuOa2E0SU26aZW0ASW3NdSON0jhtAIamdbGCZ8ZVNOIEOV7me5XlVPn48ykF+R7EI2x9FZzeGp/QJ/oN8NxEvuZKkljX+6/fXs4UXHB7kzONQooB8W/CXTHEbpHHYfBVQfYhrzD89brnYfCoqKPAF4+4/NyvTqiAlUIWA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 2BC9518000B4; Sat, 18 Apr 2026 22:34:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 30/38] target/i386: add de/compaction to xsave_helper
Date: Sun, 19 Apr 2026 00:33:12 +0200
Message-ID: <20260418223320.51330-31-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZC1NUv8wdYkPaY7XBHCPs_XS3CO1jRl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfXzyvk5gwfIOGr
 X7+PW1/h6lTDlQ54kXhfCxo/3EXY0NcZxHCa+TQN3RJQkCFi+hQKDZWTT+9QOD7C9WTlcOGXTXe
 ChaI3aHf026ab5H70y3aMdFYdNfpCnKcfA5NjVuY1bTkxs5ckbzPQZ4TwsniZWEoOdaRicYOZYU
 sG383F9rv5FgH9S0KnRnqizsdD4HcylBXKGLxHKghPwuURGQO1vHq82ViPpknv9ZupNnvmlo7fG
 YUkSoaCVunOJQbzt1lNVFUt7ApmhwWfCN+leunIMoBhDaCDiq1M2I1ko/BtK/ctU0xXMnsWCxbB
 hJ9R15W3feZJs/ig2wRj5uG4RAvquGGGSnEZHrw4KZZzVpy/uQw3zXLqY+BPfA=
X-Authority-Info-Out: v=2.4 cv=QPllhwLL c=1 sm=1 tr=0 ts=69e406ed
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=SWS4GvfA19jorXXodEoA:9
X-Proofpoint-GUID: ZC1NUv8wdYkPaY7XBHCPs_XS3CO1jRl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1030 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

HyperV use XSAVES which stores extended state in compacted format in
which components are packed contiguously, while QEMU's internal XSAVE
representation use the standard format in which each component is places
at a fixed offset. Hence for this purpose we add two conversion fn's to
the xsave helper to roundtrip XSAVE state in a migration.

- decompact_xsave_area(): converts compacted format to standard.
  XSTATE_BV is masked to host XCR0 since IA32_XSS is managed
  by the hypervisor.

- compact_xsave_area(): converts standard format back to compacted
  format. XCOMP_BV is set from the host's CPUID 0xD.0 rather than the
  guest's XCR0, as this is what the hypervisor expects.

Both functions use the host's CPUID leaf 0xD subleaves to determine component
sizes, offsets, and alignment requirements.

There are situations when the host advertises features that we want to
disable for the guest, e.g. AMX TILE. In this case we cannot rely on the
host's xcr0, but instead we use the feature mask that has been generated
in as part of the CPU realization process (x86_cpu_expand_features).

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.h          |   2 +
 target/i386/xsave_helper.c | 255 +++++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0af7bdf85a..80cdc1cb2a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -3023,6 +3023,8 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen);
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen);
 uint32_t xsave_area_size(uint64_t mask, bool compacted);
 void x86_update_hflags(CPUX86State* env);
+int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env);
+int compact_xsave_area(CPUX86State *env, void *buf, size_t buflen);
 
 static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
 {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index bab2258732..2272b83f5f 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -3,6 +3,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "cpu.h"
 
@@ -293,3 +294,257 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
     }
 #endif
 }
+
+#define XSTATE_BV_IN_HDR  offsetof(X86XSaveHeader, xstate_bv)
+#define XCOMP_BV_IN_HDR   offsetof(X86XSaveHeader, xcomp_bvo)
+
+typedef struct X86XSaveAreaView {
+    /* 512 bytes */
+    X86LegacyXSaveArea legacy;
+    /* 64 bytes */
+    X86XSaveHeader     header;
+    /* ...followed by individual xsave areas */
+} X86XSaveAreaView;
+
+#define XSAVE_XSTATE_BV_OFFSET  offsetof(X86XSaveAreaView, header.xstate_bv)
+#define XSAVE_XCOMP_BV_OFFSET   offsetof(X86XSaveAreaView, header.xcomp_bv)
+#define XSAVE_EXT_OFFSET        (sizeof(X86LegacyXSaveArea) + \
+                                 sizeof(X86XSaveHeader))
+
+/**
+ * decompact_xsave_area - Convert compacted XSAVE format to standard format
+ * @buf: Source buffer containing compacted XSAVE data
+ * @buflen: Size of source buffer
+ * @env: CPU state where the standard format buffer will be written to
+ *
+ * Accelerator backends like MSHV might return XSAVE state in compacted format
+ * (XSAVEC). The state components have to be packed contiguously without gaps.
+ * The XSAVE qemu buffers are in standard format where each component has a
+ * fixed offset.
+ *
+ * Returns: 0 on success, negative errno on failure
+ */
+int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
+{
+    uint64_t compacted_xstate_bv, compacted_xcomp_bv, compacted_layout_bv;
+    uint64_t xsave_offset, *xcomp_bv;
+    size_t i;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t size, dst_off;
+    bool align64;
+    uint64_t guest_xcr0, *xstate_bv;
+
+    compacted_xstate_bv = *(uint64_t *)(buf + XSAVE_XSTATE_BV_OFFSET);
+    compacted_xcomp_bv  = *(uint64_t *)(buf + XSAVE_XCOMP_BV_OFFSET);
+
+    /* This function only handles compacted format (bit 63 set) */
+    assert((compacted_xcomp_bv >> 63) & 1);
+
+    /* Low bits of XCOMP_BV describe which components are in the layout */
+    compacted_layout_bv = compacted_xcomp_bv & ~(1ULL << 63);
+
+    /* Zero out buffer, then copy legacy region (FP + SSE) and header as-is */
+    memset(env->xsave_buf, 0, env->xsave_buf_len);
+    memcpy(env->xsave_buf, buf, XSAVE_EXT_OFFSET);
+
+    /*
+     * We mask XSTATE_BV with the guest's supported XCR0 because:
+     * 1. Supervisor state (IA32_XSS) is hypervisor-managed, we don't use
+     *    this state for migration.
+     * 2. Features disabled at partition creation (e.g. AMX) must be excluded
+     */
+    guest_xcr0 = ((uint64_t)env->features[FEAT_XSAVE_XCR0_HI] << 32) |
+                 env->features[FEAT_XSAVE_XCR0_LO];
+    xstate_bv = (uint64_t *)(env->xsave_buf + XSAVE_XSTATE_BV_OFFSET);
+    *xstate_bv &= guest_xcr0;
+
+    /* Clear bit 63 - output is standard format, not compacted */
+    xcomp_bv = (uint64_t *)(env->xsave_buf + XSAVE_XCOMP_BV_OFFSET);
+    *xcomp_bv = *xcomp_bv & ~(1ULL << 63);
+
+    /*
+     * Process each extended state component in the compacted layout.
+     * Components 0 and 1 (FP and SSE) are in the legacy region, so we
+     * start at component 2. For each component:
+     * - Calculate its offset in the compacted source (contiguous layout)
+     * - Get its fixed offset in the standard destination from CPUID
+     * - Copy if the component has non-init state (bit set in XSTATE_BV)
+     */
+    xsave_offset = XSAVE_EXT_OFFSET;
+    for (i = 2; i < 63; i++) {
+        if (((compacted_layout_bv >> i) & 1) == 0) {
+            continue;
+        }
+
+        /* Query guest CPUID for this component's size and standard offset */
+        cpu_x86_cpuid(env, 0xD, i, &eax, &ebx, &ecx, &edx);
+
+        size = eax;
+        dst_off = ebx;
+        align64 = (ecx & (1u << 1)) != 0;
+
+        /* Component is in the layout but unknown to the guest CPUID model */
+        if (size == 0) {
+            /*
+             * The hypervisor might expose a component that has no
+             * representation in the guest CPUID model. We query the host to
+             * retrieve the size of the component, so we can skip over it.
+             */
+            host_cpuid(0xD, i, &eax, &ebx, &ecx, &edx);
+            size = eax;
+            align64 = (ecx & (1u << 1)) != 0;
+            if (size == 0) {
+                error_report("xsave component %zu: size unknown to both "
+                             "guest and host CPUID", i);
+                return -EINVAL;
+            }
+
+            if (align64) {
+                xsave_offset = QEMU_ALIGN_UP(xsave_offset, 64);
+            }
+
+            if (xsave_offset + size > buflen) {
+                error_report("xsave component %zu overruns source buffer: "
+                             "offset=%zu size=%u buflen=%zu",
+                             i, xsave_offset, size, buflen);
+                return -E2BIG;
+            }
+
+            xsave_offset += size;
+            continue;
+        }
+
+        if (align64) {
+            xsave_offset = QEMU_ALIGN_UP(xsave_offset, 64);
+        }
+
+        if ((xsave_offset + size) > buflen) {
+            error_report("xsave component %zu overruns source buffer: "
+                         "offset=%zu size=%u buflen=%zu",
+                         i, xsave_offset, size, buflen);
+            return -E2BIG;
+        }
+
+        if ((dst_off + size) > env->xsave_buf_len) {
+            error_report("xsave component %zu overruns destination buffer: "
+                         "offset=%u size=%u buflen=%zu",
+                         i, dst_off, size, (size_t)env->xsave_buf_len);
+            return -E2BIG;
+        }
+
+        /* Copy components marked present in XSTATE_BV to guest model */
+        if (((compacted_xstate_bv >> i) & 1) != 0) {
+            memcpy(env->xsave_buf + dst_off, buf + xsave_offset, size);
+        }
+
+        xsave_offset += size;
+    }
+
+    return 0;
+}
+
+/**
+ * compact_xsave_area - Convert standard XSAVE format to compacted format
+ * @env: CPU state containing the standard format XSAVE buffer
+ * @buf: Destination buffer for compacted XSAVE data (to send to hypervisor)
+ * @buflen: Size of destination buffer
+ *
+ * Accelerator backends like MSHV might expect XSAVE state in compacted format
+ * (XSAVEC). The state components are packed contiguously without gaps.
+ * The XSAVE qemu buffers are in standard format where each component has a
+ * fixed offset.
+ *
+ * This function converts from standard to compacted format, it accepts a
+ * pre-allocated destination buffer of sufficient size, it is the
+ * responsibility of the caller to ensure the buffer is big enough.
+ *
+ * Returns: total size of compacted XSAVE data written to @buf
+ */
+int compact_xsave_area(CPUX86State *env, void *buf, size_t buflen)
+{
+    uint64_t *xcomp_bv;
+    size_t i;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t size, src_off;
+    bool align64;
+    size_t compact_offset;
+    uint64_t host_xcr0_mask, guest_xcr0;
+
+    /* Zero out buffer, then copy legacy region (FP + SSE) and header as-is */
+    memset(buf, 0, buflen);
+    memcpy(buf, env->xsave_buf, XSAVE_EXT_OFFSET);
+
+    /*
+     * Set XCOMP_BV to indicate compacted format (bit 63) and which
+     * components are in the layout.
+     *
+     * We must explicitly set XCOMP_BV because x86_cpu_xsave_all_areas()
+     * produces standard format with XCOMP_BV=0 (buffer is zeroed and only
+     * XSTATE_BV is set in the header).
+     *
+     * XCOMP_BV must reflect the partition's XSAVE capability, not the
+     * guest's current XCR0 (env->xcr0). These differ b/c:
+     * - A guest's XCR0 is what the guest OS has enabled via XSETBV
+     * - The partition's XCR0 mask is the hypervisor's save/restore capability
+     *
+     * The hypervisor uses XSAVES which saves based on its capability, so the
+     * XCOMP_BV value in the buffer we send back must match that capability.
+     *
+     * We intersect the host XCR0 with the guest's supported XCR0 features
+     * (FEAT_XSAVE_XCR0_*) so that features disabled at partition creation
+     * (e.g. AMX) are excluded from the compacted layout.
+     */
+    host_cpuid(0xD, 0, &eax, &ebx, &ecx, &edx);
+    host_xcr0_mask = ((uint64_t)edx << 32) | eax;
+    guest_xcr0 = ((uint64_t)env->features[FEAT_XSAVE_XCR0_HI] << 32) |
+                 env->features[FEAT_XSAVE_XCR0_LO];
+    host_xcr0_mask &= guest_xcr0;
+    xcomp_bv = buf + XSAVE_XCOMP_BV_OFFSET;
+    *xcomp_bv = host_xcr0_mask | (1ULL << 63);
+
+    /*
+     * Process each extended state component in the host's XCR0.
+     * The compacted layout must match XCOMP_BV (host capability).
+     *
+     * For each component:
+     * - Get its size and standard offset from host CPUID
+     * - Apply 64-byte alignment if required
+     * - Copy data only if guest has this component (bit set in env->xcr0)
+     * - Always advance offset to maintain correct layout
+     */
+    compact_offset = XSAVE_EXT_OFFSET;
+    for (i = 2; i < 63; i++) {
+        if (!((host_xcr0_mask >> i) & 1)) {
+            continue;
+        }
+
+        /* Query host CPUID for this component's size and standard offset */
+        host_cpuid(0xD, i, &eax, &ebx, &ecx, &edx);
+        size = eax;
+        src_off = ebx;
+        align64 = (ecx >> 1) & 1;
+
+        if (size == 0) {
+            /* Component in host xcr0 but unknown - shouldn't happen */
+            continue;
+        }
+
+        /* Apply 64-byte alignment if required by this component */
+        if (align64) {
+            compact_offset = QEMU_ALIGN_UP(compact_offset, 64);
+        }
+
+        /*
+         * Only copy data if guest has this component enabled in XCR0.
+         * Otherwise the component remains zeroed (init state), but we
+         * still advance the offset to maintain the correct layout.
+         */
+        if ((env->xcr0 >> i) & 1) {
+            memcpy(buf + compact_offset, env->xsave_buf + src_off, size);
+        }
+
+        compact_offset += size;
+    }
+
+    return compact_offset;
+}
-- 
2.50.1 (Apple Git-155)


