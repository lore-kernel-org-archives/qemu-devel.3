Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E0109C046
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMN-000590-Q6; Wed, 25 Mar 2026 12:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMH-0004v2-85
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RME-0004fy-IY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDJ/PcBLUSV5Q5FoJHAa+eAa0xCv+PFTV5gWg0XZbs8=;
 b=fM9HK4WPpCMeWK0KkdBDP2DWc8xxtwDTL0aubuy8LrwH5/XIoXqCvia1lSMttQcSn3JmFD
 ynCtQ6qTTjyrh4wtSCC+28QglsLOnRLFr5jpvw+yCA6MgenPhILnjLMAClB/8K35pt8fvG
 bU07K0HD9ZMbwESxoM0QbwTbAst1xOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-3OUkllTUOn-I4KXkZMaYtQ-1; Wed, 25 Mar 2026 12:45:23 -0400
X-MC-Unique: 3OUkllTUOn-I4KXkZMaYtQ-1
X-Mimecast-MFC-AGG-ID: 3OUkllTUOn-I4KXkZMaYtQ_1774457122
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486f830f4e4so585985e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457121; x=1775061921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDJ/PcBLUSV5Q5FoJHAa+eAa0xCv+PFTV5gWg0XZbs8=;
 b=BpkclhlVH5psdU2fEPFxBeBlDDKosab9m+o6QszzVx37BFYAXyka23UjcSHWCeufbj
 evG9ikhII6mOxYLEXHOHsbXe5kCyUSA76+rbFrdlxdykFDWGNAjVRb+JBn9EGFZGyGqx
 /dqezZ4cs4gGTZctTWtvUyqaWZEyHcF4VOcJ0Xg2jXSzjefHJRObWZ+sBz4ULcihZxaf
 FkW3DREsQQx/OVNADZqgSPM+Y2cztYmKSx+KI2Ot4sQWILxhtYmb3b35LGt0E9ND1Gc2
 wiy+GaecXHkT4Z3Zbn/TFI5eb3ESqUr1a1D64tu0DMJA2SU5bZyRKr9e+GSxQ+slD2gc
 ntWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457121; x=1775061921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SDJ/PcBLUSV5Q5FoJHAa+eAa0xCv+PFTV5gWg0XZbs8=;
 b=fM8k4RDZbXWRpOQ6OoJIQQBId7wLUVnrv7H+TyIlK0U0ZGPnDa1/7Z677R+dixcxBl
 zh/fNsWC2cWF0pUAIU1kXqw82RdMgfv3Z0TS6gJPkfH4vka0lBNKivRBd2Dop3mLbI+n
 76NR6rmcj/JTTNwSiGOsIUeFulCJ73oa8cq19paoQSkh2ds7Le9JXcIM7wNf9pU0jblb
 /VfsjRDT6EPZa4EW+3UXvsZlq7FazCtp7bx06ugd7nIxwijsSQv2DYK71xlKlG3riQXQ
 FMRnSzqN7HAX6igMIEVS/TSUm3ylRFmAcDegAWSZYbERHqNn/x8DxFukAFTWTpL391YP
 19Nw==
X-Gm-Message-State: AOJu0YxId5xxswy/teZ+eTcKIg/QidHcXW07UfXx0NphWuxX9e8j69vR
 5IysL3aBYn1fd3DwnWTgRBmcci5j0KYpblyMyWH5TF1uau6XjDiJCgeDGqfoLXDFRXc+etqGj1/
 kyB0Bb8fZ3J9DZQV7cVvR0uLljtjZxCs2JvEZnOzjsqQ1ewni/j/khFdJylB/27xBFe8PDBIW3s
 ZycM1wlq72PPghT+8VcwtiVV6f2AJjGDYCKs5aEAQE
X-Gm-Gg: ATEYQzzYUJPsVd9Zilvmi8Dh+PtZ8NWpcd3p8vcQJMzFarAmyHTUx4PICWGyYBrmG5X
 BFimkUEss03Ih21It3a4td8fAygr5hYlbStUdCTOrXbo9mtNBk8ziiGvEpJOuRCEFDwyq44C36I
 FXlTFMy1q9kgV9Dp1fTS/V9Ego4Qa1tcpxHohKhhfgLxXLNUD4SSo4zhBGMItSYAbckETrUS5O2
 RbgPiX5WQ2G/Dgi1n8koq+O8s8X2sl73JFooiyUvZguzNbrmdo5irsk/UvSzboaXXrqmeqgWEAk
 9J24pbh85hFlh6dK9/Rwtl4f2S03fWdTtZ5YWQhxuu2O9K4GHwfN4tq4UjsmXljeMZXnvCQR6wo
 pOvJ//G6uJgWPE2xb0ura9fntAy6E9sgesCsGOOApPNbSM+6K+FHX6+oihn4tsZ8O44yeDMwGC6
 zqBmmvDi+8J3M2nbd6QeG1Q9Wd
X-Received: by 2002:a05:600c:3d90:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-48715fc38f3mr62050785e9.4.1774457120733; 
 Wed, 25 Mar 2026 09:45:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d90:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-48715fc38f3mr62050135e9.4.1774457120072; 
 Wed, 25 Mar 2026 09:45:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871e6cb664sm7908065e9.12.2026.03.25.09.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 13/19] target/i386: emulate: segmentation rework
Date: Wed, 25 Mar 2026 17:44:47 +0100
Message-ID: <20260325164453.72127-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Make accesses to segments all go through read_segment_descriptor
to be able to fetch segment state on-demand.

Switch away from SegmentCache to the x86_segment_descriptor
that is already used by read_segment_descriptor.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-11-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_helpers.c | 50 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index c817015ef92..63bae3582fe 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -43,49 +43,37 @@ static CpuMode cpu_mode(CPUState *cpu)
     return m;
 }
 
-static bool segment_type_ro(const SegmentCache *seg)
+static bool segment_type_ro(const x86_segment_descriptor desc)
 {
-    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    uint32_t type_ = desc.type;
     return (type_ & (~RWRX_SEGMENT_TYPE)) == 0;
 }
 
-static bool segment_type_code(const SegmentCache *seg)
+static bool segment_type_code(const x86_segment_descriptor desc)
 {
-    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    uint32_t type_ = desc.type;
     return (type_ & CODE_SEGMENT_TYPE) != 0;
 }
 
-static bool segment_expands_down(const SegmentCache *seg)
+static bool segment_expands_down(const x86_segment_descriptor desc)
 {
-    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    uint32_t type_ = desc.type;
 
-    if (segment_type_code(seg)) {
+    if (segment_type_code(desc)) {
         return false;
     }
 
     return (type_ & EXPAND_DOWN_SEGMENT_TYPE) != 0;
 }
 
-static uint32_t segment_limit(const SegmentCache *seg)
+static uint8_t segment_db(const x86_segment_descriptor desc)
 {
-    uint32_t limit = seg->limit;
-    uint32_t granularity = (seg->flags & DESC_G_MASK) != 0;
-
-    if (granularity != 0) {
-        limit = (limit << 12) | 0xFFF;
-    }
-
-    return limit;
+    return desc.db;
 }
 
-static uint8_t segment_db(const SegmentCache *seg)
+static uint32_t segment_max_limit(const x86_segment_descriptor desc)
 {
-    return (seg->flags >> DESC_B_SHIFT) & 1;
-}
-
-static uint32_t segment_max_limit(const SegmentCache *seg)
-{
-    if (segment_db(seg) != 0) {
+    if (segment_db(desc) != 0) {
         return 0xFFFFFFFF;
     }
     return 0xFFFF;
@@ -96,15 +84,15 @@ static int linearize(CPUState *cpu,
                      X86Seg seg_idx)
 {
     enum CpuMode mode;
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    SegmentCache *seg = &env->segs[seg_idx];
-    target_ulong base = seg->base;
+    struct x86_segment_descriptor desc;
+    target_ulong base;
     target_ulong logical_addr_32b;
     uint32_t limit;
     /* TODO: the emulator will not pass us "write" indicator yet */
     bool write = false;
 
+    emul_ops->read_segment_descriptor(cpu, &desc, seg_idx);
+    base = x86_segment_base(&desc);
     mode = cpu_mode(cpu);
 
     switch (mode) {
@@ -116,21 +104,21 @@ static int linearize(CPUState *cpu,
         break;
     case PROTECTED_MODE:
     case REAL_MODE:
-        if (segment_type_ro(seg) && write) {
+        if (segment_type_ro(desc) && write) {
             error_report("Cannot write to read-only segment");
             return -1;
         }
 
         logical_addr_32b = logical_addr & 0xFFFFFFFF;
-        limit = segment_limit(seg);
+        limit = x86_segment_limit(&desc);
 
-        if (segment_expands_down(seg)) {
+        if (segment_expands_down(desc)) {
             if (logical_addr_32b >= limit) {
                 error_report("Address exceeds limit (expands down)");
                 return -1;
             }
 
-            limit = segment_max_limit(seg);
+            limit = segment_max_limit(desc);
         }
 
         if (logical_addr_32b > limit) {
-- 
2.53.0


