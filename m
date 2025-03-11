Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A47C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIX-0002FP-OI; Tue, 11 Mar 2025 09:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzET-0005Uv-19; Tue, 11 Mar 2025 09:01:24 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEP-0000F2-Mi; Tue, 11 Mar 2025 09:01:16 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso7929377a91.3; 
 Tue, 11 Mar 2025 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698071; x=1742302871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6q6Au2PYMTFLE8G5QWMGA2jsF0I3uVxpvs/IiCO/uk=;
 b=lXeppP1+vghLkG/pDv/OlwJbFFgAs7rIO6pNb+/q7jZcBPCxs2bM9jGUlyspT9g/OM
 Epsll3+5lS3F6HpJxyx3SJm/QqpCOvX104Xo8AR3YiCKTtm9lHepZsWG2C9350PyB/Vy
 3bMtxmKUdeEFA2WM1XXMeg9FxQpt0+C02OtnOpG0BqHUe35wJjZxYx09VIUulAtRgYdk
 T2wi5lye2W012gjKonfy+MWTt2LMZaqz5HVws3AgibX15DD39XxFO3I/6tfGk+xBb20s
 tLV+CyAjnhA0kIkUUHfqnPKOLtAaxujDsKtJAwIPpB3zmJmlf3dm9Mo5r5X22ypS8xei
 rv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698071; x=1742302871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6q6Au2PYMTFLE8G5QWMGA2jsF0I3uVxpvs/IiCO/uk=;
 b=SS66HIl1CwTUCdZB9GI//u9unMC03YHFgBhqReQ1EemaYzwZenbVwcwrpXLxr5fRw2
 muWoLpitvQuj+8RjQp0Msdw+LtUsR3s7Zxc8o29t9Jzso9S4/kIziO1h7yjAdyxSUYdj
 68R1k1c5KGK1MoEsfrlfBIbSSaWIds9SuvIgVNiIEsX+99P8E7fKq81HLCo8rB0HXT23
 autd5+CsuoyX7IhvLqk8nup4T7ALr0pnJqcahMKPEM5JtW8DZv5uar1VW3r4uaTkgAOY
 uBCbMD/Q+yclr1dx69b+tkYH1whGYRvukO3AwiQB4gk65owXOJySaK9DOG19Nz76mcLj
 HlHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/hVnYp84r2CARbXen1QdLpzqKjBn4lo/FUxPKLgsJEyHIVY6MPR/TljPFyK12sE239NPznyF8A==@nongnu.org
X-Gm-Message-State: AOJu0YwNnn/AOa+EaSN1VsGq8Yl2K22yJ/a1twneThsORlM0lTEdcRfs
 11ZQM7ZvG9yzbfQENUNcc91RvpwFsQmqUKmz1jqhLe+ez+0zeq7c0sPHgw==
X-Gm-Gg: ASbGncuVMFy+xjNULygJtMgnUhSpJ1hFc7Ir86GLcvaM4Ga+xHwZGFFHkUtzNb/8cZI
 kvoGQITIOCEOu984niZIVvTwT0kcej+o/sukXI5k+6QawwhtDBPXRhClqFIOQ12HeKHz3kAFmjK
 20s6hOVzNsXsip8VqUwDCs421MAlmAeBktONYhnMr+zjpd8GMlcnNk1e6XUEEzQPoZx7JFyxP6S
 iRIQNQAdCWaDiSQ+dt+J3BPwieszPeOWMIa343bUeDEL80Sknb/8vAQNUxiODHS1jibh1CWHldi
 sKLu23ftjnSQkgxBwEwyC71Xf+0IV75/iA1FrIzuSLXP4J5KPME=
X-Google-Smtp-Source: AGHT+IFHxsySwNaiuFmOaF0flXJIqS8ZmcbDMIyGEaCgNHxjC15RdQwaFlxhKTL6OL5W4I5lt7gdgw==
X-Received: by 2002:a17:90a:e7ce:b0:2ff:58a4:9db3 with SMTP id
 98e67ed59e1d1-2ff7cf25652mr26488690a91.35.1741698071504; 
 Tue, 11 Mar 2025 06:01:11 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 54/72] hw/ppc/spapr: Convert HPTE() macro as hpte_get_ptr()
 method
Date: Tue, 11 Mar 2025 22:57:48 +1000
Message-ID: <20250311125815.903177-55-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Convert HPTE() macro as hpte_get_ptr() method.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20241220213103.6314-2-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c7cf04e063..0cae4853db 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1402,7 +1402,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
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
@@ -1617,7 +1623,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
         spapr->htab_shift = shift;
 
         for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
-            DIRTY_HPTE(HPTE(spapr->htab, i));
+            DIRTY_HPTE(hpte_get_ptr(spapr, i));
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
@@ -2174,7 +2180,7 @@ static void htab_save_chunk(QEMUFile *f, SpaprMachineState *spapr,
     qemu_put_be32(f, chunkstart);
     qemu_put_be16(f, n_valid);
     qemu_put_be16(f, n_invalid);
-    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
+    qemu_put_buffer(f, (void *)hpte_get_ptr(spapr, chunkstart),
                     HASH_PTE_SIZE_64 * n_valid);
 }
 
@@ -2200,16 +2206,16 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
 
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
 
@@ -2249,7 +2255,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume non-dirty HPTEs */
         while ((index < htabslots)
-               && !HPTE_DIRTY(HPTE(spapr->htab, index))) {
+               && !HPTE_DIRTY(hpte_get_ptr(spapr, index))) {
             index++;
             examined++;
         }
@@ -2257,9 +2263,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
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
@@ -2267,9 +2273,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
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
@@ -2451,11 +2457,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
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


