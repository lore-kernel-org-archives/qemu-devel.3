Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B47F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKn-00013C-3H; Thu, 23 Apr 2026 06:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKE-0000nF-Gl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrK9-0005me-SS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3n3FxpdFX8QEwtruRPtTMxey3qCGIDC6XniieDlmvks=;
 b=iCkJJWZHzQob61GE5rMV9/unt8vQiTCtjEcvSixopUVlXuKWlhoEFOsFahAAXpO3MazcEP
 KBL/612/mSsYA+iVw+SchJ2iMVQppaDpWqIeh1imYJ3aXKCcdzpjvVAOEqt2pvRTJYW5pG
 xilHA2mCTn4w4/ur/9YnGH971TQweRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-MonI686aNKKAVkVp6Akexw-1; Thu, 23 Apr 2026 06:30:16 -0400
X-MC-Unique: MonI686aNKKAVkVp6Akexw-1
X-Mimecast-MFC-AGG-ID: MonI686aNKKAVkVp6Akexw_1776940216
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a5adc141cso11521485e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940215; x=1777545015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n3FxpdFX8QEwtruRPtTMxey3qCGIDC6XniieDlmvks=;
 b=Y4d//JbOmcRqbs0meMaGdXK66/bxRBIG097ZNx+9TOMuZos8bTuTxadBEa2zFI01yL
 eqFJjiPeZm4GbZSkmvAeQq4mo5qrJlNFjhqXxuHHq1/90gymr4JNrx8nKNmLgxYLCV3v
 SK188mW5yj4urQKblK3NziejpgGU/YxUcPtreF8rBvzDDll26313OEy8AAMs+EUz0o/i
 eWwQ/E71bv2EekR4YL3DEsP/cSLmYW38PUJqZH8oXIgkbZPS03wTtdW4GXdHHFmelFOE
 tGDZaIUS1G8hti5Nn1gPQnMKeqP/r8lpoQ7xXJvsMe0trrXWyqNQyHrXV8FM0Eok8wyA
 NaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940215; x=1777545015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3n3FxpdFX8QEwtruRPtTMxey3qCGIDC6XniieDlmvks=;
 b=U430X7N+TIVLWt+zr9nERHi7j4nDsUfpUaJebsRB2TjC+wbDcrToV6fnM7TWTRMHR3
 TMXgod58pKordk9lsqPKQtlf7zY66kVLadZVFZp4YRB3a9EPgW8Qhi0P7XvfHtokd1rO
 zKNgddwyY0Gu1IovysdbGh/n8O+g9u1jdZNmha2AUq6d5/ySm4uX9LlbQnjxCSoB9KIN
 nZ7RHkXmd6zg5DFEOVJq4zALyxBPbSQ5Mvm0vqszGdrGAfGLsfvY1eG0pUJkTA5VkhRC
 vBnZ2BDYPcNajoJKNpbKggFRMCVQ4cOcn9p49WHNZA1F4jpHE87HtQWki7AOm2/O8vwL
 YIRw==
X-Gm-Message-State: AOJu0YwYVe7yHJUHxmhOiWQy2nFkXLu1jtlmHOuvbwq1TV1c679+oUpj
 oTK64g+0TYo04RxQk2wac0wSJaR321s60oVn3YBS5ybvPHtDHd6jCGNfSyqpFr07PtplxV6x3ys
 cSynBK049f/iBVil15mNdt6o4VA+PTk1EUQO1ZsTAl097aQRSTZrJXirLLe7z7nZO7LhsAYot/0
 Auhz2AtRMTXHuWI/1EkmLoEakVetGPgpXKDnPruS3n
X-Gm-Gg: AeBDiesGVlvlrqYtZikLvf5y3CuGXgn+R10iMMM0Ix9etosSo7Q+cOQNxJHFB6uP6cS
 GN9kz+Y98jILEoIAYrZmyihifoAslGOvETGtaS3MCo82UZ3g8zFvfWhIhb5wC4dlockanKY8uPi
 gsqRG6TcR40islAy9KgMF4KuRYmXFD20f+vl3HgnaFIhgm5xAh0MLalPJ12T5Gg3mAgoB2TACtt
 NXIzlehEsUmwFiD32YKOE/IaYKcTFl5lvp+ioSjAPn4vpYYrx0MSE6iCE11QfkttrrElw1PNXci
 AWkjYJbKzTAnVeNlenrId+BzRLezUSAwSAB5WLOzkTUKHDW/MHicn/yiVa/C0u4zHlWfR3FZeTy
 gWuED+PovUS+sxdLHMeavXw9eRX0RwygiPBNyRf9Jzz0R/vyfhcXH51n0lUvy3FzntqvfTBajaQ
 IbQV1ZixjXXqu7HNTdCURhZwrUBbfazIQ9/Co=
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr348293255e9.2.1776940214993; 
 Thu, 23 Apr 2026 03:30:14 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr348292585e9.2.1776940214393; 
 Thu, 23 Apr 2026 03:30:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489fec8f7cbsm240212955e9.11.2026.04.23.03.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 18/25] target/i386/mshv: Fix segment regression in MMIO emu
Date: Thu, 23 Apr 2026 12:29:15 +0200
Message-ID: <20260423102922.443639-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 target/i386/mshv/mshv-cpu.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2bc978deb25..4ed6e7548f6 100644
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
+    uint32_t limit;
 
-    ret = x86_read_segment_descriptor(cpu, desc, sel);
-    if (ret == false) {
-        error_report("failed to read segment descriptor");
-        abort();
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
2.53.0


