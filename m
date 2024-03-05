Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F91C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMm-0006fV-Kc; Tue, 05 Mar 2024 02:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMO-0006IK-Ms
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:18 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMM-0005uR-Qs
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:12 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6381df003so528840b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624228; x=1710229028;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R4GuE8qVzY179iy5jy7tbAhb1WE9AtUQ419atok2jy0=;
 b=Nk4NbaNPcAOAe7rA88LJqBsAfkX9kQm2XWtgHjvQ2PQebl123f2UvQea6THD8gfMLJ
 Fmo3boCfZnfigWVPWcVR9pP+NRwem5wjmOxd7Y6O/l4NW87RJlm2eyGqlfqwzkyWSL9o
 0fl7Y51yaMIVUIlEAYwrRZQFfjzhbQPlhaZemEldhuAjFBF/Hzrlcw8i7PE+p+sQThE7
 iuBIwGZw2InW1b+I1C8M86POFlRR3tsbr1+fZfsLrG23+a6oUUTpfy9m4hoR00l0MDDd
 zLSbAWl2NlVSY2LvRcBQhrz8rg6FUPB6Xn49uVo4QYRcavTl5mCljdtGx99AqYiZj1vt
 mTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624228; x=1710229028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4GuE8qVzY179iy5jy7tbAhb1WE9AtUQ419atok2jy0=;
 b=KMsLpGxLc6Zoid3ZxlSuurBoBu/e+pllFvSxjL1xkJa9EwC0dcHlcrKkNYF/1IHbVb
 hG/AjJw61C3JWQZsCvIYWwwqzxwTgqa+D6g5tr65R+n+ssHt3RXQzg16mmB3gaGhFd3Z
 uRWRfBkHomwySbiIMAGv72qrMICGLJr5hFiA5YrUUS5mzEtEKOL+lzm9UnypwXl+V3Gk
 zIj9au77SOn2zHYCpXhJmerIN3ERD3/lVyiQ1pTNYWHQpRAB2CtvOX3TtZVQ28uYm9hH
 qwWltfzFiCfkG4Us4rO00EXjlrvev1Ztx1kydOteOJD0kL1NxW2aOmCNJ2Jj9WTd3pB8
 q52g==
X-Gm-Message-State: AOJu0YxeLC2PKBUysCzjotyw/FR2yGi+TGeD68n2vSoqckryte/zttQu
 uxTmoKbu3TanSlVD7qqiOpN7EjXujne+9IriMDTE4kwA3opxRmNbfqs3Etant0qgrjV76agRpSF
 s
X-Google-Smtp-Source: AGHT+IHbZtnMGuxi2w9npBKJM6n8ElnOz1TfvXN9fBOyE+/hbK1klK3+dDESGEEzQEna4gcuSXeTbA==
X-Received: by 2002:a05:6a00:928a:b0:6e6:2176:fd5 with SMTP id
 jw10-20020a056a00928a00b006e621760fd5mr6834926pfb.28.1709624228689; 
 Mon, 04 Mar 2024 23:37:08 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 p20-20020a62ab14000000b006e47e57d976sm8316257pff.166.2024.03.04.23.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:37:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:30 +0900
Subject: [PATCH v2 13/13] contrib/elf2dmp: Clamp QEMU note to file size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-13-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

This fixes crashes with truncated dumps.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2202
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/qemu_elf.c | 87 +++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 7d896cac5b15..8d750adf904a 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "err.h"
 #include "qemu_elf.h"
 
@@ -15,36 +16,11 @@
 #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
 #endif
 
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#endif
-
-#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
-    ((DIV_ROUND_UP((hdr_size), 4) +                     \
-      DIV_ROUND_UP((name_size), 4) +                    \
-      DIV_ROUND_UP((desc_size), 4)) * 4)
-
 int is_system(QEMUCPUState *s)
 {
     return s->gs.base >> 63;
 }
 
-static char *nhdr_get_name(Elf64_Nhdr *nhdr)
-{
-    return (char *)nhdr + ROUND_UP(sizeof(*nhdr), 4);
-}
-
-static void *nhdr_get_desc(Elf64_Nhdr *nhdr)
-{
-    return nhdr_get_name(nhdr) + ROUND_UP(nhdr->n_namesz, 4);
-}
-
-static Elf64_Nhdr *nhdr_get_next(Elf64_Nhdr *nhdr)
-{
-    return (void *)((uint8_t *)nhdr + ELF_NOTE_SIZE(sizeof(*nhdr),
-                nhdr->n_namesz, nhdr->n_descsz));
-}
-
 Elf64_Phdr *elf64_getphdr(void *map)
 {
     Elf64_Ehdr *ehdr = map;
@@ -60,13 +36,35 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
+static bool advance_note_offset(uint64_t *offsetp, uint64_t size, uint64_t end)
+{
+    uint64_t offset = *offsetp;
+
+    if (uadd64_overflow(offset, size, &offset) || offset > UINT64_MAX - 3) {
+        return false;
+    }
+
+    offset = ROUND_UP(offset, 4);
+
+    if (offset > end) {
+        return false;
+    }
+
+    *offsetp = offset;
+
+    return true;
+}
+
 static bool init_states(QEMU_Elf *qe)
 {
     Elf64_Phdr *phdr = elf64_getphdr(qe->map);
-    Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
-    Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
     GPtrArray *states;
+    QEMUCPUState *state;
+    uint32_t state_size;
+    uint64_t offset;
+    uint64_t end_offset;
+    char *name;
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
@@ -74,15 +72,40 @@ static bool init_states(QEMU_Elf *qe)
     }
 
     qe->has_kernel_gs_base = 1;
+    offset = phdr[0].p_offset;
     states = g_ptr_array_new();
 
-    for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
-        if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
-            QEMUCPUState *state = nhdr_get_desc(nhdr);
+    if (uadd64_overflow(offset, phdr[0].p_memsz, &end_offset) ||
+        end_offset > qe->size) {
+        end_offset = qe->size;
+    }
+
+    while (offset < end_offset) {
+        nhdr = (void *)((uint8_t *)qe->map + offset);
+
+        if (!advance_note_offset(&offset, sizeof(*nhdr), end_offset)) {
+            break;
+        }
+
+        name = (char *)qe->map + offset;
+
+        if (!advance_note_offset(&offset, nhdr->n_namesz, end_offset)) {
+            break;
+        }
+
+        state = (void *)((uint8_t *)qe->map + offset);
+
+        if (!advance_note_offset(&offset, nhdr->n_descsz, end_offset)) {
+            break;
+        }
+
+        if (!strcmp(name, QEMU_NOTE_NAME) &&
+            nhdr->n_descsz >= offsetof(QEMUCPUState, kernel_gs_base)) {
+            state_size = MIN(state->size, nhdr->n_descsz);
 
-            if (state->size < sizeof(*state)) {
+            if (state_size < sizeof(*state)) {
                 eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
-                        states->len, state->size);
+                        states->len, state_size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.

-- 
2.44.0


