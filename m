Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5404F44873
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBCpB-0001lj-JF; Fri, 10 Apr 2026 10:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wBCp6-0001lE-So
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:27:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wBCp5-0007dw-2w
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:27:04 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.74])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9124520B710C;
 Fri, 10 Apr 2026 07:26:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9124520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775831217;
 bh=w4Et5vnM6DYRBOzmkM5lcO13jgnVys5sI6NHnXTE+6U=;
 h=From:To:Cc:Subject:Date:From;
 b=aUvZb/MpvM/jE4uiFb3/pZb3gmfBF2d39nV8nwtxa9XHFXw6sgxbLD1yO1jNZQW/4
 rYSlcSpCEcgaTQh270NTy6VeQ96PQ9yaou1olFILg6prmnjofMSalx6h5GE9oTmgXR
 0zyWglquXuV9JGdDhV687I93AkzfiaYGaawL5eLo=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>
Subject: [PATCH] target/i386/mshv: Fix segment regression in MMIO emu
Date: Fri, 10 Apr 2026 16:26:52 +0200
Message-Id: <20260410142652.367541-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 target/i386/mshv/mshv-cpu.c | 39 ++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

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
2.34.1


