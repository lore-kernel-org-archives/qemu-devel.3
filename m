Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EC7C54E67
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Hw-0000cH-1h; Sat, 09 Mar 2024 14:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Hq-0000ZV-2c
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Hh-0002Wc-QH
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56840d872aeso589381a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012183; x=1710616983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q44dwAJ9zWJURYp9hh0U7wvOFqEH1mwy4JxGXOeg8jA=;
 b=nYCXrbHderVfjS+29AGgiifMHf6NUDFw/yLJ4BwXKnabQJx+9ODwdyWCaeUtGirb1/
 81w5za2WauxJilpN9XU8+i1AIq8Ce9ZWlbfkip0kbYRQsUZO6dCILPsxb0TEc5Y+Cr0Z
 bdbArpHMzIIblJtD4BVCkOo+o1YWi4q8dy+ggsA4M22hGKeaqDz5sUp9o+sJKsq3uXUq
 nv66aYylPxLfdEd4PGjcgtTADtvDWV2odV/XpCbnfGKa0l0YGnO/L6LNQzwrMrb1+iuI
 IVqqhBTr9DT1wjuzxG/hQGuSQx/7U7l4mP1h2sRUKNfbZtwbteKRqhOPPxJndurGFREx
 lnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012183; x=1710616983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q44dwAJ9zWJURYp9hh0U7wvOFqEH1mwy4JxGXOeg8jA=;
 b=WL/q8TC37mRFxpuxjXZFJXRiky+n/1SBSxJP4pDzhF8bKdNrQfLYXyhYJUrc9AKKZ0
 xDXq+1MvA0GPefbTgls7twWKQCZPSX5rCXpvm9+WJRmt0gsUwhRDcbmgfRPiQCKgyp5/
 2s849k6CI6eJFlfCLEox4L6FDnT7QIaU2LzCASxZ3J2Dkom9MGH8CUihafV/nGhHfuAr
 Zart87jJKHJTBkbMf58kcvXvpU1BO+nvmYmKDElHEXKDt/a7h7to3ve/3O8vwi0SJLgT
 cfW/UdJxmjvCeJbUnPTh2NKnqAgfTf6Ge4XputHR2ogIAbvcBhm5NNyESqyeQ5JLDPVK
 A6Rg==
X-Gm-Message-State: AOJu0Yx2tCUPHb3TD2H2DYY9qCmyQUvW1k03dhmPCBXaZ/ZbRvAnUopi
 Ro0yN5M1kuRtvgdluw5gkx2wuyxcMeXMhlzXzDKBkD+k7GMqKaC86bGbZur9/1w8EPvttyGUHo3
 B
X-Google-Smtp-Source: AGHT+IHOQkfTUB7DFZUnzFt5SN8xXU0FWBVOfPyoMZQqgOTUu5nO+XttuLhInRopNUGb3cs1S/BhDQ==
X-Received: by 2002:a17:907:7898:b0:a45:119e:3dec with SMTP id
 ku24-20020a170907789800b00a45119e3decmr1327777ejc.73.1710012183067; 
 Sat, 09 Mar 2024 11:23:03 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a1709064bd300b00a44e2f3024bsm1172780ejv.68.2024.03.09.11.23.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PULL 08/43] hw/xen: Use target-agnostic qemu_target_page_bits()
Date: Sat,  9 Mar 2024 20:21:35 +0100
Message-ID: <20240309192213.23420-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

Instead of the target-specific TARGET_PAGE_BITS definition,
use qemu_target_page_bits() which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-15-philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index dc69cada57..1627da7398 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 #include "hw/pci/pci_host.h"
@@ -14,6 +15,7 @@ MemoryRegion xen_memory;
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
     unsigned long nr_pfn;
     xen_pfn_t *pfn_list;
     int i;
@@ -32,11 +34,11 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
 
     trace_xen_ram_alloc(ram_addr, size);
 
-    nr_pfn = size >> TARGET_PAGE_BITS;
+    nr_pfn = size >> target_page_bits;
     pfn_list = g_new(xen_pfn_t, nr_pfn);
 
     for (i = 0; i < nr_pfn; i++) {
-        pfn_list[i] = (ram_addr >> TARGET_PAGE_BITS) + i;
+        pfn_list[i] = (ram_addr >> target_page_bits) + i;
     }
 
     if (xc_domain_populate_physmap_exact(xen_xc, xen_domid, nr_pfn, 0, 0, pfn_list)) {
-- 
2.41.0


