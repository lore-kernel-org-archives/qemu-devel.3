Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C5DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJP-0004Hz-4m; Tue, 11 Mar 2025 09:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEZ-0005Vr-Qf; Tue, 11 Mar 2025 09:01:27 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEV-0000G9-Uv; Tue, 11 Mar 2025 09:01:22 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso8350772a91.1; 
 Tue, 11 Mar 2025 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698078; x=1742302878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiqaFq1CDDEcKauctJ0QrZkvhAfYnv9s43KRAQPzSbk=;
 b=jhN5LRDOEOV3/BwiWc7xG9BytRBVTP0ZlL/jGLUaSF+VH+NjQ2IGBj+MNMIYfJ1eKF
 eMfajtBXpDfTz7oKMFjQDkqw5H1pbDr51u6+A+xkQtGahxcpklq0rokdj4n4MmSFoIRc
 ch33CWZGwLkun6aT+S0EDiMedGFe6KdJRSI7woGBYFG+307+TXrm4FfU9cMAAERobeKs
 L9vZYJL0ZfAquAXSK1lng1WgApIOPCKrFoGX82G1vy5FMz2FYDjlbI0bWApQfFfouwSR
 Y4QEK5Wj8sG1C6zC19u6qhAZNX4eVDD6qtwIQnaDS/FzZm5OvvkxXzX96VtFHHJe60PW
 lHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698078; x=1742302878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiqaFq1CDDEcKauctJ0QrZkvhAfYnv9s43KRAQPzSbk=;
 b=Io7S9OMD1Mvf/Rq3JhlQQRxH9RxwbQM+StJ3GeIn10rfJ8jLR8zmST8CoSKDpV7jNG
 p8mzjxM3LbFUVteuSf3TbOICxHci46UeaxOS4RESpafzlr0GVzxre4lI/hypT1V1Ku2I
 y2YGHrkaE72SuS7zI2pZJ1XWSRNOSYBCFPRdln1u5anLyhhMSvF3mGKDuMWZrRpW7g/L
 pFIAu+vOThTJfQbxgTwMSJuOJ8E9Axtokk7fQPFdHyyH6balnnQ+taPvhqDLEyALfOSF
 qoJA7qGBaPDdC2J7A4QujqHCSnM/UN9k6dbfb6O7adXpV3rc840CY2LX8vatmHfFQEqS
 24Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXirWT0qS4NmR21+Ai/yLFBwAIpsQg/SK0rPnihKN3wJrT2xIIm9LrbCkpT/95Mkva9yugfpeJqqg==@nongnu.org
X-Gm-Message-State: AOJu0YypYlDRJ575Th20UdME2b65WtMVAyE/IVVJCy4OMnl4hyeE//YQ
 Xlev6bf8IZ7PB1RnZnGAQQr5k+WWUOAx7khgTj88ygkk2x9Lu7ME8Bhe2A==
X-Gm-Gg: ASbGncvvMQn3bwt6Il2wUdrPKYwYbjG0VVF/uCEG/8nW4yBJXjJGLV+jGWQ1pi1b3hl
 94dOsRjr5eOxqBXODsNxn32iCOAlvM2kKoBZstHGLna1twtA+tECJnWj6zGFfz7rZIeYi/U0xOg
 MAWAt/mPHizPeXUppKbSCln0MSH9mZcg7mWpKy/YdBmhhLDJWMi19H5gmc0D77CLOF3N/Om7O4j
 15AAZHH7QNwhYrXlLRaZrNffgbjspUkHE+WN1R7vyl9D6Fg0a60hBvurVS9sTbARenNfMEUb7iH
 uvP+x8TeNaOP5tGtCAOrzPDd38mF4Fe7QTYXwopnDttMlx131Ck=
X-Google-Smtp-Source: AGHT+IFZ4rCUZEjZpe1mFQo3aIobhNdwaD5QnMN0PnEvFwTHHvx+66sIohxoNQUv+G35Fntl0zu/OA==
X-Received: by 2002:a17:90b:2742:b0:2fe:a8b1:7d8 with SMTP id
 98e67ed59e1d1-300ff34d643mr4832273a91.25.1741698077824; 
 Tue, 11 Mar 2025 06:01:17 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 56/72] hw/ppc/spapr: Convert HPTE_DIRTY() macro as
 hpte_is_dirty() method
Date: Tue, 11 Mar 2025 22:57:50 +1000
Message-ID: <20250311125815.903177-57-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

Convert HPTE_DIRTY() macro as hpte_is_dirty() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20241220213103.6314-4-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index daf997cea1..dd81398445 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1414,7 +1414,11 @@ static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
     return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_VALID;
 }
 
-#define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
+static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
+{
+    return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_HPTE_DIRTY;
+}
+
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
 
@@ -2259,7 +2263,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume non-dirty HPTEs */
         while ((index < htabslots)
-               && !HPTE_DIRTY(hpte_get_ptr(spapr, index))) {
+               && !hpte_is_dirty(spapr, index)) {
             index++;
             examined++;
         }
@@ -2267,7 +2271,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_DIRTY(hpte_get_ptr(spapr, index))
+               && hpte_is_dirty(spapr, index)
                && hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
@@ -2277,7 +2281,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         invalidstart = index;
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
-               && HPTE_DIRTY(hpte_get_ptr(spapr, index))
+               && hpte_is_dirty(spapr, index)
                && !hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
-- 
2.47.1


