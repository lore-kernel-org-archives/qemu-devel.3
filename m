Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0CBC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u838D-0000LA-FO; Thu, 24 Apr 2025 16:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8386-0008V0-Gx
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8384-00052C-Cs
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so13304675e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526302; x=1746131102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZaZUiVtvhip+YjUPzbukhiUty3aZRnPrZlaJVYneow=;
 b=l+AdB8HclIJLhxMv4eS5VDnF3VoSN689AljGoi6MUnHhtG5kaNcHX0UdCBK3HjPoqv
 EGIATutv6sJNSy5sH6Wl7zSTsF0E91eu5hkXf/RRQCOYbJWA71v0c3hCyqZE//dAbRAc
 HunPzEzQK6THvyZeWRatVcXwApRr6m0gdaQ1t63ldgj9o0bVjLfVaQQqYxKJqeQt+gaT
 CXaycBWQVyhAZpDLnYBIYLmQm+mbeJ5QCcSbce/ZIH7kxcI2GmIv9cdpCQzJpxCI2+CV
 lYvNYaMxy+Y6RH12oR+6qose6rnLkH3ZOfyua6MhrqdkyO/XWP3gX80gZS5BfLLlwlOA
 iZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526302; x=1746131102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZaZUiVtvhip+YjUPzbukhiUty3aZRnPrZlaJVYneow=;
 b=UKhVG4ktq7lRMRGHjSJGVXa8z648Hf3BXPWW2TlCa4q7lgtGejbr9gOXeKNWAfwsWy
 1Kkq7hjXfHay8ypOGiEu+o3BTv5oPxBMkHVBIG/IzGFDSHzJtIwzAoFNbblQs29z2M0N
 KrrTljMlTafPXI8K4FgJT0hMdR4hN9e/UdwqRPkORmXjB6f8CWAcA6jrcGbT1H2P0bGn
 xNaBLAudpNE/GD4S3NGn34OIf4HxJVRyrJhUMX2XalqdGrONP+5DDs4P+IhqPkBlZtlD
 ZY/gqmgR0DmHvadtlRxZFIIBA3wfygi3zUL7PhWPNFVxacOoQqq+bX8ZpWpcBY2ecfHa
 bDrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfzkNSmZ2c1SNyLSs1ro6S/8oC/TxweadfKwvYLaGJcxERD1uZtUvomc5Z/hoLDss5O5m31jexiZqA@nongnu.org
X-Gm-Message-State: AOJu0Yz9WAG4u+FRkUSfAdscaoj6/CgVGpT/S1mnMtPaDk4SgiMDf54G
 vh9RE7PJwF5OsPMADSiDPPBhtsTaPUZ2fj1uoQdVbh+LHE7dZzN/My8RaRk7BDU=
X-Gm-Gg: ASbGncucNY2sd/mKfb/zoeGEF+WMS5KU9bt6hAToOi/+gwTYSZrFg0hvHW+87DnEX1C
 OdZ02zv8AjU0t74b0Fmf3pVZYucBnVmfrp0p63pAWjJOtBDTKYHJkHE+42jG2uIBoTOfexUjcif
 Zssz8mh3Py4Z+4urZwzL7HunBsfIEz+UIwDoBgUKk8iXyIZhozPeAzJKE7vTAG4xgStYwmkh13/
 CeX2vaE9byNc80uY67fNAvWS9PFutXlvevdyEWDc2CxgbpLgNtdAaCm/J7SwCtCE8h8KubZAjDO
 At6lhCu7/gJK/EJSNdOTeVcBtBdcWGf8pXddmgrhnA23b1OgR13ZLlW8THBkSnBVtDozK42GEcY
 R/GcNhjWVc1w0Dso=
X-Google-Smtp-Source: AGHT+IGtXw0XNrjlq7CWdnIXxs1DRrxI/a7YfhBBL17hb7NGrgIn0LtM9TXpOzmNpa7pBkWIcIG25A==
X-Received: by 2002:a05:600c:510e:b0:43c:fee3:2bce with SMTP id
 5b1f17b1804b1-440a3173a9fmr5815295e9.26.1745526302531; 
 Thu, 24 Apr 2025 13:25:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f691sm622195e9.37.2025.04.24.13.25.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:25:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 10/13] physmem: Move TCG IOTLB methods around
Date: Thu, 24 Apr 2025 22:24:09 +0200
Message-ID: <20250424202412.91612-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


