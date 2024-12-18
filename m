Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920E2E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyfn-0000Bo-Mg; Wed, 18 Dec 2024 13:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfm-0000BH-9k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfk-0001mF-Qe
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so45282595e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546083; x=1735150883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5jlRNCwvAALfsOlYNnOtkyFgySWMX0tusYOjYmCCCw=;
 b=mz1hhEWepn1UPaXIdlP/XwfiHzK0xu2LRs34VJg8nxEog9JIckjBNHk+suenW+DEvU
 0hqBjG5/rhwQZ7K9ucw4c0j4/sW+YVdrZzDX2JkrKM5tem+8zFvB6oUiQdIUFtOi4Vt7
 WOVZpSzvt5YZLx/tWauD/w9AvWDPULqEKU7TfWO588EMAz2wXaKwgsQg/UKoFzv42S6f
 x7roVjvBpPkGWix5vpcxkRkDnYz7KeIMBfpMBnfsiZqDrMM+mLf2IaPsoRfqTviG/I1K
 t8fqHnpbbeeOnvNwZc5W4XWAUhwjFF+BJ03kFU0xh1+4Ai0vKRYSNd/s/aZzL7/nIeuG
 YlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546083; x=1735150883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5jlRNCwvAALfsOlYNnOtkyFgySWMX0tusYOjYmCCCw=;
 b=LgQhm9LYOkM5Lq1QH10/z2p5Tt3xWYfNhzViDqZQbeaBQ/3E6rnSaGfAS+FuGfLoIy
 OAT9ujDc96ZtCWKS1+pDUklI9WYuP0um7APht8P2L38WsGdlv9UzBJUjijFjR60dQBu3
 1jWZD1QMsmJ8che33kukIUOhfFj9Lycb7iO19Mra2sL15zuacJmuU/nHA9vdm653qNBL
 g7yxoMVq22fxtiZB2lJypdr8+Bz2ja4wozaXODiAlQGNc/A7F0XIC/4zJ2nMBpavuD/w
 WmU4tCFehC8Smkn3/aSViIVQDIqWRxmYhwQXRsZgrFMPXtZ++KodOSuMO2/hv0FvyjyA
 Z1Zw==
X-Gm-Message-State: AOJu0YwXLcUyoOAsLqKAA1IRfluZyQPIBYVVuix6Fxa6PgzOdbIKGXFN
 OAMrJunf3xMRjLsUbG4ymMrO+zG/GpN74pcWkJ5sCS3ej8SS9kd086Scf7zT5Pa4f3Py5L7zERo
 T
X-Gm-Gg: ASbGncsPdo5VfRB1RES2pdTo6JoM+uoyvGHBJZmPTxRxUQsUEbXR9NkJLjXdyjBEzp/
 56v5tI/itz5WWXyaNXNf1t7PBAPshQGWVh800KwnSbBB4fGiLANAQynoJ6jfpxR8OgXm+XbcWFq
 uc7kVD5P3hpOgm/+sVXS/ZDFnbdu2na7bud6R+0tkU8uvTyg2DnHuv4r4rll/E615CsxBtYociL
 aQRnhP/xRGWFKMgf3RL62DqNXs5McO+s9u8TdYy2bdPnVdWIYX13YNjqsVHWl8Mr06DX6XOgd/r
 nVpv
X-Google-Smtp-Source: AGHT+IGvYhbxFQ4IVWBKqV530skCMjTTdodD+ByKJR3BtlBvTFN4oBGb7Q99ju7/LpK7NPCK84RKZg==
X-Received: by 2002:a5d:584a:0:b0:385:f062:c2d4 with SMTP id
 ffacd0b85a97d-38a19b34bfbmr656937f8f.37.1734546083045; 
 Wed, 18 Dec 2024 10:21:23 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c806086dsm14570843f8f.91.2024.12.18.10.21.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:22 -0800 (PST)
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
Subject: [PATCH v3 3/7] hw/ppc/spapr: Convert HPTE_VALID() macro as
 hpte_is_valid() method
Date: Wed, 18 Dec 2024 19:21:02 +0100
Message-ID: <20241218182106.78800-4-philmd@linaro.org>
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

Convert HPTE_VALID() macro as hpte_is_valid() method.
Since sPAPR is in big endian configuration at reset,
use the big endian LD/ST API to access the hash PTEs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4845bf3244b..b67ab1ee685 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1406,7 +1406,11 @@ static uint64_t *hpte_get(SpaprMachineState *s, unsigned index)
     return &table[2 * index];
 }
 
-#define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
+static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
+{
+    return ldq_be_p(hpte_get(s, index)) & HPTE64_V_VALID;
+}
+
 #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
@@ -2204,7 +2208,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume invalid HPTEs */
         while ((index < htabslots)
-               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
+               && !hpte_is_valid(spapr->htab, index)) {
             CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
         }
@@ -2212,7 +2216,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume valid HPTEs */
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_VALID(hpte_get(spapr->htab, index))) {
+               && hpte_is_valid(spapr->htab, index)) {
             CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
         }
@@ -2262,7 +2266,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && HPTE_DIRTY(hpte_get(spapr->htab, index))
-               && HPTE_VALID(hpte_get(spapr->htab, index))) {
+               && hpte_is_valid(spapr->htab, index)) {
             CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
             examined++;
@@ -2272,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
                && HPTE_DIRTY(hpte_get(spapr->htab, index))
-               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
+               && !hpte_is_valid(spapr->htab, index)) {
             CLEAN_HPTE(hpte_get(spapr->htab, index));
             index++;
             examined++;
-- 
2.45.2


