Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF9C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tBP-0008OM-0g; Thu, 24 Apr 2025 05:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBK-0008G6-D0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBI-0002bD-Fe
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so621052f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488062; x=1746092862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twrcSo4HetcJ/tOp7Scc/UtSqix7ipI/uTd3T2r+yek=;
 b=KQj4a+9165+0WLJK0amhTnlftVdqs8UhMSFFrpLbtNEJQF3ZakBUqjlWy1NjQonJlX
 5shD0YPsnmbVNhPEy7SPoQu9D6jftItLui+lKLVQ9l55b5Eq27XpcQ1is8nSVG/hygo9
 LOM045BPJelje3kO9WljPEfRVz7VBGV4V31ej+IvVtkhPQ/PnZA4MV9JsItJYxcbrsPI
 cg4Epxpz/VeJ3r0RtJZw8NcGw93smClt415urEHBMc7JUSJdCLBuyom4J7Urfj/3V9Yf
 AdLlgm39LUeVtC/RYiv+U7M7VcvnqB/M4UMJ5JOzufjeuZ9h2HnGwldAi0RNtvi9nPKl
 61dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488062; x=1746092862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twrcSo4HetcJ/tOp7Scc/UtSqix7ipI/uTd3T2r+yek=;
 b=VvEo197YVQfr5O0JsdWAIvjrd1XmG+wtdOrHtTsRe2pcieGvsC7Pm2BegxWFj3JI0i
 qcf/TmB38xNCOb0gb1Z+RjgFAW7ihv54qUwwi/dOIFDeyydXSg1PE0sO8ACXgtnekUhs
 HIsZHSqfomrAxCAY78k1HoJSXW1dS7j8jqBaG+UQXcKaMFtViQg+bPhbK9WMSCrYNax7
 lmCkJzxY+tRyWFVLK5cw1K6GEN6Y/uCOai6PvR4C48o+QsX74DhvlSijNCHNuqVS8ypb
 sHJyb+6ll/b1iv/hn9tv0G6i5rb4C2NveBrdKcWwpbP5x2npKXxW4o2DB2mkhPGAC3wt
 YaMQ==
X-Gm-Message-State: AOJu0YzsHK6SCZYPQSXF/nDgU8MHj2ygdGNT2+W/HX63y+12AvH7Hgx3
 5Id2S/8Rm8LldXL10qrf4bXEDtKZmAQJM8ni+jiBcgZZHRFnaYjeL6pQAeS3/yK4kIzWv6g+0at
 n
X-Gm-Gg: ASbGncui/ClNjJlR1keS6sJFx+1IoLK6U/ifZpCX3xG2LdudVWGH2J5NTWKxEXZnIhU
 te9BsI4hfLi1FFbXAQMqZFnErVWr/XLnBAY4zU8iFrKfJmg+6Fz2xsv844W6LCQS6QIPFnFO1mK
 en57nLx8XYSAcSoUaLdlBxz5NS9SAU2NH/gdsPOW47fWcHlgDZWNt5JoaBZ9x21ADwqw2TncOih
 GrOYYhsvmCyqDfqvVeumJbg/+UddKQ9bjQtFpT5GHW225QgY7JDj+kkOPR3jMtwJJ09VtRMAYIz
 rv3eUD/GA872kuDCWR23EIU9u8lohHvBr0XPxqOSTX1aYlfWPZR/4LBQ82XuOs7B99/GTB/zwX8
 hT1RuCkFp0KjN9MDIv9Jg
X-Google-Smtp-Source: AGHT+IHHoEMdE9fsofO98GV+L04/+tSEzxG9XNZ+9y5vjxgGsCY6KW4O2Y/8GTqXJpQJ1QhCA9yP1Q==
X-Received: by 2002:a05:6000:1ace:b0:39d:8153:fde5 with SMTP id
 ffacd0b85a97d-3a06cf5f447mr1483441f8f.24.1745488062263; 
 Thu, 24 Apr 2025 02:47:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54f157sm1538517f8f.98.2025.04.24.02.47.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/13] physmem: Move TCG IOMMU methods around
Date: Thu, 24 Apr 2025 11:46:50 +0200
Message-ID: <20250424094653.35932-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The next commit will restrict TCG specific code in physmem.c
using some #ifdef'ry. In order to keep it simple, move
iotlb_to_section() and memory_region_section_get_iotlb()
around close together.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 637f2d85324..ccbeae241c4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -746,6 +746,31 @@ translate_fail:
     return &d->map.sections[PHYS_SECTION_UNASSIGNED];
 }
 
+MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+                                      hwaddr index, MemTxAttrs attrs)
+{
+    int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
+    AddressSpaceDispatch *d = cpuas->memory_dispatch;
+    int section_index = index & ~TARGET_PAGE_MASK;
+    MemoryRegionSection *ret;
+
+    assert(section_index < d->map.sections_nb);
+    ret = d->map.sections + section_index;
+    assert(ret->mr);
+    assert(ret->mr->ops);
+
+    return ret;
+}
+
+/* Called from RCU critical section */
+hwaddr memory_region_section_get_iotlb(CPUState *cpu,
+                                       MemoryRegionSection *section)
+{
+    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
+    return section - d->map.sections;
+}
+
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
@@ -1002,14 +1027,6 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
     return false;
 }
 
-/* Called from RCU critical section */
-hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section)
-{
-    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
-    return section - d->map.sections;
-}
-
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
                             uint16_t section);
 static subpage_t *subpage_init(FlatView *fv, hwaddr base);
@@ -2669,23 +2686,6 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
     return phys_section_add(map, &section);
 }
 
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                      hwaddr index, MemTxAttrs attrs)
-{
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = cpuas->memory_dispatch;
-    int section_index = index & ~TARGET_PAGE_MASK;
-    MemoryRegionSection *ret;
-
-    assert(section_index < d->map.sections_nb);
-    ret = d->map.sections + section_index;
-    assert(ret->mr);
-    assert(ret->mr->ops);
-
-    return ret;
-}
-
 static void io_mem_init(void)
 {
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
-- 
2.47.1


