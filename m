Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03CDCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuVr-0003I3-S7; Tue, 12 May 2026 17:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVJ-0001t0-Bl; Tue, 12 May 2026 17:19:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVD-0007ny-8D; Tue, 12 May 2026 17:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=J5ZopIHRvNIpGmXxn6yCxR23lVzlxpNAEx3lxGlR9A0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LHuo4/egyFK5ZbLaAvcoszIfX4pAwSrbaMuxX49EOEPBNEWB7c5qYj0XVOy+vqyRM
 48HObN5pbycIZk8QYaaHWeGbW2potQD96J+GJ5yRFr/XZPoglqzpLQ/KUnAnAIE2NP
 +S3u29dOXOgw1VTh9zI6YGsa8cEOttJnof4g6YgOpy5sVQd87aAoPf3zZh4i36qXxc
 wPGKG2ZRdHzRY3JOuKz7umpUr41wbzL06Sg9rC6CxfcWBn1YuZC7oQO4mAaJCtOafz
 diUkq45+xfb6Tn7vq8xFNp38O56Henw/ytE6nLAt1DBaWjeMlbngFrv8sWSWfl0360
 GRjYoExg42Csw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 663C91AA3D3;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 72BC83ABD2B;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 08/58] target/i386/mshv: Fix segment regression in
 MMIO emu
Date: Tue, 12 May 2026 23:57:29 +0300
Message-ID: <20260512205820.361821-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

When the segmentation code has been reworked, there is now an
unconditional call to emul_ops->read_segment_descriptor(). The MSHV impl
was delegating this to x86_read_segement_descriptor(), which read from
the GDT in guest memory. This fails for selector.idx == 0 and when no
GDT is set up (which is the case in real mode).

In the fix we change the MSHV impl to fill segment descriptor from
SegmentCache, that was populated from the hypervisor by mshv_load_regs()
before instruction emulation.

Fixes: 09442d98ab (target/i386: emulate: segmentation rework)

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260410142652.367541-1-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7d6231dfb5eaba55b7cf266b0993adaccf0381d0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2bc978deb2..4ed6e7548f 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1552,17 +1552,42 @@ static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
 {
-    bool ret;
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     SegmentCache *seg = &env->segs[seg_idx];
-    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
-
-    ret = x86_read_segment_descriptor(cpu, desc, sel);
-    if (ret == false) {
-        error_report("failed to read segment descriptor");
-        abort();
+    uint32_t limit;
+
+    memset(desc, 0, sizeof(struct x86_segment_descriptor));
+
+    desc->type = (seg->flags & DESC_TYPE_MASK) >> DESC_TYPE_SHIFT;
+    desc->s    = (seg->flags & DESC_S_MASK)    >> DESC_S_SHIFT;
+    desc->dpl  = (seg->flags & DESC_DPL_MASK)  >> DESC_DPL_SHIFT;
+    desc->p    = (seg->flags & DESC_P_MASK)    >> DESC_P_SHIFT;
+    desc->avl  = (seg->flags & DESC_AVL_MASK)  >> DESC_AVL_SHIFT;
+    desc->l    = (seg->flags & DESC_L_MASK)    >> DESC_L_SHIFT;
+    desc->db   = (seg->flags & DESC_B_MASK)    >> DESC_B_SHIFT;
+    desc->g    = (seg->flags & DESC_G_MASK)    >> DESC_G_SHIFT;
+
+    /*
+     * SegmentCache stores the hypervisor-provided value verbatim (populated by
+     * mshv_load_regs). We need to convert it to format expected by the
+     * instruction emulator. We can have a limit value > 0xfffff with
+     * granularity of 0 (byte granularity), which is not representable
+     * in real x86_segment_descriptor. In this case we set granularity to 1
+     * (4k granularity) and shift the limit accordingly.
+     *
+     * This quirk has been adopted from "whpx_segment_to_x86_description()"
+     */
+
+    if (!desc->g && seg->limit <= 0xfffff) {
+        limit = seg->limit;
+    } else {
+        limit = seg->limit >> 12;
+        desc->g = 1;
     }
+
+    x86_set_segment_limit(desc, limit);
+    x86_set_segment_base(desc, seg->base);
 }
 
 static const struct x86_emul_ops mshv_x86_emul_ops = {
-- 
2.47.3


