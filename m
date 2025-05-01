Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CABC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLq-00012P-Ej; Thu, 01 May 2025 17:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLb-0000om-BO
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLZ-0001VV-E6
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22423adf751so16207745ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134492; x=1746739292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XmMNqwTRqPm7obbru05k0G3eZkUfqGrtagb3Klv4NE=;
 b=y/E16Q9pXXvmTwu7x3bSQI7RWuk5O+S61jdJnml606vwgU5jUuSIZxoRcw7vVBEURl
 hoNAMrCOPjtwuRg2t6VBVX5y39IzvM6sxuESzdMIvQvbIVLgju1vCRixVo/WV8L1v2br
 1TKE5Pe1+El91U2uViQ8j1Yx9DoB+asiLhuUjTCNnwQNNr2M9adEDg/fpKE6DgS6xHv4
 I7llmxtUGeN6pjcbFLo0ojkNhDcLMqJkTjtAas40GRANa1SPJ/0zdqNrNM8/JFpHAyCp
 J/ocdOhMH3ezsrTCNHCYmETbJ2HVAI5jc4m1FGww+oHHB/b/4gLLr0u3htlkX1aLHZY0
 9yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134492; x=1746739292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XmMNqwTRqPm7obbru05k0G3eZkUfqGrtagb3Klv4NE=;
 b=skkfnV5IVpPymKVVDWU/Y74BDjMgaTfzYcuBpqJBKa7/G74eelL8k/OQmb6dduhPb2
 ZFJu0vpaUQA4rsFUORauyjMFYl7B1/bwYDRWdst6rI+uBIiy/E51yv0amiOql5re7Yox
 9ASqZjObq9FIaNr/LUUTbMeeZe4V5v48NnzhXqSrXzSKpuRw8bbAe5Pcz6AUpAAWVaXf
 doFLFPQsdi67VGSCvtpC0+McWPo6Fl0DX4hkyBA5Gd8axQiVqYP7Z4L58o39CFSASmu7
 NbUlY0QyFpaENc2gIOv8/+VC3SH+mUsV7YooTCegMLkzL7QoviESlmMOCEQEZQO4KlZJ
 2Lsg==
X-Gm-Message-State: AOJu0YzeLetSj/LtybbOvm5SuN5j9hfWLy99EbXSFYhhwpuOU7ckEu35
 kPBcKa9mblL11ygM6X1f7qBcO3chYin4u1N6wWrwChCiYwIllukUN4e8uNaZ+exqBRMov73+0I0
 d
X-Gm-Gg: ASbGnctnA6kWNGFZBjMcZ405tdSGPF64GQWokK6iPo+PfJQgw/MEuDTyN0m5GOBqZxU
 QOfrebK4nz9kJPYqfd0nzy0HG/P3wBaX2WuJtKN2yKH/c8fIpg388bMUKaccDyRMUVr6ZuJetiI
 9/ZB33oiS2w8wmjyzt8iV4R8rJJfn04lWOdy77ki7imFLWCtXn3GgAsVfKiR5ANdH1aiAvukL31
 be2ZoW3f/ti8Y2vbz2Ma24I6Dv9UnRg3mFoLtbUOBQDVuPr7Q+SpF7U0R+BpW6P5glb9h+A+Q3a
 YgQJr+pghbyYBwhxiWRQiAJUJX8EhGiNL/Fr4UjlvgfOxIANWpOcOooMtn+gW/yzvi/4xdnp6m1
 Es9kinaHepQ==
X-Google-Smtp-Source: AGHT+IH0eIBKu20G2jK/riFwqZiFDTEE6ua8h70MjMGKQlEsPu2xLyK+9ZEkpyJKToxPZathwwxCLQ==
X-Received: by 2002:a17:90b:2541:b0:305:5f55:899 with SMTP id
 98e67ed59e1d1-30a4e5a579cmr972045a91.11.1746134491778; 
 Thu, 01 May 2025 14:21:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 20/59] physmem: Move TCG IOTLB methods around
Date: Thu,  1 May 2025 14:20:34 -0700
Message-ID: <20250501212113.2961531-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The next commit will restrict TCG specific code in physmem.c
using some #ifdef'ry. In order to keep it simple, move
iotlb_to_section() and memory_region_section_get_iotlb()
around close together.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-11-philmd@linaro.org>
---
 system/physmem.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 637f2d8532..ccbeae241c 100644
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
2.43.0


