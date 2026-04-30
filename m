Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67929FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV8V-0002HP-K4; Thu, 30 Apr 2026 13:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8D-0001qf-SB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV88-000507-8F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxZeOnIBvXDK4VK6QGT7GENwqWSQFh2AGAwqvzAvJ/U=;
 b=YAbls7uhub8ccUuKyXQ217h3lBUWl5gAXZdFjAy+jsmycfRTxaZoEgeJY2ZLNWevh/r2hu
 pGJ4xq7L5CedNCyKHLvZdalV5TcsvT9FpDgP4RyYM2whVfbX27OMrE+bkhWbth8niIcV5x
 CcRMEVKj1fTpgEU6/J7PrTzT+cND+sY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-sQ1QgRjTOKKimIyoDtYv7g-1; Thu, 30 Apr 2026 13:24:49 -0400
X-MC-Unique: sQ1QgRjTOKKimIyoDtYv7g-1
X-Mimecast-MFC-AGG-ID: sQ1QgRjTOKKimIyoDtYv7g_1777569889
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eabf08affaso297321785a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569888; x=1778174688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxZeOnIBvXDK4VK6QGT7GENwqWSQFh2AGAwqvzAvJ/U=;
 b=AK1m6WgTco3Y2yeAzn5hKJZe4GJlVrEK5Gkr2OSBPUkd2eKU81PBAPtY/iNHs615IE
 Z7bHldMsBrxUQ2mT0qwV8XJyDslb2WCFg2MdSpnkuFIzNOJDI4YGnCRt/xY7R+37HDsS
 rTFBlXKTS3YugLKgqFY/ECmV7xp4Nd6ammTzeOVOhD4ToaqUHRa8MxOL7cum6Pn+6d5k
 p9OBGr+SrymF9DfvSGpA8Kedr8NEAZW6zpsBBRXPin6lcSj8U69aPvGQ3lFJuIriVuLB
 ddrSNYv8x3zli/wCdT2GG9OXZBj2T0Obl0W8d3kPbrL8RXuNe8APg1ZgR/mtQKahrW1a
 k23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569888; x=1778174688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxZeOnIBvXDK4VK6QGT7GENwqWSQFh2AGAwqvzAvJ/U=;
 b=NvML5emIlksqNKmT3gnKtvUOHMy0sU2LBWd1gYqKknFEOqPeO6C5EzIHpEg6wrzJGE
 ZpffTj+RkGJU7jsa9ysMuxuA4yvVV4rE9JBArymgNeV7r+1SwrX+OqdVG2CAnImX75Ts
 4axiiypQNfKhmUFxEAISyFHPoi5nA/ooILawERxLuWqq16WdHnRhGxC9BrCXNH++u2/u
 VelHtiM1+Hzck4CS8QmsvOTk8rgKIxPa3y+IZqBpX9QkY3cG5uGLiy8f23XYFbp10CCt
 iR2U6o8k8IbxhOuf6dMzPftfSwzfI0W389yR63jpk/U5MUy6x/ie/4xrlu1UM8PL4VSI
 wkjQ==
X-Gm-Message-State: AOJu0YzsSFifgGbukKuTfInMx46fFcaTZqRay/HRw2vsr9npl2GfGK70
 Ybkrnc+QVi9w3lq9xSInRyNR2p8IBqmlYFbFBwvjARpNithjfVLLllNH3xi0YtyNKORN5pS9hr+
 OmKRwp3dXswxi4sO4rbuAS+mzS7TCviBq4UMoHfJ49TehtAwr1C1++CFQCYtsYMlntrezAf87Yn
 gPSinZ5vIchTNyD5G41syWsE+Q9ktt7AnvhFtkHpGs
X-Gm-Gg: AeBDievNrYegxjH/G3zDchiA4hRpIJHeUUt/U+yKga96IvgyGkUjKx4p09+D1Ty9KFl
 92Xh8fy9Ffk38XE6Baf1MbQv2jBhC9AUZnm4qjHHwJkLZESrDXQXYdJRAHCnrzkNgcjBJEouZcS
 AIgth1tJ1AwhRXV0CBKi+l3rMLNtdgbnvTA+jzkKf+LkQeEDLei9BM85QTrYftSKxK3A8vml42w
 4Fz/09Lre2J3SCHXI5fXEmjOm48MrNgub/pv4O/8G6NxxKZrZxuvIqoLL6ynOHQOYRO+GCqpk6L
 ZUB0YqmhwgxD361bz3MbdDPA+KxcdxL52wcArf+4cR1Il+ZzePljZrRkM2/oS+IP5NrFULsuCWQ
 BDykKJG5x4zECHuP3lL6TSzu+CuDE0xvfctuVNv51gOSHdDuv8QW+Cc3zciduSzVapxobIUFMyo
 PUhd5rc+PzMo3CbUTeru2nmOPIyJitwLkzC8Q=
X-Received: by 2002:a05:620a:a2d9:20b0:8fb:1acb:ccdc with SMTP id
 af79cd13be357-8fb1acbcd8amr270207985a.34.1777569888364; 
 Thu, 30 Apr 2026 10:24:48 -0700 (PDT)
X-Received: by 2002:a05:620a:a2d9:20b0:8fb:1acb:ccdc with SMTP id
 af79cd13be357-8fb1acbcd8amr270200685a.34.1777569887449; 
 Thu, 30 Apr 2026 10:24:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb3e29f06sm23463385a.33.2026.04.30.10.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 52/58] target/i386: add de/compaction to xsave_helper
Date: Thu, 30 Apr 2026 19:21:58 +0200
Message-ID: <20260430172204.1006673-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Fixup: made xsave_offset a size_t to fix macOS and OpenBSD builds]

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-29-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h          |   2 +
 target/i386/xsave_helper.c | 256 +++++++++++++++++++++++++++++++++++++
 target/i386/meson.build    |   5 +-
 3 files changed, 260 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2a6c54dc293..ba4b1972acc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -3024,6 +3024,8 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen);
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen);
 uint32_t xsave_area_size(uint64_t mask, bool compacted);
 void x86_update_hflags(CPUX86State* env);
+int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env);
+int compact_xsave_area(CPUX86State *env, void *buf, size_t buflen);
 
 static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
 {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index bab22587320..625bae103ab 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -3,6 +3,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "cpu.h"
 
@@ -293,3 +294,258 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
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
+    size_t xsave_offset;
+    uint64_t *xcomp_bv;
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
diff --git a/target/i386/meson.build b/target/i386/meson.build
index d385eafdf7e..14b1d2977d5 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -3,14 +3,13 @@ i386_ss.add(files(
   'cpu.c',
   'gdbstub.c',
   'helper.c',
-  'xsave_helper.c',
   'cpu-dump.c',
 ))
 i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest.c'))
 
 # x86 cpu type
-i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
-i386_ss.add(when: 'CONFIG_HVF', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_KVM', if_true: files('xsave_helper.c', 'host-cpu.c'))
+i386_ss.add(when: 'CONFIG_HVF', if_true: files('xsave_helper.c', 'host-cpu.c'))
 i386_ss.add(when: 'CONFIG_WHPX', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_NVMM', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_MSHV', if_true: files('host-cpu.c'))
-- 
2.54.0


