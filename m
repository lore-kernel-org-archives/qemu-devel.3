Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84328C54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2IP-0001HW-E5; Sat, 09 Mar 2024 14:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IE-0000xE-9N
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:39 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IB-0002cP-NP
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:38 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4417fa396fso195413266b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012214; x=1710617014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GjJ9Xc35+gwGwrFshf70kAsb/Zk8w4JUpjKATwEq64Y=;
 b=L5R6+j2a/IN8VA7V2/BT3iQfI3WeCRPgY0MP5GD1MRLbYjYztLxujw0k0VuElZqDUV
 T8MLjoK54m+R8Mq2zUvvnL86hpdd/IITBUAv7A66mZAlo466nKLV6QmZRR91OIgAHtls
 jnK3aT8sZSEwiIRJGTzrX7TFKN9eEnrqDHmSBrTk5ywRG1S2+GRbPQI6G4BXruiLDc6c
 6PHJE0IH8R71vQu7P6IqtYPCVKPk0vZo64wjUDzsu1TvVwtMyJRJLWvg0nOD880Oz6fG
 HdBwysaFcZXSvR5oiTUVFc+DzDDKkCUZB5/aOHUhQzfAEvHY9RVYnUUHqp6blsqaoA7v
 ztbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012214; x=1710617014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjJ9Xc35+gwGwrFshf70kAsb/Zk8w4JUpjKATwEq64Y=;
 b=qtLluTCf5nMYGWuqLgZboupgW5IP8aS1ALM5Ldwwt6n4YMFVGgDF0a4CmV5wj3H9SE
 FV1IDNlgmguPcIzPCDuwPoHCPI27YQ6CVFfYs3CWfsxGnomSM5j+FoQdpvr8c6ALuZqF
 nePhWf7LExcumW5VJqbIpTZCjRnPS9KHmmNzwLJd/4JHsQgUSkktsUKgolMC3H3rSf0J
 fGXukHVOJohv78J80k2wgpT6JRFJknNv4B6jJ3atMhp/Gsu+pUFgEbM/6V+ABMCw+tn2
 +jWaWA271esZTJ5e4vewMX1wU6NpXmHByLSZC/IRXtGC1O1WAbYAouAMn/tZVh4lrhaS
 KUjg==
X-Gm-Message-State: AOJu0Yz8vbVQQA0ixlQcfBTa39tFNKuIH4iWffMTCbi8xe+I9mA6JyvA
 MCM7beLvWhuP2PDyj5T4x1JEprVcm1BwDWHSgF6VM2JFT2e9sQb50U1gDX5UUM9dhE1bkwOwv3P
 u
X-Google-Smtp-Source: AGHT+IFUzNU4pC8ZaO+fIzpjlcMgyQZHUIXDLCwBTxfANDlJj9gCS9ZbhsgrrNnhXeKdaH05pNglXQ==
X-Received: by 2002:a17:907:d389:b0:a45:92c4:7892 with SMTP id
 vh9-20020a170907d38900b00a4592c47892mr1630790ejc.56.1710012214113; 
 Sat, 09 Mar 2024 11:23:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906a41400b00a46163be639sm251749ejz.12.2024.03.09.11.23.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org
Subject: [PULL 13/43] hw/xen/hvm: Propagate page_mask to a pair of functions
Date: Sat,  9 Mar 2024 20:21:40 +0100
Message-ID: <20240309192213.23420-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We are going to replace TARGET_PAGE_MASK by a
runtime variable. In order to reduce code duplication,
propagate TARGET_PAGE_MASK to get_physmapping() and
xen_phys_offset_to_gaddr().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231114163123.74888-3-philmd@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 8235782ef7..844b11ae08 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -174,11 +174,12 @@ static void xen_ram_init(PCMachineState *pcms,
     }
 }
 
-static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
+static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
+                                   int page_mask)
 {
     XenPhysmap *physmap = NULL;
 
-    start_addr &= TARGET_PAGE_MASK;
+    start_addr &= page_mask;
 
     QLIST_FOREACH(physmap, &xen_physmap, list) {
         if (range_covers_byte(physmap->start_addr, physmap->size, start_addr)) {
@@ -188,9 +189,10 @@ static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
     return NULL;
 }
 
-static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size)
+static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
+                                       int page_mask)
 {
-    hwaddr addr = phys_offset & TARGET_PAGE_MASK;
+    hwaddr addr = phys_offset & page_mask;
     XenPhysmap *physmap = NULL;
 
     QLIST_FOREACH(physmap, &xen_physmap, list) {
@@ -252,7 +254,7 @@ static int xen_add_to_physmap(XenIOState *state,
     hwaddr phys_offset = memory_region_get_ram_addr(mr);
     const char *mr_name;
 
-    if (get_physmapping(start_addr, size)) {
+    if (get_physmapping(start_addr, size, TARGET_PAGE_MASK)) {
         return 0;
     }
     if (size <= 0) {
@@ -325,7 +327,7 @@ static int xen_remove_from_physmap(XenIOState *state,
     XenPhysmap *physmap = NULL;
     hwaddr phys_offset = 0;
 
-    physmap = get_physmapping(start_addr, size);
+    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
     if (physmap == NULL) {
         return -1;
     }
@@ -373,7 +375,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
     int rc, i, j;
     const XenPhysmap *physmap = NULL;
 
-    physmap = get_physmapping(start_addr, size);
+    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
     if (physmap == NULL) {
         /* not handled */
         return;
@@ -633,7 +635,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
         int rc;
         ram_addr_t start_pfn, nb_pages;
 
-        start = xen_phys_offset_to_gaddr(start, length);
+        start = xen_phys_offset_to_gaddr(start, length, TARGET_PAGE_MASK);
 
         if (length == 0) {
             length = TARGET_PAGE_SIZE;
-- 
2.41.0


