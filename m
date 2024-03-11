Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BDCC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl7N-0005GQ-39; Mon, 11 Mar 2024 15:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl54-0003Pb-E7
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4t-0000Mr-5k
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso2759926f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184368; x=1710789168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D8bGr2tLFSsGuLe+R12MdDwd+oLrPAXm9STkJvPYqVM=;
 b=tvraFvxp8EQN0Mh2FPTasCiYmAPikVvR4BJOSJWyckmLXfsEtVbN1GvRU0LfOlsXXb
 Zz8GcT6pP4p9rRPUoMJ9J2RwqBNAWHUaUodnY6ZNB7neJLoS3d2l/RPmB8DMiF1pSTdI
 bq9YmGg6FTGxe4snUOBtMxNWsn7aXSV6G1F1XSdE8T/S/UTy/7DLp/f4IpGBCFiwfHAM
 tsxLoK5RVaJ947f+nSXZtWcKrLZAOTrO2k/4xHS0RcFO5njWVLOsOqN6YfgD+lpd+L58
 kT3a1vMEoMhJePC3/MmuwpnzxrKiQn7EMCpqeleiHviQjrnCu0CpkhJntrPSVBlEM+L6
 9SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184368; x=1710789168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8bGr2tLFSsGuLe+R12MdDwd+oLrPAXm9STkJvPYqVM=;
 b=xTAzBWEPjmju4XK4LqAlUFvnsB7efMeJDpBeimy5RKnOsl8RSiqNJqJJ48KrhG07CT
 3PmMLsBF2Z+L0vPdcsIeVTzr0SaRvk4j8vvbJbbOgHBL1b+z6gAKexpusrR5G91ctkoN
 JePLr5r0xXpbf7GuPJp0ByNtzt7GnhFtXjUAylF2lIZU8O03fg4qZF+xcdAZFyTcLETq
 IUhGtzPBt7JOYxbCX7pBYvGYdxMBxXnzuMRDtPS3wbOj73rzJJOjKTM299fTOJltniQF
 IVguaPD+aJYfREql0xfObVEk9xDlUmO/hwk/QwGCFOXD3cXqoZO/ElEFunWksWrCZJIn
 pHKg==
X-Gm-Message-State: AOJu0YyQCVgJnUb1sP519VRHjiciphTln7Be5FuGoWrnIb3bncYaqUNq
 OTMn7Gi75VBOgfYiiBCzdKBAcygY9QDlDTS/eSE23ukUj28+m/VXulWBOxpq3QPG1LeSzsynX/S
 I
X-Google-Smtp-Source: AGHT+IF9z+vz3gPBxT+qAGNkRA3fXz12xPpjqEu3XwP9flaJzA5mh6JhW3NJu1rv6gCf2CYIaNohSw==
X-Received: by 2002:a05:6000:22e:b0:33e:7b39:6739 with SMTP id
 l14-20020a056000022e00b0033e7b396739mr7753343wrz.0.1710184367981; 
 Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] contrib/elf2dmp: Always check for PA resolution failure
Date: Mon, 11 Mar 2024 19:12:32 +0000
Message-Id: <20240311191241.4177990-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Not checking PA resolution failure can result in NULL deference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-10-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.c | 46 +++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index c995c723ae8..e01860d15b0 100644
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
2.34.1


