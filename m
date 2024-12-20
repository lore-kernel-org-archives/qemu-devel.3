Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2745DE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkbQ-0005hY-I0; Fri, 20 Dec 2024 16:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkas-00051W-BY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkam-00075A-LD
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso16392265e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730286; x=1735335086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmgHhStl2mquI6PQjM+NbLeomfI+w1HT5yYsX9HFVBk=;
 b=weIYuoRw1weuaqbG4iyd11vmz14NKfDcaLWFaQLWnKC0g9e3co9vP5JElmvecBEHJY
 0CDrnAaV6RMblhQQo9JxbJOsxZlOis9PLVkG9UBJaB2b/eHUwm0lLNYF2RyDBF9Z1neQ
 Xp5NCZPm582MPJiDCn6OjSc8rW6ttBpg9sDmVw55hW4APGU0MbNRGU1P4saZhrgO3zKl
 TTDDG/Rgohw80XMLHHmF842oHvSeoZKZ1V4JMzZDofn1IhGLtgsuquTAHhr86OQYQn/P
 SDlhKYwAD5VtLgIOTOsyC4iwv9jJ52u+075fhRbQUOIAGWZ4KWZ6wIvQQLXcEAlAq/4/
 v6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730286; x=1735335086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmgHhStl2mquI6PQjM+NbLeomfI+w1HT5yYsX9HFVBk=;
 b=hp7vOUa1Dxbykvxcfbzo3xtY4Z7jMdKJLSSsvv+z+jVF7+adITuTzgNupKTaVL0PAH
 a+nFKkGn8yfKiqQvpBIQaJmJbNFUweOFmNcuprcD311uOCeGTj5lW1TTjpTyPlHz9GYn
 np2zUpOntX9nR3HvsAQGIQPUKsStElsHZWl/4odRvxwv6A1D2/qM7S1RLy6X/R1kWFyO
 ZNGA6VhpNTc4kOzbr0lkSz2RCGgV26es9qx91PxiXLTLtvbSsqpEKoNo8qbGJYWXVTaO
 ufdLqGKV39TddyvN69mwkPDjQZzcDLeRxAAAcVaU4EuT6113JD1z+yLrYukjAMxKG/6i
 WXVQ==
X-Gm-Message-State: AOJu0YwrKjEnk+PqjiA5+taIG63p8vIPQAZhVpjDfY185Q6tXJ5Px/TJ
 c58b9/HR6vrwd8k0HXcKYxUYwszWq7WeSjJTJZBcob8y5PeMtGZ0ZHzwg42TdBYNfwUUu1cBnRC
 Z
X-Gm-Gg: ASbGncvPZpa+KCKnmAKeK6Nww6wfF7zeZfHRnfHKiifhB6wm88Hl4dcwK9SKtG33XnO
 wVmLVLb2knE98Vy3hIcpkbVV78pKlOyULsI6HeV07oiBRLQrbI9Vrh/qlXNGy8UEjZ5Xxmmw5ch
 55ZGmL1awRylxgsSJl3WXN6iCFVvxbj1Sep8BGvsOKkjxLKxmypTqpD/YexyARQ2T+VXD9C2odf
 0hGhjnQqQ6aexYayA10fMQtdmQi1HNJTPcKAe/FAsvDl6SFiZaumBCorbjah+U0uoJQenwXVq0=
X-Google-Smtp-Source: AGHT+IFKwHq+5Sl5U3hzBhJq2R4YEuTbu0CSBPl2GbvslBniWV2AEu4KS5PgXz6RPyP/qCw8cXme8w==
X-Received: by 2002:a05:600c:1c09:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-43668643750mr50992655e9.10.1734730285805; 
 Fri, 20 Dec 2024 13:31:25 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b417afsm90555595e9.36.2024.12.20.13.31.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 4/6] hw/ppc/spapr: Convert CLEAN_HPTE() macro as
 hpte_set_clean() method
Date: Fri, 20 Dec 2024 22:31:01 +0100
Message-ID: <20241220213103.6314-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
References: <20241220213103.6314-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Convert CLEAN_HPTE() macro as hpte_set_clean() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 31df6fdc40c..e68e8c320f4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1416,7 +1416,12 @@ static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
     return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_HPTE_DIRTY;
 }
 
-#define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
+static void hpte_set_clean(SpaprMachineState *s, unsigned index)
+{
+    stq_be_p(hpte_get_ptr(s, index),
+             ldq_be_p(hpte_get_ptr(s, index)) & ~HPTE64_V_HPTE_DIRTY);
+}
+
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
 
 /*
@@ -2213,7 +2218,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume invalid HPTEs */
         while ((index < htabslots)
                && !hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
         }
 
@@ -2221,7 +2226,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
         }
 
@@ -2271,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && hpte_is_dirty(spapr, index)
                && hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
             examined++;
         }
@@ -2281,7 +2286,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
                && hpte_is_dirty(spapr, index)
                && !hpte_is_valid(spapr, index)) {
-            CLEAN_HPTE(hpte_get_ptr(spapr, index));
+            hpte_set_clean(spapr, index);
             index++;
             examined++;
         }
-- 
2.47.1


