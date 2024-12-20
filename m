Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768B4E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkaa-0004aI-0v; Fri, 20 Dec 2024 16:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkaX-0004V1-SO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkaW-00073X-8l
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436202dd730so17238375e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730270; x=1735335070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkSthXKkX+HHwTs+cSajLM5Uw0R3OgK0kOG1f54cJh4=;
 b=ivXAGaDk5D3Q3oX97BIDhDRAJKlxXj/VRF6XXQG/sKMowY0bckx/xDkT+uFf0ia7le
 8NOMRwpS5fPL5wXHD72QtGoXjtOZTeMAYtxLzdG+Fqgj2XYQKcpNuS4euZvoaX5PQUWD
 Xc7wpXIUZPwAt54/6brht4xWU+LhRzOr5POaZutBJtf4IEPbs+nGaF4fNTYvq8bv7r9t
 belTpmaat1rU4oywY21IlEMckzVDwNob+zDnhuWkRvEbWHprp+Cet+4xlpFcK4dboCdw
 efE6eDs9g/685Dd/olWTK0rpzHdUHieVvIaduRhn90LQDSScsEp/OABMffhRq/sAV03q
 ADQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730270; x=1735335070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkSthXKkX+HHwTs+cSajLM5Uw0R3OgK0kOG1f54cJh4=;
 b=nJE9BpuS8VF60k5tjaU8MRRDPkzf5Njngb56sHFCV0pSxuCyP4rJ8SrGQhqCPkHXN7
 CTS28mtdFD4mezdc+6Y+N8sj3qDaaJCcfwrsU5XRsYDwqLB5vo2nGpb4q61PGzqLjLtM
 EdA+yaolhK4PEdcR8te1kC7nqOqrsakap5L1P9/8Qjzhw82GQTB9DaIiSvB8FTe5IIMx
 A2ebr1YmaPpGXrt/0hmN/rhaI4XoaNtPK3mhHVO6lGJtXtVV8Aov4eFUYNlriIMKoVav
 78ZT+Ic1MYBDK+kSYFOabNKV5V8erVOosIdP20CsATnjQ1UB2yqtn8Y7uqOcMIfyvNXD
 yGtw==
X-Gm-Message-State: AOJu0YwXT1n2RPog7priGfsZQUFqAGmbtd4BHFX1e1yB1mnRksPjKVgG
 slFd3+cCcMR9+5qquNeNS0LHg0delC0JJYdil8G0yRrVN2AHNYERCBIO5uhfxk1WMu8L13QXF+z
 2
X-Gm-Gg: ASbGnct7D/J+cJnS+IiMn97NW4BXwqGm+kKIqx7/mjMgeLchKY+kJnVimFbZ55gsJni
 F7mMNITZYUX2DuA2rT2hIhERWL3ZuXgs4buwlclnrVvivcyRNjgzVLUQKqCqNu/gnRZBGHzqEtu
 T68bba2gj9YdSeeKrENGYL1BLFEC4Zk2GtC/VSKqXb7lZ9SrIHcs5A80nXK23Jd5mLb+sYlSAWT
 cWjx9Tr+6mwOn9ITPaY7V6GTq5xZTzTIOc7V8Y8R95ix4mFN58AavpAUPqDj49GfJMcgadJHg0=
X-Google-Smtp-Source: AGHT+IF46ZQ5LvDcAz5bMC3DiTZhBzoWk5EBQOgWKBMOnzB33OYLDCCr8vojqn4mA3VHjg5qR6oJ/Q==
X-Received: by 2002:a05:600c:45cf:b0:434:fbd5:2f0a with SMTP id
 5b1f17b1804b1-43668642e7bmr43838545e9.9.1734730270562; 
 Fri, 20 Dec 2024 13:31:10 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4432dsm88922455e9.41.2024.12.20.13.31.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/6] hw/ppc/spapr: Convert HPTE() macro as hpte_get_ptr()
 method
Date: Fri, 20 Dec 2024 22:30:58 +0100
Message-ID: <20241220213103.6314-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
References: <20241220213103.6314-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert HPTE() macro as hpte_get_ptr() method.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3b022e8da9e..bed60afbe22 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1399,7 +1399,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
     }
 }
 
-#define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
+static uint64_t *hpte_get_ptr(SpaprMachineState *s, unsigned index)
+{
+    uint64_t *table = s->htab;
+
+    return &table[2 * index];
+}
+
 #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
 #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
@@ -1614,7 +1620,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
         spapr->htab_shift = shift;
 
         for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
-            DIRTY_HPTE(HPTE(spapr->htab, i));
+            DIRTY_HPTE(hpte_get_ptr(spapr, i));
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
@@ -2172,7 +2178,7 @@ static void htab_save_chunk(QEMUFile *f, SpaprMachineState *spapr,
     qemu_put_be32(f, chunkstart);
     qemu_put_be16(f, n_valid);
     qemu_put_be16(f, n_invalid);
-    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
+    qemu_put_buffer(f, (void *)hpte_get_ptr(spapr, chunkstart),
                     HASH_PTE_SIZE_64 * n_valid);
 }
 
@@ -2198,16 +2204,16 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume invalid HPTEs */
         while ((index < htabslots)
-               && !HPTE_VALID(HPTE(spapr->htab, index))) {
-            CLEAN_HPTE(HPTE(spapr->htab, index));
+               && !HPTE_VALID(hpte_get_ptr(spapr, index))) {
+            CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
         }
 
         /* Consume valid HPTEs */
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_VALID(HPTE(spapr->htab, index))) {
-            CLEAN_HPTE(HPTE(spapr->htab, index));
+               && HPTE_VALID(hpte_get_ptr(spapr, index))) {
+            CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
         }
 
@@ -2247,7 +2253,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume non-dirty HPTEs */
         while ((index < htabslots)
-               && !HPTE_DIRTY(HPTE(spapr->htab, index))) {
+               && !HPTE_DIRTY(hpte_get_ptr(spapr, index))) {
             index++;
             examined++;
         }
@@ -2255,9 +2261,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_DIRTY(HPTE(spapr->htab, index))
-               && HPTE_VALID(HPTE(spapr->htab, index))) {
-            CLEAN_HPTE(HPTE(spapr->htab, index));
+               && HPTE_DIRTY(hpte_get_ptr(spapr, index))
+               && HPTE_VALID(hpte_get_ptr(spapr, index))) {
+            CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
             examined++;
         }
@@ -2265,9 +2271,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         invalidstart = index;
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
-               && HPTE_DIRTY(HPTE(spapr->htab, index))
-               && !HPTE_VALID(HPTE(spapr->htab, index))) {
-            CLEAN_HPTE(HPTE(spapr->htab, index));
+               && HPTE_DIRTY(hpte_get_ptr(spapr, index))
+               && !HPTE_VALID(hpte_get_ptr(spapr, index))) {
+            CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
             examined++;
         }
@@ -2449,11 +2455,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
         if (spapr->htab) {
             if (n_valid) {
-                qemu_get_buffer(f, HPTE(spapr->htab, index),
+                qemu_get_buffer(f, (void *)hpte_get_ptr(spapr, index),
                                 HASH_PTE_SIZE_64 * n_valid);
             }
             if (n_invalid) {
-                memset(HPTE(spapr->htab, index + n_valid), 0,
+                memset(hpte_get_ptr(spapr, index + n_valid), 0,
                        HASH_PTE_SIZE_64 * n_invalid);
             }
         } else {
-- 
2.47.1


