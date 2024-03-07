Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BCBC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsX-0004pj-OW; Thu, 07 Mar 2024 05:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsU-0004cl-Tb
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:30 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsT-0007Aq-76
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:30 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29b70bf6c58so472121a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806888; x=1710411688;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QP7weYtq4QbJF4sIXleLE+UckEHf7lBxF+Hq2Ng452s=;
 b=Yp+HuO8LKTESgehzaS487PIk+t6s6qt5zK//kqkt7Ri6qvjAc5Gid9YhBl67xPwfNC
 niACSxA9mut5TqFWuGhNvZeB7XyinKR3BONb923aHrij6e43r+zuhLCYJ8bYWDdnduwC
 9xeEYMaNJR4wesg+S2YM7/IT6t2a4aKKpKapt6uhrxC7NRHe0wjpj5/VCMKXwTsw/u0f
 wWYtFsGlAESM3Btcj7gh9B4vs9T/OJbRBFmTTj99zioeeHEYQIbFWH97WV36zF2wZaPg
 44oVgZ+4LOJoH0Gh8xjo37ESj7xsG5I+JyysbGDP2CjZz1q0ck1n0Z51UObHFirmdsd6
 F8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806888; x=1710411688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QP7weYtq4QbJF4sIXleLE+UckEHf7lBxF+Hq2Ng452s=;
 b=ekywgxSp4Ecg4ZuSnwjLQKzWeavjT1OFAXF74ob5VePUb2NTlWoNbuMhcxmaEsR2t5
 t0Nb7e0tVj9AZB1TwHj954e459V7wozFVNbUE4ZzvqToLzombs/FxGj4VzwdotFzWn8E
 K4u3Cdd4YyEMLo/J1AMbCkA7z5q9aMQFQptuRW3FMh+gMDyf7UoA4uCTnf2f+WHXFWul
 NiHXfCmTE7lg5oMl1EDbba2w0wtwN4rxEWYeZZw5k+z3YeOaZti+chkw/eZx1GKwq4VL
 Mlmcj4qq6frVx/5yKVSJ7zYvgot4TZOnFgO6djcws1rvNtHr5CfiCXlUYEL/PxK5i6sj
 Bx2w==
X-Gm-Message-State: AOJu0Yw1t6AEypfXsYYKUB6rwy3N0ktGMasIxvWr2LBVc5ogKm49eVQ/
 YiNd4SidOPL+X07ayJ1b7Bs8Ud8mJsrZbLXFXf1v7V2wpFuK9vOmeTmDNEI3Ufk=
X-Google-Smtp-Source: AGHT+IFbRyi2XeKtdwhnEB8vkbu9dmQMmGE7wE+OuDwZGbpK0VU6TFBybTPUFiK2THAId3fI4cqeyw==
X-Received: by 2002:a17:90b:3ccf:b0:299:3ebf:d180 with SMTP id
 qd15-20020a17090b3ccf00b002993ebfd180mr15706246pjb.6.1709806887843; 
 Thu, 07 Mar 2024 02:21:27 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 8-20020a17090a0cc800b0029b5f69830dsm1334553pjt.22.2024.03.07.02.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:53 +0900
Subject: [PATCH v4 10/19] contrib/elf2dmp: Always check for PA resolution
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-10-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Not checking PA resolution failure can result in NULL deference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index c995c723ae80..e01860d15b07 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -22,7 +22,7 @@ static struct pa_block *pa_space_find_block(struct pa_space *ps, uint64_t pa)
     return NULL;
 }
 
-static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
+static void *pa_space_resolve(struct pa_space *ps, uint64_t pa)
 {
     struct pa_block *block = pa_space_find_block(ps, pa);
 
@@ -33,6 +33,19 @@ static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
     return block->addr + (pa - block->paddr);
 }
 
+static bool pa_space_read64(struct pa_space *ps, uint64_t pa, uint64_t *value)
+{
+    uint64_t *resolved = pa_space_resolve(ps, pa);
+
+    if (!resolved) {
+        return false;
+    }
+
+    *value = *resolved;
+
+    return true;
+}
+
 static void pa_block_align(struct pa_block *b)
 {
     uint64_t low_align = ((b->paddr - 1) | ELF2DMP_PAGE_MASK) + 1 - b->paddr;
@@ -106,19 +119,20 @@ void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb)
     va_space_set_dtb(vs, dtb);
 }
 
-static uint64_t get_pml4e(struct va_space *vs, uint64_t va)
+static bool get_pml4e(struct va_space *vs, uint64_t va, uint64_t *value)
 {
     uint64_t pa = (vs->dtb & 0xffffffffff000) | ((va & 0xff8000000000) >> 36);
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pa);
+    return pa_space_read64(vs->ps, pa, value);
 }
 
-static uint64_t get_pdpi(struct va_space *vs, uint64_t va, uint64_t pml4e)
+static bool get_pdpi(struct va_space *vs, uint64_t va, uint64_t pml4e,
+                    uint64_t *value)
 {
     uint64_t pdpte_paddr = (pml4e & 0xffffffffff000) |
         ((va & 0x7FC0000000) >> 27);
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pdpte_paddr);
+    return pa_space_read64(vs->ps, pdpte_paddr, value);
 }
 
 static uint64_t pde_index(uint64_t va)
@@ -131,11 +145,12 @@ static uint64_t pdba_base(uint64_t pdpe)
     return pdpe & 0xFFFFFFFFFF000;
 }
 
-static uint64_t get_pgd(struct va_space *vs, uint64_t va, uint64_t pdpe)
+static bool get_pgd(struct va_space *vs, uint64_t va, uint64_t pdpe,
+                   uint64_t *value)
 {
     uint64_t pgd_entry = pdba_base(pdpe) + pde_index(va) * 8;
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pgd_entry);
+    return pa_space_read64(vs->ps, pgd_entry, value);
 }
 
 static uint64_t pte_index(uint64_t va)
@@ -148,11 +163,12 @@ static uint64_t ptba_base(uint64_t pde)
     return pde & 0xFFFFFFFFFF000;
 }
 
-static uint64_t get_pte(struct va_space *vs, uint64_t va, uint64_t pgd)
+static bool get_pte(struct va_space *vs, uint64_t va, uint64_t pgd,
+                   uint64_t *value)
 {
     uint64_t pgd_val = ptba_base(pgd) + pte_index(va) * 8;
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pgd_val);
+    return pa_space_read64(vs->ps, pgd_val, value);
 }
 
 static uint64_t get_paddr(uint64_t va, uint64_t pte)
@@ -184,13 +200,11 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
 {
     uint64_t pml4e, pdpe, pgd, pte;
 
-    pml4e = get_pml4e(vs, va);
-    if (!is_present(pml4e)) {
+    if (!get_pml4e(vs, va, &pml4e) || !is_present(pml4e)) {
         return INVALID_PA;
     }
 
-    pdpe = get_pdpi(vs, va, pml4e);
-    if (!is_present(pdpe)) {
+    if (!get_pdpi(vs, va, pml4e, &pdpe) || !is_present(pdpe)) {
         return INVALID_PA;
     }
 
@@ -198,8 +212,7 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return get_1GB_paddr(va, pdpe);
     }
 
-    pgd = get_pgd(vs, va, pdpe);
-    if (!is_present(pgd)) {
+    if (!get_pgd(vs, va, pdpe, &pgd) || !is_present(pgd)) {
         return INVALID_PA;
     }
 
@@ -207,8 +220,7 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return get_2MB_paddr(va, pgd);
     }
 
-    pte = get_pte(vs, va, pgd);
-    if (!is_present(pte)) {
+    if (!get_pte(vs, va, pgd, &pte) || !is_present(pte)) {
         return INVALID_PA;
     }
 

-- 
2.44.0


