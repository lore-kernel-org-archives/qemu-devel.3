Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2963BE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQhg-0000cS-9w; Wed, 24 Dec 2025 10:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhL-0000YJ-HO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:48 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQhJ-0004df-Os
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:47 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7ce5d6627dso989503866b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589764; x=1767194564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcMU1k1986zvYwyLzb//gpQrHqBilxoxS5xhcinB0TY=;
 b=k55vt2XDeRqYITPgypshf3YMbk613tnsyXR9nYo+Fc33WSbO8vhOpmv3BVysEVdsNZ
 w6s/JGSUuhHESUK7+5qu9UEROZGJLdNHavMaAdN+DI+wMFakKcXqlsdorelrPLwlIazA
 T9H7k6mQXDCAHylFFxXWt3jfilugTgp9Udqob/ByKl/l3DVpr2ypGbnE/2aoVfuhbZdA
 B2T/HekHnhO95sDQTBbjMF5hWbieTFkoXwuUp7D8TbY0OXw37L4JwEY9HPVghbbolTRO
 DJdbACJzA+9FxOoBAsOuCZBtSPoPfTzqzzZ/ZZFqhLsmFSVl7JrUj/67WmxxVPbgAS5G
 AIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589764; x=1767194564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XcMU1k1986zvYwyLzb//gpQrHqBilxoxS5xhcinB0TY=;
 b=u+3Xp4tIKBT+IwU49KxIy2BVsMRr9Jh7O3zE3cDJjp5PRjWS+12hfZi2JYZLky+Plv
 Ya+F782oRhQ0EPY2OiXHx4VrXkcBSA4jfx2toJpx7uoknqdKhzIpRld8sRYzPlHlKARu
 zJiy/lEwmyfmZZ1d9p0ylmZ4vhwLBfCpOy1WGe7TvNKS+BMQnMTwUuJ5H5ESEgtM0mic
 YtT93wEL+Sr7aei9QBkUW2rkTdMJZHw/UG7saIMK2vIk24NJJdKp9HzGtuwtYVsfqrUF
 y88xFydG+GcxFHV4myUlynzoZ/U6fhEpr9TyeVKY+nPuT3SuW8ZqkNxOYD7U2qB9DhS1
 iS2g==
X-Gm-Message-State: AOJu0Yx1kwqGhYyXsO7ssaRa4VTczQpM0OsZ/VYG7YdjoMNNudlFN15C
 N6i0QyHenbrIPD7iK+n66e7ibXKILXVT3nktgfU2+dTxLb/9ORCn0qek8M90mkVHWPIMY+XIFHi
 Eb+XF3+Y=
X-Gm-Gg: AY/fxX4gpohm2aMaCicZMzhVs+/2JBsHKYX6pvPMUGw4jssDczDa4xa67S8VCUzzXwH
 Yn67qAmN/rUpkNYvoNyZQJOJCkHAXRBc6CPW9+e4DmaRwZ+u56anMadZxIu9Pnwpn1XqsORA6v5
 hoeySaeak8UnB8sqGof7k1sq+t32TSPEwx3UN6L8pqzV+0H+w8TFezLZnj8Kvpfu1gy5ONmNMJx
 o6mQ3XbU+ErskcZhWvwYHMBpn/si7TJl2ReR03YQ2gimkb+ZH0vGZ1KUS95yv0z5ms5kC/pwr/G
 1Zj5KGDuHIgyTDwx+/beErgPOGoOHX9VbUy0A0jlfX/6qRYDKz45cgc0og4qzFrofLnEIA3Bi8V
 IS74HfwZXLNc291kMMVuRNS+AjCU1zt6ILoJV7mNUxgs1IA1hwt8Y5YhP1rQhFvlYFBp/aSGZu2
 tfV9eWmVEehj3JnHN5JXI2UdMTPnm5STHzuSbkJlOcKka0S0/eUPUpjY4PblMU
X-Google-Smtp-Source: AGHT+IEL04d7txa4q5psfVeI/jrTBCpAWOC+L3OQVUr1hZmEWoQZgGO/6/E4O/0INF10Ehs5Zs4FSw==
X-Received: by 2002:a17:906:9fc7:b0:b6d:9bab:a7ba with SMTP id
 a640c23a62f3a-b8037178753mr1880391866b.42.1766589763799; 
 Wed, 24 Dec 2025 07:22:43 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a61595sm1822652266b.8.2025.12.24.07.22.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:22:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 03/25] system/physmem: Use explicit endianness in
 subpage_ops::read/write()
Date: Wed, 24 Dec 2025 16:21:46 +0100
Message-ID: <20251224152210.87880-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Replace the ldn_p/stn_p() calls by their explicit endianness
variants. Duplicate the MemoryRegionOps, replacing the single
DEVICE_NATIVE_ENDIAN entry by a pair of LITTLE and BIG ones.
Select the proper MemoryRegionOps in subpage_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 76 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 7e914ecf648..9fe84679cac 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2894,8 +2894,8 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs);
 
-static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
-                                unsigned len, MemTxAttrs attrs)
+static MemTxResult subpage_read_le(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned len, MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
     uint8_t buf[8];
@@ -2906,18 +2906,49 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     if (res) {
         return res;
     }
-    *data = ldn_p(buf, len);
+    *data = ldn_le_p(buf, len);
     return MEMTX_OK;
 }
 
-static MemTxResult subpage_write(void *opaque, hwaddr addr,
-                                 uint64_t value, unsigned len, MemTxAttrs attrs)
+static MemTxResult subpage_read_be(void *opaque, hwaddr addr, uint64_t *data,
+                                   unsigned len, MemTxAttrs attrs)
+{
+    subpage_t *subpage = opaque;
+    uint8_t buf[8];
+    MemTxResult res;
+
+    trace_subpage_read(subpage, len, addr);
+    res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
+    if (res) {
+        return res;
+    }
+    *data = ldn_be_p(buf, len);
+    return MEMTX_OK;
+}
+
+static MemTxResult subpage_write_le(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned len,
+                                    MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
     uint8_t buf[8];
 
     trace_subpage_write(subpage, len, addr, value);
-    stn_p(buf, len, value);
+    stn_le_p(buf, len, value);
+
+    return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
+}
+
+static MemTxResult subpage_write_be(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned len,
+                                    MemTxAttrs attrs)
+{
+    subpage_t *subpage = opaque;
+    uint8_t buf[8];
+
+    trace_subpage_write(subpage, len, addr, value);
+    stn_be_p(buf, len, value);
+
     return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
 }
 
@@ -2933,15 +2964,26 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
                                  len, is_write, attrs);
 }
 
-static const MemoryRegionOps subpage_ops = {
-    .read_with_attrs = subpage_read,
-    .write_with_attrs = subpage_write,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 8,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 8,
-    .valid.accepts = subpage_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+static const MemoryRegionOps subpage_ops[2] = {
+    [0 ... 1] = {
+        .impl = {
+            .min_access_size = 1,
+            .max_access_size = 8,
+        },
+        .valid = {
+            .min_access_size = 1,
+            .max_access_size = 8,
+            .accepts = subpage_accepts,
+        },
+    },
+
+    [0].endianness = DEVICE_LITTLE_ENDIAN,
+    [0].read_with_attrs = subpage_read_le,
+    [0].write_with_attrs = subpage_write_le,
+
+    [1].endianness = DEVICE_BIG_ENDIAN,
+    [1].read_with_attrs = subpage_read_be,
+    [1].write_with_attrs = subpage_write_be,
 };
 
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
@@ -2969,8 +3011,8 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
     mmio = g_malloc0(sizeof(subpage_t) + TARGET_PAGE_SIZE * sizeof(uint16_t));
     mmio->fv = fv;
     mmio->base = base;
-    memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
-                          NULL, TARGET_PAGE_SIZE);
+    memory_region_init_io(&mmio->iomem, NULL, &subpage_ops[target_big_endian()],
+                          mmio, NULL, TARGET_PAGE_SIZE);
     mmio->iomem.subpage = true;
     trace_subpage_init(mmio, base, TARGET_PAGE_SIZE);
 
-- 
2.52.0


