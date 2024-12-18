Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CD6E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyfk-0000Aw-CP; Wed, 18 Dec 2024 13:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfi-0000AQ-9Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfg-0001lW-CO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f796586so75055425e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546078; x=1735150878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQzhvPTiN3ivier5WU2Y9S2wBlcJwBk1Bj+vHdELx1w=;
 b=pCZ52Q0XA4V4Zhs2dMpJETiMJZDmnulUfl5FOdn7+7yp6JPG8ci3Z6o2O5AKPYpSFE
 SjyT990rWaAqpB+NWCjOZualCeMp0Or37Gd3g4uXMurkMBwAq1Q3r0lxBwmpRXGwr8CV
 JLALKRB7rReh0IO+aTc/jEfd4OqN7b76MnHUV4jRWS9BfTwmbUDwG395PiJjxzwy1KvY
 /HullH9rniHli/fGJPogkW/N9ZgCHvkAwogz7B53BnQZgRTOQudt7gaTfgXuAxkmykxn
 OYmOOTBBlW7NbycikHfxws+8rxPRbksoIV2WKSmCgmLoWLWzs97IUb8WhUUIGh9qcZel
 NqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546078; x=1735150878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQzhvPTiN3ivier5WU2Y9S2wBlcJwBk1Bj+vHdELx1w=;
 b=ffAgubOz30fUpEbcSdatEJYJPUT2h3QANq6SqcoV4M47d5WZ6HHGFTVTtH8UBnakTs
 s7fuKFcTHS64/IHPSiAZu2dSp1HLixJpy7Kem7YGbWZKmfHYoxvmurkAsI5WZ/cXs9uM
 nNL8OpMB8fKgPlLzEF8lcCisbi7QclxMGFbsRECwDchVzeFjsJHdFEhCCg7EeuYF6e0k
 zGSd8Zq8B5py/AklWYyGNCFHxPoP0Mx3AlotZCTWx0fAiRxf2jh7ovZfkkKPUVRIj6Et
 IKarlzCJuFeftq88Wax1URFvGGSrrWGzEsiQH1BJ/b29HaSNrNId5ul9oc2jsAlg6iHG
 xF5g==
X-Gm-Message-State: AOJu0Yyk0JTKSzf8uxj0EP0CyrR115o+cZUmzuZAjXWT3syU/IHp64K8
 vC9RoHyz+xVg9r9aGly9El53u5ut3SLS2I7Q7pzJwrV4AudKt+gs7uEICSQ+KZNT/zXO8T7H4dL
 N
X-Gm-Gg: ASbGnctCYqemzcYKUMasa/n8mnRgvxOEKWnv2755iGSZydQbxgMjna58RERJpdiqHTi
 CvTky3UNKCq0BlqKypOgxCv8vSTta2s4c/cQY+viWGXa8JILMcLX5x+ZhOs7/4WtdztinVtfuhs
 2wP33zMSCYz4btACCZVsO09hRgEW3RklLX1RVuhBSa98zA0Dts/4OZaFp1ZZS83z9+lB5qahmte
 X3SAxtZNW+izKrgSRGlYItdAkB4a6O+RDo6RggXutcFplYlw3zucZ5X0PDUs9XKKid2kbVaGLnG
 sUeN
X-Google-Smtp-Source: AGHT+IHO7kuM9U5L/s/IgxGV4vT2MKyYSreP82VK+LFrdQL8+aKfmwocL5nJmp0m/eZ8h3mA7GAQSA==
X-Received: by 2002:a05:600c:1c21:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-4365c780d16mr3163225e9.8.1734546078401; 
 Wed, 18 Dec 2024 10:21:18 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4365d116d8fsm1106755e9.17.2024.12.18.10.21.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/7] hw/ppc/spapr: Convert HPTE() macro as hpte_get() method
Date: Wed, 18 Dec 2024 19:21:01 +0100
Message-ID: <20241218182106.78800-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218182106.78800-1-philmd@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Convert HPTE() macro as hpte_get() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3b022e8da9e..4845bf3244b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1399,7 +1399,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
     }
 }
 
-#define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
+static uint64_t *hpte_get(SpaprMachineState *s, unsigned index)
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
+            DIRTY_HPTE(hpte_get(spapr->htab, i));
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
@@ -2172,7 +2178,7 @@ static void htab_save_chunk(QEMUFile *f, SpaprMachineState *spapr,
     qemu_put_be32(f, chunkstart);
     qemu_put_be16(f, n_valid);
     qemu_put_be16(f, n_invalid);
-    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
+    qemu_put_buffer(f, (void *)hpte_get(spapr->htab, chunkstart),
                     HASH_PTE_SIZE_64 * n_valid);
 }
 
@@ -2198,16 +2204,16 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume invalid HPTEs */
         while ((index < htabslots)
-               && !HPTE_VALID(HPTE(spapr->htab, index))) {
-            CLEAN_HPTE(HPTE(spapr->htab, index));
+               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
+            CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
         }
 
         /* Consume valid HPTEs */
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_VALID(HPTE(spapr->htab, index))) {
-            CLEAN_HPTE(HPTE(spapr->htab, index));
+               && HPTE_VALID(hpte_get(spapr->htab, index))) {
+            CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
         }
 
@@ -2247,7 +2253,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume non-dirty HPTEs */
         while ((index < htabslots)
-               && !HPTE_DIRTY(HPTE(spapr->htab, index))) {
+               && !HPTE_DIRTY(hpte_get(spapr->htab, index))) {
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
+               && HPTE_DIRTY(hpte_get(spapr->htab, index))
+               && HPTE_VALID(hpte_get(spapr->htab, index))) {
+            CLEAN_HPTE(hpte_get(spapr->htab, index));
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
+               && HPTE_DIRTY(hpte_get(spapr->htab, index))
+               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
+            CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
             examined++;
         }
@@ -2449,11 +2455,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
         if (spapr->htab) {
             if (n_valid) {
-                qemu_get_buffer(f, HPTE(spapr->htab, index),
+                qemu_get_buffer(f, (void *)hpte_get(spapr->htab, index),
                                 HASH_PTE_SIZE_64 * n_valid);
             }
             if (n_invalid) {
-                memset(HPTE(spapr->htab, index + n_valid), 0,
+                memset(hpte_get(spapr->htab, index + n_valid), 0,
                        HASH_PTE_SIZE_64 * n_invalid);
             }
         } else {
-- 
2.45.2


