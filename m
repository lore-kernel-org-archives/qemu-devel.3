Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D18606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=FkBX6Q6+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZv-00020b-Qr; Tue, 27 Oct 2026 11:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYr-0000yT-6F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:09 -0400
Received: from ci-2002e-snip6-8.eps.apple.com ([2a01:b747:3005:206::33]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYm-0005mh-TW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:04 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 98C7D1800F5F; Tue, 27 Oct 2026 15:57:57 +0000 (UTC)
X-ICL-RepId: 01a17e15-25a0-7715-a13d-36bab5418d0e
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZZHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116679; x=1824652679;
 bh=ir7cAigVpd7VDYHnidyAwSXGHXAFs9/Ccdek5eoTA2w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FkBX6Q6+RQW4hd+naxmC6j6FTiGyPUT+/y3GIGcST+HKpK4d2rdE5DrcuNewrqBYcFl998ZbfMrR4iubIXAfTxOasFHOYs+dRRrdQYv0nVeAIJZlWL/BDoH+5WcGssxzjNaF/H4mjvRIbJ8MN/LXXD5AlADFiW77IVwXBbRF3s8txXJUgfhAw6/uta2UPx6T2LhI5+Trk8thHEHdVQpTVjdvpOniBJKJ7lxPW1GLom0qXir9amlaUaV3sdNy0EgMYj4CJalQRyLuNRLO+tY9OhVh1qUeDVOegl12u9gef1U7BNIldSlQfniv3zoak6+hB+na/6ExQ5UVVBOK+hksvg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 E0B53180010D; Tue, 27 Oct 2026 15:57:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 11/18] whpx: apic: migrate APIC implementation to new
 interface
Date: Tue, 27 Oct 2026 16:57:30 +0100
Message-ID: <20261027155737.59271-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX006HFoXqtdSu
 w9G3rBBEm9tHPFhMSmPvJbK3qoVSk6ebqIbL2FwWlxuqlubsuQJI5Ox0JyYkSsvB5zSd+bdBAlE
 wPRcewqyTPfe4Ngf/2fx1l9C5LUyok9arpE3+KNcgaVOuqAZxkz+et0Jaix5C7Skkf0dBfVsM2P
 6x1cDME/nTPd1KjkLT5e/lMZOkP5QFFBrCxjfCCH6pNXWwu1tGNHrs1ltU6yNVwsa4VjQvrKN8x
 FOs3DjsxyZuNBJSCwEeS0OOaVUYewV1u8gpQEaeDcAOn/WbrenMbOPkRKSx8tNWrIEy2Jn80Xvy
 6DOkhWEOb5Y6NGRBXfnQs5m2/AEmusGvhN4kYWEPlUPBMIieJkxS/BIPpaLk0s=
X-Proofpoint-ORIG-GUID: eVUU2eWdd3VN28NH8ZVGf0pzfmp3rhdy
X-Authority-Info-Out: v=2.4 cv=YaGwJgRf c=1 sm=1 tr=0 ts=6ae0ca06
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M0LOW7VbZ4QrGt4_3X8A:9
X-Proofpoint-GUID: eVUU2eWdd3VN28NH8ZVGf0pzfmp3rhdy
X-JNJ: AAAAAAAB+YDgcdEduBUxsvpSsvGNEPetYOrJpozwjZF/P5an7d6tiS16FnjHA7ZI//yAZl6woZ+Wne6TaQoATTe/C5RT7HkJ1gvylsRNbHgwNtiH+QoxSDZduX1suZHtqrS36Ckej4DZykcVLEQzxRRi2Ei+GR//mdGcCHiLbtUrAr9QcVG73h4zo7nu01VprW8/j+PyY086L2EL4vhZ/7FvKBSgzpdABiC0T6hysAwAa+rBOOgCoXBt/nFLrAav9mXBaIqE9ysVGMOFkeTQycktBmLyk45EUu9yKp68I3SNVE/TWAo7sF0o7iuas5nwLDTnBz+1qaXJgWgSZbMLbBZ/TMz9dBSYZa2yUv0VExg4/svIqfH1SkkDC/BVeRX76fkMDGldWx/I/q2rkAuSiU22062gR8qTCH0o3xcOxqGCdF/abkvONRpXbpDz8/Km1uaoKpEbcZPwaPrs3GfBIY1xRm46wE5Jx/qzAyoZxI41hYGihPordrA6JTbuzPFyC10BMnHRNSNFaoPv2DALVIFhPgXzKJFcBRODrtmmVwCKbAc88/h9Xm6ofL1LWnvYaXJZ7/teJaE7nk4lMzvxN9bkTEBSEfhwhULqu/8pho9TvOjdUizjXp2miMfXS+WMc+W0Pm7Mipbj58LVUU50ZxgYLijwbbEEpUOhxAPXT3W4fAA2FwSO2iIAcKupXoZCb2o81WbWPgh4KnkReGAwbs8BSeu+ib+SJxIZZXpBmDFRbHpYXERVhVrAi59vgX7dzqpd9SBlzUi5j+xLzWGKvXQ6H6ljYiisVGKG0+LHEYl8zK1h
Received-SPF: pass client-ip=2a01:b747:3005:206::33;
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

Using the translation logic from the MSHV backend.

The new API is only available on Windows 10 20H2 onwards.
Retain the older interface for backwards compatibility.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |   1 +
 target/i386/whpx/whpx-all.c    |   2 +
 target/i386/whpx/whpx-apic.c   | 297 ++++++++++++++++++++++++++++++++-
 3 files changed, 292 insertions(+), 8 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index b15f3d8faf..136ad88872 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -55,6 +55,7 @@ struct whpx_state {
 
 extern struct whpx_state whpx_global;
 void whpx_apic_get(APICCommonState *s);
+int whpx_apic_init_cpu(CPUState *cpu);
 
 #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6b00724ceb..4d4ad0919f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2969,6 +2969,8 @@ int whpx_init_vcpu(CPUState *cpu)
     header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
     header->xcomp_bv = header->xstate_bv | (1ULL << 63);
 
+    whpx_apic_init_cpu(cpu);
+
     return 0;
 
 error:
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 2d83291fae..34d5d57ad2 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -13,12 +13,32 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
+#include "migration/vmstate.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/pci/msi.h"
 #include "system/hw_accel.h"
 #include "system/whpx.h"
 #include "system/whpx-internal.h"
+#include "target/i386/whpx/whpx-i386.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "qemu/memalign.h"
+
+typedef struct hv_local_interrupt_controller_state
+               hv_local_interrupt_controller_state;
+
+struct MshvAPICState {
+    APICCommonState parent_obj;
+
+    uint32_t apic_version;
+    uint32_t apic_lvt_cmci;
+    uint32_t apic_error_status;
+    uint32_t apic_counter_value;
+    uint32_t apic_remote_read;
+};
+
+#define TYPE_MSHV_APIC "whpx-apic"
+OBJECT_DECLARE_SIMPLE_TYPE(MshvAPICState, MSHV_APIC)
 
 struct whpx_lapic_state {
     struct {
@@ -27,7 +47,106 @@ struct whpx_lapic_state {
     } fields[256];
 };
 
-static void whpx_put_apic_state(APICCommonState *s,
+static void populate_hv_lapic_state(hv_local_interrupt_controller_state *hv,
+                                    const CPUState *cpu)
+{
+    uint32_t x2apic_id;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    MshvAPICState *ms = MSHV_APIC(x86cpu->apic_state);
+    APICCommonState *s = &ms->parent_obj;
+    size_t i;
+
+    /*
+     * x2APIC:
+     * - APIC ID is the full 32-bit initial_apic_id
+     * - LDR is read-only, architecturally derived from the ID
+     * - DFR does not exist in x2APIC mode
+     */
+    if (is_x2apic_mode(s)) {
+        x2apic_id = s->initial_apic_id;
+
+        hv->apic_id  = x2apic_id;
+        hv->apic_ldr = ((x2apic_id >> 4) << 16) | (1 << (x2apic_id & 0xf));
+        hv->apic_dfr = 0;
+    } else {
+        hv->apic_id  = s->id << 24;
+        hv->apic_ldr = s->log_dest << 24;
+        hv->apic_dfr = s->dest_mode << 28 | 0x0fffffff;
+    }
+    hv->apic_version = ms->apic_version;
+    hv->apic_spurious = s->spurious_vec;
+    for (i = 0; i < 8; i++) {
+        hv->apic_isr[i] = s->isr[i];
+        hv->apic_tmr[i] = s->tmr[i];
+        hv->apic_irr[i] = s->irr[i];
+    }
+    hv->apic_esr      = s->esr;
+    hv->apic_icr_high = s->icr[1];
+    hv->apic_icr_low  = s->icr[0];
+
+    hv->apic_lvt_timer   = s->lvt[APIC_LVT_TIMER];
+    hv->apic_lvt_thermal = s->lvt[APIC_LVT_THERMAL];
+    hv->apic_lvt_perfmon = s->lvt[APIC_LVT_PERFORM];
+    hv->apic_lvt_lint0   = s->lvt[APIC_LVT_LINT0];
+    hv->apic_lvt_lint1   = s->lvt[APIC_LVT_LINT1];
+    hv->apic_lvt_error   = s->lvt[APIC_LVT_ERROR];
+    hv->apic_lvt_cmci    = ms->apic_lvt_cmci;
+
+    hv->apic_error_status         = ms->apic_error_status;
+    hv->apic_initial_count        = s->initial_count;
+    hv->apic_counter_value        = ms->apic_counter_value;
+    hv->apic_divide_configuration = s->divide_conf;
+    hv->apic_remote_read          = ms->apic_remote_read;
+}
+
+static void populate_apic_state(CPUState *cpu,
+                                const hv_local_interrupt_controller_state *hv)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    MshvAPICState *ms = MSHV_APIC(x86cpu->apic_state);
+    APICCommonState *s = &ms->parent_obj;
+    size_t i;
+
+    /*
+     * x2APIC:
+     * - APIC ID is the full 32-bit initial_apic_id
+     * - LDR is read-only, architecturally derived from the ID
+     * - DFR does not exist in x2APIC mode
+     */
+    if (is_x2apic_mode(s)) {
+        s->initial_apic_id = hv->apic_id;
+    } else {
+        s->id        = hv->apic_id  >> 24;
+        s->log_dest  = hv->apic_ldr >> 24;
+        s->dest_mode = hv->apic_dfr >> 28;
+    }
+    ms->apic_version = hv->apic_version;
+    s->spurious_vec = hv->apic_spurious;
+    for (i = 0; i < 8; i++) {
+        s->isr[i] = hv->apic_isr[i];
+        s->tmr[i] = hv->apic_tmr[i];
+        s->irr[i] = hv->apic_irr[i];
+    }
+    s->esr = hv->apic_esr;
+    s->icr[1] = hv->apic_icr_high;
+    s->icr[0] = hv->apic_icr_low;
+
+    s->lvt[APIC_LVT_TIMER]   = hv->apic_lvt_timer;
+    s->lvt[APIC_LVT_THERMAL] = hv->apic_lvt_thermal;
+    s->lvt[APIC_LVT_PERFORM] = hv->apic_lvt_perfmon;
+    s->lvt[APIC_LVT_LINT0]   = hv->apic_lvt_lint0;
+    s->lvt[APIC_LVT_LINT1]   = hv->apic_lvt_lint1;
+    s->lvt[APIC_LVT_ERROR]   = hv->apic_lvt_error;
+    ms->apic_lvt_cmci        = hv->apic_lvt_cmci;
+
+    ms->apic_error_status  = hv->apic_error_status;
+    s->initial_count       = hv->apic_initial_count;
+    ms->apic_counter_value = hv->apic_counter_value;
+    s->divide_conf         = hv->apic_divide_configuration;
+    ms->apic_remote_read   = hv->apic_remote_read;
+}
+
+static void whpx_put_apic_state_legacy(APICCommonState *s,
                                 struct whpx_lapic_state *kapic)
 {
     int i;
@@ -60,7 +179,7 @@ static void whpx_put_apic_state(APICCommonState *s,
     kapic->fields[0x3e].data = s->divide_conf;
 }
 
-static void whpx_get_apic_state(APICCommonState *s,
+static void whpx_get_apic_state_legacy(APICCommonState *s,
                                 struct whpx_lapic_state *kapic)
 {
     int i, v;
@@ -197,14 +316,14 @@ static void whpx_apic_vapic_base_update(APICCommonState *s)
     /* not implemented yet */
 }
 
-static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
+static void whpx_apic_put_legacy(CPUState *cs, run_on_cpu_data data)
 {
     APICCommonState *s = data.host_ptr;
     struct whpx_lapic_state kapic;
     HRESULT hr;
 
     whpx_put_apic_base(CPU(s->cpu), s->apicbase);
-    whpx_put_apic_state(s, &kapic);
+    whpx_put_apic_state_legacy(s, &kapic);
 
     hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
         whpx_global.partition,
@@ -220,7 +339,7 @@ static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
     }
 }
 
-void whpx_apic_get(APICCommonState *s)
+static void whpx_apic_get_legacy(APICCommonState *s)
 {
     CPUState *cpu = CPU(s->cpu);
     struct whpx_lapic_state kapic;
@@ -239,7 +358,78 @@ void whpx_apic_get(APICCommonState *s)
         abort();
     }
 
-    whpx_get_apic_state(s, &kapic);
+    whpx_get_apic_state_legacy(s, &kapic);
+}
+
+static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
+{
+    MshvAPICState *s = data.host_ptr;
+    struct hv_local_interrupt_controller_state kapic;
+    HRESULT hr;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer;
+    size_t size = 4096;
+
+    if (!whp_dispatch.WHvSetVirtualProcessorState) {
+        return whpx_apic_put_legacy(cs, data);
+    }
+
+    buffer = qemu_memalign(size, size);
+    whpx_put_apic_base(CPU(s->parent_obj.cpu), s->parent_obj.apicbase);
+    populate_hv_lapic_state(&kapic, cs);
+    memcpy(buffer, &kapic, sizeof(kapic));
+
+    hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx_global.partition,
+            cs->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            buffer,
+            size);
+
+    qemu_vfree(buffer);
+    if (FAILED(hr)) {
+        fprintf(stderr,
+            "WHvSetVirtualProcessorState failed: %08lx\n",
+             hr);
+
+        abort();
+    }
+}
+
+void whpx_apic_get(APICCommonState *s)
+{
+    CPUState *cpu = CPU(s->cpu);
+    struct hv_local_interrupt_controller_state kapic;
+    HRESULT hr;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer;
+    size_t size = 4096;
+
+    if (!whp_dispatch.WHvSetVirtualProcessorState) {
+        return whpx_apic_get_legacy(s);
+    }
+
+    buffer = qemu_memalign(size, size);
+
+    hr = whp_dispatch.WHvGetVirtualProcessorState(
+        whpx_global.partition,
+        cpu->cpu_index,
+        WHvVirtualProcessorStateTypeInterruptControllerState2,
+        buffer,
+        size,
+        NULL);
+
+    if (FAILED(hr)) {
+        fprintf(stderr,
+            "WHvGetVirtualProcessorState failed: %08lx\n",
+            hr);
+
+        abort();
+    }
+
+    memcpy(&kapic, buffer, sizeof(kapic));
+    qemu_vfree(buffer);
+    populate_apic_state(cpu, &kapic);
 }
 
 static void whpx_apic_pre_save(APICCommonState *s)
@@ -306,6 +496,59 @@ static void whpx_apic_mem_write(void *opaque, hwaddr addr,
     whpx_send_msi(&msg);
 }
 
+static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
+{
+    return ((reg) & ~0x700) | ((mode) << 8);
+}
+
+int whpx_apic_init_cpu(CPUState *cpu)
+{
+    uint32_t *lvt_lint0, *lvt_lint1;
+    HRESULT hr;
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer;
+    size_t size = 4096;
+
+    buffer = qemu_memalign(size, size);
+    hr = whp_dispatch.WHvGetVirtualProcessorState(
+        whpx_global.partition,
+        cpu->cpu_index,
+        WHvVirtualProcessorStateTypeInterruptControllerState2,
+        buffer,
+        size,
+        NULL);
+    if (FAILED(hr)) {
+        return hr;
+    }
+
+    memcpy(&lapic_state, buffer, sizeof(lapic_state));
+
+    lvt_lint0 = &lapic_state.apic_lvt_lint0;
+    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
+
+    lvt_lint1 = &lapic_state.apic_lvt_lint1;
+    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
+
+    /* TODO: should we skip setting lapic if the values are the same? */
+
+    memcpy(buffer, &lapic_state, sizeof(lapic_state));
+    hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx_global.partition,
+            cpu->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            buffer,
+            size);
+    if (FAILED(hr)) {
+        return hr;
+    }
+
+    qemu_vfree(buffer);
+    populate_apic_state(cpu, &lapic_state);
+
+    return 0;
+}
+
 static const MemoryRegionOps whpx_apic_io_ops = {
     .read = whpx_apic_mem_read,
     .write = whpx_apic_mem_write,
@@ -324,14 +567,51 @@ static void whpx_apic_reset(APICCommonState *s)
     run_on_cpu(CPU(s->cpu), whpx_apic_put, RUN_ON_CPU_HOST_PTR(s));
 }
 
+static const VMStateDescription vmstate_mshv_apic = {
+    .name = "mshv-apic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(apic_version, MshvAPICState),
+        VMSTATE_UINT32(apic_lvt_cmci, MshvAPICState),
+        VMSTATE_UINT32(apic_error_status, MshvAPICState),
+        VMSTATE_UINT32(apic_counter_value, MshvAPICState),
+        VMSTATE_UINT32(apic_remote_read, MshvAPICState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void whpx_apic_realize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(dev);
+    MshvAPICState *ms = MSHV_APIC(dev);
 
     memory_region_init_io(&s->io_memory, OBJECT(s), &whpx_apic_io_ops, s,
                           "whpx-apic-msi", APIC_SPACE_SIZE);
 
     msi_nonbroken = true;
+
+    /*
+     * We register this state explicity, rather than going via dc->vmsd.
+     * The auto-wiring would register the state with
+     * instance_id == VMSTATE_INSTANCE_ID_ANY, which for the APIC doesn't
+     * work, b/c the ID carries semantic meaning for restoring the state
+     * on the destination (which vcpu it belongs to).
+     */
+    if (!!whp_dispatch.WHvSetVirtualProcessorState) {
+        vmstate_register_with_alias_id(NULL,
+                                   s->initial_apic_id, &vmstate_mshv_apic, ms,
+                                   -1, 0, NULL);
+    }
+}
+
+static void whpx_apic_unrealize(DeviceState *dev)
+{
+    MshvAPICState *ms = MSHV_APIC(dev);
+
+    if (!!whp_dispatch.WHvSetVirtualProcessorState) {
+        vmstate_unregister(NULL, &vmstate_mshv_apic, ms);
+    }
 }
 
 static void whpx_apic_class_init(ObjectClass *klass, const void *data)
@@ -339,6 +619,7 @@ static void whpx_apic_class_init(ObjectClass *klass, const void *data)
     APICCommonClass *k = APIC_COMMON_CLASS(klass);
 
     k->realize = whpx_apic_realize;
+    k->unrealize = whpx_apic_unrealize;
     k->reset = whpx_apic_reset;
     k->set_base = apic_set_base;
     k->set_tpr = whpx_apic_set_tpr;
@@ -351,9 +632,9 @@ static void whpx_apic_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo whpx_apic_info = {
-    .name = "whpx-apic",
+    .name = TYPE_MSHV_APIC,
     .parent = TYPE_APIC_COMMON,
-    .instance_size = sizeof(APICCommonState),
+    .instance_size = sizeof(MshvAPICState),
     .class_init = whpx_apic_class_init,
 };
 
-- 
2.54.0 (Apple Git-157)


