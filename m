Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66523C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFK-0003pa-Ns; Wed, 15 May 2024 11:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFH-0003pK-1z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFF-0002ky-15
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-420104e5336so26608195e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785719; x=1716390519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQrV4UMaEBl22gT4Xij+bzAgjXuhBjByp/7UaStu/qs=;
 b=ZFmizw7OMv9hDgaBabULRIXzk/iIjsbaG53ool99QqzU5m7nifO5GhFbzXotPWFhUm
 UICbofBiNogcFhZ/xp3LWOASCJ7eugMjRxiPzMUDvW475eUMjVoHFY18N68PGcIQHIU1
 cXmw7lAS0WL8ky61chd4txx7AraFSp6Y1zEveF8fQ8XBIlMS8cDRfAHXp5M6KbIMJpbG
 6nwkjeKiUYUVNThDDtyOwM6t9Qcc7f0CimoG9crSXDznO/xaReR+Xe+vtPFyidHLdPaZ
 qFes7GdDaMX5WO5GOLP+XWZeqqqMBfLg3zOg/+YkwV9cGzo0CGYzdKs9r+2vShuon+ma
 spzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785719; x=1716390519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQrV4UMaEBl22gT4Xij+bzAgjXuhBjByp/7UaStu/qs=;
 b=FLpq6sZmBMs054KbKbOb2Bs+V/FcnwHfbOs6/AJ/WvLDDJNsvSk+LvHJ0T477ao0RF
 Ci+eGD9KJw1yQo654znue5fF3oaXeF6wqxqIGovUTjZKMr2n/xd16dp8OTHVl1bZ4hZk
 Yi20gIIWZzHY2iwfuPId7SjQyf4uRfeU4U0jDV59XTqskygepbc8fTnywBt2awUOr1Ao
 QZTIdeEHzkAwArHRGQOehlJtejfzVF/TMxSIvf9FRa4ybVookLVQGGwpf+IPWPRwntRb
 ENiV0xAPUSfbs2inJY0H64Ey/VLoKnxCfGassal3TanuXSNEtInfoQHHWywec4zPIbh+
 r7hA==
X-Gm-Message-State: AOJu0YxgNdQLRj+AafMjaVgg9hJ9fBlBzuhqmDMZdyry6EraRwvmRdDb
 cjCWtpxBUFwzOmCXhefteLSkiXPjJ0FOvoGTztBFHWEo3cDeLnpDzCClcig2OCcrAByQgoh8N1I
 vg2g=
X-Google-Smtp-Source: AGHT+IFNLA+Qrjng1hhAbcxSGhoV4wDeksxbVi4YMUIjLg69WDrbMwwwywZvkBwSAqNlgD99JjpwJA==
X-Received: by 2002:a05:600c:1909:b0:418:9d4a:1ba5 with SMTP id
 5b1f17b1804b1-41fbca35c5emr172985375e9.6.1715785719449; 
 Wed, 15 May 2024 08:08:39 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 01/28] target/i386: Add tcg/access.[ch]
Date: Wed, 15 May 2024 17:08:10 +0200
Message-Id: <20240515150837.259747-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Provide a method to amortize page lookup across large blocks.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/access.h    |  40 +++++++++
 target/i386/tcg/access.c    | 169 ++++++++++++++++++++++++++++++++++++
 target/i386/tcg/meson.build |   1 +
 3 files changed, 210 insertions(+)
 create mode 100644 target/i386/tcg/access.h
 create mode 100644 target/i386/tcg/access.c

diff --git a/target/i386/tcg/access.h b/target/i386/tcg/access.h
new file mode 100644
index 0000000000..d70808a3a3
--- /dev/null
+++ b/target/i386/tcg/access.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Access guest memory in blocks. */
+
+#ifndef X86_TCG_ACCESS_H
+#define X86_TCG_ACCESS_H
+
+/* An access covers at most sizeof(X86XSaveArea), at most 2 pages. */
+typedef struct X86Access {
+    target_ulong vaddr;
+    void *haddr1;
+    void *haddr2;
+    uint16_t size;
+    uint16_t size1;
+    /*
+     * If we can't access the host page directly, we'll have to do I/O access
+     * via ld/st helpers. These are internal details, so we store the rest
+     * to do the access here instead of passing it around in the helpers.
+     */
+    int mmu_idx;
+    CPUX86State *env;
+    uintptr_t ra;
+} X86Access;
+
+void access_prepare_mmu(X86Access *ret, CPUX86State *env,
+                        vaddr vaddr, unsigned size,
+                        MMUAccessType type, int mmu_idx, uintptr_t ra);
+void access_prepare(X86Access *ret, CPUX86State *env, vaddr vaddr,
+                    unsigned size, MMUAccessType type, uintptr_t ra);
+
+uint8_t  access_ldb(X86Access *ac, vaddr addr);
+uint16_t access_ldw(X86Access *ac, vaddr addr);
+uint32_t access_ldl(X86Access *ac, vaddr addr);
+uint64_t access_ldq(X86Access *ac, vaddr addr);
+
+void access_stb(X86Access *ac, vaddr addr, uint8_t val);
+void access_stw(X86Access *ac, vaddr addr, uint16_t val);
+void access_stl(X86Access *ac, vaddr addr, uint32_t val);
+void access_stq(X86Access *ac, vaddr addr, uint64_t val);
+
+#endif
diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
new file mode 100644
index 0000000000..56a1181ea5
--- /dev/null
+++ b/target/i386/tcg/access.c
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Access guest memory in blocks. */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
+#include "access.h"
+
+
+void access_prepare_mmu(X86Access *ret, CPUX86State *env,
+                        vaddr vaddr, unsigned size,
+                        MMUAccessType type, int mmu_idx, uintptr_t ra)
+{
+    int size1, size2;
+    void *haddr1, *haddr2;
+
+    assert(size > 0 && size <= TARGET_PAGE_SIZE);
+
+    size1 = MIN(size, -(vaddr | TARGET_PAGE_MASK)),
+    size2 = size - size1;
+
+    memset(ret, 0, sizeof(*ret));
+    ret->vaddr = vaddr;
+    ret->size = size;
+    ret->size1 = size1;
+    ret->mmu_idx = mmu_idx;
+    ret->env = env;
+    ret->ra = ra;
+
+    haddr1 = probe_access(env, vaddr, size1, type, mmu_idx, ra);
+    ret->haddr1 = haddr1;
+
+    if (unlikely(size2)) {
+        haddr2 = probe_access(env, vaddr + size1, size2, type, mmu_idx, ra);
+        if (haddr2 == haddr1 + size1) {
+            ret->size1 = size;
+        } else {
+#ifdef CONFIG_USER_ONLY
+            g_assert_not_reached();
+#else
+            ret->haddr2 = haddr2;
+#endif
+        }
+    }
+}
+
+void access_prepare(X86Access *ret, CPUX86State *env, vaddr vaddr,
+                    unsigned size, MMUAccessType type, uintptr_t ra)
+{
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    access_prepare_mmu(ret, env, vaddr, size, type, mmu_idx, ra);
+}
+
+static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
+{
+    vaddr offset = addr - ac->vaddr;
+
+    assert(addr >= ac->vaddr);
+
+#ifdef CONFIG_USER_ONLY
+    assert(offset <= ac->size1 - len);
+    return ac->haddr1 + offset;
+#else
+    if (likely(offset <= ac->size1 - len)) {
+        return ac->haddr1 + offset;
+    }
+    assert(offset <= ac->size - len);
+    /*
+     * If the address is not naturally aligned, it might span both pages.
+     * Only return ac->haddr2 if the area is entirely within the second page,
+     * otherwise fall back to slow accesses.
+     */
+    if (likely(offset >= ac->size1)) {
+        return ac->haddr2 + (offset - ac->size1);
+    }
+    return NULL;
+#endif
+}
+
+#ifdef CONFIG_USER_ONLY
+# define test_ptr(p)  true
+#else
+# define test_ptr(p)  likely(p)
+#endif
+
+uint8_t access_ldb(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint8_t));
+
+    if (test_ptr(p)) {
+        return ldub_p(p);
+    }
+    return cpu_ldub_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+uint16_t access_ldw(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint16_t));
+
+    if (test_ptr(p)) {
+        return lduw_le_p(p);
+    }
+    return cpu_lduw_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+uint32_t access_ldl(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint32_t));
+
+    if (test_ptr(p)) {
+        return ldl_le_p(p);
+    }
+    return cpu_ldl_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+uint64_t access_ldq(X86Access *ac, vaddr addr)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint64_t));
+
+    if (test_ptr(p)) {
+        return ldq_le_p(p);
+    }
+    return cpu_ldq_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
+}
+
+void access_stb(X86Access *ac, vaddr addr, uint8_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint8_t));
+
+    if (test_ptr(p)) {
+        stb_p(p, val);
+    } else {
+        cpu_stb_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
+
+void access_stw(X86Access *ac, vaddr addr, uint16_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint16_t));
+
+    if (test_ptr(p)) {
+        stw_le_p(p, val);
+    } else {
+        cpu_stw_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
+
+void access_stl(X86Access *ac, vaddr addr, uint32_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint32_t));
+
+    if (test_ptr(p)) {
+        stl_le_p(p, val);
+    } else {
+        cpu_stl_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
+
+void access_stq(X86Access *ac, vaddr addr, uint64_t val)
+{
+    void *p = access_ptr(ac, addr, sizeof(uint64_t));
+
+    if (test_ptr(p)) {
+        stq_le_p(p, val);
+    } else {
+        cpu_stq_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
+    }
+}
diff --git a/target/i386/tcg/meson.build b/target/i386/tcg/meson.build
index f9110e890c..1105b35d92 100644
--- a/target/i386/tcg/meson.build
+++ b/target/i386/tcg/meson.build
@@ -1,4 +1,5 @@
 i386_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'access.c',
   'bpt_helper.c',
   'cc_helper.c',
   'excp_helper.c',
-- 
2.34.1


