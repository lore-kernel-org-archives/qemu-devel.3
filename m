Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C51109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMP-0005A3-CY; Wed, 25 Mar 2026 12:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RML-00050Q-0l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMF-0004fw-Lj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6sdL1vsVWO3ZuG6mgc20dg8BLq/JVi1oEu7UYtVDpI=;
 b=T3e+dMX0z0mBp1nF3MSq2/Cl0CtlXbX0N5sVssDfHJECTIMDCu5BpV9VIrbkppGKiegZXy
 XhqOIlUqX2PAYgQGbJHTdBRQ18Zmhk9+WGDfXG95c4kPccQBSVfVSEBWBkV8EgChFnFrms
 ooIUREMGeUECnnk/7XlDWFxiby1Zd20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-PETlQdw2OXCRUONf7NU0aA-1; Wed, 25 Mar 2026 12:45:24 -0400
X-MC-Unique: PETlQdw2OXCRUONf7NU0aA-1
X-Mimecast-MFC-AGG-ID: PETlQdw2OXCRUONf7NU0aA_1774457123
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso420885e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457122; x=1775061922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6sdL1vsVWO3ZuG6mgc20dg8BLq/JVi1oEu7UYtVDpI=;
 b=a4O+iwd+UT8pQlSnOoe7hDZJ2b26MdKzkl7K6cN+24R8PxBJNo3PQ+qbeug7WwKxsh
 Noe6W2Ram1Gg5Uu+qsJtChR4VBZn17F4Nd12MH/M9xz9sJjonIf3MH7a3nH0oYnK5oiV
 XdRqMoG63wvpT7TTSCXqrgqug5iFDArzzwEo0dWE97ff/kZCY4ME1qVS8vwLdbB77u3/
 TB6Ak1P8hkwyG2sRtFFnH+Q5vTffuPOAElES6bhpcMgNFqPgGAhc9XauYaXO7kxG5sZh
 H3yCv0HtFwU7wD7nbEDiOdn5RuotxkipVEQEFQcJvXnvLjv6Omr1HoYUZBH+QtIQ1HWe
 eqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457122; x=1775061922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n6sdL1vsVWO3ZuG6mgc20dg8BLq/JVi1oEu7UYtVDpI=;
 b=Mil2yJyVoxkHAN8CyoO6jK1KPVWAxObSLqlCL9IXHdjFVTxk05qPmS3vlAXyMrT64I
 TB/4UQV6qgMc/RU59tpbVHNxeVcbwHrHr7QCgJ3boY0YrCdV39OCNoZqyir4+1XAPLRR
 YV+kiCOYd0DwxLKkM+0UC4bu8y6Qb/bfo4kM6hAWwauMm3zmO6V6SsUGgbkdjuswxzY8
 5KrAQpIHdYpvx7s+Xy/4oDauIGenDuQ5USt1emGDpvZiTHAWnXK2X/eSi3gjNny0VgKr
 dZAuAKR7Shk3ETfngNAsWuFUAM6PV//Rsz0JZV3qul5dJAV4xtK2lKfB7Zeb1DU0MaCB
 DBTA==
X-Gm-Message-State: AOJu0YxhwKNbJznrsYCAt80HZn6twzQDZryUFx6wOQIsUEgOEsyuW+jN
 AYP+1Ya5CDeRg655BxsOoxItYAgB05LYIQBF7celxTEIcsPFEHhbIfxp5Oc59jeHoernQUdDiS9
 n3lv3IZf9wqJ3fI032B7WTYetAPxI2MmCeHNMWMKd4e9iK/nR40FUCrBrYkl0r7hJQmlQq6sK6D
 b7z1xP13vyVzT+66Q6PepfdmwlNNf8FaVfovgCEBGR
X-Gm-Gg: ATEYQzxMMTR4dr1X4ap8RJZ8v2HosukdGn+UortMapsVNnfqcREuC+MnHv/fvSvgBfX
 xWU6bZlsBB36m2b8wkQJ0/UsHEHD1STOLPg854s6NgFGKFSP9RlLqjHcEQ8xOknVqvdxyBNrrjr
 A5ujjG7SCMHQ6BqQ9p6GklN38Jn1X7PysecrVjkKSbmNfBR2vtv4n5x4hZ6nz4tsMohIldugJxP
 a3ABII3OtWnxE28GC0RGsVfasCzP2PjcdIYm/4IzJRVf4WCvctsu6riX4jrUpWXXE8nfcR6UtO7
 Qnw1llAM09GWvIU5UIwJNWDOFrZTSbyyTWfiiFEJLNu4kWHb4NZ4nq3NgG6ULjsHJ0dueE2Up0x
 Rkjgts1ADn4F7iFuQ3TGNCka+fPqt6FOm/+d833E0JFDeM7RYsN4NxZ4xNjdPz2WuuBLmSfGukG
 onRgnsBknf51PXOKfnRAdpYygY
X-Received: by 2002:a05:600c:8489:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-48715fc38femr60002615e9.6.1774457121826; 
 Wed, 25 Mar 2026 09:45:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8489:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-48715fc38femr60002095e9.6.1774457121265; 
 Wed, 25 Mar 2026 09:45:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871e6aeef4sm6495635e9.9.2026.03.25.09.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 14/19] whpx: i386: fetch segments on-demand
Date: Wed, 25 Mar 2026 17:44:48 +0100
Message-ID: <20260325164453.72127-15-pbonzini@redhat.com>
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

Instead of save/restore, fetch segments dynamically.

Rely on the fetched state instead of loading from memory.

Or, if available, on the VM exit context.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-12-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 71 +++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 71b33a632ac..6f232786422 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -868,21 +868,70 @@ static int whpx_handle_portio(CPUState *cpu,
     return 0;
 }
 
+static void whpx_segment_to_x86_descriptor(CPUState *cpu, WHV_X64_SEGMENT_REGISTER* reg,
+                                   struct x86_segment_descriptor *desc)
+{
+    uint32_t limit;
+    desc->g = reg->Granularity;
+
+    /*
+     * Hyper-V can return reg->Granularity == 0
+     * with a higher limit than 0xfffff.
+     *
+     * Detect that case and set desc->g
+     * with shifting the limit properly.
+     */
+    if (!desc->g && reg->Limit <= 0xfffff) {
+        limit = reg->Limit;
+    } else {
+        limit = (reg->Limit >> 12);
+        desc->g = 1;
+    }
+
+    x86_set_segment_limit(desc, limit);
+    x86_set_segment_base(desc, reg->Base);
+
+    desc->type = reg->SegmentType;
+    desc->s = reg->NonSystemSegment;
+    desc->dpl = reg->DescriptorPrivilegeLevel;
+    desc->p = reg->Present;
+    desc->avl = reg->Available;
+    desc->l = reg->Long;
+    desc->db = reg->Default;
+}
+
+static void whpx_read_segment_descriptor(CPUState *cpu, WHV_X64_SEGMENT_REGISTER* reg,
+                                    X86Seg seg)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    WHV_REGISTER_NAME reg_name = WHvX64RegisterEs + seg;
+    WHV_REGISTER_VALUE val;
+
+    if (seg == R_CS) {
+        *reg = vcpu->exit_ctx.VpContext.Cs;
+        return;
+    }
+    if (vcpu->exit_ctx.ExitReason == WHvRunVpExitReasonX64IoPortAccess) {
+        if (seg == R_DS) {
+            *reg = vcpu->exit_ctx.IoPortAccess.Ds;
+            return;
+        } else if (seg == R_ES) {
+            *reg = vcpu->exit_ctx.IoPortAccess.Es;
+            return;
+        }
+    }
+
+    whpx_get_reg(cpu, reg_name, &val);
+    *reg = val.Segment;
+}
+
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
 {
-    bool ret;
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    SegmentCache *seg = &env->segs[seg_idx];
-    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
-
-    ret = x86_read_segment_descriptor(cpu, desc, sel);
-    if (ret == false) {
-        error_report("failed to read segment descriptor");
-        abort();
-    }
+    WHV_X64_SEGMENT_REGISTER reg;
+    whpx_read_segment_descriptor(cpu, &reg, seg_idx);
+    whpx_segment_to_x86_descriptor(cpu, &reg, desc);
 }
 
 static bool is_protected_mode(CPUState *cpu)
-- 
2.53.0


